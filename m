Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750985AbeFAELV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 00:11:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750715AbeFAELR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 00:11:17 -0400
Date: Fri, 1 Jun 2018 00:11:15 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.de>,
        Laurence Oberman <loberman@redhat.com>, Ewan Milne <emilne@redhat.com>,
        James Smart <james.smart@broadcom.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Martin George <marting@netapp.com>,
        John Meneghini <John.Meneghini@netapp.com>
Subject: Re: [PATCH 0/3] Provide more fine grained control over multipathing
Message-ID: <20180601041115.GA14244@redhat.com>
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525130535.GA24239@lst.de>
 <20180525135813.GB9591@redhat.com>
 <db1aa53f-1152-c003-ccc1-3e439ca6916d@grimberg.me>
 <20180530220206.GA7037@redhat.com>
 <f084e3bc-77af-4268-c882-7b0737e45f3b@grimberg.me>
 <20180531123738.GA10552@redhat.com>
 <20180531163440.GB30954@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531163440.GB30954@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31 2018 at 12:34pm -0400,
Christoph Hellwig <hch@lst.de> wrote:

> On Thu, May 31, 2018 at 08:37:39AM -0400, Mike Snitzer wrote:
> > I saw your reply to the 1/3 patch.. I do agree it is broken for not
> > checking if any handles are active.  But that is easily fixed no?
> 
> Doing a switch at runtime simply is a really bad idea.  If for some
> reason we end up with a good per-controller switch it would have
> to be something set at probe time, and to get it on a controller
> you'd need to reset it first.

Yes, I see that now.  And the implementation would need to be something
yourself or other more seasoned NVMe developers pursued.  NVMe code is
pretty unforgiving.

I took a crack at aspects of this, my head hurts.  While testing I hit
some "interesting" lack of self-awareness about NVMe resources that are
in use.  So lots of associations are able to be torn down rather than
graceful failure.  Could be nvme_fcloop specific, but it is pretty easy
to do the following using mptest's lib/unittests/nvme_4port_create.sh
followed by: modprobe -r nvme_fcloop

Results in an infinite spew of:
[14245.345759] nvme_fcloop: fcloop_exit: Failed deleting remote port
[14245.351851] nvme_fcloop: fcloop_exit: Failed deleting target port
[14245.357944] nvme_fcloop: fcloop_exit: Failed deleting remote port
[14245.364038] nvme_fcloop: fcloop_exit: Failed deleting target port

Another fun one is to lib/unittests/nvme_4port_delete.sh while the
native NVMe multipath device (created from nvme_4port_create.sh) was
still in use by an xfs mount, so:
./nvme_4port_create.sh
mount /dev/nvme1n1 /mnt
./nvme_4port_delete.sh
umount /mnt

Those were clear screwups on my part but I wouldn't have expected them
to cause nvme to blow through so many stop signs.

Anyway, I put enough time to trying to make the previously thought
"simple" mpath_personality switch safe -- in the face of active handles
(issue Sagi pointed out) -- that it is clear NVMe just doesn't have
enough state to do it in a clean way.  Would require a deeper
understanding of the code that I don't have.  Most every NVMe function
returns void so there is basically no potential for error handling (in
the face of a resource being in use).

The following is my WIP patch (built ontop of the 3 patches from
this thread's series) that has cured me of wanting to continue pursuit
of a robust implementation of the runtime 'mpath_personality' switch:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1e018d0..80103b3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2146,10 +2146,8 @@ static ssize_t __nvme_subsys_store_mpath_personality(struct nvme_subsystem *subs
 		goto out;
 	}
 
-	if (subsys->native_mpath != native_mpath) {
-		subsys->native_mpath = native_mpath;
-		ret = nvme_mpath_change_personality(subsys);
-	}
+	if (subsys->native_mpath != native_mpath)
+		ret = nvme_mpath_change_personality(subsys, native_mpath);
 out:
 	return ret ? ret : count;
 }
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 53d2610..017c924 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -247,26 +247,57 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 	put_disk(head->disk);
 }
 
-int nvme_mpath_change_personality(struct nvme_subsystem *subsys)
+static bool __nvme_subsys_in_use(struct nvme_subsystem *subsys)
 {
 	struct nvme_ctrl *ctrl;
-	int ret = 0;
+	struct nvme_ns *ns, *next;
 
-restart:
-	mutex_lock(&subsys->lock);
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
-		if (!list_empty(&ctrl->namespaces)) {
-			mutex_unlock(&subsys->lock);
-			nvme_remove_namespaces(ctrl);
-			goto restart;
+		down_write(&ctrl->namespaces_rwsem);
+		list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
+			if ((kref_read(&ns->kref) > 1) ||
+			    // FIXME: need to compare with N paths
+			    (ns->head && (kref_read(&ns->head->ref) > 1))) {
+				printk("ns->kref = %d", kref_read(&ns->kref));
+				printk("ns->head->ref = %d", kref_read(&ns->head->ref));
+				up_write(&ctrl->namespaces_rwsem);
+				mutex_unlock(&subsys->lock);
+				return true;
+			}
 		}
+		up_write(&ctrl->namespaces_rwsem);
 	}
-	mutex_unlock(&subsys->lock);
+
+	return false;
+}
+
+int nvme_mpath_change_personality(struct nvme_subsystem *subsys, bool native)
+{
+	struct nvme_ctrl *ctrl;
 
 	mutex_lock(&subsys->lock);
-	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
-		nvme_queue_scan(ctrl);
+
+	if (__nvme_subsys_in_use(subsys)) {
+		mutex_unlock(&subsys->lock);
+		return -EBUSY;
+	}
+
+	// FIXME: racey, subsys could now be in use here.
+	// Interlock against use needs work from an NVMe developer (hch?) :)
+
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+		cancel_work_sync(&ctrl->reset_work);
+		flush_work(&ctrl->reset_work);
+		nvme_stop_ctrl(ctrl);
+	}
+
+	subsys->native_mpath = native;
 	mutex_unlock(&subsys->lock);
 
-	return ret;
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+		nvme_remove_namespaces(ctrl);
+		nvme_start_ctrl(ctrl);
+	}
+
+	return 0;
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 81e4e71..97a6b08 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -452,7 +452,7 @@ void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
 void nvme_mpath_add_disk(struct nvme_ns_head *head);
 void nvme_mpath_remove_disk(struct nvme_ns_head *head);
-int nvme_mpath_change_personality(struct nvme_subsystem *subsys);
+int nvme_mpath_change_personality(struct nvme_subsystem *subsys, bool native);
 
 static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
 {

Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsQn2lXayEhinnR6MGoiUHIE6hCXQAYGW2DYgNeraPGVSsjJwUZcwMc7+fJ2d9z0OCu+y86
ARC-Seal: i=1; a=rsa-sha256; t=1520955001; cv=none;
        d=google.com; s=arc-20160816;
        b=vIGfJRoiQdSKqYzldfYtRUqSp5nYC8JIKrFaC24nTJvNUsdj+xB0JmoIKnAp6EUev6
         MPnFWsZpCjWh5xpHj0r+iO0z5m7DeBzkkdEvi7rb9/lPfY47HgjE3VKEzX3X8/1q2tPA
         CNq4PCw8jcMaML9tZz3pfr3vqo47XRBGRhZYVG064Au3wXpwxpNNOtxwxy5rJdplNuf+
         joYX+0MnNrkMZdkNd+fHBrThpCx/j5JRohRNeT2oLLrW27rqmOTd59cVQNAn2cSHYqIh
         836RsaIdByBIWddthQOnGm63LZbnzLFd1giK4XqT79752ybZcvzmGMnYGPlUDAqkKgwd
         jl6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vUhRA8dIadr6QCKmvnTMxUTsfIUhcWfhTz5h3M+yqLE=;
        b=AWYfSSqZKhZ/Z7NhDouwIVTO39m9I8rIKyU8QAjlXKdWGZVp7rCjQo9tmDHtEjumBI
         tpWjy8trQJr8eJDRQdUCk9MLCozr3WcBF+G0sdx7OxnkqciZ2fegID42kDURA4p6dzxD
         iOjvtx0GrFbm9IbEpX/XR7snxRIPst8Tcg4J+r5uA0zTFmczLu4RWEolYa6Rheu8af/R
         6lAYTm0tDwzdDk9tHQFN7NkM9NHTl+k4o7NIhuXHUC9fcX6hhBraG2c/I6Mcu12WTMZ1
         xT1lLzsvl2Q2y9T0UNV6QjvBbfyMR9i81X8DVAAEZ5NJEvzX/bnMo7OaFHy9QdJSU3DM
         D5Vg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCH 4.15 056/146] Revert "nvme: create slaves and holders entries for hidden controllers"
Date: Tue, 13 Mar 2018 16:23:43 +0100
Message-Id: <20180313152324.991971050@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836912263466557?=
X-GMAIL-MSGID: =?utf-8?q?1594836912263466557?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

commit 8a30ecc6e0ecbb9ae95daf499b2680b885ed0349 upstream.

This reverts commit e9a48034d7d1318ece7d4a235838a86c94db9d68.

The slaves and holders link for the hidden gendisks confuse lsblk so that
it errors out on, or doesn't report the nvme multipath devices.  Given
that we don't need holder relationships for something that can't even be
directly accessed we should just stop creating those links.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Potnuri Bharat Teja <bharat@chelsio.com>
Cc: stable@vger.kernel.org
Signed-off-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvme/host/core.c      |    2 --
 drivers/nvme/host/multipath.c |   30 ------------------------------
 drivers/nvme/host/nvme.h      |    8 --------
 3 files changed, 40 deletions(-)

--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2950,7 +2950,6 @@ static void nvme_alloc_ns(struct nvme_ct
 
 	if (new)
 		nvme_mpath_add_disk(ns->head);
-	nvme_mpath_add_disk_links(ns);
 	return;
  out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);
@@ -2970,7 +2969,6 @@ static void nvme_ns_remove(struct nvme_n
 		return;
 
 	if (ns->disk && ns->disk->flags & GENHD_FL_UP) {
-		nvme_mpath_remove_disk_links(ns);
 		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
 					&nvme_ns_id_attr_group);
 		if (ns->ndev)
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -245,25 +245,6 @@ void nvme_mpath_add_disk(struct nvme_ns_
 			head->disk->disk_name);
 }
 
-void nvme_mpath_add_disk_links(struct nvme_ns *ns)
-{
-	struct kobject *slave_disk_kobj, *holder_disk_kobj;
-
-	if (!ns->head->disk)
-		return;
-
-	slave_disk_kobj = &disk_to_dev(ns->disk)->kobj;
-	if (sysfs_create_link(ns->head->disk->slave_dir, slave_disk_kobj,
-			kobject_name(slave_disk_kobj)))
-		return;
-
-	holder_disk_kobj = &disk_to_dev(ns->head->disk)->kobj;
-	if (sysfs_create_link(ns->disk->part0.holder_dir, holder_disk_kobj,
-			kobject_name(holder_disk_kobj)))
-		sysfs_remove_link(ns->head->disk->slave_dir,
-			kobject_name(slave_disk_kobj));
-}
-
 void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
 	if (!head->disk)
@@ -278,14 +259,3 @@ void nvme_mpath_remove_disk(struct nvme_
 	blk_cleanup_queue(head->disk->queue);
 	put_disk(head->disk);
 }
-
-void nvme_mpath_remove_disk_links(struct nvme_ns *ns)
-{
-	if (!ns->head->disk)
-		return;
-
-	sysfs_remove_link(ns->disk->part0.holder_dir,
-			kobject_name(&disk_to_dev(ns->head->disk)->kobj));
-	sysfs_remove_link(ns->head->disk->slave_dir,
-			kobject_name(&disk_to_dev(ns->disk)->kobj));
-}
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -405,9 +405,7 @@ bool nvme_req_needs_failover(struct requ
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
 void nvme_mpath_add_disk(struct nvme_ns_head *head);
-void nvme_mpath_add_disk_links(struct nvme_ns *ns);
 void nvme_mpath_remove_disk(struct nvme_ns_head *head);
-void nvme_mpath_remove_disk_links(struct nvme_ns *ns);
 
 static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
 {
@@ -448,12 +446,6 @@ static inline void nvme_mpath_add_disk(s
 static inline void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
 }
-static inline void nvme_mpath_add_disk_links(struct nvme_ns *ns)
-{
-}
-static inline void nvme_mpath_remove_disk_links(struct nvme_ns *ns)
-{
-}
 static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
 {
 }

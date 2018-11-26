Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAF1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 02:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53BF220868
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 02:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53BF220868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbeKZNXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 08:23:39 -0500
Received: from a2nlsmtp01-05.prod.iad2.secureserver.net ([198.71.225.49]:39362
        "EHLO a2nlsmtp01-05.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726079AbeKZNXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 08:23:38 -0500
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id R6etgtjGcse9VR6etgqy2G; Sun, 25 Nov 2018 19:29:59 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1gR6et-0002xN-Fo; Sun, 25 Nov 2018 19:29:59 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     Dexuan Cui <decui@microsoft.com>, stable@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 2/2] Drivers: hv: vmbus: offload the handling of channels to two workqueues
Date:   Mon, 26 Nov 2018 02:29:57 +0000
Message-Id: <20181126022958.11320-2-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181126022958.11320-1-kys@linuxonhyperv.com>
References: <20181126022821.11269-1-kys@linuxonhyperv.com>
 <20181126022958.11320-1-kys@linuxonhyperv.com>
MIME-Version: 1.0
Reply-To: kys@microsoft.com
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfGqs2XCSQFE8c8auO0k+DyRS46UfKnHjKzOnPkfbsoytPd6lPv7AmzFOPeE5JCM+DQEADlntV/Wh63UfRQFlG47iKaC6X3McqYLgeO+EKsYg48MN7wMl
 p0B5jcj/UlQwbefuEgo/KRiBmACkpuLdqL1L5h7hSFam2h73ZMNrMcRLjJKKVF/S0b3iDez2SlcNWxde7VyG6LTEMVLTluijobUDwubKfFXTH02uXQGHG5We
 qh/MjJysgu0/wJLrObUESqI/mm6Na7cmBCaLQdIrXJv2NKAT2O9t45eUXJ1dMy4Glto0FK7X4syBbgPt4a6OnwT+XW8H26Y4YGGn59VVsA2H6HQhnAWpLdT+
 KTWEPrgxFAhXOw53+aqCK36hlOLXXuweJUUf3EkVao/akDOy14Ov7VaFczE+32frbJNirgKBYn6LXQIDIUCaYr9XTJfWdwg3ztSXXqRB9qve0Xk+GU4qyCk3
 qKAFBHfHRZEJR/1ZncF6ZwjakBQvusCgCXswlOS3xcttmgkg+G5EFbw0zn8f+26dlnvNymsMhI7YkrQd/Gpw5qJ1p4iN9wIG5fShiJXRHwmzxojrzsjT0tiB
 qA15nRkqJ0E78FTJ4KtWaJ7WZwPQWGN3zwvEvTL+UPYD8g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>

vmbus_process_offer() mustn't call channel->sc_creation_callback()
directly for sub-channels, because sc_creation_callback() ->
vmbus_open() may never get the host's response to the
OPEN_CHANNEL message (the host may rescind a channel at any time,
e.g. in the case of hot removing a NIC), and vmbus_onoffer_rescind()
may not wake up the vmbus_open() as it's blocked due to a non-zero
vmbus_connection.offer_in_progress, and finally we have a deadlock.

The above is also true for primary channels, if the related device
drivers use sync probing mode by default.

And, usually the handling of primary channels and sub-channels can
depend on each other, so we should offload them to different
workqueues to avoid possible deadlock, e.g. in sync-probing mode,
NIC1's netvsc_subchan_work() can race with NIC2's netvsc_probe() ->
rtnl_lock(), and causes deadlock: the former gets the rtnl_lock
and waits for all the sub-channels to appear, but the latter
can't get the rtnl_lock and this blocks the handling of sub-channels.

The patch can fix the multiple-NIC deadlock described above for
v3.x kernels (e.g. RHEL 7.x) which don't support async-probing
of devices, and v4.4, v4.9, v4.14 and v4.18 which support async-probing
but don't enable async-probing for Hyper-V drivers (yet).

The patch can also fix the hang issue in sub-channel's handling described
above for all versions of kernels, including v4.19 and v4.20-rc3.

So the patch should be applied to all the existing kernels.

Fixes: 8195b1396ec8 ("hv_netvsc: fix deadlock on hotplug")
Cc: stable@vger.kernel.org
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/channel_mgmt.c | 188 +++++++++++++++++++++++++-------------
 drivers/hv/connection.c   |  24 ++++-
 drivers/hv/hyperv_vmbus.h |   7 ++
 include/linux/hyperv.h    |   7 ++
 4 files changed, 161 insertions(+), 65 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 82e673671087..d01689079e9b 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -434,60 +434,16 @@ void vmbus_free_channels(void)
 	}
 }
 
-/*
- * vmbus_process_offer - Process the offer by creating a channel/device
- * associated with this offer
- */
-static void vmbus_process_offer(struct vmbus_channel *newchannel)
+/* Note: the function can run concurrently for primary/sub channels. */
+static void vmbus_add_channel_work(struct work_struct *work)
 {
-	struct vmbus_channel *channel;
-	bool fnew = true;
+	struct vmbus_channel *newchannel =
+		container_of(work, struct vmbus_channel, add_channel_work);
+	struct vmbus_channel *primary_channel = newchannel->primary_channel;
 	unsigned long flags;
 	u16 dev_type;
 	int ret;
 
-	/* Make sure this is a new offer */
-	mutex_lock(&vmbus_connection.channel_mutex);
-
-	/*
-	 * Now that we have acquired the channel_mutex,
-	 * we can release the potentially racing rescind thread.
-	 */
-	atomic_dec(&vmbus_connection.offer_in_progress);
-
-	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
-		if (!uuid_le_cmp(channel->offermsg.offer.if_type,
-			newchannel->offermsg.offer.if_type) &&
-			!uuid_le_cmp(channel->offermsg.offer.if_instance,
-				newchannel->offermsg.offer.if_instance)) {
-			fnew = false;
-			break;
-		}
-	}
-
-	if (fnew)
-		list_add_tail(&newchannel->listentry,
-			      &vmbus_connection.chn_list);
-
-	mutex_unlock(&vmbus_connection.channel_mutex);
-
-	if (!fnew) {
-		/*
-		 * Check to see if this is a sub-channel.
-		 */
-		if (newchannel->offermsg.offer.sub_channel_index != 0) {
-			/*
-			 * Process the sub-channel.
-			 */
-			newchannel->primary_channel = channel;
-			spin_lock_irqsave(&channel->lock, flags);
-			list_add_tail(&newchannel->sc_list, &channel->sc_list);
-			spin_unlock_irqrestore(&channel->lock, flags);
-		} else {
-			goto err_free_chan;
-		}
-	}
-
 	dev_type = hv_get_dev_type(newchannel);
 
 	init_vp_index(newchannel, dev_type);
@@ -505,27 +461,26 @@ static void vmbus_process_offer(struct vmbus_channel *newchannel)
 	/*
 	 * This state is used to indicate a successful open
 	 * so that when we do close the channel normally, we
-	 * can cleanup properly
+	 * can cleanup properly.
 	 */
 	newchannel->state = CHANNEL_OPEN_STATE;
 
-	if (!fnew) {
-		struct hv_device *dev
-			= newchannel->primary_channel->device_obj;
+	if (primary_channel != NULL) {
+		/* newchannel is a sub-channel. */
+		struct hv_device *dev = primary_channel->device_obj;
 
 		if (vmbus_add_channel_kobj(dev, newchannel))
-			goto err_free_chan;
+			goto err_deq_chan;
+
+		if (primary_channel->sc_creation_callback != NULL)
+			primary_channel->sc_creation_callback(newchannel);
 
-		if (channel->sc_creation_callback != NULL)
-			channel->sc_creation_callback(newchannel);
 		newchannel->probe_done = true;
 		return;
 	}
 
 	/*
-	 * Start the process of binding this offer to the driver
-	 * We need to set the DeviceObject field before calling
-	 * vmbus_child_dev_add()
+	 * Start the process of binding the primary channel to the driver
 	 */
 	newchannel->device_obj = vmbus_device_create(
 		&newchannel->offermsg.offer.if_type,
@@ -554,13 +509,28 @@ static void vmbus_process_offer(struct vmbus_channel *newchannel)
 
 err_deq_chan:
 	mutex_lock(&vmbus_connection.channel_mutex);
-	list_del(&newchannel->listentry);
+
+	/*
+	 * We need to set the flag, otherwise
+	 * vmbus_onoffer_rescind() can be blocked.
+	 */
+	newchannel->probe_done = true;
+
+	if (primary_channel == NULL) {
+		list_del(&newchannel->listentry);
+	} else {
+		spin_lock_irqsave(&primary_channel->lock, flags);
+		list_del(&newchannel->sc_list);
+		spin_unlock_irqrestore(&primary_channel->lock, flags);
+	}
+
 	mutex_unlock(&vmbus_connection.channel_mutex);
 
 	if (newchannel->target_cpu != get_cpu()) {
 		put_cpu();
 		smp_call_function_single(newchannel->target_cpu,
-					 percpu_channel_deq, newchannel, true);
+					 percpu_channel_deq,
+					 newchannel, true);
 	} else {
 		percpu_channel_deq(newchannel);
 		put_cpu();
@@ -568,14 +538,104 @@ static void vmbus_process_offer(struct vmbus_channel *newchannel)
 
 	vmbus_release_relid(newchannel->offermsg.child_relid);
 
-err_free_chan:
 	free_channel(newchannel);
 }
 
+/*
+ * vmbus_process_offer - Process the offer by creating a channel/device
+ * associated with this offer
+ */
+static void vmbus_process_offer(struct vmbus_channel *newchannel)
+{
+	struct vmbus_channel *channel;
+	struct workqueue_struct *wq;
+	unsigned long flags;
+	bool fnew = true;
+
+	mutex_lock(&vmbus_connection.channel_mutex);
+
+	/*
+	 * Now that we have acquired the channel_mutex,
+	 * we can release the potentially racing rescind thread.
+	 */
+	atomic_dec(&vmbus_connection.offer_in_progress);
+
+	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
+		if (!uuid_le_cmp(channel->offermsg.offer.if_type,
+				 newchannel->offermsg.offer.if_type) &&
+		    !uuid_le_cmp(channel->offermsg.offer.if_instance,
+				 newchannel->offermsg.offer.if_instance)) {
+			fnew = false;
+			break;
+		}
+	}
+
+	if (fnew)
+		list_add_tail(&newchannel->listentry,
+			      &vmbus_connection.chn_list);
+	else {
+		/*
+		 * Check to see if this is a valid sub-channel.
+		 */
+		if (newchannel->offermsg.offer.sub_channel_index == 0) {
+			mutex_unlock(&vmbus_connection.channel_mutex);
+			/*
+			 * Don't call free_channel(), because newchannel->kobj
+			 * is not initialized yet.
+			 */
+			kfree(newchannel);
+			WARN_ON_ONCE(1);
+			return;
+		}
+		/*
+		 * Process the sub-channel.
+		 */
+		newchannel->primary_channel = channel;
+		spin_lock_irqsave(&channel->lock, flags);
+		list_add_tail(&newchannel->sc_list, &channel->sc_list);
+		spin_unlock_irqrestore(&channel->lock, flags);
+	}
+
+	mutex_unlock(&vmbus_connection.channel_mutex);
+
+	/*
+	 * vmbus_process_offer() mustn't call channel->sc_creation_callback()
+	 * directly for sub-channels, because sc_creation_callback() ->
+	 * vmbus_open() may never get the host's response to the
+	 * OPEN_CHANNEL message (the host may rescind a channel at any time,
+	 * e.g. in the case of hot removing a NIC), and vmbus_onoffer_rescind()
+	 * may not wake up the vmbus_open() as it's blocked due to a non-zero
+	 * vmbus_connection.offer_in_progress, and finally we have a deadlock.
+	 *
+	 * The above is also true for primary channels, if the related device
+	 * drivers use sync probing mode by default.
+	 *
+	 * And, usually the handling of primary channels and sub-channels can
+	 * depend on each other, so we should offload them to different
+	 * workqueues to avoid possible deadlock, e.g. in sync-probing mode,
+	 * NIC1's netvsc_subchan_work() can race with NIC2's netvsc_probe() ->
+	 * rtnl_lock(), and causes deadlock: the former gets the rtnl_lock
+	 * and waits for all the sub-channels to appear, but the latter
+	 * can't get the rtnl_lock and this blocks the handling of
+	 * sub-channels.
+	 */
+	INIT_WORK(&newchannel->add_channel_work, vmbus_add_channel_work);
+	wq = fnew ? vmbus_connection.handle_primary_chan_wq :
+		    vmbus_connection.handle_sub_chan_wq;
+	queue_work(wq, &newchannel->add_channel_work);
+}
+
 /*
  * We use this state to statically distribute the channel interrupt load.
  */
 static int next_numa_node_id;
+/*
+ * init_vp_index() accesses global variables like next_numa_node_id, and
+ * it can run concurrently for primary channels and sub-channels: see
+ * vmbus_process_offer(), so we need the lock to protect the global
+ * variables.
+ */
+static DEFINE_SPINLOCK(bind_channel_to_cpu_lock);
 
 /*
  * Starting with Win8, we can statically distribute the incoming
@@ -611,6 +671,8 @@ static void init_vp_index(struct vmbus_channel *channel, u16 dev_type)
 		return;
 	}
 
+	spin_lock(&bind_channel_to_cpu_lock);
+
 	/*
 	 * Based on the channel affinity policy, we will assign the NUMA
 	 * nodes.
@@ -693,6 +755,8 @@ static void init_vp_index(struct vmbus_channel *channel, u16 dev_type)
 	channel->target_cpu = cur_cpu;
 	channel->target_vp = hv_cpu_number_to_vp_number(cur_cpu);
 
+	spin_unlock(&bind_channel_to_cpu_lock);
+
 	free_cpumask_var(available_mask);
 }
 
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index f4d08c8ac7f8..4fe117b761ce 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -190,6 +190,20 @@ int vmbus_connect(void)
 		goto cleanup;
 	}
 
+	vmbus_connection.handle_primary_chan_wq =
+		create_workqueue("hv_pri_chan");
+	if (!vmbus_connection.handle_primary_chan_wq) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	vmbus_connection.handle_sub_chan_wq =
+		create_workqueue("hv_sub_chan");
+	if (!vmbus_connection.handle_sub_chan_wq) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
 	INIT_LIST_HEAD(&vmbus_connection.chn_msg_list);
 	spin_lock_init(&vmbus_connection.channelmsg_lock);
 
@@ -280,10 +294,14 @@ void vmbus_disconnect(void)
 	 */
 	vmbus_initiate_unload(false);
 
-	if (vmbus_connection.work_queue) {
-		drain_workqueue(vmbus_connection.work_queue);
+	if (vmbus_connection.handle_sub_chan_wq)
+		destroy_workqueue(vmbus_connection.handle_sub_chan_wq);
+
+	if (vmbus_connection.handle_primary_chan_wq)
+		destroy_workqueue(vmbus_connection.handle_primary_chan_wq);
+
+	if (vmbus_connection.work_queue)
 		destroy_workqueue(vmbus_connection.work_queue);
-	}
 
 	if (vmbus_connection.int_page) {
 		free_pages((unsigned long)vmbus_connection.int_page, 0);
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index f17c06a5e74b..313a07f5efa1 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -333,7 +333,14 @@ struct vmbus_connection {
 	struct list_head chn_list;
 	struct mutex channel_mutex;
 
+	/*
+	 * An offer message is handled first on the work_queue, and then
+	 * is further handled on handle_primary_chan_wq or
+	 * handle_sub_chan_wq.
+	 */
 	struct workqueue_struct *work_queue;
+	struct workqueue_struct *handle_primary_chan_wq;
+	struct workqueue_struct *handle_sub_chan_wq;
 };
 
 
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 07a367f5e22f..f0885cc01db6 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -896,6 +896,13 @@ struct vmbus_channel {
 
 	bool probe_done;
 
+	/*
+	 * We must offload the handling of the primary/sub channels
+	 * from the single-threaded vmbus_connection.work_queue to
+	 * two different workqueue, otherwise we can block
+	 * vmbus_connection.work_queue and hang: see vmbus_process_offer().
+	 */
+	struct work_struct add_channel_work;
 };
 
 static inline bool is_hvsock_channel(const struct vmbus_channel *c)
-- 
2.19.1


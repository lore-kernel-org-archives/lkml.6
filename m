Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDB3C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5850B2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5850B2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933183AbeGIUOd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 16:14:33 -0400
Received: from labrats.qualcomm.com ([199.106.110.90]:13038 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932992AbeGIUOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 16:14:30 -0400
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Jul 2018 16:14:29 EDT
X-IronPort-AV: E=Sophos;i="5.51,330,1526367600"; 
   d="scan'208";a="21909315"
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by labrats.qualcomm.com with ESMTP; 09 Jul 2018 13:08:24 -0700
X-IronPort-AV: E=McAfee;i="5900,7806,8949"; a="231212367"
Received: from sdias-linux.qualcomm.com (HELO sdias-linux1.qualcomm.com) ([192.168.140.71])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP; 09 Jul 2018 13:08:24 -0700
Received: by sdias-linux1.qualcomm.com (Postfix, from userid 84243)
        id 0E1D0150B; Mon,  9 Jul 2018 13:08:24 -0700 (PDT)
From:   Sujeev Dias <sdias@codeaurora.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Sujeev Dias <sdias@codeaurora.org>,
        Tony Truong <truong@codeaurora.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>
Subject: [PATCH v2 5/7] mhi_bus: core: add support to get external modem time
Date:   Mon,  9 Jul 2018 13:08:12 -0700
Message-Id: <1531166894-30984-6-git-send-email-sdias@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531166894-30984-1-git-send-email-sdias@codeaurora.org>
References: <1524795811-21399-1-git-send-email-sdias@codeaurora.org>
 <1531166894-30984-1-git-send-email-sdias@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For accurate synchronizations between external modem and
host processor, mhi host will capture modem time relative
to host time. Client may use time measurements for adjusting
any drift between host and modem.

Signed-off-by: Sujeev Dias <sdias@codeaurora.org>
Reviewed-by: Tony Truong <truong@codeaurora.org>
Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
---
 Documentation/devicetree/bindings/bus/mhi.txt |   7 +
 Documentation/mhi.txt                         |  41 ++++
 drivers/bus/mhi/core/mhi_init.c               | 111 +++++++++++
 drivers/bus/mhi/core/mhi_internal.h           |  57 +++++-
 drivers/bus/mhi/core/mhi_main.c               | 263 +++++++++++++++++++++++++-
 drivers/bus/mhi/core/mhi_pm.c                 |   7 +
 include/linux/mhi.h                           |   7 +
 7 files changed, 486 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/bus/mhi.txt b/Documentation/devicetree/bindings/bus/mhi.txt
index 19deb84..1012ff2 100644
--- a/Documentation/devicetree/bindings/bus/mhi.txt
+++ b/Documentation/devicetree/bindings/bus/mhi.txt
@@ -19,6 +19,13 @@ Main node properties:
   Value type: <u32>
   Definition: Maximum timeout in ms wait for state and cmd completion
 
+- mhi,time-sync
+  Usage: optional
+  Value type: <bool>
+  Definition: Set true, if the external device support MHI get time
+	feature for time synchronization between host processor and
+	external modem.
+
 - mhi,use-bb
   Usage: optional
   Value type: <bool>
diff --git a/Documentation/mhi.txt b/Documentation/mhi.txt
index 1c501f1..9287899 100644
--- a/Documentation/mhi.txt
+++ b/Documentation/mhi.txt
@@ -137,6 +137,47 @@ Example Operation for data transfer:
 8. Host wakes up and check event ring for completion event
 9. Host update the Event[i].ctxt.WP to indicate processed of completion event.
 
+Time sync
+---------
+To synchronize two applications between host and external modem, MHI provide
+native support to get external modems free running timer value in a fast
+reliable method. MHI clients do not need to create client specific methods to
+get modem time.
+
+When client requests modem time, MHI host will automatically capture host time
+at that moment so clients are able to do accurate drift adjustment.
+
+Example:
+
+Client request time @ time T1
+
+Host Time: Tx
+Modem Time: Ty
+
+Client request time @ time T2
+Host Time: Txx
+Modem Time: Tyy
+
+Then drift is:
+Tyy - Ty + <drift> == Txx - Tx
+
+Clients are free to implement their own drift algorithms, what MHI host provide
+is a way to accurately correlate host time with external modem time.
+
+To avoid link level latencies, controller must support capabilities to disable
+any link level latency.
+
+During Time capture host will:
+	1. Capture host time
+	2. Trigger doorbell to capture modem time
+
+It's important time between Step 2 to Step 1 is deterministic as possible.
+Therefore, MHI host will:
+	1. Disable any MHI related to low power modes.
+	2. Disable preemption
+	3. Request bus master to disable any link level latencies. Controller
+	should disable all low power modes such as L0s, L1, L1ss.
+
 MHI States
 ----------
 
diff --git a/drivers/bus/mhi/core/mhi_init.c b/drivers/bus/mhi/core/mhi_init.c
index b09767a..e1e1b8c 100644
--- a/drivers/bus/mhi/core/mhi_init.c
+++ b/drivers/bus/mhi/core/mhi_init.c
@@ -362,6 +362,69 @@ int mhi_init_dev_ctxt(struct mhi_controller *mhi_cntrl)
 	return ret;
 }
 
+int mhi_init_timesync(struct mhi_controller *mhi_cntrl)
+{
+	struct mhi_timesync *mhi_tsync = mhi_cntrl->mhi_tsync;
+	u32 time_offset, db_offset;
+	int ret;
+
+	reinit_completion(&mhi_tsync->completion);
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		read_unlock_bh(&mhi_cntrl->pm_lock);
+		return -EIO;
+	}
+
+	mhi_cntrl->wake_get(mhi_cntrl, false);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+	mhi_cntrl->runtime_get(mhi_cntrl, mhi_cntrl->priv_data);
+	mhi_cntrl->runtime_put(mhi_cntrl, mhi_cntrl->priv_data);
+
+	ret = mhi_send_cmd(mhi_cntrl, NULL, MHI_CMD_TIMSYNC_CFG);
+	if (ret)
+		goto error_send_cmd;
+
+	ret = wait_for_completion_timeout(&mhi_tsync->completion,
+				msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	if (!ret || mhi_tsync->ccs != MHI_EV_CC_SUCCESS) {
+		ret = -EIO;
+		goto error_send_cmd;
+	}
+
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	mhi_cntrl->wake_put(mhi_cntrl, false);
+
+	ret = -EIO;
+
+	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state))
+		goto error_sync_cap;
+
+	ret = mhi_get_capability_offset(mhi_cntrl, TIMESYNC_CAP_ID,
+					&time_offset);
+	if (ret)
+		goto error_sync_cap;
+
+	ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs,
+			   time_offset + TIMESYNC_DB_OFFSET, &db_offset);
+	if (ret)
+		goto error_sync_cap;
+
+	mhi_tsync->db = mhi_cntrl->regs + db_offset;
+
+error_sync_cap:
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	return ret;
+
+error_send_cmd:
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	mhi_cntrl->wake_put(mhi_cntrl, false);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	return ret;
+}
+
 int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
 {
 	u32 val;
@@ -691,6 +754,9 @@ static int of_parse_ev_cfg(struct mhi_controller *mhi_cntrl,
 		case MHI_ER_CTRL_ELEMENT_TYPE:
 			mhi_event->process_event = mhi_process_ctrl_ev_ring;
 			break;
+		case MHI_ER_TSYNC_ELEMENT_TYPE:
+			mhi_event->process_event = mhi_process_tsync_event_ring;
+			break;
 		}
 
 		mhi_event->hw_ring = of_property_read_bool(child, "mhi,hw-ev");
@@ -858,6 +924,7 @@ static int of_parse_dt(struct mhi_controller *mhi_cntrl,
 		       struct device_node *of_node)
 {
 	int ret;
+	struct mhi_timesync *mhi_tsync;
 
 	/* parse MHI channel configuration */
 	ret = of_parse_ch_cfg(mhi_cntrl, of_node);
@@ -874,6 +941,28 @@ static int of_parse_dt(struct mhi_controller *mhi_cntrl,
 	if (ret)
 		mhi_cntrl->timeout_ms = MHI_TIMEOUT_MS;
 
+	mhi_cntrl->time_sync = of_property_read_bool(of_node, "mhi,time-sync");
+
+	if (mhi_cntrl->time_sync) {
+		mhi_tsync = kzalloc(sizeof(*mhi_tsync), GFP_KERNEL);
+		if (!mhi_tsync) {
+			ret = -ENOMEM;
+			goto error_time_sync;
+		}
+
+		ret = of_property_read_u32(of_node, "mhi,tsync-er",
+					   &mhi_tsync->er_index);
+		if (ret)
+			goto error_time_sync;
+
+		if (mhi_tsync->er_index >= mhi_cntrl->total_ev_rings) {
+			ret = -EINVAL;
+			goto error_time_sync;
+		}
+
+		mhi_cntrl->mhi_tsync = mhi_tsync;
+	}
+
 	mhi_cntrl->bounce_buf = of_property_read_bool(of_node, "mhi,use-bb");
 	ret = of_property_read_u32(of_node, "mhi,buffer-len",
 				   (u32 *)&mhi_cntrl->buffer_len);
@@ -882,6 +971,10 @@ static int of_parse_dt(struct mhi_controller *mhi_cntrl,
 
 	return 0;
 
+error_time_sync:
+	kfree(mhi_tsync);
+	kfree(mhi_cntrl->mhi_event);
+
 error_ev_cfg:
 	kfree(mhi_cntrl->mhi_chan);
 
@@ -910,6 +1003,11 @@ int of_register_mhi_controller(struct mhi_controller *mhi_cntrl)
 	if (ret)
 		return -EINVAL;
 
+	if (mhi_cntrl->time_sync &&
+	    (!mhi_cntrl->time_get || !mhi_cntrl->lpm_disable ||
+	     !mhi_cntrl->lpm_enable))
+		return -EINVAL;
+
 	mhi_cntrl->mhi_cmd = kcalloc(NR_OF_CMD_RINGS,
 				     sizeof(*mhi_cntrl->mhi_cmd), GFP_KERNEL);
 	if (!mhi_cntrl->mhi_cmd) {
@@ -953,6 +1051,14 @@ int of_register_mhi_controller(struct mhi_controller *mhi_cntrl)
 		rwlock_init(&mhi_chan->lock);
 	}
 
+	if (mhi_cntrl->mhi_tsync) {
+		struct mhi_timesync *mhi_tsync = mhi_cntrl->mhi_tsync;
+
+		spin_lock_init(&mhi_tsync->lock);
+		INIT_LIST_HEAD(&mhi_tsync->head);
+		init_completion(&mhi_tsync->completion);
+	}
+
 	if (mhi_cntrl->bounce_buf) {
 		mhi_cntrl->map_single = mhi_map_single_use_bb;
 		mhi_cntrl->unmap_single = mhi_unmap_single_use_bb;
@@ -1003,6 +1109,7 @@ void mhi_unregister_mhi_controller(struct mhi_controller *mhi_cntrl)
 	kfree(mhi_cntrl->mhi_cmd);
 	kfree(mhi_cntrl->mhi_event);
 	kfree(mhi_cntrl->mhi_chan);
+	kfree(mhi_cntrl->mhi_tsync);
 
 	device_del(&mhi_dev->dev);
 	put_device(&mhi_dev->dev);
@@ -1237,6 +1344,10 @@ static int mhi_driver_remove(struct device *dev)
 		mutex_unlock(&mhi_chan->mutex);
 	}
 
+
+	if (mhi_cntrl->tsync_dev == mhi_dev)
+		mhi_cntrl->tsync_dev = NULL;
+
 	/* relinquish any pending votes */
 	read_lock_bh(&mhi_cntrl->pm_lock);
 	while (atomic_read(&mhi_dev->dev_wake))
diff --git a/drivers/bus/mhi/core/mhi_internal.h b/drivers/bus/mhi/core/mhi_internal.h
index 1167d75..47d258a 100644
--- a/drivers/bus/mhi/core/mhi_internal.h
+++ b/drivers/bus/mhi/core/mhi_internal.h
@@ -128,6 +128,30 @@
 #define MHIDATALIMIT_HIGHER_MHIDATALIMIT_HIGHER_MASK (0xFFFFFFFF)
 #define MHIDATALIMIT_HIGHER_MHIDATALIMIT_HIGHER_SHIFT (0)
 
+/* MHI misc capability registers */
+#define MISC_OFFSET (0x24)
+#define MISC_CAP_MASK (0xFFFFFFFF)
+#define MISC_CAP_SHIFT (0)
+
+#define CAP_CAPID_MASK (0xFF000000)
+#define CAP_CAPID_SHIFT (24)
+#define CAP_NEXT_CAP_MASK (0x00FFF000)
+#define CAP_NEXT_CAP_SHIFT (12)
+
+/* MHI Timesync offsets */
+#define TIMESYNC_CFG_OFFSET (0x00)
+#define TIMESYNC_CFG_CAPID_MASK (CAP_CAPID_MASK)
+#define TIMESYNC_CFG_CAPID_SHIFT (CAP_CAPID_SHIFT)
+#define TIMESYNC_CFG_NEXT_OFF_MASK (CAP_NEXT_CAP_MASK)
+#define TIMESYNC_CFG_NEXT_OFF_SHIFT (CAP_NEXT_CAP_SHIFT)
+#define TIMESYNC_CFG_NUMCMD_MASK (0xFF)
+#define TIMESYNC_CFG_NUMCMD_SHIFT (0)
+#define TIMESYNC_TIME_LOW_OFFSET (0x4)
+#define TIMESYNC_TIME_HIGH_OFFSET (0x8)
+#define TIMESYNC_DB_OFFSET (0xC)
+
+#define TIMESYNC_CAP_ID (2)
+
 /* MHI BHI offfsets */
 #define BHI_BHIVERSION_MINOR (0x00)
 #define BHI_BHIVERSION_MAJOR (0x04)
@@ -243,6 +267,7 @@ enum mhi_cmd_type {
 	MHI_CMD_TYPE_RESET = 16,
 	MHI_CMD_TYPE_STOP = 17,
 	MHI_CMD_TYPE_START = 18,
+	MHI_CMD_TYPE_TSYNC = 24,
 };
 
 /* no operation command */
@@ -267,6 +292,12 @@ enum mhi_cmd_type {
 #define MHI_TRE_CMD_START_DWORD1(chid) ((chid << 24) | \
 					(MHI_CMD_TYPE_START << 16))
 
+/* time sync cfg command */
+#define MHI_TRE_CMD_TSYNC_CFG_PTR (0)
+#define MHI_TRE_CMD_TSYNC_CFG_DWORD0 (0)
+#define MHI_TRE_CMD_TSYNC_CFG_DWORD1(er) ((MHI_CMD_TYPE_TSYNC << 16) | \
+					  (er << 24))
+
 #define MHI_TRE_GET_CMD_CHID(tre) (((tre)->dword[1] >> 24) & 0xFF)
 #define MHI_TRE_GET_CMD_TYPE(tre) (((tre)->dword[1] >> 16) & 0xFF)
 
@@ -293,6 +324,7 @@ enum mhi_cmd_type {
 enum MHI_CMD {
 	MHI_CMD_RESET_CHAN,
 	MHI_CMD_START_CHAN,
+	MHI_CMD_TIMSYNC_CFG,
 };
 
 enum MHI_PKT_TYPE {
@@ -462,7 +494,8 @@ enum MHI_ER_TYPE {
 enum mhi_er_data_type {
 	MHI_ER_DATA_ELEMENT_TYPE,
 	MHI_ER_CTRL_ELEMENT_TYPE,
-	MHI_ER_DATA_TYPE_MAX = MHI_ER_CTRL_ELEMENT_TYPE,
+	MHI_ER_TSYNC_ELEMENT_TYPE,
+	MHI_ER_DATA_TYPE_MAX = MHI_ER_TSYNC_ELEMENT_TYPE,
 };
 
 struct db_cfg {
@@ -584,6 +617,25 @@ struct mhi_chan {
 	struct list_head node;
 };
 
+struct tsync_node {
+	struct list_head node;
+	u32 sequence;
+	u64 local_time;
+	u64 remote_time;
+	struct mhi_device *mhi_dev;
+	void (*cb_func)(struct mhi_device *mhi_dev, u32 sequence,
+			u64 local_time, u64 remote_time);
+};
+
+struct mhi_timesync {
+	u32 er_index;
+	void __iomem *db;
+	enum MHI_EV_CCS ccs;
+	struct completion completion;
+	spinlock_t lock;
+	struct list_head head;
+};
+
 /* default MHI timeout */
 #define MHI_TIMEOUT_MS (1000)
 
@@ -651,6 +703,7 @@ void mhi_ring_chan_db(struct mhi_controller *mhi_cntrl,
 void mhi_set_mhi_state(struct mhi_controller *mhi_cntrl, enum MHI_STATE state);
 int mhi_get_capability_offset(struct mhi_controller *mhi_cntrl, u32 capability,
 			      u32 *offset);
+int mhi_init_timesync(struct mhi_controller *mhi_cntrl);
 
 /* memory allocation methods */
 static inline void *mhi_alloc_coherent(struct mhi_controller *mhi_cntrl,
@@ -699,6 +752,8 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
 				struct mhi_event *mhi_event, u32 event_quota);
 int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
 			     struct mhi_event *mhi_event, u32 event_quota);
+int mhi_process_tsync_event_ring(struct mhi_controller *mhi_cntrl,
+				 struct mhi_event *mhi_event, u32 event_quota);
 
 /* initialization methods */
 int mhi_init_chan_ctxt(struct mhi_controller *mhi_cntrl,
diff --git a/drivers/bus/mhi/core/mhi_main.c b/drivers/bus/mhi/core/mhi_main.c
index 3e7077a8..8a0a7e1 100644
--- a/drivers/bus/mhi/core/mhi_main.c
+++ b/drivers/bus/mhi/core/mhi_main.c
@@ -53,6 +53,40 @@ int __must_check mhi_read_reg_field(struct mhi_controller *mhi_cntrl,
 	return 0;
 }
 
+int mhi_get_capability_offset(struct mhi_controller *mhi_cntrl,
+			      u32 capability,
+			      u32 *offset)
+{
+	u32 cur_cap, next_offset;
+	int ret;
+
+	/* get the 1st supported capability offset */
+	ret = mhi_read_reg_field(mhi_cntrl, mhi_cntrl->regs, MISC_OFFSET,
+				 MISC_CAP_MASK, MISC_CAP_SHIFT, offset);
+	if (ret)
+		return ret;
+	do {
+		ret = mhi_read_reg_field(mhi_cntrl, mhi_cntrl->regs, *offset,
+					 CAP_CAPID_MASK, CAP_CAPID_SHIFT,
+					 &cur_cap);
+		if (ret)
+			return ret;
+
+		if (cur_cap == capability)
+			return 0;
+
+		ret = mhi_read_reg_field(mhi_cntrl, mhi_cntrl->regs, *offset,
+					 CAP_NEXT_CAP_MASK, CAP_NEXT_CAP_SHIFT,
+					 &next_offset);
+		if (ret)
+			return ret;
+
+		*offset += next_offset;
+	} while (next_offset);
+
+	return -ENXIO;
+}
+
 void mhi_write_reg(struct mhi_controller *mhi_cntrl,
 		   void __iomem *base,
 		   u32 offset,
@@ -547,6 +581,42 @@ static void mhi_assign_of_node(struct mhi_controller *mhi_cntrl,
 	}
 }
 
+static void mhi_create_time_sync_dev(struct mhi_controller *mhi_cntrl)
+{
+	struct mhi_device *mhi_dev;
+	struct mhi_timesync *mhi_tsync = mhi_cntrl->mhi_tsync;
+	int ret;
+
+	if (!mhi_tsync || !mhi_tsync->db)
+		return;
+
+	if (mhi_cntrl->ee != MHI_EE_AMSS)
+		return;
+
+	mhi_dev = mhi_alloc_device(mhi_cntrl);
+	if (!mhi_dev)
+		return;
+
+	mhi_dev->dev_type = MHI_TIMESYNC_TYPE;
+	mhi_dev->chan_name = "TIME_SYNC";
+	dev_set_name(&mhi_dev->dev, "%04x_%02u.%02u.%02u_%s", mhi_dev->dev_id,
+		     mhi_dev->domain, mhi_dev->bus, mhi_dev->slot,
+		     mhi_dev->chan_name);
+
+	/* add if there is a matching DT node */
+	mhi_assign_of_node(mhi_cntrl, mhi_dev);
+
+	ret = device_add(&mhi_dev->dev);
+	if (ret) {
+		dev_err(mhi_cntrl->dev, "Failed to register dev for  chan:%s\n",
+			mhi_dev->chan_name);
+		mhi_dealloc_device(mhi_cntrl, mhi_dev);
+		return;
+	}
+
+	mhi_cntrl->tsync_dev = mhi_dev;
+}
+
 /* bind mhi channels into mhi devices */
 void mhi_create_devices(struct mhi_controller *mhi_cntrl)
 {
@@ -555,6 +625,13 @@ void mhi_create_devices(struct mhi_controller *mhi_cntrl)
 	struct mhi_device *mhi_dev;
 	int ret;
 
+	/*
+	 * we need to create time sync device before creating other
+	 * devices, because client may try to capture time during
+	 * clint probe.
+	 */
+	mhi_create_time_sync_dev(mhi_cntrl);
+
 	mhi_chan = mhi_cntrl->mhi_chan;
 	for (i = 0; i < mhi_cntrl->max_chan; i++, mhi_chan++) {
 		if (!mhi_chan->configured || mhi_chan->ee != mhi_cntrl->ee)
@@ -753,16 +830,26 @@ static void mhi_process_cmd_completion(struct mhi_controller *mhi_cntrl,
 	struct mhi_ring *mhi_ring = &cmd_ring->ring;
 	struct mhi_tre *cmd_pkt;
 	struct mhi_chan *mhi_chan;
+	struct mhi_timesync *mhi_tsync;
+	enum mhi_cmd_type type;
 	u32 chan;
 
 	cmd_pkt = mhi_to_virtual(mhi_ring, ptr);
 
-	chan = MHI_TRE_GET_CMD_CHID(cmd_pkt);
-	mhi_chan = &mhi_cntrl->mhi_chan[chan];
-	write_lock_bh(&mhi_chan->lock);
-	mhi_chan->ccs = MHI_TRE_GET_EV_CODE(tre);
-	complete(&mhi_chan->completion);
-	write_unlock_bh(&mhi_chan->lock);
+	type = MHI_TRE_GET_CMD_TYPE(cmd_pkt);
+
+	if (type == MHI_CMD_TYPE_TSYNC) {
+		mhi_tsync = mhi_cntrl->mhi_tsync;
+		mhi_tsync->ccs = MHI_TRE_GET_EV_CODE(tre);
+		complete(&mhi_tsync->completion);
+	} else {
+		chan = MHI_TRE_GET_CMD_CHID(cmd_pkt);
+		mhi_chan = &mhi_cntrl->mhi_chan[chan];
+		write_lock_bh(&mhi_chan->lock);
+		mhi_chan->ccs = MHI_TRE_GET_EV_CODE(tre);
+		complete(&mhi_chan->completion);
+		write_unlock_bh(&mhi_chan->lock);
+	}
 
 	mhi_del_ring_element(mhi_cntrl, mhi_ring);
 }
@@ -929,6 +1016,73 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
 	return count;
 }
 
+int mhi_process_tsync_event_ring(struct mhi_controller *mhi_cntrl,
+				 struct mhi_event *mhi_event,
+				 u32 event_quota)
+{
+	struct mhi_tre *dev_rp, *local_rp;
+	struct mhi_ring *ev_ring = &mhi_event->ring;
+	struct mhi_event_ctxt *er_ctxt =
+		&mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
+	struct mhi_timesync *mhi_tsync = mhi_cntrl->mhi_tsync;
+	int count = 0;
+	u32 sequence;
+	u64 remote_time;
+
+	if (unlikely(MHI_EVENT_ACCESS_INVALID(mhi_cntrl->pm_state))) {
+		read_unlock_bh(&mhi_cntrl->pm_lock);
+		return -EIO;
+	}
+
+	dev_rp = mhi_to_virtual(ev_ring, er_ctxt->rp);
+	local_rp = ev_ring->rp;
+
+	while (dev_rp != local_rp) {
+		struct tsync_node *tsync_node;
+
+		sequence = MHI_TRE_GET_EV_SEQ(local_rp);
+		remote_time = MHI_TRE_GET_EV_TIME(local_rp);
+
+		do {
+			spin_lock_irq(&mhi_tsync->lock);
+			tsync_node = list_first_entry_or_null(&mhi_tsync->head,
+						      struct tsync_node, node);
+
+			if (unlikely(!tsync_node))
+				break;
+
+			list_del(&tsync_node->node);
+			spin_unlock_irq(&mhi_tsync->lock);
+
+			/*
+			 * device may not able to process all time sync commands
+			 * host issue and only process last command it receive
+			 */
+			if (tsync_node->sequence == sequence) {
+				tsync_node->cb_func(tsync_node->mhi_dev,
+						    sequence,
+						    tsync_node->local_time,
+						    remote_time);
+				kfree(tsync_node);
+			} else {
+				kfree(tsync_node);
+			}
+		} while (true);
+
+		mhi_recycle_ev_ring_element(mhi_cntrl, ev_ring);
+		local_rp = ev_ring->rp;
+		dev_rp = mhi_to_virtual(ev_ring, er_ctxt->rp);
+		count++;
+	}
+
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl->pm_state)))
+		mhi_ring_er_db(mhi_event);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	return count;
+}
+
 void mhi_ev_task(unsigned long data)
 {
 	struct mhi_event *mhi_event = (struct mhi_event *)data;
@@ -1060,6 +1214,12 @@ int mhi_send_cmd(struct mhi_controller *mhi_cntrl,
 		cmd_tre->dword[0] = MHI_TRE_CMD_START_DWORD0;
 		cmd_tre->dword[1] = MHI_TRE_CMD_START_DWORD1(chan);
 		break;
+	case MHI_CMD_TIMSYNC_CFG:
+		cmd_tre->ptr = MHI_TRE_CMD_TSYNC_CFG_PTR;
+		cmd_tre->dword[0] = MHI_TRE_CMD_TSYNC_CFG_DWORD0;
+		cmd_tre->dword[1] = MHI_TRE_CMD_TSYNC_CFG_DWORD1
+			(mhi_cntrl->mhi_tsync->er_index);
+		break;
 	}
 
 	/* queue to hardware */
@@ -1437,3 +1597,94 @@ int mhi_poll(struct mhi_device *mhi_dev,
 	return ret;
 }
 EXPORT_SYMBOL(mhi_poll);
+
+/**
+ * mhi_get_remote_time - Get external modem time relative to host time
+ * Trigger event to capture modem time, also capture host time so client
+ * can do a relative drift comparision.
+ * Recommended only tsync device calls this method and do not call this
+ * from atomic context
+ * @mhi_dev: Device associated with the channels
+ * @sequence:unique sequence id track event
+ * @cb_func: callback function to call back
+ */
+int mhi_get_remote_time(struct mhi_device *mhi_dev,
+			u32 sequence,
+			void (*cb_func)(struct mhi_device *mhi_dev,
+					u32 sequence,
+					u64 local_time,
+					u64 remote_time))
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_timesync *mhi_tsync = mhi_cntrl->mhi_tsync;
+	struct tsync_node *tsync_node;
+	int ret;
+
+	/* not all devices support time feature */
+	if (!mhi_tsync)
+		return -EIO;
+
+	/* tsync db can only be rung in M0 state */
+	ret = __mhi_device_get_sync(mhi_cntrl);
+	if (ret)
+		return ret;
+
+	/*
+	 * technically we can use GFP_KERNEL, but wants to avoid
+	 * # of times scheduling out
+	 */
+	tsync_node = kzalloc(sizeof(*tsync_node), GFP_ATOMIC);
+	if (!tsync_node) {
+		ret = -ENOMEM;
+		goto error_no_mem;
+	}
+
+	tsync_node->sequence = sequence;
+	tsync_node->cb_func = cb_func;
+	tsync_node->mhi_dev = mhi_dev;
+
+	/* disable link level low power modes */
+	mhi_cntrl->lpm_disable(mhi_cntrl, mhi_cntrl->priv_data);
+
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (unlikely(MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))) {
+		ret = -EIO;
+		goto error_invalid_state;
+	}
+
+	spin_lock_irq(&mhi_tsync->lock);
+	list_add_tail(&tsync_node->node, &mhi_tsync->head);
+	spin_unlock_irq(&mhi_tsync->lock);
+
+	/*
+	 * time critical code, delay between these two steps should be
+	 * deterministic as possible.
+	 */
+	preempt_disable();
+	local_irq_disable();
+
+	tsync_node->local_time =
+		mhi_cntrl->time_get(mhi_cntrl, mhi_cntrl->priv_data);
+	writel_relaxed(tsync_node->sequence, mhi_tsync->db);
+	/* write must go thru immediately */
+	wmb();
+
+	local_irq_enable();
+	preempt_enable();
+
+	ret = 0;
+
+error_invalid_state:
+	if (ret)
+		kfree(tsync_node);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+	mhi_cntrl->lpm_enable(mhi_cntrl, mhi_cntrl->priv_data);
+
+error_no_mem:
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	mhi_cntrl->wake_put(mhi_cntrl, false);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(mhi_get_remote_time);
diff --git a/drivers/bus/mhi/core/mhi_pm.c b/drivers/bus/mhi/core/mhi_pm.c
index 5220cfa..f3a4965 100644
--- a/drivers/bus/mhi/core/mhi_pm.c
+++ b/drivers/bus/mhi/core/mhi_pm.c
@@ -415,6 +415,10 @@ static int mhi_pm_amss_transition(struct mhi_controller *mhi_cntrl)
 
 	read_unlock_bh(&mhi_cntrl->pm_lock);
 
+	/* setup support for time sync */
+	if (mhi_cntrl->time_sync)
+		mhi_init_timesync(mhi_cntrl);
+
 	/* add supported devices */
 	mhi_create_devices(mhi_cntrl);
 
@@ -764,6 +768,9 @@ void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
 		mhi_deinit_free_irq(mhi_cntrl);
 		mhi_deinit_dev_ctxt(mhi_cntrl);
 	}
+
+	if (mhi_cntrl->mhi_tsync)
+		mhi_cntrl->mhi_tsync->db = NULL;
 }
 EXPORT_SYMBOL(mhi_power_down);
 
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index 308d12b..25de226 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -12,6 +12,7 @@
 struct mhi_cmd;
 struct image_info;
 struct bhi_vec_entry;
+struct mhi_timesync;
 struct mhi_buf_info;
 
 /**
@@ -203,6 +204,7 @@ struct mhi_controller {
 	void (*wake_put)(struct mhi_controller *mhi_cntrl, bool override);
 	int (*runtime_get)(struct mhi_controller *mhi_cntrl, void *priv);
 	void (*runtime_put)(struct mhi_controller *mhi_cntrl, void *priv);
+	u64 (*time_get)(struct mhi_controller *mhi_cntrl, void *priv);
 	void (*lpm_disable)(struct mhi_controller *mhi_cntrl, void *priv);
 	void (*lpm_enable)(struct mhi_controller *mhi_cntrl, void *priv);
 	int (*map_single)(struct mhi_controller *mhi_cntrl,
@@ -217,6 +219,11 @@ struct mhi_controller {
 	bool bounce_buf;
 	size_t buffer_len;
 
+	/* supports time sync feature */
+	bool time_sync;
+	struct mhi_timesync *mhi_tsync;
+	struct mhi_device *tsync_dev;
+
 	/* controller specific data */
 	void *priv_data;
 	void *log_buf;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


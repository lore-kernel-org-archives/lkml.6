Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEA2C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E037D208DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E037D208DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933634AbeGIUP3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 16:15:29 -0400
Received: from labrats.qualcomm.com ([199.106.110.90]:21907 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933180AbeGIUOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 16:14:33 -0400
X-IronPort-AV: E=Sophos;i="5.51,330,1526367600"; 
   d="scan'208";a="39007201"
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by labrats.qualcomm.com with ESMTP; 09 Jul 2018 13:08:23 -0700
X-IronPort-AV: E=McAfee;i="5900,7806,8949"; a="192504336"
Received: from sdias-linux.qualcomm.com (HELO sdias-linux1.qualcomm.com) ([192.168.140.71])
  by ironmsg03-sd.qualcomm.com with ESMTP; 09 Jul 2018 13:08:23 -0700
Received: by sdias-linux1.qualcomm.com (Postfix, from userid 84243)
        id 058A2150B; Mon,  9 Jul 2018 13:08:22 -0700 (PDT)
From:   Sujeev Dias <sdias@codeaurora.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Sujeev Dias <sdias@codeaurora.org>,
        Tony Truong <truong@codeaurora.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>
Subject: [PATCH v2 3/7] mhi_bus: core: add support for data transfer
Date:   Mon,  9 Jul 2018 13:08:10 -0700
Message-Id: <1531166894-30984-4-git-send-email-sdias@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531166894-30984-1-git-send-email-sdias@codeaurora.org>
References: <1524795811-21399-1-git-send-email-sdias@codeaurora.org>
 <1531166894-30984-1-git-send-email-sdias@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for transferring data between external
modem and MHI host using MHI protocol.

Signed-off-by: Sujeev Dias <sdias@codeaurora.org>
Reviewed-by: Tony Truong <truong@codeaurora.org>
Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
---
 drivers/bus/mhi/core/mhi_init.c     |  76 +++-
 drivers/bus/mhi/core/mhi_internal.h |   8 -
 drivers/bus/mhi/core/mhi_main.c     | 803 +++++++++++++++++++++++++++++++++++-
 include/linux/mhi.h                 |  78 ++++
 4 files changed, 950 insertions(+), 15 deletions(-)

diff --git a/drivers/bus/mhi/core/mhi_init.c b/drivers/bus/mhi/core/mhi_init.c
index 7b3d12a..43a700d 100644
--- a/drivers/bus/mhi/core/mhi_init.c
+++ b/drivers/bus/mhi/core/mhi_init.c
@@ -548,6 +548,66 @@ int mhi_init_chan_ctxt(struct mhi_controller *mhi_cntrl,
 	return 0;
 }
 
+int mhi_device_configure(struct mhi_device *mhi_dev,
+			 enum dma_data_direction dir,
+			 struct mhi_buf *cfg_tbl,
+			 int elements)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_chan *mhi_chan;
+	struct mhi_event_ctxt *er_ctxt;
+	struct mhi_chan_ctxt *ch_ctxt;
+	int er_index, chan;
+
+	switch (dir) {
+	case DMA_TO_DEVICE:
+		mhi_chan = mhi_dev->ul_chan;
+		break;
+	case DMA_BIDIRECTIONAL:
+	case DMA_FROM_DEVICE:
+	case DMA_NONE:
+		mhi_chan = mhi_dev->dl_chan;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	er_index = mhi_chan->er_index;
+	chan = mhi_chan->chan;
+
+	for (; elements > 0; elements--, cfg_tbl++) {
+		/* update event context array */
+		if (!strcmp(cfg_tbl->name, "ECA")) {
+			er_ctxt = &mhi_cntrl->mhi_ctxt->er_ctxt[er_index];
+			if (sizeof(*er_ctxt) != cfg_tbl->len) {
+				dev_err(mhi_cntrl->dev,
+					"Invalid ECA size, expected:%zu actual%zu\n",
+					sizeof(*er_ctxt), cfg_tbl->len);
+				return -EINVAL;
+			}
+			memcpy((void *)er_ctxt, cfg_tbl->buf, sizeof(*er_ctxt));
+			continue;
+		}
+
+		/* update channel context array */
+		if (!strcmp(cfg_tbl->name, "CCA")) {
+			ch_ctxt = &mhi_cntrl->mhi_ctxt->chan_ctxt[chan];
+			if (cfg_tbl->len != sizeof(*ch_ctxt)) {
+				dev_err(mhi_cntrl->dev,
+					"Invalid CCA size, expected:%zu actual:%zu\n",
+					sizeof(*ch_ctxt), cfg_tbl->len);
+				return -EINVAL;
+			}
+			memcpy((void *)ch_ctxt, cfg_tbl->buf, sizeof(*ch_ctxt));
+			continue;
+		}
+
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int of_parse_ev_cfg(struct mhi_controller *mhi_cntrl,
 			   struct device_node *of_node)
 {
@@ -1067,6 +1127,9 @@ static int mhi_driver_probe(struct device *dev)
 	struct mhi_event *mhi_event;
 	struct mhi_chan *ul_chan = mhi_dev->ul_chan;
 	struct mhi_chan *dl_chan = mhi_dev->dl_chan;
+	bool auto_start = false;
+	int ret;
+
 
 	if (ul_chan) {
 		/* lpm notification require status_cb */
@@ -1078,6 +1141,7 @@ static int mhi_driver_probe(struct device *dev)
 
 		ul_chan->xfer_cb = mhi_drv->ul_xfer_cb;
 		mhi_dev->status_cb = mhi_drv->status_cb;
+		auto_start = ul_chan->auto_start;
 	}
 
 	if (dl_chan) {
@@ -1101,9 +1165,15 @@ static int mhi_driver_probe(struct device *dev)
 
 		/* ul & dl uses same status cb */
 		mhi_dev->status_cb = mhi_drv->status_cb;
+		auto_start = (auto_start || dl_chan->auto_start);
 	}
 
-	return mhi_drv->probe(mhi_dev, mhi_dev->id);
+	ret = mhi_drv->probe(mhi_dev, mhi_dev->id);
+
+	if (!ret && auto_start)
+		mhi_prepare_for_transfer(mhi_dev);
+
+	return ret;
 }
 
 static int mhi_driver_remove(struct device *dev)
@@ -1141,6 +1211,10 @@ static int mhi_driver_remove(struct device *dev)
 		ch_state[dir] = mhi_chan->ch_state;
 		mhi_chan->ch_state = MHI_CH_STATE_DISABLED;
 		write_unlock_irq(&mhi_chan->lock);
+
+		/* reset the channel */
+		if (!mhi_chan->offload_ch)
+			mhi_reset_chan(mhi_cntrl, mhi_chan);
 	}
 
 	/* destroy the device */
diff --git a/drivers/bus/mhi/core/mhi_internal.h b/drivers/bus/mhi/core/mhi_internal.h
index 0091245..1167d75 100644
--- a/drivers/bus/mhi/core/mhi_internal.h
+++ b/drivers/bus/mhi/core/mhi_internal.h
@@ -243,7 +243,6 @@ enum mhi_cmd_type {
 	MHI_CMD_TYPE_RESET = 16,
 	MHI_CMD_TYPE_STOP = 17,
 	MHI_CMD_TYPE_START = 18,
-	MHI_CMD_TYPE_TSYNC = 24,
 };
 
 /* no operation command */
@@ -268,12 +267,6 @@ enum mhi_cmd_type {
 #define MHI_TRE_CMD_START_DWORD1(chid) ((chid << 24) | \
 					(MHI_CMD_TYPE_START << 16))
 
-/* time sync cfg command */
-#define MHI_TRE_CMD_TSYNC_CFG_PTR (0)
-#define MHI_TRE_CMD_TSYNC_CFG_DWORD0 (0)
-#define MHI_TRE_CMD_TSYNC_CFG_DWORD1(er) ((MHI_CMD_TYPE_TSYNC << 16) | \
-					  (er << 24))
-
 #define MHI_TRE_GET_CMD_CHID(tre) (((tre)->dword[1] >> 24) & 0xFF)
 #define MHI_TRE_GET_CMD_TYPE(tre) (((tre)->dword[1] >> 16) & 0xFF)
 
@@ -300,7 +293,6 @@ enum mhi_cmd_type {
 enum MHI_CMD {
 	MHI_CMD_RESET_CHAN,
 	MHI_CMD_START_CHAN,
-	MHI_CMD_TIMSYNC_CFG,
 };
 
 enum MHI_PKT_TYPE {
diff --git a/drivers/bus/mhi/core/mhi_main.c b/drivers/bus/mhi/core/mhi_main.c
index 81cda31..3e7077a8 100644
--- a/drivers/bus/mhi/core/mhi_main.c
+++ b/drivers/bus/mhi/core/mhi_main.c
@@ -159,23 +159,46 @@ enum MHI_STATE mhi_get_m_state(struct mhi_controller *mhi_cntrl)
 int mhi_map_single_no_bb(struct mhi_controller *mhi_cntrl,
 			 struct mhi_buf_info *buf_info)
 {
-	return -ENOMEM;
+	buf_info->p_addr = dma_map_single(mhi_cntrl->dev, buf_info->v_addr,
+					  buf_info->len, buf_info->dir);
+	if (dma_mapping_error(mhi_cntrl->dev, buf_info->p_addr))
+		return -ENOMEM;
+
+	return 0;
 }
 
 int mhi_map_single_use_bb(struct mhi_controller *mhi_cntrl,
 			  struct mhi_buf_info *buf_info)
 {
-	return -ENOMEM;
+	void *buf = mhi_alloc_coherent(mhi_cntrl, buf_info->len,
+				       &buf_info->p_addr, GFP_ATOMIC);
+
+	if (!buf)
+		return -ENOMEM;
+
+	if (buf_info->dir == DMA_TO_DEVICE)
+		memcpy(buf, buf_info->v_addr, buf_info->len);
+
+	buf_info->bb_addr = buf;
+
+	return 0;
 }
 
 void mhi_unmap_single_no_bb(struct mhi_controller *mhi_cntrl,
 			    struct mhi_buf_info *buf_info)
 {
+	dma_unmap_single(mhi_cntrl->dev, buf_info->p_addr, buf_info->len,
+			 buf_info->dir);
 }
 
 void mhi_unmap_single_use_bb(struct mhi_controller *mhi_cntrl,
 			    struct mhi_buf_info *buf_info)
 {
+	if (buf_info->dir == DMA_FROM_DEVICE)
+		memcpy(buf_info->v_addr, buf_info->bb_addr, buf_info->len);
+
+	mhi_free_coherent(mhi_cntrl, buf_info->len, buf_info->bb_addr,
+			  buf_info->p_addr);
 }
 
 int mhi_queue_sclist(struct mhi_device *mhi_dev,
@@ -196,6 +219,41 @@ int mhi_queue_nop(struct mhi_device *mhi_dev,
 	return -EINVAL;
 }
 
+static void mhi_add_ring_element(struct mhi_controller *mhi_cntrl,
+				 struct mhi_ring *ring)
+{
+	ring->wp += ring->el_size;
+	if (ring->wp >= (ring->base + ring->len))
+		ring->wp = ring->base;
+	/* smp update */
+	smp_wmb();
+}
+
+static void mhi_del_ring_element(struct mhi_controller *mhi_cntrl,
+				 struct mhi_ring *ring)
+{
+	ring->rp += ring->el_size;
+	if (ring->rp >= (ring->base + ring->len))
+		ring->rp = ring->base;
+	/* smp update */
+	smp_wmb();
+}
+
+static int get_nr_avail_ring_elements(struct mhi_controller *mhi_cntrl,
+				      struct mhi_ring *ring)
+{
+	int nr_el;
+
+	if (ring->wp < ring->rp)
+		nr_el = ((ring->rp - ring->wp) / ring->el_size) - 1;
+	else {
+		nr_el = (ring->rp - ring->base) / ring->el_size;
+		nr_el += ((ring->base + ring->len - ring->wp) /
+			  ring->el_size) - 1;
+	}
+	return nr_el;
+}
+
 static void *mhi_to_virtual(struct mhi_ring *ring, dma_addr_t addr)
 {
 	return (addr - ring->iommu_base) + ring->base;
@@ -231,13 +289,97 @@ static void mhi_recycle_ev_ring_element(struct mhi_controller *mhi_cntrl,
 	smp_wmb();
 }
 
+static bool mhi_is_ring_full(struct mhi_controller *mhi_cntrl,
+			     struct mhi_ring *ring)
+{
+	void *tmp = ring->wp + ring->el_size;
+
+	if (tmp >= (ring->base + ring->len))
+		tmp = ring->base;
+
+	return (tmp == ring->rp);
+}
+
 int mhi_queue_skb(struct mhi_device *mhi_dev,
 		  struct mhi_chan *mhi_chan,
 		  void *buf,
 		  size_t len,
 		  enum MHI_FLAGS mflags)
 {
-	return -EINVAL;
+	struct sk_buff *skb = buf;
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_ring *tre_ring = &mhi_chan->tre_ring;
+	struct mhi_ring *buf_ring = &mhi_chan->buf_ring;
+	struct mhi_buf_info *buf_info;
+	struct mhi_tre *mhi_tre;
+	bool assert_wake = false;
+	int ret;
+
+	if (mhi_is_ring_full(mhi_cntrl, tre_ring))
+		return -ENOMEM;
+
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (unlikely(MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))) {
+		read_unlock_bh(&mhi_cntrl->pm_lock);
+		return -EIO;
+	}
+
+	/* we're in M3 or transitioning to M3 */
+	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state)) {
+		mhi_cntrl->runtime_get(mhi_cntrl, mhi_cntrl->priv_data);
+		mhi_cntrl->runtime_put(mhi_cntrl, mhi_cntrl->priv_data);
+	}
+
+	/*
+	 * For UL channels always assert WAKE until work is done,
+	 * For DL channels only assert if MHI is in a LPM
+	 */
+	if (mhi_chan->dir == DMA_TO_DEVICE ||
+	    (mhi_chan->dir == DMA_FROM_DEVICE &&
+	     mhi_cntrl->pm_state != MHI_PM_M0)) {
+		assert_wake = true;
+		mhi_cntrl->wake_get(mhi_cntrl, false);
+	}
+
+	/* generate the tre */
+	buf_info = buf_ring->wp;
+	buf_info->v_addr = skb->data;
+	buf_info->cb_buf = skb;
+	buf_info->wp = tre_ring->wp;
+	buf_info->dir = mhi_chan->dir;
+	buf_info->len = len;
+	ret = mhi_cntrl->map_single(mhi_cntrl, buf_info);
+	if (ret)
+		goto map_error;
+
+	mhi_tre = tre_ring->wp;
+	mhi_tre->ptr = MHI_TRE_DATA_PTR(buf_info->p_addr);
+	mhi_tre->dword[0] = MHI_TRE_DATA_DWORD0(buf_info->len);
+	mhi_tre->dword[1] = MHI_TRE_DATA_DWORD1(1, 1, 0, 0);
+
+	/* increment WP */
+	mhi_add_ring_element(mhi_cntrl, tre_ring);
+	mhi_add_ring_element(mhi_cntrl, buf_ring);
+
+	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl->pm_state))) {
+		read_lock_bh(&mhi_chan->lock);
+		mhi_ring_chan_db(mhi_cntrl, mhi_chan);
+		read_unlock_bh(&mhi_chan->lock);
+	}
+
+	if (mhi_chan->dir == DMA_FROM_DEVICE && assert_wake)
+		mhi_cntrl->wake_put(mhi_cntrl, true);
+
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	return 0;
+
+map_error:
+	if (assert_wake)
+		mhi_cntrl->wake_put(mhi_cntrl, false);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	return ret;
 }
 
 int mhi_gen_tre(struct mhi_controller *mhi_cntrl,
@@ -247,7 +389,41 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl,
 		size_t buf_len,
 		enum MHI_FLAGS flags)
 {
-	return -EINVAL;
+	struct mhi_ring *buf_ring, *tre_ring;
+	struct mhi_tre *mhi_tre;
+	struct mhi_buf_info *buf_info;
+	int eot, eob, chain, bei;
+	int ret;
+
+	buf_ring = &mhi_chan->buf_ring;
+	tre_ring = &mhi_chan->tre_ring;
+
+	buf_info = buf_ring->wp;
+	buf_info->v_addr = buf;
+	buf_info->cb_buf = cb;
+	buf_info->wp = tre_ring->wp;
+	buf_info->dir = mhi_chan->dir;
+	buf_info->len = buf_len;
+
+	ret = mhi_cntrl->map_single(mhi_cntrl, buf_info);
+	if (ret)
+		return ret;
+
+	eob = !!(flags & MHI_EOB);
+	eot = !!(flags & MHI_EOT);
+	chain = !!(flags & MHI_CHAIN);
+	bei = !!(mhi_chan->intmod);
+
+	mhi_tre = tre_ring->wp;
+	mhi_tre->ptr = MHI_TRE_DATA_PTR(buf_info->p_addr);
+	mhi_tre->dword[0] = MHI_TRE_DATA_DWORD0(buf_len);
+	mhi_tre->dword[1] = MHI_TRE_DATA_DWORD1(bei, eot, eob, chain);
+
+	/* increment WP */
+	mhi_add_ring_element(mhi_cntrl, tre_ring);
+	mhi_add_ring_element(mhi_cntrl, buf_ring);
+
+	return 0;
 }
 
 int mhi_queue_buf(struct mhi_device *mhi_dev,
@@ -256,7 +432,61 @@ int mhi_queue_buf(struct mhi_device *mhi_dev,
 		  size_t len,
 		  enum MHI_FLAGS mflags)
 {
-	return -EINVAL;
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_ring *tre_ring;
+	unsigned long flags;
+	bool assert_wake = false;
+	int ret;
+
+	/*
+	 * this check here only as a guard, it's always
+	 * possible mhi can enter error while executing rest of function,
+	 * which is not fatal so we do not need to hold pm_lock
+	 */
+	if (unlikely(MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)))
+		return -EIO;
+
+	/* we're in M3 or transitioning to M3 */
+	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state)) {
+		mhi_cntrl->runtime_get(mhi_cntrl, mhi_cntrl->priv_data);
+		mhi_cntrl->runtime_put(mhi_cntrl, mhi_cntrl->priv_data);
+	}
+
+	tre_ring = &mhi_chan->tre_ring;
+	if (mhi_is_ring_full(mhi_cntrl, tre_ring))
+		return -ENOMEM;
+
+	ret = mhi_chan->gen_tre(mhi_cntrl, mhi_chan, buf, buf, len, mflags);
+	if (unlikely(ret))
+		return ret;
+
+	read_lock_irqsave(&mhi_cntrl->pm_lock, flags);
+
+	/*
+	 * For UL channels always assert WAKE until work is done,
+	 * For DL channels only assert if MHI is in a LPM
+	 */
+	if (mhi_chan->dir == DMA_TO_DEVICE ||
+	    (mhi_chan->dir == DMA_FROM_DEVICE &&
+	     mhi_cntrl->pm_state != MHI_PM_M0)) {
+		assert_wake = true;
+		mhi_cntrl->wake_get(mhi_cntrl, false);
+	}
+
+	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl->pm_state))) {
+		unsigned long flags;
+
+		read_lock_irqsave(&mhi_chan->lock, flags);
+		mhi_ring_chan_db(mhi_cntrl, mhi_chan);
+		read_unlock_irqrestore(&mhi_chan->lock, flags);
+	}
+
+	if (mhi_chan->dir == DMA_FROM_DEVICE && assert_wake)
+		mhi_cntrl->wake_put(mhi_cntrl, true);
+
+	read_unlock_irqrestore(&mhi_cntrl->pm_lock, flags);
+
+	return 0;
 }
 
 /* destroy specific device */
@@ -389,6 +619,154 @@ void mhi_create_devices(struct mhi_controller *mhi_cntrl)
 			mhi_dealloc_device(mhi_cntrl, mhi_dev);
 	}
 }
+
+static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
+			    struct mhi_tre *event,
+			    struct mhi_chan *mhi_chan)
+{
+	struct mhi_ring *buf_ring, *tre_ring;
+	u32 ev_code;
+	struct mhi_result result;
+	unsigned long flags = 0;
+
+	ev_code = MHI_TRE_GET_EV_CODE(event);
+	buf_ring = &mhi_chan->buf_ring;
+	tre_ring = &mhi_chan->tre_ring;
+
+	result.transaction_status = (ev_code == MHI_EV_CC_OVERFLOW) ?
+		-EOVERFLOW : 0;
+
+	/*
+	 * if it's a DB Event then we need to grab the lock
+	 * with preemption disable and as a write because we
+	 * have to update db register and another thread could
+	 * be doing same.
+	 */
+	if (ev_code >= MHI_EV_CC_OOB)
+		write_lock_irqsave(&mhi_chan->lock, flags);
+	else
+		read_lock_bh(&mhi_chan->lock);
+
+	if (mhi_chan->ch_state != MHI_CH_STATE_ENABLED)
+		goto end_process_tx_event;
+
+	switch (ev_code) {
+	case MHI_EV_CC_OVERFLOW:
+	case MHI_EV_CC_EOB:
+	case MHI_EV_CC_EOT:
+	{
+		dma_addr_t ptr = MHI_TRE_GET_EV_PTR(event);
+		struct mhi_tre *local_rp, *ev_tre;
+		void *dev_rp;
+		struct mhi_buf_info *buf_info;
+		u16 xfer_len;
+
+		/* Get the TRB this event points to */
+		ev_tre = mhi_to_virtual(tre_ring, ptr);
+
+		/* device rp after servicing the TREs */
+		dev_rp = ev_tre + 1;
+		if (dev_rp >= (tre_ring->base + tre_ring->len))
+			dev_rp = tre_ring->base;
+
+		result.dir = mhi_chan->dir;
+
+		/* local rp */
+		local_rp = tre_ring->rp;
+		while (local_rp != dev_rp) {
+			buf_info = buf_ring->rp;
+			/* if it's last tre get len from the event */
+			if (local_rp == ev_tre)
+				xfer_len = MHI_TRE_GET_EV_LEN(event);
+			else
+				xfer_len = buf_info->len;
+
+			mhi_cntrl->unmap_single(mhi_cntrl, buf_info);
+
+			result.buf_addr = buf_info->cb_buf;
+			result.bytes_xferd = xfer_len;
+			mhi_del_ring_element(mhi_cntrl, buf_ring);
+			mhi_del_ring_element(mhi_cntrl, tre_ring);
+			local_rp = tre_ring->rp;
+
+			/* notify client */
+			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
+
+			if (mhi_chan->dir == DMA_TO_DEVICE) {
+				read_lock_bh(&mhi_cntrl->pm_lock);
+				mhi_cntrl->wake_put(mhi_cntrl, false);
+				read_unlock_bh(&mhi_cntrl->pm_lock);
+			}
+
+			/*
+			 * recycle the buffer if buffer is pre-allocated,
+			 * if there is error, not much we can do apart from
+			 * dropping the packet
+			 */
+			if (mhi_chan->pre_alloc) {
+				if (mhi_queue_buf(mhi_chan->mhi_dev, mhi_chan,
+						  buf_info->cb_buf,
+						  buf_info->len, MHI_EOT)) {
+					dev_err(mhi_cntrl->dev,
+						"Error recycling buffer for chan:%d\n",
+						mhi_chan->chan);
+					kfree(buf_info->cb_buf);
+				}
+			}
+		}
+		break;
+	} /* CC_EOT */
+	case MHI_EV_CC_OOB:
+	case MHI_EV_CC_DB_MODE:
+	{
+		unsigned long flags;
+
+		mhi_chan->db_cfg.db_mode = 1;
+		read_lock_irqsave(&mhi_cntrl->pm_lock, flags);
+		if (tre_ring->wp != tre_ring->rp &&
+		    MHI_DB_ACCESS_VALID(mhi_cntrl->pm_state)) {
+			mhi_ring_chan_db(mhi_cntrl, mhi_chan);
+		}
+		read_unlock_irqrestore(&mhi_cntrl->pm_lock, flags);
+		break;
+	}
+	case MHI_EV_CC_BAD_TRE:
+	default:
+		dev_err(mhi_cntrl->dev, "Unknown event 0x%x\n", ev_code);
+		break;
+	} /* switch(MHI_EV_READ_CODE(EV_TRB_CODE,event)) */
+
+end_process_tx_event:
+	if (ev_code >= MHI_EV_CC_OOB)
+		write_unlock_irqrestore(&mhi_chan->lock, flags);
+	else
+		read_unlock_bh(&mhi_chan->lock);
+
+	return 0;
+}
+
+static void mhi_process_cmd_completion(struct mhi_controller *mhi_cntrl,
+				       struct mhi_tre *tre)
+{
+	dma_addr_t ptr = MHI_TRE_GET_EV_PTR(tre);
+	struct mhi_cmd *cmd_ring = &mhi_cntrl->mhi_cmd[PRIMARY_CMD_RING];
+	struct mhi_ring *mhi_ring = &cmd_ring->ring;
+	struct mhi_tre *cmd_pkt;
+	struct mhi_chan *mhi_chan;
+	u32 chan;
+
+	cmd_pkt = mhi_to_virtual(mhi_ring, ptr);
+
+	chan = MHI_TRE_GET_CMD_CHID(cmd_pkt);
+	mhi_chan = &mhi_cntrl->mhi_chan[chan];
+	write_lock_bh(&mhi_chan->lock);
+	mhi_chan->ccs = MHI_TRE_GET_EV_CODE(tre);
+	complete(&mhi_chan->completion);
+	write_unlock_bh(&mhi_chan->lock);
+
+	mhi_del_ring_element(mhi_cntrl, mhi_ring);
+}
+
 int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
 			     struct mhi_event *mhi_event,
 			     u32 event_quota)
@@ -457,6 +835,7 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
 			break;
 		}
 		case MHI_PKT_TYPE_CMD_COMPLETION_EVENT:
+			mhi_process_cmd_completion(mhi_cntrl, local_rp);
 			break;
 		case MHI_PKT_TYPE_EE_EVENT:
 		{
@@ -513,11 +892,52 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
 				struct mhi_event *mhi_event,
 				u32 event_quota)
 {
-	return -EIO;
+	struct mhi_tre *dev_rp, *local_rp;
+	struct mhi_ring *ev_ring = &mhi_event->ring;
+	struct mhi_event_ctxt *er_ctxt =
+		&mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
+	int count = 0;
+	u32 chan;
+	struct mhi_chan *mhi_chan;
+
+	if (unlikely(MHI_EVENT_ACCESS_INVALID(mhi_cntrl->pm_state)))
+		return -EIO;
+
+	dev_rp = mhi_to_virtual(ev_ring, er_ctxt->rp);
+	local_rp = ev_ring->rp;
+
+	while (dev_rp != local_rp && event_quota > 0) {
+		enum MHI_PKT_TYPE type = MHI_TRE_GET_EV_TYPE(local_rp);
+
+		if (likely(type == MHI_PKT_TYPE_TX_EVENT)) {
+			chan = MHI_TRE_GET_EV_CHID(local_rp);
+			mhi_chan = &mhi_cntrl->mhi_chan[chan];
+			parse_xfer_event(mhi_cntrl, local_rp, mhi_chan);
+			event_quota--;
+		}
+
+		mhi_recycle_ev_ring_element(mhi_cntrl, ev_ring);
+		local_rp = ev_ring->rp;
+		dev_rp = mhi_to_virtual(ev_ring, er_ctxt->rp);
+		count++;
+	}
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl->pm_state)))
+		mhi_ring_er_db(mhi_event);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	return count;
 }
 
 void mhi_ev_task(unsigned long data)
 {
+	struct mhi_event *mhi_event = (struct mhi_event *)data;
+	struct mhi_controller *mhi_cntrl = mhi_event->mhi_cntrl;
+
+	/* process all pending events */
+	spin_lock_bh(&mhi_event->lock);
+	mhi_event->process_event(mhi_cntrl, mhi_event, U32_MAX);
+	spin_unlock_bh(&mhi_event->lock);
 }
 
 void mhi_ctrl_ev_task(unsigned long data)
@@ -609,6 +1029,361 @@ irqreturn_t mhi_intvec_handlr(int irq_number, void *dev)
 	return IRQ_WAKE_THREAD;
 }
 
+int mhi_send_cmd(struct mhi_controller *mhi_cntrl,
+		 struct mhi_chan *mhi_chan,
+		 enum MHI_CMD cmd)
+{
+	struct mhi_tre *cmd_tre = NULL;
+	struct mhi_cmd *mhi_cmd = &mhi_cntrl->mhi_cmd[PRIMARY_CMD_RING];
+	struct mhi_ring *ring = &mhi_cmd->ring;
+	int chan = 0;
+
+	if (mhi_chan)
+		chan = mhi_chan->chan;
+
+	spin_lock_bh(&mhi_cmd->lock);
+	if (!get_nr_avail_ring_elements(mhi_cntrl, ring)) {
+		spin_unlock_bh(&mhi_cmd->lock);
+		return -ENOMEM;
+	}
+
+	/* prepare the cmd tre */
+	cmd_tre = ring->wp;
+	switch (cmd) {
+	case MHI_CMD_RESET_CHAN:
+		cmd_tre->ptr = MHI_TRE_CMD_RESET_PTR;
+		cmd_tre->dword[0] = MHI_TRE_CMD_RESET_DWORD0;
+		cmd_tre->dword[1] = MHI_TRE_CMD_RESET_DWORD1(chan);
+		break;
+	case MHI_CMD_START_CHAN:
+		cmd_tre->ptr = MHI_TRE_CMD_START_PTR;
+		cmd_tre->dword[0] = MHI_TRE_CMD_START_DWORD0;
+		cmd_tre->dword[1] = MHI_TRE_CMD_START_DWORD1(chan);
+		break;
+	}
+
+	/* queue to hardware */
+	mhi_add_ring_element(mhi_cntrl, ring);
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl->pm_state)))
+		mhi_ring_cmd_db(mhi_cntrl, mhi_cmd);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+	spin_unlock_bh(&mhi_cmd->lock);
+
+	return 0;
+}
+
+static void __mhi_unprepare_channel(struct mhi_controller *mhi_cntrl,
+				    struct mhi_chan *mhi_chan)
+{
+	int ret;
+
+	dev_info(mhi_cntrl->dev, "Entered: unprepare channel:%d\n",
+		 mhi_chan->chan);
+
+	/* no more processing events for this channel */
+	mutex_lock(&mhi_chan->mutex);
+	write_lock_irq(&mhi_chan->lock);
+	if (mhi_chan->ch_state != MHI_CH_STATE_ENABLED) {
+		write_unlock_irq(&mhi_chan->lock);
+		mutex_unlock(&mhi_chan->mutex);
+		return;
+	}
+
+	mhi_chan->ch_state = MHI_CH_STATE_DISABLED;
+	write_unlock_irq(&mhi_chan->lock);
+
+	reinit_completion(&mhi_chan->completion);
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		read_unlock_bh(&mhi_cntrl->pm_lock);
+		goto error_invalid_state;
+	}
+
+	mhi_cntrl->wake_get(mhi_cntrl, false);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	mhi_cntrl->runtime_get(mhi_cntrl, mhi_cntrl->priv_data);
+	mhi_cntrl->runtime_put(mhi_cntrl, mhi_cntrl->priv_data);
+	ret = mhi_send_cmd(mhi_cntrl, mhi_chan, MHI_CMD_RESET_CHAN);
+	if (ret)
+		goto error_completion;
+
+	/* even if it fails we will still reset */
+	ret = wait_for_completion_timeout(&mhi_chan->completion,
+				msecs_to_jiffies(mhi_cntrl->timeout_ms));
+	if (!ret || mhi_chan->ccs != MHI_EV_CC_SUCCESS)
+		dev_err(mhi_cntrl->dev,
+			"Failed to receive cmd completion, still resetting\n");
+
+error_completion:
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	mhi_cntrl->wake_put(mhi_cntrl, false);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+error_invalid_state:
+	if (!mhi_chan->offload_ch) {
+		mhi_reset_chan(mhi_cntrl, mhi_chan);
+		mhi_deinit_chan_ctxt(mhi_cntrl, mhi_chan);
+	}
+	dev_info(mhi_cntrl->dev, "chan:%d successfully resetted\n",
+		 mhi_chan->chan);
+	mutex_unlock(&mhi_chan->mutex);
+}
+
+static int __mhi_prepare_channel(struct mhi_controller *mhi_cntrl,
+				 struct mhi_chan *mhi_chan)
+{
+	int ret = 0;
+
+	dev_info(mhi_cntrl->dev, "Entered: preparing channel:%d\n",
+		 mhi_chan->chan);
+
+	if (mhi_cntrl->ee != mhi_chan->ee)
+		return -ENOTCONN;
+
+	mutex_lock(&mhi_chan->mutex);
+	/* client manages channel context for offload channels */
+	if (!mhi_chan->offload_ch) {
+		ret = mhi_init_chan_ctxt(mhi_cntrl, mhi_chan);
+		if (ret)
+			goto error_init_chan;
+	}
+
+	reinit_completion(&mhi_chan->completion);
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		read_unlock_bh(&mhi_cntrl->pm_lock);
+		ret = -EIO;
+		goto error_pm_state;
+	}
+
+	mhi_cntrl->wake_get(mhi_cntrl, false);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+	mhi_cntrl->runtime_get(mhi_cntrl, mhi_cntrl->priv_data);
+	mhi_cntrl->runtime_put(mhi_cntrl, mhi_cntrl->priv_data);
+
+	ret = mhi_send_cmd(mhi_cntrl, mhi_chan, MHI_CMD_START_CHAN);
+	if (ret)
+		goto error_send_cmd;
+
+	ret = wait_for_completion_timeout(&mhi_chan->completion,
+				msecs_to_jiffies(mhi_cntrl->timeout_ms));
+	if (!ret || mhi_chan->ccs != MHI_EV_CC_SUCCESS) {
+		ret = -EIO;
+		goto error_send_cmd;
+	}
+
+	write_lock_irq(&mhi_chan->lock);
+	mhi_chan->ch_state = MHI_CH_STATE_ENABLED;
+	write_unlock_irq(&mhi_chan->lock);
+
+	/* pre allocate buffer for xfer ring */
+	if (mhi_chan->pre_alloc) {
+		int nr_el = get_nr_avail_ring_elements(mhi_cntrl,
+						       &mhi_chan->tre_ring);
+		size_t len = mhi_cntrl->buffer_len;
+
+		while (nr_el--) {
+			void *buf;
+
+			buf = kmalloc(len, GFP_KERNEL);
+			if (!buf) {
+				ret = -ENOMEM;
+				goto error_pre_alloc;
+			}
+
+			/* prepare transfer descriptors */
+			ret = mhi_chan->gen_tre(mhi_cntrl, mhi_chan, buf, buf,
+						len, MHI_EOT);
+			if (ret) {
+				kfree(buf);
+				goto error_pre_alloc;
+			}
+		}
+
+		read_lock_bh(&mhi_cntrl->pm_lock);
+		if (MHI_DB_ACCESS_VALID(mhi_cntrl->pm_state)) {
+			read_lock_irq(&mhi_chan->lock);
+			mhi_ring_chan_db(mhi_cntrl, mhi_chan);
+			read_unlock_irq(&mhi_chan->lock);
+		}
+		read_unlock_bh(&mhi_cntrl->pm_lock);
+	}
+
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	mhi_cntrl->wake_put(mhi_cntrl, false);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	mutex_unlock(&mhi_chan->mutex);
+
+	dev_info(mhi_cntrl->dev, "Chan:%d successfully moved to start state\n",
+		 mhi_chan->chan);
+
+	return 0;
+
+error_send_cmd:
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	mhi_cntrl->wake_put(mhi_cntrl, false);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+error_pm_state:
+	if (!mhi_chan->offload_ch)
+		mhi_deinit_chan_ctxt(mhi_cntrl, mhi_chan);
+
+error_init_chan:
+	mutex_unlock(&mhi_chan->mutex);
+
+	return ret;
+
+error_pre_alloc:
+
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	mhi_cntrl->wake_put(mhi_cntrl, false);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	mutex_unlock(&mhi_chan->mutex);
+	__mhi_unprepare_channel(mhi_cntrl, mhi_chan);
+
+	return ret;
+}
+
+void mhi_reset_chan(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan)
+{
+	struct mhi_tre *dev_rp, *local_rp;
+	struct mhi_event_ctxt *er_ctxt;
+	struct mhi_event *mhi_event;
+	struct mhi_ring *ev_ring, *buf_ring, *tre_ring;
+	unsigned long flags;
+	int chan = mhi_chan->chan;
+	struct mhi_result result;
+
+	/* nothing to reset, client don't queue buffers */
+	if (mhi_chan->offload_ch)
+		return;
+
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	mhi_event = &mhi_cntrl->mhi_event[mhi_chan->er_index];
+	ev_ring = &mhi_event->ring;
+	er_ctxt = &mhi_cntrl->mhi_ctxt->er_ctxt[mhi_chan->er_index];
+
+	/* mark all stale events related to channel as STALE event */
+	spin_lock_irqsave(&mhi_event->lock, flags);
+	dev_rp = mhi_to_virtual(ev_ring, er_ctxt->rp);
+	if (!mhi_event->mhi_chan) {
+		local_rp = ev_ring->rp;
+		while (dev_rp != local_rp) {
+			if (MHI_TRE_GET_EV_TYPE(local_rp) ==
+			    MHI_PKT_TYPE_TX_EVENT &&
+			    chan == MHI_TRE_GET_EV_CHID(local_rp))
+				local_rp->dword[1] = MHI_TRE_EV_DWORD1(chan,
+						MHI_PKT_TYPE_STALE_EVENT);
+			local_rp++;
+			if (local_rp == (ev_ring->base + ev_ring->len))
+				local_rp = ev_ring->base;
+		}
+	} else {
+		/* dedicated event ring so move the ptr to end */
+		ev_ring->rp = dev_rp;
+		ev_ring->wp = ev_ring->rp - ev_ring->el_size;
+		if (ev_ring->wp < ev_ring->base)
+			ev_ring->wp = ev_ring->base + ev_ring->len -
+				ev_ring->el_size;
+		if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl->pm_state)))
+			mhi_ring_er_db(mhi_event);
+	}
+
+	spin_unlock_irqrestore(&mhi_event->lock, flags);
+
+	/* reset any pending buffers */
+	buf_ring = &mhi_chan->buf_ring;
+	tre_ring = &mhi_chan->tre_ring;
+	result.transaction_status = -ENOTCONN;
+	result.bytes_xferd = 0;
+	while (tre_ring->rp != tre_ring->wp) {
+		struct mhi_buf_info *buf_info = buf_ring->rp;
+
+		if (mhi_chan->dir == DMA_TO_DEVICE)
+			mhi_cntrl->wake_put(mhi_cntrl, false);
+
+		mhi_cntrl->unmap_single(mhi_cntrl, buf_info);
+		mhi_del_ring_element(mhi_cntrl, buf_ring);
+		mhi_del_ring_element(mhi_cntrl, tre_ring);
+
+		if (mhi_chan->pre_alloc) {
+			kfree(buf_info->cb_buf);
+		} else {
+			result.buf_addr = buf_info->cb_buf;
+			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
+		}
+	}
+
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+}
+
+/* move channel to start state */
+int mhi_prepare_for_transfer(struct mhi_device *mhi_dev)
+{
+	int ret, dir;
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_chan *mhi_chan;
+
+	for (dir = 0; dir < 2; dir++) {
+		mhi_chan = dir ? mhi_dev->dl_chan : mhi_dev->ul_chan;
+
+		if (!mhi_chan)
+			continue;
+
+		ret = __mhi_prepare_channel(mhi_cntrl, mhi_chan);
+		if (ret)
+			goto error_open_chan;
+	}
+
+	return 0;
+
+error_open_chan:
+	for (--dir; dir >= 0; dir--) {
+		mhi_chan = dir ? mhi_dev->dl_chan : mhi_dev->ul_chan;
+
+		if (!mhi_chan)
+			continue;
+
+		__mhi_unprepare_channel(mhi_cntrl, mhi_chan);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(mhi_prepare_for_transfer);
+
+void mhi_unprepare_from_transfer(struct mhi_device *mhi_dev)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_chan *mhi_chan;
+	int dir;
+
+	for (dir = 0; dir < 2; dir++) {
+		mhi_chan = dir ? mhi_dev->ul_chan : mhi_dev->dl_chan;
+
+		if (!mhi_chan)
+			continue;
+
+		__mhi_unprepare_channel(mhi_cntrl, mhi_chan);
+	}
+}
+EXPORT_SYMBOL(mhi_unprepare_from_transfer);
+
+int mhi_get_no_free_descriptors(struct mhi_device *mhi_dev,
+				enum dma_data_direction dir)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_chan *mhi_chan = (dir == DMA_TO_DEVICE) ?
+		mhi_dev->ul_chan : mhi_dev->dl_chan;
+	struct mhi_ring *tre_ring = &mhi_chan->tre_ring;
+
+	return get_nr_avail_ring_elements(mhi_cntrl, tre_ring);
+}
+EXPORT_SYMBOL(mhi_get_no_free_descriptors);
+
 static int __mhi_bdf_to_controller(struct device *dev, void *tmp)
 {
 	struct mhi_device *mhi_dev = to_mhi_device(dev);
@@ -646,3 +1421,19 @@ struct mhi_controller *mhi_bdf_to_controller(u32 domain,
 	return mhi_dev->mhi_cntrl;
 }
 EXPORT_SYMBOL(mhi_bdf_to_controller);
+
+int mhi_poll(struct mhi_device *mhi_dev,
+	     u32 budget)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_chan *mhi_chan = mhi_dev->dl_chan;
+	struct mhi_event *mhi_event = &mhi_cntrl->mhi_event[mhi_chan->er_index];
+	int ret;
+
+	spin_lock_bh(&mhi_event->lock);
+	ret = mhi_event->process_event(mhi_cntrl, mhi_event, budget);
+	spin_unlock_bh(&mhi_event->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(mhi_poll);
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index ed7cea8..308d12b 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -326,6 +326,29 @@ static inline void *mhi_device_get_devdata(struct mhi_device *mhi_dev)
 	return mhi_dev->priv_data;
 }
 
+/**
+ * mhi_queue_transfer - Queue a buffer to hardware
+ * All transfers are asyncronous transfers
+ * @mhi_dev: Device associated with the channels
+ * @dir: Data direction
+ * @buf: Data buffer (skb for hardware channels)
+ * @len: Size in bytes
+ * @mflags: Interrupt flags for the device
+ */
+static inline int mhi_queue_transfer(struct mhi_device *mhi_dev,
+				     enum dma_data_direction dir,
+				     void *buf,
+				     size_t len,
+				     enum MHI_FLAGS mflags)
+{
+	if (dir == DMA_TO_DEVICE)
+		return mhi_dev->ul_xfer(mhi_dev, mhi_dev->ul_chan, buf, len,
+					mflags);
+	else
+		return mhi_dev->dl_xfer(mhi_dev, mhi_dev->dl_chan, buf, len,
+					mflags);
+}
+
 static inline void *mhi_controller_get_devdata(struct mhi_controller *mhi_cntrl)
 {
 	return mhi_cntrl->priv_data;
@@ -349,6 +372,21 @@ static inline void mhi_free_controller(struct mhi_controller *mhi_cntrl)
 void mhi_driver_unregister(struct mhi_driver *mhi_drv);
 
 /**
+ * mhi_device_configure - configure ECA or CCA context
+ * For offload channels that client manage, call this
+ * function to configure channel context or event context
+ * array associated with the channel
+ * @mhi_div: Device associated with the channels
+ * @dir: Direction of the channel
+ * @mhi_buf: Configuration data
+ * @elements: # of configuration elements
+ */
+int mhi_device_configure(struct mhi_device *mhi_div,
+			 enum dma_data_direction dir,
+			 struct mhi_buf *mhi_buf,
+			 int elements);
+
+/**
  * mhi_device_get - disable all low power modes
  * Only disables lpm, does not immediately exit low power mode
  * if controller already in a low power mode
@@ -371,6 +409,46 @@ static inline void mhi_free_controller(struct mhi_controller *mhi_cntrl)
 void mhi_device_put(struct mhi_device *mhi_dev);
 
 /**
+ * mhi_prepare_for_transfer - setup channel for data transfer
+ * Moves both UL and DL channel from RESET to START state
+ * @mhi_dev: Device associated with the channels
+ */
+int mhi_prepare_for_transfer(struct mhi_device *mhi_dev);
+
+/**
+ * mhi_unprepare_from_transfer -unprepare the channels
+ * Moves both UL and DL channels to RESET state
+ * @mhi_dev: Device associated with the channels
+ */
+void mhi_unprepare_from_transfer(struct mhi_device *mhi_dev);
+
+/**
+ * mhi_get_no_free_descriptors - Get transfer ring length
+ * Get # of TD available to queue buffers
+ * @mhi_dev: Device associated with the channels
+ * @dir: Direction of the channel
+ */
+int mhi_get_no_free_descriptors(struct mhi_device *mhi_dev,
+				enum dma_data_direction dir);
+
+/**
+ * mhi_poll - poll for any available data to consume
+ * This is only applicable for DL direction
+ * @mhi_dev: Device associated with the channels
+ * @budget: In descriptors to service before returning
+ */
+int mhi_poll(struct mhi_device *mhi_dev, u32 budget);
+
+/**
+ * mhi_ioctl - user space IOCTL support for MHI channels
+ * Native support for setting  TIOCM
+ * @mhi_dev: Device associated with the channels
+ * @cmd: IOCTL cmd
+ * @arg: Optional parameter, iotcl cmd specific
+ */
+long mhi_ioctl(struct mhi_device *mhi_dev, unsigned int cmd, unsigned long arg);
+
+/**
  * mhi_alloc_controller - Allocate mhi_controller structure
  * Allocate controller structure and additional data for controller
  * private data. You may get the private data pointer by calling
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


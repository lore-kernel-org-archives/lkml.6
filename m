Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EC4C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39716214C2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="okjt7qQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39716214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731310AbeJICAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:00:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbeJICAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:00:06 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C13E214C5;
        Mon,  8 Oct 2018 18:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024419;
        bh=31akmiuRbVUM5/fblvwkPyMFeLVT4qPKmwXmnuehncA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=okjt7qQO0hfLcE+LAinmwlfylAsyTLanGxw6uad9ayDelcZXu4FTgLSZV359ltktg
         fbhNDWz4RNxHb03qHwwMgf5sgREUjOm9a5r651uWW3d7nSjUdHJdsPiYthPlIDCQgp
         vaqts5yoPE+/FhNx0jVXmx20fbM40WSmWBWufxqc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peng Li <lipeng321@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 032/168] net: hns: add the code for cleaning pkt in chip
Date:   Mon,  8 Oct 2018 20:30:12 +0200
Message-Id: <20181008175621.268395199@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peng Li <lipeng321@huawei.com>

[ Upstream commit 31fabbee8f5c658c3fa1603c66e9e4f51ea8c2c6 ]

If there are packets in hardware when changing the speed
or duplex, it may cause hardware hang up.

This patch adds the code for waiting chip to clean the all
pkts(TX & RX) in chip when the driver uses the function named
"adjust link".

This patch cleans the pkts as follows:
1) close rx of chip, close tx of protocol stack.
2) wait rcb, ppe, mac to clean.
3) adjust link
4) open rx of chip, open tx of protocol stack.

Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns/hnae.h          |    2 
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c  |   67 ++++++++++++++++++++-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c |   36 +++++++++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c  |   44 +++++++++++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h  |    8 ++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c |   29 +++++++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h |    3 
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c  |   23 +++++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h  |    1 
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c  |   23 +++++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h  |    1 
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h  |    1 
 drivers/net/ethernet/hisilicon/hns/hns_enet.c      |   21 +++++-
 13 files changed, 255 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/hisilicon/hns/hnae.h
+++ b/drivers/net/ethernet/hisilicon/hns/hnae.h
@@ -486,6 +486,8 @@ struct hnae_ae_ops {
 			u8 *auto_neg, u16 *speed, u8 *duplex);
 	void (*toggle_ring_irq)(struct hnae_ring *ring, u32 val);
 	void (*adjust_link)(struct hnae_handle *handle, int speed, int duplex);
+	bool (*need_adjust_link)(struct hnae_handle *handle,
+				 int speed, int duplex);
 	int (*set_loopback)(struct hnae_handle *handle,
 			    enum hnae_loop loop_mode, int en);
 	void (*get_ring_bdnum_limit)(struct hnae_queue *queue,
--- a/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
@@ -155,6 +155,41 @@ static void hns_ae_put_handle(struct hna
 		hns_ae_get_ring_pair(handle->qs[i])->used_by_vf = 0;
 }
 
+static int hns_ae_wait_flow_down(struct hnae_handle *handle)
+{
+	struct dsaf_device *dsaf_dev;
+	struct hns_ppe_cb *ppe_cb;
+	struct hnae_vf_cb *vf_cb;
+	int ret;
+	int i;
+
+	for (i = 0; i < handle->q_num; i++) {
+		ret = hns_rcb_wait_tx_ring_clean(handle->qs[i]);
+		if (ret)
+			return ret;
+	}
+
+	ppe_cb = hns_get_ppe_cb(handle);
+	ret = hns_ppe_wait_tx_fifo_clean(ppe_cb);
+	if (ret)
+		return ret;
+
+	dsaf_dev = hns_ae_get_dsaf_dev(handle->dev);
+	if (!dsaf_dev)
+		return -EINVAL;
+	ret = hns_dsaf_wait_pkt_clean(dsaf_dev, handle->dport_id);
+	if (ret)
+		return ret;
+
+	vf_cb = hns_ae_get_vf_cb(handle);
+	ret = hns_mac_wait_fifo_clean(vf_cb->mac_cb);
+	if (ret)
+		return ret;
+
+	mdelay(10);
+	return 0;
+}
+
 static void hns_ae_ring_enable_all(struct hnae_handle *handle, int val)
 {
 	int q_num = handle->q_num;
@@ -399,12 +434,41 @@ static int hns_ae_get_mac_info(struct hn
 	return hns_mac_get_port_info(mac_cb, auto_neg, speed, duplex);
 }
 
+static bool hns_ae_need_adjust_link(struct hnae_handle *handle, int speed,
+				    int duplex)
+{
+	struct hns_mac_cb *mac_cb = hns_get_mac_cb(handle);
+
+	return hns_mac_need_adjust_link(mac_cb, speed, duplex);
+}
+
 static void hns_ae_adjust_link(struct hnae_handle *handle, int speed,
 			       int duplex)
 {
 	struct hns_mac_cb *mac_cb = hns_get_mac_cb(handle);
 
-	hns_mac_adjust_link(mac_cb, speed, duplex);
+	switch (mac_cb->dsaf_dev->dsaf_ver) {
+	case AE_VERSION_1:
+		hns_mac_adjust_link(mac_cb, speed, duplex);
+		break;
+
+	case AE_VERSION_2:
+		/* chip need to clear all pkt inside */
+		hns_mac_disable(mac_cb, MAC_COMM_MODE_RX);
+		if (hns_ae_wait_flow_down(handle)) {
+			hns_mac_enable(mac_cb, MAC_COMM_MODE_RX);
+			break;
+		}
+
+		hns_mac_adjust_link(mac_cb, speed, duplex);
+		hns_mac_enable(mac_cb, MAC_COMM_MODE_RX);
+		break;
+
+	default:
+		break;
+	}
+
+	return;
 }
 
 static void hns_ae_get_ring_bdnum_limit(struct hnae_queue *queue,
@@ -902,6 +966,7 @@ static struct hnae_ae_ops hns_dsaf_ops =
 	.get_status = hns_ae_get_link_status,
 	.get_info = hns_ae_get_mac_info,
 	.adjust_link = hns_ae_adjust_link,
+	.need_adjust_link = hns_ae_need_adjust_link,
 	.set_loopback = hns_ae_config_loopback,
 	.get_ring_bdnum_limit = hns_ae_get_ring_bdnum_limit,
 	.get_pauseparam = hns_ae_get_pauseparam,
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
@@ -257,6 +257,16 @@ static void hns_gmac_get_pausefrm_cfg(vo
 	*tx_pause_en = dsaf_get_bit(pause_en, GMAC_PAUSE_EN_TX_FDFC_B);
 }
 
+static bool hns_gmac_need_adjust_link(void *mac_drv, enum mac_speed speed,
+				      int duplex)
+{
+	struct mac_driver *drv = (struct mac_driver *)mac_drv;
+	struct hns_mac_cb *mac_cb = drv->mac_cb;
+
+	return (mac_cb->speed != speed) ||
+		(mac_cb->half_duplex == duplex);
+}
+
 static int hns_gmac_adjust_link(void *mac_drv, enum mac_speed speed,
 				u32 full_duplex)
 {
@@ -309,6 +319,30 @@ static void hns_gmac_set_promisc(void *m
 		hns_gmac_set_uc_match(mac_drv, en);
 }
 
+int hns_gmac_wait_fifo_clean(void *mac_drv)
+{
+	struct mac_driver *drv = (struct mac_driver *)mac_drv;
+	int wait_cnt;
+	u32 val;
+
+	wait_cnt = 0;
+	while (wait_cnt++ < HNS_MAX_WAIT_CNT) {
+		val = dsaf_read_dev(drv, GMAC_FIFO_STATE_REG);
+		/* bit5~bit0 is not send complete pkts */
+		if ((val & 0x3f) == 0)
+			break;
+		usleep_range(100, 200);
+	}
+
+	if (wait_cnt >= HNS_MAX_WAIT_CNT) {
+		dev_err(drv->dev,
+			"hns ge %d fifo was not idle.\n", drv->mac_id);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
 static void hns_gmac_init(void *mac_drv)
 {
 	u32 port;
@@ -690,6 +724,7 @@ void *hns_gmac_config(struct hns_mac_cb
 	mac_drv->mac_disable = hns_gmac_disable;
 	mac_drv->mac_free = hns_gmac_free;
 	mac_drv->adjust_link = hns_gmac_adjust_link;
+	mac_drv->need_adjust_link = hns_gmac_need_adjust_link;
 	mac_drv->set_tx_auto_pause_frames = hns_gmac_set_tx_auto_pause_frames;
 	mac_drv->config_max_frame_length = hns_gmac_config_max_frame_length;
 	mac_drv->mac_pausefrm_cfg = hns_gmac_pause_frm_cfg;
@@ -717,6 +752,7 @@ void *hns_gmac_config(struct hns_mac_cb
 	mac_drv->get_strings = hns_gmac_get_strings;
 	mac_drv->update_stats = hns_gmac_update_stats;
 	mac_drv->set_promiscuous = hns_gmac_set_promisc;
+	mac_drv->wait_fifo_clean = hns_gmac_wait_fifo_clean;
 
 	return (void *)mac_drv;
 }
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
@@ -114,6 +114,26 @@ int hns_mac_get_port_info(struct hns_mac
 	return 0;
 }
 
+/**
+ *hns_mac_is_adjust_link - check is need change mac speed and duplex register
+ *@mac_cb: mac device
+ *@speed: phy device speed
+ *@duplex:phy device duplex
+ *
+ */
+bool hns_mac_need_adjust_link(struct hns_mac_cb *mac_cb, int speed, int duplex)
+{
+	struct mac_driver *mac_ctrl_drv;
+
+	mac_ctrl_drv = (struct mac_driver *)(mac_cb->priv.mac);
+
+	if (mac_ctrl_drv->need_adjust_link)
+		return mac_ctrl_drv->need_adjust_link(mac_ctrl_drv,
+			(enum mac_speed)speed, duplex);
+	else
+		return true;
+}
+
 void hns_mac_adjust_link(struct hns_mac_cb *mac_cb, int speed, int duplex)
 {
 	int ret;
@@ -430,6 +450,16 @@ int hns_mac_vm_config_bc_en(struct hns_m
 	return 0;
 }
 
+int hns_mac_wait_fifo_clean(struct hns_mac_cb *mac_cb)
+{
+	struct mac_driver *drv = hns_mac_get_drv(mac_cb);
+
+	if (drv->wait_fifo_clean)
+		return drv->wait_fifo_clean(drv);
+
+	return 0;
+}
+
 void hns_mac_reset(struct hns_mac_cb *mac_cb)
 {
 	struct mac_driver *drv = hns_mac_get_drv(mac_cb);
@@ -999,6 +1029,20 @@ static int hns_mac_get_max_port_num(stru
 		return  DSAF_MAX_PORT_NUM;
 }
 
+void hns_mac_enable(struct hns_mac_cb *mac_cb, enum mac_commom_mode mode)
+{
+	struct mac_driver *mac_ctrl_drv = hns_mac_get_drv(mac_cb);
+
+	mac_ctrl_drv->mac_enable(mac_cb->priv.mac, mode);
+}
+
+void hns_mac_disable(struct hns_mac_cb *mac_cb, enum mac_commom_mode mode)
+{
+	struct mac_driver *mac_ctrl_drv = hns_mac_get_drv(mac_cb);
+
+	mac_ctrl_drv->mac_disable(mac_cb->priv.mac, mode);
+}
+
 /**
  * hns_mac_init - init mac
  * @dsaf_dev: dsa fabric device struct pointer
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h
@@ -356,6 +356,9 @@ struct mac_driver {
 	/*adjust mac mode of port,include speed and duplex*/
 	int (*adjust_link)(void *mac_drv, enum mac_speed speed,
 			   u32 full_duplex);
+	/* need adjust link */
+	bool (*need_adjust_link)(void *mac_drv, enum mac_speed speed,
+				 int duplex);
 	/* config autoegotaite mode of port*/
 	void (*set_an_mode)(void *mac_drv, u8 enable);
 	/* config loopbank mode */
@@ -394,6 +397,7 @@ struct mac_driver {
 	void (*get_info)(void *mac_drv, struct mac_info *mac_info);
 
 	void (*update_stats)(void *mac_drv);
+	int (*wait_fifo_clean)(void *mac_drv);
 
 	enum mac_mode mac_mode;
 	u8 mac_id;
@@ -427,6 +431,7 @@ void *hns_xgmac_config(struct hns_mac_cb
 
 int hns_mac_init(struct dsaf_device *dsaf_dev);
 void mac_adjust_link(struct net_device *net_dev);
+bool hns_mac_need_adjust_link(struct hns_mac_cb *mac_cb, int speed, int duplex);
 void hns_mac_get_link_status(struct hns_mac_cb *mac_cb,	u32 *link_status);
 int hns_mac_change_vf_addr(struct hns_mac_cb *mac_cb, u32 vmid, char *addr);
 int hns_mac_set_multi(struct hns_mac_cb *mac_cb,
@@ -463,5 +468,8 @@ int hns_mac_add_uc_addr(struct hns_mac_c
 int hns_mac_rm_uc_addr(struct hns_mac_cb *mac_cb, u8 vf_id,
 		       const unsigned char *addr);
 int hns_mac_clr_multicast(struct hns_mac_cb *mac_cb, int vfn);
+void hns_mac_enable(struct hns_mac_cb *mac_cb, enum mac_commom_mode mode);
+void hns_mac_disable(struct hns_mac_cb *mac_cb, enum mac_commom_mode mode);
+int hns_mac_wait_fifo_clean(struct hns_mac_cb *mac_cb);
 
 #endif /* _HNS_DSAF_MAC_H */
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
@@ -2733,6 +2733,35 @@ void hns_dsaf_set_promisc_tcam(struct ds
 	soft_mac_entry->index = enable ? entry_index : DSAF_INVALID_ENTRY_IDX;
 }
 
+int hns_dsaf_wait_pkt_clean(struct dsaf_device *dsaf_dev, int port)
+{
+	u32 val, val_tmp;
+	int wait_cnt;
+
+	if (port >= DSAF_SERVICE_NW_NUM)
+		return 0;
+
+	wait_cnt = 0;
+	while (wait_cnt++ < HNS_MAX_WAIT_CNT) {
+		val = dsaf_read_dev(dsaf_dev, DSAF_VOQ_IN_PKT_NUM_0_REG +
+			(port + DSAF_XGE_NUM) * 0x40);
+		val_tmp = dsaf_read_dev(dsaf_dev, DSAF_VOQ_OUT_PKT_NUM_0_REG +
+			(port + DSAF_XGE_NUM) * 0x40);
+		if (val == val_tmp)
+			break;
+
+		usleep_range(100, 200);
+	}
+
+	if (wait_cnt >= HNS_MAX_WAIT_CNT) {
+		dev_err(dsaf_dev->dev, "hns dsaf clean wait timeout(%u - %u).\n",
+			val, val_tmp);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
 /**
  * dsaf_probe - probo dsaf dev
  * @pdev: dasf platform device
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
@@ -44,6 +44,8 @@ struct hns_mac_cb;
 #define DSAF_ROCE_CREDIT_CHN	8
 #define DSAF_ROCE_CHAN_MODE	3
 
+#define HNS_MAX_WAIT_CNT 10000
+
 enum dsaf_roce_port_mode {
 	DSAF_ROCE_6PORT_MODE,
 	DSAF_ROCE_4PORT_MODE,
@@ -463,5 +465,6 @@ int hns_dsaf_rm_mac_addr(
 
 int hns_dsaf_clr_mac_mc_port(struct dsaf_device *dsaf_dev,
 			     u8 mac_id, u8 port_num);
+int hns_dsaf_wait_pkt_clean(struct dsaf_device *dsaf_dev, int port);
 
 #endif /* __HNS_DSAF_MAIN_H__ */
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
@@ -274,6 +274,29 @@ static void hns_ppe_exc_irq_en(struct hn
 	dsaf_write_dev(ppe_cb, PPE_INTEN_REG, msk_vlue & vld_msk);
 }
 
+int hns_ppe_wait_tx_fifo_clean(struct hns_ppe_cb *ppe_cb)
+{
+	int wait_cnt;
+	u32 val;
+
+	wait_cnt = 0;
+	while (wait_cnt++ < HNS_MAX_WAIT_CNT) {
+		val = dsaf_read_dev(ppe_cb, PPE_CURR_TX_FIFO0_REG) & 0x3ffU;
+		if (!val)
+			break;
+
+		usleep_range(100, 200);
+	}
+
+	if (wait_cnt >= HNS_MAX_WAIT_CNT) {
+		dev_err(ppe_cb->dev, "hns ppe tx fifo clean wait timeout, still has %u pkt.\n",
+			val);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
 /**
  * ppe_init_hw - init ppe
  * @ppe_cb: ppe device
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h
@@ -100,6 +100,7 @@ struct ppe_common_cb {
 
 };
 
+int hns_ppe_wait_tx_fifo_clean(struct hns_ppe_cb *ppe_cb);
 int hns_ppe_init(struct dsaf_device *dsaf_dev);
 
 void hns_ppe_uninit(struct dsaf_device *dsaf_dev);
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
@@ -66,6 +66,29 @@ void hns_rcb_wait_fbd_clean(struct hnae_
 			"queue(%d) wait fbd(%d) clean fail!!\n", i, fbd_num);
 }
 
+int hns_rcb_wait_tx_ring_clean(struct hnae_queue *qs)
+{
+	u32 head, tail;
+	int wait_cnt;
+
+	tail = dsaf_read_dev(&qs->tx_ring, RCB_REG_TAIL);
+	wait_cnt = 0;
+	while (wait_cnt++ < HNS_MAX_WAIT_CNT) {
+		head = dsaf_read_dev(&qs->tx_ring, RCB_REG_HEAD);
+		if (tail == head)
+			break;
+
+		usleep_range(100, 200);
+	}
+
+	if (wait_cnt >= HNS_MAX_WAIT_CNT) {
+		dev_err(qs->dev->dev, "rcb wait timeout, head not equal to tail.\n");
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
 /**
  *hns_rcb_reset_ring_hw - ring reset
  *@q: ring struct pointer
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h
@@ -136,6 +136,7 @@ void hns_rcbv2_int_clr_hw(struct hnae_qu
 void hns_rcb_init_hw(struct ring_pair_cb *ring);
 void hns_rcb_reset_ring_hw(struct hnae_queue *q);
 void hns_rcb_wait_fbd_clean(struct hnae_queue **qs, int q_num, u32 flag);
+int hns_rcb_wait_tx_ring_clean(struct hnae_queue *qs);
 u32 hns_rcb_get_rx_coalesced_frames(
 	struct rcb_common_cb *rcb_common, u32 port_idx);
 u32 hns_rcb_get_tx_coalesced_frames(
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h
@@ -464,6 +464,7 @@
 #define RCB_RING_INTMSK_TX_OVERTIME_REG		0x000C4
 #define RCB_RING_INTSTS_TX_OVERTIME_REG		0x000C8
 
+#define GMAC_FIFO_STATE_REG			0x0000UL
 #define GMAC_DUPLEX_TYPE_REG			0x0008UL
 #define GMAC_FD_FC_TYPE_REG			0x000CUL
 #define GMAC_TX_WATER_LINE_REG			0x0010UL
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -1212,11 +1212,26 @@ static void hns_nic_adjust_link(struct n
 	struct hnae_handle *h = priv->ae_handle;
 	int state = 1;
 
+	/* If there is no phy, do not need adjust link */
 	if (ndev->phydev) {
-		h->dev->ops->adjust_link(h, ndev->phydev->speed,
-					 ndev->phydev->duplex);
-		state = ndev->phydev->link;
+		/* When phy link down, do nothing */
+		if (ndev->phydev->link == 0)
+			return;
+
+		if (h->dev->ops->need_adjust_link(h, ndev->phydev->speed,
+						  ndev->phydev->duplex)) {
+			/* because Hi161X chip don't support to change gmac
+			 * speed and duplex with traffic. Delay 200ms to
+			 * make sure there is no more data in chip FIFO.
+			 */
+			netif_carrier_off(ndev);
+			msleep(200);
+			h->dev->ops->adjust_link(h, ndev->phydev->speed,
+						 ndev->phydev->duplex);
+			netif_carrier_on(ndev);
+		}
 	}
+
 	state = state && h->dev->ops->get_status(h);
 
 	if (state != priv->link) {



Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E22EC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 23:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B261A213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 23:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QOpUAfcO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B261A213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbeJFGhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 02:37:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38290 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbeJFGhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 02:37:01 -0400
Received: by mail-pf1-f193.google.com with SMTP id f29-v6so2888932pff.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 16:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=GaoCLYzUb0Hh3RqtRA4wV8vIvH60MYCEpHgXwdfb5VQ=;
        b=QOpUAfcODgkFZtJ75KtYSfZhfU9yguIKrbfQF+TmQRRsjldCKILHfKBPQkYNXb29RY
         Eq3Imbt0Ec/aeDqZdEBBusgCy7qWo7oyi87VgW3JWYzs45U2dGbVn40VmwiDK6UcdZOS
         F9XEAGolIKZgqJTfN5SW3FxzqqHZpGaBO4s28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=GaoCLYzUb0Hh3RqtRA4wV8vIvH60MYCEpHgXwdfb5VQ=;
        b=or4CQsxPET6rFORtdbPNy9fuFcxELTh8Ljl8NJZQToGRQiSHW2n8XV117NlEnfr6Xd
         puI2qfkXzAAtPhJN4FNCzGtX16t2sVZqUsR9Cx7LwQVjkOgKt8eWcPe+TW+5kvUPsB5q
         swAIgY7uV6f8/VPZOYdidUgAcZk7Dp/I+dOhSSLIhPlx1QErCLKaCTj35vSBdUBtfri4
         ZRBfCPDbXAZvg79WMVeuvZ53UzGlX5E1MinhTJFTBLMSOUrTr8E3iJwTsAUMOxZcClGO
         NGy3j4r5XxCG7jdrBmNhK6fZp+Uonb+7GpkS1EymVlCNOSslaRKMWdHljt90VBaJqxoz
         wKaA==
X-Gm-Message-State: ABuFfohkNU7LLctRsXk3bZ+EblUehRllFjJxwpnzVwWJ8RS8FcQh/O1e
        BSwy35ZEmn9OITYUSVdRVBDxbA==
X-Google-Smtp-Source: ACcGV625veJ22bFwMgFGaUOdN7BkJ+J3IOYWQlAWPYy2sbkcE+aXXJUW79oAtqKVlGYhNkVScngoow==
X-Received: by 2002:a63:8742:: with SMTP id i63-v6mr11993548pge.27.1538782562571;
        Fri, 05 Oct 2018 16:36:02 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id y19-v6sm18618491pff.14.2018.10.05.16.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 16:36:00 -0700 (PDT)
Date:   Fri, 5 Oct 2018 16:35:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v4.19-rc7] treewide: Replace more open-coded allocation size
 multiplications
Message-ID: <20181005233559.GA37919@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As done treewide earlier, this catches several more open-coded
allocation size calculations that were added to the kernel during the
merge window. This performs the following mechanical transformations
using Coccinelle:

	kvmalloc(a * b, ...) -> kvmalloc_array(a, b, ...)
	kvzalloc(a * b, ...) -> kvcalloc(a, b, ...)
	devm_kzalloc(..., a * b, ...) -> devm_kcalloc(..., a, b, ...)

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/bluetooth/hci_qca.c                 |  2 +-
 drivers/crypto/inside-secure/safexcel.c     |  8 +++++---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c     |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_io_util.c |  4 ++--
 drivers/hwmon/npcm750-pwm-fan.c             |  2 +-
 drivers/md/dm-integrity.c                   |  3 ++-
 drivers/net/wireless/mediatek/mt76/usb.c    | 10 +++++-----
 drivers/pci/controller/pcie-cadence.c       |  4 ++--
 drivers/tty/serial/qcom_geni_serial.c       |  4 ++--
 net/sched/sch_cake.c                        |  2 +-
 10 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index e182f6019f68..2fee65886d50 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1322,7 +1322,7 @@ static int qca_init_regulators(struct qca_power *qca,
 {
 	int i;
 
-	qca->vreg_bulk = devm_kzalloc(qca->dev, num_vregs *
+	qca->vreg_bulk = devm_kcalloc(qca->dev, num_vregs,
 				      sizeof(struct regulator_bulk_data),
 				      GFP_KERNEL);
 	if (!qca->vreg_bulk)
diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
index 7e71043457a6..86c699c14f84 100644
--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -1044,7 +1044,8 @@ static int safexcel_probe(struct platform_device *pdev)
 
 	safexcel_configure(priv);
 
-	priv->ring = devm_kzalloc(dev, priv->config.rings * sizeof(*priv->ring),
+	priv->ring = devm_kcalloc(dev, priv->config.rings,
+				  sizeof(*priv->ring),
 				  GFP_KERNEL);
 	if (!priv->ring) {
 		ret = -ENOMEM;
@@ -1063,8 +1064,9 @@ static int safexcel_probe(struct platform_device *pdev)
 		if (ret)
 			goto err_reg_clk;
 
-		priv->ring[i].rdr_req = devm_kzalloc(dev,
-			sizeof(priv->ring[i].rdr_req) * EIP197_DEFAULT_RING_SIZE,
+		priv->ring[i].rdr_req = devm_kcalloc(dev,
+			EIP197_DEFAULT_RING_SIZE,
+			sizeof(priv->ring[i].rdr_req),
 			GFP_KERNEL);
 		if (!priv->ring[i].rdr_req) {
 			ret = -ENOMEM;
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 0b976dfd04df..92ecb9bf982c 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -600,7 +600,7 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 	}
 
 	mtk_crtc->layer_nr = mtk_ddp_comp_layer_nr(mtk_crtc->ddp_comp[0]);
-	mtk_crtc->planes = devm_kzalloc(dev, mtk_crtc->layer_nr *
+	mtk_crtc->planes = devm_kcalloc(dev, mtk_crtc->layer_nr,
 					sizeof(struct drm_plane),
 					GFP_KERNEL);
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_io_util.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_io_util.c
index 790d39f816dc..b557687b1964 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_io_util.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_io_util.c
@@ -153,8 +153,8 @@ int msm_dss_parse_clock(struct platform_device *pdev,
 		return 0;
 	}
 
-	mp->clk_config = devm_kzalloc(&pdev->dev,
-				      sizeof(struct dss_clk) * num_clk,
+	mp->clk_config = devm_kcalloc(&pdev->dev,
+				      num_clk, sizeof(struct dss_clk),
 				      GFP_KERNEL);
 	if (!mp->clk_config)
 		return -ENOMEM;
diff --git a/drivers/hwmon/npcm750-pwm-fan.c b/drivers/hwmon/npcm750-pwm-fan.c
index 8474d601aa63..b998f9fbed41 100644
--- a/drivers/hwmon/npcm750-pwm-fan.c
+++ b/drivers/hwmon/npcm750-pwm-fan.c
@@ -908,7 +908,7 @@ static int npcm7xx_en_pwm_fan(struct device *dev,
 	if (fan_cnt < 1)
 		return -EINVAL;
 
-	fan_ch = devm_kzalloc(dev, sizeof(*fan_ch) * fan_cnt, GFP_KERNEL);
+	fan_ch = devm_kcalloc(dev, fan_cnt, sizeof(*fan_ch), GFP_KERNEL);
 	if (!fan_ch)
 		return -ENOMEM;
 
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 89ccb64342de..e1fa6baf4e8e 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -3462,7 +3462,8 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 			r = -ENOMEM;
 			goto bad;
 		}
-		ic->recalc_tags = kvmalloc((RECALC_SECTORS >> ic->sb->log2_sectors_per_block) * ic->tag_size, GFP_KERNEL);
+		ic->recalc_tags = kvmalloc_array(RECALC_SECTORS >> ic->sb->log2_sectors_per_block,
+						 ic->tag_size, GFP_KERNEL);
 		if (!ic->recalc_tags) {
 			ti->error = "Cannot allocate tags for recalculating";
 			r = -ENOMEM;
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 7780b07543bb..79e59f2379a2 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -258,7 +258,7 @@ int mt76u_buf_alloc(struct mt76_dev *dev, struct mt76u_buf *buf,
 	if (!buf->urb)
 		return -ENOMEM;
 
-	buf->urb->sg = devm_kzalloc(dev->dev, nsgs * sizeof(*buf->urb->sg),
+	buf->urb->sg = devm_kcalloc(dev->dev, nsgs, sizeof(*buf->urb->sg),
 				    gfp);
 	if (!buf->urb->sg)
 		return -ENOMEM;
@@ -464,8 +464,8 @@ static int mt76u_alloc_rx(struct mt76_dev *dev)
 	int i, err, nsgs;
 
 	spin_lock_init(&q->lock);
-	q->entry = devm_kzalloc(dev->dev,
-				MT_NUM_RX_ENTRIES * sizeof(*q->entry),
+	q->entry = devm_kcalloc(dev->dev,
+				MT_NUM_RX_ENTRIES, sizeof(*q->entry),
 				GFP_KERNEL);
 	if (!q->entry)
 		return -ENOMEM;
@@ -717,8 +717,8 @@ static int mt76u_alloc_tx(struct mt76_dev *dev)
 		INIT_LIST_HEAD(&q->swq);
 		q->hw_idx = q2hwq(i);
 
-		q->entry = devm_kzalloc(dev->dev,
-					MT_NUM_TX_ENTRIES * sizeof(*q->entry),
+		q->entry = devm_kcalloc(dev->dev,
+					MT_NUM_TX_ENTRIES, sizeof(*q->entry),
 					GFP_KERNEL);
 		if (!q->entry)
 			return -ENOMEM;
diff --git a/drivers/pci/controller/pcie-cadence.c b/drivers/pci/controller/pcie-cadence.c
index 86f1b002c846..975bcdd6b5c0 100644
--- a/drivers/pci/controller/pcie-cadence.c
+++ b/drivers/pci/controller/pcie-cadence.c
@@ -180,11 +180,11 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 		return 0;
 	}
 
-	phy = devm_kzalloc(dev, sizeof(*phy) * phy_count, GFP_KERNEL);
+	phy = devm_kcalloc(dev, phy_count, sizeof(*phy), GFP_KERNEL);
 	if (!phy)
 		return -ENOMEM;
 
-	link = devm_kzalloc(dev, sizeof(*link) * phy_count, GFP_KERNEL);
+	link = devm_kcalloc(dev, phy_count, sizeof(*link), GFP_KERNEL);
 	if (!link)
 		return -ENOMEM;
 
diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 29ec34387246..1515074e18fb 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -868,8 +868,8 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
 	geni_se_init(&port->se, port->rx_wm, port->rx_rfr);
 	geni_se_select_mode(&port->se, port->xfer_mode);
 	if (!uart_console(uport)) {
-		port->rx_fifo = devm_kzalloc(uport->dev,
-			port->rx_fifo_depth * sizeof(u32), GFP_KERNEL);
+		port->rx_fifo = devm_kcalloc(uport->dev,
+			port->rx_fifo_depth, sizeof(u32), GFP_KERNEL);
 		if (!port->rx_fifo)
 			return -ENOMEM;
 	}
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index c07c30b916d5..793016d722ec 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -2644,7 +2644,7 @@ static int cake_init(struct Qdisc *sch, struct nlattr *opt,
 	for (i = 1; i <= CAKE_QUEUES; i++)
 		quantum_div[i] = 65535 / i;
 
-	q->tins = kvzalloc(CAKE_MAX_TINS * sizeof(struct cake_tin_data),
+	q->tins = kvcalloc(CAKE_MAX_TINS, sizeof(struct cake_tin_data),
 			   GFP_KERNEL);
 	if (!q->tins)
 		goto nomem;
-- 
2.17.1


-- 
Kees Cook
Pixel Security

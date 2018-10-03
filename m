Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70AAC65BAA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 03:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF6F20644
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 03:42:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF6F20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbeJCK2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 06:28:44 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:51858 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726755AbeJCK2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 06:28:43 -0400
X-UUID: 87a6177d19b7415cbe2f4b9b92318249-20181003
X-UUID: 87a6177d19b7415cbe2f4b9b92318249-20181003
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1107484080; Wed, 03 Oct 2018 11:41:57 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 3 Oct 2018 11:41:52 +0800
Received: from mtkslt209.mediatek.inc (10.21.15.96) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 3 Oct 2018 11:41:52 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Cawa Cheng <cawa.cheng@mediatek.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        YT Shen <yt.shen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        CK Hu <ck.hu@mediatek.com>, Mao Huang <littlecvr@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        chunhui dai <chunhui.dai@mediatek.com>
Subject: [PATCH v5 01/11] drm/mediatek: add refcount for DPI power on/off
Date:   Wed, 3 Oct 2018 11:41:41 +0800
Message-ID: <20181003034151.31452-2-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.12.5.2.gbdf23ab
In-Reply-To: <20181003034151.31452-1-bibby.hsieh@mediatek.com>
References: <20181003034151.31452-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F2AA8FCF95BECA976623B48750DB52AC5873E2628E581D54FFBF8BE689C2A7982000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chunhui dai <chunhui.dai@mediatek.com>

After the kernel 4.4, the DRM disable flow was changed, if DPI was
disableed before CRTC, it will cause warning message as following:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1339 at ../../linux/linux-4.4.24-mtk/drivers/gpu/drm/drm_irq.c:1326 drm_wait_one_vblank+0x188/0x18c()
vblank wait timed out on crtc 0
Modules linked in: bridge mt8521p_ir_shim(O) i2c_eeprom(O) mtk_m4(O) fuse_ctrl(O) virtual_block(O) caamkeys(PO) chk(PO) amperctl(O) ledctl(O) apple_auth(PO) micctl(O) sensors(PO) lla(O) sdd(PO) ice40_fpga(O) psmon(O) event_queue(PO) utils(O) blackbox(O)
CPU: 0 PID: 1339 Comm: kworker/0:1 Tainted: P        W  O    4.4.24 #1
Hardware name: Mediatek Cortex-A7 (Device Tree)
Workqueue: events drm_mode_rmfb_work_fn
[<c001a710>] (unwind_backtrace) from [<c00151e4>] (show_stack+0x20/0x24)
[<c00151e4>] (show_stack) from [<c027961c>] (dump_stack+0x98/0xac)
[<c027961c>] (dump_stack) from [<c002ac54>] (warn_slowpath_common+0x94/0xc4)
[<c002ac54>] (warn_slowpath_common) from [<c002acc4>] (warn_slowpath_fmt+0x40/0x48)
[<c002acc4>] (warn_slowpath_fmt) from [<c03307ac>] (drm_wait_one_vblank+0x188/0x18c)
[<c03307ac>] (drm_wait_one_vblank) from [<c03307d8>] (drm_crtc_wait_one_vblank+0x28/0x2c)
[<c03307d8>] (drm_crtc_wait_one_vblank) from [<c034f48c>] (mtk_drm_crtc_disable+0x78/0x240)
[<c034f48c>] (mtk_drm_crtc_disable) from [<c03240d4>] (drm_atomic_helper_commit_modeset_disables+0x128/0x3b8)
[<c03240d4>] (drm_atomic_helper_commit_modeset_disables) from [<c0350a7c>] (mtk_atomic_complete+0x74/0xb4)
[<c0350a7c>] (mtk_atomic_complete) from [<c0350b24>] (mtk_atomic_commit+0x68/0x98)
[<c0350b24>] (mtk_atomic_commit) from [<c034ab48>] (drm_atomic_commit+0x54/0x74)
[<c034ab48>] (drm_atomic_commit) from [<c0325c4c>] (drm_atomic_helper_set_config+0x7c/0xa0)
[<c0325c4c>] (drm_atomic_helper_set_config) from [<c0338594>] (drm_mode_set_config_internal+0x68/0xe4)
[<c0338594>] (drm_mode_set_config_internal) from [<c033967c>] (drm_framebuffer_remove+0xe4/0x120)
[<c033967c>] (drm_framebuffer_remove) from [<c0339700>] (drm_mode_rmfb_work_fn+0x48/0x58)
[<c0339700>] (drm_mode_rmfb_work_fn) from [<c0043a38>] (process_one_work+0x154/0x50c)
[<c0043a38>] (process_one_work) from [<c0044074>] (worker_thread+0x284/0x568)
[<c0044074>] (worker_thread) from [<c0049dc4>] (kthread+0xec/0x104)
[<c0049dc4>] (kthread) from [<c0010678>] (ret_from_fork+0x14/0x3c)
---[ end trace 12ae5358e992abd5 ]---

so, we add refcount for DPI power on/off to protect the flow.

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 43 ++++++++++++--------------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 6c0ea39d5739..5ede1ddbaa1a 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -76,8 +76,7 @@ struct mtk_dpi {
 	enum mtk_dpi_out_yc_map yc_map;
 	enum mtk_dpi_out_bit_num bit_num;
 	enum mtk_dpi_out_channel_swap channel_swap;
-	bool power_sta;
-	u8 power_ctl;
+	int refcount;
 };
 
 static inline struct mtk_dpi *mtk_dpi_from_encoder(struct drm_encoder *e)
@@ -90,11 +89,6 @@ enum mtk_dpi_polarity {
 	MTK_DPI_POLARITY_FALLING,
 };
 
-enum mtk_dpi_power_ctl {
-	DPI_POWER_START = BIT(0),
-	DPI_POWER_ENABLE = BIT(1),
-};
-
 struct mtk_dpi_polarities {
 	enum mtk_dpi_polarity de_pol;
 	enum mtk_dpi_polarity ck_pol;
@@ -367,40 +361,30 @@ static void mtk_dpi_config_color_format(struct mtk_dpi *dpi,
 	}
 }
 
-static void mtk_dpi_power_off(struct mtk_dpi *dpi, enum mtk_dpi_power_ctl pctl)
+static void mtk_dpi_power_off(struct mtk_dpi *dpi)
 {
-	dpi->power_ctl &= ~pctl;
-
-	if ((dpi->power_ctl & DPI_POWER_START) ||
-	    (dpi->power_ctl & DPI_POWER_ENABLE))
+	if (WARN_ON(dpi->refcount == 0))
 		return;
 
-	if (!dpi->power_sta)
+	if (--dpi->refcount != 0)
 		return;
 
 	mtk_dpi_disable(dpi);
 	clk_disable_unprepare(dpi->pixel_clk);
 	clk_disable_unprepare(dpi->engine_clk);
-	dpi->power_sta = false;
 }
 
-static int mtk_dpi_power_on(struct mtk_dpi *dpi, enum mtk_dpi_power_ctl pctl)
+static int mtk_dpi_power_on(struct mtk_dpi *dpi)
 {
 	int ret;
 
-	dpi->power_ctl |= pctl;
-
-	if (!(dpi->power_ctl & DPI_POWER_START) &&
-	    !(dpi->power_ctl & DPI_POWER_ENABLE))
-		return 0;
-
-	if (dpi->power_sta)
+	if (++dpi->refcount != 1)
 		return 0;
 
 	ret = clk_prepare_enable(dpi->engine_clk);
 	if (ret) {
 		dev_err(dpi->dev, "Failed to enable engine clock: %d\n", ret);
-		goto err_eng;
+		goto err_refcount;
 	}
 
 	ret = clk_prepare_enable(dpi->pixel_clk);
@@ -410,13 +394,12 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi, enum mtk_dpi_power_ctl pctl)
 	}
 
 	mtk_dpi_enable(dpi);
-	dpi->power_sta = true;
 	return 0;
 
 err_pixel:
 	clk_disable_unprepare(dpi->engine_clk);
-err_eng:
-	dpi->power_ctl &= ~pctl;
+err_refcount:
+	dpi->refcount--;
 	return ret;
 }
 
@@ -552,14 +535,14 @@ static void mtk_dpi_encoder_disable(struct drm_encoder *encoder)
 {
 	struct mtk_dpi *dpi = mtk_dpi_from_encoder(encoder);
 
-	mtk_dpi_power_off(dpi, DPI_POWER_ENABLE);
+	mtk_dpi_power_off(dpi);
 }
 
 static void mtk_dpi_encoder_enable(struct drm_encoder *encoder)
 {
 	struct mtk_dpi *dpi = mtk_dpi_from_encoder(encoder);
 
-	mtk_dpi_power_on(dpi, DPI_POWER_ENABLE);
+	mtk_dpi_power_on(dpi);
 	mtk_dpi_set_display_mode(dpi, &dpi->mode);
 }
 
@@ -582,14 +565,14 @@ static void mtk_dpi_start(struct mtk_ddp_comp *comp)
 {
 	struct mtk_dpi *dpi = container_of(comp, struct mtk_dpi, ddp_comp);
 
-	mtk_dpi_power_on(dpi, DPI_POWER_START);
+	mtk_dpi_power_on(dpi);
 }
 
 static void mtk_dpi_stop(struct mtk_ddp_comp *comp)
 {
 	struct mtk_dpi *dpi = container_of(comp, struct mtk_dpi, ddp_comp);
 
-	mtk_dpi_power_off(dpi, DPI_POWER_START);
+	mtk_dpi_power_off(dpi);
 }
 
 static const struct mtk_ddp_comp_funcs mtk_dpi_funcs = {
-- 
2.12.5.2.gbdf23ab


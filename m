Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456FAC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E668721533
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E668721533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389035AbeIUJPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 05:15:19 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:53153 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388834AbeIUJPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 05:15:18 -0400
X-UUID: bfcd24bb60e84564b439fe0ea8ab5b82-20180921
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2046175288; Fri, 21 Sep 2018 11:28:27 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Fri, 21 Sep 2018 11:28:25 +0800
Received: from mtkslt209.mediatek.inc (10.21.15.96) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 21 Sep 2018 11:28:26 +0800
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
Subject: [PATCH v3 01/12] drm/mediatek: add refcount for DPI power on/off
Date:   Fri, 21 Sep 2018 11:28:11 +0800
Message-ID: <20180921032822.30771-2-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.12.5.2.gbdf23ab
In-Reply-To: <20180921032822.30771-1-bibby.hsieh@mediatek.com>
References: <20180921032822.30771-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
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
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 6c0ea39d5739..d9373e67d328 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -77,6 +77,7 @@ struct mtk_dpi {
 	enum mtk_dpi_out_bit_num bit_num;
 	enum mtk_dpi_out_channel_swap channel_swap;
 	bool power_sta;
+	int refcount;
 	u8 power_ctl;
 };
 
@@ -369,6 +370,12 @@ static void mtk_dpi_config_color_format(struct mtk_dpi *dpi,
 
 static void mtk_dpi_power_off(struct mtk_dpi *dpi, enum mtk_dpi_power_ctl pctl)
 {
+	if (WARN_ON(dpi->refcount == 0))
+		return;
+
+	if (--dpi->refcount != 0)
+		return;
+
 	dpi->power_ctl &= ~pctl;
 
 	if ((dpi->power_ctl & DPI_POWER_START) ||
@@ -388,14 +395,17 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi, enum mtk_dpi_power_ctl pctl)
 {
 	int ret;
 
+	if (++dpi->refcount != 1)
+		return 0;
+
 	dpi->power_ctl |= pctl;
 
 	if (!(dpi->power_ctl & DPI_POWER_START) &&
 	    !(dpi->power_ctl & DPI_POWER_ENABLE))
-		return 0;
+		goto err_refcount;
 
 	if (dpi->power_sta)
-		return 0;
+		goto err_refcount;
 
 	ret = clk_prepare_enable(dpi->engine_clk);
 	if (ret) {
@@ -417,6 +427,8 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi, enum mtk_dpi_power_ctl pctl)
 	clk_disable_unprepare(dpi->engine_clk);
 err_eng:
 	dpi->power_ctl &= ~pctl;
+err_refcount:
+	dpi->refcount--;
 	return ret;
 }
 
-- 
2.12.5.2.gbdf23ab


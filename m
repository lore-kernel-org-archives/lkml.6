Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9E6C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108FD2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 108FD2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbeH1MX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:23:26 -0400
Received: from regular1.263xmail.com ([211.150.99.139]:53732 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeH1MX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:23:26 -0400
Received: from hjc?rock-chips.com (unknown [192.168.167.8])
        by regular1.263xmail.com (Postfix) with ESMTP id 62AB843D;
        Tue, 28 Aug 2018 16:32:41 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id 89AC93F8;
        Tue, 28 Aug 2018 16:32:39 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: hjc@rock-chips.com
X-FST-TO: hjc@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: hjc@rock-chips.com
X-UNIQUE-TAG: <6bd076a808940d035c6e904059178093>
X-ATTACHMENT-NUM: 0
X-SENDER: hjc@rock-chips.com
X-DNS-TYPE: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 31698GND4NZ;
        Tue, 28 Aug 2018 16:32:40 +0800 (CST)
From:   Sandy Huang <hjc@rock-chips.com>
To:     hjc@rock-chips.com, heiko@sntech.de,
        David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/rockchip: vop: fix some register define error for px30
Date:   Tue, 28 Aug 2018 16:32:30 +0800
Message-Id: <1535445150-40296-1-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. interrupt register define error lead to enable interrupt failed;
2. px30 unsupport hdmi output;
3. there are some hardware designed bug, we must swap win2 gate and
   enable offset, otherwise will appear vop iommu pagefault.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index d824ca6..7f29913 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -190,10 +190,10 @@ static const int px30_vop_intrs[] = {
 static const struct vop_intr px30_intr = {
 	.intrs = px30_vop_intrs,
 	.nintrs = ARRAY_SIZE(px30_vop_intrs),
-	.line_flag_num[0] = VOP_REG(PX30_LINE_FLAG, 0xfff, 12),
-	.status = VOP_REG_SYNC(PX30_INTR_STATUS, 0xf, 0),
-	.enable = VOP_REG_SYNC(PX30_INTR_EN, 0xf, 4),
-	.clear = VOP_REG_SYNC(PX30_INTR_CLEAR, 0xf, 8),
+	.line_flag_num[0] = VOP_REG(PX30_LINE_FLAG, 0xfff, 0),
+	.status = VOP_REG_MASK_SYNC(PX30_INTR_STATUS, 0xffff, 0),
+	.enable = VOP_REG_MASK_SYNC(PX30_INTR_EN, 0xffff, 0),
+	.clear = VOP_REG_MASK_SYNC(PX30_INTR_CLEAR, 0xffff, 0),
 };
 
 static const struct vop_common px30_common = {
@@ -212,10 +212,8 @@ static const struct vop_modeset px30_modeset = {
 
 static const struct vop_output px30_output = {
 	.rgb_pin_pol = VOP_REG(PX30_DSP_CTRL0, 0xf, 1),
-	.hdmi_pin_pol = VOP_REG(PX30_DSP_CTRL0, 0xf, 9),
 	.mipi_pin_pol = VOP_REG(PX30_DSP_CTRL0, 0xf, 25),
 	.rgb_en = VOP_REG(PX30_DSP_CTRL0, 0x1, 0),
-	.hdmi_en = VOP_REG(PX30_DSP_CTRL0, 0x1, 8),
 	.mipi_en = VOP_REG(PX30_DSP_CTRL0, 0x1, 24),
 };
 
@@ -257,8 +255,8 @@ static const struct vop_win_phy px30_win1_data = {
 static const struct vop_win_phy px30_win2_data = {
 	.data_formats = formats_win_lite,
 	.nformats = ARRAY_SIZE(formats_win_lite),
-	.gate = VOP_REG(PX30_WIN2_CTRL0, 0x1, 0),
-	.enable = VOP_REG(PX30_WIN2_CTRL0, 0x1, 4),
+	.gate = VOP_REG(PX30_WIN2_CTRL0, 0x1, 4),
+	.enable = VOP_REG(PX30_WIN2_CTRL0, 0x1, 0),
 	.format = VOP_REG(PX30_WIN2_CTRL0, 0x3, 5),
 	.rb_swap = VOP_REG(PX30_WIN2_CTRL0, 0x1, 20),
 	.dsp_info = VOP_REG(PX30_WIN2_DSP_INFO0, 0x0fff0fff, 0),
-- 
2.7.4



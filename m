Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07D2C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E54126696
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E54126696
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932734AbeFZIRu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:17:50 -0400
Received: from regular1.263xmail.com ([211.150.99.130]:42311 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932125AbeFZIRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:17:45 -0400
Received: from hjc?rock-chips.com (unknown [192.168.167.233])
        by regular1.263xmail.com (Postfix) with ESMTP id 2EDCFB1AD;
        Tue, 26 Jun 2018 16:17:32 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id 471543E1;
        Tue, 26 Jun 2018 16:17:17 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: hjc@rock-chips.com
X-FST-TO: dri-devel@lists.freedesktop.org
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: hjc@rock-chips.com
X-UNIQUE-TAG: <4290c5e2179ea33f72c094655a260b4b>
X-ATTACHMENT-NUM: 0
X-SENDER: hjc@rock-chips.com
X-DNS-TYPE: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 8813II07W7;
        Tue, 26 Jun 2018 16:17:26 +0800 (CST)
From:   Sandy Huang <hjc@rock-chips.com>
To:     dri-devel@lists.freedesktop.org, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/rockchip: vop: fixup linebuffer mode calc error
Date:   Tue, 26 Jun 2018 16:16:44 +0800
Message-Id: <1530001004-25036-1-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linebuffer mode should be LB_YUV_3840X5 when width is bigger
than 1280 in yuv mode.
seperate yuv and rgb case make the scl_vop_cal_lb_mode() logic
is clearer.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1523960108-190541-1-git-send-email-hjc@rock-chips.com
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index 084acdd..fcb9104 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -331,16 +331,19 @@ static inline int scl_vop_cal_lb_mode(int width, bool is_yuv)
 {
 	int lb_mode;
 
-	if (width > 2560)
-		lb_mode = LB_RGB_3840X2;
-	else if (width > 1920)
-		lb_mode = LB_RGB_2560X4;
-	else if (!is_yuv)
-		lb_mode = LB_RGB_1920X5;
-	else if (width > 1280)
-		lb_mode = LB_YUV_3840X5;
-	else
-		lb_mode = LB_YUV_2560X8;
+	if (is_yuv) {
+		if (width > 1280)
+			lb_mode = LB_YUV_3840X5;
+		else
+			lb_mode = LB_YUV_2560X8;
+	} else {
+		if (width > 2560)
+			lb_mode = LB_RGB_3840X2;
+		else if (width > 1920)
+			lb_mode = LB_RGB_2560X4;
+		else
+			lb_mode = LB_RGB_1920X5;
+	}
 
 	return lb_mode;
 }
-- 
2.7.4



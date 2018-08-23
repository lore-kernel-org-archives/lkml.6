Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C88DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029BD20851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 029BD20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732891AbeHWMMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:12:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50220 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeHWMMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:12:02 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CCFBC7F6;
        Thu, 23 Aug 2018 08:43:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maciej Purski <m.purski@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 083/324] drm/bridge/sii8620: fix display of packed pixel modes in MHL2
Date:   Thu, 23 Aug 2018 09:52:29 +0200
Message-Id: <20180823075000.038824990@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej Purski <m.purski@samsung.com>

[ Upstream commit e8b92efa629dac0e70ea4145c5e70616de5f89c8 ]

Currently packed pixel modes in MHL2 can't be displayed. The device
automatically recognizes output format, so setting format other than
RGB causes failure. Fix it by writing proper values to registers.

Tested on MHL1 and MHL2 using various vendors' dongles both in
DVI and HDMI mode.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1516706239-9104-1-git-send-email-m.purski@samsung.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/bridge/sil-sii8620.c |   17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -1060,20 +1060,11 @@ static void sii8620_stop_video(struct si
 
 static void sii8620_set_format(struct sii8620 *ctx)
 {
-	u8 out_fmt;
-
 	if (sii8620_is_mhl3(ctx)) {
 		sii8620_setbits(ctx, REG_M3_P0CTRL,
 				BIT_M3_P0CTRL_MHL3_P0_PIXEL_MODE_PACKED,
 				ctx->use_packed_pixel ? ~0 : 0);
 	} else {
-		if (ctx->use_packed_pixel)
-			sii8620_write_seq_static(ctx,
-				REG_VID_MODE, BIT_VID_MODE_M1080P,
-				REG_MHL_TOP_CTL, BIT_MHL_TOP_CTL_MHL_PP_SEL | 1,
-				REG_MHLTX_CTL6, 0x60
-			);
-		else
 			sii8620_write_seq_static(ctx,
 				REG_VID_MODE, 0,
 				REG_MHL_TOP_CTL, 1,
@@ -1081,15 +1072,9 @@ static void sii8620_set_format(struct si
 			);
 	}
 
-	if (ctx->use_packed_pixel)
-		out_fmt = VAL_TPI_FORMAT(YCBCR422, FULL) |
-			BIT_TPI_OUTPUT_CSCMODE709;
-	else
-		out_fmt = VAL_TPI_FORMAT(RGB, FULL);
-
 	sii8620_write_seq(ctx,
 		REG_TPI_INPUT, VAL_TPI_FORMAT(RGB, FULL),
-		REG_TPI_OUTPUT, out_fmt,
+		REG_TPI_OUTPUT, VAL_TPI_FORMAT(RGB, FULL),
 	);
 }
 



Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146BDC04E85
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA2020851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAA2020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732392AbeHWMJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:09:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49816 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729381AbeHWMJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:09:43 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 336228B1;
        Thu, 23 Aug 2018 08:41:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maciej Purski <m.purski@samsung.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 010/324] drm/bridge/sii8620: fix loops in EDID fetch logic
Date:   Thu, 23 Aug 2018 09:51:16 +0200
Message-Id: <20180823074956.449944818@linuxfoundation.org>
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

From: Andrzej Hajda <a.hajda@samsung.com>

[ Upstream commit 8e627a1b1ce8feb3e1da4428b71b9b4905f04888 ]

Function should constantly check if cable is connected and finish
in finite time.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Maciej Purski <m.purski@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180115173357.31067-4-a.hajda@samsung.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/bridge/sil-sii8620.c |   31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -807,6 +807,7 @@ static void sii8620_burst_rx_all(struct
 static void sii8620_fetch_edid(struct sii8620 *ctx)
 {
 	u8 lm_ddc, ddc_cmd, int3, cbus;
+	unsigned long timeout;
 	int fetched, i;
 	int edid_len = EDID_LENGTH;
 	u8 *edid;
@@ -856,23 +857,31 @@ static void sii8620_fetch_edid(struct si
 			REG_DDC_CMD, ddc_cmd | VAL_DDC_CMD_ENH_DDC_READ_NO_ACK
 		);
 
-		do {
-			int3 = sii8620_readb(ctx, REG_INTR3);
+		int3 = 0;
+		timeout = jiffies + msecs_to_jiffies(200);
+		for (;;) {
 			cbus = sii8620_readb(ctx, REG_CBUS_STATUS);
-
-			if (int3 & BIT_DDC_CMD_DONE)
-				break;
-
-			if (!(cbus & BIT_CBUS_STATUS_CBUS_CONNECTED)) {
+			if (~cbus & BIT_CBUS_STATUS_CBUS_CONNECTED) {
+				kfree(edid);
+				edid = NULL;
+				goto end;
+			}
+			if (int3 & BIT_DDC_CMD_DONE) {
+				if (sii8620_readb(ctx, REG_DDC_DOUT_CNT)
+				    >= FETCH_SIZE)
+					break;
+			} else {
+				int3 = sii8620_readb(ctx, REG_INTR3);
+			}
+			if (time_is_before_jiffies(timeout)) {
+				ctx->error = -ETIMEDOUT;
+				dev_err(ctx->dev, "timeout during EDID read\n");
 				kfree(edid);
 				edid = NULL;
 				goto end;
 			}
-		} while (1);
-
-		sii8620_readb(ctx, REG_DDC_STATUS);
-		while (sii8620_readb(ctx, REG_DDC_DOUT_CNT) < FETCH_SIZE)
 			usleep_range(10, 20);
+		}
 
 		sii8620_read_buf(ctx, REG_DDC_DATA, edid + fetched, FETCH_SIZE);
 		if (fetched + FETCH_SIZE == EDID_LENGTH) {



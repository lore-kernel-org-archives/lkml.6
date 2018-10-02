Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE82C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A4B2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A4B2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbeJBUpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:45:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33398 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729073AbeJBUNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:13:34 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C9935C2B;
        Tue,  2 Oct 2018 13:30:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 178/228] mmc: atmel-mci: fix bad logic of sg_copy_{from,to}_buffer conversion
Date:   Tue,  2 Oct 2018 06:24:35 -0700
Message-Id: <20181002132510.559367604@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
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

From: Ludovic Desroches <ludovic.desroches@microchip.com>

[ Upstream commit 19f5e9e015675fcdbf2c20e804b2e84e80201454 ]

The conversion to sg_copy_{from,to}_buffer has been done in the wrong
way. sg_copy_to_buffer is a copy from an SG list to a linear buffer so
it can't replace memcpy(buf + offset, &value, remaining) where buf is
the virtual address of the SG. Same for sg_copy_to_buffer but in the
opposite way.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Suggested-by: Douglas Gilbert <dgilbert@interlog.com>
Fixes: 5b4277814e3f ("mmc: atmel-mci: use sg_copy_{from,to}_buffer")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/atmel-mci.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -1976,7 +1976,7 @@ static void atmci_read_data_pio(struct a
 	do {
 		value = atmci_readl(host, ATMCI_RDR);
 		if (likely(offset + 4 <= sg->length)) {
-			sg_pcopy_to_buffer(sg, 1, &value, sizeof(u32), offset);
+			sg_pcopy_from_buffer(sg, 1, &value, sizeof(u32), offset);
 
 			offset += 4;
 			nbytes += 4;
@@ -1993,7 +1993,7 @@ static void atmci_read_data_pio(struct a
 		} else {
 			unsigned int remaining = sg->length - offset;
 
-			sg_pcopy_to_buffer(sg, 1, &value, remaining, offset);
+			sg_pcopy_from_buffer(sg, 1, &value, remaining, offset);
 			nbytes += remaining;
 
 			flush_dcache_page(sg_page(sg));
@@ -2003,7 +2003,7 @@ static void atmci_read_data_pio(struct a
 				goto done;
 
 			offset = 4 - remaining;
-			sg_pcopy_to_buffer(sg, 1, (u8 *)&value + remaining,
+			sg_pcopy_from_buffer(sg, 1, (u8 *)&value + remaining,
 					offset, 0);
 			nbytes += offset;
 		}
@@ -2042,7 +2042,7 @@ static void atmci_write_data_pio(struct
 
 	do {
 		if (likely(offset + 4 <= sg->length)) {
-			sg_pcopy_from_buffer(sg, 1, &value, sizeof(u32), offset);
+			sg_pcopy_to_buffer(sg, 1, &value, sizeof(u32), offset);
 			atmci_writel(host, ATMCI_TDR, value);
 
 			offset += 4;
@@ -2059,7 +2059,7 @@ static void atmci_write_data_pio(struct
 			unsigned int remaining = sg->length - offset;
 
 			value = 0;
-			sg_pcopy_from_buffer(sg, 1, &value, remaining, offset);
+			sg_pcopy_to_buffer(sg, 1, &value, remaining, offset);
 			nbytes += remaining;
 
 			host->sg = sg = sg_next(sg);
@@ -2070,7 +2070,7 @@ static void atmci_write_data_pio(struct
 			}
 
 			offset = 4 - remaining;
-			sg_pcopy_from_buffer(sg, 1, (u8 *)&value + remaining,
+			sg_pcopy_to_buffer(sg, 1, (u8 *)&value + remaining,
 					offset, 0);
 			atmci_writel(host, ATMCI_TDR, value);
 			nbytes += offset;



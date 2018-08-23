Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83027C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E04C21564
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:55:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E04C21564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbeHWV0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 17:26:20 -0400
Received: from gateway30.websitewelcome.com ([192.185.192.34]:37270 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726573AbeHWV0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 17:26:20 -0400
X-Greylist: delayed 760 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Aug 2018 17:26:19 EDT
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 429803337B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 12:55:29 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id stpRfSNLwbXuJstpRfojY9; Thu, 23 Aug 2018 12:55:29 -0500
X-Authority-Reason: nr=8
Received: from [189.250.40.214] (port=36274 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fstpQ-003RFo-Bq; Thu, 23 Aug 2018 12:55:28 -0500
Date:   Thu, 23 Aug 2018 12:55:27 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v3] usb: iowarrior: replace kmalloc with kmalloc_array
Message-ID: <20180823175527.GA26370@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.40.214
X-Source-L: No
X-Exim-ID: 1fstpQ-003RFo-Bq
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.40.214]:36274
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 19
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A common flaw in the kernel is integer overflow during memory allocation
size calculations. In an effort to reduce the frequency of these bugs,
kmalloc_array was implemented, which allocates memory for an array,
while at the same time detects integer overflow.

This patch replaces cases of:

	kmalloc(a * b, gfp)

with:
	kmalloc_array(a, b, gfp)

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v3:
 - Update commit log.

Changes in v2:
 - Align GFP_KERNEL to open parenthesis.

 drivers/usb/misc/iowarrior.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index c2991b8..ba05dd8 100644
--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -808,8 +808,8 @@ static int iowarrior_probe(struct usb_interface *interface,
 			 dev->int_in_endpoint->bInterval);
 	/* create an internal buffer for interrupt data from the device */
 	dev->read_queue =
-	    kmalloc(((dev->report_size + 1) * MAX_INTERRUPT_BUFFER),
-		    GFP_KERNEL);
+	    kmalloc_array(dev->report_size + 1, MAX_INTERRUPT_BUFFER,
+			  GFP_KERNEL);
 	if (!dev->read_queue)
 		goto error;
 	/* Get the serial-number of the chip */
-- 
2.7.4


Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9366EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F8020779
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F8020779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbeICVLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:11:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36112 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbeICVLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:11:23 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C1A62CF3;
        Mon,  3 Sep 2018 16:50:26 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eugeniu Rosca <erosca@de.adit-jv.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 14/56] usb: gadget: f_uac2: fix endianness of struct cntrl_*_lay3
Date:   Mon,  3 Sep 2018 18:49:04 +0200
Message-Id: <20180903164924.813770576@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903164924.078355019@linuxfoundation.org>
References: <20180903164924.078355019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eugeniu Rosca <roscaeugeniu@gmail.com>

[ Upstream commit eec24f2a0d4dc3b1d95a3ccd2feb523ede3ba775 ]

The list [1] of commits doing endianness fixes in USB subsystem is long
due to below quote from USB spec Revision 2.0 from April 27, 2000:

------------
8.1 Byte/Bit Ordering

Multiple byte fields in standard descriptors, requests, and responses
are interpreted as and moved over the bus in little-endian order, i.e.
LSB to MSB.
------------

This commit belongs to the same family.

[1] Example of endianness fixes in USB subsystem:
commit 14e1d56cbea6 ("usb: gadget: f_uac2: endianness fixes.")
commit 42370b821168 ("usb: gadget: f_uac1: endianness fixes.")
commit 63afd5cc7877 ("USB: chaoskey: fix Alea quirk on big-endian hosts")
commit 74098c4ac782 ("usb: gadget: acm: fix endianness in notifications")
commit cdd7928df0d2 ("ACM gadget: fix endianness in notifications")
commit 323ece54e076 ("cdc-wdm: fix endianness bug in debug statements")
commit e102609f1072 ("usb: gadget: uvc: Fix endianness mismatches")
       list goes on

Fixes: 132fcb460839 ("usb: gadget: Add Audio Class 2.0 Driver")
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Reviewed-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/f_uac2.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -941,14 +941,14 @@ static struct usb_descriptor_header *hs_
 };
 
 struct cntrl_cur_lay3 {
-	__u32	dCUR;
+	__le32	dCUR;
 };
 
 struct cntrl_range_lay3 {
-	__u16	wNumSubRanges;
-	__u32	dMIN;
-	__u32	dMAX;
-	__u32	dRES;
+	__le16	wNumSubRanges;
+	__le32	dMIN;
+	__le32	dMAX;
+	__le32	dRES;
 } __packed;
 
 static inline void
@@ -1274,9 +1274,9 @@ in_rq_cur(struct usb_function *fn, const
 		struct cntrl_cur_lay3 c;
 
 		if (entity_id == USB_IN_CLK_ID)
-			c.dCUR = p_srate;
+			c.dCUR = cpu_to_le32(p_srate);
 		else if (entity_id == USB_OUT_CLK_ID)
-			c.dCUR = c_srate;
+			c.dCUR = cpu_to_le32(c_srate);
 
 		value = min_t(unsigned, w_length, sizeof c);
 		memcpy(req->buf, &c, value);
@@ -1314,15 +1314,15 @@ in_rq_range(struct usb_function *fn, con
 
 	if (control_selector == UAC2_CS_CONTROL_SAM_FREQ) {
 		if (entity_id == USB_IN_CLK_ID)
-			r.dMIN = p_srate;
+			r.dMIN = cpu_to_le32(p_srate);
 		else if (entity_id == USB_OUT_CLK_ID)
-			r.dMIN = c_srate;
+			r.dMIN = cpu_to_le32(c_srate);
 		else
 			return -EOPNOTSUPP;
 
 		r.dMAX = r.dMIN;
 		r.dRES = 0;
-		r.wNumSubRanges = 1;
+		r.wNumSubRanges = cpu_to_le16(1);
 
 		value = min_t(unsigned, w_length, sizeof r);
 		memcpy(req->buf, &r, value);



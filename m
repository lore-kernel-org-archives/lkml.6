Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8CBC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE3820661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE3820661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeLIWJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:09:07 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37384 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726641AbeLIWJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:09:05 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW735-0002ij-1a; Sun, 09 Dec 2018 21:55:39 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72g-0003Vp-Is; Sun, 09 Dec 2018 21:55:14 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jia-Ju Bai" <baijiaju1990@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.143845085@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 209/328] usb: misc: uss720: Fix two sleep-in-atomic-context
 bugs
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jia-Ju Bai <baijiaju1990@gmail.com>

commit bc8acc214d3f1cafebcbcd101a695bbac716595d upstream.

async_complete() in uss720.c is a completion handler function for the
USB driver. So it should not sleep, but it is can sleep according to the
function call paths (from bottom to top) in Linux-4.16.

[FUNC] set_1284_register(GFP_KERNEL)
drivers/usb/misc/uss720.c, 372:
  set_1284_register in parport_uss720_frob_control
drivers/parport/ieee1284.c, 560:
  [FUNC_PTR]parport_uss720_frob_control in parport_ieee1284_ack_data_avail
drivers/parport/ieee1284.c, 577:
  parport_ieee1284_ack_data_avail in parport_ieee1284_interrupt
./include/linux/parport.h, 474:
  parport_ieee1284_interrupt in parport_generic_irq
drivers/usb/misc/uss720.c, 116:
  parport_generic_irq in async_complete

[FUNC] get_1284_register(GFP_KERNEL)
drivers/usb/misc/uss720.c, 382:
  get_1284_register in parport_uss720_read_status
drivers/parport/ieee1284.c, 555:
  [FUNC_PTR]parport_uss720_read_status in parport_ieee1284_ack_data_avail
drivers/parport/ieee1284.c, 577:
  parport_ieee1284_ack_data_avail in parport_ieee1284_interrupt
./include/linux/parport.h, 474:
  parport_ieee1284_interrupt in parport_generic_irq
drivers/usb/misc/uss720.c, 116:
  parport_generic_irq in async_complete

Note that [FUNC_PTR] means a function pointer call is used.

To fix these bugs, GFP_KERNEL is replaced with GFP_ATOMIC.

These bugs are found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/misc/uss720.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/misc/uss720.c
+++ b/drivers/usb/misc/uss720.c
@@ -392,7 +392,7 @@ static unsigned char parport_uss720_frob
 	mask &= 0x0f;
 	val &= 0x0f;
 	d = (priv->reg[1] & (~mask)) ^ val;
-	if (set_1284_register(pp, 2, d, GFP_KERNEL))
+	if (set_1284_register(pp, 2, d, GFP_ATOMIC))
 		return 0;
 	priv->reg[1] = d;
 	return d & 0xf;
@@ -402,7 +402,7 @@ static unsigned char parport_uss720_read
 {
 	unsigned char ret;
 
-	if (get_1284_register(pp, 1, &ret, GFP_KERNEL))
+	if (get_1284_register(pp, 1, &ret, GFP_ATOMIC))
 		return 0;
 	return ret & 0xf8;
 }


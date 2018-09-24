Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C45FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F8621486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F8621486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbeIXRns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:43:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51094 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729237AbeIXRnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:43:47 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0FBD31072;
        Mon, 24 Sep 2018 11:42:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 3.18 089/105] usb: misc: uss720: Fix two sleep-in-atomic-context bugs
Date:   Mon, 24 Sep 2018 13:34:15 +0200
Message-Id: <20180924113121.809676889@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113113.268650190@linuxfoundation.org>
References: <20180924113113.268650190@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/misc/uss720.c |    4 ++--
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



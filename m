Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30B8C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7512D20867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7512D20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbeICVLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:11:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36058 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbeICVLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:11:10 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 60C27CF1;
        Mon,  3 Sep 2018 16:50:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 10/56] usb: gadget: r8a66597: Fix two possible sleep-in-atomic-context bugs in init_controller()
Date:   Mon,  3 Sep 2018 18:49:00 +0200
Message-Id: <20180903164924.602670202@linuxfoundation.org>
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

From: Jia-Ju Bai <baijiaju1990@gmail.com>

[ Upstream commit 0602088b10a7c0b4e044a810678ef93d7cc5bf48 ]

The driver may sleep with holding a spinlock.
The function call paths (from bottom to top) in Linux-4.16.7 are:

[FUNC] msleep
drivers/usb/gadget/udc/r8a66597-udc.c, 839:
		msleep in init_controller
drivers/usb/gadget/udc/r8a66597-udc.c, 96:
		init_controller in r8a66597_usb_disconnect
drivers/usb/gadget/udc/r8a66597-udc.c, 93:
		spin_lock in r8a66597_usb_disconnect

[FUNC] msleep
drivers/usb/gadget/udc/r8a66597-udc.c, 835:
		msleep in init_controller
drivers/usb/gadget/udc/r8a66597-udc.c, 96:
		init_controller in r8a66597_usb_disconnect
drivers/usb/gadget/udc/r8a66597-udc.c, 93:
		spin_lock in r8a66597_usb_disconnect

To fix these bugs, msleep() is replaced with mdelay().

This bug is found by my static analysis tool (DSAC-2) and checked by
my code review.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/udc/r8a66597-udc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/gadget/udc/r8a66597-udc.c
+++ b/drivers/usb/gadget/udc/r8a66597-udc.c
@@ -835,11 +835,11 @@ static void init_controller(struct r8a66
 
 		r8a66597_bset(r8a66597, XCKE, SYSCFG0);
 
-		msleep(3);
+		mdelay(3);
 
 		r8a66597_bset(r8a66597, PLLC, SYSCFG0);
 
-		msleep(1);
+		mdelay(1);
 
 		r8a66597_bset(r8a66597, SCKE, SYSCFG0);
 



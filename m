Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419A6C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E967B20895
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E967B20895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389143AbeG0LLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:11:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53168 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbeG0LLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:11:35 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1D3E1BB6;
        Fri, 27 Jul 2018 09:50:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.17 53/66] usb: gadget: Fix OS descriptors support
Date:   Fri, 27 Jul 2018 11:45:46 +0200
Message-Id: <20180727093815.002097607@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727093809.043856530@linuxfoundation.org>
References: <20180727093809.043856530@linuxfoundation.org>
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

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit 50b9773c13bffbef32060e67c4483ea7b2eca7b5 upstream.

The current code is broken as it re-defines "req" inside the
if block, then goto out of it. Thus the request that ends
up being sent is not the one that was populated by the
code in question.

This fixes RNDIS driver autodetect by Windows 10 for me.

The bug was introduced by Chris rework to remove the local
queuing inside the if { } block of the redefined request.

Fixes: 636ba13aec8a ("usb: gadget: composite: remove duplicated code in OS desc handling")
Cc: <stable@vger.kernel.org> # v4.17
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/composite.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1816,7 +1816,6 @@ unknown:
 		if (cdev->use_os_string && cdev->os_desc_config &&
 		    (ctrl->bRequestType & USB_TYPE_VENDOR) &&
 		    ctrl->bRequest == cdev->b_vendor_code) {
-			struct usb_request		*req;
 			struct usb_configuration	*os_desc_cfg;
 			u8				*buf;
 			int				interface;



Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E186DC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 06:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76042170B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 06:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A76042170B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbeHZK3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 06:29:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53894 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbeHZK3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 06:29:38 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9260925A;
        Sun, 26 Aug 2018 06:48:02 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Jay Hsu <shih-chieh.hsu@mediatek.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 19/56] usb: gadget: composite: fix delayed_status race condition when set_interface
Date:   Sun, 26 Aug 2018 08:44:40 +0200
Message-Id: <20180826064233.289281648@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180826064232.320669119@linuxfoundation.org>
References: <20180826064232.320669119@linuxfoundation.org>
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

From: Chunfeng Yun <chunfeng.yun@mediatek.com>

[ Upstream commit 980900d6318066b9f8314bfb87329a20fd0d1ca4 ]

It happens when enable debug log, if set_alt() returns
USB_GADGET_DELAYED_STATUS and usb_composite_setup_continue()
is called before increasing count of @delayed_status,
so fix it by using spinlock of @cdev->lock.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Tested-by: Jay Hsu <shih-chieh.hsu@mediatek.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/composite.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1530,6 +1530,8 @@ composite_setup(struct usb_gadget *gadge
 			break;
 		if (w_value && !f->set_alt)
 			break;
+
+		spin_lock(&cdev->lock);
 		value = f->set_alt(f, w_index, w_value);
 		if (value == USB_GADGET_DELAYED_STATUS) {
 			DBG(cdev,
@@ -1539,6 +1541,7 @@ composite_setup(struct usb_gadget *gadge
 			DBG(cdev, "delayed_status count %d\n",
 					cdev->delayed_status);
 		}
+		spin_unlock(&cdev->lock);
 		break;
 	case USB_REQ_GET_INTERFACE:
 		if (ctrl->bRequestType != (USB_DIR_IN|USB_RECIP_INTERFACE))



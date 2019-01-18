Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F50CC1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C9882086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547846977;
	bh=4Wy9HHw4yohxCo423IljYqpK8zEHV671qXpcn7IEDfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IQoQSkZS3PZbgB5brFqyJ4JvGqEsjjhaQNOooUmpqfKjxvtaezmqe/1rv9A/ZW8AY
	 hnkiD1iVqT7GoGa3LovWMg84eXjEWS63M7ZYtdk+c/Tc7J7oCSr6mNVJHJBgvPG6He
	 gCm5OUmvxv7ifryMVlvFCfGgBJldG5cdbL4Delwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbfARV3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 16:29:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:57724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729598AbfARV3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 16:29:34 -0500
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18CBB20896;
        Fri, 18 Jan 2019 21:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547846974;
        bh=4Wy9HHw4yohxCo423IljYqpK8zEHV671qXpcn7IEDfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wIm3cf/PLSfO999wvGqEUmAG1U72VcqdyUk+c5L0BrDytWqMQAWCNvd6m+XdykoD0
         JtHlPxW5zv9Cjhce6+peLJTzsszDIj6gq8V22ze8bm5jd5u6iHKRvtfNQvoBeV5AuE
         48v6tnDRQkpaQ/xpkztVqDKhpjfshCabDZoacG3A=
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usbip: Fix vhci_urb_enqueue() URB null transfer buffer error path
Date:   Fri, 18 Jan 2019 14:29:31 -0700
Message-Id: <20190118212931.18482-2-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190118212931.18482-1-skhan@linuxfoundation.org>
References: <20190118212931.18482-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuah Khan <shuah@kernel.org>

Fix vhci_urb_enqueue() to print error and return error instead of
failing with WARN_ON.

Signed-off-by: Shuah Khan <shuah@kernel.org>
---
 drivers/usb/usbip/vhci_hcd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 1e592ec94ba4..849ebfde87b5 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -702,8 +702,10 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 	}
 	vdev = &vhci_hcd->vdev[portnum-1];
 
-	/* patch to usb_sg_init() is in 2.5.60 */
-	BUG_ON(!urb->transfer_buffer && urb->transfer_buffer_length);
+	if (!urb->transfer_buffer && urb->transfer_buffer_length) {
+		dev_err(dev, "Null URB transfer buffer\n");
+		return -EINVAL;
+	}
 
 	spin_lock_irqsave(&vhci->lock, flags);
 
-- 
2.17.1


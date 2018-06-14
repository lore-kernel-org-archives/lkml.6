Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9322AC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49CE5208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8PHDWUf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49CE5208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936290AbeFNO5c (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:57:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936158AbeFNOFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:05:51 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E779208DA;
        Thu, 14 Jun 2018 14:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985151;
        bh=qrTzcnLStUtagmZRjbTq7317A+FizR83uKUZlZoh9i4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C8PHDWUfJ/VQYtsAxXWBVj3vDHL3LWRjXMAbwrRp8J8JzcYM2YU8cEWh8qk1AEqJX
         ltbMBwsS7MtHLN5R9u+5k7y4IEMvghFuEWK/Q/bpQXUqNt66KRsaDOL8b/7J3qJEq/
         cLLfBjEVPXITg99oTKWZ3O+zkX/kYZbjxgyISaP8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.17 18/45] usb: gadget: function: printer: avoid wrong list handling in printer_write()
Date:   Thu, 14 Jun 2018 16:04:09 +0200
Message-Id: <20180614132127.735330833@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132126.797006529@linuxfoundation.org>
References: <20180614132126.797006529@linuxfoundation.org>
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

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit 4a014a7339f441b0851ce012f469c0fadac61c81 upstream.

When printer_write() calls usb_ep_queue(), a udc driver (e.g.
renesas_usbhs driver) may call usb_gadget_giveback_request() in
the udc .queue ops immediately. Then, printer_write() calls
list_add(&req->list, &dev->tx_reqs_active) wrongly. After that,
if we do unbind the printer driver, WARN_ON() happens in
printer_func_unbind() because the list entry is not removed.

So, this patch moves list_add(&req->list, &dev->tx_reqs_active)
calling before usb_ep_queue().

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/function/f_printer.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -631,19 +631,19 @@ printer_write(struct file *fd, const cha
 			return -EAGAIN;
 		}
 
+		list_add(&req->list, &dev->tx_reqs_active);
+
 		/* here, we unlock, and only unlock, to avoid deadlock. */
 		spin_unlock(&dev->lock);
 		value = usb_ep_queue(dev->in_ep, req, GFP_ATOMIC);
 		spin_lock(&dev->lock);
 		if (value) {
+			list_del(&req->list);
 			list_add(&req->list, &dev->tx_reqs);
 			spin_unlock_irqrestore(&dev->lock, flags);
 			mutex_unlock(&dev->lock_printer_io);
 			return -EAGAIN;
 		}
-
-		list_add(&req->list, &dev->tx_reqs_active);
-
 	}
 
 	spin_unlock_irqrestore(&dev->lock, flags);



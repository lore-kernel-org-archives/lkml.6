Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BCC33C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71775208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcATZr2i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71775208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965739AbeFNOfv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:35:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:51112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965556AbeFNOKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:10:05 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF139208DE;
        Thu, 14 Jun 2018 14:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985405;
        bh=Dn6w0KV4MTmV9M7YVAHHYA4wOB2pwrCF9IeGeul/kls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VcATZr2i2LV5ZI5J6Ar9ZE2ZA27D8cZ9/Btj73kMuFpvQAIX9vZdLpaFO28g2GRzC
         zVoQsnRardxgIXaw12GpIT6RVLDRCFmisTVTjYwD93j7dxCfU/nLO4d6Rka9dJ9+2e
         lqe7pFz9euH1M7ADvjtnPqOaXMmPQFgiUhWFu2xk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.14 16/36] usb: gadget: function: printer: avoid wrong list handling in printer_write()
Date:   Thu, 14 Jun 2018 16:04:39 +0200
Message-Id: <20180614132157.985403185@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132157.333004166@linuxfoundation.org>
References: <20180614132157.333004166@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -635,19 +635,19 @@ printer_write(struct file *fd, const cha
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



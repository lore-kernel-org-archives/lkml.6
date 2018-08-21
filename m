Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BE4C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6967E208A6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6967E208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbeHUJpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:45:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56418 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbeHUJpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:45:45 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6EFB0AD8;
        Tue, 21 Aug 2018 06:26:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Ogness <john.ogness@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.14 18/29] USB: serial: sierra: fix potential deadlock at close
Date:   Tue, 21 Aug 2018 08:21:11 +0200
Message-Id: <20180821055109.114467343@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821055108.333930282@linuxfoundation.org>
References: <20180821055108.333930282@linuxfoundation.org>
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

From: John Ogness <john.ogness@linutronix.de>

commit e60870012e5a35b1506d7b376fddfb30e9da0b27 upstream.

The portdata spinlock can be taken in interrupt context (via
sierra_outdat_callback()).
Disable interrupts when taking the portdata spinlock when discarding
deferred URBs during close to prevent a possible deadlock.

Fixes: 014333f77c0b ("USB: sierra: fix urb and memory leak on disconnect")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
[ johan: amend commit message and add fixes and stable tags ]
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/sierra.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/serial/sierra.c
+++ b/drivers/usb/serial/sierra.c
@@ -773,9 +773,9 @@ static void sierra_close(struct usb_seri
 		kfree(urb->transfer_buffer);
 		usb_free_urb(urb);
 		usb_autopm_put_interface_async(serial->interface);
-		spin_lock(&portdata->lock);
+		spin_lock_irq(&portdata->lock);
 		portdata->outstanding_urbs--;
-		spin_unlock(&portdata->lock);
+		spin_unlock_irq(&portdata->lock);
 	}
 
 	sierra_stop_rx_urbs(port);



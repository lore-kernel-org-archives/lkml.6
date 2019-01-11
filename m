Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294F0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EADF521841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216200;
	bh=Yi7UWpode7Q2FAbhuyp5t7reHFre/Nh0HpwnsFO47KE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uWS/yIB3E2keFqpC/erG9PxivlFImz8xmoLQAIdDgOEZpIrM6nVm36M876V5UUkTS
	 gWCBAZa0yhw6NUleCnY3B1I+wgmdymBhiGo+G7Qs7W9CVAi++7/stIQwtn1PAoQdCb
	 0shg6+st9pCNkBy3INCymFLDp4hKPJOLiPopEn5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387684AbfAKOQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:16:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:32814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731311AbfAKOQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:16:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 587FA214D8;
        Fri, 11 Jan 2019 14:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216194;
        bh=Yi7UWpode7Q2FAbhuyp5t7reHFre/Nh0HpwnsFO47KE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bsp6vf2mUaWCtLzn8hMAhKeFEQCyKWkVRan4MrYPBIEoS68ioHLlgNSQ+3sQxF+cE
         qwMFZs4xUh3S70jud5rH/Ee4FFvFC3gMji79HwBrmH4SA5ckY2Ozzh086BRUKqxto+
         kYk7PZRcUA+so5KcSY9iR/lQZXwKmaTToe5O7txM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.4 02/88] xhci: Dont prevent USB2 bus suspend in state check intended for USB3 only
Date:   Fri, 11 Jan 2019 15:07:31 +0100
Message-Id: <20190111131046.711762405@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131045.137499039@linuxfoundation.org>
References: <20190111131045.137499039@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit 45f750c16cae3625014c14c77bd9005eda975d35 upstream.

The code to prevent a bus suspend if a USB3 port was still in link training
also reacted to USB2 port polling state.
This caused bus suspend to busyloop in some cases.
USB2 polling state is different from USB3, and should not prevent bus
suspend.

Limit the USB3 link training state check to USB3 root hub ports only.
The origial commit went to stable so this need to be applied there as well

Fixes: 2f31a67f01a8 ("usb: xhci: Prevent bus suspend if a port connect change or polling state is detected")
Cc: stable@vger.kernel.org
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-hub.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -1329,7 +1329,8 @@ int xhci_bus_suspend(struct usb_hcd *hcd
 		portsc_buf[port_index] = 0;
 
 		/* Bail out if a USB3 port has a new device in link training */
-		if ((t1 & PORT_PLS_MASK) == XDEV_POLLING) {
+		if ((hcd->speed >= HCD_USB3) &&
+		    (t1 & PORT_PLS_MASK) == XDEV_POLLING) {
 			bus_state->bus_suspended = 0;
 			spin_unlock_irqrestore(&xhci->lock, flags);
 			xhci_dbg(xhci, "Bus suspend bailout, port in polling\n");



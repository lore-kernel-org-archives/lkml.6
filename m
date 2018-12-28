Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D3BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF4AC2184B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999483;
	bh=urz0nclJ7Y1zmmtX+AVrbaHnye+U41xDjfW+rXTbBbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M2Bj7CEMCA9Elas1TCmXp7NfNgj3WeDtuRa/7BPQiu15VY674nh94TJoQsA90eR/C
	 JIHZRQvqfjfu3X3L8XocwiK/8MlJl5IvsqZWkIlrp1LjEg4oVoMwdxH8Tt+pi7J/nL
	 7XDK4aUk22arBNYIkRLxeFsBMwWtybLsiOUCwL/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733081AbeL1MSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:18:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:37080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbeL1MR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:17:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFA70218F0;
        Fri, 28 Dec 2018 12:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999477;
        bh=urz0nclJ7Y1zmmtX+AVrbaHnye+U41xDjfW+rXTbBbw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wXc3eZA2ulzTiIVT/1w3+pXZ0zuhFqdmCsSMT+YYN+2ohAJ4W1IJR16kLEprxL/cb
         f5iXokTJQ0Ox9MGfjRWkOeU4tjU0mukHmJsAWMJZUAYpyt4le9rRpbDzNchCBoc+w7
         DGuA6rVugnVUoyrvfrPjoMq5RHxnWj4PZ0hg2wT4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.9 05/22] xhci: Dont prevent USB2 bus suspend in state check intended for USB3 only
Date:   Fri, 28 Dec 2018 12:52:42 +0100
Message-Id: <20181228113126.506978683@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113126.144310132@linuxfoundation.org>
References: <20181228113126.144310132@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1353,7 +1353,8 @@ int xhci_bus_suspend(struct usb_hcd *hcd
 		portsc_buf[port_index] = 0;
 
 		/* Bail out if a USB3 port has a new device in link training */
-		if ((t1 & PORT_PLS_MASK) == XDEV_POLLING) {
+		if ((hcd->speed >= HCD_USB3) &&
+		    (t1 & PORT_PLS_MASK) == XDEV_POLLING) {
 			bus_state->bus_suspended = 0;
 			spin_unlock_irqrestore(&xhci->lock, flags);
 			xhci_dbg(xhci, "Bus suspend bailout, port in polling\n");



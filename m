Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D441C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F48C20675
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999683;
	bh=iswoIo8hIR7L5r1Eur5PMcmykedhbk7C3VZmkcTVVPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0QN3p4IbhWk3NUTtgKToMnIrsc5bev+frqiujXxKDQUy2SdSmJTO7VY5yYJ4mRuYx
	 dIA4yF7fEATDSvNLfMxsIQGvkhN9s/VCgK8U8ZnmjxfghgxeH0Fliy3z+/Fqsx7sWB
	 qkbHA8iqY4Ir0BEqMrxJHYjH6QJdKOzKt6aYy2js=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732612AbeL1MQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:16:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:35132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732555AbeL1MQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:16:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 686802146F;
        Fri, 28 Dec 2018 12:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999362;
        bh=iswoIo8hIR7L5r1Eur5PMcmykedhbk7C3VZmkcTVVPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kad7jnUu5gO83LTpwCPCrCcIJtbpooCf4X6eluJNG7mWUi1oanr/J5Ss5/MDhGVkn
         anWeN7d47dEnhfU/mbIR+kOoPaiaMd/YzAhE3De1ZBkPPCkvhr9Od4+pn6UzCivRg0
         10nHqGOawxDXyyg4C+I+HL2k1cFnlNXFbymquoRw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.14 09/36] xhci: Dont prevent USB2 bus suspend in state check intended for USB3 only
Date:   Fri, 28 Dec 2018 12:52:25 +0100
Message-Id: <20181228113127.142487229@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113126.526729877@linuxfoundation.org>
References: <20181228113126.526729877@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1512,7 +1512,8 @@ int xhci_bus_suspend(struct usb_hcd *hcd
 		portsc_buf[port_index] = 0;
 
 		/* Bail out if a USB3 port has a new device in link training */
-		if ((t1 & PORT_PLS_MASK) == XDEV_POLLING) {
+		if ((hcd->speed >= HCD_USB3) &&
+		    (t1 & PORT_PLS_MASK) == XDEV_POLLING) {
 			bus_state->bus_suspended = 0;
 			spin_unlock_irqrestore(&xhci->lock, flags);
 			xhci_dbg(xhci, "Bus suspend bailout, port in polling\n");



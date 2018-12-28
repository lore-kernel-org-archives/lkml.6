Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B178CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBF22146F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999306;
	bh=eWUvJZkPJBd7nyvvBAdYKqq1G4iKPrUO1RQj/kFKZ10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mO9707pDHWqz0ciFMltybdwdb33G2f6IePmGj6tNLCF99SCDr9vfl/LGP74uKcrkN
	 ZLKHQnTHNIEMUJT2j2n6Bz9b3FOhwf4NApsDZVCiLZh7t8ml7D3cMya24hTKY7fcut
	 uzQM7K4ywGfJpbPcjZNBFOhjBs7lnmCNHpS714g4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbeL1MPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:15:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:33916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731342AbeL1MO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:14:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7A84218FE;
        Fri, 28 Dec 2018 12:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999297;
        bh=eWUvJZkPJBd7nyvvBAdYKqq1G4iKPrUO1RQj/kFKZ10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1ktiaOwDRd7UIGvNIcKcfkonoce6ED8rum21ju5LI3Qhh/21F6XW/edL/h9UFwDEV
         3ZqXrPLc+YQSSn/W2PMRRXB8pMCNoKUVhlRfk+blmEjAHqzBby+PT2i4Yp5TvbPP84
         9cMrumOy8VRdAOBO3D2WAHafGH0Z+gtKpqEoMUW0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.19 04/46] xhci: Dont prevent USB2 bus suspend in state check intended for USB3 only
Date:   Fri, 28 Dec 2018 12:51:58 +0100
Message-Id: <20181228113125.146588313@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113124.971620049@linuxfoundation.org>
References: <20181228113124.971620049@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1507,7 +1507,8 @@ int xhci_bus_suspend(struct usb_hcd *hcd
 		portsc_buf[port_index] = 0;
 
 		/* Bail out if a USB3 port has a new device in link training */
-		if ((t1 & PORT_PLS_MASK) == XDEV_POLLING) {
+		if ((hcd->speed >= HCD_USB3) &&
+		    (t1 & PORT_PLS_MASK) == XDEV_POLLING) {
 			bus_state->bus_suspended = 0;
 			spin_unlock_irqrestore(&xhci->lock, flags);
 			xhci_dbg(xhci, "Bus suspend bailout, port in polling\n");



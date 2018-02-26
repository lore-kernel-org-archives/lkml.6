Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3726165-1519677315-2-12847796383143082516
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519677314; b=HkNMlCCD6P98QNJ7VB/OQJ3BofFbcrml3G4ZEvrX9Po0wDn
    hy3jIOqWAHVgJE6Acb7dZzx4JyVUY+PzxkaX+sqypNf6wLmPUpubcJKemn8v43Y4
    qniCspE9zLVrn61PGNwi1ynm/D+JqOvNbuZuTIRIzYSknMBm3Mi0ELkb/tBG4oSM
    zFBSSM4FivPs5TF/fsVO+FQP1AJ/gppBILiUTaBd2VFtMbMurvxI9ebG8ZGqRxPa
    B/D1+uowZBlItSMvHRDG2wNExtjtXmiHOwjAezOZ46P1//D4NZzxqSNKoKYILEsh
    wAgtfCh+a36RpfO4xYozDBx0CcRaQ2g+CLBT8ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519677314; bh=GGahBPEtUb6XEiFE1wp/lqXYP9
    na8xcBcwgeW8Qg6tw=; b=BpNbgCmliW/z20DtMczb7W+vA1bnAyBTX2fgJ2ZRFr
    SM9GDfEFvGG/JnZGv5BEqzxWSS9hEb8c4o2CdfYwwtLOD39OYQcpF1TPh9Lwl9/+
    UrZN73wNiHjoLjyVQYVU37Ay69RWY+XR5410BYtK5KqRhjl6jl4aMnIHbQcksims
    6u/oTvdBHD8sVpGv2CkcfkvVU9PpQfyOiipZnsi9ICavCjxMOabqMZj+JXZfd9oZ
    F2Tt+ZyRCE+KMFlONejvaI5lP0j3dC7m4cILgMTVmcDy9QOkGZdolpRiwocMfbhG
    blitNdqogawzBrBItfpsl4PL9rhPLpRGnrM8vWHiHf6Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753384AbeBZU16 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 15:27:58 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36946 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753758AbeBZU1z (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 15:27:55 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Chen <peter.chen@nxp.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 4.15 44/64] usb: host: ehci: use correct device pointer for dma ops
Date: Mon, 26 Feb 2018 21:22:21 +0100
Message-Id: <20180226202155.327690673@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Chen <hzpeterchen@gmail.com>

commit 02a10f061a3f8bca1b37332672f50a107198adbe upstream.

commit a8c06e407ef9 ("usb: separate out sysdev pointer from usb_bus")
converted to use hcd->self.sysdev for DMA operations instead of
hcd->self.controller, but forgot to do it for hcd test mode. Replace
the correct one in this commit.

Fixes: a8c06e407ef9 ("usb: separate out sysdev pointer from usb_bus")
Signed-off-by: Peter Chen <peter.chen@nxp.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/ehci-hub.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/host/ehci-hub.c
+++ b/drivers/usb/host/ehci-hub.c
@@ -774,12 +774,12 @@ static struct urb *request_single_step_s
 	atomic_inc(&urb->use_count);
 	atomic_inc(&urb->dev->urbnum);
 	urb->setup_dma = dma_map_single(
-			hcd->self.controller,
+			hcd->self.sysdev,
 			urb->setup_packet,
 			sizeof(struct usb_ctrlrequest),
 			DMA_TO_DEVICE);
 	urb->transfer_dma = dma_map_single(
-			hcd->self.controller,
+			hcd->self.sysdev,
 			urb->transfer_buffer,
 			urb->transfer_buffer_length,
 			DMA_FROM_DEVICE);

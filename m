Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3726165-1519677329-2-15094933033836648765
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
    t=1519677329; b=FS6X5Zmy18wq5ZKsRHKbyIT9G9GUQswQtKssCelUQ+grsMq
    57W+lGYVrQkXcsajvx804cPB8P01nvGJVM9R6UIBZ97lwNaNh2Ie5xoo1LNvHWxk
    QM/YiNKZ8YxtoNb9hzEZbZg3kUuWo/d33qVvPYu7p/7+U82G8hAXZ3PmFYpH9tyq
    CgmAXFIO/Z+j21M4hnK28g8Qhfx7RLFiFoW/L4/nPh12AZHFLSoGqJi5l3BZ+jJK
    UVyl8z30LoRoDrsgdnEL1RQXExWKZUDoAtKxWmyoqRgf9/Vg6MlxzUbQKE9zDVbG
    0s9bvoQGuCR/tYen91BxgdiGEGoqyae8C87Rqiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519677329; bh=8zrgYiVrELcnUf8ZsxS3njXAIN
    sFE4+3CQD5lj+diWc=; b=GAzHQyu98fY2xv96EIvjUMoxzP9ToYQ8QM8SesDJRO
    BtiSode9OABBJ8RFfm8zXPpnRCLMEcehh1MffFj7T2JeXNU7GxXuPDilczRQXio+
    oFwaVqKYPTNxxEUJkmwn4g55fEVST4UGD+2FLGw6CMcQ7nAAcR/98A7Fty39MWVg
    eJStyt1TnJypFlc/xv2Elt595JJ6IOSDfJgi7gn57kQDqFyNtXtywNfXhy2HN0rA
    YWQoah2KrMzZOXDkmVGhCt9GAWWXPkqCedQA489Z/zbK/ht22SIi5g3YycX94OjB
    EdaInzi84M1/ywbAwUrBffZXbDuL2pgsDERuzAJjqjlw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750877AbeBZUfM (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 15:35:12 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36974 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753820AbeBZU16 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 15:27:58 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thinh Nguyen <thinhn@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.15 45/64] usb: dwc3: gadget: Set maxpacket size for ep0 IN
Date: Mon, 26 Feb 2018 21:22:22 +0100
Message-Id: <20180226202155.369082229@linuxfoundation.org>
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

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

commit 6180026341e852a250e1f97ebdcf71684a3c81b9 upstream.

There are 2 control endpoint structures for DWC3. However, the driver
only updates the OUT direction control endpoint structure during
ConnectDone event. DWC3 driver needs to update the endpoint max packet
size for control IN endpoint as well. If the max packet size is not
properly set, then the driver will incorrectly calculate the data
transfer size and fail to send ZLP for HS/FS 3-stage control read
transfer.

The fix is simply to update the max packet size for the ep0 IN direction
during ConnectDone event.

Cc: stable@vger.kernel.org
Fixes: 72246da40f37 ("usb: Introduce DesignWare USB3 DRD Driver")
Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/gadget.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2744,6 +2744,8 @@ static void dwc3_gadget_conndone_interru
 		break;
 	}
 
+	dwc->eps[1]->endpoint.maxpacket = dwc->gadget.ep0->maxpacket;
+
 	/* Enable USB2 LPM Capability */
 
 	if ((dwc->revision > DWC3_REVISION_194A) &&

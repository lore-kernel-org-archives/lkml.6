Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3759000-1519415608-2-8101516518112232388
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
    t=1519415607; b=Ou9ELHzewfFDMphai9bnUNsbrQu0xLNQxkjH9M681ObhlVz
    DQ3XTMyvrm1HIQwgmx1LVs9azU0BsgghDqyZQyn5nl82+COKyWZcu3oupJ+j9REj
    I+Cgb1dIDM42W84e7DcurkWw76ig0x6bgxR5i7146628wYyQV6NFC4WPqQfz+Y3y
    SP7M6Kiq5xoLAZWG7LUsLwmCOc1NT3WBQmC9detxNaXoo5E+/6H72UbCyTy7NnMv
    +mOR3HlSrEsOb4ZRa/8qcQGa0zgUCRwd+vp/qgmMZYqOJGBWBjlMqHVakRZJWwlv
    Hgijga246aptl2SzYb5U51JLP4sxRV0d3c45T2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415607; bh=wUXa8+9aSCFrTDc0UjBCgAj3lh
    IGlS7blDRe2rBrvdQ=; b=RMV17qsihj6drJulEXf84HPOzTbEwV03H0MjuOIQnc
    YRF+YjqR1j3gpbnHdLxtf4TqWAnfSpAFTgDqybf6ZTrqOPehWsJka8nx71I2NF8X
    9rIZBjjaO09mVEhyuwk0rI4bZ45pJIyYtOMbORe0If2PNhH7OXlQrpoSjDj421pa
    inPwPMy+U+ejLrt4NH7zjLqslXg6epqzCTQBgNzKwOoGkXDNyUK41lzOZGM6VCdP
    pNkg7J9vLhQLPnr84blQmPXEOuHomoQlhz1L8FqV2msBwfuBDIpfek7Mh9V3ybAx
    0J3axanQe+cIckkFQvi6RaSTMrnd2As3rjqirS9YWd1w==
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
        id S933806AbeBWSpc (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:45:32 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43366 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933330AbeBWSpa (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:45:30 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 073/145] dmaengine: at_hdmac: fix potential NULL pointer dereference in atc_prep_dma_interleaved
Date: Fri, 23 Feb 2018 19:26:19 +0100
Message-Id: <20180223170734.126332999@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>


[ Upstream commit 62a277d43d47e74972de44d33bd3763e31992414 ]

_xt_ is being dereferenced before it is null checked, hence there is a
potential null pointer dereference.

Fix this by moving the pointer dereference after _xt_ has been null
checked.

This issue was detected with the help of Coccinelle.

Fixes: 4483320e241c ("dmaengine: Use Pointer xt after NULL check.")
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/at_hdmac.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -709,7 +709,7 @@ atc_prep_dma_interleaved(struct dma_chan
 			 unsigned long flags)
 {
 	struct at_dma_chan	*atchan = to_at_dma_chan(chan);
-	struct data_chunk	*first = xt->sgl;
+	struct data_chunk	*first;
 	struct at_desc		*desc = NULL;
 	size_t			xfer_count;
 	unsigned int		dwidth;
@@ -721,6 +721,8 @@ atc_prep_dma_interleaved(struct dma_chan
 	if (unlikely(!xt || xt->numf != 1 || !xt->frame_size))
 		return NULL;
 
+	first = xt->sgl;
+
 	dev_info(chan2dev(chan),
 		 "%s: src=%pad, dest=%pad, numf=%d, frame_size=%d, flags=0x%lx\n",
 		__func__, &xt->src_start, &xt->dst_start, xt->numf,

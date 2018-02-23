Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3841409-1519418876-2-12551995071137446697
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519418875; b=K7sxNBJOlJEWtqByIOVhsrAjFJc9fEysdlB1MXlBdW66l9R
    epAugrZQIWWRXmmDtP2p2VjH3z6oRhIc7a0Evnim3JvlROnVINuyBVTx6/sn6Jkt
    xcbsXvMXwsh1+TLRTqruxS/14fZnr9vwLnX1cUpVueQp9UdRtgfwOJFBfLEWqmXL
    0dwCihdb+J5oiNPQoQdQniNaOnvlME9kioJnUM3jsGSv2Ih7DkZYLLORymuVxDqx
    PS3pXRxBKy+3eCVgv5QXP2+mJ0FNdF2XQZNQgz1nrI7uF5WS/OkP3WDp0UjcXrdU
    qzyFo9kavhP1yoYLy0XvQcin/XnXPOJesVpEDqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519418875; bh=fq87fmeWC4Qb8iB+4JxFfxs6yR
    ydVLqbpSL0jUcWobc=; b=XiIA8UuV3P4HtkGMMn156bsFZpvkC+Z2x5M6RJAEiK
    pR2WZw9mFJO8tbcHysPDIvrnBuk2ZouIVGna8q0Q0NsPSBrQg27gjWka98Y5l7bK
    Wz68REawTjue268xfU2h6PvG6eP7tgYFYaYUEVO77D7/dQW5GrRSS6mLKCbOkJNF
    3Yu3ekxmXaZ/ch1Im2fdxrM3U7fKpHCXINXxmwFOYHlUe6JV6ctRUeVWC4kG5Lyk
    tGZ+Jj81is+MamGiPvaX6t4xC4mf73f532hS1slgbi1iQDEN1b2N5MpCu2pAdCBY
    S7gXPx8TmSP9TbMeP3szdTLXIws7jTs24EgZN8jkbvoQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752848AbeBWUrb (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 15:47:31 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35808 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752736AbeBWScF (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:32:05 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tobias Jordan <Tobias.Jordan@elektrobit.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 52/58] dmaengine: jz4740: disable/unprepare clk if probe fails
Date: Fri, 23 Feb 2018 19:26:51 +0100
Message-Id: <20180223170214.923328434@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170206.724655284@linuxfoundation.org>
References: <20180223170206.724655284@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tobias Jordan <Tobias.Jordan@elektrobit.com>


[ Upstream commit eb9436966fdc84cebdf222952a99898ab46d9bb0 ]

in error path of jz4740_dma_probe(), call clk_disable_unprepare() to clean
up.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: 25ce6c35fea0 MIPS: jz4740: Remove custom DMA API
Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/dma-jz4740.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/dma/dma-jz4740.c
+++ b/drivers/dma/dma-jz4740.c
@@ -575,7 +575,7 @@ static int jz4740_dma_probe(struct platf
 
 	ret = dma_async_device_register(dd);
 	if (ret)
-		return ret;
+		goto err_clk;
 
 	irq = platform_get_irq(pdev, 0);
 	ret = request_irq(irq, jz4740_dma_irq, 0, dev_name(&pdev->dev), dmadev);
@@ -588,6 +588,8 @@ static int jz4740_dma_probe(struct platf
 
 err_unregister:
 	dma_async_device_unregister(dd);
+err_clk:
+	clk_disable_unprepare(dmadev->clk);
 	return ret;
 }
 

Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3759000-1519415540-2-11311721299743605663
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415539; b=jJvAqNhKXJ0TGVAvFFEu7WGSbB6pyHA1Pz7LT0WB9+SPfRv
    mu6CDqsoDEfCWHTCoDpDzwr66gpH33jGKLGCMiqQ+zCGLuJeh4+anpHJIWoxmrUJ
    zjbd2BDrdG/XtBIRqe9OpzAH/SKVVt0XNC0wbUeO3Ch4hvxEpDGwdmY8cPOfmDk/
    BjQK+/PJQKSbKqyPKOi3/3F1N5cX7/o0P11pR7hovrzJEWjgBA4WMk84Lzn9J7t/
    6jNCHHW3TW9jS4j/VnTypx1uJ/891yHsGIsIGIP7sXqXXFtzPaVaD5IZAvgoaO8n
    lbfN9XR7zya0HzDvvFyYQtq9JisZIPGY16WfFvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415539; bh=xzzwYZ8rTNsG6BFybiuffHAxL8
    01GpwPiugiExr/0jM=; b=gGF+IWJUYTQuEi2S1y3QHineEUwzfb6u1/Svj6pH83
    eKdaL1j+BJ0pO7BZM655DJ85hW+fWey4c9vEW5Uu5+Jt29NngMJ7HMIW8xtltmVT
    doyLi8mvq9q3QB0KXbZqsRoT5HsUr0KXaDlz2/PyZY5aYTcuOTQmrzWZWADBq3PO
    TOhQSNMrN5767TsS4ykxWaJAwBFgE753bpf8mJmq0td4y1Ng0ULXuZPAanYnkxB1
    twVX8DAlXRF7PofT2JhIXegjS5OgnU8R9USDInblwcaHjAhXsSy6VfB9JlBUreWi
    7x7CIvWlc2bA7xWIZBWzPujF/jEFBFOqpIWMRBhljrng==
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
        id S1754908AbeBWTwB (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:52:01 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43446 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933872AbeBWSpr (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:45:47 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tobias Jordan <Tobias.Jordan@elektrobit.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 079/145] dmaengine: jz4740: disable/unprepare clk if probe fails
Date: Fri, 23 Feb 2018 19:26:25 +0100
Message-Id: <20180223170734.947559180@linuxfoundation.org>
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
@@ -555,7 +555,7 @@ static int jz4740_dma_probe(struct platf
 
 	ret = dma_async_device_register(dd);
 	if (ret)
-		return ret;
+		goto err_clk;
 
 	irq = platform_get_irq(pdev, 0);
 	ret = request_irq(irq, jz4740_dma_irq, 0, dev_name(&pdev->dev), dmadev);
@@ -568,6 +568,8 @@ static int jz4740_dma_probe(struct platf
 
 err_unregister:
 	dma_async_device_unregister(dd);
+err_clk:
+	clk_disable_unprepare(dmadev->clk);
 	return ret;
 }
 

Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182439-1521807323-2-13452608208725270576
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521807322; b=GMvd6xuj2NmYEihHhThggq4jqXy2h9F3SqMddnNEfta2DJS
    Br8ioLwjHYI/yI8x1iNpR+RRCR10w4f4iXWHYhlMldnVpJ42CdABZal9FiLehQbe
    3EhAob1PC+tCeGmqc9ZFeda39xm7l1lM5nkDzS98qILctKzcEmtv5RP8BkOIBS+j
    NzcRWbO2427lCT/RK8GOklpxV9NlR1+XtPInbzpJLoC54NjUBXHv0XoBuB1mz+i1
    ceqncM0HqOCre9aWamOKqdhdgvuzV5ZKGrbyI1RrPlv2J/u/1X8yji+qxiQEqbWL
    6pnUcTiY62xtSmxvmW+88i5k1xcGdxxvey1KqWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521807322; bh=vJCdFSmpLEe5UjxpBCZwfyOojv
    /d79h/LKEYEpujGdU=; b=jboQyTn2kJYWIHnx2pfijbGWJsNNMYR3nrWMwgG6bf
    HiHdgEV+Im2fsINyBxGucBBs5MepJ4cg+L5X/oalfPzChIHtOpkWantW3OBlu5Xd
    xkPynO7uTn7nNd4Eh4snU94GpeFAy76TIvxkR+T6W1+h4+xCZjMDRgvLnm8OSQHg
    OPRmFXUMbmdSU3ScXFX2W1yNPgocILoIl57Ul+qnb2brL9gRmj26CwO5dG3rlVT2
    w+9hG9ptLB3/FxJUdAyE1c2zqhyxYPcMw6j7pQWmzbCu1pM37Z+D68INUJHrzP1T
    Spz61aiI0Afc9vxbopjyBDbPvrDsXH5EBDV9RP5DSa+g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752800AbeCWMO7 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 08:14:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34166 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752406AbeCWJ46 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:56:58 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kedareswara rao Appana <appanad@xilinx.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 29/84] dmaengine: zynqmp_dma: Fix race condition in the probe
Date: Fri, 23 Mar 2018 10:53:43 +0100
Message-Id: <20180323095416.293246720@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
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

From: Kedareswara rao Appana <appana.durga.rao@xilinx.com>


[ Upstream commit 5ba080aada5e739165e0f38d5cc3b04c82b323c8 ]

Incase of interrupt property is not present,
Driver is trying to free an invalid irq,
This patch fixes it by adding a check before freeing the irq.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/xilinx/zynqmp_dma.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -838,7 +838,8 @@ static void zynqmp_dma_chan_remove(struc
 	if (!chan)
 		return;
 
-	devm_free_irq(chan->zdev->dev, chan->irq, chan);
+	if (chan->irq)
+		devm_free_irq(chan->zdev->dev, chan->irq, chan);
 	tasklet_kill(&chan->tasklet);
 	list_del(&chan->common.device_node);
 	clk_disable_unprepare(chan->clk_apb);

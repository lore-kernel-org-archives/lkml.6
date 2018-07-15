Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB023ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 15:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E3A21473
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 15:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metanate.com header.i=@metanate.com header.b="r9Hld/V5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E3A21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=metanate.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbeGOPfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 11:35:01 -0400
Received: from dougal.metanate.com ([90.155.101.14]:32546 "EHLO metanate.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726224AbeGOPfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 11:35:01 -0400
X-Greylist: delayed 1278 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Jul 2018 11:35:00 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=metanate.com;
         s=stronger; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vkQdFU1BQsDAnCJf+QmX/RQ6w1vx9gZKvHY8xOJ3/Tg=; b=r9Hld/V5SQEdgMrIh3CpD8OpGO
        UuXQ+bDaO7oBqFs7kRO+DrUXylciqA0gHBf8EfqDW1k3fYil0PN5bXtQIvj0VArXVu70MgRBeGu88
        PYrApdgWwSF5SHNlKdwsCW7u++fSzkgwcKCPjxro1r2n4RLggJHgMuTmISbyzdXV6ZiNaB9wvFof3
        bPNyEP6T5zYj1nZ0/Un9Yq+bjczuCIgXyItJ1OlQJIxAW7mSluIiX8UHRFvgF86jfTERpXb1dPZ98
        etNoUmPLCguKrBlDx24zzXHIaD8OLMaB/HdE1prZzHJJrQnNm1ZT+OJpBbkearOl1yLmojmycY3da
        KKmRirOQ==;
Received: from johnkeeping.plus.com ([81.174.171.191] helo=localhost.localdomain)
        by shrek.metanate.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <john@metanate.com>)
        id 1feiLy-00024m-9M; Sun, 15 Jul 2018 15:50:26 +0100
From:   John Keeping <john@metanate.com>
To:     Minas Harutyunyan <hminas@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Razmik Karapetyan <razmik@synopsys.com>,
        John Keeping <john@metanate.com>
Subject: [PATCH] usb: dwc2: avoid NULL dereferences
Date:   Sun, 15 Jul 2018 15:50:43 +0100
Message-Id: <20180715145043.25379-1-john@metanate.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For unidirectional endpoints, the endpoint pointer will be NULL for the
unused direction.  Check that the endpoint is active before
dereferencing this pointer.

Fixes: 1b4977c793d3 ("usb: dwc2: Update dwc2_handle_incomplete_isoc_in() function")
Fixes: 689efb2619b5 ("usb: dwc2: Update dwc2_handle_incomplete_isoc_out() function")
Fixes: d84845522d93 ("usb: dwc2: Update GINTSTS_GOUTNAKEFF interrupt handling")
Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/usb/dwc2/gadget.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index a0f82cca2d9a..cefc99ae69b2 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -3430,7 +3430,7 @@ static void dwc2_gadget_handle_incomplete_isoc_in(struct dwc2_hsotg *hsotg)
 	for (idx = 1; idx < hsotg->num_of_eps; idx++) {
 		hs_ep = hsotg->eps_in[idx];
 		/* Proceed only unmasked ISOC EPs */
-		if (!hs_ep->isochronous || (BIT(idx) & ~daintmsk))
+		if ((BIT(idx) & ~daintmsk) || !hs_ep->isochronous)
 			continue;
 
 		epctrl = dwc2_readl(hsotg->regs + DIEPCTL(idx));
@@ -3476,7 +3476,7 @@ static void dwc2_gadget_handle_incomplete_isoc_out(struct dwc2_hsotg *hsotg)
 	for (idx = 1; idx < hsotg->num_of_eps; idx++) {
 		hs_ep = hsotg->eps_out[idx];
 		/* Proceed only unmasked ISOC EPs */
-		if (!hs_ep->isochronous || (BIT(idx) & ~daintmsk))
+		if ((BIT(idx) & ~daintmsk) || !hs_ep->isochronous)
 			continue;
 
 		epctrl = dwc2_readl(hsotg->regs + DOEPCTL(idx));
@@ -3650,7 +3650,7 @@ static irqreturn_t dwc2_hsotg_irq(int irq, void *pw)
 		for (idx = 1; idx < hsotg->num_of_eps; idx++) {
 			hs_ep = hsotg->eps_out[idx];
 			/* Proceed only unmasked ISOC EPs */
-			if (!hs_ep->isochronous || (BIT(idx) & ~daintmsk))
+			if ((BIT(idx) & ~daintmsk) || !hs_ep->isochronous)
 				continue;
 
 			epctrl = dwc2_readl(hsotg->regs + DOEPCTL(idx));
-- 
2.18.0


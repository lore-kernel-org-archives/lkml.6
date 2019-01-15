Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A90C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298DF20651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbfAONnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:43:52 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50768 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729245AbfAONns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:43:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E2F3EBD;
        Tue, 15 Jan 2019 05:43:48 -0800 (PST)
Received: from e110176-lin.kfn.arm.com (e110176-lin.kfn.arm.com [10.50.4.178])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 421483F70D;
        Tue, 15 Jan 2019 05:43:47 -0800 (PST)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] crypto: ccree: shared irq lines are not a bug
Date:   Tue, 15 Jan 2019 15:43:16 +0200
Message-Id: <20190115134318.28712-7-gilad@benyossef.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115134318.28712-1-gilad@benyossef.com>
References: <20190115134318.28712-1-gilad@benyossef.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ccree driver was logging an error if it got an interrupt but
HW indicated nothing to do as might happen if sharing an irq line.
Remove the error as this is normal and we already have a debug
print for the IRR register value.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 drivers/crypto/ccree/cc_driver.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/ccree/cc_driver.c b/drivers/crypto/ccree/cc_driver.c
index 8ada308d72ee..e75fbe7a8f84 100644
--- a/drivers/crypto/ccree/cc_driver.c
+++ b/drivers/crypto/ccree/cc_driver.c
@@ -103,10 +103,10 @@ static irqreturn_t cc_isr(int irq, void *dev_id)
 	/* read the interrupt status */
 	irr = cc_ioread(drvdata, CC_REG(HOST_IRR));
 	dev_dbg(dev, "Got IRR=0x%08X\n", irr);
-	if (irr == 0) { /* Probably shared interrupt line */
-		dev_err(dev, "Got interrupt with empty IRR\n");
+
+	if (irr == 0) /* Probably shared interrupt line */
 		return IRQ_NONE;
-	}
+
 	imr = cc_ioread(drvdata, CC_REG(HOST_IMR));
 
 	/* clear interrupt - must be before processing events */
-- 
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id U5+uONRNGVtTcwAAmS7hNA
	; Thu, 07 Jun 2018 15:23:01 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D2515608B8; Thu,  7 Jun 2018 15:23:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 04CFD6063F;
	Thu,  7 Jun 2018 15:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 04CFD6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935803AbeFGPW6 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:22:58 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41219 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935544AbeFGO6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:58:50 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbe-0005hL-EK; Thu, 07 Jun 2018 15:09:38 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb6-000324-Ot; Thu, 07 Jun 2018 15:09:04 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        "=?UTF-8?q?Horia=20Geant=C4=83?=" <horia.geanta@nxp.com>,
        "Auer Lukas" <lukas.auer@aisec.fraunhofer.de>,
        "Bryan O'Donoghue" <pure.logic@nexus-software.ie>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.855397034@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 218/410] crypto: caam - fix endless loop when DECO
 acquire fails
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Horia Geantă <horia.geanta@nxp.com>

commit 225ece3e7dad4cfc44cca38ce7a3a80f255ea8f1 upstream.

In case DECO0 cannot be acquired - i.e. run_descriptor_deco0() fails
with -ENODEV, caam_probe() enters an endless loop:

run_descriptor_deco0
	ret -ENODEV
	-> instantiate_rng
		-ENODEV, overwritten by -EAGAIN
		ret -EAGAIN
		-> caam_probe
			-EAGAIN results in endless loop

It turns out the error path in instantiate_rng() is incorrect,
the checks are done in the wrong order.

Fixes: 1005bccd7a4a6 ("crypto: caam - enable instantiation of all RNG4 state handles")
Reported-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Suggested-by: Auer Lukas <lukas.auer@aisec.fraunhofer.de>
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/crypto/caam/ctrl.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -196,12 +196,16 @@ static int instantiate_rng(struct device
 		 * without any error (HW optimizations for later
 		 * CAAM eras), then try again.
 		 */
+		if (ret)
+			break;
+
 		rdsta_val =
 			rd_reg32(&topregs->ctrl.r4tst[0].rdsta) & RDSTA_IFMASK;
-		if (status || !(rdsta_val & (1 << sh_idx)))
+		if (status || !(rdsta_val & (1 << sh_idx))) {
 			ret = -EAGAIN;
-		if (ret)
 			break;
+		}
+
 
 		dev_info(ctrldev, "Instantiated RNG4 SH%d\n", sh_idx);
 		/* Clear the contents before recreating the descriptor */

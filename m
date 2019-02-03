Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A40C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C082084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbfBCOW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:22:59 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55910 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730610AbfBCOVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:21:42 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIeT-0006TD-6Q; Sun, 03 Feb 2019 14:21:41 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9t-0007Qr-Qt; Sun, 03 Feb 2019 14:50:05 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Ulf Hansson" <ulf.hansson@linaro.org>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.992824529@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 288/305] mmc: core: Reset HPI enabled state during
 re-init and in case of errors
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ulf Hansson <ulf.hansson@linaro.org>

commit a0741ba40a009f97c019ae7541dc61c1fdf41efb upstream.

During a re-initialization of the eMMC card, we may fail to re-enable HPI.
In these cases, that isn't properly reflected in the card->ext_csd.hpi_en
bit, as it keeps being set. This may cause following attempts to use HPI,
even if's not enabled. Let's fix this!

Fixes: eb0d8f135b67 ("mmc: core: support HPI send command")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/mmc/core/mmc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1418,9 +1418,11 @@ static int mmc_init_card(struct mmc_host
 		if (err) {
 			pr_warning("%s: Enabling HPI failed\n",
 				   mmc_hostname(card->host));
+			card->ext_csd.hpi_en = 0;
 			err = 0;
-		} else
+		} else {
 			card->ext_csd.hpi_en = 1;
+		}
 	}
 
 	/*


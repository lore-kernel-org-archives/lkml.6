Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C797C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15CC120859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388630AbfAOSDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 13:03:41 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50336 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729928AbfAOSDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 13:03:41 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gjT3q-0002nF-Nb; Tue, 15 Jan 2019 18:03:38 +0000
From:   Colin King <colin.king@canonical.com>
To:     Chas Williams <3chas3@gmail.com>,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] atm: he: fix sign-extension overflow on large shift
Date:   Tue, 15 Jan 2019 18:03:38 +0000
Message-Id: <20190115180338.32357-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Shifting the 1 by exp by an int can lead to sign-extension overlow when
exp is 31 since 1 is an signed int and sign-extending this result to an
unsigned long long will set the upper 32 bits.  Fix this by shifting an
unsigned long.

Detected by cppcheck:
(warning) Shifting signed 32-bit value by 31 bits is undefined behaviour

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/atm/he.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/atm/he.c b/drivers/atm/he.c
index 2e9d1cfe3aeb..211607986134 100644
--- a/drivers/atm/he.c
+++ b/drivers/atm/he.c
@@ -718,7 +718,7 @@ static int he_init_cs_block_rcm(struct he_dev *he_dev)
 			instead of '/ 512', use '>> 9' to prevent a call
 			to divdu3 on x86 platforms
 		*/
-		rate_cps = (unsigned long long) (1 << exp) * (man + 512) >> 9;
+		rate_cps = (unsigned long long) (1UL << exp) * (man + 512) >> 9;
 
 		if (rate_cps < 10)
 			rate_cps = 10;	/* 2.2.1 minimum payload rate is 10 cps */
-- 
2.19.1


Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13628C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 21:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D572520855
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 21:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfBBV7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 16:59:21 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:45868 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbfBBV7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 16:59:21 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gq3Jk-0003PI-M2; Sat, 02 Feb 2019 21:59:16 +0000
From:   Colin King <colin.king@canonical.com>
To:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: comedi: dt2811: fix integer overflow in multiply
Date:   Sat,  2 Feb 2019 21:59:16 +0000
Message-Id: <20190202215916.25753-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Multiplying two unsigned ints leads to an unsigned int result. The
intention is that the result is a unsigned long long, so to fix the
overflow cast the div to an unsigned long long to ensure that the
multiplication is on unsigned long longs to avoid overflow.

Detected by CoverityScan, CID#1357597 ("Unintentioal integer overflow")

Fixes: f2975a9b2ab9 ("staging: comedi: dt2811: add async command support for AI subdevice")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/comedi/drivers/dt2811.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/drivers/dt2811.c b/drivers/staging/comedi/drivers/dt2811.c
index 05207a519755..820e75f850ff 100644
--- a/drivers/staging/comedi/drivers/dt2811.c
+++ b/drivers/staging/comedi/drivers/dt2811.c
@@ -323,7 +323,8 @@ static unsigned int dt2811_ns_to_timer(unsigned int *nanosec,
 		for (_mult = 0; _mult <= 7; _mult++) {
 			unsigned int div = dt2811_clk_dividers[_div];
 			unsigned int mult = dt2811_clk_multipliers[_mult];
-			unsigned long long divider = div * mult;
+			unsigned long long divider =
+				(unsigned long long)div * mult;
 			unsigned int divisor = DT2811_TMRCTR_MANTISSA(_div) |
 					       DT2811_TMRCTR_EXPONENT(_mult);
 
-- 
2.20.1


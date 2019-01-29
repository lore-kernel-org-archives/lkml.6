Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECD7C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFCE621871
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbfA2KdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:33:06 -0500
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:39826 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbfA2KdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:33:04 -0500
Received: from [77.22.253.72] (helo=calia.hitronhub.home)
        by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <jan@schnhrr.de>)
        id 1goQXN-0003Gk-GU; Tue, 29 Jan 2019 11:22:37 +0100
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jan@schnhrr.de>
To:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jan@schnhrr.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] x86/tsc: Allow quick PIT calibration despite interruptions
Date:   Tue, 29 Jan 2019 11:23:28 +0100
Message-Id: <20190129102329.27610-2-jan@schnhrr.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190129102329.27610-1-jan@schnhrr.de>
References: <20190129102329.27610-1-jan@schnhrr.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Df-Sender: am5Ac2Nobmhyci5kZQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some systems experience regular interruptions (60 Hz SMI?), that prevent
the quick PIT calibration from succeeding: individual interruptions can be
so long, that the PIT MSB is observed to decrement by 2 or 3 instead of 1.
The existing code cannot recover from this.

The system in question is an AMD Ryzen Threadripper 2950X, microcode
0x800820b, on an ASRock Fatal1ty X399 Professional Gaming, BIOS P3.30.

Change the code to handle (almost) arbitrary interruptions, as long
as they happen only once in a while and they do not take too long.
Specifically, also cover an interruption during the very first reads.

Signed-off-by: Jan H. Schönherr <jan@schnhrr.de>
---
 arch/x86/kernel/tsc.c | 80 +++++++++++++++++++++++++------------------
 1 file changed, 46 insertions(+), 34 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index e9f777bfed40..a005e0aa215e 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -485,7 +485,7 @@ static inline int pit_verify_msb(unsigned char val)
 static inline int pit_expect_msb(unsigned char val, u64 *tscp, unsigned long *deltap)
 {
 	int count;
-	u64 tsc = 0, prev_tsc = 0;
+	u64 tsc = get_cycles(), prev_tsc = 0;
 
 	for (count = 0; count < 50000; count++) {
 		if (!pit_verify_msb(val))
@@ -500,7 +500,7 @@ static inline int pit_expect_msb(unsigned char val, u64 *tscp, unsigned long *de
 	 * We require _some_ success, but the quality control
 	 * will be based on the error terms on the TSC values.
 	 */
-	return count > 5;
+	return count > 0 && pit_verify_msb(val - 1);
 }
 
 /*
@@ -515,7 +515,8 @@ static inline int pit_expect_msb(unsigned char val, u64 *tscp, unsigned long *de
 static unsigned long quick_pit_calibrate(void)
 {
 	int i;
-	u64 tsc, delta;
+	u64 tsc = 0, delta;
+	unsigned char start;
 	unsigned long d1, d2;
 
 	if (!has_legacy_pic())
@@ -547,39 +548,50 @@ static unsigned long quick_pit_calibrate(void)
 	 */
 	pit_verify_msb(0);
 
-	if (pit_expect_msb(0xff, &tsc, &d1)) {
-		for (i = 1; i <= MAX_QUICK_PIT_ITERATIONS; i++) {
-			if (!pit_expect_msb(0xff-i, &delta, &d2))
-				break;
-
-			delta -= tsc;
-
-			/*
-			 * Extrapolate the error and fail fast if the error will
-			 * never be below 500 ppm.
-			 */
-			if (i == 1 &&
-			    d1 + d2 >= (delta * MAX_QUICK_PIT_ITERATIONS) >> 11)
-				return 0;
-
-			/*
-			 * Iterate until the error is less than 500 ppm
-			 */
-			if (d1+d2 >= delta >> 11)
-				continue;
-
-			/*
-			 * Check the PIT one more time to verify that
-			 * all TSC reads were stable wrt the PIT.
-			 *
-			 * This also guarantees serialization of the
-			 * last cycle read ('d2') in pit_expect_msb.
-			 */
-			if (!pit_verify_msb(0xfe - i))
-				break;
-			goto success;
+	for (i = 0xff; i > 0xf0; i--) {
+		if (!pit_expect_msb(i, &delta, &d2))
+			continue;
+
+		if (!tsc) {
+			/* first success */
+			tsc = delta;
+			d1 = d2;
+			continue;
+		}
+
+		/* second success */
+		if (d2 < d1) {
+			tsc = delta;
+			d1 = d2;
 		}
+		goto calibrate;
+	}
+
+	pr_info("Fast TSC calibration failed (couldn't even start)\n");
+	return 0;
+
+calibrate:
+	/*
+	 * Extrapolate the error and fail fast if the error will
+	 * never be below 500 ppm.
+	 */
+	if (d1 + d1 >= (delta * MAX_QUICK_PIT_ITERATIONS) >> 11) {
+		pr_info("Fast TSC calibration failed (wouldn't work)\n");
+		return 0;
+	}
+
+	start = i;
+	for (i = 1; i <= MAX_QUICK_PIT_ITERATIONS; i++) {
+		if (!pit_expect_msb(start - i, &delta, &d2))
+			continue;
+
+		delta -= tsc;
+
+		/* Stop when the error is less than 500 ppm */
+		if (d1 + d2 < delta >> 11)
+			goto success;
 	}
+
 	pr_info("Fast TSC calibration failed\n");
 	return 0;
 
-- 
2.19.2


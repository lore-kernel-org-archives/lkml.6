Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592F2C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2582D2080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2582D2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbeKLGFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:05:46 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53136 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731140AbeKLGFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:05:46 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvtB-0000oM-RI; Sun, 11 Nov 2018 19:59:21 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsO-0001PQ-KX; Sun, 11 Nov 2018 19:58:32 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Michael Ellerman" <mpe@ellerman.id.au>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.118234801@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 042/366] powerpc/lib: Fix the feature fixup tests to
 actually work
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

commit cad0e39023b43d94d5e38dfd55c103e15bdd093d upstream.

The code patching code has always been a bit confused about whether
it's best to use void *, unsigned int *, char *, etc. to point to
instructions. In fact in the feature fixups tests we use both unsigned
int[] and u8[] in different places.

Unfortunately the tests that use unsigned int[] calculate the size of
the code blocks using subtraction of those unsigned int pointers, and
then pass the result to memcmp(). This means we're only comparing 1/4
of the bytes we need to, because we need to multiply by
sizeof(unsigned int) to get the number of *bytes*.

The result is that the tests do all the patching and then only compare
some of the resulting code, so patching bugs that only effect that
last 3/4 of the code could slip through undetected. It turns out that
hasn't been happening, although one test had a bad expected case (see
previous commit).

Fix it for now by multiplying the size by 4 in the affected functions.

Fixes: 362e7701fd18 ("powerpc: Add self-tests of the feature fixup code")
Epic-brown-paper-bag-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/powerpc/lib/feature-fixups.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -170,7 +170,7 @@ void test_basic_patching(void)
 	extern unsigned int end_ftr_fixup_test1[];
 	extern unsigned int ftr_fixup_test1_orig[];
 	extern unsigned int ftr_fixup_test1_expected[];
-	int size = end_ftr_fixup_test1 - ftr_fixup_test1;
+	int size = 4 * (end_ftr_fixup_test1 - ftr_fixup_test1);
 
 	fixup.value = fixup.mask = 8;
 	fixup.start_off = calc_offset(&fixup, ftr_fixup_test1 + 1);
@@ -202,7 +202,7 @@ static void test_alternative_patching(vo
 	extern unsigned int ftr_fixup_test2_orig[];
 	extern unsigned int ftr_fixup_test2_alt[];
 	extern unsigned int ftr_fixup_test2_expected[];
-	int size = end_ftr_fixup_test2 - ftr_fixup_test2;
+	int size = 4 * (end_ftr_fixup_test2 - ftr_fixup_test2);
 
 	fixup.value = fixup.mask = 0xF;
 	fixup.start_off = calc_offset(&fixup, ftr_fixup_test2 + 1);
@@ -234,7 +234,7 @@ static void test_alternative_case_too_bi
 	extern unsigned int end_ftr_fixup_test3[];
 	extern unsigned int ftr_fixup_test3_orig[];
 	extern unsigned int ftr_fixup_test3_alt[];
-	int size = end_ftr_fixup_test3 - ftr_fixup_test3;
+	int size = 4 * (end_ftr_fixup_test3 - ftr_fixup_test3);
 
 	fixup.value = fixup.mask = 0xC;
 	fixup.start_off = calc_offset(&fixup, ftr_fixup_test3 + 1);
@@ -261,7 +261,7 @@ static void test_alternative_case_too_sm
 	extern unsigned int ftr_fixup_test4_orig[];
 	extern unsigned int ftr_fixup_test4_alt[];
 	extern unsigned int ftr_fixup_test4_expected[];
-	int size = end_ftr_fixup_test4 - ftr_fixup_test4;
+	int size = 4 * (end_ftr_fixup_test4 - ftr_fixup_test4);
 	unsigned long flag;
 
 	/* Check a high-bit flag */
@@ -295,7 +295,7 @@ static void test_alternative_case_with_b
 	extern unsigned int ftr_fixup_test5[];
 	extern unsigned int end_ftr_fixup_test5[];
 	extern unsigned int ftr_fixup_test5_expected[];
-	int size = end_ftr_fixup_test5 - ftr_fixup_test5;
+	int size = 4 * (end_ftr_fixup_test5 - ftr_fixup_test5);
 
 	check(memcmp(ftr_fixup_test5, ftr_fixup_test5_expected, size) == 0);
 }
@@ -305,7 +305,7 @@ static void test_alternative_case_with_e
 	extern unsigned int ftr_fixup_test6[];
 	extern unsigned int end_ftr_fixup_test6[];
 	extern unsigned int ftr_fixup_test6_expected[];
-	int size = end_ftr_fixup_test6 - ftr_fixup_test6;
+	int size = 4 * (end_ftr_fixup_test6 - ftr_fixup_test6);
 
 	check(memcmp(ftr_fixup_test6, ftr_fixup_test6_expected, size) == 0);
 }


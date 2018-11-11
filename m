Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3949C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0582080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:05:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A0582080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731256AbeKLFyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:54:49 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51788 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727354AbeKLFyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:54:49 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvtC-0000lF-LL; Sun, 11 Nov 2018 19:59:22 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsO-0001PK-JH; Sun, 11 Nov 2018 19:58:32 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Andrew Donnellan" <andrew.donnellan@au1.ibm.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Daniel Axtens" <dja@axtens.net>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Daniel Micay" <danielmicay@gmail.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.328288053@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 041/366] powerpc: make feature-fixup tests fortify-safe
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

From: Daniel Axtens <dja@axtens.net>

commit c69a48cdb301a18697bc8c9935baf4f32861cf9e upstream.

Testing the fortified string functions[1] would cause a kernel panic on
boot in test_feature_fixups() due to a buffer overflow in memcmp.

This boils down to things like this:

  extern unsigned int ftr_fixup_test1;
  extern unsigned int ftr_fixup_test1_orig;

  check(memcmp(&ftr_fixup_test1, &ftr_fixup_test1_orig, size) == 0);

We know that these are asm labels so it is safe to read up to 'size'
bytes at those addresses.

However, because we have passed the address of a single unsigned int to
memcmp, the compiler believes the underlying object is in fact a single
unsigned int.  So if size > sizeof(unsigned int), there will be a panic
at runtime.

We can fix this by changing the types: instead of calling the asm labels
unsigned ints, call them unsigned int[]s.  Therefore the size isn't
incorrectly determined at compile time and we get a regular unsafe
memcmp and no panic.

[1] http://openwall.com/lists/kernel-hardening/2017/05/09/2

Link: http://lkml.kernel.org/r/1497903987-21002-7-git-send-email-keescook@chromium.org
Signed-off-by: Daniel Axtens <dja@axtens.net>
Signed-off-by: Kees Cook <keescook@chromium.org>
Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Tested-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Daniel Micay <danielmicay@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/powerpc/lib/feature-fixups.c | 180 +++++++++++++++---------------
 1 file changed, 90 insertions(+), 90 deletions(-)

--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -166,192 +166,192 @@ static long calc_offset(struct fixup_ent
 
 void test_basic_patching(void)
 {
-	extern unsigned int ftr_fixup_test1;
-	extern unsigned int end_ftr_fixup_test1;
-	extern unsigned int ftr_fixup_test1_orig;
-	extern unsigned int ftr_fixup_test1_expected;
-	int size = &end_ftr_fixup_test1 - &ftr_fixup_test1;
+	extern unsigned int ftr_fixup_test1[];
+	extern unsigned int end_ftr_fixup_test1[];
+	extern unsigned int ftr_fixup_test1_orig[];
+	extern unsigned int ftr_fixup_test1_expected[];
+	int size = end_ftr_fixup_test1 - ftr_fixup_test1;
 
 	fixup.value = fixup.mask = 8;
-	fixup.start_off = calc_offset(&fixup, &ftr_fixup_test1 + 1);
-	fixup.end_off = calc_offset(&fixup, &ftr_fixup_test1 + 2);
+	fixup.start_off = calc_offset(&fixup, ftr_fixup_test1 + 1);
+	fixup.end_off = calc_offset(&fixup, ftr_fixup_test1 + 2);
 	fixup.alt_start_off = fixup.alt_end_off = 0;
 
 	/* Sanity check */
-	check(memcmp(&ftr_fixup_test1, &ftr_fixup_test1_orig, size) == 0);
+	check(memcmp(ftr_fixup_test1, ftr_fixup_test1_orig, size) == 0);
 
 	/* Check we don't patch if the value matches */
 	patch_feature_section(8, &fixup);
-	check(memcmp(&ftr_fixup_test1, &ftr_fixup_test1_orig, size) == 0);
+	check(memcmp(ftr_fixup_test1, ftr_fixup_test1_orig, size) == 0);
 
 	/* Check we do patch if the value doesn't match */
 	patch_feature_section(0, &fixup);
-	check(memcmp(&ftr_fixup_test1, &ftr_fixup_test1_expected, size) == 0);
+	check(memcmp(ftr_fixup_test1, ftr_fixup_test1_expected, size) == 0);
 
 	/* Check we do patch if the mask doesn't match */
-	memcpy(&ftr_fixup_test1, &ftr_fixup_test1_orig, size);
-	check(memcmp(&ftr_fixup_test1, &ftr_fixup_test1_orig, size) == 0);
+	memcpy(ftr_fixup_test1, ftr_fixup_test1_orig, size);
+	check(memcmp(ftr_fixup_test1, ftr_fixup_test1_orig, size) == 0);
 	patch_feature_section(~8, &fixup);
-	check(memcmp(&ftr_fixup_test1, &ftr_fixup_test1_expected, size) == 0);
+	check(memcmp(ftr_fixup_test1, ftr_fixup_test1_expected, size) == 0);
 }
 
 static void test_alternative_patching(void)
 {
-	extern unsigned int ftr_fixup_test2;
-	extern unsigned int end_ftr_fixup_test2;
-	extern unsigned int ftr_fixup_test2_orig;
-	extern unsigned int ftr_fixup_test2_alt;
-	extern unsigned int ftr_fixup_test2_expected;
-	int size = &end_ftr_fixup_test2 - &ftr_fixup_test2;
+	extern unsigned int ftr_fixup_test2[];
+	extern unsigned int end_ftr_fixup_test2[];
+	extern unsigned int ftr_fixup_test2_orig[];
+	extern unsigned int ftr_fixup_test2_alt[];
+	extern unsigned int ftr_fixup_test2_expected[];
+	int size = end_ftr_fixup_test2 - ftr_fixup_test2;
 
 	fixup.value = fixup.mask = 0xF;
-	fixup.start_off = calc_offset(&fixup, &ftr_fixup_test2 + 1);
-	fixup.end_off = calc_offset(&fixup, &ftr_fixup_test2 + 2);
-	fixup.alt_start_off = calc_offset(&fixup, &ftr_fixup_test2_alt);
-	fixup.alt_end_off = calc_offset(&fixup, &ftr_fixup_test2_alt + 1);
+	fixup.start_off = calc_offset(&fixup, ftr_fixup_test2 + 1);
+	fixup.end_off = calc_offset(&fixup, ftr_fixup_test2 + 2);
+	fixup.alt_start_off = calc_offset(&fixup, ftr_fixup_test2_alt);
+	fixup.alt_end_off = calc_offset(&fixup, ftr_fixup_test2_alt + 1);
 
 	/* Sanity check */
-	check(memcmp(&ftr_fixup_test2, &ftr_fixup_test2_orig, size) == 0);
+	check(memcmp(ftr_fixup_test2, ftr_fixup_test2_orig, size) == 0);
 
 	/* Check we don't patch if the value matches */
 	patch_feature_section(0xF, &fixup);
-	check(memcmp(&ftr_fixup_test2, &ftr_fixup_test2_orig, size) == 0);
+	check(memcmp(ftr_fixup_test2, ftr_fixup_test2_orig, size) == 0);
 
 	/* Check we do patch if the value doesn't match */
 	patch_feature_section(0, &fixup);
-	check(memcmp(&ftr_fixup_test2, &ftr_fixup_test2_expected, size) == 0);
+	check(memcmp(ftr_fixup_test2, ftr_fixup_test2_expected, size) == 0);
 
 	/* Check we do patch if the mask doesn't match */
-	memcpy(&ftr_fixup_test2, &ftr_fixup_test2_orig, size);
-	check(memcmp(&ftr_fixup_test2, &ftr_fixup_test2_orig, size) == 0);
+	memcpy(ftr_fixup_test2, ftr_fixup_test2_orig, size);
+	check(memcmp(ftr_fixup_test2, ftr_fixup_test2_orig, size) == 0);
 	patch_feature_section(~0xF, &fixup);
-	check(memcmp(&ftr_fixup_test2, &ftr_fixup_test2_expected, size) == 0);
+	check(memcmp(ftr_fixup_test2, ftr_fixup_test2_expected, size) == 0);
 }
 
 static void test_alternative_case_too_big(void)
 {
-	extern unsigned int ftr_fixup_test3;
-	extern unsigned int end_ftr_fixup_test3;
-	extern unsigned int ftr_fixup_test3_orig;
-	extern unsigned int ftr_fixup_test3_alt;
-	int size = &end_ftr_fixup_test3 - &ftr_fixup_test3;
+	extern unsigned int ftr_fixup_test3[];
+	extern unsigned int end_ftr_fixup_test3[];
+	extern unsigned int ftr_fixup_test3_orig[];
+	extern unsigned int ftr_fixup_test3_alt[];
+	int size = end_ftr_fixup_test3 - ftr_fixup_test3;
 
 	fixup.value = fixup.mask = 0xC;
-	fixup.start_off = calc_offset(&fixup, &ftr_fixup_test3 + 1);
-	fixup.end_off = calc_offset(&fixup, &ftr_fixup_test3 + 2);
-	fixup.alt_start_off = calc_offset(&fixup, &ftr_fixup_test3_alt);
-	fixup.alt_end_off = calc_offset(&fixup, &ftr_fixup_test3_alt + 2);
+	fixup.start_off = calc_offset(&fixup, ftr_fixup_test3 + 1);
+	fixup.end_off = calc_offset(&fixup, ftr_fixup_test3 + 2);
+	fixup.alt_start_off = calc_offset(&fixup, ftr_fixup_test3_alt);
+	fixup.alt_end_off = calc_offset(&fixup, ftr_fixup_test3_alt + 2);
 
 	/* Sanity check */
-	check(memcmp(&ftr_fixup_test3, &ftr_fixup_test3_orig, size) == 0);
+	check(memcmp(ftr_fixup_test3, ftr_fixup_test3_orig, size) == 0);
 
 	/* Expect nothing to be patched, and the error returned to us */
 	check(patch_feature_section(0xF, &fixup) == 1);
-	check(memcmp(&ftr_fixup_test3, &ftr_fixup_test3_orig, size) == 0);
+	check(memcmp(ftr_fixup_test3, ftr_fixup_test3_orig, size) == 0);
 	check(patch_feature_section(0, &fixup) == 1);
-	check(memcmp(&ftr_fixup_test3, &ftr_fixup_test3_orig, size) == 0);
+	check(memcmp(ftr_fixup_test3, ftr_fixup_test3_orig, size) == 0);
 	check(patch_feature_section(~0xF, &fixup) == 1);
-	check(memcmp(&ftr_fixup_test3, &ftr_fixup_test3_orig, size) == 0);
+	check(memcmp(ftr_fixup_test3, ftr_fixup_test3_orig, size) == 0);
 }
 
 static void test_alternative_case_too_small(void)
 {
-	extern unsigned int ftr_fixup_test4;
-	extern unsigned int end_ftr_fixup_test4;
-	extern unsigned int ftr_fixup_test4_orig;
-	extern unsigned int ftr_fixup_test4_alt;
-	extern unsigned int ftr_fixup_test4_expected;
-	int size = &end_ftr_fixup_test4 - &ftr_fixup_test4;
+	extern unsigned int ftr_fixup_test4[];
+	extern unsigned int end_ftr_fixup_test4[];
+	extern unsigned int ftr_fixup_test4_orig[];
+	extern unsigned int ftr_fixup_test4_alt[];
+	extern unsigned int ftr_fixup_test4_expected[];
+	int size = end_ftr_fixup_test4 - ftr_fixup_test4;
 	unsigned long flag;
 
 	/* Check a high-bit flag */
 	flag = 1UL << ((sizeof(unsigned long) - 1) * 8);
 	fixup.value = fixup.mask = flag;
-	fixup.start_off = calc_offset(&fixup, &ftr_fixup_test4 + 1);
-	fixup.end_off = calc_offset(&fixup, &ftr_fixup_test4 + 5);
-	fixup.alt_start_off = calc_offset(&fixup, &ftr_fixup_test4_alt);
-	fixup.alt_end_off = calc_offset(&fixup, &ftr_fixup_test4_alt + 2);
+	fixup.start_off = calc_offset(&fixup, ftr_fixup_test4 + 1);
+	fixup.end_off = calc_offset(&fixup, ftr_fixup_test4 + 5);
+	fixup.alt_start_off = calc_offset(&fixup, ftr_fixup_test4_alt);
+	fixup.alt_end_off = calc_offset(&fixup, ftr_fixup_test4_alt + 2);
 
 	/* Sanity check */
-	check(memcmp(&ftr_fixup_test4, &ftr_fixup_test4_orig, size) == 0);
+	check(memcmp(ftr_fixup_test4, ftr_fixup_test4_orig, size) == 0);
 
 	/* Check we don't patch if the value matches */
 	patch_feature_section(flag, &fixup);
-	check(memcmp(&ftr_fixup_test4, &ftr_fixup_test4_orig, size) == 0);
+	check(memcmp(ftr_fixup_test4, ftr_fixup_test4_orig, size) == 0);
 
 	/* Check we do patch if the value doesn't match */
 	patch_feature_section(0, &fixup);
-	check(memcmp(&ftr_fixup_test4, &ftr_fixup_test4_expected, size) == 0);
+	check(memcmp(ftr_fixup_test4, ftr_fixup_test4_expected, size) == 0);
 
 	/* Check we do patch if the mask doesn't match */
-	memcpy(&ftr_fixup_test4, &ftr_fixup_test4_orig, size);
-	check(memcmp(&ftr_fixup_test4, &ftr_fixup_test4_orig, size) == 0);
+	memcpy(ftr_fixup_test4, ftr_fixup_test4_orig, size);
+	check(memcmp(ftr_fixup_test4, ftr_fixup_test4_orig, size) == 0);
 	patch_feature_section(~flag, &fixup);
-	check(memcmp(&ftr_fixup_test4, &ftr_fixup_test4_expected, size) == 0);
+	check(memcmp(ftr_fixup_test4, ftr_fixup_test4_expected, size) == 0);
 }
 
 static void test_alternative_case_with_branch(void)
 {
-	extern unsigned int ftr_fixup_test5;
-	extern unsigned int end_ftr_fixup_test5;
-	extern unsigned int ftr_fixup_test5_expected;
-	int size = &end_ftr_fixup_test5 - &ftr_fixup_test5;
+	extern unsigned int ftr_fixup_test5[];
+	extern unsigned int end_ftr_fixup_test5[];
+	extern unsigned int ftr_fixup_test5_expected[];
+	int size = end_ftr_fixup_test5 - ftr_fixup_test5;
 
-	check(memcmp(&ftr_fixup_test5, &ftr_fixup_test5_expected, size) == 0);
+	check(memcmp(ftr_fixup_test5, ftr_fixup_test5_expected, size) == 0);
 }
 
 static void test_alternative_case_with_external_branch(void)
 {
-	extern unsigned int ftr_fixup_test6;
-	extern unsigned int end_ftr_fixup_test6;
-	extern unsigned int ftr_fixup_test6_expected;
-	int size = &end_ftr_fixup_test6 - &ftr_fixup_test6;
+	extern unsigned int ftr_fixup_test6[];
+	extern unsigned int end_ftr_fixup_test6[];
+	extern unsigned int ftr_fixup_test6_expected[];
+	int size = end_ftr_fixup_test6 - ftr_fixup_test6;
 
-	check(memcmp(&ftr_fixup_test6, &ftr_fixup_test6_expected, size) == 0);
+	check(memcmp(ftr_fixup_test6, ftr_fixup_test6_expected, size) == 0);
 }
 
 static void test_cpu_macros(void)
 {
-	extern u8 ftr_fixup_test_FTR_macros;
-	extern u8 ftr_fixup_test_FTR_macros_expected;
-	unsigned long size = &ftr_fixup_test_FTR_macros_expected -
-			     &ftr_fixup_test_FTR_macros;
+	extern u8 ftr_fixup_test_FTR_macros[];
+	extern u8 ftr_fixup_test_FTR_macros_expected[];
+	unsigned long size = ftr_fixup_test_FTR_macros_expected -
+			     ftr_fixup_test_FTR_macros;
 
 	/* The fixups have already been done for us during boot */
-	check(memcmp(&ftr_fixup_test_FTR_macros,
-		     &ftr_fixup_test_FTR_macros_expected, size) == 0);
+	check(memcmp(ftr_fixup_test_FTR_macros,
+		     ftr_fixup_test_FTR_macros_expected, size) == 0);
 }
 
 static void test_fw_macros(void)
 {
 #ifdef CONFIG_PPC64
-	extern u8 ftr_fixup_test_FW_FTR_macros;
-	extern u8 ftr_fixup_test_FW_FTR_macros_expected;
-	unsigned long size = &ftr_fixup_test_FW_FTR_macros_expected -
-			     &ftr_fixup_test_FW_FTR_macros;
+	extern u8 ftr_fixup_test_FW_FTR_macros[];
+	extern u8 ftr_fixup_test_FW_FTR_macros_expected[];
+	unsigned long size = ftr_fixup_test_FW_FTR_macros_expected -
+			     ftr_fixup_test_FW_FTR_macros;
 
 	/* The fixups have already been done for us during boot */
-	check(memcmp(&ftr_fixup_test_FW_FTR_macros,
-		     &ftr_fixup_test_FW_FTR_macros_expected, size) == 0);
+	check(memcmp(ftr_fixup_test_FW_FTR_macros,
+		     ftr_fixup_test_FW_FTR_macros_expected, size) == 0);
 #endif
 }
 
 static void test_lwsync_macros(void)
 {
-	extern u8 lwsync_fixup_test;
-	extern u8 end_lwsync_fixup_test;
-	extern u8 lwsync_fixup_test_expected_LWSYNC;
-	extern u8 lwsync_fixup_test_expected_SYNC;
-	unsigned long size = &end_lwsync_fixup_test -
-			     &lwsync_fixup_test;
+	extern u8 lwsync_fixup_test[];
+	extern u8 end_lwsync_fixup_test[];
+	extern u8 lwsync_fixup_test_expected_LWSYNC[];
+	extern u8 lwsync_fixup_test_expected_SYNC[];
+	unsigned long size = end_lwsync_fixup_test -
+			     lwsync_fixup_test;
 
 	/* The fixups have already been done for us during boot */
 	if (cur_cpu_spec->cpu_features & CPU_FTR_LWSYNC) {
-		check(memcmp(&lwsync_fixup_test,
-			     &lwsync_fixup_test_expected_LWSYNC, size) == 0);
+		check(memcmp(lwsync_fixup_test,
+			     lwsync_fixup_test_expected_LWSYNC, size) == 0);
 	} else {
-		check(memcmp(&lwsync_fixup_test,
-			     &lwsync_fixup_test_expected_SYNC, size) == 0);
+		check(memcmp(lwsync_fixup_test,
+			     lwsync_fixup_test_expected_SYNC, size) == 0);
 	}
 }
 


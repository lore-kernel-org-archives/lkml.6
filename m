Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5E0C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD35F21908
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbfBASIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 13:08:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39758 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730590AbfBASIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 13:08:41 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 20AE3C05D261;
        Fri,  1 Feb 2019 18:08:41 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F221B600D7;
        Fri,  1 Feb 2019 18:08:36 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rik van Riel <riel@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Subject: [PATCH v2] x86, random: Fix get_random_bytes() warning in x86 start_kernel
Date:   Fri,  1 Feb 2019 13:08:31 -0500
Message-Id: <20190201180831.19839-1-prarit@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 01 Feb 2019 18:08:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After 43838a23a05f ("random: fix crng_ready() test") early boot calls to
get_random_bytes() will warn on x86 because the crng is not initialized.
For example,

random: get_random_bytes called from start_kernel+0x8e/0x587 with crng_init=0

x86 only uses get_random_bytes() for better randomization of the stack
canary value so the warning is of no consequence.

Test if the crng is initialized before calling get_random_bytes().  If it
is not available then attempt to read from the hardware random generator,
before finally using the TSC.

v2: Add HW random read based on feedback fro hpa@zytor.com & tytso@mit.edu

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
---
 arch/x86/include/asm/stackprotector.h | 14 +++++++++-----
 drivers/char/random.c                 |  5 ++++-
 include/linux/random.h                |  1 +
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm/stackprotector.h
index 8ec97a62c245..082100608d18 100644
--- a/arch/x86/include/asm/stackprotector.h
+++ b/arch/x86/include/asm/stackprotector.h
@@ -62,17 +62,21 @@ static __always_inline void boot_init_stack_canary(void)
 {
 	u64 canary;
 	u64 tsc;
+	int ret;
 
 #ifdef CONFIG_X86_64
 	BUILD_BUG_ON(offsetof(union irq_stack_union, stack_canary) != 40);
 #endif
 	/*
-	 * We both use the random pool and the current TSC as a source
-	 * of randomness. The TSC only matters for very early init,
-	 * there it already has some randomness on most systems. Later
-	 * on during the bootup the random pool has true entropy too.
+	 * During early boot the entropy pool may not be initialized.  As an
+	 * alternative and if one is available, try to use the hardware random
+	 * generator.  On most systems the TSC will have some randomness so it
+	 * can also be used for entropy during early boot.
 	 */
-	get_random_bytes(&canary, sizeof(canary));
+	if (crng_ready())
+		get_random_bytes(&canary, sizeof(canary));
+	else
+		ret = get_random_bytes_arch(&canary, sizeof(canary));
 	tsc = rdtsc();
 	canary += tsc + (tsc << 32UL);
 	canary &= CANARY_MASK;
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 38c6d1af6d1c..ea6466a3ab14 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -428,7 +428,10 @@ struct crng_state primary_crng = {
  * its value (from 0->1->2).
  */
 static int crng_init = 0;
-#define crng_ready() (likely(crng_init > 1))
+int crng_ready(void)
+{
+	return likely(crng_init > 1);
+}
 static int crng_init_cnt = 0;
 static unsigned long crng_global_init_time = 0;
 #define CRNG_INIT_CNT_THRESH (2*CHACHA_KEY_SIZE)
diff --git a/include/linux/random.h b/include/linux/random.h
index 445a0ea4ff49..3b5919cb62ca 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -197,4 +197,5 @@ static inline u32 next_pseudo_random32(u32 seed)
 	return seed * 1664525 + 1013904223;
 }
 
+extern int crng_ready(void);
 #endif /* _LINUX_RANDOM_H */
-- 
2.17.2


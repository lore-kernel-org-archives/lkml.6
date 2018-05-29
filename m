Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934225AbeE2MiN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 08:38:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933874AbeE2MiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 08:38:11 -0400
From: Prarit Bhargava <prarit@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rik van Riel <riel@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Subject: [PATCH] x86, random: Fix get_random_bytes() warning in x86 start_kernel
Date: Tue, 29 May 2018 08:38:00 -0400
Message-Id: <20180529123800.19627-1-prarit@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After 43838a23a05f ("random: fix crng_ready() test") early boot calls
to get_random_bytes() will warn on each cpu on x86 because the crng
is not initialized.  For example,

random: get_random_bytes called from start_kernel+0x8e/0x587 with crng_init=0

x86 only uses get_random_bytes() for better randomization of the stack
canary value so the warning is of no consequence.

Export crng_ready() for x86 and test if the crng is initialized before
calling get_random_bytes().

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
 arch/x86/include/asm/stackprotector.h | 3 ++-
 drivers/char/random.c                 | 5 ++++-
 include/linux/random.h                | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm/stackprotector.h
index 371b3a4af000..4e2223aa34fc 100644
--- a/arch/x86/include/asm/stackprotector.h
+++ b/arch/x86/include/asm/stackprotector.h
@@ -72,7 +72,8 @@ static __always_inline void boot_init_stack_canary(void)
 	 * there it already has some randomness on most systems. Later
 	 * on during the bootup the random pool has true entropy too.
 	 */
-	get_random_bytes(&canary, sizeof(canary));
+	if (crng_ready())
+		get_random_bytes(&canary, sizeof(canary));
 	tsc = rdtsc();
 	canary += tsc + (tsc << 32UL);
 	canary &= CANARY_MASK;
diff --git a/drivers/char/random.c b/drivers/char/random.c
index cd888d4ee605..003091d104bf 100644
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
 #define CRNG_INIT_CNT_THRESH (2*CHACHA20_KEY_SIZE)
diff --git a/include/linux/random.h b/include/linux/random.h
index 2ddf13b4281e..45616513abd9 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -196,4 +196,5 @@ static inline u32 next_pseudo_random32(u32 seed)
 	return seed * 1664525 + 1013904223;
 }
 
+extern int crng_ready(void);
 #endif /* _LINUX_RANDOM_H */
-- 
2.14.3

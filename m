Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750864AbeESGN0 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 02:13:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33839 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbeESGNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 02:13:24 -0400
Date: Fri, 18 May 2018 23:12:52 -0700
From: tip-bot for Mark Rutland <tipbot@zytor.com>
Message-ID: <tip-4f74d72aa7067e75af92fbab077e6d7d0210be66@git.kernel.org>
Cc: mingo@kernel.org, mark.rutland@arm.com, kim.phillips@arm.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, ard.biesheuvel@linaro.org, tglx@linutronix.de,
        hpa@zytor.com
Reply-To: mingo@kernel.org, kim.phillips@arm.com, mark.rutland@arm.com,
        torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        ard.biesheuvel@linaro.org
In-Reply-To: <20180518140841.9731-2-ard.biesheuvel@linaro.org>
References: <20180518140841.9731-2-ard.biesheuvel@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:efi/urgent] efi/libstub/arm64: Handle randomized TEXT_OFFSET
Git-Commit-ID: 4f74d72aa7067e75af92fbab077e6d7d0210be66
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  4f74d72aa7067e75af92fbab077e6d7d0210be66
Gitweb:     https://git.kernel.org/tip/4f74d72aa7067e75af92fbab077e6d7d0210be66
Author:     Mark Rutland <mark.rutland@arm.com>
AuthorDate: Fri, 18 May 2018 16:08:41 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 19 May 2018 08:07:56 +0200

efi/libstub/arm64: Handle randomized TEXT_OFFSET

When CONFIG_RANDOMIZE_TEXT_OFFSET=y, TEXT_OFFSET is an arbitrary
multiple of PAGE_SIZE in the interval [0, 2MB).

The EFI stub does not account for the potential misalignment of
TEXT_OFFSET relative to EFI_KIMG_ALIGN, and produces a randomized
physical offset which is always a round multiple of EFI_KIMG_ALIGN.
This may result in statically allocated objects whose alignment exceeds
PAGE_SIZE to appear misaligned in memory. This has been observed to
result in spurious stack overflow reports and failure to make use of
the IRQ stacks, and theoretically could result in a number of other
issues.

We can OR in the low bits of TEXT_OFFSET to ensure that we have the
necessary offset (and hence preserve the misalignment of TEXT_OFFSET
relative to EFI_KIMG_ALIGN), so let's do that.

Reported-by: Kim Phillips <kim.phillips@arm.com>
Tested-by: Kim Phillips <kim.phillips@arm.com>
[ardb: clarify comment and commit log, drop unneeded parens]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Fixes: 6f26b3671184c36d ("arm64: kaslr: increase randomization granularity")
Link: http://lkml.kernel.org/r/20180518140841.9731-2-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/libstub/arm64-stub.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index b9bd827caa22..1b4d465cc5d9 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -97,6 +97,16 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
 		u32 offset = !IS_ENABLED(CONFIG_DEBUG_ALIGN_RODATA) ?
 			     (phys_seed >> 32) & mask : TEXT_OFFSET;
 
+		/*
+		 * With CONFIG_RANDOMIZE_TEXT_OFFSET=y, TEXT_OFFSET may not
+		 * be a multiple of EFI_KIMG_ALIGN, and we must ensure that
+		 * we preserve the misalignment of 'offset' relative to
+		 * EFI_KIMG_ALIGN so that statically allocated objects whose
+		 * alignment exceeds PAGE_SIZE appear correctly aligned in
+		 * memory.
+		 */
+		offset |= TEXT_OFFSET % EFI_KIMG_ALIGN;
+
 		/*
 		 * If KASLR is enabled, and we have some randomness available,
 		 * locate the kernel at a randomized offset in physical memory.

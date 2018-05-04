Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751820AbeEDGBj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 02:01:39 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53552 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751742AbeEDGBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 02:01:35 -0400
X-Google-Smtp-Source: AB8JxZoJHc6w0sYegE+ooP6uCU2WaVVf01pOF5BmlXNbaBWOr2Vl1hodFzCfh0EecL4m0thDhktjug==
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/17] efi/libstub/arm64: handle randomized TEXT_OFFSET
Date: Fri,  4 May 2018 08:00:03 +0200
Message-Id: <20180504060003.19618-18-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180504060003.19618-1-ard.biesheuvel@linaro.org>
References: <20180504060003.19618-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

When CONFIG_RANDOMIZE_TEXT_OFFSET is selected, TEXT_OFFSET is an
arbitrary multiple of PAGE_SIZE in the interval [0, 2MB).

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

Fixes: 6f26b3671184c36d ("arm64: kaslr: increase randomization granularity")
Cc: <stable@vger.kernel.org> # v4.7+
Reported-by: Kim Phillips <kim.phillips@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Kim Phillips <kim.phillips@arm.com>
[ardb: clarify commit log]
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/libstub/arm64-stub.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index b9bd827caa22..541b82fdc8a2 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -97,6 +97,13 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
 		u32 offset = !IS_ENABLED(CONFIG_DEBUG_ALIGN_RODATA) ?
 			     (phys_seed >> 32) & mask : TEXT_OFFSET;
 
+		/*
+		 * With CONFIG_RANDOMIZE_TEXT_OFFSET, TEXT_OFFSET may not be a
+		 * multiple of EFI_KIMG_ALIGN, and we must ensure that we apply
+		 * the offset below EFI_KIMG_ALIGN.
+		 */
+		offset |= (TEXT_OFFSET % EFI_KIMG_ALIGN);
+
 		/*
 		 * If KASLR is enabled, and we have some randomness available,
 		 * locate the kernel at a randomized offset in physical memory.
-- 
2.17.0

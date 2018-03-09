Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbeCIJOS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 04:14:18 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48119 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751483AbeCIJOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 04:14:10 -0500
Date: Fri, 9 Mar 2018 01:13:49 -0800
From: tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-5b4e4c3aa220d07d166d3f21f158bc9c69e3c044@git.kernel.org>
Cc: torvalds@linux-foundation.org, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de, peterz@infradead.org, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org, matt@codeblueprint.co.uk
Reply-To: peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org,
        matt@codeblueprint.co.uk, hpa@zytor.com, torvalds@linux-foundation.org,
        mingo@kernel.org
In-Reply-To: <20180308080020.22828-11-ard.biesheuvel@linaro.org>
References: <20180308080020.22828-11-ard.biesheuvel@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi: Reorder pr_notice() with
 add_device_randomness() call
Git-Commit-ID: 5b4e4c3aa220d07d166d3f21f158bc9c69e3c044
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

Commit-ID:  5b4e4c3aa220d07d166d3f21f158bc9c69e3c044
Gitweb:     https://git.kernel.org/tip/5b4e4c3aa220d07d166d3f21f158bc9c69e3c044
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Thu, 8 Mar 2018 08:00:18 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 9 Mar 2018 08:58:23 +0100

efi: Reorder pr_notice() with add_device_randomness() call

Currently, when we receive a random seed from the EFI stub, we call
add_device_randomness() to incorporate it into the entropy pool, and
issue a pr_notice() saying we are about to do that, e.g.,

  [    0.000000] efi:  RNG=0x87ff92cf18
  [    0.000000] random: fast init done
  [    0.000000] efi: seeding entropy pool

Let's reorder those calls to make the output look less confusing:

  [    0.000000] efi: seeding entropy pool
  [    0.000000] efi:  RNG=0x87ff92cf18
  [    0.000000] random: fast init done

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180308080020.22828-11-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index cd42f66a7c85..92b9e79e5da9 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -542,9 +542,9 @@ int __init efi_config_parse_tables(void *config_tables, int count, int sz,
 			seed = early_memremap(efi.rng_seed,
 					      sizeof(*seed) + size);
 			if (seed != NULL) {
+				pr_notice("seeding entropy pool\n");
 				add_device_randomness(seed->bits, seed->size);
 				early_memunmap(seed, sizeof(*seed) + size);
-				pr_notice("seeding entropy pool\n");
 			} else {
 				pr_err("Could not map UEFI random seed!\n");
 			}

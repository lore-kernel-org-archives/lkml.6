Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbeDUIUE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 04:20:04 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57138 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752743AbeDUIUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 04:20:00 -0400
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] x86/microcode: Do not exit early from __reload_late()
Date: Sat, 21 Apr 2018 10:19:30 +0200
Message-Id: <20180421081930.15741-2-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180421081930.15741-1-bp@alien8.de>
References: <20180421081930.15741-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Vitezslav reported a case where the

  "Timeout during microcode update!"

panic would hit. After a deeper look, it turned out that his .config had
CONFIG_HOTPLUG_CPU disabled which practically made save_mc_for_early() a
no-op.

When that happened, the discovered microcode patch wasn't saved into our
cache and the late loading path wouldn't find any.

This, then, lead to early exit from __reload_late() and thus CPUs
waiting until the timeout is reached, leading to the panic.

In hindsight, I should've made that function not return before the
post-synchronization. Oh well, I know better now...

Reported-by: Vitezslav Samel <vitezslav@samel.cz>
Tested-by: Vitezslav Samel <vitezslav@samel.cz>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: <stable@vger.kernel.org>
Fixes: bb8c13d61a62 ("x86/microcode: Fix CPU synchronization routine")
Link: http://lkml.kernel.org/r/20180418081140.GA2439@pc11.op.pod.cz
---
 arch/x86/kernel/cpu/microcode/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 10c4fc2c91f8..77e201301528 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -564,14 +564,12 @@ static int __reload_late(void *info)
 	apply_microcode_local(&err);
 	spin_unlock(&update_lock);
 
+	/* siblings return UCODE_OK because their engine got updated already */
 	if (err > UCODE_NFOUND) {
 		pr_warn("Error reloading microcode on CPU %d\n", cpu);
-		return -1;
-	/* siblings return UCODE_OK because their engine got updated already */
+		ret = -1;
 	} else if (err == UCODE_UPDATED || err == UCODE_OK) {
 		ret = 1;
-	} else {
-		return ret;
 	}
 
 	/*
-- 
2.13.0

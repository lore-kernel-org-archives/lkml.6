Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752831AbeDUIUE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 04:20:04 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57130 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751364AbeDUIUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 04:20:00 -0400
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] x86/microcode/intel: Save microcode patch unconditionally
Date: Sat, 21 Apr 2018 10:19:29 +0200
Message-Id: <20180421081930.15741-1-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

save_mc_for_early() was a no-op on !CONFIG_HOTPLUG_CPU but the
generic_load_microcode() path saves the microcode patches it has found
into our cache of patches which is used for late loading too. Regardless
of whether we do CPU hotplug or not.

So make the saving unconditional so that late loading can find the
proper patch.

Reported-by: Vitezslav Samel <vitezslav@samel.cz>
Tested-by: Vitezslav Samel <vitezslav@samel.cz>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: <stable@vger.kernel.org> # if it has backported d8c3b52c00a05036e0a6b315b4b17921a7b67997
Link: http://lkml.kernel.org/r/20180418081140.GA2439@pc11.op.pod.cz
---
 arch/x86/kernel/cpu/microcode/intel.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 32b8e5724f96..1c2cfa0644aa 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -485,7 +485,6 @@ static void show_saved_mc(void)
  */
 static void save_mc_for_early(u8 *mc, unsigned int size)
 {
-#ifdef CONFIG_HOTPLUG_CPU
 	/* Synchronization during CPU hotplug. */
 	static DEFINE_MUTEX(x86_cpu_microcode_mutex);
 
@@ -495,7 +494,6 @@ static void save_mc_for_early(u8 *mc, unsigned int size)
 	show_saved_mc();
 
 	mutex_unlock(&x86_cpu_microcode_mutex);
-#endif
 }
 
 static bool load_builtin_intel_microcode(struct cpio_data *cp)
-- 
2.13.0

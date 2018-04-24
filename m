Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756552AbeDXHwM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 03:52:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45703 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756193AbeDXHwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 03:52:07 -0400
Date: Tue, 24 Apr 2018 00:51:50 -0700
From: tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-84749d83758af6576552046b215b9b7f37f9556b@git.kernel.org>
Cc: vitezslav@samel.cz, linux-kernel@vger.kernel.org, mingo@kernel.org,
        bp@suse.de, hpa@zytor.com, ashok.raj@intel.com, tglx@linutronix.de
Reply-To: tglx@linutronix.de, ashok.raj@intel.com, hpa@zytor.com, bp@suse.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org, vitezslav@samel.cz
In-Reply-To: <20180421081930.15741-1-bp@alien8.de>
References: <20180418081140.GA2439@pc11.op.pod.cz>
        <20180421081930.15741-1-bp@alien8.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/microcode/intel: Save microcode patch
 unconditionally
Git-Commit-ID: 84749d83758af6576552046b215b9b7f37f9556b
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

Commit-ID:  84749d83758af6576552046b215b9b7f37f9556b
Gitweb:     https://git.kernel.org/tip/84749d83758af6576552046b215b9b7f37f9556b
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Sat, 21 Apr 2018 10:19:29 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 24 Apr 2018 09:48:22 +0200

x86/microcode/intel: Save microcode patch unconditionally

save_mc_for_early() was a no-op on !CONFIG_HOTPLUG_CPU but the
generic_load_microcode() path saves the microcode patches it has found into
the cache of patches which is used for late loading too. Regardless of
whether CPU hotplug is used or not.

Make the saving unconditional so that late loading can find the proper
patch.

Reported-by: Vitezslav Samel <vitezslav@samel.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Vitezslav Samel <vitezslav@samel.cz>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20180418081140.GA2439@pc11.op.pod.cz
Link: https://lkml.kernel.org/r/20180421081930.15741-1-bp@alien8.de

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

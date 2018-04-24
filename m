Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756567AbeDXHwj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 03:52:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42769 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755929AbeDXHwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 03:52:36 -0400
Date: Tue, 24 Apr 2018 00:52:24 -0700
From: tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-09e182d17e8891dd73baba961a0f5a82e9274c97@git.kernel.org>
Cc: bp@suse.de, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, vitezslav@samel.cz, ashok.raj@intel.com,
        tglx@linutronix.de
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, vitezslav@samel.cz,
        mingo@kernel.org, ashok.raj@intel.com, bp@suse.de, hpa@zytor.com
In-Reply-To: <20180421081930.15741-2-bp@alien8.de>
References: <20180418081140.GA2439@pc11.op.pod.cz>
        <20180421081930.15741-2-bp@alien8.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/microcode: Do not exit early from
 __reload_late()
Git-Commit-ID: 09e182d17e8891dd73baba961a0f5a82e9274c97
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

Commit-ID:  09e182d17e8891dd73baba961a0f5a82e9274c97
Gitweb:     https://git.kernel.org/tip/09e182d17e8891dd73baba961a0f5a82e9274c97
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Sat, 21 Apr 2018 10:19:30 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 24 Apr 2018 09:48:22 +0200

x86/microcode: Do not exit early from __reload_late()

Vitezslav reported a case where the

  "Timeout during microcode update!"

panic would hit. After a deeper look, it turned out that his .config had
CONFIG_HOTPLUG_CPU disabled which practically made save_mc_for_early() a
no-op.

When that happened, the discovered microcode patch wasn't saved into the
cache and the late loading path wouldn't find any.

This, then, lead to early exit from __reload_late() and thus CPUs waiting
until the timeout is reached, leading to the panic.

In hindsight, that function should have been written so it does not return
before the post-synchronization. Oh well, I know better now...

Fixes: bb8c13d61a62 ("x86/microcode: Fix CPU synchronization routine")
Reported-by: Vitezslav Samel <vitezslav@samel.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Vitezslav Samel <vitezslav@samel.cz>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20180418081140.GA2439@pc11.op.pod.cz
Link: https://lkml.kernel.org/r/20180421081930.15741-2-bp@alien8.de

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751260AbeBQLoG (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:44:06 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54081 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750975AbeBQLoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:44:04 -0500
Date: Sat, 17 Feb 2018 03:43:35 -0800
From: tip-bot for Baoquan He <tipbot@zytor.com>
Message-ID: <tip-bee3204ec3c49f6f53add9c3962c9012a5c036fa@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        bhe@redhat.com, hpa@zytor.com, mingo@kernel.org, ebiederm@xmission.com,
        tglx@linutronix.de, peterz@infradead.org
Reply-To: ebiederm@xmission.com, mingo@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, bhe@redhat.com
In-Reply-To: <20180214054656.3780-7-bhe@redhat.com>
References: <20180214054656.3780-7-bhe@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/apic: Set up through-local-APIC mode on the boot
 CPU if 'noapic' specified
Git-Commit-ID: bee3204ec3c49f6f53add9c3962c9012a5c036fa
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

Commit-ID:  bee3204ec3c49f6f53add9c3962c9012a5c036fa
Gitweb:     https://git.kernel.org/tip/bee3204ec3c49f6f53add9c3962c9012a5c036fa
Author:     Baoquan He <bhe@redhat.com>
AuthorDate: Wed, 14 Feb 2018 13:46:56 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 17 Feb 2018 11:47:46 +0100

x86/apic: Set up through-local-APIC mode on the boot CPU if 'noapic' specified

Currently the kdump kernel becomes very slow if 'noapic' is specified.
Normal kernel doesn't have this bug.

Kernel parameter 'noapic' is used to disable IO-APIC in system for
testing or special purpose. Here the root cause is that in kdump
kernel LAPIC is disabled since commit:

  522e664644 ("x86/apic: Disable I/O APIC before shutdown of the local APIC")

In this case we need set up through-local-APIC on boot CPU in
setup_local_APIC().

In normal kernel the legacy irq mode is enabled by the BIOS. If
it is virtual wire mode, the local-APIC has been enabled and set as
through-local-APIC.

Though we fixed the regression introduced by commit 522e664644,
to further improve robustness set up the through-local-APIC mode
explicitly, do not rely on the default boot IRQ mode.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Eric W. Biederman <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: douly.fnst@cn.fujitsu.com
Cc: joro@8bytes.org
Cc: prarit@redhat.com
Cc: uobergfe@redhat.com
Link: http://lkml.kernel.org/r/20180214054656.3780-7-bhe@redhat.com
[ Rewrote the changelog. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/apic/apic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 871018d..2ceac9f 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1570,7 +1570,7 @@ static void setup_local_APIC(void)
 	 * TODO: set up through-local-APIC from through-I/O-APIC? --macro
 	 */
 	value = apic_read(APIC_LVT0) & APIC_LVT_MASKED;
-	if (!cpu && (pic_mode || !value)) {
+	if (!cpu && (pic_mode || !value || skip_ioapic_setup)) {
 		value = APIC_DM_EXTINT;
 		apic_printk(APIC_VERBOSE, "enabled ExtINT on CPU#%d\n", cpu);
 	} else {

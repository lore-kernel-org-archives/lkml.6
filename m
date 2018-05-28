Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162769AbeE1N6I (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:58:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162846AbeE1Kki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:40:38 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Baoquan He <bhe@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, douly.fnst@cn.fujitsu.com,
        joro@8bytes.org, prarit@redhat.com, uobergfe@redhat.com,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 319/329] x86/apic: Set up through-local-APIC mode on the boot CPU if noapic specified
Date: Mon, 28 May 2018 12:04:08 +0200
Message-Id: <20180528100307.517818508@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baoquan He <bhe@redhat.com>

[ Upstream commit bee3204ec3c49f6f53add9c3962c9012a5c036fa ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/apic/apic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1403,7 +1403,7 @@ void setup_local_APIC(void)
 	 * TODO: set up through-local-APIC from through-I/O-APIC? --macro
 	 */
 	value = apic_read(APIC_LVT0) & APIC_LVT_MASKED;
-	if (!cpu && (pic_mode || !value)) {
+	if (!cpu && (pic_mode || !value || skip_ioapic_setup)) {
 		value = APIC_DM_EXTINT;
 		apic_printk(APIC_VERBOSE, "enabled ExtINT on CPU#%d\n", cpu);
 	} else {

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934144AbeBMKLw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 05:11:52 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51108 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933865AbeBMKL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 05:11:26 -0500
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org, ebiederm@xmission.com
Cc: mingo@kernel.org, tglx@linutronix.de, x86@kernel.org,
        douly.fnst@cn.fujitsu.com, joro@8bytes.org, uobergfe@redhat.com,
        prarit@redhat.com, Baoquan He <bhe@redhat.com>
Subject: [PATCH v4 5/5] x86/apic: Set up through-local-APIC on boot CPU if 'noapic' specified
Date: Tue, 13 Feb 2018 18:10:51 +0800
Message-Id: <20180213101051.13630-6-bhe@redhat.com>
In-Reply-To: <20180213101051.13630-1-bhe@redhat.com>
References: <20180213101051.13630-1-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently kdump kernel becomes very slow if 'noapic' is specified.
Normal kernel won't.

Kernel parameter 'noapic' is used to disable IO-APIC in system for
testing or special purpose. Here the root cause is that in kdump
kernel LAPIC is disabled since commit 522e664644
("x86/apic: Disable I/O APIC before shutdown of the local APIC").
In this case We need set up through-local-APIC on boot CPU in
setup_local_APIC().

While In normal kernel the legacy irq mode is enabled in BIOS. If
it is virtual wire mode, the local-APIC has been enabled and set as
through-local-APIC.

Though we fix the regression introduced by criminal commit 522e664644,
for safety and clarity, better set up through-local-APIC explicitly,
but not rely on the default boot irq mode.

Do it now.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/apic/apic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 25ddf02598d2..3fc259b4dd2d 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1570,7 +1570,7 @@ void setup_local_APIC(void)
 	 * TODO: set up through-local-APIC from through-I/O-APIC? --macro
 	 */
 	value = apic_read(APIC_LVT0) & APIC_LVT_MASKED;
-	if (!cpu && (pic_mode || !value)) {
+	if (!cpu && (pic_mode || !value || skip_ioapic_setup)) {
 		value = APIC_DM_EXTINT;
 		apic_printk(APIC_VERBOSE, "enabled ExtINT on CPU#%d\n", cpu);
 	} else {
-- 
2.13.6

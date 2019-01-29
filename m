Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB96C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01332083B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762981;
	bh=Sag5WKGWQuToTUlKAyJpbOvklgh9V2rRUNng81RR7OA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iVSjaQaU/YtzKE+wJRZnc5tEBwQY80Kct05a1Bd5iByrgCSHbM+v2Id9IqarMAEWV
	 WWlBJ9vKaZtytKGCUjHs+lZfRn7phuqCG39Jr3DrpAhq+wb8YnqUJY6btkCkoLJt8A
	 COuWctq8ec2SX2BcECaOconY0m5VS8hbceVt6oLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731607AbfA2L4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:56:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:41138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731563AbfA2LuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:50:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D84342083B;
        Tue, 29 Jan 2019 11:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762599;
        bh=Sag5WKGWQuToTUlKAyJpbOvklgh9V2rRUNng81RR7OA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RgleGhAuk5uJzCQLoXlfK3DdmUL2cRBhz5WcbrZXtYJEnY7v+VsaYbtXcg41RsGTg
         fdJDKOYgA0qpThWpD/TetSbCB/Y5H7SR+S9i2nvtrYcSIczXSxBcQGth9Zh3FpIKTe
         6jHaOESgrj3y1Ab2cTpH9TC9TlBJMBW+0MMgvHsc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joao Martins <joao.m.martins@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH 4.14 61/68] x86/pvclock: add setter for pvclock_pvti_cpu0_va
Date:   Tue, 29 Jan 2019 12:36:23 +0100
Message-Id: <20190129113137.450738956@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113131.751891514@linuxfoundation.org>
References: <20190129113131.751891514@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joao Martins <joao.m.martins@oracle.com>

commit 9f08890ab906abaf9d4c1bad8111755cbd302260 upstream.

Right now there is only a pvclock_pvti_cpu0_va() which is defined
on kvmclock since:

commit dac16fba6fc5
("x86/vdso: Get pvclock data from the vvar VMA instead of the fixmap")

The only user of this interface so far is kvm. This commit adds a
setter function for the pvti page and moves pvclock_pvti_cpu0_va
to pvclock, which is a more generic place to have it; and would
allow other PV clocksources to use it, such as Xen.

While moving pvclock_pvti_cpu0_va into pvclock, rename also this
function to pvclock_get_pvti_cpu0_va (including its call sites)
to be symmetric with the setter (pvclock_set_pvti_cpu0_va).

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/vdso/vma.c      |    2 +-
 arch/x86/include/asm/pvclock.h |   19 ++++++++++---------
 arch/x86/kernel/kvmclock.c     |    7 +------
 arch/x86/kernel/pvclock.c      |   14 ++++++++++++++
 drivers/ptp/ptp_kvm.c          |    2 +-
 5 files changed, 27 insertions(+), 17 deletions(-)

--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -112,7 +112,7 @@ static int vvar_fault(const struct vm_sp
 				    __pa_symbol(&__vvar_page) >> PAGE_SHIFT);
 	} else if (sym_offset == image->sym_pvclock_page) {
 		struct pvclock_vsyscall_time_info *pvti =
-			pvclock_pvti_cpu0_va();
+			pvclock_get_pvti_cpu0_va();
 		if (pvti && vclock_was_used(VCLOCK_PVCLOCK)) {
 			ret = vm_insert_pfn(
 				vma,
--- a/arch/x86/include/asm/pvclock.h
+++ b/arch/x86/include/asm/pvclock.h
@@ -5,15 +5,6 @@
 #include <linux/clocksource.h>
 #include <asm/pvclock-abi.h>
 
-#ifdef CONFIG_KVM_GUEST
-extern struct pvclock_vsyscall_time_info *pvclock_pvti_cpu0_va(void);
-#else
-static inline struct pvclock_vsyscall_time_info *pvclock_pvti_cpu0_va(void)
-{
-	return NULL;
-}
-#endif
-
 /* some helper functions for xen and kvm pv clock sources */
 u64 pvclock_clocksource_read(struct pvclock_vcpu_time_info *src);
 u8 pvclock_read_flags(struct pvclock_vcpu_time_info *src);
@@ -102,4 +93,14 @@ struct pvclock_vsyscall_time_info {
 
 #define PVTI_SIZE sizeof(struct pvclock_vsyscall_time_info)
 
+#ifdef CONFIG_PARAVIRT_CLOCK
+void pvclock_set_pvti_cpu0_va(struct pvclock_vsyscall_time_info *pvti);
+struct pvclock_vsyscall_time_info *pvclock_get_pvti_cpu0_va(void);
+#else
+static inline struct pvclock_vsyscall_time_info *pvclock_get_pvti_cpu0_va(void)
+{
+	return NULL;
+}
+#endif
+
 #endif /* _ASM_X86_PVCLOCK_H */
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -47,12 +47,6 @@ early_param("no-kvmclock", parse_no_kvmc
 static struct pvclock_vsyscall_time_info *hv_clock;
 static struct pvclock_wall_clock wall_clock;
 
-struct pvclock_vsyscall_time_info *pvclock_pvti_cpu0_va(void)
-{
-	return hv_clock;
-}
-EXPORT_SYMBOL_GPL(pvclock_pvti_cpu0_va);
-
 /*
  * The wallclock is the time of day when we booted. Since then, some time may
  * have elapsed since the hypervisor wrote the data. So we try to account for
@@ -335,6 +329,7 @@ int __init kvm_setup_vsyscall_timeinfo(v
 		return 1;
 	}
 
+	pvclock_set_pvti_cpu0_va(hv_clock);
 	put_cpu();
 
 	kvm_clock.archdata.vclock_mode = VCLOCK_PVCLOCK;
--- a/arch/x86/kernel/pvclock.c
+++ b/arch/x86/kernel/pvclock.c
@@ -25,8 +25,10 @@
 
 #include <asm/fixmap.h>
 #include <asm/pvclock.h>
+#include <asm/vgtod.h>
 
 static u8 valid_flags __read_mostly = 0;
+static struct pvclock_vsyscall_time_info *pvti_cpu0_va __read_mostly;
 
 void pvclock_set_flags(u8 flags)
 {
@@ -144,3 +146,15 @@ void pvclock_read_wallclock(struct pvclo
 
 	set_normalized_timespec(ts, now.tv_sec, now.tv_nsec);
 }
+
+void pvclock_set_pvti_cpu0_va(struct pvclock_vsyscall_time_info *pvti)
+{
+	WARN_ON(vclock_was_used(VCLOCK_PVCLOCK));
+	pvti_cpu0_va = pvti;
+}
+
+struct pvclock_vsyscall_time_info *pvclock_get_pvti_cpu0_va(void)
+{
+	return pvti_cpu0_va;
+}
+EXPORT_SYMBOL_GPL(pvclock_get_pvti_cpu0_va);
--- a/drivers/ptp/ptp_kvm.c
+++ b/drivers/ptp/ptp_kvm.c
@@ -182,7 +182,7 @@ static int __init ptp_kvm_init(void)
 		return -ENODEV;
 
 	clock_pair_gpa = slow_virt_to_phys(&clock_pair);
-	hv_clock = pvclock_pvti_cpu0_va();
+	hv_clock = pvclock_get_pvti_cpu0_va();
 
 	if (!hv_clock)
 		return -ENODEV;



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932165AbeCCIFJ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 03:05:09 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:43926 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751821AbeCCIDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 03:03:51 -0500
From: Dongjiu Geng <gengdongjiu@huawei.com>
To: <rkrcmar@redhat.com>, <corbet@lwn.net>, <christoffer.dall@linaro.org>,
        <marc.zyngier@arm.com>, <james.morse@arm.com>, <linux@armlinux.org.uk>,
        <catalin.marinas@arm.com>, <rjw@rjwysocki.net>, <bp@alien8.de>,
        <lenb@kernel.org>, <kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-acpi@vger.kernel.org>,
        <devel@acpica.org>
CC: <gengdongjiu@huawei.com>, <huangshaoyu@huawei.com>
Subject: [PATCH v10 5/5] arm64: handle NOTIFY_SEI notification by the APEI driver
Date: Sun, 4 Mar 2018 00:09:40 +0800
Message-ID: <1520093380-42577-6-git-send-email-gengdongjiu@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520093380-42577-1-git-send-email-gengdongjiu@huawei.com>
References: <1520093380-42577-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.143.28.90]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper to handle the NOTIFY_SEI notification, when kernel
gets the NOTIFY_SEI notification, call this helper and let APEI
driver to handle this notification.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
 arch/arm64/include/asm/system_misc.h |  1 +
 arch/arm64/kernel/traps.c            |  4 ++++
 arch/arm64/mm/fault.c                | 10 ++++++++++
 3 files changed, 15 insertions(+)

diff --git a/arch/arm64/include/asm/system_misc.h b/arch/arm64/include/asm/system_misc.h
index 07aa8e3..9ee13ad 100644
--- a/arch/arm64/include/asm/system_misc.h
+++ b/arch/arm64/include/asm/system_misc.h
@@ -57,6 +57,7 @@ void hook_debug_fault_code(int nr, int (*fn)(unsigned long, unsigned int,
 })
 
 int handle_guest_sea(phys_addr_t addr, unsigned int esr);
+int handle_guest_sei(void);
 
 #endif	/* __ASSEMBLY__ */
 
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index e88096a..6cb280f 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -681,6 +681,10 @@ bool arm64_is_fatal_ras_serror(struct pt_regs *regs, unsigned int esr)
 {
 	u32 aet = arm64_ras_serror_get_severity(esr);
 
+	/* The APEI driver may handle this RAS error. */
+	if (!handle_guest_sei())
+		return false;
+
 	switch (aet) {
 	case ESR_ELx_AET_CE:	/* corrected error */
 	case ESR_ELx_AET_UEO:	/* restartable, not yet consumed */
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index f76bb2c..8f29bd8 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -683,6 +683,16 @@ int handle_guest_sea(phys_addr_t addr, unsigned int esr)
 	return ret;
 }
 
+int handle_guest_sei(void)
+{
+	int ret = -ENOENT;
+
+	if (IS_ENABLED(CONFIG_ACPI_APEI_SEI))
+		ret = ghes_notify_sei();
+
+	return ret;
+}
+
 asmlinkage void __exception do_mem_abort(unsigned long addr, unsigned int esr,
 					 struct pt_regs *regs)
 {
-- 
1.9.1

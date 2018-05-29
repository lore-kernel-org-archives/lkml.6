Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932966AbeE2KMw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:12:52 -0400
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:33203 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S932665AbeE2KMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 06:12:48 -0400
From: David Wang <davidwang@zhaoxin.com>
To: <rjw@rjwysocki.net>, <mingo@redhat.com>, <len.brown@intel.com>,
        <pavel@ucw.cz>, <tglx@linutronix.de>, <hpa@zytor.com>,
        <x86@kernel.org>, <linux-pm@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <brucechang@via-alliance.com>, <cooperyan@zhaoxin.com>,
        <qiyuanwang@zhaoxin.com>, <benjaminpan@viatech.com>,
        <lukelin@viacpu.com>, <timguo@zhaoxin.com>,
        David Wang <davidwang@zhaoxin.com>
Subject: [PATCH v3] Optimize C3 entry on Centaur CPUs
Date: Tue, 29 May 2018 18:12:37 +0800
Message-ID: <1527588757-19229-1-git-send-email-davidwang@zhaoxin.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.8.54]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx3.zhaoxin.com (10.29.252.165)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For new Centaur CPUs the ucode will take care of the preservation of cache coherence
between CPU cores in C-states regardless of how deep the C-states are. So, it is not
necessary to flush the caches in software befor entering C3.

Signed-off-by: David Wang <davidwang@zhaoxin.com>

Changes from v2 to v3:
*1, Replace "c->x86_mask" with "c->x86_stepping".

Changes from v1 to v2:
* 1, Add some Family/Model/Stepping contrains to let this patch only apply
* to new centaur CPUs.
* 2, The arbiter disable/enable operations maybe needed for old VIA/Centaur
* platform. So, delete "flags->bm_control=0" in patch v1.

---
 arch/x86/kernel/acpi/cstate.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index dde437f..a82fed6 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -51,6 +51,19 @@ void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
 	if (c->x86_vendor == X86_VENDOR_INTEL &&
 	    (c->x86 > 0xf || (c->x86 == 6 && c->x86_model >= 0x0f)))
 			flags->bm_control = 0;
+
+	/*
+	 * For all recent Centaur CPUs, the ucode will make sure that each
+	 * core can keep cache coherence with each other while entering C3
+	 * type state. So, set bm_check to 1 to indicate that the kernel
+	 * need not execute a cache flush operation (WBINVD) when entering
+	 * C3 type state.
+	 */
+	if (c->x86_vendor == X86_VENDOR_CENTAUR) {
+		if (c->x86 > 6 || (c->x86 == 6 && c->x86_model == 0x0f &&
+			c->x86_stepping >= 0x0e))
+			flags->bm_check = 1;
+	}
 }
 EXPORT_SYMBOL(acpi_processor_power_init_bm_check);
 
-- 
1.9.1

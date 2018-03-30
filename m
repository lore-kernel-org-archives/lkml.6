Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752659AbeC3CCz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 22:02:55 -0400
Received: from zxshcas1.zhaoxin.com ([180.169.121.91]:12621 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752510AbeC3CCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 22:02:54 -0400
From: David Wang <davidwang@zhaoxin.com>
To: <rjw@rjwysocki.net>, <mingo@kernel.org>, <len.brown@intel.com>,
        <pavel@ucw.cz>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <hpa@zytor.com>, <x86@kernel.org>, <linux-pm@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <brucechang@via-alliance.com>, <cooperyan@zhaoxin.com>,
        <qiyuanwang@zhaoxin.com>, <benjaminpan@viatech.com>,
        <lukelin@viacpu.com>, <timguo@zhaoxin.com>,
        David Wang <davidwang@zhaoxin.com>
Subject: [PATCH v2] Optimize C3 entry on Centaur CPUs
Date: Fri, 30 Mar 2018 10:02:39 +0800
Message-ID: <1522375359-30370-1-git-send-email-davidwang@zhaoxin.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.8.54]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx3.zhaoxin.com (10.29.252.165)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For new Centaur CPUs the ucode will take care of the preservation of
cache coherence between CPU cores in C-states and the other CPU cores
regardless of how deep the C-states are, so it is not necessary to
flush the caches in software before entering C3.

Signed-off-by: David Wang <davidwang@zhaoxin.com>

Changes from v1 to v2:
* 1, Add some Family/Model/Stepping contrains to let this patch only apply
* to new centaur CPUs.       
* 2, The arbiter disable/enable operations maybe needed for old VIA/Centaur
* platform. So, delete "flags->bm_control=0" in patch v1.

---
 arch/x86/kernel/acpi/cstate.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index dde437f..d92a7f3 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -51,6 +51,16 @@ void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
 	if (c->x86_vendor == X86_VENDOR_INTEL &&
 	    (c->x86 > 0xf || (c->x86 == 6 && c->x86_model >= 0x0f)))
 			flags->bm_control = 0;
+
+	/*
+	 * For all recent Centaur CPUs, the ucode will make sure that each core can keep
+	 * cache coherence with each other while entering C3 type state.
+	 * So, set bm_check to 1 to indicate that the kernel need not execute a cache 
+	 * flush operation (WBINVD) when entering C3 type state.
+	 */
+	if (c->x86_vendor == X86_VENDOR_CENTAUR &&
+	    (c->x86 > 6 || (c->x86 == 6 && c->x86_model == 0x0f && c->x86_mask>=0x0e)))
+			flags->bm_check = 1;
 }
 EXPORT_SYMBOL(acpi_processor_power_init_bm_check);
 
-- 
1.9.1

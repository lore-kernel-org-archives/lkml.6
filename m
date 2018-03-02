Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932378AbeCBFST (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 00:18:19 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55164 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753155AbeCBFSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 00:18:18 -0500
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        hpa@zytor.com, dyoung@redhat.com, x86@kernel.org,
        ebiederm@xmission.com, douly.fnst@cn.fujitsu.com, vgoyal@redhat.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH] kdump, vmcoreinfo: Export value to tell if 5-level is enabled
Date: Fri,  2 Mar 2018 13:18:01 +0800
Message-Id: <20180302051801.19594-1-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace utility needs to know if the corrupted kernel is in
5-level paging mode. So write 'pgtable_l5_enabled' to vmcoreinfo.
It covers below three cases:
  pgtable_l5_enabled == 0 when
  Compile kernel with CONFIG_X86_5LEVEL=n
  Compile with CONFIG_X86_5LEVEL=y while cpu has no 'la57' flag

  pgtable_l5_enabled != 0 when
  Compile with CONFIG_X86_5LEVEL=y and cpu has 'la57' flag

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 1f790cf9d38f..5f3545eaa76a 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -350,6 +350,7 @@ void arch_crash_save_vmcoreinfo(void)
 {
 	VMCOREINFO_NUMBER(phys_base);
 	VMCOREINFO_SYMBOL(init_top_pgt);
+	VMCOREINFO_NUMBER(pgtable_l5_enabled);
 
 #ifdef CONFIG_NUMA
 	VMCOREINFO_SYMBOL(node_data);
-- 
2.13.6

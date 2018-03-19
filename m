Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967705AbeCSQ6f (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 12:58:35 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39404 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935103AbeCSQ6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 12:58:18 -0400
X-Google-Smtp-Source: AG47ELvBzkIhT5IOmLdowr1z2tYx6Mo2SiPRx+jdMYUpqRA3KK9Z7IYGe5UFFuybU9vTfRdmOTIKIw==
From: Jason Andryuk <jandryuk@gmail.com>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc: Jason Andryuk <jandryuk@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/xen: Delay get_cpu_cap until stack canary is established
Date: Mon, 19 Mar 2018 12:58:04 -0400
Message-Id: <20180319165804.10636-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2cc42bac1c79 ("x86-64/Xen: eliminate W+X mappings") introduced a
call to get_cpu_cap, which is fstack-protected.  This is works on x86-64
as commit 4f277295e54c ("x86/xen: init %gs very early to avoid page
faults with stack protector") ensures the stack protector is configured,
but it it did not cover x86-32.

Delay calling get_cpu_cap until after xen_setup_gdt has initialized the
stack canary.  Without this, a 32bit PV machine crashes early
in boot.
(XEN) Domain 0 (vcpu#0) crashed on cpu#0:
(XEN) ----[ Xen-4.6.6-xc  x86_64  debug=n  Tainted:    C ]----
(XEN) CPU:    0
(XEN) RIP:    e019:[<00000000c10362f8>]

And the PV kernel IP corresponds to init_scattered_cpuid_features
   0xc10362f8 <+24>:    mov    %gs:0x14,%eax

Fixes 2cc42bac1c79 ("x86-64/Xen: eliminate W+X mappings")

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
 arch/x86/xen/enlighten_pv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 3c2c2530737e..c36d23aa6c35 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1259,10 +1259,6 @@ asmlinkage __visible void __init xen_start_kernel(void)
 	 */
 	__userpte_alloc_gfp &= ~__GFP_HIGHMEM;
 
-	/* Work out if we support NX */
-	get_cpu_cap(&boot_cpu_data);
-	x86_configure_nx();
-
 	/* Get mfn list */
 	xen_build_dynamic_phys_to_machine();
 
@@ -1272,6 +1268,10 @@ asmlinkage __visible void __init xen_start_kernel(void)
 	 */
 	xen_setup_gdt(0);
 
+	/* Work out if we support NX */
+	get_cpu_cap(&boot_cpu_data);
+	x86_configure_nx();
+
 	xen_init_irq_ops();
 
 	/* Let's presume PV guests always boot on vCPU with id 0. */
-- 
2.14.3

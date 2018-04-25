Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751944AbeDYKIl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 06:08:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:49045 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751451AbeDYKIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 06:08:39 -0400
Date: Wed, 25 Apr 2018 12:08:35 +0200
From: Petr Tesarik <ptesarik@suse.cz>
To: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@suse.de>,
        Juergen Gross <jgross@suse.com>, Andy Lutomirski <luto@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>, Jean Delvare <jdelvare@suse.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86: Do not reserve a crash kernel region if booted on Xen
 PV
Message-ID: <20180425120835.23cef60c@ezekiel.suse.cz>
Organization: SUSE Linux, s.r.o.
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xen PV domains cannot shut down and start a crash kernel. Instead,
the crashing kernel makes a SCHEDOP_shutdown hypercall with the
reason code SHUTDOWN_crash, cf. xen_crash_shutdown() machine op in
arch/x86/xen/enlighten_pv.c.

A crash kernel reservation is merely a waste of RAM in this case. It
may also confuse users of kexec_load(2) and/or kexec_file_load(2).
When flags include KEXEC_ON_CRASH or KEXEC_FILE_ON_CRASH,
respectively, these syscalls return success, which is technically
correct, but the crash kexec image will never be actually used.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 arch/x86/kernel/setup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 6285697b6e56..5c623dfe39d1 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -50,6 +50,7 @@
 #include <linux/init_ohci1394_dma.h>
 #include <linux/kvm_para.h>
 #include <linux/dma-contiguous.h>
+#include <xen/xen.h>
 
 #include <linux/errno.h>
 #include <linux/kernel.h>
@@ -534,6 +535,11 @@ static void __init reserve_crashkernel(void)
 		high = true;
 	}
 
+	if (xen_pv_domain()) {
+		pr_info("Ignoring crashkernel for a Xen PV domain\n");
+		return;
+	}
+
 	/* 0 means: find the address automatically */
 	if (crash_base <= 0) {
 		/*
-- 
2.13.6

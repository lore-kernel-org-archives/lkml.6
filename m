Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbeECOpy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 10:45:54 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:63202 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbeECOpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 10:45:52 -0400
X-IronPort-AV: E=Sophos;i="5.49,358,1520899200";
   d="scan'208";a="72566471"
From: Roger Pau Monne <roger.pau@citrix.com>
To: <linux-kernel@vger.kernel.org>
CC: Roger Pau Monne <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, <xen-devel@lists.xenproject.org>
Subject: [PATCH 1/3] xen/pvh: enable and set default MTRR type
Date: Thu, 3 May 2018 15:44:59 +0100
Message-ID: <20180503144459.61007-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180503143646.60747-1-roger.pau@citrix.com>
References: <20180503143646.60747-1-roger.pau@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On PVH MTRR is not initialized by the firmware (because there's no
firmware), so the kernel is started with MTRR disabled which means all
memory accesses are UC.

So far there have been no issues (ie: slowdowns) caused by this
because PVH only supported DomU mode without passed-through devices,
so Xen was using WB as the default memory type instead of UC.

Fix this by enabling MTRR and setting the default type to WB. Linux
will use PAT to set the actual memory cache attributes.

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: xen-devel@lists.xenproject.org
---
 arch/x86/xen/enlighten_pvh.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
index aa1c6a6831a9..e039d1809809 100644
--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -6,6 +6,7 @@
 #include <asm/io_apic.h>
 #include <asm/hypervisor.h>
 #include <asm/e820/api.h>
+#include <asm/mtrr.h>
 #include <asm/x86_init.h>
 
 #include <asm/xen/interface.h>
@@ -98,6 +99,8 @@ void __init xen_prepare_pvh(void)
 
 	xen_pvh = 1;
 
+	wrmsr_safe(MSR_MTRRdefType, 0x800 | MTRR_TYPE_WRBACK, 0);
+
 	msr = cpuid_ebx(xen_cpuid_base() + 2);
 	pfn = __pa(hypercall_page);
 	wrmsr_safe(msr, (u32)pfn, (u32)(pfn >> 32));
-- 
2.17.0

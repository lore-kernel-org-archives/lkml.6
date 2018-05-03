Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751477AbeECOqD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 10:46:03 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:63218 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751346AbeECOqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 10:46:01 -0400
X-IronPort-AV: E=Sophos;i="5.49,358,1520899200";
   d="scan'208";a="72566510"
From: Roger Pau Monne <roger.pau@citrix.com>
To: <linux-kernel@vger.kernel.org>
CC: Roger Pau Monne <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, <xen-devel@lists.xenproject.org>
Subject: [PATCH 3/3] xen: share start flags between PV and PVH
Date: Thu, 3 May 2018 15:45:45 +0100
Message-ID: <20180503144545.61123-1-roger.pau@citrix.com>
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

Use a global variable to store the start flags for both PV and PVH.
This allows the xen_initial_domain macro to work properly on PVH.

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: xen-devel@lists.xenproject.org
---
 arch/x86/xen/enlighten.c     | 7 +++++++
 arch/x86/xen/enlighten_pv.c  | 1 +
 arch/x86/xen/enlighten_pvh.c | 1 +
 include/xen/xen.h            | 4 +++-
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index c9081c6671f0..cdbd7b524133 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -64,6 +64,13 @@ struct shared_info xen_dummy_shared_info;
 __read_mostly int xen_have_vector_callback;
 EXPORT_SYMBOL_GPL(xen_have_vector_callback);
 
+/*
+ * NB: needs to live in .data because it's used by xen_prepare_pvh which runs
+ * before clearing the bss.
+ */
+uint32_t xen_start_flags __attribute__((section(".data"))) = 0;
+EXPORT_SYMBOL_GPL(xen_start_flags);
+
 /*
  * Point at some empty memory to start with. We map the real shared_info
  * page as soon as fixmap is up and running.
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index c36d23aa6c35..04a6914b8b85 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1227,6 +1227,7 @@ asmlinkage __visible void __init xen_start_kernel(void)
 		return;
 
 	xen_domain_type = XEN_PV_DOMAIN;
+	xen_start_flags = xen_start_info->flags;
 
 	xen_setup_features();
 
diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
index e039d1809809..2653eb9b5dd8 100644
--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -98,6 +98,7 @@ void __init xen_prepare_pvh(void)
 	}
 
 	xen_pvh = 1;
+	xen_start_flags = pvh_start_info.flags;
 
 	wrmsr_safe(MSR_MTRRdefType, 0x800 | MTRR_TYPE_WRBACK, 0);
 
diff --git a/include/xen/xen.h b/include/xen/xen.h
index 9d4340c907d1..6b5bee7041db 100644
--- a/include/xen/xen.h
+++ b/include/xen/xen.h
@@ -25,12 +25,14 @@ extern bool xen_pvh;
 #define xen_hvm_domain()	(xen_domain_type == XEN_HVM_DOMAIN)
 #define xen_pvh_domain()	(xen_pvh)
 
+extern uint32_t xen_start_flags;
+
 #ifdef CONFIG_XEN_DOM0
 #include <xen/interface/xen.h>
 #include <asm/xen/hypervisor.h>
 
 #define xen_initial_domain()	(xen_domain() && \
-				 xen_start_info && xen_start_info->flags & SIF_INITDOMAIN)
+				 (xen_start_flags & SIF_INITDOMAIN))
 #else  /* !CONFIG_XEN_DOM0 */
 #define xen_initial_domain()	(0)
 #endif	/* CONFIG_XEN_DOM0 */
-- 
2.17.0

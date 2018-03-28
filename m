Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753444AbeC1T6T (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 15:58:19 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35655 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752992AbeC1T6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 15:58:18 -0400
X-Google-Smtp-Source: AIpwx480XsOYLFcvJyLfzst+/ud9hZLGEPKnz6YD8XIci5wLO5A27XtXNM7csrBEbSAsmXowpz+gng==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: LEROY Christophe <christophe.leroy@c-s.fr>,
        Mathieu Malaterre <malat@debian.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/19] powerpc/kvm: Prefer fault_in_pages_readable function
Date: Wed, 28 Mar 2018 21:58:11 +0200
Message-Id: <20180328195811.27758-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180322202007.23088-5-malat@debian.org>
References: <20180322202007.23088-5-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Directly use fault_in_pages_readable instead of manual __get_user code. Fix
warning treated as error with W=1:

  arch/powerpc/kernel/kvm.c:675:6: error: variable ‘tmp’ set but not used [-Werror=unused-but-set-variable]

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: use fault_in_pages_readable instead
 arch/powerpc/kernel/kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index 9ad37f827a97..124c51030b75 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -25,6 +25,7 @@
 #include <linux/kvm_para.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/pagemap.h>
 
 #include <asm/reg.h>
 #include <asm/sections.h>
@@ -672,14 +673,13 @@ static void kvm_use_magic_page(void)
 {
 	u32 *p;
 	u32 *start, *end;
-	u32 tmp;
 	u32 features;
 
 	/* Tell the host to map the magic page to -4096 on all CPUs */
 	on_each_cpu(kvm_map_magic_page, &features, 1);
 
 	/* Quick self-test to see if the mapping works */
-	if (__get_user(tmp, (u32*)KVM_MAGIC_PAGE)) {
+	if (!fault_in_pages_readable((const char *)KVM_MAGIC_PAGE, sizeof(u32))) {
 		kvm_patching_worked = false;
 		return;
 	}
-- 
2.11.0

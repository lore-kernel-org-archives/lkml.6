Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077FBC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A1E20684
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A1E20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbeI1WDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:03:40 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:55279 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728873AbeI1WDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:03:39 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42MG7V3fyHz9ttfs;
        Fri, 28 Sep 2018 17:39:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id L1JUP_l9iiuS; Fri, 28 Sep 2018 17:39:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42MG7V36NWz9ttfr;
        Fri, 28 Sep 2018 17:39:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AFB3B8B91E;
        Fri, 28 Sep 2018 17:39:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id i4doe6mF1TeF; Fri, 28 Sep 2018 17:39:20 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7FAF28B91B;
        Fri, 28 Sep 2018 17:39:20 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 5ED296F281; Fri, 28 Sep 2018 15:39:20 +0000 (UTC)
Message-Id: <b3ca67442a924acb9f4a3409264914ca9feaf7d5.1538148840.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3] powerpc: wire up memtest
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-doc@vger.kernel.org
Date:   Fri, 28 Sep 2018 15:39:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add call to early_memtest() so that kernel compiled with
CONFIG_MEMTEST really perform memtest at startup when requested
via 'memtest' boot parameter.

Tested-by: Daniel Axtens <dja@axtens.net>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v3: updated kernel parameters documentation to mention PPC

 v2: moved the test after initmem_init() as PPC64 sets max_low_pfn later than PPC32.

 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 arch/powerpc/kernel/setup-common.c              | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 92eb1f42240d..a5ad67d5cb16 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2404,7 +2404,7 @@
 			seconds.  Use this parameter to check at some
 			other rate.  0 disables periodic checking.
 
-	memtest=	[KNL,X86,ARM] Enable memtest
+	memtest=	[KNL,X86,ARM,PPC] Enable memtest
 			Format: <integer>
 			default : 0 <disable>
 			Specifies the number of memtest passes to be
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 93fa0c99681e..9ca9db707bcb 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -33,6 +33,7 @@
 #include <linux/serial_8250.h>
 #include <linux/percpu.h>
 #include <linux/memblock.h>
+#include <linux/bootmem.h>
 #include <linux/of_platform.h>
 #include <linux/hugetlb.h>
 #include <asm/debugfs.h>
@@ -966,6 +967,8 @@ void __init setup_arch(char **cmdline_p)
 
 	initmem_init();
 
+	early_memtest(min_low_pfn << PAGE_SHIFT, max_low_pfn << PAGE_SHIFT);
+
 #ifdef CONFIG_DUMMY_CONSOLE
 	conswitchp = &dummy_con;
 #endif
-- 
2.13.3


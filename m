Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D8FC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F74220879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F74220879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbeLNK1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:27:51 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:12900 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728269AbeLNK1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:27:51 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43GRZV74PgzB09ZX;
        Fri, 14 Dec 2018 11:27:46 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 36XgWSyIgkCL; Fri, 14 Dec 2018 11:27:46 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43GRZV6YDKzB09ZV;
        Fri, 14 Dec 2018 11:27:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CFC798B8AE;
        Fri, 14 Dec 2018 11:27:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Me0Y8NP_9X8p; Fri, 14 Dec 2018 11:27:47 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AE97C8B8AC;
        Fri, 14 Dec 2018 11:27:47 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 850E87170A; Fri, 14 Dec 2018 10:27:47 +0000 (UTC)
Message-Id: <a138aa8f635f3d9e49e8aa5e3fcfe271bf669b4d.1544749037.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc/prom: fix early DEBUG messages
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 14 Dec 2018 10:27:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes early DEBUG messages in prom.c:
- Use %px instead of %p to see the addresses
- Cast memblock_phys_mem_size() with (unsigned long long) to
avoid build failure when phys_addr_t is not 64 bits.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v2: cast instead of #ifdef %llx/%x

 arch/powerpc/kernel/prom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index fe758cedb93f..87a68e2dc531 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -129,7 +129,7 @@ static void __init move_device_tree(void)
 		p = __va(memblock_phys_alloc(size, PAGE_SIZE));
 		memcpy(p, initial_boot_params, size);
 		initial_boot_params = p;
-		DBG("Moved device tree to 0x%p\n", p);
+		DBG("Moved device tree to 0x%px\n", p);
 	}
 
 	DBG("<- move_device_tree\n");
@@ -689,7 +689,7 @@ void __init early_init_devtree(void *params)
 {
 	phys_addr_t limit;
 
-	DBG(" -> early_init_devtree(%p)\n", params);
+	DBG(" -> early_init_devtree(%px)\n", params);
 
 	/* Too early to BUG_ON(), do it by hand */
 	if (!early_init_dt_verify(params))
@@ -749,7 +749,7 @@ void __init early_init_devtree(void *params)
 	memblock_allow_resize();
 	memblock_dump_all();
 
-	DBG("Phys. mem: %llx\n", memblock_phys_mem_size());
+	DBG("Phys. mem: %llx\n", (unsigned long long)memblock_phys_mem_size());
 
 	/* We may need to relocate the flat tree, do it now.
 	 * FIXME .. and the initrd too? */
-- 
2.13.3


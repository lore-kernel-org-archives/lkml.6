Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9645C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 14:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26FE217AA
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 14:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A26FE217AA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbeHRRK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 13:10:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11138 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726202AbeHRRK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 13:10:56 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 95D9567895111;
        Sat, 18 Aug 2018 22:03:03 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.399.0; Sat, 18 Aug 2018 22:03:03 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <yamada.masahiro@socionext.com>
CC:     <Julia.Lawall@lip6.fr>, <himanshujha199640@gmail.com>,
        <Gilles.Muller@lip6.fr>, <nicolas.palix@imag.fr>,
        <michal.lkml@markovi.net>, <linux-kernel@vger.kernel.org>
Subject: [PATCHv2] Coccinelle: remove pci_alloc_consistent semantic to detect in zalloc-simple.cocci
Date:   Sat, 18 Aug 2018 21:51:12 +0800
Message-ID: <1534600272-7685-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because pci_alloc_consistent has been deprecated. We prefer to use
dma_alloc_coherent directly. Therefore, we should remove pci_alloc_consistent
to increase the confidence.

Acked-by: Julia Lawall <julia.lawall@lip6.fr>
Acked-by: Himanshu Jha <himanshujha199640@gmail.com>
Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
v1->v2:
 - fix some spelling mistakes.  

 scripts/coccinelle/api/alloc/zalloc-simple.cocci | 41 +-----------------------
 1 file changed, 1 insertion(+), 40 deletions(-)

diff --git a/scripts/coccinelle/api/alloc/zalloc-simple.cocci b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
index 92b2091..d819275 100644
--- a/scripts/coccinelle/api/alloc/zalloc-simple.cocci
+++ b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
@@ -35,8 +35,7 @@ statement S;
 
 * x = (T)\(kmalloc(E1, ...)\|vmalloc(E1)\|dma_alloc_coherent(...,E1,...)\|
   kmalloc_node(E1, ...)\|kmem_cache_alloc(...)\|kmem_alloc(E1, ...)\|
-  devm_kmalloc(...,E1,...)\|kvmalloc(E1, ...)\|pci_alloc_consistent(...,E1,...)\|
-  kvmalloc_node(E1,...)\);
+  devm_kmalloc(...,E1,...)\|kvmalloc(E1, ...)\|kvmalloc_node(E1,...)\);
   if ((x==NULL) || ...) S
 * memset((T2)x,0,E1);
 
@@ -124,15 +123,6 @@ statement S;
 - x = (T)kvmalloc(E1,E2);
 + x = (T)kvzalloc(E1,E2);
 |
-- x = pci_alloc_consistent(E2,E1,E3);
-+ x = pci_zalloc_consistent(E2,E1,E3);
-|
-- x = (T *)pci_alloc_consistent(E2,E1,E3);
-+ x = pci_zalloc_consistent(E2,E1,E3);
-|
-- x = (T)pci_alloc_consistent(E2,E1,E3);
-+ x = (T)pci_zalloc_consistent(E2,E1,E3);
-|
 - x = kvmalloc_node(E1,E2,E3);
 + x = kvzalloc_node(E1,E2,E3);
 |
@@ -389,35 +379,6 @@ msg="WARNING: kvzalloc should be used for %s, instead of kvmalloc/memset" % (x)
 coccilib.report.print_report(p[0], msg)
 
 //-----------------------------------------------------------------
-@r8 depends on org || report@
-type T, T2;
-expression x;
-expression E1,E2,E3;
-statement S;
-position p;
-@@
-
- x = (T)pci_alloc_consistent@p(E2,E1,E3);
- if ((x==NULL) || ...) S
- memset((T2)x,0,E1);
-
-@script:python depends on org@
-p << r8.p;
-x << r8.x;
-@@
-
-msg="%s" % (x)
-msg_safe=msg.replace("[","@(").replace("]",")")
-coccilib.org.print_todo(p[0], msg_safe)
-
-@script:python depends on report@
-p << r8.p;
-x << r8.x;
-@@
-
-msg="WARNING: pci_zalloc_consistent should be used for %s, instead of pci_alloc_consistent/memset" % (x)
-coccilib.report.print_report(p[0], msg)
-//-----------------------------------------------------------------
 @r9 depends on org || report@
 type T, T2;
 expression x;
-- 
1.7.12.4


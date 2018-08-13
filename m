Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B763C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F097217D5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F097217D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbeHMQJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 12:09:48 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:20144 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728370AbeHMQJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 12:09:47 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41pxNb5m1gz9tvRN;
        Mon, 13 Aug 2018 15:27:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id JJRkFmYE9l8F; Mon, 13 Aug 2018 15:27:27 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41pxNb5C8Yz9tvRJ;
        Mon, 13 Aug 2018 15:27:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 07BEC8B7A8;
        Mon, 13 Aug 2018 15:27:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qVMoKMyv41oM; Mon, 13 Aug 2018 15:27:27 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.4])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D21208B752;
        Mon, 13 Aug 2018 15:27:27 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id DE4977125F; Mon, 13 Aug 2018 13:27:27 +0000 (UTC)
Message-Id: <6a7381f371d17bef13c704055079525955c44beb.1534166756.git.christophe.leroy@c-s.fr>
In-Reply-To: <1cbc8dba537393edbb6384b67cbb123431ba6a32.1534166756.git.christophe.leroy@c-s.fr>
References: <1cbc8dba537393edbb6384b67cbb123431ba6a32.1534166756.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 3/3] powerpc/mm: remove unneccessary test in
 pgtable_cache_init()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 13 Aug 2018 13:27:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pgtable_cache_add() gracefully handles the case when a cache that
size already exists by returning early with the following test:

	if (PGT_CACHE(shift))
		return; /* Already have a cache of this size */

It is then not needed to test the existance of the cache before.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/init-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
index 8fb182aaf87d..ebdb76cbb468 100644
--- a/arch/powerpc/mm/init-common.c
+++ b/arch/powerpc/mm/init-common.c
@@ -78,13 +78,13 @@ void pgtable_cache_init(void)
 {
 	pgtable_cache_add(PGD_INDEX_SIZE);
 
-	if (PMD_CACHE_INDEX && !PGT_CACHE(PMD_CACHE_INDEX))
+	if (PMD_CACHE_INDEX)
 		pgtable_cache_add(PMD_CACHE_INDEX);
 	/*
 	 * In all current configs, when the PUD index exists it's the
 	 * same size as either the pgd or pmd index except with THP enabled
 	 * on book3s 64
 	 */
-	if (PUD_CACHE_INDEX && !PGT_CACHE(PUD_CACHE_INDEX))
+	if (PUD_CACHE_INDEX)
 		pgtable_cache_add(PUD_CACHE_INDEX);
 }
-- 
2.13.3


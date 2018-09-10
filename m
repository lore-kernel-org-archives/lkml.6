Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF146C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85CEF20645
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85CEF20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbeIJTlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:41:13 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:8109 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727744AbeIJTlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:41:13 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4289q13fr7z9ttC8;
        Mon, 10 Sep 2018 16:46:37 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id rxG_HcX9c2DI; Mon, 10 Sep 2018 16:46:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4289q1360Pz9ttBp;
        Mon, 10 Sep 2018 16:46:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 840098B7B7;
        Mon, 10 Sep 2018 16:46:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id OfUJIAZLR9pY; Mon, 10 Sep 2018 16:46:46 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 24B8F8B7B5;
        Mon, 10 Sep 2018 16:46:46 +0200 (CEST)
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        aneesh.kumar@linux.vnet.ibm.com,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: How to handle PTE tables with non contiguous entries ?
Message-ID: <ddc3bb56-4da0-c093-256f-185d4a612b5c@c-s.fr>
Date:   Mon, 10 Sep 2018 14:34:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm having a hard time figuring out the best way to handle the following 
situation:

On the powerpc8xx, handling 16k size pages requires to have page tables 
with 4 identical entries.

Initially I was thinking about handling this by simply modifying 
pte_index() which changing pte_t type in order to have one entry every 
16 bytes, then replicate the PTE value at *ptep, *ptep+1,*ptep+2 and 
*ptep+3 both in set_pte_at() and pte_update().

However, this doesn't work because many many places in the mm core part 
of the kernel use loops on ptep with single ptep++ increment.

Therefore did it with the following hack:

  /* PTE level */
+#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
+typedef struct { pte_basic_t pte, pte1, pte2, pte3; } pte_t;
+#else
  typedef struct { pte_basic_t pte; } pte_t;
+#endif

@@ -181,7 +192,13 @@ static inline unsigned long pte_update(pte_t *p,
         : "cc" );
  #else /* PTE_ATOMIC_UPDATES */
         unsigned long old = pte_val(*p);
-       *p = __pte((old & ~clr) | set);
+       unsigned long new = (old & ~clr) | set;
+
+#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
+       p->pte = p->pte1 = p->pte2 = p->pte3 = new;
+#else
+       *p = __pte(new);
+#endif
  #endif /* !PTE_ATOMIC_UPDATES */

  #ifdef CONFIG_44x


@@ -161,7 +161,11 @@ static inline void __set_pte_at(struct mm_struct 
*mm, unsigned long addr,
         /* Anything else just stores the PTE normally. That covers all 
64-bit
          * cases, and 32-bit non-hash with 32-bit PTEs.
          */
+#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
+       ptep->pte = ptep->pte1 = ptep->pte2 = ptep->pte3 = pte_val(pte);
+#else
         *ptep = pte;
+#endif



But I'm not too happy with it as it means pte_t is not a single type 
anymore so passing it from one function to the other is quite heavy.


Would someone have an idea of an elegent way to handle that ?

Thanks
Christophe

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752716AbeC1A0e (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 20:26:34 -0400
Received: from mout.gmx.net ([212.227.17.22]:34753 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752654AbeC1A0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 20:26:32 -0400
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>, Joe Perches <joe@perches.com>,
        "Oliver O'Halloran" <oohall@gmail.com>
Subject: [PATCH v2 2/5] powerpc: mm: Use memblock API for PPC32 page_is_ram
Date: Wed, 28 Mar 2018 02:25:41 +0200
Message-Id: <20180328002544.18526-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180328002544.18526-1-j.neuschaefer@gmx.net>
References: <20180328002544.18526-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:5r1JfX1lnLXponBj9lN4MLyDWS9GKfj4FAaMc6dBC0PqiKZlVuP
 mPLxdUdhCSl6z9+L0D1fwWHo70bbToUqq+IP9C+G5xdZaJjbgAczBo/KHGmpd43SKFl/H1M
 ObuamyKaaT7YQVwn/qUQGnjno0JWf0KKVFIadpVMSpijp00DvIdYISpqAtMj3NuZXscJaVR
 78eE3YT7Sr8SY5WCztilw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6fj34sPQXmo=:NILmFApDZYju49MHRwn/sz
 kzfXmUknzGd4i8vQ+ozHUWEun4jcRJ4cqpXZyLHePheN5aMFUx8MZ8D57dql6KT6rr23pYNHt
 btpXDzlQq/UUYiP0D8PSGua7vsBwPZZhl2fec28EpdKHjf1YIV8PEQhAIGtOuveTkSFM4Bmr3
 SL2gnqUrmiCzfO9x8ENW9yAD/mG3UAxTuL1G5uW1mua3+s4gRVDHOrB1fl0Q9DPWAyN/I47vg
 qiHfGZHM7HS/wDbyBKcnVVB2EsbDkKjqFjhVHce0ZWPP7laZ4hs8ITBGMP62HcKUIDNA9JwTY
 UynG8dxueLQetKpQK2hm+quQ+QQmX2BfBvghyiXUfv2YkvoOljqXREeM23fhZNQn9aaERWSQS
 QlXoBchTc+3X8PRIdCUWThEV/WDjg9IhSmVHZ27459sl1a53PakzCO1J31T9KnWgiTC60k+F/
 CD4ZinPYQAoJX2c2i28oq27A11yYwRBZVrhLKLU+JRNpWSKOxm5wKFjrlN1LFWzBX3sj5JqHF
 kcz3eNys2BeSv5eo54C0Zc2TeObURhlYKnN8PsYQF4XWkpSUwhxYepwIpaR5vfKxQ8mJrj+TY
 2hr3w4meQuFOZP0imwKsYfIXUTm6FAlol3um4cKDYp9wtVzH5yyAHYKNNOlel+cotzMeo7T5o
 jLfl5+j702/toCI2GsTv27CS8jDKkTLZnf+zD1W/m3lgiGsWjJwOKwMItblosAg+rPkOxcRUy
 IycOB1yJQIreA4JweIwhecmiYB8ljPPTYTxbzEVLjzqB9Gzj8QYapmPWTSlcVYnADt3K8nqSK
 1m1gJ2XRTToM9KwUjGEcqnJF940pO1epKSPHM3u0WRC6bG++YE=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support accurate checking for different blocks of memory on PPC32,
use the same memblock-based approach that's already used on PPC64 also
on PPC32.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---

v2: no changes
---
 arch/powerpc/mm/mem.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index da4e1555d61d..a42b86e2a34c 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -82,11 +82,7 @@ static inline pte_t *virt_to_kpte(unsigned long vaddr)
 
 int page_is_ram(unsigned long pfn)
 {
-#ifndef CONFIG_PPC64	/* XXX for now */
-	return pfn < max_pfn;
-#else
 	return memblock_is_memory(__pfn_to_phys(pfn));
-#endif
 }
 
 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
-- 
2.16.2

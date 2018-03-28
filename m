Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752571AbeC1AcE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 20:32:04 -0400
Received: from mout.gmx.net ([212.227.17.22]:55867 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752008AbeC1AcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 20:32:02 -0400
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 3/5] powerpc/mm/32: Use page_is_ram to check for RAM
Date: Wed, 28 Mar 2018 02:25:42 +0200
Message-Id: <20180328002544.18526-4-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180328002544.18526-1-j.neuschaefer@gmx.net>
References: <20180328002544.18526-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:bQG1uSOZ520gD1ATxFq4+MYvYFQ3ICA0Wf9A/Q81VBKCgmmzXEU
 jbRABMHoa5hW035c0wCE9bCTPjYvB+7N69JkMvMtIWcAKG8t3IM9CbWxkXWLiHPSxWDtzhK
 hqZqMJPj9MtWtAt/JgBniFmfL5hgLzX3PuoJB7E2d1w0FYtXU7SJO8RL06FTmrM8xvtA6mL
 IaZirbDQYcsM9VmWyXLMw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CX1cdQ9U4F4=:8lMQxcdYXR8y/35Vc4diwI
 UaNMFj9E5y17Vqndf7xiNLsj8FpsPzznILF/xzLu/Pea6bnDliWkwA5sT1MQL+svcQtQ1bG4O
 WB217jfp8OpxPHTlIamarvhMuNuHlrw8kI4gNDk0DG6or3tK9/QcvCKTtjgXGlNQa9XQC+JTZ
 n40ZcdbvUtFniZlob2U4FCTjwKpROPE1a2HTDj2acS3I+Bfc53FGoky+xozvc5FNAn8jzmiOP
 bWf0V0NvqbaBkDg6TVWLPw6A97f/a88cdsiBX9NtP3QGU1K+lbVPK5g4OAw5JQBWvsk0nos/x
 oGbOQX/oy+rLWgipFNAI18TOmBKPZAXkx1YGC2Pnv+JfoWRTIX9l+BJS8aokX0BJTwMQ7kbg3
 d5yHK/wIEouxGTajzTF6Po6qfmZ9YjlAN0YqNvd1szwozv9tdr2vk7XSj5bQcWA7DSvJwLlTn
 z8cfFZzBna9ioU8Ty3GfOO252c4IjbsvCSHeJJOUaGqAgkM1Hs5EZFitJXecC+W7AKVb+0D4x
 kqHr37Jfl9k8km21/i5wkHx0mkaLnhq0DUu1wMW+LN+D6edp5PchLZq+nrlSE1a24B/zZOuzx
 eXaM8wmVY+ke9djiwfIVVkBvHM1ac5xHWW5C+g67WViTuOJyyPOJcg52c8o1nY+6wSVlZwfRT
 q0sw+31cpsVuGEZsVf6dRAEfaaNB//XrnkWajJKLiovhFvJWFuYxwBShRUO3NWY8Y51qzp7U/
 +Qyol20tZxnJoKZEPiMv+Y/Rtdo85qjzq3l+FHy6MO0K56eVpNwShNL/fYjOTrq57J2Sw/aPt
 HVTN6NEtKgoeYqCQy9JE94YgKwLdSBLjdNp4BZNo8RwAUraB+Q=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On systems where there is MMIO space between different blocks of RAM in
the physical address space, __ioremap_caller did not allow mapping these
MMIO areas, because they were below the end RAM and thus considered RAM
as well.  Use the memblock-based page_is_ram function, which returns
false for such MMIO holes.

v2:
  Keep the check for p < virt_to_phys(high_memory). On 32-bit systems
  with high memory (memory above physical address 4GiB), the high memory
  is expected to be available though ioremap. The high_memory variable
  marks the end of low memory; comparing against it means that only
  ioremap requests for low RAM will be denied.
  Reported by Michael Ellerman.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 arch/powerpc/mm/pgtable_32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index d35d9ad3c1cd..6668ecc041ad 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -148,6 +148,7 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
 	 * mem_init() sets high_memory so only do the check after that.
 	 */
 	if (slab_is_available() && (p < virt_to_phys(high_memory)) &&
+	    page_is_ram(__phys_to_pfn(p)) &&
 	    !(__allow_ioremap_reserved && memblock_is_region_reserved(p, size))) {
 		printk("__ioremap(): phys addr 0x%llx is RAM lr %ps\n",
 		       (unsigned long long)p, __builtin_return_address(0));
-- 
2.16.2

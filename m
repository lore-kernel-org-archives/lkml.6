Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752897AbeBTQR3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:17:29 -0500
Received: from mout.gmx.net ([212.227.15.15]:53069 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752865AbeBTQRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:17:25 -0500
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        linux-mm@kvack.org, Joel Stanley <joel@jms.id.au>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Balbir Singh <bsingharora@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 1/6] powerpc/mm/32: Use pfn_valid to check if pointer is in RAM
Date: Tue, 20 Feb 2018 17:14:19 +0100
Message-Id: <20180220161424.5421-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180220161424.5421-1-j.neuschaefer@gmx.net>
References: <20180220161424.5421-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Hthx+kvy28X5VX0hPeeUhv94zCtzEu6cEWzBT0iLWjOUd4wXolt
 4wkiwoP6d0TUVgnCVMA6a/ifYyfRxtOLQA82xEcACf/G5o/tVdp6qVqjLKky9COui7URr4R
 rPwfHyBrZWqYbPGnQxQ7XocmCoSa8P9622C3P1LEiCYzj9yL7N2ox29M4kLcTbIVNmd17YM
 8LHsqeLBmO2Dvue4lzYEA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:neJzz4bDzMs=:HBQ4T4Bv/XNrq5QvnmLta8
 mkSqbV06t4B6LdWLn8GwbgPXWxOkLkuko/SoBUPOm5RL1eIPjhj5YXqY8Q1gBCSpv+fFxxX89
 JEwowTDHEoToKL2bheWnvfoyKltUWcRsHHiBRGoDLA9xkw5g+zH3+ROyUSUOoQCpwASynP2Vp
 aYJBuRQXPKvGvniXlBv0A4AqIapvgzt1jYhChXw6gvFF3uDu3/1HHp5VEqKOKny2Yfwwl/R7z
 khumRu8OU1Xl+uT0lIoKCdrjaubPVBnRxnBYMnZawp5mNk7e3xBw3FE6Lb8ZMoxMD0fWYL7aZ
 1YVp/fezehQUbwuYFHO9ar1SjJLXGnPcrpQkTYIDXsDgQAlT9pJtemtFiXyYuKjxfrCX1/DpR
 s1sQvRy7GHldb4QC9rhXAE1x0yhagw2GXRq2oT3z9Zcj6lOlB5vdURY8JOvPUzsUXHbO/xNnC
 sgAJ4wmlhQCfeNpnzfCh33uLAiGQK+VhRNRgUhkUW2mqKTnR8TycCocNe+ymtglMKoPXzD2yb
 6v/U3yxe8FcemgSs/tOaf1qUzKILq2BhTCGunEEsVz64/Hz/0hb8toH56q1Xn5MFTekfnzX6T
 iFjLNtveNCbsUYM7eC6t8IfoDZAXJMFu5nl9ruvwk/2WTAJOuG7hJfmj9k6SkAMeZdq7zvqX1
 PYGiWKEx6povq7W4eSIAZFqM4dKAY8s3AihaymKxD0GoY9c0H2N0pODFTlwItWBzx9Lr+Yptk
 cw0pAcMUmhKGQy3BzeU+at12tUZMIQq/aC6ZFmTOLeotlDT0Lww5Ka731sKQvQd0gkMolFYiS
 /2HzrKruIW844ORMt9UGGYA4yBfCoS++LGdVXOOHjuetWWZp4w=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Nintendo Wii has a memory layout that places two chunks of RAM at
non-adjacent addresses, and MMIO between them. Currently, the allocation
of these MMIO areas is made possible by declaring the MMIO hole as
reserved memory and allowing reserved memory to be allocated (cf.
wii_memory_fixups).

This patch is the first step towards proper support for discontiguous
memory on PPC32 by using pfn_valid to check if a pointer points into
RAM, rather than open-coding the check. It should result in no
functional difference.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 arch/powerpc/mm/pgtable_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index d35d9ad3c1cd..b5c009893a44 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -147,7 +147,7 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
 	 * Don't allow anybody to remap normal RAM that we're using.
 	 * mem_init() sets high_memory so only do the check after that.
 	 */
-	if (slab_is_available() && (p < virt_to_phys(high_memory)) &&
+	if (slab_is_available() && pfn_valid(__phys_to_pfn(p)) &&
 	    !(__allow_ioremap_reserved && memblock_is_region_reserved(p, size))) {
 		printk("__ioremap(): phys addr 0x%llx is RAM lr %ps\n",
 		       (unsigned long long)p, __builtin_return_address(0));
-- 
2.16.1

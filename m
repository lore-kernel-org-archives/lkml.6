Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752687AbeC1A0V (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 20:26:21 -0400
Received: from mout.gmx.net ([212.227.17.21]:32889 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752654AbeC1A0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 20:26:18 -0400
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCH v2 4/5] powerpc: wii: Don't rely on the reserved memory hack
Date: Wed, 28 Mar 2018 02:25:43 +0200
Message-Id: <20180328002544.18526-5-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180328002544.18526-1-j.neuschaefer@gmx.net>
References: <20180328002544.18526-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:fRiZ4coo3t3knmAUPIIEoC6xqtYK4B8lJ1kT7i0c4yv1Qg5xw2T
 2EcDVMNRqOVKXDk8q6DGcuGCoAY6G/uxNP2mcNFofDX2zaL2fCsuEevXUoZEiQ7gTJRmt1/
 Khik0A1V86SPxUb0Bz8jCPN3bwCjFUiz9IsRzL14dPk2mMkJJDr+1RWN0PVWh3j49n/f0CQ
 s6TbJo+vT2VF7eWAIB4cQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:62Kr/n6tZoI=:KAiF5X8Z65mGmDqV6J2Noe
 5ImF8Kp0JjDbosLu9Wyn+i7Vavmy7gZCg59T60eyw55GvWfmEabnf9+tz1v9l7EPtKcuVme8f
 PsAJOIxTM8BF9TCZbE2EGebeBbsjB0kIeLjGYTV/Ly2ybYjcjEYK1dz/Qr7DahbufXo++tIeA
 jnWGWte205/985NiyRb9mHb9QxPob4P8hd5gzpYSPOw6doS6W2hyW4UJ2GM87C8SJy5iDNI8g
 f+ivDBS5c5AxuLqTOi3nrSYuxQai19pmHPhgf2c+x2fPTzW+2051vabWMCIwLhZS9zrf5n/sv
 g9+AbzaVMfytrp95w8p0DsY9iYpUS/Rdz71b1IJVVdY4Lxwwh4OmuqihYVuowPjzEHxxmIoaK
 KhPG/kuBRYkzt40xZmY2Hz9/c4UmiawXxY7uTZpcs6iBZLFCjy9YX/Jlj6TfJC+V7r0mu++rm
 LxPTckMJXd1oH/Eylp0XQq2374trrWSZV5Qe0QatUkjlAXWgA7szXbZrDsRiQDY0wuJSVNA1t
 dfCjM0IurMv30/p6Kg7UE9+536J7qsvqM0YBh5KqycLjhSjtzcJAGNrdod3JbDDb8nfhSLTpV
 X87behclKof44mxBbUSdtFaR2s0KrieoztwAsD97/qRLiLbSiBw6tK7/6g6wVArh9GmvX+Itw
 APDw8YHFEDJejMBev3oO8LigajpGow9DSAD71EYMMJYmAnk+3DKImKy4nIsG4K+sZDBF56Ap5
 MoD0jG3B7P8KbVuUfnONl+IQjxYOm7jv7zsnG5F9bgsYLN/VhzGAozSZEWyEdA3fKn9B8l9hg
 nB4YBgcffe2Nk5ldUbFTn/5OxhORAFV+bjifkI6kYLGfv1UwOk=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because the two memory blocks (usually called MEM1 and MEM2) are not
merged anymore, __request_region in kernel/resource.c will correctly
allow reserving regions in the physical address space between MEM1 and
MEM2, where many important peripherals are (GPIO, MMC, USB, ...).

A previous change to __ioremap_caller in arch/powerpc/mm/pgtable_32.c
ensures that multiple memblocks are properly considered in ioremap; this
makes it unnecessary to set __allow_ioremap_reserved.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---

v2:
Add some text to the commit message.
---
 arch/powerpc/platforms/embedded6xx/wii.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
index 4682327f76a9..fc00d82691e1 100644
--- a/arch/powerpc/platforms/embedded6xx/wii.c
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -81,21 +81,9 @@ void __init wii_memory_fixups(void)
 	BUG_ON(memblock.memory.cnt != 2);
 	BUG_ON(!page_aligned(p[0].base) || !page_aligned(p[1].base));
 
-	/* trim unaligned tail */
-	memblock_remove(ALIGN(p[1].base + p[1].size, PAGE_SIZE),
-			(phys_addr_t)ULLONG_MAX);
-
-	/* determine hole, add & reserve them */
+	/* determine hole */
 	wii_hole_start = ALIGN(p[0].base + p[0].size, PAGE_SIZE);
 	wii_hole_size = p[1].base - wii_hole_start;
-	memblock_add(wii_hole_start, wii_hole_size);
-	memblock_reserve(wii_hole_start, wii_hole_size);
-
-	BUG_ON(memblock.memory.cnt != 1);
-	__memblock_dump_all();
-
-	/* allow ioremapping the address space in the hole */
-	__allow_ioremap_reserved = 1;
 }
 
 unsigned long __init wii_mmu_mapin_mem2(unsigned long top)
-- 
2.16.2

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932284AbeBVMQH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 07:16:07 -0500
Received: from mout.gmx.net ([212.227.15.15]:48799 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932159AbeBVMQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 07:16:04 -0500
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        linux-mm@kvack.org, Joel Stanley <joel@jms.id.au>,
        Christophe LEROY <christophe.leroy@c-s.fr>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Balbir Singh <bsingharora@gmail.com>,
        "Oliver O'Halloran" <oohall@gmail.com>, Joe Perches <joe@perches.com>
Subject: [PATCH 2/5] powerpc: mm: Use memblock API for PPC32 page_is_ram
Date: Thu, 22 Feb 2018 13:15:13 +0100
Message-Id: <20180222121516.23415-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180222121516.23415-1-j.neuschaefer@gmx.net>
References: <20180222121516.23415-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:HXQxNQxY+Q02yGRL6Kz8Tk39uBZXI9Cqhs7UTon4LbICJDL0/kq
 QTi6Awrtqn5PAhP0IudbJpFfXws6h6p434XYeVt1GrXmElBMPGPcjjcfEpeTioE2Je11l8X
 Y2IXnHWW4zzLy/uCVpSEjFcfKyIin1zNMmTruXtMau+X0SMkZ3HOqY8MVGgq85W3aNHzumL
 3TWYYWYz7D0tpT3Rcegow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZfB36E2romQ=:WfRSJDF8IcyTwwFSYgOq4S
 GjAYGQjRpAGOO8W3UVQ4dc0Vhjv2r8Pl6h9irOJQ9qoWzJ4UMPhtG5Q+rh6+3TR2GFuBJ2Eez
 KmdxitM2WniZ5faWKNGlswEmccGEmvN8yl0qZxWi8mcnBWrPmUNjBbdtuG8RubJSy/kgc291R
 d2hg/FFVmtAsG7/nLCE1OEsVyYmXtRJ/h2vMtPZmrV69XKJCSlwec5/reT27ItfgdkXj8AWLl
 xNgogz0+yRBj4Du+fYtgfrv5rMQ3xxAPOBidL/alVo+AdfMFxqxKdpEumLwApc2ZqaERk9wda
 N3Uc/CVQkhHlfLzIt/fQIIxMCt73zNXCgvbngsTg/td7jBH/rsT8gufnBdsp5q1ivum++qGEE
 NYqNMnzVMP69z/3JEwgeoIaXfHAtexD+ankr2VlbGNL1TewxF8pnxZG1GTpvbckjZBnx7NzBY
 Q2tCxkCixrnFaQju4MbdBmi0OtN7jzvN7hvI5Cts/7oO7krrqDyEQnSDuy1Sz0yQiEf220zX5
 uuo4Ey283DHHeOEzLSklIF2QIsM8R3aOWHUdv6e4Xmk5H9aKggla4XPWA4R2T+TXh2E5cMP4D
 RSF1Ym1cJb+4W79ZEMyw8LINmLT4egAxY30wP0noDWXaTsMyfNZBjH4bvisXZx/tvNOOZwmEF
 MsjfdZdAb9gGYTCRw86lt8S7VHZtHWLnK4DGf/U4DxlIivYaX4yzWDoftfC7d2Yr46/6/5Rz2
 mOU0QiBaWlBbgEp4A5tDOONyj0Cj9gi3H6lLS+mJnFL6sRUo+60AqrobPBn27c++squKnC6Nf
 V0rz6aOb4mTE8NCTnXsa9iM6ZIVxZaLcl3AKaQZKTu/3RvWtGo=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support accurate checking for different blocks of memory on PPC32,
use the same memblock-based approach that's already used on PPC64 also
on PPC32.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
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
2.16.1

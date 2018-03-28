Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752649AbeC1A0R (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 20:26:17 -0400
Received: from mout.gmx.net ([212.227.15.19]:50887 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752192AbeC1A0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 20:26:15 -0400
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Joe Perches <joe@perches.com>,
        "Oliver O'Halloran" <oohall@gmail.com>
Subject: [PATCH v2 1/5] powerpc: mm: Simplify page_is_ram by using memblock_is_memory
Date: Wed, 28 Mar 2018 02:25:40 +0200
Message-Id: <20180328002544.18526-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180328002544.18526-1-j.neuschaefer@gmx.net>
References: <20180328002544.18526-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:4X5xhHCQrKNvvRNv2KZQfNoK+9KF464oEOgCR6y+MTDs3jhN1J2
 lvS4NFBx0Xwaf9fzSXem9+vkgiMJWXYyTMFKfxqlg5pE9QBXqE/ZT7Bn4kNfItB93busCAP
 3WgtVQSIMHu1NX4ch7L5UMvTgSrIp8mtuJ9PsIxcVUq06Olubs6nP9VQxKdeSA2vxaUdwF3
 Ew/LY0XnYt8I7s44KpDSA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:69EKAHRScN0=:gcqe7oIyiuetAkWF2ZYrBm
 4/EIuL+OzvhPyCsKMTwiBQlhYYttIO+iHBI+QA6HjA+pf/MKpgpjxrstlCXDPVB8N9REXMGis
 X7D0hnIvNnlctMepcwxGwm19rN/NQaSGZ/atMMuBYh+VCmAAkh/bkQ5HCbLO5+wxe8Ck1MEys
 SzGz0Ov1Bk9t2vyoQSUXL1qdF48pp1Ax94KE0XltUqyRsxOu0Np+6yWrDrhvuXLaBEdnD8ILp
 qh1RWedMMoNjSMrvicCTiKDJcdfk9vDq4m7ngSImMnMQ7ZnJUXmVEdPJ2u0lJD7rJsH1YIpg0
 Xw4mjhILm/psTz/eRGoVVD81C/rGLd5cbCu5fWfsDZTeUJyxT0hyQADGe1IMRnbRVWYpS5W6m
 5h9BEZX+VOY+5SlgSAudBA9BQHDIfc/fE86VHyljCKNuoYayJfWdTmPhCPHxVyEMWbgA2miKH
 eyfzNoTj0nxUdm9gKy9w5P+DS2xKUrmpErDaXJXRV94SuPuOGtU3/wy9IfO3rA4+Oa8lF64wt
 jxK0XPzpC0ERiJM4ms83W0iqxmXxCvGY7pkAXVwTrvb1in34k854OGHMuYBjHPdNDpj9FmrSs
 4cDggnGmE6yvR5KpYtPaxlgqBIBxFWQ4UeEtSP3oUl5hDJebD4pKSRFBD+yzEyFmZUisa/WsT
 S9u/adGTi+2GTvy7sJY7mCUAqsF1Prng/Bj8+m/3gn4EK0hOJ7UKs15e5zc2QVlIjfXRWJy8X
 PI+5L3hkRlmOyhfueZxdvaoM31nmkwL2ze8GrOS6TT1LDWSvgvBWZfFsud358QIjgWGe8cgn4
 9T/OtAQliIVv0plOF7kttVIcnHP7Ngljw8gGUED8y/BwxS2Blo=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of open-coding the search in page_is_ram, call memblock_is_memory.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---

v2: no changes
---
 arch/powerpc/mm/mem.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index fe8c61149fb8..da4e1555d61d 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -85,13 +85,7 @@ int page_is_ram(unsigned long pfn)
 #ifndef CONFIG_PPC64	/* XXX for now */
 	return pfn < max_pfn;
 #else
-	unsigned long paddr = (pfn << PAGE_SHIFT);
-	struct memblock_region *reg;
-
-	for_each_memblock(memory, reg)
-		if (paddr >= reg->base && paddr < (reg->base + reg->size))
-			return 1;
-	return 0;
+	return memblock_is_memory(__pfn_to_phys(pfn));
 #endif
 }
 
-- 
2.16.2

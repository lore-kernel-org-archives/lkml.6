Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932236AbeBVMQC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 07:16:02 -0500
Received: from mout.gmx.net ([212.227.15.18]:60617 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932159AbeBVMQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 07:16:01 -0500
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
        Balbir Singh <bsingharora@gmail.com>, Joe Perches <joe@perches.com>,
        "Oliver O'Halloran" <oohall@gmail.com>
Subject: [PATCH 1/5] powerpc: mm: Simplify page_is_ram by using memblock_is_memory
Date: Thu, 22 Feb 2018 13:15:12 +0100
Message-Id: <20180222121516.23415-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180222121516.23415-1-j.neuschaefer@gmx.net>
References: <20180222121516.23415-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:XWvX93o2JH6Wl8FiQeMc/lflGyGAM8DKpJg5Ji2lItwpqGkAXWa
 U/8KcD1gEFpuUITxWvNEvmpUFQLKa75G4D6IvPRVQBCHayPJr16SYCLZ/caPTsZpmhZ++ss
 6iIdi1dD1HOOhQr6L7gHcdApWQAyWSDrJwQCqFDApuqxPQTBPBoU+MKzLtjcYvQYMb6yW46
 MdEBIJu6eN+PTG9FzddGQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DfaDm+0sUEg=:6ZmFnhGfjolenyLucpe3Z4
 ZBMJWSgSg6fhiFc91cWovZVjKjLAWFpzzhD39TlrjWDhoVcCe+640XxPzKmAqn14XqqLf5TYW
 UqiLahb8NRWR43j8h3BsIZRc2LqGXgfkjmgnyT0+RpGkY8d/1t1exonsHDiLKDoRgUpv7Jh1S
 tNI6LXIfVv4YGEUJCf+eGvD/qb6Ez+9Sy8afRPtgBcXlXDMsyW8FLgmWlLqYYBoTKa3Nx/ca4
 PqoP91tEVu6lOt9hcqyKVcczqxIK16mR9OP0VcPNqbr4DLowdiYJJzZZ7WhRezQks/E2O7FLG
 36IzcM50rR94qhEz4VuiE44T4eBQmAnvDrHNn9aA9rtJSwl1pxdlMtU59MFI5QZp9XqmMMh0w
 JnznJuM6C56qoRB1CXb3T9di9bi1A8WHzyqkMyOKnFE20pv3PjeU8R3q/1ZRWJ3WDuMK7D9gx
 9bjqk5sieVOclH1BUL7CfN0z45khVanfxOcWVzhgXirEwRgTTUIHksSwRr8sz69Q8Ze3sshYO
 qk7kLMxvX97WTR8GU5ol0SkGfcBRr7jXwHEsng1TAQtCGLgPvLAuXvF5vGTO4IW7g7V0xiaWq
 u2Gv/pNACkAN8fz2hruS8ZKHGKBWK9qZoRIYaSPULfNnedsyn+Uqxkxa5cd6kwEmRT7AYclgF
 2zmfY3vq1CdOv7JGlglBs01kFzpVOw9juWULsDS3u+ZfOtS5pGtJp5TzjJdtP/XgZStFmn2RY
 0827fuVo0/XkIqGRNFhXyUgeq8E3UxL3q2BqTJg8r3zuI4zjks7+1cC2Xmt5V/kkCks9a7POn
 Z7wtN7lrQ/uCAJOiYIflovVhCUEN2Xydg4GJxkqTQYn8T4C47c=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of open-coding the search in page_is_ram, call memblock_is_memory.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
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
2.16.1

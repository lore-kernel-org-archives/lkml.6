Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932341AbeBVMQc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 07:16:32 -0500
Received: from mout.gmx.net ([212.227.17.21]:47199 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932077AbeBVMQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 07:16:06 -0500
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        linux-mm@kvack.org, Joel Stanley <joel@jms.id.au>,
        Christophe LEROY <christophe.leroy@c-s.fr>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCH 4/5] powerpc: wii: Don't rely on the reserved memory hack
Date: Thu, 22 Feb 2018 13:15:15 +0100
Message-Id: <20180222121516.23415-5-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180222121516.23415-1-j.neuschaefer@gmx.net>
References: <20180222121516.23415-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:no0Bh1zJjmJQEtMX3MGI68G+d3Lph+K4+Vs8bwF1EMnSZ4krBTY
 QQyxzwjoHaWU16FDIlwv8RI4JBm51FlCWgWkaUF/hrU2ZA7LV0RzbRv85N+hxmvMdL6jMD9
 Qnw3ldegM05gtzX/TJ3CaY9O0bcKlxX2NA/P2liFQokM+1AEBHGZwg0phtkPiJKocrtM2/B
 /MhG4sCVbd8xG20PjwpTA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1Cf/jYba+aI=:aMshu3YknPujH18v3diJee
 bzFClLfIVfziWYkM+JiakZOlrdULbRNnP5gLlmuyKGFDDqps8uUTQwjQmvk6xqWZIerEWlxis
 VeuCcBAJ3bdVyyZFTkYr1I48LZy9MVVfU5WARGTpwBKrdeyjBzqNF3aioWPe6I8IBr0FyPGyo
 70SjLNG0KpZMwfAJWqsWoTnGPRPS1rNZ4k26FB7rt91gfjJH8+n3jPozTcE/LL3OXvNk6GabY
 8DWP2clOcHKlANKp+jpwVijsnmFlWTR8JpAnhKzgSwRtNGv9Bm1AURqbJzAM43OoDx7GxncT4
 Ru0HJ7Nsp5/Az60DRb7Gd+xQZlJwl6FyeytwYcgulhdHxOdpFjqEMHv5ZapzuqMlYjzHZcfkO
 Gswj6WnNq/YxpKsLgX/4z2bBOZAqHypKIUTKf3aCD7hb+qoed9pyU1LRSFYvSY/m/lKa/Xyqf
 SwiWtui5Q2kRAwWYQoufp/g79k0cETfCDIMKemSGNvKe9+g800INDUFxPeljsnWmnfDUKMV+t
 +XeeHGqWPDXUkug4IuMfHsR9IsxbnfyVqzif3jAdQ1AvuS5q91VZw4JBZvxcXyyzdtNniYMsL
 PNr5ajy3Mo2uY8Q5CvORwXl1i0D6i4Te8h0Hqjhyx4ZMeaEHD+NKp4lVktNl3vAXbjjxEgG4a
 4NyTOW+oEHiwC0RHH7t9m/ksUROm24lQVZk3hl1DCyjxj9u1kOpKGYbzXTxVDK6hMTVO+ahFu
 MAb7ujYsqyl7HVj1eiC5kzInauERF78QJQCwTPJhjDHKzE4rWo1Z4VAGNdd/F6VqQsIN6bSrb
 R+Q12bnjWMwiE74ucf3iWF3w3xbRe8Mat7rhNp1KThY90YiSPI=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
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
2.16.1

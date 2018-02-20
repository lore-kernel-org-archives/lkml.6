Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752837AbeBTQQx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:16:53 -0500
Received: from mout.gmx.net ([212.227.17.22]:34605 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751993AbeBTQQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:16:50 -0500
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        linux-mm@kvack.org, Joel Stanley <joel@jms.id.au>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCH 6/6] powerpc: wii: Don't rely on reserved memory hack if DISCONTIGMEM is set
Date: Tue, 20 Feb 2018 17:14:24 +0100
Message-Id: <20180220161424.5421-7-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180220161424.5421-1-j.neuschaefer@gmx.net>
References: <20180220161424.5421-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:lZIGsfQDedeE7iQHvVsDtkfAq0H8hSzdwMrOUnPhk1B8ESguVvv
 9KV4W7NRDfNKz2ALejPsyYOqSlTqggvhtGef846QFFN5Lw2KEdQvdnopPWSLEG3fALshBR5
 rmauqk9r5FV67Neeh1f1rKGu4WuaKTs9Ci2jor/tTAfGtKQttSLJTMkjOyUdjxvbK6VwVDQ
 qH0T4P5FzkpW9jPK0iJZw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hibDOacvZ/U=:HK4HZch/9T7nF2+BaNUXYP
 OT5ckh1FjzI4pgmV9MORYrFtRpYWfYngMrE/BFV1hkTYdgQRm0jTRiq7dwixFJz8/b52HdG4v
 m98YF0ALyJCqrTuWb6wLrqlHYGz3IqI+GZqX8cUsrmPn67M40pcEpfcvnt3rp3hGwcoDig0sF
 Fv2SiHt8WXIeC4BbghpF04BgyQr5dcydnPrc4K7Sa2rCv5wE7fjcVL6Hr4rrxMtMwlKW3muy7
 Uf+ytsd4FtQylgudfeBQk/NMhXvFoMfOehfJS2fbIMa0KcrXVj9Ulynnse9FiK7gbJB+9C4ES
 sOpsyUS+55jQbQtKrfHJSqZW81Bn42rXnK9G3yX1XiO1/wweIbfZ3L71jKaS8V9caRekwKqn4
 O/6et0O6O6EjO9Cq/2Uzi3awAVbiPUB5ee4h9dPjwjM61JF7RmCsaHcGcJTNleBS6YkX6UMe4
 yOu0TXYzRCSajyIU3yjuk99f8u54+YRY4cQtqG5LsWNsjXXcLI6KmN2Rsm++Q1fvmJ2lkLSYr
 8Nr0IVyT4aZ+IFtPDSEEjbP6npvG7gOX4oOGn6HL6udzCTkX2Izz87+e/ciKco2oFFcZCCooj
 dTIVNlZ+WvoRSxNJNWoF5udhoSKccovQd7vB9GX84LtmpwhqMXWNffjVwOayRMwiX6Qc2FWse
 f45luFOkVGMng/bAjRN5NYx19ywG4A1SD8a8az3iMlm1SCjU2pqWneT8yJd46frW+P7MjDTsV
 22xKFtXCqD99c9HSMDZ4lAMe3InbFrpqxo0/imfOLD69on0ecn9ORLOSWmiAvGkL4X+Y/BFQJ
 ZHFVzPp7R22DyEQAo4GjefhGYaAG4uW3GZoH0hecTrSAmwJGg0=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 arch/powerpc/platforms/embedded6xx/wii.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
index 4682327f76a9..589ac87a3ce0 100644
--- a/arch/powerpc/platforms/embedded6xx/wii.c
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -81,13 +81,16 @@ void __init wii_memory_fixups(void)
 	BUG_ON(memblock.memory.cnt != 2);
 	BUG_ON(!page_aligned(p[0].base) || !page_aligned(p[1].base));
 
+	/* determine hole */
+	wii_hole_start = ALIGN(p[0].base + p[0].size, PAGE_SIZE);
+	wii_hole_size = p[1].base - wii_hole_start;
+
+#ifndef CONFIG_DISCONTIGMEM
 	/* trim unaligned tail */
 	memblock_remove(ALIGN(p[1].base + p[1].size, PAGE_SIZE),
 			(phys_addr_t)ULLONG_MAX);
 
-	/* determine hole, add & reserve them */
-	wii_hole_start = ALIGN(p[0].base + p[0].size, PAGE_SIZE);
-	wii_hole_size = p[1].base - wii_hole_start;
+	/* add & reserve hole */
 	memblock_add(wii_hole_start, wii_hole_size);
 	memblock_reserve(wii_hole_start, wii_hole_size);
 
@@ -96,6 +99,7 @@ void __init wii_memory_fixups(void)
 
 	/* allow ioremapping the address space in the hole */
 	__allow_ioremap_reserved = 1;
+#endif
 }
 
 unsigned long __init wii_mmu_mapin_mem2(unsigned long top)
-- 
2.16.1

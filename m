Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752074AbeDDUIo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 16:08:44 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:32788 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751556AbeDDUIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 16:08:43 -0400
X-Google-Smtp-Source: AIpwx4+zUbF+p6tR8zaRZIrMhWaEa3UMOxHGLjFLpbDKJa4c0l0PP+xWlnfHNiUHzoIqNBhVwpBHDg==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
        Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/19] powerpc: Move `path` variable inside DEBUG_PROM
Date: Wed,  4 Apr 2018 22:08:35 +0200
Message-Id: <20180404200836.27446-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180328193307.978-1-malat@debian.org>
References: <20180328193307.978-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gcc attribute unused for two variables. Fix warnings treated as errors
with W=1:

  arch/powerpc/kernel/prom_init.c:1388:8: error: variable ‘path’ set but not used [-Werror=unused-but-set-variable]

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v3: really move path within ifdef DEBUG_PROM
v2: move path within ifdef DEBUG_PROM

 arch/powerpc/kernel/prom_init.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index acf4b2e0530c..223b35acbbdd 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -603,7 +603,7 @@ static void __init early_cmdline_parse(void)
 	const char *opt;
 
 	char *p;
-	int l = 0;
+	int l __maybe_unused = 0;
 
 	prom_cmd_line[0] = 0;
 	p = prom_cmd_line;
@@ -1385,7 +1385,10 @@ static void __init reserve_mem(u64 base, u64 size)
 static void __init prom_init_mem(void)
 {
 	phandle node;
-	char *path, type[64];
+#ifdef DEBUG_PROM
+	char *path;
+#endif
+	char type[64];
 	unsigned int plen;
 	cell_t *p, *endp;
 	__be32 val;
@@ -1406,7 +1409,9 @@ static void __init prom_init_mem(void)
 	prom_debug("root_size_cells: %x\n", rsc);
 
 	prom_debug("scanning memory:\n");
+#ifdef DEBUG_PROM
 	path = prom_scratch;
+#endif
 
 	for (node = 0; prom_next_node(&node); ) {
 		type[0] = 0;
-- 
2.11.0

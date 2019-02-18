Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B42C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8533217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="TZCcIvz/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730847AbfBRMZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:25:23 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:39462 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729639AbfBRMZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:25:22 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44333c12w1z9v0s0;
        Mon, 18 Feb 2019 13:25:16 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=TZCcIvz/; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 5kyQMr2VWdiF; Mon, 18 Feb 2019 13:25:16 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44333b6xLTz9v0ry;
        Mon, 18 Feb 2019 13:25:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1550492716; bh=1as0ClI9dn5BE3e3EcZOrFyo31L77TqVjn8Dhtw/V+k=;
        h=From:Subject:To:Cc:Date:From;
        b=TZCcIvz/VBqlnFS/mHEJT7Kew+xZcQk1n0Sy5ytEdKoz3SF0X0WhODFvfj+P1qSD7
         RSpkfhA6H7+fjiHxkfWunmu2xW2sFLUodzprI1fWnl/QavUrn3qemzZHN21zEd4x7t
         YJ8UisBtAwwIMdEpbUAamfbB6lRIbw0QQkH1b3xc=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C56038B7BC;
        Mon, 18 Feb 2019 13:25:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id fk_fz_MQUNcB; Mon, 18 Feb 2019 13:25:20 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A09408B7B9;
        Mon, 18 Feb 2019 13:25:20 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 7F8BA6A4AD; Mon, 18 Feb 2019 12:25:20 +0000 (UTC)
Message-Id: <9afb42b9d78abe00fe049e1736a180b1facdfd86.1550490186.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc: dump as a single line areas mapping a single
 physical page.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 18 Feb 2019 12:25:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using KASAN, there are parts of the shadow area where all
pages are mapped to the kasan_early_shadow_page. It is pointless
to dump one line for each of those pages (in the example below there
are 7168 entries pointing to the same physical page).

~# cat /sys/kernel/debug/kernel_page_tables
 ...
---[ kasan shadow mem start ]---
0xf7c00000-0xf8bfffff 0x06fac000       16M        rw       present           dirty  accessed
0xf8c00000-0xf8c03fff 0x00cd0000       16K        r        present           dirty  accessed
0xf8c04000-0xf8c07fff 0x00cd0000       16K        r        present           dirty  accessed
0xf8c08000-0xf8c0bfff 0x00cd0000       16K        r        present           dirty  accessed
0xf8c0c000-0xf8c0ffff 0x00cd0000       16K        r        present           dirty  accessed
0xf8c10000-0xf8c13fff 0x00cd0000       16K        r        present           dirty  accessed
 ... 7168 identical lines
0xffbfc000-0xffbfffff 0x00cd0000       16K        r        present           dirty  accessed
---[ kasan shadow mem end ]---
 ...

This patch modifies linux table dump to dump as a single line areas
where all addresses points to the same physical page. That physical
address is put inside [] to show that all virt pages points to the
same phys page.

~# cat /sys/kernel/debug/kernel_page_tables
 ...
---[ kasan shadow mem start ]---
0xf7c00000-0xf8bfffff  0x06fac000        16M        rw       present           dirty  accessed
0xf8c00000-0xffbfffff [0x00cd0000]       16K        r        present           dirty  accessed
---[ kasan shadow mem end ]---
 ...

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/dump_linuxpagetables.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/dump_linuxpagetables.c
index 6aa41669ac1a..b0da447197d4 100644
--- a/arch/powerpc/mm/dump_linuxpagetables.c
+++ b/arch/powerpc/mm/dump_linuxpagetables.c
@@ -143,14 +143,19 @@ static void dump_addr(struct pg_state *st, unsigned long addr)
 	unsigned long delta;
 
 #ifdef CONFIG_PPC64
-	seq_printf(st->seq, "0x%016lx-0x%016lx ", st->start_address, addr-1);
-	seq_printf(st->seq, "0x%016lx ", st->start_pa);
+#define REG		"0x%016lx"
 #else
-	seq_printf(st->seq, "0x%08lx-0x%08lx ", st->start_address, addr - 1);
-	seq_printf(st->seq, "0x%08lx ", st->start_pa);
+#define REG		"0x%08lx"
 #endif
 
-	delta = (addr - st->start_address) >> 10;
+	seq_printf(st->seq, REG "-" REG " ", st->start_address, addr - 1);
+	if (st->start_pa == st->last_pa && st->start_address + PAGE_SIZE != addr) {
+		seq_printf(st->seq, "[" REG "]", st->start_pa);
+		delta = PAGE_SIZE >> 10;
+	} else {
+		seq_printf(st->seq, " " REG " ", st->start_pa);
+		delta = (addr - st->start_address) >> 10;
+	}
 	/* Work out what appropriate unit to use */
 	while (!(delta & 1023) && unit[1]) {
 		delta >>= 10;
@@ -184,7 +189,8 @@ static void note_page(struct pg_state *st, unsigned long addr,
 	 */
 	} else if (flag != st->current_flags || level != st->level ||
 		   addr >= st->marker[1].start_address ||
-		   pa != st->last_pa + PAGE_SIZE) {
+		   (pa != st->last_pa + PAGE_SIZE &&
+		    (pa != st->start_pa || st->start_pa != st->last_pa))) {
 
 		/* Check the PTE flags */
 		if (st->current_flags) {
-- 
2.13.3


Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90434C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 06:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C1D2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 06:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C1D2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbeJOOVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 10:21:38 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:13979 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbeJOOVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 10:21:38 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42YTJY4ZV5z9ttC9;
        Mon, 15 Oct 2018 08:37:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id AXz23BRcNS-Q; Mon, 15 Oct 2018 08:37:33 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42YTJY3yYyz9ttC7;
        Mon, 15 Oct 2018 08:37:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4776B8B77E;
        Mon, 15 Oct 2018 08:37:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id VRJ-Ia9zE_a2; Mon, 15 Oct 2018 08:37:42 +0200 (CEST)
Received: from pc13168vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1FB0B8B74B;
        Mon, 15 Oct 2018 08:37:42 +0200 (CEST)
Received: by pc13168vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id DE6C16F469; Mon, 15 Oct 2018 06:37:41 +0000 (UTC)
Message-Id: <23d27ae15a7b0389fc26f2265f969c6c69f44009.1539433567.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/book3s64: fix dump_linuxpagetables "present" flag
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 15 Oct 2018 06:37:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit bd0dbb73e013 ("powerpc/mm/books3s: Add new pte bit to
mark pte temporarily invalid."), _PAGE_PRESENT doesn't mean exactly
that a page is present. A page is also considered preset when
_PAGE_INVALID is set.

This patch changes the meaning of "present" and adds a status "valid"
associated to the _PAGE_PRESENT flag.

Fixes: bd0dbb73e013 ("powerpc/mm/books3s: Add new pte bit to mark pte temporarily invalid.")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/dump_linuxpagetables-book3s64.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/dump_linuxpagetables-book3s64.c b/arch/powerpc/mm/dump_linuxpagetables-book3s64.c
index a637e612b205..ed6fcf78256e 100644
--- a/arch/powerpc/mm/dump_linuxpagetables-book3s64.c
+++ b/arch/powerpc/mm/dump_linuxpagetables-book3s64.c
@@ -38,8 +38,13 @@ static const struct flag_info flag_array[] = {
 	}, {
 		.mask	= _PAGE_PRESENT,
 		.val	= _PAGE_PRESENT,
-		.set	= "present",
-		.clear	= "       ",
+		.set	= "valid",
+		.clear	= "     ",
+	}, {
+		.mask	= _PAGE_PRESENT | _PAGE_INVALID,
+		.val	= 0,
+		.set	= "       ",
+		.clear	= "present",
 	}, {
 		.mask	= H_PAGE_HASHPTE,
 		.val	= H_PAGE_HASHPTE,
-- 
2.13.3


Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FB2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73A920657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="unknown key hash" (0-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="sgL9q/z4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfAQK77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:59:59 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:1049 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728424AbfAQK76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:59:58 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43gLgs5DSBz9v2C1;
        Thu, 17 Jan 2019 11:59:53 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=sgL9q/z4; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id dY3GDlVabaBu; Thu, 17 Jan 2019 11:59:53 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43gLgs41Psz9v2By;
        Thu, 17 Jan 2019 11:59:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1547722793; bh=bCzDoKXfQUOk8+dp/9F7V6/4S9bkDV/4QQa9kOcF0rw=;
        h=From:Subject:To:Cc:Date:From;
        b=sgL9q/z46bGcBiyFkBtl28Nz8YopNnn0jVHHpOnGTKRUeh4VUquSaNDw/qxUzN+iG
         3iPhL1pCbRcr/dX5eRF1OK7nxq5CkoBpTanQ5uFJlzDAmLEYOpvDqHDzpfifFIGPvy
         WK4u/BOY4jtnyQNCigB3FnecHhkSBg4W6paGtMvg=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B03DA8B858;
        Thu, 17 Jan 2019 11:59:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ZYyDY2pIAeGp; Thu, 17 Jan 2019 11:59:54 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 868008B75B;
        Thu, 17 Jan 2019 11:59:54 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 302B971884; Thu, 17 Jan 2019 10:59:54 +0000 (UTC)
Message-Id: <029eb2f45a8b964ce82118044912a39679fac592.1547680951.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc/wii: properly disable use of BATs when requested.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 17 Jan 2019 10:59:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'nobats' kernel parameter or some options like CONFIG_DEBUG_PAGEALLOC
deny the use of BATS for mapping memory.

This patch makes sure that the specific wii RAM mapping function
takes it into account as well.

Fixes: de32400dd26e ("wii: use both mem1 and mem2 as ram")
Cc: stable@vger.kernel.org
Reviewed-by: Jonathan Neuschafer <j.neuschaefer@gmx.net>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/platforms/embedded6xx/wii.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
index ecf703ee3a76..ac4ee88efc80 100644
--- a/arch/powerpc/platforms/embedded6xx/wii.c
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -83,6 +83,10 @@ unsigned long __init wii_mmu_mapin_mem2(unsigned long top)
 	/* MEM2 64MB@0x10000000 */
 	delta = wii_hole_start + wii_hole_size;
 	size = top - delta;
+
+	if (__map_without_bats)
+		return delta;
+
 	for (bl = 128<<10; bl < max_size; bl <<= 1) {
 		if (bl * 2 > size)
 			break;
-- 
2.13.3


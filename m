Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9B7C10F07
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2427F20859
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Fdov9p9u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfBTRaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 12:30:14 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:45723 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbfBTR3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 12:29:14 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 444PjL451xz9v0g8;
        Wed, 20 Feb 2019 18:29:10 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Fdov9p9u; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id tsjR6lXNW2L5; Wed, 20 Feb 2019 18:29:10 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 444PjL2x1Fz9v0g0;
        Wed, 20 Feb 2019 18:29:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1550683750; bh=iljY86BFuTKNcJ3pkIrKPFpSMlm1mETpFf/uS5+PD+w=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=Fdov9p9u8el3LkPNtVwvEong3Fab7QADNAEFRlJVS6LZhs14Tu0jYLVjZdwXuTEQk
         M5YRy0PDg7DoPhyjx/aiR+lHa3Ieog0ajtY8JdPyiBIj3W4NLhpkrKvdbGDDa8v+15
         mEHlHlNb7XhmMceppxTeZx9K4zyiiJSrZ36LELG4=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 131B28B84F;
        Wed, 20 Feb 2019 18:29:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id t467b22GxxRb; Wed, 20 Feb 2019 18:29:12 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EE4B18B84A;
        Wed, 20 Feb 2019 18:29:11 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id EA1656E85E; Wed, 20 Feb 2019 17:29:11 +0000 (UTC)
Message-Id: <6ad76b17b3ab5e33162bfbdae35bcd30901910f7.1550648295.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1550648295.git.christophe.leroy@c-s.fr>
References: <cover.1550648295.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 05/16] powerpc/32: always populate page tables for Abatron
 BDI.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, j.neuschaefer@gmx.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 20 Feb 2019 17:29:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_BDI_SWITCH is set, the page tables have to be populated
allthough large TLBs are used, because the BDI switch knows nothing
about those large TLBs which are handled directly in TLB miss logic.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/pgtable_32.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index fd665c32a1f7..94bd7d013557 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -261,7 +261,10 @@ void __init mapin_ram(void)
 		unsigned long top = base + reg->size;
 
 		base = mmu_mapin_ram(base, top);
-		__mapin_ram_chunk(base, top);
+		if (IS_ENABLED(CONFIG_BDI_SWITCH))
+			__mapin_ram_chunk(reg->base, top);
+		else
+			__mapin_ram_chunk(base, top);
 	}
 }
 
-- 
2.13.3


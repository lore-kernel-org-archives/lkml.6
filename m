Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6277FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344412081B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="BRGMRMi6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfBUTKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 14:10:00 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:25284 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbfBUTIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 14:08:43 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4453sj6JRlz9v6l3;
        Thu, 21 Feb 2019 20:08:41 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=BRGMRMi6; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id I9qrvplztOEf; Thu, 21 Feb 2019 20:08:41 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4453sj58Mfz9v6jt;
        Thu, 21 Feb 2019 20:08:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1550776121; bh=qk6ZCRpgX5r06gob5K89honwW6UBGj0f+E18dNkH6ok=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=BRGMRMi6YFMegVPcOqphbBJdilQR/TJ5/mvm3s0Hg4UPtmJf1GQh6a3ZCx4rTfqPN
         RtvOZYTpIYRo+Xb6veRCEM1WNL0s+ZTYADmqG0lLESum9nhTbKGE+eRXnCYffa2lKA
         NUKaHYVenhvsz8W1dexsy50Uqm7aQVW1YRecKbRA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B525F8B86A;
        Thu, 21 Feb 2019 20:08:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id MS0uiyf5W3s9; Thu, 21 Feb 2019 20:08:41 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8C7228B852;
        Thu, 21 Feb 2019 20:08:41 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 6ABD46EF61; Thu, 21 Feb 2019 19:08:41 +0000 (UTC)
Message-Id: <8187e3e7b08436528d850176deb611609fcae57d.1550775950.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1550775950.git.christophe.leroy@c-s.fr>
References: <cover.1550775950.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 05/16] powerpc/32: always populate page tables for Abatron
 BDI.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, j.neuschaefer@gmx.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 21 Feb 2019 19:08:41 +0000 (UTC)
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
index c4b0eb51f6d8..a000768a5cc9 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -263,7 +263,10 @@ void __init mapin_ram(void)
 		if (base >= top)
 			continue;
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


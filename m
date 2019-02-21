Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA134C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74AE2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="XQW+54wH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfBUTIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 14:08:49 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:10798 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbfBUTIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 14:08:46 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4453sn0Jmwz9v6l6;
        Thu, 21 Feb 2019 20:08:45 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=XQW+54wH; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id iX7qrrwEcELT; Thu, 21 Feb 2019 20:08:44 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4453sm6DlYz9v6l5;
        Thu, 21 Feb 2019 20:08:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1550776124; bh=ccf0q8MxveX5A/kD+EyhGHMgyOOsoAgRMM6RQCBw488=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=XQW+54wHmUiaRFKUF+D/fBbwmgxHedz3leUsTByMVqFevpJtMirejjPNwQaUv4KA8
         +uEMhDPz85UgoLjBb8QkAvn4vD1HYVoKMeg0OU04/CWd+ALYzBJtVkoTXWNrXIbm8v
         2B6cXPGoCwZjzM2yfmfoguApjS2UbJqqO0H5QWc4=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D88078B852;
        Thu, 21 Feb 2019 20:08:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0AQ4MwL2JTi8; Thu, 21 Feb 2019 20:08:44 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AFF668B86B;
        Thu, 21 Feb 2019 20:08:44 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 88A5D6EF61; Thu, 21 Feb 2019 19:08:44 +0000 (UTC)
Message-Id: <ea9f411218ba70b2a6b34b335ac6aee6c610d8b8.1550775950.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1550775950.git.christophe.leroy@c-s.fr>
References: <cover.1550775950.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 08/16] powerpc/32: add helper to write into segment
 registers
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, j.neuschaefer@gmx.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 21 Feb 2019 19:08:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add an helper which wraps 'mtsrin' instruction
to write into segment registers.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/reg.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 1c98ef1f2d5b..a70cbaf5c26f 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1425,6 +1425,11 @@ static inline void msr_check_and_clear(unsigned long bits)
 #define mfsrin(v)	({unsigned int rval; \
 			asm volatile("mfsrin %0,%1" : "=r" (rval) : "r" (v)); \
 					rval;})
+
+static inline void mtsrin(u32 val, u32 idx)
+{
+	asm volatile("mtsrin %0, %1" : : "r" (val), "r" (idx));
+}
 #endif
 
 #define proc_trap()	asm volatile("trap")
-- 
2.13.3


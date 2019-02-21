Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9326DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627522086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="kVjmQJD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfBUIFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 03:05:08 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:18195 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727457AbfBUIFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 03:05:05 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 444n7y4DFxz9vJgK;
        Thu, 21 Feb 2019 09:05:02 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=kVjmQJD3; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id hm0oPd382hcC; Thu, 21 Feb 2019 09:05:02 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 444n7y38SMz9vJg1;
        Thu, 21 Feb 2019 09:05:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1550736302; bh=0UTyl0SLhivPdqU7U6NSaq2bROyqBzPjvYQ+WcMIB0I=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=kVjmQJD30eoZw+k9U/6tGCIIwmAqWfVzIiKYR1170Dkpeh4dfwc1Qd5zdstxh9Tjb
         FhT5JVweXZ/ajTxpcey7tTtyqQs0hVOQsMDuqnixIMeJCBNWSmfA+rj+uM09R8tSu1
         0PgShOl1TxflWTNLqD9tGJjdSmCLqkm0fGUaV58A=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5CD2D8B78F;
        Thu, 21 Feb 2019 09:05:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id w0_BgYKExB-q; Thu, 21 Feb 2019 09:05:03 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1BF108B75B;
        Thu, 21 Feb 2019 09:05:03 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id DA8206E866; Thu, 21 Feb 2019 08:05:02 +0000 (UTC)
Message-Id: <7ed390a0c72d9bba6a1ea5bdda92dde287b18fa0.1550692943.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1550692943.git.christophe.leroy@c-s.fr>
References: <cover.1550692943.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 14/16] powerpc/kconfig: make _etext and data areas
 alignment configurable on Book3s 32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, j.neuschaefer@gmx.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 21 Feb 2019 08:05:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on the number of available BATs for mapping the different
kernel areas, it might be needed to increase the alignment of _etext
and/or of data areas.

This patchs allows the user to do it via Kconfig.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 26ddea487d72..127259179b4d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -728,16 +728,44 @@ config THREAD_SHIFT
 	  Used to define the stack size. The default is almost always what you
 	  want. Only change this if you know what you are doing.
 
+config ETEXT_SHIFT_BOOL
+	bool "Set custom etext alignment" if STRICT_KERNEL_RWX && PPC_BOOK3S_32
+	depends on ADVANCED_OPTIONS
+	help
+	  This option allows you to set the kernel end of text alignment. When
+	  RAM is mapped by blocks, the alignment needs to fit the size and
+	  number of possible blocks. The default should be OK for most configs.
+
+	  Say N here unless you know what you are doing.
+
 config ETEXT_SHIFT
-	int
+	int "_etext shift" if ETEXT_SHIFT_BOOL
+	range 17 28 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
 	default 17 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
 	default PPC_PAGE_SHIFT
+	help
+	  On Book3S 32 (603+), IBATs are used to map kernel text.
+	  Smaller is the alignment, greater is the number of necessary IBATs.
+
+config DATA_SHIFT_BOOL
+	bool "Set custom data alignment" if STRICT_KERNEL_RWX && PPC_BOOK3S_32
+	depends on ADVANCED_OPTIONS
+	help
+	  This option allows you to set the kernel data alignment. When
+	  RAM is mapped by blocks, the alignment needs to fit the size and
+	  number of possible blocks. The default should be OK for most configs.
+
+	  Say N here unless you know what you are doing.
 
 config DATA_SHIFT
-	int
+	int "Data shift" if DATA_SHIFT_BOOL
 	default 24 if STRICT_KERNEL_RWX && PPC64
+	range 17 28 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
 	default 22 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
 	default PPC_PAGE_SHIFT
+	help
+	  On Book3S 32 (603+), DBATs are used to map kernel text and rodata RO.
+	  Smaller is the alignment, greater is the number of necessary DBATs.
 
 config FORCE_MAX_ZONEORDER
 	int "Maximum zone order"
-- 
2.13.3


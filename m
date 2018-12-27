Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48369C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 16:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174B520882
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 16:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eS3tyIIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbeL0Qqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 11:46:43 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45767 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbeL0Qqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 11:46:42 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so8975993pgc.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 08:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=GUXPQyjoj0cfygc0MJ63sgmqBS3VZEPyrVrHL2EIUT8=;
        b=eS3tyIIahWeBt5EmxwZwV08uyvjeimT4M3vtiKqZu1IX05aPVJ7DnFLBM2E3TTQM7J
         T4LhXjassT+suonUlIPCL10BD1KcfssPvhfqNlmnt3B/aCTRacKN/ElQip1Taf7IoxCV
         /dHzwog04dnWFj65oJI8KM8B2qH2fk9TdiBQ36ztPL3BCURWzZ/kV5sTWatlp+xtHnYM
         EjzLFtj1/jv8C12CPceDjv8ZfZBVGPdmMpUeBOxm2JiBZMXH8G3kGTKqWqLPJUrkgOdF
         KCDEMYmfpEzDmF4lH3i1JuRlTMx93qZvcjYH0WnL84GCPCwAGmuSdrJsVxd/xrwSJkK0
         4zAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=GUXPQyjoj0cfygc0MJ63sgmqBS3VZEPyrVrHL2EIUT8=;
        b=gPaX+A6i6Yuy6JMKgfpg4kOze2F31sX938cNndq5qNvLNPlkWLoTeA0azd1ar5Ax3v
         2gEjD2kQ9a/5/tulJlIV8o34P5i5fzmxseqj7pDZukMfoxzgJTwZ7jkzqJg9vIPvQVhg
         CCHGPtR+04N2DFZlYOl6e1E1dPtMh5L881J6xtweQ5p1ReyfLMYQI/jVxnwDDyVbdhPy
         zQGfNDWycZ0YzwwYJLfjmoxFUaVU7Kn2QuSjADCuMK57cJ0K9p+dKBSeQj/6NY78aBjj
         cbXmK0e+TElQcK5bBwes2ivwWDVskFDdn6PlrgGLSgnwuR5P8oBg91zLAV7YwQEInWFz
         S1SQ==
X-Gm-Message-State: AA+aEWYij9W2VRuzSVvuRMCcqxCliflmkns6BFBdpMZcYwZI25tiFLII
        75iRw4O42m6EIobo08PQ4cE=
X-Google-Smtp-Source: ALg8bN4013lpDNMjwX84jAZSBaxHliKia8K76G1J2apt5QBL/D/8yE0n+Ad2SgsWNFvvIfMLEXnGVg==
X-Received: by 2002:a62:ca05:: with SMTP id n5mr24844072pfg.154.1545929201712;
        Thu, 27 Dec 2018 08:46:41 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g11sm54811025pfo.139.2018.12.27.08.46.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 08:46:40 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     uclinux-h8-devel@lists.sourceforge.jp,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Sinan Kaya <okaya@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] h8300: pci: Remove local declaration of pcibios_penalize_isa_irq
Date:   Thu, 27 Dec 2018 08:46:38 -0800
Message-Id: <1545929198-15733-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

h8300 builds fail with:

In file included from drivers/of/address.c:11:
include/linux/pci.h:1966:20: error: redefinition of 'pcibios_penalize_isa_irq'

This is because CONFIG_PCI is not enabled, and pcibios_penalize_isa_irq()
is now declared as inline static function in generic code if this is the
case. Since h8300 does not support PCI to start with, fix the problem by
removing the architecture specific pci.h.

Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
Cc: Sinan Kaya <okaya@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/h8300/include/asm/Kbuild |  1 +
 arch/h8300/include/asm/pci.h  | 18 ------------------
 2 files changed, 1 insertion(+), 18 deletions(-)
 delete mode 100644 arch/h8300/include/asm/pci.h

diff --git a/arch/h8300/include/asm/Kbuild b/arch/h8300/include/asm/Kbuild
index a5d0b2991f47..cd400d353d18 100644
--- a/arch/h8300/include/asm/Kbuild
+++ b/arch/h8300/include/asm/Kbuild
@@ -33,6 +33,7 @@ generic-y += mmu.h
 generic-y += mmu_context.h
 generic-y += module.h
 generic-y += parport.h
+generic-y += pci.h
 generic-y += percpu.h
 generic-y += pgalloc.h
 generic-y += preempt.h
diff --git a/arch/h8300/include/asm/pci.h b/arch/h8300/include/asm/pci.h
deleted file mode 100644
index d4d345a52092..000000000000
--- a/arch/h8300/include/asm/pci.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_H8300_PCI_H
-#define _ASM_H8300_PCI_H
-
-/*
- * asm-h8300/pci.h - H8/300 specific PCI declarations.
- *
- * Yoshinori Sato <ysato@users.sourceforge.jp>
- */
-
-#define pcibios_assign_all_busses()	0
-
-static inline void pcibios_penalize_isa_irq(int irq, int active)
-{
-	/* We don't do dynamic PCI IRQ allocation */
-}
-
-#endif /* _ASM_H8300_PCI_H */
-- 
2.7.4


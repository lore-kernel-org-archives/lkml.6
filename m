Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024B5C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0282083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hj1YTnmP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC0282083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030443AbeFST1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:27:49 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38735 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967219AbeFST1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:27:47 -0400
Received: by mail-wr0-f196.google.com with SMTP id e18-v6so798106wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 12:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DW28HMLEUGoRqgLlA7upbDDKO5Z+/RlxqvmR8s+h2lw=;
        b=hj1YTnmPbXxhKwvZEAVYKAjMPvGhzmGIgOZPls9AssyYVdfnulHJUr1bdvCOeNVBOF
         VLQRfv2CfWaZDO6wolpcmcWLW69oOD69fccM2NZ0maQgaUAvVYEYx+knBdKq6C+O7v4N
         Fh3E7OXHIkK65PWzlDmcpb88sSwdw6+ttuDtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DW28HMLEUGoRqgLlA7upbDDKO5Z+/RlxqvmR8s+h2lw=;
        b=Ld3/qHFYF0TLleDpKLt0g1BXFlh99IUR/PUtCh6X9E5Q9VVk5BxcspxR1weXcm8/ez
         g+5bjrsaQTFDGm/cx6G4UEyfwn28NYJr97UTp+jeJyEmdJSjFHeqRduTdBG75bpWSlTR
         xIOINXQW/L2W5Ext8It30lR3fshOBZC9OeU8Ro7kcYKbR32/JXQL71491i/KPc58h58B
         Bb69fFd/+v8FcNt+Ncrw4tozMQ3JH5GKsDBHIJkliT1BLrGPB5nkoXB3cB8TaYO+9Cgt
         luLWVuD+yOfL4iYQHWxUU0Q86TZyzdpsxDaRRoA8rAMAhtsbm3pj/P04t5A7EGs8uWK5
         KLug==
X-Gm-Message-State: APt69E0iznjjHBiQQdJnyTG5cQvKfKmpoDipMjKrObnJoIw8RrsKpRbM
        BZrwTaUL0eDGAgNm2yV6haJrJw==
X-Google-Smtp-Source: ADUXVKJwf3eTpJ9Lawx/SKxU/m8QWpVYkUL8zCbDIA9zliiYrUeOFbBHqVCPqiTYMqm6QpUEwDbrMw==
X-Received: by 2002:adf:9187:: with SMTP id 7-v6mr16335104wri.69.1529436466172;
        Tue, 19 Jun 2018 12:27:46 -0700 (PDT)
Received: from dogfood.home ([2a01:cb1d:112:6f00:a06d:5653:4fd5:13a])
        by smtp.gmail.com with ESMTPSA id c53-v6sm982601wrg.12.2018.06.19.12.27.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 12:27:45 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux@armlinux.org.uk, linux@roeck-us.net, mark.rutland@arm.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 1/2] ARM: avoid badr macro for switching to Thumb-2 mode
Date:   Tue, 19 Jun 2018 21:26:32 +0200
Message-Id: <20180619192633.21846-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619192633.21846-1-ard.biesheuvel@linaro.org>
References: <20180619192633.21846-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switching to Thumb-2 mode can be done using a single 'sub' instruction
so use that instead of the badr macro in various places in the code.
This allows us to reimplement the macro in a way that does not allow
it to be used in ARM code sequences when building a Thumb2 kernel.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/common/mcpm_head.S  |  5 ++---
 arch/arm/kernel/head-nommu.S |  7 +++----
 arch/arm/kernel/head.S       | 15 +++++++--------
 arch/arm/kernel/sleep.S      |  7 +++----
 4 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/arch/arm/common/mcpm_head.S b/arch/arm/common/mcpm_head.S
index 08b3bb9bc6a2..4c72314e87a3 100644
--- a/arch/arm/common/mcpm_head.S
+++ b/arch/arm/common/mcpm_head.S
@@ -49,10 +49,9 @@
 ENTRY(mcpm_entry_point)
 
  ARM_BE8(setend        be)
- THUMB(	badr	r12, 1f		)
- THUMB(	bx	r12		)
+ THUMB(	sub	pc, pc, #3	)
  THUMB(	.thumb			)
-1:
+
 	mrc	p15, 0, r0, c0, c0, 5		@ MPIDR
 	ubfx	r9, r0, #0, #8			@ r9 = cpu
 	ubfx	r10, r0, #8, #8			@ r10 = cluster
diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index dae8fa2f72c5..406dab0b773c 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -47,10 +47,9 @@ ENTRY(stext)
 	.arm
 ENTRY(stext)
 
- THUMB(	badr	r9, 1f		)	@ Kernel is always entered in ARM.
- THUMB(	bx	r9		)	@ If this is a Thumb-2 kernel,
- THUMB(	.thumb			)	@ switch to Thumb now.
- THUMB(1:			)
+ THUMB(	sub	pc, pc, #3	)	@ Kernel is always entered in ARM.
+ THUMB(	.thumb			)	@ If this is a Thumb-2 kernel,
+					@ switch to Thumb now.
 #endif
 
 	setmode	PSR_F_BIT | PSR_I_BIT | SVC_MODE, r9 @ ensure svc mode
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 4b815821ec02..1e44ee9b2074 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -80,10 +80,9 @@
 ENTRY(stext)
  ARM_BE8(setend	be )			@ ensure we are in BE8 mode
 
- THUMB(	badr	r9, 1f		)	@ Kernel is always entered in ARM.
- THUMB(	bx	r9		)	@ If this is a Thumb-2 kernel,
- THUMB(	.thumb			)	@ switch to Thumb now.
- THUMB(1:			)
+ THUMB(	sub	pc, pc, #3	)	@ Kernel is always entered in ARM.
+ THUMB(	.thumb			)	@ If this is a Thumb-2 kernel,
+					@ switch to Thumb now.
 
 #ifdef CONFIG_ARM_VIRT_EXT
 	bl	__hyp_stub_install
@@ -363,10 +362,10 @@ __turn_mmu_on_loc:
 	.text
 	.arm
 ENTRY(secondary_startup_arm)
- THUMB(	badr	r9, 1f		)	@ Kernel is entered in ARM.
- THUMB(	bx	r9		)	@ If this is a Thumb-2 kernel,
- THUMB(	.thumb			)	@ switch to Thumb now.
- THUMB(1:			)
+ THUMB(	sub	pc, pc, #3	)	@ Kernel is entered in ARM.
+ THUMB(	.thumb			)	@ If this is a Thumb-2 kernel,
+					@ switch to Thumb now.
+
 ENTRY(secondary_startup)
 	/*
 	 * Common entry point for secondary CPUs.
diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index a8257fc9cf2a..76b3d7c1c8d0 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -123,10 +123,9 @@ ENDPROC(cpu_resume_after_mmu)
 #ifdef CONFIG_MMU
 	.arm
 ENTRY(cpu_resume_arm)
- THUMB(	badr	r9, 1f		)	@ Kernel is entered in ARM.
- THUMB(	bx	r9		)	@ If this is a Thumb-2 kernel,
- THUMB(	.thumb			)	@ switch to Thumb now.
- THUMB(1:			)
+ THUMB(	sub	pc, pc, #3	)	@ Kernel is entered in ARM.
+ THUMB(	.thumb			)	@ If this is a Thumb-2 kernel,
+					@ switch to Thumb now.
 #endif
 
 ENTRY(cpu_resume)
-- 
2.17.1


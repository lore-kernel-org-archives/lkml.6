Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A960C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 00:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1621240BE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 00:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1621240BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753934AbeGFAuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 20:50:32 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:41348 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753661AbeGFAtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 20:49:53 -0400
Received: by mail-qt0-f194.google.com with SMTP id y20-v6so8710580qto.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 17:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=67hlObYZQvpyPrZPGFFFmsXvb23O2m/LLRXIOlSOTJM=;
        b=Wr7neszQUrvdPPIJmUHzzlM8Ycs3jBHHyAW/q62Y22CVLbbpZuJcoR4wKuRgmlm+Ch
         PvOHwYs4c3jkhTDx8rb9zZHqGN03r2mduM8YJwn9uRtzfAfD41aka0sg18wRrjsuW2m9
         AV1HnHC8ypD7Uw8Ga5ZUCWvq5g6TjOBR1k/M10Sx1hP1DCVd6l78IrCrUuRexrbWTnRs
         y/MDE1s8pHH2mbKp9OZY69gXS8bQsXaT/ZXWNPT967FALdMAJezcEPl2qocoEDDaooFF
         3Ja/9i694VL5omTCbGiSCLR5tx6efa5uVIUge2M7379YcMUtvF3gDvBKGqWOoDzutoxU
         2eOA==
X-Gm-Message-State: APt69E1xS8m3BVcDWytJtnux89TPYji2PraOPV1RtRTupYLMzZjS5/uM
        u48v+4I7bPRG2+83tm4+CWFR3w==
X-Google-Smtp-Source: AAOMgpcDXPWsVG/BRvKvP0SpuDTAEA0xzeu22Bn+U90IrrehylHhNmdMOa7spPnsVyw7LNI5+ZBI2g==
X-Received: by 2002:a0c:9351:: with SMTP id e17-v6mr6973648qve.4.1530838193023;
        Thu, 05 Jul 2018 17:49:53 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::f0c1])
        by smtp.gmail.com with ESMTPSA id q67-v6sm4675205qkb.16.2018.07.05.17.49.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 17:49:50 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>, mjw@fedoraproject.org,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Nick Clifton <nickc@redhat.com>,
        Cary Coutant <ccoutant@gmail.com>,
        linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCHv6 2/4] x86: Add build salt to the vDSO
Date:   Thu,  5 Jul 2018 17:49:38 -0700
Message-Id: <20180706004940.32587-3-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180706004940.32587-1-labbott@redhat.com>
References: <20180706004940.32587-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The vDSO needs to have a unique build id in a similar manner
to the kernel and modules. Use the build salt macro.

Acked-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v6: Ack from Andy
---
 arch/x86/entry/vdso/vdso-note.S   | 3 +++
 arch/x86/entry/vdso/vdso32/note.S | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/entry/vdso/vdso-note.S b/arch/x86/entry/vdso/vdso-note.S
index 79a071e4357e..79423170118f 100644
--- a/arch/x86/entry/vdso/vdso-note.S
+++ b/arch/x86/entry/vdso/vdso-note.S
@@ -3,6 +3,7 @@
  * Here we can supply some information useful to userland.
  */
 
+#include <linux/build-salt.h>
 #include <linux/uts.h>
 #include <linux/version.h>
 #include <linux/elfnote.h>
@@ -10,3 +11,5 @@
 ELFNOTE_START(Linux, 0, "a")
 	.long LINUX_VERSION_CODE
 ELFNOTE_END
+
+BUILD_SALT
diff --git a/arch/x86/entry/vdso/vdso32/note.S b/arch/x86/entry/vdso/vdso32/note.S
index 9fd51f206314..e78047d119f6 100644
--- a/arch/x86/entry/vdso/vdso32/note.S
+++ b/arch/x86/entry/vdso/vdso32/note.S
@@ -4,6 +4,7 @@
  * Here we can supply some information useful to userland.
  */
 
+#include <linux/build-salt.h>
 #include <linux/version.h>
 #include <linux/elfnote.h>
 
@@ -14,6 +15,8 @@ ELFNOTE_START(Linux, 0, "a")
 	.long LINUX_VERSION_CODE
 ELFNOTE_END
 
+BUILD_SALT
+
 #ifdef CONFIG_XEN
 /*
  * Add a special note telling glibc's dynamic linker a fake hardware
-- 
2.17.1


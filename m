Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C358CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89958206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrpsJOLZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89958206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388954AbeKVFqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:46:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:42248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730565AbeKVFqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:46:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0342E214D9;
        Wed, 21 Nov 2018 19:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827479;
        bh=LbTbpD/BuAdDdYjouaE5FY136OFEO1GAK1V+73PR+IY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hrpsJOLZlNa3g+8fwRx173wnEl1GlizHAX7NtkIdotkA0t22F03GH8Qx41nRTFrwM
         8pJn4m4s8WMbaZduJ45nhLNp4PTU5fYnv9SjU2g7B5r5US0OZU7/ClUPqLhyPhWSDI
         GA5cbeUbVdcZsP1olk4B5o1wpLgdiSk4SqPe/vnY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 4.9 30/59] efi/libstub: Preserve .debug sections after absolute relocation check
Date:   Wed, 21 Nov 2018 20:06:45 +0100
Message-Id: <20181121183509.434200105@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183508.262873520@linuxfoundation.org>
References: <20181121183508.262873520@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

commit 696204faa6e8a318320ebb49d9fa69bc8275644d upstream.

The build commands for the ARM and arm64 EFI stubs strip the .debug
sections and other sections that may legally contain absolute relocations,
in order to inspect the remaining sections for the presence of such
relocations.

This leaves us without debugging symbols in the stub for no good reason,
considering that these sections are omitted from the kernel binary anyway,
and that these relocations are thus only consumed by users of the ELF
binary, such as debuggers.

So move to 'strip' for performing the relocation check, and if it succeeds,
invoke objcopy as before, but leaving the .debug sections in place. Note
that these sections may refer to ksymtab/kcrctab contents, so leave those
in place as well.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/1485868902-20401-11-git-send-email-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/efi/libstub/Makefile |   24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -11,7 +11,7 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__K
 				   -mno-mmx -mno-sse
 
 cflags-$(CONFIG_ARM64)		:= $(subst -pg,,$(KBUILD_CFLAGS))
-cflags-$(CONFIG_ARM)		:= $(subst -pg,,$(KBUILD_CFLAGS)) -g0 \
+cflags-$(CONFIG_ARM)		:= $(subst -pg,,$(KBUILD_CFLAGS)) \
 				   -fno-builtin -fpic -mno-single-pic-base
 
 cflags-$(CONFIG_EFI_ARMSTUB)	+= -I$(srctree)/scripts/dtc/libfdt
@@ -60,7 +60,7 @@ CFLAGS_arm64-stub.o 		:= -DTEXT_OFFSET=$
 extra-$(CONFIG_EFI_ARMSTUB)	:= $(lib-y)
 lib-$(CONFIG_EFI_ARMSTUB)	:= $(patsubst %.o,%.stub.o,$(lib-y))
 
-STUBCOPY_FLAGS-y		:= -R .debug* -R *ksymtab* -R *kcrctab*
+STUBCOPY_RM-y			:= -R *ksymtab* -R *kcrctab*
 STUBCOPY_FLAGS-$(CONFIG_ARM64)	+= --prefix-alloc-sections=.init \
 				   --prefix-symbols=__efistub_
 STUBCOPY_RELOC-$(CONFIG_ARM64)	:= R_AARCH64_ABS
@@ -68,17 +68,25 @@ STUBCOPY_RELOC-$(CONFIG_ARM64)	:= R_AARC
 $(obj)/%.stub.o: $(obj)/%.o FORCE
 	$(call if_changed,stubcopy)
 
+#
+# Strip debug sections and some other sections that may legally contain
+# absolute relocations, so that we can inspect the remaining sections for
+# such relocations. If none are found, regenerate the output object, but
+# this time, use objcopy and leave all sections in place.
+#
 quiet_cmd_stubcopy = STUBCPY $@
-      cmd_stubcopy = if $(OBJCOPY) $(STUBCOPY_FLAGS-y) $< $@; then	\
-		     $(OBJDUMP) -r $@ | grep $(STUBCOPY_RELOC-y)	\
-		     && (echo >&2 "$@: absolute symbol references not allowed in the EFI stub"; \
-			 rm -f $@; /bin/false); else /bin/false; fi
+      cmd_stubcopy = if $(STRIP) --strip-debug $(STUBCOPY_RM-y) -o $@ $<; \
+		     then if $(OBJDUMP) -r $@ | grep $(STUBCOPY_RELOC-y); \
+		     then (echo >&2 "$@: absolute symbol references not allowed in the EFI stub"; \
+			   rm -f $@; /bin/false); 			  \
+		     else $(OBJCOPY) $(STUBCOPY_FLAGS-y) $< $@; fi	  \
+		     else /bin/false; fi
 
 #
 # ARM discards the .data section because it disallows r/w data in the
 # decompressor. So move our .data to .data.efistub, which is preserved
 # explicitly by the decompressor linker script.
 #
-STUBCOPY_FLAGS-$(CONFIG_ARM)	+= --rename-section .data=.data.efistub \
-				   -R ___ksymtab+sort -R ___kcrctab+sort
+STUBCOPY_FLAGS-$(CONFIG_ARM)	+= --rename-section .data=.data.efistub
+STUBCOPY_RM-$(CONFIG_ARM)	+= -R ___ksymtab+sort -R ___kcrctab+sort
 STUBCOPY_RELOC-$(CONFIG_ARM)	:= R_ARM_ABS



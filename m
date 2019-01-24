Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1655C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9111B20663
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359357;
	bh=2ZsPHUaXym3MPjXKtlaQnhUw8BdmQ76Kiis1P+OCEnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0VDlOJ2LpkWLoGSDMN7Jt8N4t/MZ48gPgfC0gmlU0E/Tpq+2GdCN1P5a0eNb7pg2R
	 fJq5qZkWHsvujQEM+sHuHgWPZA8SXp5h9KFYScOlQnSuVhfoT9NylZ8cu6ECfNuWED
	 TFVNUutipJ9CA3T5NDs7eOU7Xgz332bpfzyWDkH0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732554AbfAXTtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:49:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:41598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732866AbfAXTlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:41:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EE8120663;
        Thu, 24 Jan 2019 19:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358877;
        bh=2ZsPHUaXym3MPjXKtlaQnhUw8BdmQ76Kiis1P+OCEnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2SyJgUDcwhgBQkTE+5YvbUzdGgci6/v226v+hBz98OMmZ2kWNEZCjWeHAZ8iSoStH
         2W1kazzkC/cADVX2WyuSGaR2CNt4+kEk5QZigpyv7NyT5IyYqu42xsOvIyTczy0MR4
         ifXA9yaY96uQUCMRnPck7kqmWCEMBdPJcHvw+bO8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Peter Smith <peter.smith@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 058/127] arm64: relocatable: fix inconsistencies in linker script and options
Date:   Thu, 24 Jan 2019 20:20:04 +0100
Message-Id: <20190124190214.648699474@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 3bbd3db86470c701091fb1d67f1fab6621debf50 ]

readelf complains about the section layout of vmlinux when building
with CONFIG_RELOCATABLE=y (for KASLR):

  readelf: Warning: [21]: Link field (0) should index a symtab section.
  readelf: Warning: [21]: Info field (0) should index a relocatable section.

Also, it seems that our use of '-pie -shared' is contradictory, and
thus ambiguous. In general, the way KASLR is wired up at the moment
is highly tailored to how ld.bfd happens to implement (and conflate)
PIE executables and shared libraries, so given the current effort to
support other toolchains, let's fix some of these issues as well.

- Drop the -pie linker argument and just leave -shared. In ld.bfd,
  the differences between them are unclear (except for the ELF type
  of the produced image [0]) but lld chokes on seeing both at the
  same time.

- Rename the .rela output section to .rela.dyn, as is customary for
  shared libraries and PIE executables, so that it is not misidentified
  by readelf as a static relocation section (producing the warnings
  above).

- Pass the -z notext and -z norelro options to explicitly instruct the
  linker to permit text relocations, and to omit the RELRO program
  header (which requires a certain section layout that we don't adhere
  to in the kernel). These are the defaults for current versions of
  ld.bfd.

- Discard .eh_frame and .gnu.hash sections to avoid them from being
  emitted between .head.text and .text, screwing up the section layout.

These changes only affect the ELF image, and produce the same binary
image.

[0] b9dce7f1ba01 ("arm64: kernel: force ET_DYN ELF type for ...")

Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Peter Smith <peter.smith@linaro.org>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/Makefile             | 2 +-
 arch/arm64/kernel/vmlinux.lds.S | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 6cb9fc7e9382..8978f60779c4 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -18,7 +18,7 @@ ifeq ($(CONFIG_RELOCATABLE), y)
 # Pass --no-apply-dynamic-relocs to restore pre-binutils-2.27 behaviour
 # for relative relocs, since this leads to better Image compression
 # with the relocation offsets always being zero.
-LDFLAGS_vmlinux		+= -pie -shared -Bsymbolic \
+LDFLAGS_vmlinux		+= -shared -Bsymbolic -z notext -z norelro \
 			$(call ld-option, --no-apply-dynamic-relocs)
 endif
 
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 03b00007553d..7fa008374907 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -99,7 +99,8 @@ SECTIONS
 		*(.discard)
 		*(.discard.*)
 		*(.interp .dynamic)
-		*(.dynsym .dynstr .hash)
+		*(.dynsym .dynstr .hash .gnu.hash)
+		*(.eh_frame)
 	}
 
 	. = KIMAGE_VADDR + TEXT_OFFSET;
@@ -192,12 +193,12 @@ SECTIONS
 
 	PERCPU_SECTION(L1_CACHE_BYTES)
 
-	.rela : ALIGN(8) {
+	.rela.dyn : ALIGN(8) {
 		*(.rela .rela*)
 	}
 
-	__rela_offset	= ABSOLUTE(ADDR(.rela) - KIMAGE_VADDR);
-	__rela_size	= SIZEOF(.rela);
+	__rela_offset	= ABSOLUTE(ADDR(.rela.dyn) - KIMAGE_VADDR);
+	__rela_size	= SIZEOF(.rela.dyn);
 
 	. = ALIGN(SEGMENT_ALIGN);
 	__initdata_end = .;
-- 
2.19.1




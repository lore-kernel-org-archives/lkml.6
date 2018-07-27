Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688D2C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26BF92064D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26BF92064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730971AbeG0Otj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 10:49:39 -0400
Received: from foss.arm.com ([217.140.101.70]:43622 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730088AbeG0Otj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 10:49:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7831F15AD;
        Fri, 27 Jul 2018 06:27:42 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 490DC3F2EA;
        Fri, 27 Jul 2018 06:27:42 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id CD9131AE5252; Fri, 27 Jul 2018 14:27:42 +0100 (BST)
Date:   Fri, 27 Jul 2018 14:27:42 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kees Cook <keescook@google.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Popov <alex.popov@linux.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Laura Abbott <labbott@redhat.com>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <20180727132742.GB28549@arm.com>
References: <20180727190207.7ce1c9b0@canb.auug.org.au>
 <20180727190647.3525f5f7@canb.auug.org.au>
 <20180727205511.7c0f2e62@canb.auug.org.au>
 <20180727125522.GA6173@arm.com>
 <20180727130106.GB6173@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727130106.GB6173@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 02:01:06PM +0100, Will Deacon wrote:
> On Fri, Jul 27, 2018 at 01:55:22PM +0100, Will Deacon wrote:
> > On Fri, Jul 27, 2018 at 08:55:11PM +1000, Stephen Rothwell wrote:
> > > On Fri, 27 Jul 2018 19:06:47 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > >
> > > > On Fri, 27 Jul 2018 19:02:07 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > > >
> > > > > After merging the kspp tree, today's linux-next build (x86_64
> > > > > allmodconfig) failed like this:
> > > > > 
> > > > > cc1: error: plugin stackleak_plugin should be specified before -fplugin-arg-stackleak_plugin-disable in the command line
> > > > > 
> > > > > Maybe caused by commit
> > > > > 
> > > > >   a8b9eaddb9c0 ("gcc-plugins: Add STACKLEAK plugin for tracking the kernel stack")
> > > > > 
> > > > > I have used the kspp tree from next-20180726 for today.  
> > > > 
> > > > Well, that obviously didn't work since the tree hasn't changed for a
> > > > few days.
> > > > 
> > > > I can't see what has interacted to make this happen, so I have dropped
> > > > the kspp tree for today.
> > > 
> > > Actually, it may have been caused by commit
> > > 
> > >   0b3e336601b8 ("arm64: Add support for STACKLEAK gcc plugin")
> > > 
> > > from the arm64 tree.
> > 
> > Thanks, Stephen. I managed to reproduce this by merging for-next/kspp from
> > Kees's tree and for-next/core from the arm64 tree. The failure happens when
> > building the EFI stub, so the commit you mention above is almost certainly
> > the culprit.
> > 
> > We build the stub with the following GCC invocation:
> > 
> >  gcc -Wp,-MD,drivers/firmware/efi/libstub/.efi-stub-helper.o.d  -nostdinc -isystem /usr/lib/gcc/x86_64-linux-gnu/4.9/include -I./arch/x86/include -I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/kconfig.h -include ./include/linux/compiler_types.h -D__KERNEL__ -mcmodel=small -m64 -D__KERNEL__ -O2 -fPIC -fno-strict-aliasing -mno-red-zone -mno-mmx -mno-sse -fshort-wchar -DDISABLE_BRANCH_PROFILING -D__NO_FORTIFY -ffreestanding -fno-stack-protector -fplugin-arg-stackleak_plugin-disable   -fno-builtin      -DKBUILD_BASENAME='"efi_stub_helper"' -DKBUILD_MODNAME='"efi_stub_helper"' -c -o drivers/firmware/efi/libstub/.tmp_efi-stub-helper.o drivers/firmware/efi/libstub/efi-stub-helper.c
> > 
> > so given that we're not passing any -fplugin= option anyway (because we
> > override KBUILD_CFLAGS for the stub), I don't understand why we need
> > to the disable option at all.
> > 
> > Laura?
> 
> ... ah, but arm and arm64 inherit the old KBUILD_CFLAGS via the
> cflags-$(CONFIG_ARM64) and cflags-$(CONFIG_ARM) definitions, so they
> would be the places where we need to disable the plugin.

i.e. something like the diff below.

Will

--->8

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 25dd2a14560d..f3700fe08908 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -11,9 +11,11 @@ cflags-$(CONFIG_X86)         += -m$(BITS) -D__KERNEL__ -O2 \
                                   -fPIC -fno-strict-aliasing -mno-red-zone \
                                   -mno-mmx -mno-sse -fshort-wchar
 
-cflags-$(CONFIG_ARM64)         := $(subst -pg,,$(KBUILD_CFLAGS)) -fpie
+cflags-$(CONFIG_ARM64)         := $(subst -pg,,$(KBUILD_CFLAGS)) -fpie \
+                                  $(DISABLE_STACKLEAK_PLUGIN)
 cflags-$(CONFIG_ARM)           := $(subst -pg,,$(KBUILD_CFLAGS)) \
-                                  -fno-builtin -fpic -mno-single-pic-base
+                                  -fno-builtin -fpic -mno-single-pic-base \
+                                  $(DISABLE_STACKLEAK_PLUGIN)
 
 cflags-$(CONFIG_EFI_ARMSTUB)   += -I$(srctree)/scripts/dtc/libfdt
 
@@ -21,7 +23,6 @@ KBUILD_CFLAGS                 := $(cflags-y) -DDISABLE_BRANCH_PROFILING \
                                   -D__NO_FORTIFY \
                                   $(call cc-option,-ffreestanding) \
                                   $(call cc-option,-fno-stack-protector) \
-                                  $(DISABLE_STACKLEAK_PLUGIN)
 
 GCOV_PROFILE                   := n
 KASAN_SANITIZE                 := n


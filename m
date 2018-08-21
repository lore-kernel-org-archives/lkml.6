Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C276C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 02:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC93920673
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 02:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC93920673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbeHUGFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 02:05:46 -0400
Received: from exmail.andestech.com ([59.124.169.137]:8421 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbeHUGFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 02:05:46 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w7L2jXYi048082;
        Tue, 21 Aug 2018 10:45:33 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Tue, 21 Aug 2018
 10:47:27 +0800
Date:   Tue, 21 Aug 2018 10:47:28 +0800
From:   Alan Kao <alankao@andestech.com>
To:     Palmer Dabbelt <palmer@sifive.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <albert@sifive.com>, Christoph Hellwig <hch@infradead.org>,
        Andrew Waterman <andrew@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darius Rad <darius@bluespec.com>, <greentime@andestech.com>,
        <vincentc@andestech.com>, <zong@andestech.com>,
        <nickhu@andestech.com>
Subject: Re: [PATCH v4 3/5] Cleanup ISA string setting
Message-ID: <20180821024728.GA6169@andestech.com>
References: <1533698685-18022-4-git-send-email-alankao@andestech.com>
 <mhng-e7585e65-b47f-48c2-97dd-5cc19396c0a7@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <mhng-e7585e65-b47f-48c2-97dd-5cc19396c0a7@palmer-si-x1c4>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w7L2jXYi048082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 03:22:55PM -0700, Palmer Dabbelt wrote:
> On Tue, 07 Aug 2018 20:24:43 PDT (-0700), alankao@andestech.com wrote:
> >Just a side note: (Assume that atomic and compressed is on)
> >
> >Before this patch, assembler was always given the riscv64imafdc
> >MARCH string because there are fld/fsd's in entry.S; compiler was
> >always given riscv64imac because kernel doesn't need floating point
> >code generation.  After this, the MARCH string in AFLAGS and CFLAGS
> >become the same.
> >
> >Signed-off-by: Alan Kao <alankao@andestech.com>
> >Cc: Greentime Hu <greentime@andestech.com>
> >Cc: Vincent Chen <vincentc@andestech.com>
> >Cc: Zong Li <zong@andestech.com>
> >Cc: Nick Hu <nickhu@andestech.com>
> >Reviewed-by: Christoph Hellwig <hch@lst.de>
> >---
> > arch/riscv/Makefile | 19 ++++++++-----------
> > 1 file changed, 8 insertions(+), 11 deletions(-)
> >
> >diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> >index 6d4a5f6c3f4f..e0fe6790624f 100644
> >--- a/arch/riscv/Makefile
> >+++ b/arch/riscv/Makefile
> >@@ -26,7 +26,6 @@ ifeq ($(CONFIG_ARCH_RV64I),y)
> >
> > 	KBUILD_CFLAGS += -mabi=lp64
> > 	KBUILD_AFLAGS += -mabi=lp64
> >-	KBUILD_MARCH = rv64im
> > 	LDFLAGS += -melf64lriscv
> > else
> > 	BITS := 32
> >@@ -34,22 +33,20 @@ else
> >
> > 	KBUILD_CFLAGS += -mabi=ilp32
> > 	KBUILD_AFLAGS += -mabi=ilp32
> >-	KBUILD_MARCH = rv32im
> > 	LDFLAGS += -melf32lriscv
> > endif
> >
> > KBUILD_CFLAGS += -Wall
> >
> >-ifeq ($(CONFIG_RISCV_ISA_A),y)
> >-	KBUILD_ARCH_A = a
> >-endif
> >-ifeq ($(CONFIG_RISCV_ISA_C),y)
> >-	KBUILD_ARCH_C = c
> >-endif
> >-
> >-KBUILD_AFLAGS += -march=$(KBUILD_MARCH)$(KBUILD_ARCH_A)fd$(KBUILD_ARCH_C)
> >+# ISA string setting
> >+riscv-march-$(CONFIG_ARCH_RV32I)	:= rv32im
> >+riscv-march-$(CONFIG_ARCH_RV64I)	:= rv64im
> >+riscv-march-$(CONFIG_RISCV_ISA_A)	:= $(riscv-march-y)a
> >+riscv-march-y				:= $(riscv-march-y)fd
> >+riscv-march-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-y)c
> >+KBUILD_CFLAGS += -march=$(riscv-march-y)
> >+KBUILD_AFLAGS += -march=$(riscv-march-y)
> >
> >-KBUILD_CFLAGS += -march=$(KBUILD_MARCH)$(KBUILD_ARCH_A)$(KBUILD_ARCH_C)
> 
> We used to have "fd" disabled in KBUILD_CFLAGS because we wanted to ensure
> that any use of floating-point types within the kernel would trigger the
> inclusion of soft-float libraries rather than emitting hardware
> floating-point instructions.  The worry here is that we'd end up corrupting
> the user's floating-point state with the kernel accesses because of the lazy
> save/restore stuff going on.

Thanks for pointing that out.

Just as you said, the use of KBUILD_CFLAGS=*fd* is based on the assumption that
not a single floating-point instruction involves in the kernel, and that might
be wrong.

> I remember at some point it was illegal to use floating-point within the
> kernel, but for some reason I thought that had changed.  I do see a handful
> of references to "float" and "double" in the kernel source, and most of
> references to kernel_fpu_begin() appear to be in SSE-specific stuff.  My one
> worry are the usages in drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c, as
> I can't quickly demonstrate they won't happen.

Empirically, this CFLAGS with *fd* did not cause any trouble to me, but of
course this is not a good statement to support this patch.

Meanwhile, I find a flaw in "[PATCH 4/5] Allow to Disable FPU Support." 
The purpose of this "[PATCH 3/5] Cleanup ISA String" was to make CONFIG_FPU
a switch for the appearance of "fd" in both KBUILD_CFLAGS and KBUILD_ASFLAGS,
but somehow the modification was forgotten.

> 
> If we do this I think we should at least ensure kernel_fpu_{begin,end}() do
> the right thing for RISC-V.  I'd still feel safer telling the C compiler to
> disallow floating-point, though, as I'm a bit paranoid that GCC might go and
> emit a floating-point instruction even when it's not explicitly asked for.
> I just asked Jim, who actually understands GCC, and he said that it'll spill
> to floating-point registers if the cost function determines it's cheaper
> than the stack.  While he thinks that's unlikely, I don't really want to
> rely a GCC cost function for the correctness of our kernel port.

The purpose of this whole patchset was to remove all floating-point-related
logic in kernel space (while remainging FPU systems work as usual), so
implementing the two APIs would be out of scope here.

I suggest that, some people have to provide these APIs if they do need hardware
floating-point calculation in kernel space (kernel or module) in the future.
It seems that we don't need those for the kernel and any already supported
hardware drivers at least for now.  Please correct me if my understanding is
out-of-date.

> 
> I'd like to avoid having "-march=*fd*" in CFLAGS, unless someone can
> convince me it's safe and that I'm just being too paranoid :).

I will send a new version of the patchset, which will make sure that CFLAGS has
no *fd* (3/5) and the CONFIG_FPU did remove *fd* from ASFLAGS (4/5).

> 
> > KBUILD_CFLAGS += -mno-save-restore
> > KBUILD_CFLAGS += -DCONFIG_PAGE_OFFSET=$(CONFIG_PAGE_OFFSET)

Thanks!

Alan

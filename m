Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CB9C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E68206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BkrUUpLJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E68206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbeIZNRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 09:17:10 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57603 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726369AbeIZNRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 09:17:10 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id D45EB21A29;
        Wed, 26 Sep 2018 03:05:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 26 Sep 2018 03:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=YAAlbg
        fgco+8zPEzNLVVaxni0CpmWU3G40gJqbgFe6I=; b=BkrUUpLJrAcMShPVvqOFS9
        pzPen3FwM4EoOt3d+GqkRlCakvItJIEtsIiiz8t2Fk4mJXXJEftIVHMmbQkY7JPD
        xtksL+3lPzkcIAR99WOQflqwpCVdxcJk69iZ+lwIt9OzKfs5+KbmQi/D2/3duBi3
        qw8eP9KjFXcv+uMZFy7kPC+rs6sUVCLRelOJePB6xwsiBr/w4Vn+I7fJ/hGuFfwq
        CZL+35fCnLjDB5cHcMi7HWQIk6EjVwG+Q3v6fWBluRSfriFeflwdM43OfP31Eac5
        ugoZ8uzyOLpXjdsMoNvMAZhdxmJ/vs1OOZM+YcZH/knBRDIGcUyKGQmp/BkAARfA
        ==
X-ME-Proxy: <xmx:wy-rW5di1k5MQIjHBX8Jhh856KthLNYFOTcCCvfw5QEOFUK-4BmcZw>
    <xmx:wy-rW7T-VE8s0a3sMCdUuNEL-tOCT7POLrWR_EBfyhfjXNCYDQoA2w>
    <xmx:wy-rW3vB9TnACwbJfw9THhmC-2pDbAKp7-dnA-R8mUYStJAZE0NwhA>
    <xmx:wy-rWzfJ8tmJrbzgR4OiuXTaGF-FUZSWCGn3TvcRImS6ywQN_CsA3w>
    <xmx:wy-rW5zKizBF3nT98soP0vKCnzbHVGCTzlTQA_ILzSLoj_q9YOncrA>
    <xmx:xS-rW9Qynoy_Q9tbGvhL8__0pHEIayWpdewsPA4l8uGsBtfuUB-WtQ>
X-ME-Sender: <xms:wy-rW2UXPTbElBvAeo5o-9cn5-jFFj9J0AVkpXE0LIe3K-IQCAWFPA>
Received: from snap.ozlabs.ibm.com (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6F96C102D2;
        Wed, 26 Sep 2018 03:05:37 -0400 (EDT)
Message-ID: <d203ccfce64c8f9fd403162f2fa3807ade7f1d28.camel@russell.cc>
Subject: Re: [PATCH v3 2/2] powerpc/64: add stack protector support
From:   Russell Currey <ruscur@russell.cc>
To:     Christophe LEROY <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <0797fc91-6400-2508-1cc0-4bba78aafbbb@c-s.fr>
References: <2b934594d21ade67a4092637cf9e6b7d2d131187.1537801613.git.christophe.leroy@c-s.fr>
         <e84d65fb4744cf8260eb2fc9474765a7f3a60573.1537801613.git.christophe.leroy@c-s.fr>
         <0797fc91-6400-2508-1cc0-4bba78aafbbb@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 26 Sep 2018 17:05:34 +1000
Mime-Version: 1.0
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-25 at 17:56 +0200, Christophe LEROY wrote:
> Snowpatch reports failure on pmac32_defconfig, as follows:
> 
> arch/powerpc/platforms/powermac/bootx_init.o: In function `bootx_printf':
> /var/lib/jenkins-slave/workspace/snowpatch/snowpatch-linux-
> sparse/linux/arch/powerpc/platforms/powermac/bootx_init.c:88: 
> undefined reference to `__stack_chk_fail_local'
> arch/powerpc/platforms/powermac/bootx_init.o: In function 
> `bootx_add_display_props':
> /var/lib/jenkins-slave/workspace/snowpatch/snowpatch-linux-
> sparse/linux/arch/powerpc/platforms/powermac/bootx_init.c:211: 
> undefined reference to `__stack_chk_fail_local'
> arch/powerpc/platforms/powermac/bootx_init.o: In function 
> `bootx_scan_dt_build_struct':
> /var/lib/jenkins-slave/workspace/snowpatch/snowpatch-linux-
> sparse/linux/arch/powerpc/platforms/powermac/bootx_init.c:350: 
> undefined reference to `__stack_chk_fail_local'
> arch/powerpc/platforms/powermac/bootx_init.o: In function `bootx_init':
> /var/lib/jenkins-slave/workspace/snowpatch/snowpatch-linux-
> sparse/linux/arch/powerpc/platforms/powermac/bootx_init.c:598: 
> undefined reference to `__stack_chk_fail_local'
> ld: .tmp_vmlinux1: hidden symbol `__stack_chk_fail_local' isn't defined
> ld: final link failed: Bad value
> Makefile:1040: recipe for target 'vmlinux' failed
> make: *** [vmlinux] Error 1
> 
> I don't have this issue with GCC 8.1, bootx_init.o has references to 
> __stack_chk_fail, not to __stack_chk_fail_local
> 
> Looking online, it may be due to an old build and a lack of 'make 
> clean', could it be the case here ?

We do make mrproper AND clean, just to be sure :)

> 
> Otherwise, can you retry the build to see if it's happen again ?

I've retried the build and the same thing happens.  Our build environment is using
GCC 7.3 on Ubuntu 18.04.  Reproduced on a different machine too, running the same
OS and compiler.

You can see exactly what gets run here: 
https://github.com/ajdlinux/openpower.xyz-snowpatch/blob/master/kernel-build-sparse.sh

- Russell

> 
> Christophe
> 
> Le 24/09/2018 à 17:15, Christophe Leroy a écrit :
> > On PPC64, as register r13 points to the paca_struct at all time,
> > this patch adds a copy of the canary there, which is copied at
> > task_switch.
> > That new canary is then used by using the following GCC options:
> > -mstack-protector-guard=tls
> > -mstack-protector-guard-reg=r13
> > -mstack-protector-guard-offset=offsetof(struct paca_struct, canary))
> > 
> > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > ---
> >   arch/powerpc/Kconfig                      | 2 +-
> >   arch/powerpc/Makefile                     | 8 ++++++++
> >   arch/powerpc/include/asm/paca.h           | 3 +++
> >   arch/powerpc/include/asm/stackprotector.h | 3 +++
> >   arch/powerpc/kernel/asm-offsets.c         | 3 +++
> >   arch/powerpc/kernel/entry_64.S            | 4 ++++
> >   6 files changed, 22 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index 3bcb05929931..602eea723624 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -180,7 +180,7 @@ config PPC
> >   	select HAVE_ARCH_SECCOMP_FILTER
> >   	select HAVE_ARCH_TRACEHOOK
> >   	select HAVE_CBPF_JIT			if !PPC64
> > -	select HAVE_STACKPROTECTOR		if $(cc-option,-mstack-protector-
> > guard=tls) && PPC32
> > +	select HAVE_STACKPROTECTOR		if $(cc-option,-mstack-protector-
> > guard=tls)
> >   	select HAVE_CONTEXT_TRACKING		if PPC64
> >   	select HAVE_DEBUG_KMEMLEAK
> >   	select HAVE_DEBUG_STACKOVERFLOW
> > diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> > index 45b8eb4d8fe7..81552c7b46eb 100644
> > --- a/arch/powerpc/Makefile
> > +++ b/arch/powerpc/Makefile
> > @@ -113,7 +113,11 @@ KBUILD_ARFLAGS	+= --target=elf$(BITS)-$(GNUTARGET)
> >   endif
> >   
> >   cflags-$(CONFIG_STACKPROTECTOR)	+= -mstack-protector-guard=tls
> > +ifdef CONFIG_PPC64
> > +cflags-$(CONFIG_STACKPROTECTOR)	+= -mstack-protector-guard-reg=r13
> > +else
> >   cflags-$(CONFIG_STACKPROTECTOR)	+= -mstack-protector-guard-reg=r2
> > +endif
> >   
> >   LDFLAGS_vmlinux-y := -Bstatic
> >   LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) := -pie
> > @@ -411,8 +415,12 @@ ifdef CONFIG_STACKPROTECTOR
> >   prepare: stack_protector_prepare
> >   
> >   stack_protector_prepare: prepare0
> > +ifdef CONFIG_PPC64
> > +	$(eval KBUILD_CFLAGS += -mstack-protector-guard-offset=$(shell awk '{if
> > ($$2 == "PACA_CANARY") print $$3;}' include/generated/asm-offsets.h))
> > +else
> >   	$(eval KBUILD_CFLAGS += -mstack-protector-guard-offset=$(shell awk '{if
> > ($$2 == "TASK_CANARY") print $$3;}' include/generated/asm-offsets.h))
> >   endif
> > +endif
> >   
> >   # Use the file '.tmp_gas_check' for binutils tests, as gas won't output
> >   # to stdout and these checks are run even on install targets.
> > diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
> > index 6d6b3706232c..98d883e58945 100644
> > --- a/arch/powerpc/include/asm/paca.h
> > +++ b/arch/powerpc/include/asm/paca.h
> > @@ -246,6 +246,9 @@ struct paca_struct {
> >   	struct slb_entry *mce_faulty_slbs;
> >   	u16 slb_save_cache_ptr;
> >   #endif /* CONFIG_PPC_BOOK3S_64 */
> > +#ifdef CONFIG_STACKPROTECTOR
> > +	unsigned long canary;
> > +#endif
> >   } ____cacheline_aligned;
> >   
> >   extern struct paca_struct **paca_ptrs;
> > diff --git a/arch/powerpc/include/asm/stackprotector.h
> > b/arch/powerpc/include/asm/stackprotector.h
> > index 263e2aab1862..e81991955c0d 100644
> > --- a/arch/powerpc/include/asm/stackprotector.h
> > +++ b/arch/powerpc/include/asm/stackprotector.h
> > @@ -29,6 +29,9 @@ static __always_inline void boot_init_stack_canary(void)
> >   	canary ^= LINUX_VERSION_CODE;
> >   
> >   	current->stack_canary = canary;
> > +#ifdef CONFIG_PPC64
> > +	get_paca()->canary = canary;
> > +#endif
> >   }
> >   
> >   #endif	/* _ASM_STACKPROTECTOR_H */
> > diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-
> > offsets.c
> > index a992f7a53cf3..773dee55b3f6 100644
> > --- a/arch/powerpc/kernel/asm-offsets.c
> > +++ b/arch/powerpc/kernel/asm-offsets.c
> > @@ -81,6 +81,9 @@ int main(void)
> >   	OFFSET(MM, task_struct, mm);
> >   #ifdef CONFIG_STACKPROTECTOR
> >   	OFFSET(TASK_CANARY, task_struct, stack_canary);
> > +#ifdef CONFIG_PPC64
> > +	OFFSET(PACA_CANARY, paca_struct, canary);
> > +#endif
> >   #endif
> >   	OFFSET(MMCONTEXTID, mm_struct, context.id);
> >   #ifdef CONFIG_PPC64
> > diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> > index 77a888bfcb53..573fa879d785 100644
> > --- a/arch/powerpc/kernel/entry_64.S
> > +++ b/arch/powerpc/kernel/entry_64.S
> > @@ -624,6 +624,10 @@ _GLOBAL(_switch)
> >   
> >   	addi	r6,r4,-THREAD	/* Convert THREAD to 'current' */
> >   	std	r6,PACACURRENT(r13)	/* Set new 'current' */
> > +#if defined(CONFIG_STACKPROTECTOR)
> > +	ld	r6, TASK_CANARY(r6)
> > +	std	r6, PACA_CANARY(r13)
> > +#endif
> >   
> >   	ld	r8,KSP(r4)	/* new stack pointer */
> >   #ifdef CONFIG_PPC_BOOK3S_64
> > 


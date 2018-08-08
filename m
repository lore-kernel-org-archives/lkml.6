Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBC8C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B1021708
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jlyrZF5q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B1021708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbeHHJhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 05:37:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55642 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbeHHJhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 05:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+5b7gKosyeNkdQOda1z7vya6blsqnJpgJrY9PUkCP7U=; b=jlyrZF5qYGGnqT45ftPGkadh8
        ffIsubXhTvz2QXDJBYWbaIl3IlL5JBbXOswXr/ttyLrOI5HPhzoEcB1UAfPzwEcuzaOWDM0bUVspn
        sffKElzav0bDZyz52LKOKnFBLpox+0yNKu8DtLPbvY9Es4A5/VHHhJH1cxTm8QYn8eAwLVo9K6xrT
        Xi14v4jGjN1gJur5zky7ALLltph7d9MSHv5WTHHOTXOii1dl2harCm1h1yD9qsYD9C+ixZOOPpTjv
        fA2GRM2c+lgIbdh9VIf43cIxqvUwGVmCFDBGomxIMndTLpBJCrAAeWG/Pyl38/rDp4otGo4STnAay
        h8dAcXODQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fnIkA-0003W2-R4; Wed, 08 Aug 2018 07:18:54 +0000
Date:   Wed, 8 Aug 2018 00:18:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alan Kao <alankao@andestech.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Waterman <andrew@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darius Rad <darius@bluespec.com>,
        Vincent Chen <vincentc@andestech.com>,
        Zong Li <zong@andestech.com>, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <greentime@andestech.com>
Subject: Re: [PATCH v4 5/5] Auto-detect whether a FPU exists
Message-ID: <20180808071854.GB27402@infradead.org>
References: <1533698685-18022-1-git-send-email-alankao@andestech.com>
 <1533698685-18022-6-git-send-email-alankao@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533698685-18022-6-git-send-email-alankao@andestech.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  extern unsigned long elf_hwcap;
> +#ifdef CONFIG_FPU
> +extern bool no_fpu;
> +#endif

No need to have an ifdef around an extern declaration.

>  static inline void fstate_save(struct task_struct *task,
>  			       struct pt_regs *regs)
>  {
> +	if (unlikely(no_fpu))
> +		return;
> +
>  	if ((regs->sstatus & SR_FS) == SR_FS_DIRTY) {

Wouldn't the sstatus check here always evaluate to false for the
no_fpu case anyway?

> @@ -39,6 +43,9 @@ static inline void fstate_save(struct task_struct *task,
>  static inline void fstate_restore(struct task_struct *task,
>  				  struct pt_regs *regs)
>  {
> +	if (unlikely(no_fpu))
> +		return;
> +

Same here?

> -#define DEFAULT_SSTATUS (SR_SPIE | SR_FS_INITIAL)
> +#define DEFAULT_SSTATUS \
> +	((unlikely(no_fpu)) ? (SR_SPIE | SR_FS_OFF) : (SR_SPIE | SR_FS_INITIAL))

Please don't hide this in a a macro.

I'd rather get rid of the macro and do this in start_thread:

	regs->sstatus = SR_SPIE /* User mode, irqs on */
	if (!no_fpu)
		regs->sstatus |= SR_FS_INITIAL;

and provide a stub for the no_fpu variable for the !CONFIG_CPU case.

In fact I'd probably invert the polarity of this variable and make it
'has_fpu'.  The for !CONFIG_FPU you define that as

#define has_cpu	false
		
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -22,6 +22,9 @@
>  #include <asm/hwcap.h>
>  
>  unsigned long elf_hwcap __read_mostly;
> +#ifdef CONFIG_FPU
> +bool no_fpu __read_mostly;
> +#endif
>  
>  void riscv_fill_hwcap(void)
>  {
> @@ -58,4 +61,12 @@ void riscv_fill_hwcap(void)
>  		elf_hwcap |= isa2hwcap[(unsigned char)(isa[i])];
>  
>  	pr_info("elf_hwcap is 0x%lx", elf_hwcap);
> +
> +#ifdef CONFIG_FPU
> +	no_fpu = 0;
> +	if (!(elf_hwcap & (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D))) {
> +		pr_info("Bypass FPU code.");
> +		no_fpu = 1;
> +	}
> +#endif

Note that variables unless they are on stack in a function are always
initialized to zero.  So together with my above ideas this could become:

#ifdef CONFIG_FPU
	if (elf_hwcap & (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D)
		has_fpu = true;
#endif

Note the use of true/false for booleans and dropping the printk.

> diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
> index 2450b824d799..9714e4fccb69 100644
> --- a/arch/riscv/kernel/signal.c
> +++ b/arch/riscv/kernel/signal.c
> @@ -45,6 +45,9 @@ static long restore_fp_state(struct pt_regs *regs,
>  	struct __riscv_d_ext_state __user *state = &sc_fpregs->d;
>  	size_t i;
>  
> +	if (unlikely(no_fpu))
> +		return 0;

I'd be tempted to move this into the caler, e.g.

	if (has_fpu) {
		restore_fp_state()..
	}

Also the unlikely annotations seem odd - this seems like something that
even the simplest branch predictor can handle.  If we really want to
optimize it (not for this series but in the future) we should implement
the alternatives mechanism for live patching.

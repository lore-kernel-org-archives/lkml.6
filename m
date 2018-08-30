Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFBAC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0598D2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tt98Oi0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0598D2082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbeH3So2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:44:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41372 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbeH3So2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NFku9iHEzzrk/KE6L1FWj11aQOyWr/lqpqJsf5EBcSg=; b=Tt98Oi0QD+XMmVhifPAgmjYCd
        VWr/V1Tfz2D26lBFDvNblDJbaLz4zZwh1ZZEXF2995ihPOvRdcOlPz7zWpLlofQrMMZ/Xu01/dfg0
        vBhBuo5qKJwBL1WApXd3am/4YVSzDOWTUpYKxpnIMYCtw9ljvZWliU0QXq5dza2VY5wEVgJdsPLt6
        1hptBV/+YcK+IanWMLr+S2uKJZUgTC1d60W0kJXlKYfejkGS9Hn4jnWii/vULIzvsHGIzi3P4WeEd
        1GlofwfOQ3A2AyEtCXbk4LkbOzGq6+6KpuCgIS06f17wpaH2mGxyx+7IJ1/yNtvCJ0QEqhL4crJec
        YNKcsyXcg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvO8x-0007Wx-SI; Thu, 30 Aug 2018 14:41:55 +0000
Date:   Thu, 30 Aug 2018 07:41:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-riscv@lists.infradead.org, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com,
        dmitriy@oss-tech.org, jeremy.linton@arm.com,
        linux-kernel@vger.kernel.org, atish.patra@wdc.com,
        aou@eecs.berkeley.edu, Greg KH <gregkh@linuxfoundation.org>,
        tglx@linutronix.de
Subject: Re: [PATCH 6/8] RISC-V: Use mmgrab()
Message-ID: <20180830144155.GB27233@infradead.org>
References: <20180827184243.25344-1-palmer@sifive.com>
 <20180827184243.25344-7-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827184243.25344-7-palmer@sifive.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#include <linux/sched/mm.h>
>  #include <asm/irq.h>
>  #include <asm/mmu_context.h>
>  #include <asm/tlbflush.h>
> @@ -79,8 +80,8 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
>  	 * the spinning harts that they can continue the boot process.
>  	 */
>  	smp_mb();
> -	__cpu_up_stack_pointer[cpu] = task_stack_page(tidle) + THREAD_SIZE;
> -	__cpu_up_task_pointer[cpu] = tidle;
> +	WRITE_ONCE(__cpu_up_stack_pointer[cpu], task_stack_page(tidle) + THREAD_SIZE);
> +	WRITE_ONCE(__cpu_up_task_pointer[cpu], tidle);

This looks unrelated.

> @@ -100,7 +101,7 @@ asmlinkage void __init smp_callin(void)
>  	struct mm_struct *mm = &init_mm;
>  
>  	/* All kernel threads share the same mm context.  */
> -	atomic_inc(&mm->mm_count);
> +	mmgrab(mm);
>  	current->active_mm = mm;

This part looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>


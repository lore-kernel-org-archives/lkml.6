Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFF1C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43AA32087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RTkObx3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43AA32087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbeIJSlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:41:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46940 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbeIJSlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FVdSVNFJp0QvNizd2aYHJH9Nx3e9PKDutqDOLkgauko=; b=RTkObx3RzZu7PqYri57+SEsim
        Vv7EyJrDKF+rtfMCSmBxxq0XZ/V1GCdhWHNBGSza65tGMSuGRldWGwUtN7kNJt+Lf7o6tuKsLboyb
        kFRCixQzqm+qX+ctUWpPy+LW1n3YrV0D5S95vQLMQxMLWYmJNJtKxl5HzvL5ThRR123yINo9nQT27
        iL+HERkHSjugVVEyPgnNhTxcVBiFsl1kGotPWR4DV18nPJCAKv0bri7Rg4uNT41BTAkw4V3O2xhQg
        w81sLxK77c8IIUw0M43bQZK5UBpUFz79sew0CNy3Uh8RwI4bVq2QXX9/hqkuC84R7sIrS8t7C9iwH
        FWci5xD0g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzMWq-0003FS-3c; Mon, 10 Sep 2018 13:47:00 +0000
Date:   Mon, 10 Sep 2018 06:46:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] RISC-V: Show IPI stats
Message-ID: <20180910134659.GA30774@infradead.org>
References: <20180907124429.31407-1-anup@brainfault.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907124429.31407-1-anup@brainfault.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 06:14:29PM +0530, Anup Patel wrote:
> This patch provides arch_show_interrupts() implementation to
> show IPI stats via /proc/interrupts.
> 
> Now the contents of /proc/interrupts" will look like below:
>            CPU0       CPU1       CPU2       CPU3
>   8:         17          7          6         14  SiFive PLIC   8  virtio0
>  10:         10         10          9         11  SiFive PLIC  10  ttyS0
> IPI0:       170        673        251         79  Rescheduling interrupts
> IPI1:         1         12         27          1  Function call interrupts
> IPI2:         0          0          0          0  CPU wake-up interrupts
> 
> Signed-off-by: Anup Patel <anup@brainfault.org>

Thanks, this looks pretty sensible to me.  Maybe we want to also show
timer interrupts if we do this?

> --- a/arch/riscv/kernel/irq.c
> +++ b/arch/riscv/kernel/irq.c
> @@ -8,6 +8,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/irqchip.h>
>  #include <linux/irqdomain.h>
> +#include <linux/seq_file.h>
>  
>  /*
>   * Possible interrupt causes:
> @@ -24,6 +25,14 @@
>   */
>  #define INTERRUPT_CAUSE_FLAG	(1UL << (__riscv_xlen - 1))
>  
> +int arch_show_interrupts(struct seq_file *p, int prec)
> +{
> +#ifdef CONFIG_SMP
> +	show_ipi_stats(p, prec);
> +#endif
> +	return 0;
> +}

If we don't also add timer stats I'd just move arch_show_interrupts
to smp.c and make it conditional.  If we don't this split might make
more sense.

> +static const char *ipi_names[IPI_MAX] = {
> +	[IPI_RESCHEDULE] = "Rescheduling interrupts",
> +	[IPI_CALL_FUNC] = "Function call interrupts",
> +	[IPI_CALL_WAKEUP] = "CPU wake-up interrupts",
> +};

No need for the explicit array size.  Also please use a few tabs to
align this nicely:

static const char *ipi_names[] = {
	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
	[IPI_CALL_FUNC]		= "Function call interrupts",
	[IPI_CALL_WAKEUP]	= "CPU wake-up interrupts",
};

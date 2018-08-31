Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38523C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 06:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09C820661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 06:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QcV7TA0f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D09C820661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeHaKY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 06:24:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39180 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbeHaKYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 06:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GDmX4l4gkRdsmPEFij6nXUvbXpPfJSVZbfHw862rKog=; b=QcV7TA0fjnqi3nxzn300vovXy
        9JrZZyktH6LQ0UqQnIKxURC7zOUVw48j8sKs4uq9zI+0XEXBRoq7gM1/aYXzqu0r7ItJWE5mRl9lz
        KfYmE569eIE99d/mdW9BtbOtxQdU/Yj6oz2PHVGtvA2Z+iXrWplWFlNI5g9tvZTIDfAuDcShYZM7S
        /rEVvQHH7zd6Ni2S3aqDsRJ7PBk5hE5P1hqPkzbd2iRYwA+dmoYkjULjduDdFAPl8feY6m5vLJRhU
        KepZ2hdSGo+Db6uD7rrTX9ITVPMPpSQuZY6kawbImFoUh1kyvmZl7c5YFoIBw1ATvwd14cGYZ90Ta
        G4j8h6/mQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvcln-0004dd-O9; Fri, 31 Aug 2018 06:18:59 +0000
Date:   Thu, 30 Aug 2018 23:18:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        mark.rutland@arm.com, anup@brainfault.org, hch@infradead.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        damein@vger.kernel.org
Subject: Re: [PATCH v2 3/3] RISC-V: Support cpu hotplug.
Message-ID: <20180831061859.GC19292@infradead.org>
References: <1535445370-19004-1-git-send-email-atish.patra@wdc.com>
 <1535445370-19004-4-git-send-email-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535445370-19004-4-git-send-email-atish.patra@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#else
> +static inline bool can_hotplug_cpu(void) { return 0; }
> +static inline void arch_send_call_wakeup_ipi(int cpu) { }

Please use normal coding style for these stubs.

>  #define INTERRUPT_CAUSE_FLAG	(1UL << (__riscv_xlen - 1))
> +#define get_scause(cause)	(cause & ~INTERRUPT_CAUSE_FLAG)

I think this helper is misleading - the cause includes the interrupt
flag.  I'd rather open code this in the other place as well.

> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index d7c6ca7c..cb209139 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -42,6 +42,13 @@ void arch_cpu_idle(void)
>  	local_irq_enable();
>  }
>  
> +#ifdef CONFIG_HOTPLUG_CPU
> +void arch_cpu_idle_dead(void)
> +{
> +	cpu_play_dead();
> +}
> +#endif

I wonder if it might be worth to introduce a small
arch/riscv/kernel/cpu-hotplug.c file for the various CONFIG_HOTPLUG_CPU
only functions.

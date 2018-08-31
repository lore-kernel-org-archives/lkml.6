Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B63C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 06:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FDF20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 06:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NeJIqgWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07FDF20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbeHaKQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 06:16:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37294 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbeHaKQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 06:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=h5DIRi/7pguCzoWiQZue73FmMTzLwp+f4iXfI1wTytM=; b=NeJIqgWUitas4HA6cRH9WRpKx
        KAh7slWJItCmn/NNJVpzaj6geLZ08tgBLn5O5NM7WYXBV3dvK0r9Km0lbjsEqE3bXSf18DF4pWtAC
        9qRnjOdSCWYpnsFSzZmPWWeua2Zo/arcB5VRZ9xECqJWxMLRqdL5uHgRj45zvk2h2b+qoJgaTzQCe
        pJJ2EGmzWbYw1dXTONaFUTrL/CtwL9MsY6wOY/waTmAIE0fBgOtV2hPbZS+aHiruJtdCaJ6p+DXrA
        yEpNJofvUjhWWXsb0MIlXUzhkc+Xxw2wUPVRS4I86guMJ71W7e3XpRcZVFidbhTHdmYPh3TZ9C9S3
        wosgfbCew==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvce8-0002iG-5s; Fri, 31 Aug 2018 06:11:04 +0000
Date:   Thu, 30 Aug 2018 23:11:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        mark.rutland@arm.com, anup@brainfault.org, hch@infradead.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        damein@vger.kernel.org
Subject: Re: [PATCH v2 2/3] RISC-V: Use Linux logical cpu number instead of
 hartid
Message-ID: <20180831061104.GB19292@infradead.org>
References: <1535445370-19004-1-git-send-email-atish.patra@wdc.com>
 <1535445370-19004-3-git-send-email-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535445370-19004-3-git-send-email-atish.patra@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -#define flush_tlb_all() sbi_remote_sfence_vma(NULL, 0, -1)
> +static inline void remote_sfence_vma(struct cpumask *cmask, unsigned long start,
> +				     unsigned long size)
> +{
> +	struct cpumask hmask;
> +
> +	riscv_cpuid_to_hartid_mask(cmask, &hmask);
> +	sbi_remote_sfence_vma(hmask.bits, start, size);
> +}
> +
> +#define flush_tlb_all() remote_sfence_vma(NULL, 0, -1)

flush_tlb_all passed NULL to sbi_remote_sfence_vma before, so this
changes what we pass.  I think we should keep the existing behavior.

> @@ -93,10 +94,11 @@ static inline void plic_toggle(int ctxid, int hwirq, int enable)
>  static inline void plic_irq_toggle(struct irq_data *d, int enable)
>  {
>  	int cpu;
> +	struct plic_handler *handler;
>  
>  	writel(enable, plic_regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
>  	for_each_cpu(cpu, irq_data_get_affinity_mask(d)) {
> -		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
> +		handler = per_cpu_ptr(&plic_handlers, cpu);

This looks like a spurious change.

Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28D5C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA9720C0B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gDO4KMDt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA9720C0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbeHULOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 07:14:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42990 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbeHULOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 07:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SIRw8Jlc1mnQWPRV/sciX68GhApdsm9OEVbOr3WxSgM=; b=gDO4KMDt36h4DU83LJZDzsD7d
        eLUGToWCqA7gLeAEYvcyWNDfOPv1sIqdyhRfNTfBEy1/nESabNh0iyuB3PX9XKq0ZjhjULPuxMF5b
        fwatKUX5T3F6cxASAhrztrcgmPe9xqJu/fqXhbWkvezPvI/3LTyNtLo9+c4viodakSNaEe0YE4Y17
        Ff1xzFPA85GfbUNqzpIfg9a9s+DQn0b89BhnuN95ImDUYjNAbpIV8wLGPjk6oZmMUETQNMHkKa7hg
        v/eUO8JL5lTNCw6gNrsYvGJucf5WglrqmzdeT7yUORMK3H+EMl2iY+2B5SWAv4AFbN1mqinIvFG0+
        xjWNxOVvw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fs1V6-0002NM-UL; Tue, 21 Aug 2018 07:54:52 +0000
Date:   Tue, 21 Aug 2018 00:54:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        mark.rutland@arm.com, anup@brainfault.org, hch@infradead.org,
        tglx@linutronix.de, Damien.LeMoal@wdc.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 5/5] RISC-V: Support cpu hotplug.
Message-ID: <20180821075452.GC28079@infradead.org>
References: <1534377377-70108-1-git-send-email-atish.patra@wdc.com>
 <1534377377-70108-6-git-send-email-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534377377-70108-6-git-send-email-atish.patra@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  	if (!err) {
> +
> +#ifdef CONFIG_HOTPLUG_CPU
> +		arch_send_call_function_single_ipi(cpu);
> +#endif

Please just provide a stub version of arch_send_call_function_single_ipi
for the !CONFIG_HOTPLUG_CPU case instead of the ifdef here.

> +#ifdef CONFIG_HOTPLUG_CPU
> +int can_hotplug_cpu(void)

This should be a bool.

> +{
> +	if (cpu_ops.cpu_die)
> +		return 1;
> +	else
> +		return 0;
> +}

	return cpu_ops.cpu_die != NULL;

> +void default_cpu_die(unsigned int cpu)
> +{
> +	int sipval, sieval, scauseval;
> +
> +	/* clear all pending flags */
> +	csr_write(sip, 0);
> +	/* clear any previous scause data */
> +	csr_write(scause, 0);
> +
> +	do {
> +		wait_for_interrupt();
> +		sipval = csr_read(sip);
> +		sieval = csr_read(sie);
> +		scauseval = csr_read(scause);
> +	/* only break if wfi returns for an enabled interrupt */
> +	} while ((sipval & sieval) == 0 &&
> +		 scauseval != INTERRUPT_CAUSE_SOFTWARE);
> +
> +	boot_sec_cpu();
> +}

I suspect all of this except for the boot_sec_cpu() should go into
a helper in irq.c.  Also as-is this probably doesn't work as scauseval
will have INTERRUPT_CAUSE_FLAG set, making the comparism never true.

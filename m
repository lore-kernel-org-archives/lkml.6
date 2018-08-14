Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C407FC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702AB21581
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MiW47vip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 702AB21581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732800AbeHNQ0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 12:26:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58814 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732741AbeHNQ0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 12:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hHtdPYHA7AL1PuPfHdU84gQo4AN+KuWstw0czjhquHM=; b=MiW47vipY9KHrXV8iLNx9kG+r
        +znYYTVT5N724PAtuz0XSQS7VHoVt1W2SQTTkCuu9VsecIuFEBjuz0Ft3K3baoQIh6gO0oma2LnTz
        7pK97GcEtewmP0a13jP23ZOAg6DaTkQebMk9VzXg7DlLe1ZBz93ohzkkjlKFWAQmOQAMKp4DCUuLy
        bOZMzv6N8zXE4Woj74yqy2TVO+nWFqjdEvT07FHE5eEvvDSRgeAbtphfkTOyf8YbCltNaxsz/Oi9U
        mIwJRRffQ3lblM86yqwZdwPYOHs9UUvwqmqr0/HDvZbPYYNetPebvREPataf7q/GSF1D3KG+4Bl8r
        G0JXTQ3Cg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fpZXf-0003a4-MR; Tue, 14 Aug 2018 13:39:23 +0000
Date:   Tue, 14 Aug 2018 06:39:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux@roeck-us.net,
        aou@eecs.berkeley.edu, Andrew Waterman <andrew@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux@dominikbrodowski.net, tklauser@distanz.ch,
        linux-riscv@lists.infradead.org, dan.carpenter@oracle.com
Subject: Re: [PATCH v3 1/2] RISC-V: Define sys_riscv_flush_icache when SMP=n
Message-ID: <20180814133922.GC28080@infradead.org>
References: <20180809221952.24260-1-palmer@sifive.com>
 <20180809221952.24260-2-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809221952.24260-2-palmer@sifive.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  SYSCALL_DEFINE3(riscv_flush_icache, uintptr_t, start, uintptr_t, end,
>  	uintptr_t, flags)
>  {
> +#ifdef CONFIG_SMP
>  	struct mm_struct *mm = current->mm;
>  	bool local = (flags & SYS_RISCV_FLUSH_ICACHE_LOCAL) != 0;
> +#endif
>  
>  	/* Check the reserved flags. */
>  	if (unlikely(flags & ~SYS_RISCV_FLUSH_ICACHE_ALL))
>  		return -EINVAL;
>  
> +	/*
> +	 * Without CONFIG_SMP flush_icache_mm is a just a flush_icache_all(),
> +	 * which generates unused variable warnings all over this function.
> +	 */
> +#ifdef CONFIG_SMP
>  	flush_icache_mm(mm, local);
> +#else
> +	flush_icache_all();
> +#endif

Eeek.

Something like an unconditional:

	flush_icache_mm(current->mm, flags & SYS_RISCV_FLUSH_ICACHE_LOCAL);

should solve those issues.

Also in the longer run we should turn the !SMP flush_icache_mm stub
into an inline function to solve this problem for all potential
callers.  Excepte that flush_icache_mm happens to be a RISC-V specific
API without any other callers.  So for now I think the above is what
I'd do, but this area has a lot of room for cleanup.

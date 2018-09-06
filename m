Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA676C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8775D2077C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hCOxYuzc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8775D2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbeIFNgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:36:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50566 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbeIFNgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CxURDXOJ/bVBK6vwIiHDWdbFBP5azd04fxM73FjDmWM=; b=hCOxYuzc+VXxzxJhst7nzr0gZ
        9RrO+Ym9tGR7Z8Yv7eQ+UEI+TqgpSNdjZRcEtgVUcefy+S6/1ClDeDH7jMkCPI8Fq4yhjZe+ZiPpk
        Pk2LFaw6Qm/vvYmsNYPYypnSK08jy76Jn38rQDMgFN1lYTPTIEt+yGtodkhu2nUp65G0mQCMT4/l6
        vcsQaLbfv9KzdDBYUJLW625K5DPI3XVb54fQ0ffURNJAEMudvTcb4P7ko9hDn79EUsbI3vBcGRgfq
        Fkwpzx2m1yD7intMdcdYVt3F/FdB1TI2n+7Q6wfbNUab8gFlGgBicyGCb6TICkifJIu/b7F1HeZs5
        rxEo9bD0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxqAa-00033G-Er; Thu, 06 Sep 2018 09:01:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C285D20210309; Thu,  6 Sep 2018 11:01:42 +0200 (CEST)
Date:   Thu, 6 Sep 2018 11:01:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v2 4/6] x86/alternatives: initializing temporary mm for
 patching
Message-ID: <20180906090142.GG24082@hirez.programming.kicks-ass.net>
References: <20180902173224.30606-1-namit@vmware.com>
 <20180902173224.30606-5-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180902173224.30606-5-namit@vmware.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 02, 2018 at 10:32:22AM -0700, Nadav Amit wrote:
> +void __init poking_init(void)
> +{
> +	unsigned long poking_addr;
> +
> +	poking_mm = copy_init_mm();
> +	if (!poking_mm) {
> +		pr_err("x86/mm: error setting a separate poking address space");
> +		return;
> +	}
> +
> +	/*
> +	 * Randomize the poking address, but make sure that the following page
> +	 * will be mapped at the same PMD. We need 2 pages, so find space for 3,
> +	 * and adjust the address if the PMD ends after the first one.
> +	 */
> +	poking_addr = TASK_UNMAPPED_BASE +
> +		(kaslr_get_random_long("Poking") & PAGE_MASK) %
> +		(TASK_SIZE - TASK_UNMAPPED_BASE - 3 * PAGE_SIZE);
> +
> +	if (((poking_addr + PAGE_SIZE) & ~PMD_MASK) == 0)
> +		poking_addr += PAGE_SIZE;
> +}

This fails to compile for me.. I don't have kaslr_get_random_long().

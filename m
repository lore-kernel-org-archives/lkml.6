Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA10AC4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 09:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB3920844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 09:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Az0mgWn8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB3920844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbeIHOXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 10:23:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34750 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbeIHOXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 10:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=arSLLkz4x4r5ZOaLr/shpRPAdoQhpUrAAuhtA1wLLIg=; b=Az0mgWn8hDo9fm8+uxhioq/vi
        w050KsCMIBCqTM457hjCP0p5fLKslVwWeXWymJLB7QZs6EKrljV2m5IbH3LGSzd0tUkodB4nFpW0m
        E1+9iGiCeQgpcAAA5gu24llVa2j8Mx/OCArJYN9AyVt4GGOYDWH4o8ldxRbU2B5+8cNE4tjzYKOil
        7iMultp0Mw1N+ASr9BjZMlINWxvsQWCHoa/5E5pByyMta6tNWuh5I7/tuCfLOrFj3TG85uovZkgD2
        Y0o5cFczxRkdIQoGWe4C/MyFjMk7PkHuN324eCdu1nz788rvLsCAY6h5C/HX/f5teo6AGUzGB+A8H
        3xt6q/EWg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fyZgv-0003jI-2t; Sat, 08 Sep 2018 09:38:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EE8C42027331B; Sat,  8 Sep 2018 11:38:05 +0200 (CEST)
Date:   Sat, 8 Sep 2018 11:38:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com,
        tglx@linutronix.de, x86@kernel.org, luto@kernel.org
Subject: Re: [RFC][PATCH 3/8] x86/mm: break out user address space handling
Message-ID: <20180908093805.GO24082@hirez.programming.kicks-ass.net>
References: <20180907194852.3C351B82@viggo.jf.intel.com>
 <20180907194857.93621ACE@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907194857.93621ACE@viggo.jf.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 12:48:57PM -0700, Dave Hansen wrote:
> +static noinline void
> +__do_page_fault(struct pt_regs *regs, unsigned long hw_error_code,
> +		unsigned long address)
> +{
> +	prefetchw(&current->mm->mmap_sem);
> +
> +	if (unlikely(kmmio_fault(regs, address)))
> +		return;
> +
> +	/* Was the fault on kernel-controlled part of the address space? */
> +	if (unlikely(fault_in_kernel_space(address)))
> +		do_kern_addr_space_fault(regs, hw_error_code, address);
> +	else
> +		do_user_addr_space_fault(regs, hw_error_code, address);
> +}

How about: do_{user,kernel}_fault() ? That _addr_space_ is just a lot of
typing for no real benefit imo.

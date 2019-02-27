Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E08FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA8C920C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UkO5QxoR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbfB0MCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 07:02:02 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33622 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729808AbfB0MCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 07:02:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gC1QpjC5eUP2inSql7baVcU2hr85v5GCdT9eaUp4MMY=; b=UkO5QxoRx89Sna0SYQYgcHud0
        fstd214LikVJEOQL02fS1v1bMI2JtKP1XniX/y4Bb3qG7PkCTDoJoCcv5Q8PY8UuDKMKxzYEO2bkd
        FhwOoWQSBBLSxE8VwARkCXQKipfb1RS+nbdyGPUyLIp0iJyoEtRkbAKniRvAsvwaWqJuAJFyfsaah
        G1MmeS9iZqt8LxJhkgXoPx4wy5nIPGZiuy5jaSU6rA9Eqh6EdS6hZrR1bHWis8YaJNsQkPBHBIt4y
        QYu9MxNkU8mDjvl1tMgy1g4N5HW2KV7atePoPf2Zo0UqJ9vKepYMOkTj09cgJQtS3OI7GGaJ9Uln1
        QAiIxvYKw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyxuD-0001cc-19; Wed, 27 Feb 2019 12:01:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E49C428525DAA; Wed, 27 Feb 2019 13:01:41 +0100 (CET)
Date:   Wed, 27 Feb 2019 13:01:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kairui Song <kasong@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dave Young <dyoung@redhat.com>, x86@kernel.org,
        devel@linuxdriverproject.org
Subject: Re: [RFC PATCH] x86, hyperv: fix kernel panic when kexec on HyperV VM
Message-ID: <20190227120141.GN32494@hirez.programming.kicks-ass.net>
References: <20190226155615.16724-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226155615.16724-1-kasong@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 11:56:15PM +0800, Kairui Song wrote:
>  arch/x86/hyperv/hv_init.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 7abb09e2eeb8..92291c18d716 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -406,6 +406,10 @@ void hyperv_cleanup(void)
>  	/* Reset our OS id */
>  	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
>  
> +	/* Cleanup page reference before reset the page */
> +	hv_hypercall_pg = NULL;
> +	wmb();

What do we need that SFENCE for? Any why does it lack a comment?

> +
>  	/* Reset the hypercall page */
>  	hypercall_msr.as_uint64 = 0;
>  	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> -- 
> 2.20.1
> 

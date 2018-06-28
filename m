Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197E4C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50D3270F5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="w8JWlmrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C50D3270F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752351AbeF1IkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 04:40:17 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52352 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbeF1IkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 04:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=h4xKpgE2MQLtBZJkuVS8FjXWkeZEK3fhTY/y4XX9agM=; b=w8JWlmrhbMTvoP/D9Pz41JBIa
        83UrwBjtk1SdYcNgdfwKpSw668XjzTbhtn2ApxYgj/WbUIhnOrmi05/Xt9zg/njoxMrElyj4B2zQz
        0AB/GoqDNUlbJHtAKpi2W8K3uV4om3X3Dfy8/q8rxyQJf8QPRTTUKjr+4evT6DrROeUwiMmMse5Qv
        7H/FbzstJjue7I+vkMnPYZaah+hYL6t3mfll0UNEgGMBA7Kjt8E1CdzQAz20Z0jW0P+n+xKiWy7b5
        PMhSOz9Nz17YmAAtrQmelkfLIbA3fy3ecB0dCLFL4o86zuK4EL8boqbHqETTkS4NAZKUmyptS6Brs
        eJk8d0dPA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYSTD-0002eS-TL; Thu, 28 Jun 2018 08:40:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A9CBF20297645; Thu, 28 Jun 2018 10:40:02 +0200 (CEST)
Date:   Thu, 28 Jun 2018 10:40:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        g@hirez.programming.kicks-ass.net
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/5] kernel/jump_label: abstract jump_entry member
 accessors
Message-ID: <20180628084002.GZ2494@hirez.programming.kicks-ass.net>
References: <20180627160604.8154-1-ard.biesheuvel@linaro.org>
 <20180627160604.8154-2-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627160604.8154-2-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 06:06:00PM +0200, Ard Biesheuvel wrote:

> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> index 01ebdf1f9f40..c3524c9b3004 100644
> --- a/kernel/jump_label.c
> +++ b/kernel/jump_label.c
> @@ -38,10 +38,12 @@ static int jump_label_cmp(const void *a, const void *b)
>  	const struct jump_entry *jea = a;
>  	const struct jump_entry *jeb = b;
>  
> -	if (jea->key < jeb->key)
> +	if ((unsigned long)jump_entry_key(jea) <
> +	    (unsigned long)jump_entry_key(jeb))
>  		return -1;
>  
> -	if (jea->key > jeb->key)
> +	if ((unsigned long)jump_entry_key(jea) >
> +	    (unsigned long)jump_entry_key(jeb))
>  		return 1;

I think you can ditch the unsigned long cast and directly compare
pointers. That leads to much prettier code:

	if (jump_entry_key(jea) < jump_entry_key(jeb))
		return -1;

etc..


Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7A8C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27ED21470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tCRY/F66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27ED21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbeJDOil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:38:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48858 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbeJDOik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=slt0o/Y5eHJCzNwlapLyBLoYgMm/G7tr/06+1ILfgwc=; b=tCRY/F66q5V77DRFNTT6rDNf4
        gOmUSnOaYzk9NRhg+NAhAUa49Zn/jFJ7yB5rZUViVbOnV2IXBuw58qSqpsX+3F6KhI5n2tcUDvo+a
        uu4LDbPxcQUkqWHWMTi/zQe9XV+waC5TL+xYrbVcB+9llI2kVjacfhCy6gwcQy2BGNm+knitiYHEE
        U/t6W1wPCNzhI44uAhwA8N6Ap+4xoMUicm+IZvVs1VfFnTpqqemtSdB2+O5jGJNEr18e9TqJ7b9mD
        DZ9dDDuimDThxhOMTrHc522GbUbESp7VkyN5r1/3ga3brBmbLM2QSuJILT7KCw7irSbdd29tJ/rys
        rriSdulrw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7yLJ-0001M3-Ih; Thu, 04 Oct 2018 07:46:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D3C24202666EC; Thu,  4 Oct 2018 09:46:27 +0200 (CEST)
Date:   Thu, 4 Oct 2018 09:46:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 3/6] cpuidle: menu: Get rid of first_idx from
 menu_select()
Message-ID: <20181004074627.GE19272@hirez.programming.kicks-ass.net>
References: <3510260.hvypppS8Bs@aspire.rjw.lan>
 <4130376.2FFt7p4687@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4130376.2FFt7p4687@aspire.rjw.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 11:44:06PM +0200, Rafael J. Wysocki wrote:
>  	idx = -1;
> -	for (i = first_idx; i < drv->state_count; i++) {
> +	for (i = 0; i < drv->state_count; i++) {
>  		struct cpuidle_state *s = &drv->states[i];
>  		struct cpuidle_state_usage *su = &dev->states_usage[i];
>  
>  		if (s->disabled || su->disable)
>  			continue;
> +
>  		if (idx == -1)
>  			idx = i; /* first enabled state */
> +
>  		if (s->target_residency > predicted_us) {
> +			/*
> +			 * Use a physical idle state, not busy polling, unless
> +			 * a timer is going to trigger really really soon.
> +			 */
> +			if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
> +			    i == idx + 1 && latency_req > s->exit_latency &&
> +			    data->next_timer_us > max_t(unsigned int, 20,
> +							s->target_residency)) {

Not new in this patch, but this is where I really noticed it; that 20,
should that not be something like: POLL_IDLE_TIME_LIMIT / NSEC_PER_USEC
?

> +				idx = i;
> +				break;
> +			}
>  			if (predicted_us < TICK_USEC)
>  				break;
>  
> 

Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE20C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F22206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="DrZu+84s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F22206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405821AbeKWCZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 21:25:29 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41733 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbeKWCZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 21:25:29 -0500
Received: by mail-ed1-f65.google.com with SMTP id z28so8050927edi.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 07:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hUuTUv+s2G7K7h9qC0GrCi8WkD6WoUB4IZbeVWgDQNg=;
        b=DrZu+84s6rzVOB+IHZ0V3NtYJvcBcxzGQ+tkFanJJ2N1igEh1N+9Du3DrAnulFhUzx
         Mm5WwNlYcyP9VlTQ+tjsL9+3xieAtsC1Ccy6mRRzJzZrXMOnHkCUAljaxLf4Ux7yp9sZ
         zLjb2Z5e49jm1Fy09dO0/ZO0ssHqj6ggNzMzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hUuTUv+s2G7K7h9qC0GrCi8WkD6WoUB4IZbeVWgDQNg=;
        b=o5oD9wAnZfFyknvs2JDrwC3lc35Mp7kPFSQ2A7gRzXHmkr0Zi7pHhv4TiTtYi1hSu4
         bfpFp023+aFk/WiNwaro7XVO+xERd2LNv5CN61rHmQP+mWyxDZ/K4G3EmDL3fWhDFMhm
         BneD5E6Mrya0EqzgahCyuHs4kcLKBNzz0UDJf+KFft16Feyk1Gyt0CU6oS39yjtpS1+8
         Z9Gyy4u8ZkoneLq3yAeyjtT8KrM9781Vy0E+WW0VfzY2knckwLcd2xIb2+7ue1GlbnoU
         QaFuQWAipaMrCZ6amQgpqVlKMHpcaOMgr6V32LAITc6B2Te8TaaxTwRT11MfRwxLaEAV
         DvRg==
X-Gm-Message-State: AGRZ1gJhOvLuFgtYojvuJGbrt0gjOU/ufFXmnHsNR3TKdI4JJ3rxwE51
        ql0WFff/HSRC/cEht2yIye+J5g==
X-Google-Smtp-Source: AJdET5dG9omYPG26APSmPpHqTG/vmuygttzR7O2Wsrk4rKpoDNvqqLvjNHJ7ybOP6/elylrH8m7ntA==
X-Received: by 2002:a17:906:2cd3:: with SMTP id r19-v6mr8489968ejr.38.1542901533862;
        Thu, 22 Nov 2018 07:45:33 -0800 (PST)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id x58sm13104893edm.10.2018.11.22.07.45.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 07:45:33 -0800 (PST)
Date:   Thu, 22 Nov 2018 16:45:27 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [Question] smp_wmb() in prepare_uprobe()
Message-ID: <20181122154526.GA14616@andrea>
References: <20181121224124.GB4016@andrea>
 <20181122123655.GD28270@redhat.com>
 <20181122134400.GA10327@andrea>
 <20181122150524.GF28270@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122150524.GF28270@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 04:05:24PM +0100, Oleg Nesterov wrote:
> On 11/22, Andrea Parri wrote:
> >
> > > See 142b18ddc81439acda4bc4231b291e99fe67d507 ("uprobes: Fix handle_swbp()
> > > vs unregister() + register() race") and the comment above this rmb().
> >
> > Mmh..., at first glance, this suggests me that the above set_bit() and
> > test_bit() to/from uprobe->flags are among these memory accesses.  But
> > this doesn't make sense to me: these accesses do not "alternate" (i.e.,
> > they both appear after the corresponding barrier..); instead I'd expect
> > something like (on top of the above diff):
> >
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 2d29977522017..a75b9a08dee54 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -2178,10 +2178,18 @@ static void handle_swbp(struct pt_regs *regs)
> >  	 * After we hit the bp, _unregister + _register can install the
> >  	 * new and not-yet-analyzed uprobe at the same address, restart.
> >  	 */
> > -	smp_rmb(); /* pairs with the smp_wmb() in prepare_uprobe() */
> >  	if (unlikely(!test_bit(UPROBE_COPY_INSN, &uprobe->flags)))
> >  		goto out;
> >
> > +	/*
> > +	 * Pairs with the smp_wmb() in prepare_uprobe().
> > +	 *
> > +	 * Guarantees that if we see the UPROBE_COPY_INSN bit set, then
> > +	 * we must (can) also see the stores to &uprobe->arch performed
> > +	 * by prepare_uprobe() (say).
> > +	 */
> > +	smp_rmb();
> 
> OOPS, you are right! Thanks.

Thank you for the clarification; I'll send a patch with the fix shortly.

  Andrea


> 
> Oleg.
> 

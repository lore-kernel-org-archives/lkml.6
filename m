Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D017C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F03208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="gUx7iYnA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F03208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbeJPECq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 00:02:46 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41933 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeJPECq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 00:02:46 -0400
Received: by mail-pl1-f196.google.com with SMTP id q17-v6so9830709plr.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 13:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bCG56MnvqknkV8yWIM1urB4dfW5GfosWZ/Pr+b9aTc0=;
        b=gUx7iYnAVk2aekhGq/1UAPgVIzD5v+C3MbNDeZ/fO+ulwk7tR8g1VJxPpmKGVG7DQl
         q7xgY0SfDkCpoGWA3tBB7Kk8CD6riV3179robf/nMlVa8AkmhBRTqlydOY66AialCdlx
         488un7mF0M0i8quXKybpYG30xobaLy+Zc7IaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bCG56MnvqknkV8yWIM1urB4dfW5GfosWZ/Pr+b9aTc0=;
        b=j44BEjmdMhW3v7GDH9NPgXt6Najk7F7edpMWNPbddNdOpC+DyicaCaUrdoyiac04yv
         vb0QK2za0/+POEyCVTYR/ETDQ6Uuih8U6OluWr/RUjSgssOlsbaAflCwpxFuKH7WfQzT
         wRUtHPGiobLYAtKaVItC384RKNvwInoO5kcD+/H4seTlp+AlgdamdZfTAaG1at7BdPcr
         PW1qzBYZzLZ/GNe9ZNOjZ42qou92N0OmOPjM1TqGrQVFOAqLauEGIeVJVWYu/bJE1H7X
         W42CQIw5kYh89ug/sRF95G+1bKp8xfzxMo/m9a291Of8OZgTNLkdAPDjDO7UnnUnWCzP
         c9Tg==
X-Gm-Message-State: ABuFfoiMIkKuvRmrsSoHmeUrj8Yzs18XGFOm2jZo6Kp5FxH9wDZmAfJs
        9Nz7S+ZPyg+YIRh6nJ7OUNMS1w==
X-Google-Smtp-Source: ACcGV61OnpFXUsG4YV2MK6nnPTIS9vHYx1oz1S+HXGjA/afo3d+u98ei8DHNwysKVGYsDRIDc4htyw==
X-Received: by 2002:a17:902:7203:: with SMTP id ba3-v6mr8448519plb.321.1539634559171;
        Mon, 15 Oct 2018 13:15:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id m10-v6sm18226446pfg.180.2018.10.15.13.15.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 13:15:57 -0700 (PDT)
Date:   Mon, 15 Oct 2018 13:15:56 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] doc: rcu: remove obsolete (non-)requirement about
 disabling preemption
Message-ID: <20181015201556.GA43575@joelaf.mtv.corp.google.com>
References: <20181014212955.95267-1-joel@joelfernandes.org>
 <20181014231731.GN2674@linux.ibm.com>
 <20181015020827.GA217384@joelaf.mtv.corp.google.com>
 <20181015021349.GB217384@joelaf.mtv.corp.google.com>
 <20181015023328.GP2674@linux.ibm.com>
 <20181015024758.GA227989@joelaf.mtv.corp.google.com>
 <5151da01-343b-bb37-353e-b6652ae530f5@suse.com>
 <20181015112112.GT2674@linux.ibm.com>
 <20181015193951.GA33528@joelaf.mtv.corp.google.com>
 <20181015195426.GD2674@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015195426.GD2674@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 12:54:26PM -0700, Paul E. McKenney wrote:
[...]
> > > In any case, please don't spin for milliseconds with preemption disabled.
> > > The real-time guys are unlikely to be happy with you if you do this!
> > 
> > Well just to clarify, I was just running Oleg's test which did this. This
> > test was mentioned in the original documentation that I deleted. Ofcourse I
> > would not dare do such a thing in production code :-D. I guess to Oleg's
> > defense, he did it to very that synchronize_rcu() was not blocked on
> > preempt-disable sections which was a different test.
> 
> Understood!  Just pointing out that RCU's tolerating a given action does
> not necessarily mean that it is a good idea to take that action.  ;-)

Makes sense :-) thanks.

> > > > > +		pr_crit("SPIN done!\n");
> > > > > +		preempt_enable();
> > > > > +		break;
> > > > > +	case 777:
> > > > > +		pr_crit("SYNC start\n");
> > > > > +		synchronize_rcu();
> > > > > +		pr_crit("SYNC done!\n");
> > > > 
> > > > But you are using the console printing infrastructure which is rather
> > > > heavyweight. Try replacing pr_* calls with trace_printk so that you
> > > > write to the lock-free ring buffer, this will reduce the noise from the
> > > > heavy console printing infrastructure.
> > > 
> > > And this might be a problem as well.
> > 
> > This was not the issue (or atleast not fully the issue) since I saw the same
> > thing with trace_printk. It was exactly what you said - which is the
> > excessively long preempt disabled times.
> 
> One approach would be to apply this patch against (say) v4.18, which
> does not have consolidated grace periods.  You might then be able to
> tell if the pr_crit() calls make any difference.

I could do that, yeah. But since the original problem went away due to
disabling preempts for a short while, I will move on and continue to focus on
updating other parts of the documenation. Just to mention I
brought this up because I thought its better to do that than not to, just
incase there is any lurking issue with the consolidation. Sorry if that ended
up with me being noisy.

Just curious, while I am going through the documentation, is there anything
in particular that particularly sticks out to you that needs updating? I
think I am around 50% there with the last several rounds of doc patches but I
have lot more to go through. "Just keep doing what you're doing" is also a
perfectly valid answer ;-)

thanks,

 - Joel


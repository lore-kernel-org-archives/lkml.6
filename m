Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DDCC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4422082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="KCVSFnmV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4422082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbeKCHWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 03:22:34 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41286 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeKCHWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 03:22:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id k13so1541165pga.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 15:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xdBL0DlA3KNettyWK3BHrvK++SJ5OVVpJi6/gu9FZpw=;
        b=KCVSFnmVg0hT65Pfzd0i9KZpFdgPHxmexub+VQRzuuE/4ImXowNJ0YsmglOW5X5gZC
         WDZ29mqBoWgJcWnP29esc4mpZO3CYGvd6cBgdev85qIQQbBsMDHH9NXy6oQl8XDF9guP
         yyt9w1VFRNYUFHWL/jzq2WT+6nzAPp4xEMkAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xdBL0DlA3KNettyWK3BHrvK++SJ5OVVpJi6/gu9FZpw=;
        b=H6rhB9wuf+OJH0AziMHqQvw78JjvwTJ0m16fg+VaFy3XHU8cjCirnmTSaisGDQu6AO
         8yGUCESC1HEK68ZQI6RNdPny5pSkSLkKGjVGB+B3QoVMcl/wwMH/TQne0SpZ+ZHWP8ft
         1Xn/BQtZhReXVaroa29jd9/40xu93NeSeBH624InSYHjEhJATlHPe3gzd0qNcHY9JKWK
         2HhwZaTSauD5bA52Yw7EXrzHGWE6BOmUTn8bqLm3SmH2hoeGiAWMh6UoVcO3g3FoZNP8
         7j/AGcHMjOcaTgmRuhxQGM/BlEUuzEegzzZl+XJ0KIxQlOJsm7NVGj9hv+nQpsYvC0X9
         zAVg==
X-Gm-Message-State: AGRZ1gI6lWo6SWB6ywK96g7+PvEJXCtUixJz6vRXW+TowGCPxMv3cDoK
        6JfvNhkxz1GOtlawfi+KBmMNIDDjmpY=
X-Google-Smtp-Source: AJdET5ciGU5tzRYDvwnJ32Vw9tschbG7m1SOte/771cdPmgUGo4e3Tk1onu83xd9RUnPbfO9rMzowA==
X-Received: by 2002:a62:4251:: with SMTP id p78-v6mr1148087pfa.72.1541196818926;
        Fri, 02 Nov 2018 15:13:38 -0700 (PDT)
Received: from breakout.internal.digitalocean.com (97-120-168-235.ptld.qwest.net. [97.120.168.235])
        by smtp.gmail.com with ESMTPSA id d24-v6sm18601636pfe.40.2018.11.02.15.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 15:13:38 -0700 (PDT)
Received: by breakout.internal.digitalocean.com (Postfix, from userid 1000)
        id 2DC1B8A2A45; Fri,  2 Nov 2018 15:13:37 -0700 (PDT)
Date:   Fri, 2 Nov 2018 15:13:37 -0700
From:   Nishanth Aravamudan <naravamudan@digitalocean.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jan =?iso-8859-1?Q?H=2E_Sch=F6nherr?= <jschoenh@amazon.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [RFC 00/60] Coscheduling for Linux
Message-ID: <20181102221337.GA22399@breakout>
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <20180914111251.GC24106@hirez.programming.kicks-ass.net>
 <1d86f497-9fef-0b19-50d6-d46ef1c0bffa@amazon.de>
 <20180917113315.GS24124@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180917113315.GS24124@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.09.2018 [13:33:15 +0200], Peter Zijlstra wrote:
> On Fri, Sep 14, 2018 at 06:25:44PM +0200, Jan H. Schönherr wrote:
> > On 09/14/2018 01:12 PM, Peter Zijlstra wrote:
> > > On Fri, Sep 07, 2018 at 11:39:47PM +0200, Jan H. Schönherr wrote:
> 
> > >> B) Why would I want this?
> > > 
> > >>    In the L1TF context, it prevents other applications from
> > >>    loading additional data into the L1 cache, while one
> > >>    application tries to leak data.
> > > 
> > > That is the whole and only reason you did this;
> > It really isn't. But as your mind seems made up, I'm not going to
> > bother to argue.
> 
> > >> D) What can I *not* do with this?
> > >> ---------------------------------
> > >>
> > >> Besides the missing load-balancing within coscheduled
> > >> task-groups, this implementation has the following properties,
> > >> which might be considered short-comings.
> > >>
> > >> This particular implementation focuses on SCHED_OTHER tasks
> > >> managed by CFS and allows coscheduling them. Interrupts as well
> > >> as tasks in higher scheduling classes are currently out-of-scope:
> > >> they are assumed to be negligible interruptions as far as
> > >> coscheduling is concerned and they do *not* cause a preemption of
> > >> a whole group. This implementation could be extended to cover
> > >> higher scheduling classes. Interrupts, however, are an orthogonal
> > >> issue.
> > >>
> > >> The collective context switch from one coscheduled set of tasks
> > >> to another -- while fast -- is not atomic. If a use-case needs
> > >> the absolute guarantee that all tasks of the previous set have
> > >> stopped executing before any task of the next set starts
> > >> executing, an additional hand-shake/barrier needs to be added.
> > > 
> > > IOW it's completely friggin useless for L1TF.
> > 
> > Do you believe me now, that L1TF is not "the whole and only reason"
> > I did this? :D
> 
> You did mention this work first to me in the context of L1TF, so I might
> have jumped to conclusions here.
> 
> Also, I have, of course, been looking at (SMT) co-scheduling,
> specifically in the context of L1TF, myself. I came up with a vastly
> different approach. Tim - where are we on getting some of that posted?
> 
> Note; that even though I wrote much of that code, I don't particularly
> like it either :-)

Did your approach get posted to LKML? I never saw it I don't think, and
I don't see it on lore. Could it be posted as an RFC, even if not
suitable for upstreaming yet, just for comparison?

Thanks!
-Nish

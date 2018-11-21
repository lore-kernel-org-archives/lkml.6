Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DFAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 04:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE7F2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 04:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="kBFcWVzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE7F2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbeKUPKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 10:10:12 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40465 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeKUPKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 10:10:11 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22-v6so3570960pls.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 20:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8sm5U8cKgs+Hk5a0p2QXRBGPqZ7nN5nin9bTAzAn6D0=;
        b=kBFcWVzsWnCIMDVTR8h7GDL7Kvggn1JU5Lu/AsSFW5Yxp2mFTAyOmcT23FmqNwU6nF
         2xQT/rggQSHUU1FUNUBTI6svDOYH5GRqwKEMIXXJKSqCXROVUg56NQCpOwWBQ0RjL5Yr
         sQD/8lUJRWQHQ1nmMV5jRhkq5m6Vh6y63qn5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8sm5U8cKgs+Hk5a0p2QXRBGPqZ7nN5nin9bTAzAn6D0=;
        b=CtKM6Sao2Z1LQqNvwo4XgU06BuR/MLB6IZAhgxMnUV9f7dG5j5Lf9JfHyegz9RloXg
         OtV0K6hXMSGQKfSAXIvCCuYcpP/b1sk4pXTEKCub5zSrLWjgKETDZt4jH+xOa5hUo8B6
         JipSuDBa5zALNjANQSPj5i2D4dU7mEhXgVJkAkWTMZcTCF56haeHZAtwFbAUkOMxKmuD
         v7RNKFQvwaijon5TtyxJvat1lJb2bDwOwZuQP0qB23aCNPT7cZYwI4lCUb8ZoPVu/t5C
         SgXMc5S+ARW9Q6B5Zy0eY7/7DsFC/OC9MiTCbEjsHTjMd2fOntTkKunK49uneIjYaP1H
         Cidg==
X-Gm-Message-State: AGRZ1gIZPnrKla/7tVQfXCsRZQzJRbG0sSQx5kDfYNT3qMMeXll5O5o0
        IfshYT71NhRnHStzTStumKajKQ==
X-Google-Smtp-Source: AJdET5fs90hJgFD9nxQNL+JCVe+VUMWyKKYkC/om6nM6wxJF4vg2NR4mGiK10XytmXHGrrlUIkibkQ==
X-Received: by 2002:a62:6ec8:: with SMTP id j191mr5206605pfc.198.1542775044987;
        Tue, 20 Nov 2018 20:37:24 -0800 (PST)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id q195sm48747758pgq.7.2018.11.20.20.37.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 20:37:23 -0800 (PST)
Date:   Tue, 20 Nov 2018 20:37:22 -0800
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com
Subject: Re: dyntick-idle CPU and node's qsmask
Message-ID: <20181121043722.GA102501@google.com>
References: <20181110214659.GA96924@google.com>
 <20181110230436.GL4170@linux.ibm.com>
 <20181111030925.GA182908@google.com>
 <20181111042210.GN4170@linux.ibm.com>
 <20181111180916.GA25327@google.com>
 <20181111183618.GY4170@linux.ibm.com>
 <20181120204243.GA22801@google.com>
 <20181120222813.GE4170@linux.ibm.com>
 <20181121020612.GB60896@google.com>
 <20181121024107.GI4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121024107.GI4170@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 06:41:07PM -0800, Paul E. McKenney wrote:
[...] 
> > > > I was thinking if we could simplify rcu_note_context_switch (the parts that
> > > > call rcu_momentary_dyntick_idle), if we did the following in
> > > > rcu_implicit_dynticks_qs.
> > > > 
> > > > Since we already call rcu_qs in rcu_note_context_switch, that would clear the
> > > > rdp->cpu_no_qs flag. Then there should be no need to call
> > > > rcu_momentary_dyntick_idle from rcu_note_context switch.
> > > 
> > > But does this also work for the rcu_all_qs() code path?
> > 
> > Could we not do something like this in rcu_all_qs? as some over-simplified
> > pseudo code:
> > 
> > rcu_all_qs() {
> >   if (!urgent_qs || !heavy_qs)
> >      return;
> > 
> >   rcu_qs();   // This clears the rdp->cpu_no_qs flags which we can monitor in
> >               //  the diff in my last email (from rcu_implicit_dynticks_qs)
> > }
> 
> Except that rcu_qs() doesn't necessarily report the quiescent state to
> the RCU core.  Keeping down context-switch overhead and all that.

Sure yeah, but I think the QS will be indirectly anyway by the force_qs_rnp()
path if we detect that rcu_qs() happened on the CPU?

> > > > I think this would simplify cond_resched as well.  Could this avoid the need
> > > > for having an rcu_all_qs at all? Hopefully I didn't some Tasks-RCU corner cases..
> > > 
> > > There is also the code path from cond_resched() in PREEMPT=n kernels.
> > > This needs rcu_all_qs().  Though it is quite possible that some additional
> > > code collapsing is possible.
> > > 
> > > > Basically for some background, I was thinking can we simplify the code that
> > > > calls "rcu_momentary_dyntick_idle" since we already register a qs in other
> > > > ways (like by resetting cpu_no_qs).
> > > 
> > > One complication is that rcu_all_qs() is invoked with interrupts
> > > and preemption enabled, while rcu_note_context_switch() is
> > > invoked with interrupts disabled.  Also, as you say, Tasks RCU.
> > > Plus rcu_all_qs() wants to exit immediately if there is nothing to
> > > do, while rcu_note_context_switch() must unconditionally do rcu_qs()
> > > -- yes, it could check, but that would be redundant with the checks
> > 
> > This immediate exit is taken care off in the above psuedo code, would that
> > help the cond_resched performance?
> 
> It look like you are cautiously edging towards the two wrapper functions
> calling common code, relying on inlining and simplification.  Why not just
> try doing it?  ;-)

Sure yeah. I was more thinking of the ambitious goal of getting rid of the
complexity and exploring the general design idea, than containing/managing
the complexity with reducing code duplication. :D

> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index c818e0c91a81..5aa0259c014d 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -1063,7 +1063,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
> > > >  	 * read-side critical section that started before the beginning
> > > >  	 * of the current RCU grace period.
> > > >  	 */
> > > > -	if (rcu_dynticks_in_eqs_since(rdp, rdp->dynticks_snap)) {
> > > > +	if (rcu_dynticks_in_eqs_since(rdp, rdp->dynticks_snap) || !rdp->cpu_no_qs.b.norm) {
> > > 
> > > If I am not too confused, this change could cause trouble for
> > > nohz_full CPUs looping in the kernel.  Such CPUs don't necessarily take
> > > scheduler-clock interrupts, last I checked, and this could prevent the
> > > CPU from reporting its quiescent state to core RCU.
> > 
> > Would that still be a problem if rcu_all_qs called rcu_qs? Also the above
> > diff is an OR condition so it is more relaxed than before.
> 
> Yes, because rcu_qs() is only guaranteed to capture the quiescent
> state on the current CPU, not necessarily report it to the RCU core.

The reporting to the core is necessary to call rcu_report_qs_rnp so that the
QS information is propogating up the tree, right?

Wouldn't that reporting be done anyway by:

force_qs_rnp
  -> rcu_implicit_dynticks_qs  (which returns 1 because rdp->cpu_no_qs.b.norm
				was cleared by rcu_qs() and we detect that
				with help of above diff)

  -> rcu_report_qs_rnp is called with mask bit set for corresponding CPU that
  				has the !rdp->cpu_no_qs.b.norm


I think that's what I am missing - that why wouldn't the above scheme work.
The only difference is reporting to the RCU core might invoke pending
callbacks but I'm not sure if that matters for this. I'll these changes,
and try tracing it out and study it more.  thanks for the patience,

 - Joel
 

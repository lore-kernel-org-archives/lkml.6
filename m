Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79647ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316BB2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="biW9nDpq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316BB2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbeJTBba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 21:31:30 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36805 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbeJTBb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 21:31:29 -0400
Received: by mail-pl1-f194.google.com with SMTP id y11-v6so16139981plt.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 10:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VTnFOBixui79GYZyd1d6AFYHBoWHP2ePrlCN4gUkHyk=;
        b=biW9nDpqzbHaUAY2aAwObqu/S5gb09yycRPQuFQPwS915bCRnOZGzwu7bk/GlIdeD7
         +WHAVw+YuhIAJ6S/VL+zRA0W+dw51NrMlfyvt4QaAD6HalCdvDMgWCWsXuCHsYTo43+9
         bX2hHJqOSOWcrk7wqb0NkWzZPUwDjcqas535E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VTnFOBixui79GYZyd1d6AFYHBoWHP2ePrlCN4gUkHyk=;
        b=YpIk5sG7E6oPn4F0r8DXE0kG8A46cRXbnnhsKaJwbVR0Ulg0hX5JLCDZvqntbQ8W9+
         jXgOZendPdPflmK8tFDpr0Fk4CUFSJEzt8rz5UBl+Js36kTfLcU9Dq9LxNq4c4VmHjsJ
         0J/yzx1IU+j0S33pH/D+ggs10/bXKRS3D+1RVh0tXeXK6Lc/86xUNN97oYKsm7lQvNsv
         pXtYcMxgmP4ek9sLMUzmBvhkxdEXXAL4re2CrkvDV62rLGFmJFNDpAc4/DkWarZY6Iug
         5UYIwBTvYxTEME4SgbmQvBfz+qt5p3SIgaf4h7qc3DmanQPW2q4ACskkovbhos9Td2z4
         8FvQ==
X-Gm-Message-State: ABuFfoioHS+ctwH6phG9YHJ/ak0k+fTepiTNdHtQQNFJXsZgxwmKNSCK
        k0Aer/v/mxRVhDALXKker9SX7BeEZyI=
X-Google-Smtp-Source: ACcGV63WZpY6yUQ+VqBypfvICr6Xjdf5o5s0h33vJDjjk6DKruyJkEmsqfimin4mYh7ninU9AWIZJg==
X-Received: by 2002:a17:902:59d2:: with SMTP id d18-v6mr2932755plj.116.1539969867836;
        Fri, 19 Oct 2018 10:24:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id i5-v6sm24315196pgs.10.2018.10.19.10.24.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 10:24:26 -0700 (PDT)
Date:   Fri, 19 Oct 2018 10:24:25 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH RFC] doc: rcu: remove obsolete (non-)requirement about
 disabling preemption
Message-ID: <20181019172425.GA197351@joelaf.mtv.corp.google.com>
References: <20181018020751.GB99677@joelaf.mtv.corp.google.com>
 <20181018144637.GD2674@linux.ibm.com>
 <20181019000350.GB89903@joelaf.mtv.corp.google.com>
 <20181019001932.GR2674@linux.ibm.com>
 <20181019012645.GC89903@joelaf.mtv.corp.google.com>
 <20181018215035.5e8ff553@vmware.local.home>
 <20181019022529.GA155753@joelaf.mtv.corp.google.com>
 <20181018225223.42641c73@vmware.local.home>
 <20181019035844.GA141835@joelaf.mtv.corp.google.com>
 <20181019120758.GV2674@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019120758.GV2674@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 05:07:58AM -0700, Paul E. McKenney wrote:
> On Thu, Oct 18, 2018 at 08:58:44PM -0700, Joel Fernandes wrote:
> > On Thu, Oct 18, 2018 at 10:52:23PM -0400, Steven Rostedt wrote:
> > > On Thu, 18 Oct 2018 19:25:29 -0700
> > > Joel Fernandes <joel@joelfernandes.org> wrote:
> > > 
> > > > On Thu, Oct 18, 2018 at 09:50:35PM -0400, Steven Rostedt wrote:
> > > > > On Thu, 18 Oct 2018 18:26:45 -0700
> > > > > Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > >   
> > > > > > Yes, local_irq_restore is light weight, and does not check for reschedules.
> > > > > > 
> > > > > > I was thinking of case where ksoftirqd is woken up, but does not run unless
> > > > > > we set the NEED_RESCHED flag. But that should get set anyway since probably
> > > > > > ksoftirqd is of high enough priority than the currently running task..
> > > > > > 
> > > > > > Roughly speaking the scenario could be something like:
> > > > > > 
> > > > > > rcu_read_lock();
> > > > > >                  <-- IPI comes in for the expedited GP, sets exp_hint
> > > > > > local_irq_disable();
> > > > > > // do a bunch of stuff
> > > > > > rcu_read_unlock();   <-- This calls the rcu_read_unlock_special which raises
> > > > > >                          the soft irq, and wakesup softirqd.  
> > > > > 
> > > > > If softirqd is of higher priority than the current running task, then
> > > > > the try_to_wake_up() will set NEED_RESCHED of the current task here.
> > > > >   
> > > > 
> > > > Yes, only *if*. On my system, ksoftirqd is CFS nice 0. I thought expedited
> > > > grace periods are quite important and they should complete quickly which is
> > > > the whole reason for interrupting rcu read sections with an IPI and stuff.
> > > > IMO there should be no harm in setting NEED_RESCHED unconditionally anyway
> > > > for possible benefit of systems where the ksoftirqd is not of higher priority
> > > > than the currently running task, and we need to run it soon on the CPU. But
> > > > I'm Ok with whatever Paul and you want to do here.
> > > 
> > > 
> > > Setting NEED_RESCHED unconditionally wont help. Because even if we call
> > > schedule() ksoftirqd will not be scheduled! If it's CFS nice 0, and the
> > > current task still has quota to run, if you call schedule, you'll just
> > > waste time calculating that the current task should still be running.
> > > It's equivalent to calling yield() (which is why we removed all yield()
> > > users in the kernel, because *all* of them were buggy!). This is *why*
> > > it only calls schedule *if* softirqd is of higher priority.
> > 
> > Yes, ok. you are right the TTWU path should handle setting the NEED_RESCHED
> > flag or not and unconditionally setting it does not get us anything. I had to
> > go through the code a bit since it has been a while since I explored it.
> > 
> > So Paul, I'm Ok with your latest patch for the issue we discussed and don't
> > think much more can be done barring raising of ksofitrqd priorities :-) So I
> > guess the synchronize_rcu_expedited will just cope with the deal between
> > local_irq_enable and the next scheduling point.. :-)
> 
> Thank you both!
> 
> Indeed, real-time systems need to be configured carefully, especially if
> you are crazy enough to run them under high load.  I interpreted "Ok with
> your latest patch" as an Acked-by, but please let me know if that is a
> misinterpretation.

Yes,

Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks!

- Joel


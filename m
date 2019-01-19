Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E38DC5AE5E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04AFC20850
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="wvmflCNd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbfASBx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 20:53:58 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37856 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbfASBx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 20:53:58 -0500
Received: by mail-qt1-f194.google.com with SMTP id t33so17357248qtt.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 17:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uA2xWLve8Th5/na34Noxswo34IRYpFbURVS0OXk2Y+4=;
        b=wvmflCNdwPrJbnXhBU1O9qAEh9KVIRyZ/yn+iVd3oyZ/4ADrtDfcawNJYPzJOlTOcn
         yHHknYOk16lznM6rppvst8aqhmmpZ8fEZ3STAOFjPB0V142rIs5wqCgm+A/2T4mx4X5Q
         NuK49aZyNo+Fr3LkWj72mhjNAjZJ31F83bNIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uA2xWLve8Th5/na34Noxswo34IRYpFbURVS0OXk2Y+4=;
        b=BPbvvaH6k3czFNucEdzx09WpShgwqUR2M9sAZvYW94KrdkdHgmD+7vpYmFwc/11VX4
         YH7J5YH904nEyCNXO+8KXFGiXnMJylWDKiOzrDFIYs5iWrAiT+xyEl7buz9sXEftnWCO
         8LdPsAMyVwgnrlw7k7uve6+n50sJI+b8UIh8iq6rfuckwE3Se2N2MnjiNPBn4u0pExsi
         Tw5CQkCesZoCxglkFQE1omdaun/FPiT4Gu0XNjrL7+Sy1hARNd3r7kQzsVMzE9nxqocy
         vOfSOmlCiw0kDbc0pVE+Gbgy88RM8K9HJqceEMIw0Cm0Pb5ne6J8JRaxYUkg2dX0R1nz
         m0uQ==
X-Gm-Message-State: AJcUukfw6AOE6hctvdtcwav/XHbi8m+GelvdvmtWAKhHKGp3hYUrKo1C
        lssdtGvqWr6ypQyiblKzdVHOOw==
X-Google-Smtp-Source: ALg8bN451jFTqRgCxPCmDvP9hgeEmJ+6kSxwNjG0cFiI9dTaMvXfDalon4HlMxHABAJ/r3LaScrQ9g==
X-Received: by 2002:a0c:b044:: with SMTP id l4mr18081949qvc.80.1547862837029;
        Fri, 18 Jan 2019 17:53:57 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id h35sm63140168qth.59.2019.01.18.17.53.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 17:53:56 -0800 (PST)
Date:   Fri, 18 Jan 2019 20:53:55 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Hugo Lefeuvre <hle@owl.eu.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Hartman <ghartman@google.com>,
        Alistair Strachan <strachan@google.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/wait: introduce wait_event_freezable_hrtimeout
Message-ID: <20190119015355.GA115342@google.com>
References: <20190117224135.GC8100@hle-laptop.local>
 <20190118151941.GB187589@google.com>
 <20190118170801.GA4537@hle-laptop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118170801.GA4537@hle-laptop.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 06:08:01PM +0100, Hugo Lefeuvre wrote:
[...] 
> > > +/*
> > > + * like wait_event_hrtimeout() -- except it uses TASK_INTERRUPTIBLE to avoid
> > > + * increasing load and is freezable.
> > > + */
> > > +#define wait_event_freezable_hrtimeout(wq_head, condition, timeout)		\
> > 
> > You should document the variable names in the header comments.
> 
> Agree. This comment was copy/pasted from wait_event_freezable_timeout,
> should I fix it there as well?
> 
> > Also, this new API appears to conflict with definition of 'freezable' in
> > wait_event_freezable I think,
> > 
> > wait_event_freezable - sleep or freeze until condition is true.
> > 
> > wait_event_freezable_hrtimeout - sleep but make sure freezer is not blocked.
> > (your API)
> > 
> > It seems to me these are 2 different definitions of 'freezing' (or I could be
> > completely confused). But in the first case it calls try_to_freeze after
> > schedule(). In the second case (your new API), it calls freezable_schedule().
> > 
> > So I am wondering why is there this difference in the 'meaning of freezable'.
> > In the very least, any such subtle differences should be documented in the
> > header comments IMO.
> 
> It appears that freezable_schedule() and schedule(); try_to_freeze() are
> almost identical:
> 
>     static inline void freezable_schedule(void)
>     {
>         freezer_do_not_count();
>         schedule();
>         freezer_count();
>     }
> 
> and
> 
>     static inline void freezer_do_not_count(void)
>     {
>         current->flags |= PF_FREEZER_SKIP;
>     }
> 
>     static inline void freezer_count(void)
>     {
>         current->flags &= ~PF_FREEZER_SKIP;
>         /*
>          * If freezing is in progress, the following paired with smp_mb()
>          * in freezer_should_skip() ensures that either we see %true
>          * freezing() or freezer_should_skip() sees !PF_FREEZER_SKIP.
>          */
>         smp_mb();
>         try_to_freeze();
>     }
> 
> as far as I understand this code, freezable_schedule() avoids blocking the
> freezer during the schedule() call, but in the end try_to_freeze() is still
> called so the result is the same, right?
> I wonder why wait_event_freezable is not calling freezable_schedule().

It could be something subtle in my view. freezable_schedule() actually makes
the freezer code not send a wake up to the sleeping task if a freeze happens,
because the PF_FREEZER_SKIP flag is set, as you pointed.

Whereas wait_event_freezable() which uses try_to_freeze() does not seem to have
this behavior and the task will enter the freezer. So I'm a bit skeptical if
your API will behave as expected (or at least consistently with other wait
APIs).

> That being said, I am not sure that the try_to_freeze() call does anything
> in the vsoc case because there is no call to set_freezable() so the thread
> still has PF_NOFREEZE...

I traced this, and PF_NOFREEZE is not set by default for tasks.

thanks,

 - Joel


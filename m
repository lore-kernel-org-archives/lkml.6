Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC18C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E4721726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="u6lhP5JV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfAVWU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:20:59 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38325 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfAVWU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 17:20:59 -0500
Received: by mail-qt1-f195.google.com with SMTP id p17so197637qtl.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 14:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EQIsUq/WjPCU+7D5spFv+4jiuFGwbuG24v7sxTqsz88=;
        b=u6lhP5JV/uBirGyZBgegn7Rt3UCx2O69Tr3a0M/UUyZBHHI4/YHC34l3qaFb5pJsVg
         PfUZRUfH7vQr9Wsxde0p8IocqFvtdhnSDpbBno+Hjqbu+ivBZiDrP8u+Y5zJWX2a0GNj
         80R1rKderCoWTGBBzDJ6OWOHidtEOJXt2WnJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EQIsUq/WjPCU+7D5spFv+4jiuFGwbuG24v7sxTqsz88=;
        b=O7JDSlZ1K8hGzYaeQRPcZlZw8A89F5C4kkbLXNTOM7HeIXAunPCM0a+e9UKcazQO2D
         PVJX4QWXYU9EeWvllVFZF3SH/mtnT8Yr2J25cP9pO6Fv+2WUzSEdvuzI7WdWLVo1ZBz5
         +Ca072FGjqK7Yl+jTsLjKzwSHG91RR6myX5GN7CUbiUan2qsUu/eLL09CWGaE01pkux/
         T2QDiMpDV2krw+FHfCwtuwds2IsfCzHZw3lMxnfBfF/a6k3uedg0arZM2/Qs4K8ACgBV
         RohVmsq/UHt4CvK2YuwI4rdJG5sW5n5YBXrtjpAN5yFmAX7kBi6wmVMY8VCjxFDpDbDV
         VfSw==
X-Gm-Message-State: AJcUukcelVG0cKA1a3INmbu800mCz7C70hfwUysrweMs63bDQairqIUw
        A3RRKc2RZX8HGJ43eWntiS4yhQ==
X-Google-Smtp-Source: ALg8bN66JNeSnq/AXrSUv/jiOZX3F9P/e329Su6o4C4oAeedbOrGuYZjzw3jtG5WwD63jvTdivA49A==
X-Received: by 2002:a0c:ad48:: with SMTP id v8mr31077250qvc.83.1548195657730;
        Tue, 22 Jan 2019 14:20:57 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id a185sm58262440qkb.1.2019.01.22.14.20.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 14:20:55 -0800 (PST)
Date:   Tue, 22 Jan 2019 17:20:54 -0500
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
Message-ID: <20190122222054.GA37126@google.com>
References: <20190117224135.GC8100@hle-laptop.local>
 <20190118151941.GB187589@google.com>
 <20190118170801.GA4537@hle-laptop.local>
 <20190119015355.GA115342@google.com>
 <20190119102912.GA2647@hle-laptop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190119102912.GA2647@hle-laptop.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 11:29:12AM +0100, Hugo Lefeuvre wrote:
> > > as far as I understand this code, freezable_schedule() avoids blocking the
> > > freezer during the schedule() call, but in the end try_to_freeze() is still
> > > called so the result is the same, right?
> > > I wonder why wait_event_freezable is not calling freezable_schedule().
> > 
> > It could be something subtle in my view. freezable_schedule() actually makes
> > the freezer code not send a wake up to the sleeping task if a freeze happens,
> > because the PF_FREEZER_SKIP flag is set, as you pointed.
> > 
> > Whereas wait_event_freezable() which uses try_to_freeze() does not seem to have
> > this behavior and the task will enter the freezer. So I'm a bit skeptical if
> > your API will behave as expected (or at least consistently with other wait
> > APIs).
> 
> oh right, now it is clear to me:
> 
> - schedule(); try_to_freeze()
> 
> schedule() is called and the task enters sleep. Since PF_FREEZER_SKIP is
> not set, the task wakes up as soon as try_to_freeze_tasks() is called.
> Right after waking up the task calls try_to_freeze() which freezes it.
> 
> - freezable_schedule() 
> 
> schedule() is called and the task enters sleep. Since PF_FREEZER_SKIP is
> set, the task does not wake up when try_to_freeze_tasks() is called. This
> is not a problem, the task can't "do anything which isn't allowed for a
> frozen task" while sleeping[0]. 
> 
> When the task wakes up (timeout, or whatever other reason) it calls
> try_to_freeze() which freezes it if the freeze is still underway.
> 
> So if a freeze is triggered while the task is sleeping, a task executing
> freezable_schedule() might or might not notice the freeze depending on how
> long it sleeps. A task executing schedule(); try_to_freeze() will always
> notice it.
> 
> I might be wrong on that, but freezable_schedule() just seems like a
> performance improvement to me.
> 
> Now I fully agree with you that there should be a uniform definition of
> "freezable" between wait_event_freezable and wait_event_freezable_hrtimeout.
> This leaves me to the question: should I modify my definition of
> wait_event_freezable_hrtimeout, or prepare a patch for wait_event_freezable ?
> 
> If I am right with the performance thing, the latter might be worth
> considering?
> 
> Either way, this will be fixed in the v2.

I agree, it is probably better to use freezable_schedule() for all freeze
related wait APIs, and keep it consistent. Your analysis is convincing.

Peter, what do you think?

> > > That being said, I am not sure that the try_to_freeze() call does anything
> > > in the vsoc case because there is no call to set_freezable() so the thread
> > > still has PF_NOFREEZE...
> > 
> > I traced this, and PF_NOFREEZE is not set by default for tasks.
> 
> Well, I did not check this in practice and might be confused somewhere but
> the documentation[1] says "kernel threads are not freezable by default.
> However, a kernel thread may clear PF_NOFREEZE for itself by calling
> set_freezable()".
> 
> Looking at the kthreadd() definition it seems like new tasks have
> PF_NOFREEZE set by default[2].
> 
> I'll take some time to check this in practice in the next days.
> 
> Anyways, thanks for your time !

Yeah, no problem.

thanks,

 - Joel

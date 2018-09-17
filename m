Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E5BECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4F92147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE4F92147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbeIRCjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 22:39:16 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34393 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbeIRCjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 22:39:14 -0400
Received: by mail-oi0-f66.google.com with SMTP id 13-v6so20315710ois.1;
        Mon, 17 Sep 2018 14:10:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wn6/2z4zlAOhpUBscoDfHx16LguhclKxj7pRk8ePZ4k=;
        b=AKOF3FvJZVAR+Pcsw3fYC9gR4yNX6KkYn7dddBI1S7HR3EQhaZdZcBYqugjxPjvuRx
         PL14J0U9XA8dDOXXkbYzk3qzvuYF8XNy7SMGbE8hooymSe9syTbPtI6ZI1zt37ITytj7
         rZJqP8vzWiqGj1/ElIzFxASJbhBxUK540lv2vI6miH72gw4BLG1IIgzOvv1nIKgoto5i
         88r5y67nb2NrGuUE1Pr2O1gHsdR+kPUjCmwEk7kiCMGQfeQluK+n6zVXOVpScnKWWBLC
         0Icwoo84/B7v595v6afgBFjiGzXbyfEnBW1eEz6WRyHN2iDvMsffAF/aVQBlYHcfPPO8
         iQRw==
X-Gm-Message-State: APzg51DKo8026yknotcF7cZzYfi865GFJ93NYThOEwQ8PveyRHq3VmJy
        eR+ZPYJ50Mw1qgqjiUt2JKhvC+TggGd01k13ILVdfg==
X-Google-Smtp-Source: ANB0VdbMfOrD93byZ2I8V9S1s9GRtHrvClHPKTobhY/CfluV6/+uAf18L3P0FoQmxaQ/TjyoBs3a6a/+ZN5+1uCC1D8=
X-Received: by 2002:aca:e6d4:: with SMTP id d203-v6mr18838292oih.311.1537218609959;
 Mon, 17 Sep 2018 14:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180913160851.18169-1-vkuznets@redhat.com> <4793718.OcKebjM5bH@aspire.rjw.lan>
 <87d0tg88l3.fsf@vitty.brq.redhat.com> <20180914162103.GA11171@redhat.com>
 <CAJZ5v0jpK-KWE7Pv1fKAWFXweW7jNH26fFDM=sXMPRNPJ96u7g@mail.gmail.com> <20180917165518.GA25931@redhat.com>
In-Reply-To: <20180917165518.GA25931@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 17 Sep 2018 23:09:58 +0200
Message-ID: <CAJZ5v0h9zPofaJCxshZgcEuBDELDKS4e4oQAn9m8KmNCdFR1eQ@mail.gmail.com>
Subject: Re: [PATCH] kernel/hung_task.c: disable on suspend
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 6:55 PM Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 09/17, Rafael J. Wysocki wrote:
> >
> > On Fri, Sep 14, 2018 at 6:21 PM Oleg Nesterov <oleg@redhat.com> wrote:
> > >
> > > > > Since you are adding the notifier anyway, what about designing it to make
> > > > > the thread wait on _PREPARE until the notifier kicks it again on exit
> > > > > fron suspend/hibernation?
> > >
> > > Well. I agree that freezable kthreads are not nice, but it seems you are
> > > going to add another questionable interface ;)
> >
> > Why would it be questionable?
> >
> > The watchdog needs to be disarmed somehow before tasks are frozen and
> > re-armed after they have been thawed or it may report false-positives
> > on the way out.  PM notifiers can be used for that.
>
> Or watchdog() can simply use set_freezable/freezing interface we already
> have, without additional complications.
>
> Yes, this is not "before tasks are frozen", but probably should work?

Well, not really.

It is a kernel thread and therefore it is frozen after all user space
and thawed before it.

> OK, I won't argue.
>
> > > Where does the caller of pm_suspend() sleep in D state? Why it sleeps more
> > > than 120 seconds?
> >
> > It need not be sleeping for over 2 minutes, but if suspend-to-idle
> > advances the clock sufficiently, the watchdog will regard that as the
> > task sleep time.
>
> As I already said, I don't understand this magic, so you can ignore me.

Suspend-to-RAM suspends timekeeping (among other things) on the way to
system-wide suspend and resumes it on the way back to the working
state.  The time between those two events is not added to the
monotonic clock and jiffies is not updated while timekeeping is
suspended. As a result, the new jiffies value doesn't include the time
when the system is in the sleep state.  In that case the 2 minutes
interval is more than enough to cover the two system transitions (into
system-wide suspend and back) and the sleep time doesn't count.

Suspend-to-idle, OTOH, only suspends timekeeping when the last CPU
goes idle and resumes it when the first CPU is woken up.  That may
take place for multiple times in a row while the system is regarded as
suspended, due to spurious wakeups.  While the time when timekeeping
is suspended still doesn't count (the monotonic clock is not advanced
and jiffies is not updated then), the time when at least one CPU is
not idle counts.  Hence, if the system is in suspend-to-idle for a
sufficiently long time and there are sufficiently many spurious
wakeups during that period, the monotonic clock and jiffies may be
advanced by over 2 minutes while the system is regarded as suspended.

> But again, it would be nice to explain this in the changelog, I mean, how
> exactly (and why) jiffies can grow for over 2 minutes in this case.

Agreed, the changelog should explain that.

> > > And. given that it takes system_transition_mutex anyway, can't it use
> > > lock_system_sleep() which marks the caller as PF_FREEZER_SKIP (checked
> > > in check_hung_task()) ?
> >
> > Well, it could, but that would be somewhat confusing and slightly
> > abusing the flag IMO.
>
> OK, I won't insist.

OK :-)

Cheers,
Rafael

Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FADC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704FC218D0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551224468;
	bh=qf/RvSfES8AyAd0/pTnfjk+dQZ4NGLkCF/jmPmBylyY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ica04h3smbMCTMR8vFOzaBV40YWn/Vp3eIV9xROz40kKfrcwwoob6FEfbkQ3nzpJT
	 ZciS3MZC0eEansDEpOii3OXQpOtQ2tlXKo8I5GOujB/t97O+CKpGbGLoy/zU186LGV
	 BKIDK71En5RPuVKoWrxP5A5XJARoAcBDVtKLvIy8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbfBZXlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 18:41:07 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42395 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbfBZXlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 18:41:06 -0500
Received: by mail-oi1-f193.google.com with SMTP id s16so11915437oih.9;
        Tue, 26 Feb 2019 15:41:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=epJM6HtzQ2OfC7XTiRTHdv/WmhwMHpOkziIIKw/BBW8=;
        b=fTjq5NomyFaOoEbdSpCXWJGve0Ym0JrRT84j4zIdlFuh2okCeUSqNG/+i5RbnS+O5L
         qKyWqcaD79alHcLMxFSVzx2XgCQBpCMQGrgmqgIEt05m0z014ZktTQasTJP2IRK8EEUZ
         o3IXXJwvG2LJMR1+HkFKCZLQk5L7VzrxG2ZmUofva06yxV9rM9yhv7tqmoDEDNsaNqFI
         tDLxc6IJSlboluvdXmAJvq3z3JYE0eTohzdjf9GkjRrmgVuWpwAxfQ1NShgf65bmFcAY
         eah9mgRetQH4RTwIf7M7IzYlJC1qnhv+5o6wUcy9HMz1MmMjG7BkJYhAeSmEAHA1flD/
         dOxw==
X-Gm-Message-State: AHQUAuYjKLwTR7p3ieEpSs1QQ+4Ma4I6d2taEdZ+I14sj/1j9NUQBmEc
        uPXrlYMwyCsiPtcwI0daGv5HuSTTizdnTwu5PrE=
X-Google-Smtp-Source: AHgI3IbjPplUAm+aVWnmZI5/MQeCGYPCjW+5hu1qhcjl2DYuTYQwAA3fyJg5KHjdxJ/Q7i15gvFLTECKDuiSOMCgA/U=
X-Received: by 2002:aca:f4d3:: with SMTP id s202mr3998542oih.178.1551224465277;
 Tue, 26 Feb 2019 15:41:05 -0800 (PST)
MIME-Version: 1.0
References: <20190226145415.19411-1-ulf.hansson@linaro.org>
 <20190226145415.19411-8-ulf.hansson@linaro.org> <CAJZ5v0j=ddMEwvr8rt=PxxPpxoAHary7cYLYgTBbcuBuiGbTZA@mail.gmail.com>
 <CAPDyKFoFmnxWo7XhvAeB08xkDzSqUsmX_Zr=Zh6cmJWq=++0_Q@mail.gmail.com>
In-Reply-To: <CAPDyKFoFmnxWo7XhvAeB08xkDzSqUsmX_Zr=Zh6cmJWq=++0_Q@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 Feb 2019 00:40:53 +0100
Message-ID: <CAJZ5v0hPiQe_mrPAAqRwTTdb-X4=-WQAdfC-peWb9zsc_wU5yw@mail.gmail.com>
Subject: Re: [PATCH v11 7/8] cpuidle: Pre-store next timer/tick before
 selecting an idle state
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 12:16 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 26 Feb 2019 at 23:08, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Feb 26, 2019 at 3:54 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > A common piece of data used by cpuidle governors, is the information about
> > > when the next timer/tick is going to fire. Rather than having each governor
> > > calling tick_nohz_get_next_timer|hrtimer() separately, let's consolidate
> > > the code by calling these functions before invoking the ->select() callback
> > > of the governor - and store the output data in the struct cpuidle_device.
> >
> > That misses the point IMO.
> >
> > You don't need to store two values in struct cpuidle_device, but just
> > one, and not before running ->select(), but before invoking the
> > driver's ->enter() callback.
>
> Okay! Thanks for letting me know!
>
> >
> > At that point, the decision on whether or not to stop the scheduler
> > tick has been made already and it should be sufficient to store the
> > return value of tick_nohz_get_next_hrtimer() introduced by patch
> > [3/8], because that value represents the next timer regardless of what
> > has been decided with respect to the tick.
>
> Just to make sure I get this correctly, because it seems like I have
> missed a few points here....
>
> If we decided to keep the tick running, then
> tick_nohz_get_next_hrtimer() gives the next tick or the next hrtimer,
> whatever that comes first. There are no other timer that can expire
> earlier than this, right!?
>
> If we decided to stop the tick, then tick_nohz_get_next_hrtimer() will
> give us the next hrtimer. Again, then there are no other timer that
> can't expire earlier than this, right!?

Right in both cases.

IOW, that is the event that will wake up the CPU unless any other
(non-timer) interrupts (or equivalent events) occur in the meantime.

> >
> > And you won't need the tick_nohz_get_next_timer() any more then.
>
> Alright, this kind of brings this hole thing back closer to v10 - and
> then we should stick to use tick_nohz_get_sleep_length() as is for the
> cpuidle governors. That is what you are saying?

For the menu and teo governors - yes.  IMO
tick_nohz_get_sleep_length() is as good as it gets in there.

Cheers,
Rafael

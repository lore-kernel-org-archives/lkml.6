Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18414C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07E620861
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07E620861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeIETuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:50:32 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:44137 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeIETuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:50:32 -0400
Received: by mail-ua1-f67.google.com with SMTP id m11-v6so6081531uao.11;
        Wed, 05 Sep 2018 08:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A5ShTxmYlAi3VGjNLkpVICEssMioNtljehLiWA3JiRg=;
        b=Z46M0+4+DO5OOtRm7IsY00AgGdCyA4xWZ0hAhUVTcVHaMuY1QjL4YaY6T9rMxT3oUz
         Hhe/oikJhlNuDg/j05GPuU7r0E4MJCKhF45IF5pKDhKsNTXaNEf+JUesYLd9HxRuLOR/
         l2t3tCDG3nbQrffebPh3RSrlAlOxzSeRvvZyDG6uibQcmedG+2m7xJGx2dJl+eA9NOlP
         brSclUR6zpj0/EEZpSlME6qQMWCuMT1HJrNRd70ZW6tOYANiyUTwSgRLGTFIbjAIhYwL
         w7/W/wCqUFNYQK2ZUxbBixup18vEwMKvLn186uzVo7lESpyj0XbN6bIQCsQ/ArJn/HuK
         39Ug==
X-Gm-Message-State: APzg51Ccy1wR6rpPHG5Ebr17DLqietaCnMsLoHGRGkhgZnKOfgI+csHk
        LIXYYDC1yvwx6/dN894nadM55l7egPLf3WzUgh8=
X-Google-Smtp-Source: ANB0VdY+Vf/ur6bcD0KSo4NEsOV/rpOLL2QBw4qYtDaliuknYQpgvCk5Xbs/fjufZu6n9Z77o3GGPCE/fRLfwPvD3IU=
X-Received: by 2002:a67:4c93:: with SMTP id h19-v6mr5090535vsg.36.1536160791874;
 Wed, 05 Sep 2018 08:19:51 -0700 (PDT)
MIME-Version: 1.0
References: <1536042803-6152-1-git-send-email-neeraju@codeaurora.org>
 <alpine.DEB.2.21.1809051244500.1416@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1809051419580.1416@nanos.tec.linutronix.de> <20180905145353.GA14069@e107155-lin>
In-Reply-To: <20180905145353.GA14069@e107155-lin>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 5 Sep 2018 17:19:40 +0200
Message-ID: <CAMuHMdUEVt0JW6XV9zOx53Rv3C9Za-5hjg=J6TpWgUxHWcctjQ@mail.gmail.com>
Subject: Re: [PATCH] cpu/hotplug: Fix rollback during error-out in takedown_cpu()
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, dzickus@redhat.com,
        Brendan Jackman <brendan.jackman@arm.com>,
        Mathieu Malaterre <malat@debian.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sramana@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

Thanks for the CC!

On Wed, Sep 5, 2018 at 4:54 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> On Wed, Sep 05, 2018 at 02:23:46PM +0200, Thomas Gleixner wrote:
> > On Wed, 5 Sep 2018, Thomas Gleixner wrote:
> > > On Tue, 4 Sep 2018, Neeraj Upadhyay wrote:
> > > >   ret = cpuhp_down_callbacks(cpu, st, target);
> > > >   if (ret && st->state > CPUHP_TEARDOWN_CPU && st->state < prev_state) {
> > > > -         cpuhp_reset_state(st, prev_state);
> > > > +         /*
> > > > +          * As st->last is not set, cpuhp_reset_state() increments
> > > > +          * st->state, which results in CPUHP_AP_SMPBOOT_THREADS being
> > > > +          * skipped during rollback. So, don't use it here.
> > > > +          */
> > > > +         st->rollback = true;
> > > > +         st->target = prev_state;
> > > > +         st->bringup = !st->bringup;
> > >
> > > No, this is just papering over the actual problem.
> > >
> > > The state inconsistency happens in take_cpu_down() when it returns with a
> > > failure from __cpu_disable() because that returns with state = TEARDOWN_CPU
> > > and st->state is then incremented in undo_cpu_down().
> > >
> > > That's the real issue and we need to analyze the whole cpu_down rollback
> > > logic first.
> >
> > And looking closer this is a general issue. Just that the TEARDOWN state
> > makes it simple to observe. It's universaly broken, when the first teardown
> > callback fails because, st->state is only decremented _AFTER_ the callback
> > returns success, but undo_cpu_down() increments unconditionally.
> >
> > Patch below.
>
> This patch fixes the issue reported @[1]. Lorenzo did some debugging and
> I wanted to have a look at it at some point but this discussion drew my
> attention and sounded very similar[2]. So I did a quick test with this
> patch and it fixes the issue.

> [1] https://lore.kernel.org/lkml/CAMuHMdVg868LgL5xTg5Dp5rReKxoo+8fRy+ETJiMxGWZCp+hWw@mail.gmail.com/
> [2] https://lore.kernel.org/lkml/20180823131505.GA31558@red-moon/

Thomas' patch fixes the issue for me:
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

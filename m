Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3634AC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68F221470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E68F221470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbeJDOpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:45:49 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42149 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbeJDOps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:45:48 -0400
Received: by mail-ot1-f67.google.com with SMTP id h26-v6so8255293otl.9;
        Thu, 04 Oct 2018 00:53:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GDx4p5DFZ9XPKXannRc4MFzWbtLPe7XcgronuugR8Xw=;
        b=KSnzAKhaiNQDUMmoZdcC10+3lApKHDiu3zw14HPVmBtfWC7QbNm01ADvogfH3cNkyD
         ukJDiICN3ks7BvR8xbzM331sDXBG30Onz7zk+jMmCyboZJ6SY3haGSpIj6FZTOiA0OxZ
         KWI1rqJVNgj0nuZ4uXSjYyLYP6Lmi21dcOhcvu4GSu334hTTeRWTT+64gfa8QWqZsYm/
         c16ZKXLl90xgtUv8REH3W/OiDoF3JUB/JiNV7CwAHBISaACji4lIIRIQ+3uptJ5WxrTv
         b//FNfOBr2Q514/sFKAMh4bO+ughLGafTJZEF0msrM6KgZM9+rZ1Xs444vD3VEa2bAEU
         nIxA==
X-Gm-Message-State: ABuFfoju3WX4qP79pgbB0hTnKVjewgZPrOQ9TpDxJBKKHQwPTkCxYCZx
        RWpZksIILgi8b7Vr6fZ6Gc8R/FE9sLmwoBEezn8SWDTU
X-Google-Smtp-Source: ACcGV618RVqsiIWgEclyULb0hws3OaXE0It+jOPTm3w9R7HjBxgvAVh5pUJ4t319R/gU+YAge95JFujnsvHVdrsv3OU=
X-Received: by 2002:a9d:7303:: with SMTP id e3-v6mr2784012otk.124.1538639630361;
 Thu, 04 Oct 2018 00:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <3510260.hvypppS8Bs@aspire.rjw.lan> <4130376.2FFt7p4687@aspire.rjw.lan>
 <20181004074627.GE19272@hirez.programming.kicks-ass.net>
In-Reply-To: <20181004074627.GE19272@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 Oct 2018 09:53:39 +0200
Message-ID: <CAJZ5v0gvAOz7R8uwXy=37ni=+dz9-gb69S2M2PtZSXc+tUhxrQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] cpuidle: menu: Get rid of first_idx from menu_select()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 9:46 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Oct 02, 2018 at 11:44:06PM +0200, Rafael J. Wysocki wrote:
> >       idx = -1;
> > -     for (i = first_idx; i < drv->state_count; i++) {
> > +     for (i = 0; i < drv->state_count; i++) {
> >               struct cpuidle_state *s = &drv->states[i];
> >               struct cpuidle_state_usage *su = &dev->states_usage[i];
> >
> >               if (s->disabled || su->disable)
> >                       continue;
> > +
> >               if (idx == -1)
> >                       idx = i; /* first enabled state */
> > +
> >               if (s->target_residency > predicted_us) {
> > +                     /*
> > +                      * Use a physical idle state, not busy polling, unless
> > +                      * a timer is going to trigger really really soon.
> > +                      */
> > +                     if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
> > +                         i == idx + 1 && latency_req > s->exit_latency &&
> > +                         data->next_timer_us > max_t(unsigned int, 20,
> > +                                                     s->target_residency)) {
>
> Not new in this patch, but this is where I really noticed it; that 20,
> should that not be something like: POLL_IDLE_TIME_LIMIT / NSEC_PER_USEC
> ?

The POLL_IDLE_TIME_LIMIT is how much time we allow it to spin in
idle_poll() and I'm not sure it is related.  Besides, I want it to go
away actually (https://patchwork.kernel.org/patch/10624117/).

I could use a separate symbol for this particular magic number, but it
has been magic forever and it is used just in this one place, so ...

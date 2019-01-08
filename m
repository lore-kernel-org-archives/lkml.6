Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FC7C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C652087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UsGIUpO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfAHQmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:42:22 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40582 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbfAHQmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 11:42:21 -0500
Received: by mail-it1-f193.google.com with SMTP id h193so6846097ita.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 08:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T77jOpgl5kT9nsJy++gxqYvIqefMlA9GSijxs1pT/Wg=;
        b=UsGIUpO+pD7kOlewF36d5G4TyyYE5FO+ZOSdX+U84B8FptCA8y9qf45KISLT6lSGay
         4dWiWRMWrovQ3OLKBTsPSLwyrff2S66LvaP0lk55hunhTxMEO34/1BIL+gB8y82xFpaH
         gAKqC/x8LGRkTGv4XqxXcoAFae6c3ptqQ5ASo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T77jOpgl5kT9nsJy++gxqYvIqefMlA9GSijxs1pT/Wg=;
        b=o2dKTo1WMGWdMkRUwk7NRnd8QWVVR4U2SAkQA3eqF4W9LxBJQP0c6wre9D4hyog/Og
         UmSdGFe95qofARsXLfFzpwlbycIrsWiJGMDG4f/rrwRRBt0nwcV0B+AMh4TxUAQF9l2q
         AwVsJMVql79c9v7lIYkNa7jmm8FTOBs6p+Z6hcgQEfO0WVM771sVszRe3OLWirNcq4wu
         4m2jp6N/QLUBKOc6cXpXo/8636eyzMJabm8kaZ/BKNimCVHwFqQRMrrpaR7hrvBXGfWz
         bs3OECTgwQw8SCaCJ0q7VCRifh7xIsEB4c3jQgqaDqjp1n85s9hdN/KFCCdQXDMelin6
         3ItQ==
X-Gm-Message-State: AJcUuke3gRYdFq5+T36I9xc+Nugf8q8o+gcC/tozs1u9TI7H/fk8Jmxx
        tAJEdA62K9BlyTQYHsjNo1rZQ/9Ps0kuRWeu8YSrrg==
X-Google-Smtp-Source: ALg8bN6sUDFH6KY+3686EvHTI7eBltskRImQF9pWoUDC40g+tyMtE62dltvynnZjCHtIeLooeCD66UjdGTanvqRjfyE=
X-Received: by 2002:a05:660c:a8f:: with SMTP id m15mr1741799itk.114.1546965740395;
 Tue, 08 Jan 2019 08:42:20 -0800 (PST)
MIME-Version: 1.0
References: <20190107233833.GI5544@atomide.com> <CAKfTPtDBEmcsLotp-6K1KU1wM9Ba1EpMp3niXScRxYgzjs0nog@mail.gmail.com>
 <20190108155354.GL5544@atomide.com>
In-Reply-To: <20190108155354.GL5544@atomide.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 8 Jan 2019 17:42:09 +0100
Message-ID: <CAKfTPtCoOK-cYLXJ--sOfpVa9RVmzOAEN1+zB2qHMCzkJN0qaQ@mail.gmail.com>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
To:     Tony Lindgren <tony@atomide.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2019 at 16:53, Tony Lindgren <tony@atomide.com> wrote:
>
> * Vincent Guittot <vincent.guittot@linaro.org> [190108 08:00]:
> > Hi Tony,
> >
> > On Tue, 8 Jan 2019 at 00:38, Tony Lindgren <tony@atomide.com> wrote:
> > >
> > > Hi all,
> > >
> > > Looks like commit 8234f6734c5d ("PM-runtime: Switch autosuspend
> > > over to using hrtimers") caused a regression on at least
> > > omap5-uevm where 8250 UART rx wake no longer works. I have not
> > > noticed this happening on others so far.
> > >
> > > The devices I've tested all are using 8250 with dedicated
> > > wakeirqs configured for the rx pin. I can see the interrupt
> > > increase on omap5-uevm after some one or more keypresses,
> > > but then nothing. It seems that the uart just falls back
> > > asleep right away or something.
> > >
> > > Any ideas what might be going wrong?
> >
> > What is the autosuspend value ? Can it be that the autosuspend is set
> > to a short value but was finally greater than 10-20ms on arm32. And
> > now the autosuspend happens before and this has changed the sequence ?
>
> It's set to 3 seconds. The difference between let's say
> C-A9 pandaboard (that is working) compared to C-A15 omap5-uevm
> is that the C-A15 has arch_timer in use. Other than that things
> should behave more or less the same way.
>
> Hmm so could it be that we now rely on timers that that may
> not be capable of waking up the system from idle states with
> hrtimer?

With nohz and hrtimer enabled,  timer relies on hrtimer to generate
the tick so you should use the same interrupt.

>
> Regards,
>
> Tony
>

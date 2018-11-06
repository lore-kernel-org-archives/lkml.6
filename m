Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52F8C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5CB20827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5CB20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731053AbeKGJH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 04:07:27 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46214 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730409AbeKGJH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 04:07:26 -0500
Received: by mail-oi1-f196.google.com with SMTP id k64-v6so12314877oia.13;
        Tue, 06 Nov 2018 15:39:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S2KO6+1RSyzau/C640jmqGihOk9pii2ENU5KaGY+YZ0=;
        b=ZuvrVWFcTf+Mbeltbkd/zMGQORenPH0aYwfAwqY63rJ8IOVEtVlSRsiX/3xQ/c1UhL
         hoo1xmCID0Yfw8a5hv0d5r49dtvFMjn+HtY3WYehDz7A4LLGIc4mbV+VcvjX5V4sgsd7
         UI/L7fYx2sXc+8U2pwIUZjTgqJXp2i0RKjJyQQbueWz6a0qT+EtMBLgVg/0mCMgCCmK2
         edRScoyUkzl3CfEvNIB2zlmmBDEFuo1DMTZwZJJwr85rW6W6MEZ+6+Dmiho9qdfqtqvH
         8FxaqAf1P87u24dN2d1Hxspnd+FznthVEL8M/5DZWVXG2x1FTzc+wDDuEXa2O3ngNgQZ
         E/QA==
X-Gm-Message-State: AGRZ1gKsC1VrZdaF7jyPcrGEFy/+JjqjGb+VEHbt51LWkoYEwk06coSX
        EuCeEBvJAIt/Nlc0xlGRMQXAcxQKMeKagMqI90yOGpjf
X-Google-Smtp-Source: AJdET5dgIdxbfxxUEzedWFnWVEewAfGn/rjxm5WRFJ2UiwECOLlraXpbCOL1lLdscf9PgIOGsCrFda8OOrPlozx3m+I=
X-Received: by 2002:aca:afd0:: with SMTP id y199-v6mr15481629oie.322.1541547583534;
 Tue, 06 Nov 2018 15:39:43 -0800 (PST)
MIME-Version: 1.0
References: <1556808.yKVbhZSazi@aspire.rjw.lan> <20181106170442.GC9781@hirez.programming.kicks-ass.net>
 <CAJZ5v0hmm2UWRt1j6hQo14nZLgPrE3DZkOznfo2kMxsZ1spo-Q@mail.gmail.com> <20181106195127.GD9781@hirez.programming.kicks-ass.net>
In-Reply-To: <20181106195127.GD9781@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 7 Nov 2018 00:39:31 +0100
Message-ID: <CAJZ5v0iPs8Wt0PneBVWptqJPP6dEze+=GvxjU=dHBRbmty+kOw@mail.gmail.com>
Subject: Re: [RFC/RFT][PATCH v3] cpuidle: New timer events oriented governor
 for tickless systems
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 8:51 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Nov 06, 2018 at 07:19:24PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Nov 6, 2018 at 6:04 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > Instead of this detector; why haven't you used the code from
> > > kernel/irq/timings.c ?
> >
> > Because it doesn't help much AFAICS.
> >
> > Wakeups need not be interrupts in particular
>
> You're alluding to the MWAIT wakeup through the MONITOR address ?

Yes.

> > and interrupt patterns that show up when the CPU is busy may not be
> > relevant for when it is idle.
>
> I think that is not always true; consider things like the periodic
> interrupt from frame rendering or audio; if there is nothing more going
> on in the system than say playing your favourite tune, it gets the
> 'need more data soon' interrupt from the audio card, wakes up, does a little
> mp3/flac/ogg/whatever decode to fill up the buffer and goes back to
> sleep. Same for video playback I assume, the vsync interrupt for buffer
> flips is fairly predictable.
>
> The interrupt predictor we have in kernel/irq/timings.c should be very
> accurate in predicting those interrupts.

In the above case the interrupts should produce a detectable pattern
of wakeups anyway.

In general, however, I need to be convinced that interrupts that
didn't wake up the CPU from idle are relevant for next wakeup
prediction.  I see that this may be the case, but to what extent is
rather unclear to me and it looks like calling
irq_timings_next_event() would add considerable overhead.

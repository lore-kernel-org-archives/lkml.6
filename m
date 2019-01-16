Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88646C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3925F20840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547676404;
	bh=ziqRfkLiUoU3PFhv6ezHMx+Es4ETWd7hMUwjBlTz4ac=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=G4xYjX9j4n/ycKhZ4/D5e8j5XYni0bicjZiTJamBdZtNu1RUVkUhiQtgatZ4yNXCh
	 /FEfBY3LJPUDdI+NF+2UmacALRm9bHwk7xX1kZEVwZDdoAL/YJtkOB8H3rq22Pp+23
	 WHEZldi36DZysGZtBgBGn5ao2xHsP9GQx5sLEEnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733097AbfAPWGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:06:42 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33941 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730743AbfAPWGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:06:41 -0500
Received: by mail-ot1-f67.google.com with SMTP id t5so4216752otk.1;
        Wed, 16 Jan 2019 14:06:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/xubJhtAPHRyUOogVDFNJWyza99JJZxK/ZoUQ5e6gbo=;
        b=FQYu0/LZDEG3Z1q1aODuJuGhXFAJDhn+yYG1r+CRj1c+46KLrSMXXghzbysEzLkzg4
         G80O6+W2x8hfFZs2neZ1aMGxNr3WWmKH1cxPVHqly+xHeEsC0gqw6fdYVxtUn4QxcM/t
         ukqpOFinsxwTKy/KsWq8ZOxx8lby106cpD8ln0nqmulkXxMAbVzOjnaWJCfGx1FUcqFU
         4zLLiHVJIApYZnUsMS1QNi+zdxPSYGgoTzAF6wy37bqYlKy7KAheW3Lvml6M/Zch76Im
         N0LiEPhAtRF7fqmGVtIGDQJ3tVYCJd7ryYAFg7VXIjnEHSs6AVEaJyOU1dEe0EglDSVV
         grkA==
X-Gm-Message-State: AJcUuke3HOTmqrtxy0tngzixVtc560fcClrEy7UY6TwD5n3gJPIIjgj4
        aDYhj6LVZINbEKGQkasPSxmzJgenbygJd7iFZkc=
X-Google-Smtp-Source: ALg8bN7yt9QCvp2nkDGcS6GGrYc/Ju25VjpiEmNhSMFr9WMpF2xwdFHrziVT7jwxRq8QWxE+3RD1AzJIh9TuX3e8w0Y=
X-Received: by 2002:a9d:4c84:: with SMTP id m4mr6526894otf.124.1547676400306;
 Wed, 16 Jan 2019 14:06:40 -0800 (PST)
MIME-Version: 1.0
References: <3625809.WY5lk7ujeb@aspire.rjw.lan> <2138748.C3tVedyW9D@aspire.rjw.lan>
 <7ce53e4d-69ca-f7a5-5880-21999d926d3d@linaro.org>
In-Reply-To: <7ce53e4d-69ca-f7a5-5880-21999d926d3d@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 16 Jan 2019 23:06:29 +0100
Message-ID: <CAJZ5v0gLzX3c6o6wA9dXg7Wa00+CgaOG4aDQD=7x7UzuuzdegQ@mail.gmail.com>
Subject: Re: [PATCH v11] cpuidle: New timer events oriented governor for
 tickless systems
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>, "Chen, Hu" <hu1.chen@intel.com>,
        Quentin Perret <quentin.perret@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 1:22 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 16/01/2019 13:03, Rafael J. Wysocki wrote:
> > On Friday, January 4, 2019 12:30:47 PM CET Rafael J. Wysocki wrote:
> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> The venerable menu governor does some things that are quite
> >> questionable in my view.
> >>
> >> First, it includes timer wakeups in the pattern detection data and
> >> mixes them up with wakeups from other sources which in some cases
> >> causes it to expect what essentially would be a timer wakeup in a
> >> time frame in which no timer wakeups are possible (because it knows
> >> the time until the next timer event and that is later than the
> >> expected wakeup time).
> >>
> >> Second, it uses the extra exit latency limit based on the predicted
> >> idle duration and depending on the number of tasks waiting on I/O,
> >> even though those tasks may run on a different CPU when they are
> >> woken up.  Moreover, the time ranges used by it for the sleep length
> >> correction factors depend on whether or not there are tasks waiting
> >> on I/O, which again doesn't imply anything in particular, and they
> >> are not correlated to the list of available idle states in any way
> >> whatever.
> >>
> >> Also, the pattern detection code in menu may end up considering
> >> values that are too large to matter at all, in which cases running
> >> it is a waste of time.
> >>
> >> A major rework of the menu governor would be required to address
> >> these issues and the performance of at least some workloads (tuned
> >> specifically to the current behavior of the menu governor) is likely
> >> to suffer from that.  It is thus better to introduce an entirely new
> >> governor without them and let everybody use the governor that works
> >> better with their actual workloads.
> >>
> >> The new governor introduced here, the timer events oriented (TEO)
> >> governor, uses the same basic strategy as menu: it always tries to
> >> find the deepest idle state that can be used in the given conditions.
> >> However, it applies a different approach to that problem.
> >>
> >> First, it doesn't use "correction factors" for the time till the
> >> closest timer, but instead it tries to correlate the measured idle
> >> duration values with the available idle states and use that
> >> information to pick up the idle state that is most likely to "match"
> >> the upcoming CPU idle interval.
> >>
> >> Second, it doesn't take the number of "I/O waiters" into account at
> >> all and the pattern detection code in it avoids taking timer wakeups
> >> into account.  It also only uses idle duration values less than the
> >> current time till the closest timer (with the tick excluded) for that
> >> purpose.
> >
> > Given the lack of negative feedback and my confidence in this, I'm
> > queuing it up for 5.1.
>
> Yeah, this governor was not proposed in the better moment for review for
> me :/
>
> I agree writing a new governor is certainly simpler than revisiting the
> menu governor again. That is the advantage of the governors, we can add
> more of them suiting the needs.
>
> If you are confident and Doug bench-marked it showing better results
> than the menu governor on x86, I don't see any reason to not merge it.
>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thank you!

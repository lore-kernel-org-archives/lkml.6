Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB80C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A91206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="IeON+W7j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A91206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbeLDTd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:33:58 -0500
Received: from mail-lj1-f172.google.com ([209.85.208.172]:34748 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbeLDTd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:33:57 -0500
Received: by mail-lj1-f172.google.com with SMTP id u6-v6so16037528ljd.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 11:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0v1PwKxmmsTkB8PjeALCaZBS0XNbiV4V2qeuZmJerjs=;
        b=IeON+W7jCdYuUXnDE0SU5AmweOANdxgDFSNoGU3gJ/BxMk7YxV8fbPE/CcEzXtaJ8Q
         dX75XmBHdTlPKtytVWCgzGrs2A/MMDUOwqLOe+3JQzAqAdoxk8xupa0fa6/yeeBNz6hi
         GB6Mv7MS4UQacr0iwerEeL9y4dMLqF/2BnzAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0v1PwKxmmsTkB8PjeALCaZBS0XNbiV4V2qeuZmJerjs=;
        b=k8V4pJhjQduPLgLpa2surbcthMJrLxgM6c0P5+KzWneB4Ep3RAzDqpQPf7rpkCyOnx
         cGzWT7Cdjw5p1hf4reQ7WQuDyHo3JdEJB61tANNJF+3HlaQAyltEZjxOyO80KQ5JaO1t
         bvE+IU/8raSTN7aRbU1M36xouFSGx6DPbOT4/nNbOyasduWjtnTAJZFRruMWmVT3FLcO
         Ll7CwtIa/5/vKW7GW7iHGoK4fhAsKxpZ+z2Is9pBMIc04B/mS4ehLkNYdtEg7sIis/nc
         lEkEqfGCMzKlF1FB3cLazoxyrd7l3MhVjd9N9+1FbXvIjJM4YmYJfNGE/KBSzTtsKupk
         RQYw==
X-Gm-Message-State: AA+aEWaA0HLpF4xRnXkMmx8XEYihFEq7guYMaSQPqSz1x88OWMSHWEsE
        EkR26J5KJa5Eltqo6qo17JSOBQT+k5f0hNk4SkprJw==
X-Google-Smtp-Source: AFSGD/Vb0JinOVIa7YWhwgLpd4aon5430RrR8lc6je2RsMIoIVWnyIxRHi0pKxOlmnNxGHQPhEzpvXLhPZMMWNCyK2M=
X-Received: by 2002:a2e:5d12:: with SMTP id r18-v6mr15100382ljb.89.1543952035629;
 Tue, 04 Dec 2018 11:33:55 -0800 (PST)
MIME-Version: 1.0
References: <20181130211750.5571-1-roland@purestorage.com> <alpine.DEB.2.21.1812041237460.8181@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1812041237460.8181@nanos.tec.linutronix.de>
From:   Roland Dreier <roland@purestorage.com>
Date:   Tue, 4 Dec 2018 11:33:43 -0800
Message-ID: <CAL1RGDV_f8_sDMrK6rUq1P-xh-=E0xwphPo0bQ6tHSnJk6JQmw@mail.gmail.com>
Subject: Re: [PATCH] clocksource: Add heuristics to avoid switching away from
 TSC due to timer delay
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     john.stultz@linaro.org, sboyd@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>                  /*
>                   * Proper multiline comments look like this not like
>                   * the above.
>                   */

Got it, will fix next time around.

> That aside. Why are you trying to do heuristics on the delta?
>
> We have way better information than that. The watchdog timer expiry time is
> known and we can determine the exact delay of the timer.
>
> The watchdog clocksource provides the maximum 'idle' time, i.e. the time
> between two reads, in clocksource::max_idle_ns. That value is filled in
> when the clocksource is configured.
>
> So without doing speculation we can make an informed decision:
>
>     elapsed = jiffies_to_nsec(jiffies - watchdog_timer->expires) +
>               WATCHDOG_INTERVAL_NS;
>
>     if (elapsed > wdcs->max_idle_ns) {
>             Skip ......
>     }

Yes, that makes more sense than what I was doing, although I'm not
sure on the details.  Just missed that idea.

Why are you adding the watchdog interval to the calculated elapsed
time?  It seems we have an issue exactly if jiffies -
watchdog_timer->expires is too big, without adding the interval we
tried to wait in on top.  Also I think we might want to be careful
that jiffies is >= the expires time - or is it not possible that a
timer fires one jiffy early?

Also for full generality it seems we should check against the
clocksource max_idle_ns as well - for x86 TSC is wider than HPET but
there may be other architectures that could hit the same problem, just
with the clocksource being checked wrapping around instead of the
watchdog clocksource.  Right?

Thanks!
  Roland

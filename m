Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B540C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 11:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9DD9217AC
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 11:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9DD9217AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbeHYPAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 11:00:36 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:44210 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbeHYPAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 11:00:35 -0400
Received: by mail-oi0-f66.google.com with SMTP id l82-v6so14043069oih.11;
        Sat, 25 Aug 2018 04:21:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fE0pTMEfBua07Pw8ZqJb+6OUKoSm94ROR/q+KzgLwFY=;
        b=hKZuvVoRmGxk0MkSdIf2+CllJhQH5GetZPlqjYFY8tjW5K16N3Q7/b2H88clIOqWNJ
         GRUgI58QWCqriNRtqwRtgbxsDV4kJLurFonPUhtRkt4vNSjCUPU5FseAsRbN5J2Iv8/d
         RxPfJTqZD831kiNEKsteO0gqggiEgXUmD6DIEfMgetYI4RysBm8EGFL1ZT/zD8deHoO8
         B7fzaKkXGeGOwiwNChoJLMOmAZOzl/IlcynycWyFBNpIYj+26NwvTvqVbfolBAiwhFO6
         KfJEMoH1q0riJ0YN713nQc5TiNlHqLY+0LmzhjPNK4u4OlQW7/xHTFGdyzk9Lma136IC
         ps6Q==
X-Gm-Message-State: APzg51Dlpz/e3HboJ3xPiLYcfmoh7RK9dsVf5HC7D5aUDoNDAcO2ABBd
        2CPrNjzHI/1IV/3f0XID9LaF3NJq6yQJfUBwkpo=
X-Google-Smtp-Source: ANB0VdbLJlM7T4KAMyi3MxPSXuA+LJohv6tfzTS/bS2hWoGx8sOqPk4v2k/xEFp30yuqO/vm6hBCW0PNPjdLRy7c5Ms=
X-Received: by 2002:aca:1719:: with SMTP id j25-v6mr5110893oii.138.1535196115364;
 Sat, 25 Aug 2018 04:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <34910476.pgRhNDWo5t@aspire.rjw.lan> <000701d43bc1$5e0c2c50$1a2484f0$@net>
In-Reply-To: <000701d43bc1$5e0c2c50$1a2484f0$@net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 25 Aug 2018 13:21:44 +0200
Message-ID: <CAJZ5v0gtsEM9OMaJO=uM30R8dUBzk8C1E+8nzX0Oj4xA-J3-tw@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: menu: Retain tick when shallow state is selected
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 5:52 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> On 2018.08.24 02:44 Rafael J. Wysocki wrote:
> > On Tuesday, August 21, 2018 10:44:10 AM CEST Rafael J. Wysocki wrote:
> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> The case addressed by commit 5ef499cd571c (cpuidle: menu: Handle
> >> stopped tick more aggressively) in the stopped tick case is present
> >> when the tick has not been stopped yet too.
>
> ... [snip] ...
>
> >> Fixes: 87c9fe6ee495 (cpuidle: menu: Avoid selecting shallow states with stopped tick)
>
> ... [snip] ...
>
> > Due to the lack of objections, I'm inclined to queue this up.
>
> I have been following these threads.
> Recall that I was involved, over a period of months, in the original
> "powernightmare" stuff.
> I have revived my tests (and wish I had left myself better notes), and
> am establishing a baseline before adding and trying this patch.
> My baseline is actually two tests with and without the previous two patches (the ones
> that were just sent a couple of days ago in "More power management updates for v4.19-rc1".
> I might have those results in some presentable form by later today (it looks O.K.)
> Results with this patch will take another couple of days.

Thanks Doug, much appreciated!

This patch has been queued up, but I will wait for your results for a
few days before pushing it.

Cheers,
Rafael

Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009DBC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 08:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1BA5217FE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 08:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1BA5217FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbeHMKwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 06:52:41 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:38223 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbeHMKwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 06:52:41 -0400
Received: by mail-oi0-f66.google.com with SMTP id v8-v6so25784688oie.5;
        Mon, 13 Aug 2018 01:11:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t/AaPrbbhfdVZb7hZmY+u4aObSKOmt9MPbHoYBb8VBk=;
        b=Y2A5jeySnYl+3U1OQGqeKXsULeBCEZ0lyJaAvxmuJ9kLC+GllFiRv9J+uQQNs92jrT
         FPb8DvoYETxj0qwB/WwqqhwyvsT5vhhaV7ylNbRiwFjtFMBhYLd4CSRi6E9IHYv47U5H
         lIxvzHf1AFnKdUEGBNCeNJf3FEZUo3yVSv4FKEvsMf6muoQVUpBjJERXnWYzrI7nle11
         ks3p4NcerSFc8WjhJ2ApToychw++ImQorZXN0cBfMk/FBKG905ysD2zdKukFsSo03srY
         81Bwjvuo7L9BlmatwbUv5SMM9Ylru2TSEZqrc026f0ha+8K+gisb7jpk9M1/SOTWst7m
         PgHA==
X-Gm-Message-State: AOUpUlH/hmiEaYju0DvU9Gy6jKFzxk8qaH4MJ2+MdXgKbTem0/9RGGHe
        cw9PGTYM+J3dZlBFZ1Rgv73JMg9SXJ3N589zsHo=
X-Google-Smtp-Source: AA+uWPylud6zxlH35bqXSMhyMKVKQthynEECUhAlCUYHNclXLAOvP4jLlZdJ8Xw3GJ4zuymXiVBN91n288+LLMN9gIs=
X-Received: by 2002:aca:5b0b:: with SMTP id p11-v6mr18295821oib.116.1534147891827;
 Mon, 13 Aug 2018 01:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <1951009.1jlQfyrxio@aspire.rjw.lan> <3174357.2tBMdxG3bF@aspire.rjw.lan>
 <1754612.IcCR94pSYR@aspire.rjw.lan> <20180812145515.GB28966@leoy-ThinkPad-X240s>
In-Reply-To: <20180812145515.GB28966@leoy-ThinkPad-X240s>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Aug 2018 10:11:20 +0200
Message-ID: <CAJZ5v0i27XksAGUsq8CQRpE_AbNhYwu0roGdfy5DHBrPqtsPtw@mail.gmail.com>
Subject: Re: [PATCH v3] cpuidle: menu: Handle stopped tick more aggressively
To:     Leo Yan <leo.yan@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 12, 2018 at 4:55 PM <leo.yan@linaro.org> wrote:
>
> On Fri, Aug 10, 2018 at 01:15:58PM +0200, Rafael J . Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >

[cut]

>
> I tried this patch at my side, firstly just clarify this patch is okay
> for me, but there have other underlying issues I observed the CPU
> staying shallow idle state with tick stopped, so just note at here.

Thanks for testing!

> From my understanding, the rational for this patch is we
> only use the timer event as the reliable wake up source; if there have
> one short timer event then we can select shallow state, otherwise we
> also can select deepest idle state for long expired timer.
>
> This means the idle governor needs to know the reliable info for the
> timer event, so far I observe there at least have two issues for timer
> event delta value cannot be trusted.
>
> The first one issue is caused by timer cancel, I wrote one case for
> CPU_0 starting a hrtimer with pinned mode with short expire time and
> when the CPU_0 goes to sleep this short timeout timer can let idle
> governor selects a shallow state; at the meantime another CPU_1 will
> be used to try to cancel the timer, my purpose is to cheat CPU_0 so can
> see the CPU_0 staying in shallow state for long time;  it has low
> percentage to cancel the timer successfully, but I do see seldomly the
> timer can be canceled successfully so CPU_0 will stay in idle for long
> time (I cannot explain why the timer cannot be canceled successfully
> for every time, this might be another issue?).  This case is tricky,
> but it's possible happen in drivers with timer cancel.

Yes, it can potentially happen, but I'm not worried about it.  If it
happens, that will only be occasionally and without measurable effect
on total energy usage of the system.

> Another issue is caused by spurious interrupts; if we review the
> function tick_nohz_get_sleep_length(), it uses 'ts->idle_entrytime' to
> calculate tick or timer delta, so every time when exit from interrupt
> and before enter idle governor, it needs to update
> 'ts->idle_entrytime'; but for spurious interrupts, it will not call
> irq_enter() and irq_exit() pairs, so it doesn't invoke below flows:
>
>   irq_exit()
>     `->tick_irq_exit()
>          `->tick_nohz_irq_exit()
>               `->tick_nohz_start_idle()
>
> As result, after spurious interrupts handling, the idle loop doesn't
> update for ts->idle_entrytime so the governor might read back a stale
> value.  I don't really locate this issue, but I can see the CPU is
> waken up without any interrupt handling and then directly go to
> sleep again, the menu governor selects one shallow state so the cpu
> stay in shallow state for long time.

This sounds buggy, but again, spurious interrupts are not expected to
occur too often and if they do, they are a serious enough issue by
themselves.

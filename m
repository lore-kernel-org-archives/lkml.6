Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87948C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 21:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3012F2173A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 21:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3012F2173A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbeHUAij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 20:38:39 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39915 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbeHUAij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 20:38:39 -0400
Received: by mail-oi0-f68.google.com with SMTP id d189-v6so28439662oib.6;
        Mon, 20 Aug 2018 14:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hQiuAF/Hn9K/8uBFxuKMy+i9l/kcGbsm5FBg2xp2gAc=;
        b=MJVwM73T6KNC+ULIn7Yes3rrcBlViqVQDYWhm56XtcSPYbhOoT7mnr53RGegvYviKp
         RUIIKdSG2OBhIaVD/h9uh3sE4+1dOVuVByHSTObPEK9kVBlolb8WIj36UFhHW1qvNzsi
         MFSrYIffOSw8oTQJklQhdProfWd5DrOpASe26/eKpwBg9WlJbCbJgus6HzBElUcu1vd7
         PYlDZsoDCtnjjVvO+at5u3bHCTx5eFP6CVzYDq+5q7ODqh6rYQWCeGKyxAp1iTewrl7Q
         sGSZ53V4/S7wOVexrImsXaZPGJuZRRwQwSeJAUxZYaw3UArT4JLeDSJrO7z/iXAXUgDG
         6Thg==
X-Gm-Message-State: AOUpUlFCnsNzFeMgWtpvE78Inl6SzpolR1snumx3ZT/2+I2WzNAF0GSi
        OVKAi5sp8k+Atnukwo2eT5U2NoV9rzFsfV0X66pI8A==
X-Google-Smtp-Source: AA+uWPxCAt/qn65GD/5m7am/RlURgeYAco9Y+N8tDmGwsiBuuZUfimadWxr7Q72w+NotcP3r9MDIt1hRPbVl5XdX5Fs=
X-Received: by 2002:aca:190d:: with SMTP id l13-v6mr15707022oii.216.1534800085217;
 Mon, 20 Aug 2018 14:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <2161372.IsD4PDzmmY@aspire.rjw.lan> <20180816132723.GA6010@lerouge>
 <10817203.8q7neLTJVD@aspire.rjw.lan> <20180817141252.GA12426@lerouge>
 <CAJZ5v0gD79NuTgr3dVS_3cBFz5Q1JtQTP8mDfSM1tvwDcYkFAQ@mail.gmail.com> <20180820144249.GA9770@lerouge>
In-Reply-To: <20180820144249.GA9770@lerouge>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 20 Aug 2018 23:21:13 +0200
Message-ID: <CAJZ5v0hATzs2NqPEdPSJFcSNWXVu+jkE-KoToCEr-c-y1yphtw@mail.gmail.com>
Subject: Re: [PATCH] sched: idle: Avoid retaining the tick when it has been stopped
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Leo Yan <leo.yan@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 4:42 PM Frederic Weisbecker <frederic@kernel.org> wrote:
>
> On Sat, Aug 18, 2018 at 11:57:00PM +0200, Rafael J. Wysocki wrote:
> > On Fri, Aug 17, 2018 at 4:12 PM Frederic Weisbecker <frederic@kernel.org> wrote:

[cut]

> >
> > Now, in general, there are two reasons for the idle governor (whatever
> > it is) to select an idle state with a target residency below the tick
> > period length.  The first reason is when the governor knows that the
> > closest timer event is going to occur in this time frame, but in that
> > case (as stated above), it is not necessary to worry about the tick,
> > because the other timer will trigger soon enough anyway.  The second
> > reason is when the governor predicts a wakeup which is not by a timer
> > in this time frame and it is quite arguable what the governor should
> > do then.  IMO it at least is not unreasonable to throw the prediction
> > away and still go for the closest timer event in that case (which is
> > the current approach).
>
> Then in this case, when you say you throw away that prediction, does it
> mean you select an idle state that only takes the next timer event into
> consideration?

Yes, it does.

> So for example we predict a wake up event TICK_NSEC ahead but the next
> timer event is a few seconds, you're going to select an idle state
> according to that "few seconds" ahead next event, right? (which in
> practice is likely to be deep I guess).
>
> I guess so but, just want to be sure I understand you correctly.

More precisely, if the original predicted idle duration is less than
TICK_USEC and the tick has been stopped, the governor takes the time
till the next timer event instead of the predicted value (so
effectively the predicted value is discarded).

If the original predicted idle duration is TICK_USEC or more, the tick
would have been stopped anyway (had it not been stopped already), so
it may as well be used for idle state selection in the stopped tick
case.

Cheers,
Rafael

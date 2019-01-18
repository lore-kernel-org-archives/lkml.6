Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27A2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E072087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547809533;
	bh=dgKQp9MiodrstjAvj9PjEha/WmalovybMvQYxW1GktA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WYbTnvGYsFzU0cRG6Vuin+MmmjAceTi71XHPzRbn8anLdB6nCDEIjk9ePhUi8lB0c
	 blf4ZA4cvwFZL4hwooVdMTMXxAhn6WHr81Ba3ok/5BT+0LFvSD+FKevxliWQDxD1i2
	 7kkd3L0PiVpBqxxCsDZ/zViqXofpyUWYJ53hw+p8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbfARLFb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 06:05:31 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45028 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfARLFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 06:05:31 -0500
Received: by mail-oi1-f196.google.com with SMTP id m6so8640932oig.11;
        Fri, 18 Jan 2019 03:05:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qqgYhdtZbYxA/dAajTTHvHTsOtceTWqPRaIVq+BJeoc=;
        b=uGPAaxrO7cJ9uI5bl3qxhhlTVU2ln77QCfMvr6sQi35QMf8FFH71lDYlO7EV0IQn75
         jxD7VO2LX29crJtIJYfa0opDoWHa/jr2V+hp7zMLFskBLPdb3f6NcN8uxSYMhJnczkLi
         ixSSqHxGCeRcWaUeLDUGmG6brjtNakvPQOkrnGbl/7PjhPkYixNAr6ESDu7OnZGIjikF
         ojCRlE/Gt5fE1uY5W7KdUZbIuZwdqlyVPCfgKWAp3zte6d8QlqQsYmuv73Twel42tetF
         u/EmXiO6Vj7BuX5l1cnwUioyl2AncRECDd/1RJkCa3QTH1Yc2eJ4ZVRgm84bAfrutNvn
         FXdA==
X-Gm-Message-State: AJcUukcZ6qlIsylJ4ScAFWjk6IYMt27a9++8sWLAZK+niBk1e/3MSJVa
        1n30y43iZo0LSv/1ztLXMb67ONyXJbb6EMOzrZc=
X-Google-Smtp-Source: ALg8bN4bkpsb8Ob+GNgZby+3RXRY7hagOEbOzI/KVTic5w6Acr5SXBbXsn9230G44sH4z9f/YDavM6kOkXNV6awKzAk=
X-Received: by 2002:a54:4d01:: with SMTP id v1mr380529oix.246.1547809529970;
 Fri, 18 Jan 2019 03:05:29 -0800 (PST)
MIME-Version: 1.0
References: <1545388436-7489-1-git-send-email-vincent.guittot@linaro.org>
 <1545388436-7489-4-git-send-email-vincent.guittot@linaro.org>
 <20190117221628.GA21979@roeck-us.net> <20190118104215.GA13168@linaro.org> <CAKfTPtD9fu06sw8=MvjwfQfJoQHb0kT3un9=kdw+WZj+rbVUZg@mail.gmail.com>
In-Reply-To: <CAKfTPtD9fu06sw8=MvjwfQfJoQHb0kT3un9=kdw+WZj+rbVUZg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Jan 2019 12:05:18 +0100
Message-ID: <CAJZ5v0gFpK3Kqyf=RM+160A3RAQYPs3c3EgxmNH7ZceEaujEUw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] PM/runtime:Replace jiffies based accounting with
 ktime based accounting
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        rodrigo.vivi@intel.com, David Airlie <airlied@linux.ie>,
        "Intel graphics driver community testing & development" 
        <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 11:53 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Fri, 18 Jan 2019 at 11:42, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > Hi Guenter,
> >
> > Le Thursday 17 Jan 2019 à 14:16:28 (-0800), Guenter Roeck a écrit :
> > > On Fri, Dec 21, 2018 at 11:33:56AM +0100, Vincent Guittot wrote:
> > > > From: Thara Gopinath <thara.gopinath@linaro.org>
> > > >
> > > > This patch replaces jiffies based accounting for runtime_active_time
> > > > and runtime_suspended_time with ktime base accounting. This makes the
> > > > runtime debug counters inline with genpd and other pm subsytems which
> > > > uses ktime based accounting.
> > > >
> > > > timekeeping is initialized before pm_runtime_init() so ktime_get() will
> > > > be ready before first call. In fact, timekeeping_init() is called early
> > > > in start_kernel() which is way before driver_init() (and that's when
> > > > devices can start to be initialized) called from rest_init() via
> > > > kernel_init_freeable() and do_basic_setup().
> > > >
> > > This is not (always) correct. My qemu "collie" boot test fails with this
> > > patch applied. Reverting the patch fixes the problem. Bisect log attached.
> > >
> >
> > Can you try the patch below ?
> > ktime_get_mono_fast_ns() has the advantage of being init with dummy clock so
> > it can be used at early_init.
>
> Another possibility would be delay the init of the gpiochip

Well, right.

Initializing devices before timekeeping doesn't feel particularly
robust from the design perspective.

How exactly does that happen?

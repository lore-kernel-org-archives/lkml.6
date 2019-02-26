Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86164C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5456D20863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551218929;
	bh=XYz4Yvj2dgYXIVXzNSizY57kzLzBLSu1ofbljAMU7ZI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=j1r203faXUGmWWTbPE+ma4itKeCf0u3TAW79PeiuiIQWh2i3C3ANZmAU0FCyWvqJ/
	 r/CusMmyKJ3uSvXbu9Y0DiT9vlAGBXbzUX+X98aHyJaIXzHsl+j/42XAqOlcZ2uzn+
	 ekX2BnrYNJcTyy2neARE9NctbpKIzlmyKCfhTsWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbfBZWIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 17:08:48 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43616 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbfBZWIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 17:08:47 -0500
Received: by mail-ot1-f65.google.com with SMTP id n71so12531542ota.10;
        Tue, 26 Feb 2019 14:08:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XYz4Yvj2dgYXIVXzNSizY57kzLzBLSu1ofbljAMU7ZI=;
        b=rq+g4FVyM0Gwph1ayv9JKGmmxQwmqZB0mG9jdTUHPGvGyuqwn5HVlZNUOWnuXWwxGi
         8yqh4ihctt8b0YYwue2Cz50b4rPkLEhIxQBeavO/1J647QZdEAg9g9AlXOE1a6keTVAg
         97GlIqUyl/jQH5yUubd20fjgJ+PLy29icWXEobDirHtBMRnIsOxGC02oz42hyXpHAo7g
         TdX4w9Xz8UcarmVo5zAzfJhCoGaa1iHxkq6U1U+CyJ8UIxLqcoVwIJ+bqya6SrhCBolp
         OUzacpTVQyi1d+eKdQY1BJFyTisY/cfj1c1nCVwQxq4vnIc+LKe1FuFlKIor9a4HLP+b
         x25w==
X-Gm-Message-State: AHQUAuZnOaem+YDidjKuezKSiF14jAoBfEE6fVrTBkVI3PDHd6QIgV7q
        TYbqEbUTB9rGVbjwsTh5g73RVzM34NIyTG22VFQ=
X-Google-Smtp-Source: AHgI3IZEmzeStka0O4TpvO76n23BS1dRpDTF1Wcq7EyNtg7rTBAbNMXgJvSTC6sVqvNAehmF+gXS18Tv8CsQFGOwxTw=
X-Received: by 2002:a9d:4e08:: with SMTP id p8mr137025otf.124.1551218926888;
 Tue, 26 Feb 2019 14:08:46 -0800 (PST)
MIME-Version: 1.0
References: <20190226145415.19411-1-ulf.hansson@linaro.org> <20190226145415.19411-8-ulf.hansson@linaro.org>
In-Reply-To: <20190226145415.19411-8-ulf.hansson@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Feb 2019 23:08:35 +0100
Message-ID: <CAJZ5v0j=ddMEwvr8rt=PxxPpxoAHary7cYLYgTBbcuBuiGbTZA@mail.gmail.com>
Subject: Re: [PATCH v11 7/8] cpuidle: Pre-store next timer/tick before
 selecting an idle state
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 3:54 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> A common piece of data used by cpuidle governors, is the information about
> when the next timer/tick is going to fire. Rather than having each governor
> calling tick_nohz_get_next_timer|hrtimer() separately, let's consolidate
> the code by calling these functions before invoking the ->select() callback
> of the governor - and store the output data in the struct cpuidle_device.

That misses the point IMO.

You don't need to store two values in struct cpuidle_device, but just
one, and not before running ->select(), but before invoking the
driver's ->enter() callback.

At that point, the decision on whether or not to stop the scheduler
tick has been made already and it should be sufficient to store the
return value of tick_nohz_get_next_hrtimer() introduced by patch
[3/8], because that value represents the next timer regardless of what
has been decided with respect to the tick.

And you won't need the tick_nohz_get_next_timer() any more then.

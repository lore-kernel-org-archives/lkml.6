Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 244FAC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4912086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f05KOYzQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF4912086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935050AbeFMIzR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 04:55:17 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39943 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934150AbeFMIzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 04:55:14 -0400
Received: by mail-pf0-f193.google.com with SMTP id z24-v6so1046617pfe.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 01:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sSL37yrzOQ4dbYa066Ru1UuYzO2b4FLOQBFVZ1IWPRQ=;
        b=f05KOYzQwm59KnvKoXULTuK7W7QqmM8oHGwfM8NXFFfITQuypU6YOu4RT66yXFpA/B
         fiewLb9vbAg2oAXQm5OE46K0obceDZJxUMi8wsxpFYL+8Ukqu13ugb3aKPBASGxduM3/
         b3Pm3wMqX2huvxcTBOsKYm20x4asDJ4xGH6ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sSL37yrzOQ4dbYa066Ru1UuYzO2b4FLOQBFVZ1IWPRQ=;
        b=ScWWBxbjm0ieszsvzNeZvR6KBNLk4s+YlHNIrsC3YoMpDsrFo/kOrCMLmRZwU37+A4
         UbvlrxQDT14hTDD7ka0UA2jVQ/u/KYeyKsIAhvTNQD1yaT1yQy5nCwK9JXBCFSLXY1RN
         2+OJ/SWwyZ529vnsygslbdFWEqirBrBs0zbJnFVOkaUsCsauGIYAejV1f1O65v0ngrvm
         19R7ecTVdTmhdpLe/9Gal4Kb6hNka1ahV9fU6fm2rLu+j5W+8pgyFySLIsQ+QbfIGW+x
         UWEq+WZFofyoiL1JxAFsgcyBG73GQ87ZS+r4mXn4iQNWPIAvUuDDuunUGfs3apM0mlsy
         puTA==
X-Gm-Message-State: APt69E1ql11A9tmvNvdR5Y9frGnNh24pDC1dsm/eB7IuQwj1iS6fA34W
        qMjnuclZXPwEjMWFgf3NplsuKQ==
X-Google-Smtp-Source: ADUXVKLKDxwzqfT/aeLjfKOoOXAsu/jEDGe0SXF54DDRXUq0unTv4RN3p3dc47MvJX5a7FB/1CYWIw==
X-Received: by 2002:a65:51c9:: with SMTP id i9-v6mr3401313pgq.202.1528880113113;
        Wed, 13 Jun 2018 01:55:13 -0700 (PDT)
Received: from localhost ([223.226.91.101])
        by smtp.gmail.com with ESMTPSA id h124-v6sm4400837pfc.100.2018.06.13.01.55.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 01:55:11 -0700 (PDT)
Date:   Wed, 13 Jun 2018 14:25:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH V6] powercap/drivers/idle_injection: Add an idle
 injection framework
Message-ID: <20180613085509.s7ktdespfyjpozuu@vireshk-i7>
References: <1528804816-32636-1-git-send-email-daniel.lezcano@linaro.org>
 <20180612123036.GJ12180@hirez.programming.kicks-ass.net>
 <16d5649d-863c-10c7-9287-202568e713e6@linaro.org>
 <20180612125247.GO12217@hirez.programming.kicks-ass.net>
 <16770447-afe3-0fd7-19f9-1bd52c4c8ced@linaro.org>
 <20180612140654.GQ12217@hirez.programming.kicks-ass.net>
 <cce05d92-d51a-ab4f-83f2-37dcdee0cd6a@linaro.org>
 <20180612155841.GT12217@hirez.programming.kicks-ass.net>
 <7190a58e-05f2-216c-8b36-70692fa722bf@linaro.org>
 <20180612173514.GV12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612173514.GV12217@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-06-18, 19:35, Peter Zijlstra wrote:
> On Tue, Jun 12, 2018 at 07:02:57PM +0200, Daniel Lezcano wrote:
> > Mmh, it is unclear for me if the park() vs wakeup() can happen at the
> > same time.
> > 
> > If the park() function is called, that means the hotplug is allowed.
> 
> No, it means we're inside hot-un-plug, but that doesn't stop the hrtimer
> from firing.
> 
> > If the hotplug is allowed, we can modify the online mask.
> > 
> > What happens with the online mask when we are processing it in an
> > interrupt context ?
> 
> RCU-like, if you observe a CPU in the online mask, it will stay
> available, but the bit might get cleared.
> 
> > > Maybe avoid the issue entire by having a
> > > {period,idle} tuple, where your old run := period - idle.
> > 
> > Can you elaborate ? I don't get it.
> 
> Have a period parameter that specifies the interval in which you have
> one injected idle, and specify for how long you want to inject idle;
> then obviously idle < period.
> 
> > >>> Furthermore, should you not be using hrtimer_forward(&timer,
> > >>> idle_duration + run_duration) instead? AFAICT the current scheme is
> > >>> prone to drifting.
> > >>
> > >> (I assume you meant setting the timer in the wakeup task function).
> > >>
> > >> Yes, drifting is not an issue if that happens. This scheme is simpler
> > >> and safer than setting the timer ahead before waking up the tasks with
> > >> the risk it expires before all the tasks ended their idle cycles.
> > > 
> > > sloppy though..
> > 
> > Ok, do you prefer to see the timer set in the wakeup function and thus
> > having a periodic tick for the idle injection ?
> 
> I think having a HRTIMER_RESTART handler that does hrtimer_forward() is
> the most sensible. You will end up having to deal with threads not being
> ready, but I think that's not a real problem.

Honestly speaking I am not sure if we can fix all the races we have identified
until now, with the current design and the fear of using resources after getting
freed will always be there. Too many corner cases really.

The requirement we have is to make sure no kthread or hrtimer is still in use
when the ii_dev is freed from idle_injection_unregister().

May be the only sane way to make it work is to call
smpboot_register_percpu_thread() from idle_injection_register() and then
unregister those threads from idle_injection_unregister().

-- 
viresh

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752466AbeBEERo (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 23:17:44 -0500
Received: from mail-pl0-f50.google.com ([209.85.160.50]:39441 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752256AbeBEERi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 23:17:38 -0500
X-Google-Smtp-Source: AH8x224ZOL0TcKhrmu/ABVtXN32E+Myxt+srhLKhMyEAWMBZM3fWqjtPFvByao41A+JiFdTwbQHZ8A==
Date: Mon, 5 Feb 2018 09:47:34 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Javi Merino <javi.merino@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        daniel.thompson@linaro.org
Subject: Re: [PATCH 8/8] thermal/drivers/cpu_cooling: Add the combo cpu
 cooling device
Message-ID: <20180205041734.GD28462@vireshk-i7>
References: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org>
 <1516721671-16360-9-git-send-email-daniel.lezcano@linaro.org>
 <20180202104259.GA28462@vireshk-i7>
 <8dadd854-25ac-68aa-aa9f-33ba76a137a4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dadd854-25ac-68aa-aa9f-33ba76a137a4@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-02-18, 15:30, Daniel Lezcano wrote:
> On 02/02/2018 11:42, Viresh Kumar wrote:
> > Here is how I see the whole thing now:
> > 
> > - Yes we need individual support for both cpufreq and cpuidle cooling devices,
> >   and no one disagrees on that I believe.
> > 
> > - There is nothing in the thermal framework that disallows both cpufreq and
> >   cpuidle cooling devices to co-exist. Both would be part of the same thermal
> >   zone and so will get throttled with the same thermal sensor event. And so we
> >   will end up trying to cool down the SoC using both cpufreq and cpuidle
> >   technique.
> 
> No. It does not work because we will need different state for each
> cooling device and we need some logic behind.

Right, but I thought the cooling-maps can help us specify different cooling
states for different cooling devices for the same trip point. Maybe my
understanding of that is incorrect.

> > - Now I am just wondering if we really need the "combo" functionality or not.
> >   Can we fine tune the DT cpu-cooling properties (existing ones) for a platform,
> >   so that it automatically acts as a combo cooling device? I am not 100% sure
> >   its gonna fly, but just wanted to make sure its not possible to work around
> >   with and then only try the combo device thing.
> > 
> > For example, suppose that with just cpufreq-cooling device we need to take the
> > CPU down to 1 GHz from 2 GHz if we cross temperature 'X'. What if we can change
> > this policy from DT and say the cpufreq-cooling device goes to 1.5 GHz and
> > cpuidle-cooling device takes us to idle for 'y' us, and the effect of
> > combination of these two is >= the effect of the 1 GHz for just the
> > cpufreq-cooling device.
> > 
> > Is there any possibility of this to work ?
> 
> It does not make sense. The combo does that automatically by computing
> the power equivalence more precisely.

Sure, but that works by creating a virtual combo-cooling device instead of two
separate cooling devices and then there are several limitation (at least right
now) where it doesn't sense the real situation automagically. For example I
would expect the combo to just work with cpuidle if cpufreq isn't present and as
soon as cpufreq comes in, covert itself to cpufreq+cpuidle. I was just trying to
present another view at solving the problem at hand, not that one is better
than the other.

-- 
viresh

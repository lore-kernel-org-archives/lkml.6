Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751864AbeBBKnL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 05:43:11 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:38847 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751671AbeBBKnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 05:43:03 -0500
X-Google-Smtp-Source: AH8x227KveMPrTkDX+qVyBUpeIf0XODu/McUO7j+S+xdJGPCo319jZNd2sLYXl+e2izkrbFbRyiV4w==
Date: Fri, 2 Feb 2018 16:12:59 +0530
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
Message-ID: <20180202104259.GA28462@vireshk-i7>
References: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org>
 <1516721671-16360-9-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516721671-16360-9-git-send-email-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

I have gone through the other review comments, specially from Daniel T.. While I
share some of his concerns, I have few more of mine.

On 23-01-18, 16:34, Daniel Lezcano wrote:
> +late_initcall(cpu_cooling_init);

For example, this thing isn't going to fly nicely as you have assumed cpufreq
and cpuidle drivers are going to be part of the kernel itself. What if they are
modules and are inserted after late-init ? There are more cases like this where
the cpufreq driver may unregister the cpufreq cooling device on the fly and then
add it back. And so this stuff is a bit tricky.

Here is how I see the whole thing now:

- Yes we need individual support for both cpufreq and cpuidle cooling devices,
  and no one disagrees on that I believe.

- There is nothing in the thermal framework that disallows both cpufreq and
  cpuidle cooling devices to co-exist. Both would be part of the same thermal
  zone and so will get throttled with the same thermal sensor event. And so we
  will end up trying to cool down the SoC using both cpufreq and cpuidle
  technique.

- Now I am just wondering if we really need the "combo" functionality or not.
  Can we fine tune the DT cpu-cooling properties (existing ones) for a platform,
  so that it automatically acts as a combo cooling device? I am not 100% sure
  its gonna fly, but just wanted to make sure its not possible to work around
  with and then only try the combo device thing.

For example, suppose that with just cpufreq-cooling device we need to take the
CPU down to 1 GHz from 2 GHz if we cross temperature 'X'. What if we can change
this policy from DT and say the cpufreq-cooling device goes to 1.5 GHz and
cpuidle-cooling device takes us to idle for 'y' us, and the effect of
combination of these two is >= the effect of the 1 GHz for just the
cpufreq-cooling device.

Is there any possibility of this to work ?

-- 
viresh

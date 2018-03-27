Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752197AbeC0CDo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 22:03:44 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:53424 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbeC0CDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 22:03:42 -0400
X-Google-Smtp-Source: AIpwx48EAGnqT5ER2nkbZh3EepDowTZxY8a/Db0hM7JO9ZETUhStK0X/WjygKz2aPfJ0Q0TQmMoyKA==
Date: Tue, 27 Mar 2018 10:03:31 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        linux-kernel@vger.kernel.org, javi.merino@kernel.org,
        rui.zhang@intel.com, daniel.thompson@linaro.org,
        linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 6/7] thermal/drivers/cpu_cooling: Introduce the cpu
 idle cooling driver
Message-ID: <20180327020331.GA21693@leoy-ThinkPad-X240s>
References: <1519226968-19821-1-git-send-email-daniel.lezcano@linaro.org>
 <1519226968-19821-7-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519226968-19821-7-git-send-email-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Wed, Feb 21, 2018 at 04:29:27PM +0100, Daniel Lezcano wrote:
> The cpu idle cooling driver performs synchronized idle injection across all
> cpus belonging to the same cluster and offers a new method to cool down a SoC.
> 
> Each cluster has its own idle cooling device, each core has its own idle
> injection thread, each idle injection thread uses play_idle to enter idle.  In
> order to reach the deepest idle state, each cooling device has the idle
> injection threads synchronized together.
> 
> It has some similarity with the intel power clamp driver but it is actually
> designed to work on the ARM architecture via the DT with a mathematical proof
> with the power model which comes with the Documentation.
> 
> The idle injection cycle is fixed while the running cycle is variable. That
> allows to have control on the device reactivity for the user experience. At
> the mitigation point the idle threads are unparked, they play idle the
> specified amount of time and they schedule themselves. The last thread sets
> the next idle injection deadline and when the timer expires it wakes up all
> the threads which in turn play idle again. Meanwhile the running cycle is
> changed by set_cur_state.  When the mitigation ends, the threads are parked.
> The algorithm is self adaptive, so there is no need to handle hotplugging.

The idle injection threads are RT threads (FIFO) and I saw in
play_idle() set/clear flag PF_IDLE for it.  Will these idle injection
threads utilization be accounted into RT utilization?

If idle injection threads utilization is accounted as RT tasks
utilization, will this impact CPUFreq governor 'schedutil' for OPP
selection?

[...]

Thanks,
Leo Yan

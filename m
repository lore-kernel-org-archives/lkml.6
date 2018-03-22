Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751921AbeCVDaU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 23:30:20 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46810 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751728AbeCVDaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 23:30:17 -0400
X-Google-Smtp-Source: AG47ELvUCriKIR7jn/fdh2I7336ces3UUq4SDG3egVyF7GgtPnftSqHMyM6WFIrjyLx0GqqAdMEplQ==
Date: Thu, 22 Mar 2018 11:30:13 +0800
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shunyong Yang <shunyong.yang@hxt-semitech.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wang Dongsheng <dongsheng.wang@hxt-semitech.com>,
        Joey Zheng <yu.zheng@hxt-semitech.com>
Subject: Re: [RFC PATCH] cpufreq: Calling init() of cpufreq_driver  when
 policy inactive cpu online
Message-ID: <20180322033013.3mqhf2fnbaqfdgay@vireshk-mac-ubuntu>
References: <1521627703-7728-1-git-send-email-shunyong.yang@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521627703-7728-1-git-send-email-shunyong.yang@hxt-semitech.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-03-18, 18:21, Shunyong Yang wrote:
> When multiple cpus are related in one cpufreq policy, the first online cpu
> will be chosen by default to handle cpufreq operations. In a CPPC case,
> let's take two related cpus, cpu0 and cpu1 as an example.
> 
> After system start, cpu0 is the first online cpu. Cpufreq policy will be
> allocated and init() in cpufreq_driver will be called to initialize cpu0's
> perf capabilities and policy parameters.

Not exactly. The init() is called to initialize stuff for all the CPUs that
should be part of policy->related_cpus after init() has returned. So you should
initialize perf capabilities for all of them.

> When cpu1 is online, current code
> will not call init() in cpufreq_driver as policy has been allocated and
> activated by cpu0. So, cpu1's perf capabilities are not initialized
> (all 0s).
> 
> When cpu0 is offline, policy->cpu will be shifted to cpu1. As cpu1's perf
> capabilities are 0s, speed change will not take effect when setting
> speed.
> 
> This patch adds calling init() of cpufreq_driver when policy inactive cpu
> comes to online.

No CPU should be inactive here, its just that you haven't initialized it
properly.

And we are not going to call init() multiple times for a group of CPUs. That's
not what the purpose of init() is.

-- 
viresh

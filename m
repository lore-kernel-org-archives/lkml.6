Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755461AbeE2Isr convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 04:48:47 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50123 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755438AbeE2Ism (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 04:48:42 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: "Wangtao (Kevin, Kirin)" <kevin.wangtao@hisilicon.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gengyanping@hisilicon.com, sunzhaosheng@hisilicon.com
Subject: Re: [PATCH] cpufreq: reinitialize new policy min/max when writing scaling_(max|min)_freq
Date: Tue, 29 May 2018 10:47:55 +0200
Message-ID: <2309223.3p98OPSZcO@aspire.rjw.lan>
In-Reply-To: <c6d1e102-bfdb-572c-2045-bf669ee9d674@hisilicon.com>
References: <1527144234-96396-1-git-send-email-kevin.wangtao@hisilicon.com> <CAJZ5v0ih6s9WviSpg9D+kSt2h8T5Vnx-MziOmYuk1H4yZOYLNg@mail.gmail.com> <c6d1e102-bfdb-572c-2045-bf669ee9d674@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, May 26, 2018 8:50:46 AM CEST Wangtao (Kevin, Kirin) wrote:
> 
> 在 2018/5/24 15:45, Rafael J. Wysocki 写道:
> > On Thu, May 24, 2018 at 8:43 AM, Kevin Wangtao
> > <kevin.wangtao@hisilicon.com> wrote:
> >> consider such situation, current user_policy.min is 1000000,
> >> current user_policy.max is 1200000, in cpufreq_set_policy,
> >> other driver may update policy.min to 1200000, policy.max to
> >> 1300000. After that, If we input "echo 1300000 > scaling_min_freq",
> >> then user_policy.min will be 1300000, and user_policy.max is
> >> still 1200000, because the input value is checked with policy.max
> >> not user_policy.max. if we get all related cpus offline and
> >> online again, it will cause cpufreq_init_policy fail because
> >> user_policy.min is higher than user_policy.max.
> > 
> > How do you reproduce this, exactly?
>
> I can also reproduce this issue with upstream code, write max frequency to scaling_max_freq
> and scaling_min_freq, run benchmark to let cpu cooling take effect to clip freq, then write
> the cliped freq to scaling_max_freq, thus user_policy.min is still max frequency but user_policy.max
> is cliped freq which is lower than max frequency.

OK, this is a bit more convincing.

It looks like bad interaction between cpufreq_update_policy() and updates of
the limits via sysfs.

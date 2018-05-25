Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936213AbeEYO0y (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 10:26:54 -0400
Received: from foss.arm.com ([217.140.101.70]:34614 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935826AbeEYO0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 10:26:52 -0400
Date: Fri, 25 May 2018 15:26:48 +0100
From: Quentin Perret <quentin.perret@arm.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com
Subject: Re: [PATCH v5 01/10] sched/pelt: Move pelt related code in a
 dedicated file
Message-ID: <20180525142648.GC15173@e108498-lin.cambridge.arm.com>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <1527253951-22709-2-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527253951-22709-2-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Friday 25 May 2018 at 15:12:22 (+0200), Vincent Guittot wrote:
> We want to track rt_rq's utilization as a part of the estimation of the
> whole rq's utilization. This is necessary because rt tasks can steal
> utilization to cfs tasks and make them lighter than they are.
> As we want to use the same load tracking mecanism for both and prevent
> useless dependency between cfs and rt code, pelt code is moved in a
> dedicated file.

I tried to do a quick build test to check if this patch actually introduces
function calls or not in the end. The base branch I used is today's
tip/sched/core ("2539fc82aa9b sched/fair: Update util_est before updating
schedutil").

* x86, x86_defconfig
  - Without patch:
    queper01 ~/work/linux> size vmlinux
    text data bss dec hex filename
    17476437 4942296 999628 23418361 16555f9 vmlinux

  - With patch:
    queper01 ~/work/linux> size vmlinux
    text data bss dec hex filename
    17476757 4942296 999628 23418681 1655739 vmlinux

* arm64, defconfig
  - Without patch:
    queper01 ~/work/linux> size vmlinux
    text data bss dec hex filename
    11349598 6440764 395336 18185698 1157de2 vmlinux

  - With patch:
    queper01 ~/work/linux> size vmlinux
    text data bss dec hex filename
    11349598 6440764 395336 18185698 1157de2 vmlinux

It's also true that I'm not using the same gcc version for both archs
(both quite old TBH -- 4.9.4 for arm64, 4.8.4 for x86).

The fact that the code size doesn't change for arm64 suggests that we
already had function calls for the __update_load_avg* functions, so
the patch isn't making things worst than they already are, but for x86,
this is different. Have you tried on x86 on your end ?

And also, I understand these functions are large, but if we _really_
want to inline them even though they're big, why not putting them in
sched-pelt.h ? We probably wouldn't accept that for everything, but
those PELT functions are used all over the place, including latency
sensitive code paths (e.g. task wake-up).

Thanks,
Quentin

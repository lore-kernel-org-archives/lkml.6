Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752227AbeCWV2V (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 17:28:21 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:43083 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751595AbeCWV2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 17:28:20 -0400
X-Google-Smtp-Source: AG47ELv8OqLAkrscMYbnOBDmxRsJ/D1ZcX4I2vv2AKPjp5vRthP3ilN5/29W+/x90COX9+0Lgkgmig==
To: Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Problem with commit 31e77c93e432 "sched/fair: Update blocked load
 when newly idle"
Message-ID: <e1da0be1-94d8-d5d0-8329-4507c51ddd64@gmail.com>
Date: Fri, 23 Mar 2018 22:28:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently I started to get the following problems with linux-next:

- When working via Putty/SSH on the system the console frequently freezes
  for few seconds. Sometimes only opening a second console makes the
  first one react again.

- I get "INFO: rcu_sched detected stalls on CPUs/tasks:" warnings as
  described in [1].

Bisecting the issue resulted in:

31e77c93e432dec79c7d90b888bbfc3652592741 is the first bad commit
commit 31e77c93e432dec79c7d90b888bbfc3652592741
Author: Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed Feb 14 16:26:46 2018 +0100

    sched/fair: Update blocked load when newly idle

    When NEWLY_IDLE load balance is not triggered, we might need to update the
    blocked load anyway. We can kick an ilb so an idle CPU will take care of
    updating blocked load or we can try to update them locally before entering
    idle. In the latter case, we reuse part of the nohz_idle_balance.

After reversing this commit at least the issue with the freezing console
is gone. The second one appeared only sporadically, I still have to see
whether it pops up again.

System is a Zotac CI321 mini PC with Intel Celeron 2961Y CPU.
If you need more details, please let me know.

Regards, Heiner

[1] https://lkml.org/lkml/2018/3/22/605

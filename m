Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752713AbeDQOVZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:21:25 -0400
Received: from mail-pl0-f49.google.com ([209.85.160.49]:37004 "EHLO
        mail-pl0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeDQOVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:21:23 -0400
X-Google-Smtp-Source: AIpwx4/l+aAK3gHbuexhJl00kYgpux3qJtYVcwThyZ+uN/0F8AP8Xs5QqQ+V//aDALT/P9iRjrs/1A==
Date: Tue, 17 Apr 2018 15:21:19 +0100
From: Matt Fleming <matt@codeblueprint.co.uk>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: cpu stopper threads and load balancing leads to deadlock
Message-ID: <20180417142119.GA4511@codeblueprint.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24+42 (6e565710a064) (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

We've seen a bug in one of our SLE kernels where the cpu stopper
thread ("migration/15") is entering idle balance. This then triggers
active load balance.

At the same time, a task on another CPU triggers a page fault and NUMA
balancing kicks in to try and migrate the task closer to the NUMA node
for that page (we're inside stop_two_cpus()). This faulting task is
spinning in try_to_wake_up() (inside smp_cond_load_acquire(&p->on_cpu,
!VAL)), waiting for "migration/15" to context switch.

Unfortunately, because "migration/15" is doing active load balance
it's spinning waiting for the NUMA-page-faulting CPU's stopper lock,
which is already held (since it's inside stop_two_cpus()).

Deadlock ensues.

This seems like a situation that should be prohibited, but I cannot
find any code to prevent it. Is it OK for stopper threads to load
balance? Is there something that should prevent this situation from
happening?

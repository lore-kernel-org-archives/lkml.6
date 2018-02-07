Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754654AbeBGPoP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 10:44:15 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:55275 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754637AbeBGPoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 10:44:11 -0500
X-Google-Smtp-Source: AH8x226aagYWb3Zma/LHgO3WkdvjAJK8CysD8efSdD61XxhSnAlpVRk474y+I9YVG5qgvQ0Tbsu4hm1jBuipvd+6p8o=
MIME-Version: 1.0
In-Reply-To: <20180203082353.17284-1-hannes@cmpxchg.org>
References: <20180203082353.17284-1-hannes@cmpxchg.org>
From: Shakeel Butt <shakeelb@google.com>
Date: Wed, 7 Feb 2018 07:44:08 -0800
Message-ID: <CALvZod5-35Y+_eot6-6J5HyssnmAW-wfYhuQdxxA9Zj8Ng2e+g@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: fix NR_WRITEBACK leak in memcg and system stats
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 3, 2018 at 12:23 AM, Johannes Weiner <hannes@cmpxchg.org> wrote:
> After the ("a983b5ebee57 mm: memcontrol: fix excessive complexity in
> memory.stat reporting"), we observed slowly upward creeping
> NR_WRITEBACK counts over the course of several days, both the
> per-memcg stats as well as the system counter in e.g. /proc/meminfo.
>
> The conversion from full per-cpu stat counts to per-cpu cached atomic
> stat counts introduced an irq-unsafe RMW operation into the updates.
>
> Most stat updates come from process context, but one notable exception
> is the NR_WRITEBACK counter. While writebacks are issued from process
> context, they are retired from (soft)irq context.
>
> When writeback completions interrupt the RMW counter updates of new
> writebacks being issued, the decs from the completions are lost.
>
> Since the global updates are routed through the joint lruvec API, both
> the memcg counters as well as the system counters are affected.
>
> This patch makes the joint stat and event API irq safe.
>
> Fixes: a983b5ebee57 ("mm: memcontrol: fix excessive complexity in memory.stat reporting")
> Debugged-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Should this be considered for stable?

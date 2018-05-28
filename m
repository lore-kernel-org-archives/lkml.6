Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938945AbeE1Mhk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:37:40 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34173 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938934AbeE1Mhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 08:37:35 -0400
X-Google-Smtp-Source: ADUXVKLMme34j4+FwAShlLsf6uvbBnVSeYmSO3tNOFi5q253zNuyBozbFfLeVMmxnYfMaeklS6LXXw==
Date: Mon, 28 May 2018 14:37:30 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v5 08/10] cpufreq/schedutil: take into account interrupt
Message-ID: <20180528123730.GC1293@localhost.localdomain>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <1527253951-22709-9-git-send-email-vincent.guittot@linaro.org>
 <20180528104127.GB1293@localhost.localdomain>
 <CAKfTPtAn6F6J9=KFJrG_fMMeGvTn3abn1sMAdjpQMKLz0p9egA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAn6F6J9=KFJrG_fMMeGvTn3abn1sMAdjpQMKLz0p9egA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/18 14:06, Vincent Guittot wrote:
> Hi Juri,
> 
> On 28 May 2018 at 12:41, Juri Lelli <juri.lelli@redhat.com> wrote:
> > Hi Vincent,
> >
> > On 25/05/18 15:12, Vincent Guittot wrote:
> >> The time spent under interrupt can be significant but it is not reflected
> >> in the utilization of CPU when deciding to choose an OPP. Now that we have
> >> access to this metric, schedutil can take it into account when selecting
> >> the OPP for a CPU.
> >> The CPU utilization is :
> >>   irq util_avg + (1 - irq util_avg / max capacity ) * /Sum rq util_avg
> >
> > IIUC the code below you actually propose that
> >
> >  util = [(max_cap - util_irq) * util_rq] / max_cap + util_irq
> >
> > where
> >
> >  util_rq  = /Sum rq util_avg
> >  util_irq = irq util_avg
> >
> > So, which one is what you have in mind? Or am I wrong? :)
> 
> mmh ... aren't they equal  ?
> 
> util = [(max_cap - util_irq) * util_rq] / max_cap + util_irq
> util = [(max_cap/max_cap - util_irq/max_cap) * util_rq]  + util_irq
> util = [(1 - util_irq/max_cap) * util_rq]  + util_irq
> util = util_irq +  [(1 - util_irq/max_cap) * util_rq]

Ah, indeed.

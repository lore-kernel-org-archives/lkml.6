Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753408AbeEUPuE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 11:50:04 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34222 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752657AbeEUPt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 11:49:59 -0400
X-Google-Smtp-Source: AB8JxZolIgq3iBI0j+WwmbVR811cOcEUq9uV4DL8hnjZLORaD3/1GWGKDIe5mvPnCzm3vQfm2je6ag==
Date: Mon, 21 May 2018 08:49:57 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: "Joel Fernandes (Google.)" <joelaf@google.com>,
        linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>, Todd Kjos <tkjos@google.com>,
        claudio@evidence.eu.com, kernel-team@android.com,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] schedutil: Allow cpufreq requests to be made even
 when kthread kicked
Message-ID: <20180521154957.GA14065@joelaf.mtv.corp.google.com>
References: <20180518185501.173552-1-joel@joelfernandes.org>
 <20180521105055.GQ30654@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521105055.GQ30654@e110439-lin>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 11:50:55AM +0100, Patrick Bellasi wrote:
> On 18-May 11:55, Joel Fernandes (Google.) wrote:
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > 
> > Currently there is a chance of a schedutil cpufreq update request to be
> > dropped if there is a pending update request. This pending request can
> > be delayed if there is a scheduling delay of the irq_work and the wake
> > up of the schedutil governor kthread.
> > 
> > A very bad scenario is when a schedutil request was already just made,
> > such as to reduce the CPU frequency, then a newer request to increase
> > CPU frequency (even sched deadline urgent frequency increase requests)
> > can be dropped, even though the rate limits suggest that its Ok to
> > process a request. This is because of the way the work_in_progress flag
> > is used.
> > 
> > This patch improves the situation by allowing new requests to happen
> > even though the old one is still being processed. Note that in this
> > approach, if an irq_work was already issued, we just update next_freq
> > and don't bother to queue another request so there's no extra work being
> > done to make this happen.
> 
> Maybe I'm missing something but... is not this patch just a partial
> mitigation of the issue you descrive above?
> 
> If a DL freq increase is queued, with this patch we store the request
> but we don't actually increase the frequency until the next schedutil
> update, which can be one tick away... isn't it?
> 
> If that's the case, maybe something like the following can complete
> the cure?

We already discussed this and thought of this case, I think you missed a
previous thread [1]. The outer loop in the kthread_work subsystem will take
care of calling sugov_work again incase another request was queued which we
happen to miss. So I don't think more complexity is needed to handle the case
you're bringing up.

thanks!

 - Joel

[1] https://lkml.org/lkml/2018/5/17/668

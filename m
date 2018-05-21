Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753293AbeEURqF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 13:46:05 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39202 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753097AbeEURqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 13:46:01 -0400
X-Google-Smtp-Source: AB8JxZpikmuGGgZkfUK7ifHereuXf4s4qScL9bv2mAsC5TySqwzeXyVk5nsyqj/a4fl0EH4waFonxg==
Date: Mon, 21 May 2018 10:46:00 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, kernel-team@android.com
Subject: Re: [PATCH v3 2/2] cpufreq: schedutil: Cleanup and document iowait
 boost
Message-ID: <20180521174600.GC21678@joelaf.mtv.corp.google.com>
References: <20180521085120.7902-1-patrick.bellasi@arm.com>
 <20180521085120.7902-3-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521085120.7902-3-patrick.bellasi@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 09:51:20AM +0100, Patrick Bellasi wrote:
> The iowait boosting code has been recently updated to add a progressive
> boosting behavior which allows to be less aggressive in boosting tasks
> doing only sporadic IO operations, thus being more energy efficient for
> example on mobile platforms.
> 
> The current code is now however a bit convoluted. Some functionalities
> (e.g. iowait boost reset) are replicated in different paths and their
> documentation is slightly misaligned.
> 
> Let's cleanup the code by consolidating all the IO wait boosting related
> functionality within within few dedicated functions and better define
> their role:
> 
> - sugov_iowait_boost: set/increase the IO wait boost of a CPU
> - sugov_iowait_apply: apply/reduce the IO wait boost of a CPU
> 
> Both these two function are used at every sugov updated and they makes

makes->make
updated->update

> use of a unified IO wait boost reset policy provided by:
> 
> - sugov_iowait_reset: reset/disable the IO wait boost of a CPU
>      if a CPU is not updated for more then one tick
> 
> This makes possible a cleaner and more self-contained design for the IO
> wait boosting code since the rest of the sugov update routines, both for
> single and shared frequency domains, follow the same template:
> 
>    /* Configure IO boost, if required */
>    sugov_iowait_boost()
> 
>    /* Return here if freq change is in progress or throttled */
> 
>    /* Collect and aggregate utilization information */
>    sugov_get_util()
>    sugov_aggregate_util()
> 
>    /*
>     * Add IO boost, if currently enabled, on top of the aggregated
>     * utilization value
>     */
>    sugov_iowait_apply()
> 
> As a extra bonus, let's also add the documentation for the new
> functions and better align the in-code documentation.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

[..]
 

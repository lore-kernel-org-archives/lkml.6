Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B779DC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCB427BCD
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="pGZA/Nci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DCB427BCD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936335AbeF2Sp3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:45:29 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39151 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932375AbeF2Sp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:45:27 -0400
Received: by mail-pl0-f65.google.com with SMTP id s24-v6so4861804plq.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 11:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9r9AtNZBHhD/fMjv5S8hLTePDvy7n7A1dRpluu9sKXg=;
        b=pGZA/NciLOAA6IPh7Won8fhTy56FA6Tb66E37gmYyk70GnM5vjKgsamO3Yqlmqgltg
         u4H82uQkEBpifuRIvTQ3+kIpPjGsTJPBnuYzj2bq9Ldz8ZRXXEzD11ooqm4R7xT2ajJ7
         EDqckZ15Xn60/jJKv6OxVA0ofcrLqESt66Rrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9r9AtNZBHhD/fMjv5S8hLTePDvy7n7A1dRpluu9sKXg=;
        b=TFpsf0fu9vdOA7YPiCOqJhxfM7jeH3rQ5wCpcjCSfH1oqscn2Hg9sZ326iP+GC7QkN
         WLF1wmiFf7NO5LhVGEaoOFYt/HWbq4qG51MnQ4CIGd3Jv0SiDNIXw4d+0PNjaYRl1D8a
         zt8pdVs0kXPMYKBPAo6ZrJsFjrcS8qnhWAmf72/lTQ72rXibJxul3PXZhzP33557SQVh
         W8VeBfl93k3TEkYRQHVM0FBSo/gnFr+3WyQkEJxD0I+pDBSVW/cWbxD9Px9pyLgHFcVB
         QYFHDsEVqR85sCS3kWHuKfMWyRamS7asEAzQqtsa6w/ZSaAr1inlhAfGLmZb5EiRSoGU
         jTkQ==
X-Gm-Message-State: APt69E1UdeNPM0ahnvzpeALWz8ymQBjn0Bq9m8ioCF9BO2aS+b6GL9a1
        tw+ZGNaD2PGtENLiuVOaOLlNWQ==
X-Google-Smtp-Source: ADUXVKIlsLc7QHCVGqWtLSPZZ4aK1hk1wgFYrGIuI9YTWuMOwgM0wNurRG7iKu1k8+H3DyP9q2V/6w==
X-Received: by 2002:a17:902:b589:: with SMTP id a9-v6mr16205063pls.140.1530297926750;
        Fri, 29 Jun 2018 11:45:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id e81-v6sm29551747pfb.62.2018.06.29.11.45.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 11:45:26 -0700 (PDT)
Date:   Fri, 29 Jun 2018 11:45:25 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Alessio Balsini <alessio.balsini@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] sched/deadline: sched_getattr() returns absolute
 dl-task information
Message-ID: <20180629184525.GA261771@joelaf.mtv.corp.google.com>
References: <20180629120947.14579-1-alessio.balsini@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629120947.14579-1-alessio.balsini@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 02:09:47PM +0200, Alessio Balsini wrote:
> If the task calls sched_getattr() with SCHED_GETATTR_FLAGS_DL_ABSOLUTE
> flag set, the returned runtime and deadline parameters are, accordingly,
> the remaining runtime and the absolute deadline.
> 
> To return consistent data, the scheduler and rq times, as well as the
> task statistics, are updated.

The commit log should typically also explain the "why" not just the "how".
Think about someone doing a git log later and trying to find out why this was
added.

> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
> Cc: Luca Abeni <luca.abeni@santannapisa.it>
> Cc: Claudio Scordino <claudio@evidence.eu.com>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Patrick Bellasi <patrick.bellasi@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Alessio Balsini <alessio.balsini@gmail.com>
> ---
> Having a precise means for measuring the execution time of a task at
> each activation is critical for real-time application design,
> development, and deployment. This allows for estimating the
> computational demand of the task at run-time, constituting the
> fundamental information over which the runtime parameter can be set when
> using the SCHED_DEADLINE policy. For example, one could set the runtime
> equal to the maximum observed execution time, or a proper percentile of
> its observed distribution (while a discussion of more complex WCET
> estimation techniques is out of scope here). Moreover, in dynamic
> workload scenarios, one needs to track the execution time changes, in
> order to possibly adapt the runtime parameter as needed.

All this should be in the commit log?

> However, on platforms with frequency switching capabilities, the typical
> way to perform execution time measurements for a task, based on sampling
> the CLOCK_THREAD_CPUTIME_ID clock, produces unreliable results due to
> the sporadic frequency switches that may happen between two
> measurements, and locking down the frequency is rarely a viable
> solution, anyway only acceptable during design/development, not for
> dynamic adaptations while the task is running.
> 
> Execution time measurements can be done by using the remaining runtime
> and absolute deadline instead, for SCHED_DEADLINE tasks. This is a
> better option because (i) it only accounts for the actual runtime of the
> task, and (ii) the runtime accounting is automatically normalized
> (scaled) with the CPU frequency (and capacity, for heterogeneous
> platforms).
> 
> 
> This solution preserves the ability to query for the absolute

"The solution presented in this patch"

> sched_{runtime, deadline} values of tasks other than itself, simplifying
> the development of a task hierarchy where a manager process can allocate
> the bandwidths of other deadline tasks in the system.

You didn't mention here you are attempting to fetch the remaining runtime of
the DL task. It almost sounds like you are saying here that the new flag will
fetch the configured runtime which it doesn't.

> 
> 
> The simplest way to measure the normalized duration C_ns of a piece of

"The simples way this can be used"

> deadline task that does not use bandwidth reclaiming is the following:
> 
> struct sched_attr s, e;
> uint64_t dl_misses;
> struct sched_attr curr_attr = {
>     [...]
>     sched_policy = SCHED_DEADLINE,
>     [...]
> };
> 
> sched_setattr(0, &curr_attr, 0);
> 
> sched_getattr(0, &s, ..., SCHED_GETATTR_FLAGS_DL_ABSOLUTE);
> /* calculations to be measured */
> sched_getattr(0, &e, ..., SCHED_GETATTR_FLAGS_DL_ABSOLUTE);
> 
> /* SCHED_DL periods within measurement, usually 0 */
> n_periods = (e.sched_deadline - s.sched_deadline) / s.sched_period;
> C_ns = s.sched_runtime - e.sched_runtime + n_periods * t.sched_runtime;


Overall I feel the description can be improved and made clear in conveying
the need for the patch in calculating the execution time. Also you didn't
even mention the usecase of low-latency audio. :-(

thanks!

- Joel
 

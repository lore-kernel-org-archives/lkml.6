Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C99CECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B394720852
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="T0zqIuO6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B394720852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731497AbeGQNgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:36:33 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39872 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbeGQNgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:36:33 -0400
Received: by mail-pf0-f196.google.com with SMTP id j8-v6so474811pff.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 06:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gv4W8nGAHM+Ge3egwRfGgTP8VH7brii8tl8m/22o5io=;
        b=T0zqIuO65Kz8Mu7bydxFKutavSE0X7/3R40nFtIXGOGWd3/8OwK3H9xo6w0tsn5Dqr
         Hm1/dDKtbS5acg303oluvpqaYt6Idm0L1O7fjd0L/eH62LISMB0hRlYa+FfIcE6BeUXn
         oxay2XnW+ZvJZUAE3T3srl9t6MuBdg7QyPalc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gv4W8nGAHM+Ge3egwRfGgTP8VH7brii8tl8m/22o5io=;
        b=A+12A/dNqVoXLtuv/o3zsdM5c1LBbHxQU5kRvA8Mp+pm/RVWMNeFYai0/Guffy24Ok
         uwYsW2WrND7vPao/QmpOfcRmrcj2LkMKLUjaxnjvf17i5VXkxiHc0k/Rp5urfolG2uNr
         yEtjdrXTJQFKWSyQy9manf0ZV4uqpL2/y81sf9QNIDm3IG8J2uwfN7ZiKZWbJHwrBZG4
         kH1NgBhvslivqY2UgL6Ylw7QCxf8KvlKMf7AuN8cvEJrIp6iqVPflt2GZ26b2kcW+IZ7
         cCNNVay1Wrl7tatTCEhV+4st4XbglI8DpuRHTK/Nh96l8HnMSF7xl2fhHuzepgDH75UZ
         zhOA==
X-Gm-Message-State: AOUpUlFTlTpfwOa1vqqrogcLfGSqD4/0rOG7/Fue5n83M7t5ECzkWHPK
        9CmKrOr3ZyDt7QI3ti/mhWOm2g==
X-Google-Smtp-Source: AAOMgpdqK/nAmF2QTJHvU772xNgO0mhGvhJCoUtEIrDhJ8/9Mlj+I+zdWghH1id2VjkBxKCFu8f1Dg==
X-Received: by 2002:a63:b504:: with SMTP id y4-v6mr1541689pge.247.1531832638298;
        Tue, 17 Jul 2018 06:03:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id s184-v6sm1925253pfb.56.2018.07.17.06.03.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 06:03:57 -0700 (PDT)
Date:   Tue, 17 Jul 2018 06:03:57 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v2 00/12] Add utilization clamping support
Message-ID: <20180717130357.GA17824@joelaf.mtv.corp.google.com>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716082906.6061-1-patrick.bellasi@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 09:28:54AM +0100, Patrick Bellasi wrote:
> This is a respin of:
> 
>    https://lore.kernel.org/lkml/20180409165615.2326-1-patrick.bellasi@arm.com
> 
> which addresses all the feedbacks collected from the LKML discussion as well
> as during the presentation at last OSPM Summit:
> 
>    https://www.youtube.com/watch?v=0Yv9smm9i78
> 
> Further comments and feedbacks are more than welcome!
> 
[...] 
> 
> Patrick Bellasi (12):
>   sched/core: uclamp: extend sched_setattr to support utilization
>     clamping
>   sched/core: uclamp: map TASK's clamp values into CPU's clamp groups
>   sched/core: uclamp: add CPU's clamp groups accounting
>   sched/core: uclamp: update CPU's refcount on clamp changes
>   sched/cpufreq: uclamp: add utilization clamping for FAIR tasks
>   sched/cpufreq: uclamp: add utilization clamping for RT tasks
>   sched/core: uclamp: enforce last task UCLAMP_MAX
>   sched/core: uclamp: extend cpu's cgroup controller
>   sched/core: uclamp: map TG's clamp values into CPU's clamp groups
>   sched/core: uclamp: use TG's clamps to restrict Task's clamps
>   sched/core: uclamp: update CPU's refcount on TG's clamp changes
>   sched/core: uclamp: use percentage clamp values
> 
>  Documentation/admin-guide/cgroup-v2.rst |  25 +
>  include/linux/sched.h                   |  53 ++
>  include/uapi/linux/sched.h              |   4 +-
>  include/uapi/linux/sched/types.h        |  66 +-
>  init/Kconfig                            |  63 ++
>  kernel/sched/core.c                     | 876 ++++++++++++++++++++++++

While I'm reviewing these patches, I had a quick thought. core.c is already
7k+ lines. Based on this diffstat, does it make sense for uclamp to be in its
own kernel/sched/uclamp.c file?

thanks,

- Joel
 

Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDF3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ACBD21850
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="boHUVNLr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbfB0PmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 10:42:20 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46538 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730074AbfB0PmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 10:42:19 -0500
Received: by mail-qk1-f194.google.com with SMTP id i5so10069497qkd.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 07:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bJ5h9be4b7KCjMmK31Zpums+iy/AqhYXrtbrX7XS2j4=;
        b=boHUVNLrnlG4TgjStODkEU1FcTkx0wyYKewSIai/QoC/lS2BfdId423m0hUDd6nedu
         xxLvlrxJf6SWVkI44rgL24FToLG+GhYJ+IDweZf/UnU94dNNWCoo/auLAV0oNzCh/sqy
         SnXQ9kxkTrRODGLFg9MGoeA//cakMmUg6wfo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bJ5h9be4b7KCjMmK31Zpums+iy/AqhYXrtbrX7XS2j4=;
        b=YGEdFxbIfxg/Yrznc2LRM9XVxgqeutJaCh654Y/Lnz6UBcgJx3V3VihiXqHmwalE+5
         FWHm9CR/9rb9mm301mCU/raxY2lZsNAloVg5GzN0UZ7jhjN1az3b9doxkTeKpxdfAbsE
         oK12ZPC6o/Hv9BysCWdH6+ZppN5SJU3w41XoJlqxlI7AbofLMm/PZyIkcOD4KCzFsJIy
         tsAuyQCkpIWISxRL9SuynmT1B34UbH4rUWYTS2mE4LutPsWeh5JvuV7L4O1k4O4/5RG2
         O7fGn2VuQm1TdRt1aU1qScNMycTD9DV+nplQrfczgehjAvaNXL2UvcxEvIrMjlCzspiB
         ErBQ==
X-Gm-Message-State: AHQUAuaCKD610O3y6nov5GVVSCloh4Wf2tr5rDA7/zRNzuHs2IQL8DN+
        vkvZzS9G3GdugJNHusPHYWUc9A==
X-Google-Smtp-Source: AHgI3Iamsa3Ik9XV4LjWAIy8cg6gBN5T+YQ/cs9zGO4iqp1O2YCvPCFKiL2sCP5zrblaVykHSQQfrA==
X-Received: by 2002:a37:9c8f:: with SMTP id f137mr2695722qke.248.1551282138312;
        Wed, 27 Feb 2019 07:42:18 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id r24sm9908162qte.60.2019.02.27.07.42.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 07:42:17 -0800 (PST)
Date:   Wed, 27 Feb 2019 10:42:16 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        netdev@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Quentin Perret <quentin.perret@arm.com>, rcu@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xdp-newbies@vger.kernel.org, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH v2 3/6] sched/cpufreq: Annotate cpufreq_update_util_data
 pointer with __rcu
Message-ID: <20190227154216.GA248723@google.com>
References: <20190223063434.6793-1-joel@joelfernandes.org>
 <20190223063434.6793-4-joel@joelfernandes.org>
 <20190225211026.GX4072@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225211026.GX4072@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 01:10:26PM -0800, Paul E. McKenney wrote:
> On Sat, Feb 23, 2019 at 01:34:31AM -0500, Joel Fernandes (Google) wrote:
> > Recently I added an RCU annotation check to rcu_assign_pointer(). All
> > pointers assigned to RCU protected data are to be annotated with __rcu
> > inorder to be able to use rcu_assign_pointer() similar to checks in
> > other RCU APIs.
> > 
> > This resulted in a sparse error: kernel//sched/cpufreq.c:41:9: sparse:
> > error: incompatible types in comparison expression (different address
> > spaces)
> > 
> > Fix this by annotating cpufreq_update_util_data pointer with __rcu. This
> > will also help sparse catch any future RCU misuage bugs.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> From an RCU perspective:
> 
> Reviewed-by: Paul E. McKenney <paulmck@linux.ibm.com>

Thanks a lot Paul.

Peter, Rafael, Steve,
Are you Ok with the patches 3-6? It will be nice to quiet down sparse.

thanks,

 - Joel

> > ---
> >  kernel/sched/cpufreq.c | 2 +-
> >  kernel/sched/sched.h   | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq.c
> > index 22bd8980f32f..e316ee7bb2e5 100644
> > --- a/kernel/sched/cpufreq.c
> > +++ b/kernel/sched/cpufreq.c
> > @@ -7,7 +7,7 @@
> >   */
> >  #include "sched.h"
> >  
> > -DEFINE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
> > +DEFINE_PER_CPU(struct update_util_data __rcu *, cpufreq_update_util_data);
> >  
> >  /**
> >   * cpufreq_add_update_util_hook - Populate the CPU's update_util_data pointer.
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index d04530bf251f..2ab545d40381 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -2166,7 +2166,7 @@ static inline u64 irq_time_read(int cpu)
> >  #endif /* CONFIG_IRQ_TIME_ACCOUNTING */
> >  
> >  #ifdef CONFIG_CPU_FREQ
> > -DECLARE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
> > +DECLARE_PER_CPU(struct update_util_data __rcu *, cpufreq_update_util_data);
> >  
> >  /**
> >   * cpufreq_update_util - Take a note about CPU utilization changes.
> > -- 
> > 2.21.0.rc0.258.g878e2cd30e-goog
> > 
> 

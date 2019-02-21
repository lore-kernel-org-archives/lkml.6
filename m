Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69915C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3730D2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="yKG9kAR3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfBUPVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:21:42 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39635 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbfBUPVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:21:42 -0500
Received: by mail-qt1-f195.google.com with SMTP id o6so31871803qtk.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 07:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2OcfaLdiZJ/DrcUmYGdobOiPniYbCbJZcx2QAY5FqJE=;
        b=yKG9kAR3cFhThVITkHFpqeKZ19spKE9FoF8RXXFoPWtzTJEINdUL9NjVeUSjGgIvpU
         t6Agz8TVbm2+EQSEaXfA98gzdr8AmxznEkJ44+cnYfCLNPdv6YHwVtqiX/5cbb1QxcMZ
         xQy2qobblBIqoWahRQBYm39qt5j8yfVXoeM2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2OcfaLdiZJ/DrcUmYGdobOiPniYbCbJZcx2QAY5FqJE=;
        b=Pa7xmtO4guhhi2kHsvvDc1zy3h0C4gPZf/zWnxdt706yhbKjVZc9PVDffK6DWqhn2s
         c1S4IXMqEUuJbp5vGV3eKKiaZxeAFyie7EA+13wXc9BsE4PtUvLWOPMS4YWuuj0fqQC9
         E4NzhpGR93hYymrJXQ++S1SU8E/5Ze8/Zu64g1SMHhvktnNfC1JVfwGMKcxSfwZ4sfFj
         74jpk77b0hF7WMckPf+a0d40y0nl3ylnZv+NUgvhx3RCkQjuUfqJTHsU/qfGxvGGDxKr
         IqjEePjh7vSpYrxiLpcdB0uCQblpHWQnWdb4YMasHZeb7vksKZR/EtDdgqMK/WX2MqaK
         ZXmw==
X-Gm-Message-State: AHQUAub128ly+R3kUdaNQTRe5ZwZypTtuEszfvX2846lX2KyV+rK60XW
        iyLDL+QtTIBoqza+zngy8m3ZXQ==
X-Google-Smtp-Source: AHgI3IYaKXPenwj0UlCVky9qpVGMk1TU9VaHIXvXb8FPwjD0AJNp6uBg7VjF0WvjRkgp9ndQmmTeJw==
X-Received: by 2002:ac8:2fc8:: with SMTP id m8mr31033726qta.83.1550762500642;
        Thu, 21 Feb 2019 07:21:40 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id p15sm14830780qta.81.2019.02.21.07.21.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 07:21:39 -0800 (PST)
Date:   Thu, 21 Feb 2019 10:21:39 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        Ingo Molnar <mingo@redhat.com>,
        "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        netdev@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.ibm.com>,
        rcu@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        xdp-newbies@vger.kernel.org, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH RFC 3/5] sched/cpufreq: Fix incorrect RCU API usage
Message-ID: <20190221152139.GB19213@google.com>
References: <20190221054942.132388-1-joel@joelfernandes.org>
 <20190221054942.132388-4-joel@joelfernandes.org>
 <20190221091805.GX32477@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221091805.GX32477@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 10:18:05AM +0100, Peter Zijlstra wrote:
> On Thu, Feb 21, 2019 at 12:49:40AM -0500, Joel Fernandes (Google) wrote:
> > @@ -34,8 +34,12 @@ void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
> >  	if (WARN_ON(!data || !func))
> >  		return;
> >  
> > -	if (WARN_ON(per_cpu(cpufreq_update_util_data, cpu)))
> > +	rcu_read_lock();
> > +	if (WARN_ON(rcu_dereference(per_cpu(cpufreq_update_util_data, cpu)))) {
> > +		rcu_read_unlock();
> >  		return;
> > +	}
> > +	rcu_read_unlock();
> >  
> >  	data->func = func;
> >  	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), data);
> 
> This doesn't make any kind of sense to me.
> 

As per the rcu_assign_pointer() line, I inferred that
cpufreq_update_util_data is expected to be RCU protected. Reading the pointer
value of RCU pointers generally needs to be done from RCU read section, and
using rcu_dereference() (or using rcu_access()).

In this patch, I changed cpufreq_update_util_data to be __rcu annotated to
avoid the sparse error thrown by rcu_assign_pointer().

Instead of doing that, If your intention here is RELEASE barrier, should I
just replace in this function:
	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), data);
with:
	smp_store_release(per_cpu(cpufreq_update_util_data, cpu), data))
?

It would be nice IMO to be explicit about the intention of release/publish
semantics by using smp_store_release().

thanks,

 - Joel


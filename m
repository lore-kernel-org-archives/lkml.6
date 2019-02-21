Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C85C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32BE2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="NUkDyIfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfBURNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:13:16 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38724 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfBURNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 12:13:15 -0500
Received: by mail-qk1-f194.google.com with SMTP id p15so4707314qkl.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 09:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=41DJd/jPexbjxvgsSyMtotGUuKs1Czyv7tGoT1h60KM=;
        b=NUkDyIfCjApsV4ZYCcxVhXbcYB4tde9vxi5EkAlTQvXRu9Gl1dkXcu7a5kLo03gyil
         Snw+QY1LdgTcXMaa/cluhgr+XbKsR9vJYfV/DkmZw+z3uuQq+9MufIgHLK7iDg04OZ2C
         yfBCIYjdUWWXF3IlPKAGbJeSGSoedJNcxluig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=41DJd/jPexbjxvgsSyMtotGUuKs1Czyv7tGoT1h60KM=;
        b=QOapbtOaWcQzXxmU7ozS/51iZn8a52Ysshibxu6yumpwz4Vo0Z0RWi43bajQRc6xn5
         kbYuPREwcmIXN2nTogMZzBpL/mF2M4swVPYewtqiRdnURapaI6O80MVYnAloYj7fxtk0
         ASiez7urpxVkh5626ze/tpaSLTRuHtrnzoxb3rylDJ5bEYdFumb+D2eMP05JheOwZyhr
         raMgKqEQW6XeXXFrpXfDBhuPCgegz4gur5692jepyQ1ZcEx4Rez/ExspZMQyFAtRbddn
         WYf+e/t3m8gjK22QEzo+bIbLNCpaQuUhCvRoE6LRP48Kvau9ggyElrvuSAxp6eaEc/YA
         Qv5g==
X-Gm-Message-State: AHQUAuagI47CgLf48nTbUJxVWTlqpJsnxb+CnnLsiddwsc1hqvrN6Mt+
        XUidjg+RXPw7xgGHL7VF89eNkg==
X-Google-Smtp-Source: AHgI3IbfzzzZ88sploh4dDYxzRY2NObMLMZPcHodt+kMbEUHkhN7VjWE2CL6nLEKzCfDDednB73/Ug==
X-Received: by 2002:a37:83c6:: with SMTP id f189mr9459033qkd.196.1550769194098;
        Thu, 21 Feb 2019 09:13:14 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id 14sm323833qkf.23.2019.02.21.09.13.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 09:13:12 -0800 (PST)
Date:   Thu, 21 Feb 2019 12:13:11 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
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
        netdev@vger.kernel.org, rcu@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        xdp-newbies@vger.kernel.org, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH RFC 3/5] sched/cpufreq: Fix incorrect RCU API usage
Message-ID: <20190221171311.GA118415@google.com>
References: <20190221054942.132388-1-joel@joelfernandes.org>
 <20190221054942.132388-4-joel@joelfernandes.org>
 <20190221091805.GX32477@hirez.programming.kicks-ass.net>
 <20190221152139.GB19213@google.com>
 <20190221153117.GT32494@hirez.programming.kicks-ass.net>
 <20190221155218.GZ11787@linux.ibm.com>
 <20190221161144.GU32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221161144.GU32494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 05:11:44PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 21, 2019 at 07:52:18AM -0800, Paul E. McKenney wrote:
> > On Thu, Feb 21, 2019 at 04:31:17PM +0100, Peter Zijlstra wrote:
> > > On Thu, Feb 21, 2019 at 10:21:39AM -0500, Joel Fernandes wrote:
> > > > On Thu, Feb 21, 2019 at 10:18:05AM +0100, Peter Zijlstra wrote:
> > > > > On Thu, Feb 21, 2019 at 12:49:40AM -0500, Joel Fernandes (Google) wrote:
> > > > > > @@ -34,8 +34,12 @@ void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
> > > > > >  	if (WARN_ON(!data || !func))
> > > > > >  		return;
> > > > > >  
> > > > > > -	if (WARN_ON(per_cpu(cpufreq_update_util_data, cpu)))
> > > > > > +	rcu_read_lock();
> > > > > > +	if (WARN_ON(rcu_dereference(per_cpu(cpufreq_update_util_data, cpu)))) {
> > > > > > +		rcu_read_unlock();
> > > > > >  		return;
> > > > > > +	}
> > > > > > +	rcu_read_unlock();
> > > > > >  
> > > > > >  	data->func = func;
> > > > > >  	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), data);
> 
> > For whatever it is worth, in that case it could use rcu_access_pointer().
> > And this primitive does not do the lockdep check for being within an RCU
> > read-side critical section.  As Peter says, if there is no dereferencing,
> > there can be no use-after-free bug, so the RCU read-side critical is
> > not needed.
> 
> On top of that, I suspect this is under the write-side lock (we're doing
> assignment after all).

Yes it is under a policy->rwsem, just confirmed that.

And indeed rcu_read_lock() is not needed here in this patch, thanks for
pointing that out. Sometimes the word "dereference" plays some visual tricks
and in this case tempted me to add an RCU reader section ;-) Assuming you
guys are in agreement with usage of rcu_access_pointer() here to keep sparse
happy, I'll rework the patch accordingly and resubmit with that.

thanks!

 - Joel




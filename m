Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98900C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 667FD2075A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K2ZBnd88"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbfBUQMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:12:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45072 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfBUQMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:12:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+afU/7gPddCKUBDq0d2rahTcTZQRyFY7yXaqsaIIiY0=; b=K2ZBnd881nfOv0p2biUTm2bsQ
        2y19KpXZLPRe4bJDBtpWJzOvsYr3jmdXlgf4UeWm9iGGQB9Cj27r1McuFSVcie7aIXYnxXwbItDHL
        zCwDoEF3eo5DZfBZcuQQN+V1D4hnZSD8m7Yr3/VZXkHsJVdhpsbkUx9GTXPUiXu4PdRzzid+cUWQU
        RvagWeh8OrcbrEEdTqgjj9lx87t/hT3vLYv5D857ipKKmqfC1BF2gDC4REr7dJ6V8t7PM9nkKOayI
        rMiXrmxO8q2gxzYuVAOkkzMDlTr43Fxp+Vr42qm+RwTTcd9x+KtdIOkCkUxBfL4zhwXSHGMJuH4h8
        yCW9KAhKQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwqwt-0006aB-Ok; Thu, 21 Feb 2019 16:11:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F412A28B8C88B; Thu, 21 Feb 2019 17:11:44 +0100 (CET)
Date:   Thu, 21 Feb 2019 17:11:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
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
Message-ID: <20190221161144.GU32494@hirez.programming.kicks-ass.net>
References: <20190221054942.132388-1-joel@joelfernandes.org>
 <20190221054942.132388-4-joel@joelfernandes.org>
 <20190221091805.GX32477@hirez.programming.kicks-ass.net>
 <20190221152139.GB19213@google.com>
 <20190221153117.GT32494@hirez.programming.kicks-ass.net>
 <20190221155218.GZ11787@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221155218.GZ11787@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 07:52:18AM -0800, Paul E. McKenney wrote:
> On Thu, Feb 21, 2019 at 04:31:17PM +0100, Peter Zijlstra wrote:
> > On Thu, Feb 21, 2019 at 10:21:39AM -0500, Joel Fernandes wrote:
> > > On Thu, Feb 21, 2019 at 10:18:05AM +0100, Peter Zijlstra wrote:
> > > > On Thu, Feb 21, 2019 at 12:49:40AM -0500, Joel Fernandes (Google) wrote:
> > > > > @@ -34,8 +34,12 @@ void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
> > > > >  	if (WARN_ON(!data || !func))
> > > > >  		return;
> > > > >  
> > > > > -	if (WARN_ON(per_cpu(cpufreq_update_util_data, cpu)))
> > > > > +	rcu_read_lock();
> > > > > +	if (WARN_ON(rcu_dereference(per_cpu(cpufreq_update_util_data, cpu)))) {
> > > > > +		rcu_read_unlock();
> > > > >  		return;
> > > > > +	}
> > > > > +	rcu_read_unlock();
> > > > >  
> > > > >  	data->func = func;
> > > > >  	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), data);

> For whatever it is worth, in that case it could use rcu_access_pointer().
> And this primitive does not do the lockdep check for being within an RCU
> read-side critical section.  As Peter says, if there is no dereferencing,
> there can be no use-after-free bug, so the RCU read-side critical is
> not needed.

On top of that, I suspect this is under the write-side lock (we're doing
assignment after all).

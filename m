Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6865C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D9F2075A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oqxcEcRu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbfBUPbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:31:49 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36638 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfBUPbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:31:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/eQaoz239TKQfUHXIpEoiodA8p/xYR3qGQZwY36Notw=; b=oqxcEcRuccvGZCmVsKZvwtoGN
        Mu0n1fsl8gF4wnhYcrKz5Nqqoxo1Qq7kMpyEpYE4YGcPcKLCZWlWthGHRTBhkmBSudyCeQk9rX9yB
        zalrR5KsLkb3wskDfdAp+2uSwFJaCOrLcLd7TjWFEX8W94Q4uc69iz5wHlLcY29QLOB+oPtyDmMYw
        Elq/oCah4BtOaJJWxHLzJvvjty7PeOZIUaJh+sBvLd3X+16M7D70ii3HPtd4G/tJz4Mbr8esmv+r0
        9D1dq4Gq2C0BUh4fAigsBbhyz4+Hqg6Xx/i4ineQty7lRdY2u7msPNCu6skXQfJquau9s4Y5cOGZK
        j1VHsgevw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwqJi-00022p-Vv; Thu, 21 Feb 2019 15:31:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B82712030EE5E; Thu, 21 Feb 2019 16:31:17 +0100 (CET)
Date:   Thu, 21 Feb 2019 16:31:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
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
Message-ID: <20190221153117.GT32494@hirez.programming.kicks-ass.net>
References: <20190221054942.132388-1-joel@joelfernandes.org>
 <20190221054942.132388-4-joel@joelfernandes.org>
 <20190221091805.GX32477@hirez.programming.kicks-ass.net>
 <20190221152139.GB19213@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221152139.GB19213@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 10:21:39AM -0500, Joel Fernandes wrote:
> On Thu, Feb 21, 2019 at 10:18:05AM +0100, Peter Zijlstra wrote:
> > On Thu, Feb 21, 2019 at 12:49:40AM -0500, Joel Fernandes (Google) wrote:
> > > @@ -34,8 +34,12 @@ void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
> > >  	if (WARN_ON(!data || !func))
> > >  		return;
> > >  
> > > -	if (WARN_ON(per_cpu(cpufreq_update_util_data, cpu)))
> > > +	rcu_read_lock();
> > > +	if (WARN_ON(rcu_dereference(per_cpu(cpufreq_update_util_data, cpu)))) {
> > > +		rcu_read_unlock();
> > >  		return;
> > > +	}
> > > +	rcu_read_unlock();
> > >  
> > >  	data->func = func;
> > >  	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), data);
> > 
> > This doesn't make any kind of sense to me.
> > 
> 
> As per the rcu_assign_pointer() line, I inferred that
> cpufreq_update_util_data is expected to be RCU protected. Reading the pointer
> value of RCU pointers generally needs to be done from RCU read section, and
> using rcu_dereference() (or using rcu_access()).
> 
> In this patch, I changed cpufreq_update_util_data to be __rcu annotated to
> avoid the sparse error thrown by rcu_assign_pointer().
> 
> Instead of doing that, If your intention here is RELEASE barrier, should I
> just replace in this function:
> 	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), data);
> with:
> 	smp_store_release(per_cpu(cpufreq_update_util_data, cpu), data))
> ?
> 
> It would be nice IMO to be explicit about the intention of release/publish
> semantics by using smp_store_release().

No, it is RCU managed, it should be RCU. The problem is that the hunk
above is utter crap.

All that does is read the pointer, it never actually dereferences it.

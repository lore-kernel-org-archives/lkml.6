Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BABC00319
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B8F2075A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TY0N5Az3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbfBUPbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:31:37 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36598 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfBUPbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:31:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=H2AlPf/San2lH+W5wwdKet9prltcvmYRTKXWCKIfSww=; b=TY0N5Az39TgIvC740C8G8lm1J
        UdXrhFrJoKZozRHHFymJfOWOEzjaS8w8q2r/MlzsVS81u4OEprd7WPYqenFm0/310G/6hBkc7FFX2
        3ltei01yEDDPhzzSQTlaXOLDnHbevN+NTOn0k23qvjsBUk9AxMeFZ7MC85N4wCvPE7JL56kIWUnQo
        tqUL+iVjRDOR1iO/tF+bhycyT2ql3aBbb7t5mPNZeZkmvcRR+/22DC7obFYWZrNfpT+ALT35y+Ucp
        Nrp9vkb4bAzYPEEgAh+J4p7gF+5bT0SSPVLyglgG9+CApCCzJpZDVRpfYhPO8P10MMNxtWWa3i53A
        hzGJezN+g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwqIE-00021n-C0; Thu, 21 Feb 2019 15:29:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 908DD2030EE5E; Thu, 21 Feb 2019 16:29:44 +0100 (CET)
Date:   Thu, 21 Feb 2019 16:29:44 +0100
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
Subject: Re: [PATCH RFC 4/5] sched/topology: Annonate RCU pointers properly
Message-ID: <20190221152944.GS32494@hirez.programming.kicks-ass.net>
References: <20190221054942.132388-1-joel@joelfernandes.org>
 <20190221054942.132388-5-joel@joelfernandes.org>
 <20190221091944.GY32477@hirez.programming.kicks-ass.net>
 <20190221151057.GA19213@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221151057.GA19213@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 10:10:57AM -0500, Joel Fernandes wrote:
> Hi Peter,
> 
> Thanks for taking a look.
> 
> On Thu, Feb 21, 2019 at 10:19:44AM +0100, Peter Zijlstra wrote:
> > On Thu, Feb 21, 2019 at 12:49:41AM -0500, Joel Fernandes (Google) wrote:
> > 
> > > Also replace rcu_assign_pointer call on rq->sd with WRITE_ONCE. This
> > > should be sufficient for the rq->sd initialization.
> > 
> > > @@ -668,7 +668,7 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
> > >  
> > >  	rq_attach_root(rq, rd);
> > >  	tmp = rq->sd;
> > > -	rcu_assign_pointer(rq->sd, sd);
> > > +	WRITE_ONCE(rq->sd, sd);
> > >  	dirty_sched_domain_sysctl(cpu);
> > >  	destroy_sched_domains(tmp);
> > 
> > Where did the RELEASE barrier go?
> > 
> > That was a publish operation, now it is not.
> 
> Funny thing is, initially I had written this patch with smp_store_release()
> instead of WRITE_ONCE, but checkpatch complaints with that since it needs a
> comment on top of it, and I wasn't sure if RELEASE barrier was the intent of
> using rcu_assign_pointer (all the more reason to replace it with something
> more explicit).
> 
> I will replace it with the following and resubmit it then:
> 
> /* Release barrier */
> smp_store_release(&rq->sd, sd);
> 
> Or do we want to just drop the "Release barrier" comment and live with the
> checkpatch warning?

How about we keep using rcu_assign_pointer(), the whole sched domain
tree is under rcu; peruse that destroy_sched_domains() function for
instance.

Also check how for_each_domain() uses rcu_dereference().

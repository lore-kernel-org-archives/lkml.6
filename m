Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E4CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E82D2086A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z2Ehd2Vf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfBUJUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:20:43 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56442 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfBUJUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:20:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AccFzJ3uYhK/np+7aunm21cKSFWXmp6vGCUzFdRuplc=; b=Z2Ehd2VfhBgBJ0U4T/UHNKgT9
        xwJeVYYIubzvX+x4NY9w0tDJHF95lmtSTsgfvCCSVDLL92Elz4E5Ab5ZuzEtDUUxaaqXNrE30wFaB
        1S8SHwN3Qvz7G9KyISOFHQuxcABmXv9nkAYcdMmLyrtUsYP/sJluBhrKqsRlfsxzIifAbOUgtl2iT
        3xiJGjLPhGmT7pmWJ5Igjq/c9N/VYy1XEzsDVk83W81TggCsCCiafaDrE9GWCpOHPUt1oKKQkgI4h
        B5P2Kv8dkrozF+w9kkjTONap8Loxx62l+TPvhNc9HJxJYfrSATjERUUKfe3WyOT9enojUdrERUd07
        bNc+8te7Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwkWB-0006uY-8l; Thu, 21 Feb 2019 09:19:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DA0FB2139CDFF; Thu, 21 Feb 2019 10:19:44 +0100 (CET)
Date:   Thu, 21 Feb 2019 10:19:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
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
Message-ID: <20190221091944.GY32477@hirez.programming.kicks-ass.net>
References: <20190221054942.132388-1-joel@joelfernandes.org>
 <20190221054942.132388-5-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221054942.132388-5-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 12:49:41AM -0500, Joel Fernandes (Google) wrote:

> Also replace rcu_assign_pointer call on rq->sd with WRITE_ONCE. This
> should be sufficient for the rq->sd initialization.

> @@ -668,7 +668,7 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
>  
>  	rq_attach_root(rq, rd);
>  	tmp = rq->sd;
> -	rcu_assign_pointer(rq->sd, sd);
> +	WRITE_ONCE(rq->sd, sd);
>  	dirty_sched_domain_sysctl(cpu);
>  	destroy_sched_domains(tmp);

Where did the RELEASE barrier go?

That was a publish operation, now it is not.

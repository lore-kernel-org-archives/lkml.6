Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DF3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF55214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kIAemxbp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfBUJUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:20:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33424 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfBUJUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:20:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wP//jFvsGdNSawgJBIo/KKWC9LGNeQdk4UowQ5cHBuU=; b=kIAemxbpBandbbJU8UFGKf9u+
        d/uo+EwMEvmj+W34ozPy+phWNNrJVc84p1HF0OGxOdOKkyagqWLvFsGYgPRmSHV/+rLZBwLhOOmv/
        bvwmJjJvwoUfRGfHgkkzdDhpSHM78/XtXa07fvbFxSHUeycyFwRP0fts4b8PLO/BCbmvLNCZkMZVb
        JngdLA98YrTBEVog6MG9sB9TDlkgjJgYX5LFuI3GhlAAxCiVr3JdVP3WygXdQak08WAiW37mdzW+l
        nHtiGBP12sf76jMMcf+xC2e0vSXqiXNxSx3mEWgfUFQ5V8kYDAGrQYEbadBkg1cMuK6Jx4KPrv3UG
        G5unB8urQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwkWk-0007v3-ED; Thu, 21 Feb 2019 09:20:22 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CE4D82139CDFF; Thu, 21 Feb 2019 10:20:20 +0100 (CET)
Date:   Thu, 21 Feb 2019 10:20:20 +0100
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
Subject: Re: [PATCH RFC 5/5] rcuwait: Replace rcu_assign_pointer() with
 WRITE_ONCE
Message-ID: <20190221092020.GZ32477@hirez.programming.kicks-ass.net>
References: <20190221054942.132388-1-joel@joelfernandes.org>
 <20190221054942.132388-6-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221054942.132388-6-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 12:49:42AM -0500, Joel Fernandes (Google) wrote:
> This suppresses a sparse error generated due to the recently added
> rcu_assign_pointer sparse check below. It seems WRITE_ONCE should be
> sufficient here.
> 
> >> kernel//locking/percpu-rwsem.c:162:9: sparse: error: incompatible
> types in comparison expression (different address spaces)
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  include/linux/rcuwait.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/rcuwait.h b/include/linux/rcuwait.h
> index 90bfa3279a01..9e5b4760e6c2 100644
> --- a/include/linux/rcuwait.h
> +++ b/include/linux/rcuwait.h
> @@ -44,7 +44,7 @@ extern void rcuwait_wake_up(struct rcuwait *w);
>  	 */                                                             \
>  	WARN_ON(current->exit_state);                                   \
>  									\
> -	rcu_assign_pointer((w)->task, current);				\
> +	WRITE_ONCE((w)->task, current);					\
>  	for (;;) {							\
>  		/*							\
>  		 * Implicit barrier (A) pairs with (B) in		\

Distinct lack of justification for loosing the RELEASE again.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752474AbeEOBBe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 21:01:34 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42515 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752139AbeEOBBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 21:01:32 -0400
X-Google-Smtp-Source: AB8JxZpvXtSRoflr3BH4fkQYrqULSpfwonKK1JjvWyQJ/F31p9hwD6jnrNbyx3vpplZeweKD2Tb9sw==
Date: Mon, 14 May 2018 18:01:31 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: Re: [PATCH RFC 7/8] rcu: trace CleanupMore condition only if needed
Message-ID: <20180515010131.GF209519@joelaf.mtv.corp.google.com>
References: <20180514031541.67247-1-joel@joelfernandes.org>
 <20180514031541.67247-8-joel@joelfernandes.org>
 <20180514192028.GG26088@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514192028.GG26088@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 12:20:28PM -0700, Paul E. McKenney wrote:
> On Sun, May 13, 2018 at 08:15:40PM -0700, Joel Fernandes (Google) wrote:
> > Currently the tree RCU clean up code records a CleanupMore trace event
> > even if the GP was already in progress. This makes CleanupMore show up
> > twice for no reason. Avoid it.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Good catch, and I applied this patch.  I did rework the commit log
> a bit, so please look it over to make sure I didn't mess it up.
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 52c4e689efd975f5383895b1bc1b91bc90fdd372
> Author: Joel Fernandes (Google) <joel@joelfernandes.org>
> Date:   Sun May 13 20:15:40 2018 -0700
> 
>     rcu: Produce last "CleanupMore" trace only if late-breaking request
>     
>     Currently the tree RCU clean-up code records a "CleanupMore" trace
>     event in response to late-arriving grace-period requests even if the
>     grace period was already requested. This makes "CleanupMore" show up an
>     extra time (in addition to once for each rcu_node structure that was
>     previously marked with the request) for no good reason.  This commit
>     therefore avoids emitting this trace message unless the only if the only
>     request for this next grace period arrived during or after the cleanup
>     scan of the rcu_node structures.

Yes, this is fine except "unless the only if the only" should be "unless the".

thanks,

- Joel

>     
>     Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 8063a0478870..de6447dd73de 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2072,7 +2072,7 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
>  	rsp->gp_state = RCU_GP_IDLE;
>  	/* Check for GP requests since above loop. */
>  	rdp = this_cpu_ptr(rsp->rda);
> -	if (ULONG_CMP_LT(rnp->gp_seq, rnp->gp_seq_needed)) {
> +	if (!needgp && ULONG_CMP_LT(rnp->gp_seq, rnp->gp_seq_needed)) {
>  		trace_rcu_this_gp(rnp, rdp, rnp->gp_seq_needed,
>  				  TPS("CleanupMore"));
>  		needgp = true;
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752506AbeEOBCt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 21:02:49 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43852 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752145AbeEOBCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 21:02:48 -0400
X-Google-Smtp-Source: AB8JxZrm/+eZav6cRE4wqB3daEzuI/LTKMT8Ue4hBMXhX5eC7skDFtOS5JafsnvxDJdLWls9DB9gLg==
Date: Mon, 14 May 2018 18:02:47 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: Re: [PATCH RFC 8/8] rcu: Fix cpustart tracepoint gp_seq number
Message-ID: <20180515010247.GG209519@joelaf.mtv.corp.google.com>
References: <20180514031541.67247-1-joel@joelfernandes.org>
 <20180514031541.67247-9-joel@joelfernandes.org>
 <20180514203320.GK26088@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514203320.GK26088@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 01:33:20PM -0700, Paul E. McKenney wrote:
> On Sun, May 13, 2018 at 08:15:41PM -0700, Joel Fernandes (Google) wrote:
> > cpustart shows a stale gp_seq. This is because rdp->gp_seq is updated
> > only at the end of the __note_gp_changes function. For this reason, use
> > rnp->gp_seq instead. I believe we can't update rdp->gp_seq too early so
> > lets just use the gp_seq from rnp instead.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> I took this one with the usual commit-log update.  Please take a look!

Looks good, thanks!

- Joel


> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 3e14c6a5225d201776edd9a96d9c9b4435855446
> Author: Joel Fernandes (Google) <joel@joelfernandes.org>
> Date:   Sun May 13 20:15:41 2018 -0700
> 
>     rcu: Fix cpustart tracepoint gp_seq number
>     
>     The "cpustart" trace event shows a stale gp_seq. This is because it uses
>     rdp->gp_seq, which is updated only at the end of the __note_gp_changes()
>     function. This commit therefore instead uses rnp->gp_seq.
>     
>     An alternative fix would be to update rdp->gp_seq earlier, but this would
>     break RCU's detection of the beginning of a new-to-this-CPU grace period.
>     
>     Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index de6447dd73de..23b855f5c5cb 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1796,7 +1796,7 @@ static bool __note_gp_changes(struct rcu_state *rsp, struct rcu_node *rnp,
>  		 * set up to detect a quiescent state, otherwise don't
>  		 * go looking for one.
>  		 */
> -		trace_rcu_grace_period(rsp->name, rdp->gp_seq, TPS("cpustart"));
> +		trace_rcu_grace_period(rsp->name, rnp->gp_seq, TPS("cpustart"));
>  		need_gp = !!(rnp->qsmask & rdp->grpmask);
>  		rdp->cpu_no_qs.b.norm = need_gp;
>  		rdp->rcu_qs_ctr_snap = __this_cpu_read(rcu_dynticks.rcu_qs_ctr);
> 

Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBFFC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 02:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E779F20666
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 02:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E779F20666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeH3GAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 02:00:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbeH3GAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 02:00:14 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A818C20647;
        Thu, 30 Aug 2018 02:00:28 +0000 (UTC)
Date:   Wed, 29 Aug 2018 22:00:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 0/52] Remove rcu_state pointers for
 v4.20/v5.0
Message-ID: <20180829220026.3579e9a1@vmware.local.home>
In-Reply-To: <20180829223830.GA1800@linux.vnet.ibm.com>
References: <20180829223830.GA1800@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018 15:38:30 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> Hello!
> 
> This commit does RCU-consolidation cleanups that get rid of pointers to
> the sole remaining rcu_state structure:
> 
> 1-40:	Remove the "rsp" parameter from numerous functions, given that
> 	the corresponding argument will always be &rcu_state.

Hmm, couldn't 1-40 have been made into a single patch?

-- Steve

> 
> 41.	Remove rcu_data structure's ->rsp field, now that it always
> 	contains a pointer to rcu_state.
> 
> 42.	Remove non-flavor-traversal rsp local variable from tree_plugin.h.
> 
> 43.	Remove the for_each_rcu_flavor() flavor-traversal macro, given
> 	that there is now only ever one flavor to traverse.
> 
> 44.	Simplify rcutorture_get_gp_data() based on there now being only
> 	one rcu_state structure.
> 
> 45.	Restructure rcu_check_gp_kthread_starvation() based on there
> 	now being only one rcu_state structure.
> 
> 46.	Restructure RCU CPU stall warnings based on there now being only
> 	one rcu_state structure.
> 
> 47.	Restructure grace-period management code based on there now being
> 	only one rcu_state structure.
> 
> 48.	Restructure callback registration/invocation code based on there
> 	now being only one rcu_state structure.
> 
> 49.	Restructure quiescent-state and grace-period-nonstart code based
> 	on there now being only one rcu_state structure.
> 
> 50.	Restructure rcu_barrier() based on there now being only one
> 	rcu_state structure.
> 
> 51.	Restructure initialization code based on there now being only
> 	one rcu_state structure.
> 
> 52.	Fix typo in force_qs_rnp()'s parameter's parameter, which was
> 	located by searching for "rsp".
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
>  Documentation/RCU/Design/Data-Structures/Data-Structures.html |   23 
>  kernel/rcu/rcu.h                                              |   28 
>  kernel/rcu/srcutree.c                                         |    4 
>  kernel/rcu/tree.c                                             | 1261 ++++------
>  kernel/rcu/tree.h                                             |   29 
>  kernel/rcu/tree_exp.h                                         |  209 -
>  kernel/rcu/tree_plugin.h                                      |  203 -
>  7 files changed, 784 insertions(+), 973 deletions(-)


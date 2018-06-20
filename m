Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1723FC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A615220874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A615220874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754324AbeFTNdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:33:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753594AbeFTNdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:33:12 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 812E520872;
        Wed, 20 Jun 2018 13:33:11 +0000 (UTC)
Date:   Wed, 20 Jun 2018 09:33:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     jiangshanlai@gmail.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        joel@joelfernandes.org
Subject: Re: [RFC 1/2] rcu: Do prepare and cleanup idle depending on
 in_nmi()
Message-ID: <20180620093309.7d07715a@gandalf.local.home>
In-Reply-To: <1529484440-20634-1-git-send-email-byungchul.park@lge.com>
References: <1529484440-20634-1-git-send-email-byungchul.park@lge.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2018 17:47:19 +0900
Byungchul Park <byungchul.park@lge.com> wrote:

> Get rid of dependency on ->dynticks_nmi_nesting.

This is not a trivial change. Can you please explain the rational and
background in the change log. Add enough context here to know why this
change is needed.

Thanks!

-- Steve

> 
> Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> ---
>  kernel/rcu/tree.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index deb2508..59ae94e 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -797,6 +797,11 @@ void rcu_nmi_exit(void)
>  		return;
>  	}
>  
> +	if (!in_nmi()) {
> +		rcu_prepare_for_idle();
> +		rcu_dynticks_task_enter();
> +	}
> +
>  	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
>  	trace_rcu_dyntick(TPS("Startirq"), rdtp->dynticks_nmi_nesting, 0, rdtp->dynticks);
>  	WRITE_ONCE(rdtp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
> @@ -824,14 +829,8 @@ void rcu_nmi_exit(void)
>   */
>  void rcu_irq_exit(void)
>  {
> -	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
> -
>  	lockdep_assert_irqs_disabled();
> -	if (rdtp->dynticks_nmi_nesting == 1)
> -		rcu_prepare_for_idle();
>  	rcu_nmi_exit();
> -	if (rdtp->dynticks_nmi_nesting == 0)
> -		rcu_dynticks_task_enter();
>  }
>  
>  /*
> @@ -944,6 +943,11 @@ void rcu_nmi_enter(void)
>  	if (rcu_dynticks_curr_cpu_in_eqs()) {
>  		rcu_dynticks_eqs_exit();
>  		incby = 1;
> +
> +		if (!in_nmi()) {
> +			rcu_dynticks_task_exit();
> +			rcu_cleanup_after_idle();
> +		}
>  	}
>  	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
>  			  rdtp->dynticks_nmi_nesting,
> @@ -977,14 +981,8 @@ void rcu_nmi_enter(void)
>   */
>  void rcu_irq_enter(void)
>  {
> -	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
> -
>  	lockdep_assert_irqs_disabled();
> -	if (rdtp->dynticks_nmi_nesting == 0)
> -		rcu_dynticks_task_exit();
>  	rcu_nmi_enter();
> -	if (rdtp->dynticks_nmi_nesting == 1)
> -		rcu_cleanup_after_idle();
>  }
>  
>  /*


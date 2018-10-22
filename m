Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD10C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135F720663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135F720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeJVXnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 19:43:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54412 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727669AbeJVXnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 19:43:08 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A42974E91C;
        Mon, 22 Oct 2018 15:24:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.106])
        by smtp.corp.redhat.com (Postfix) with SMTP id BEE54105705D;
        Mon, 22 Oct 2018 15:24:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 22 Oct 2018 17:24:09 +0200 (CEST)
Date:   Mon, 22 Oct 2018 17:24:07 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH RFC kenrel/rcu] Eliminate BUG_ON() for sync.c
Message-ID: <20181022152406.GA7257@redhat.com>
References: <20181022145241.GA7488@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022145241.GA7488@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 22 Oct 2018 15:24:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22, Paul E. McKenney wrote:
>
> The sync.c file has a number of calls to BUG_ON(), which panics the
> kernel, which is not a good

Agreed.

I added these BUG_ON's for documentation when I was prototyping this code,
perhaps we can simply remove them.

> @@ -125,12 +125,12 @@ void rcu_sync_enter(struct rcu_sync *rsp)
>  		rsp->gp_state = GP_PENDING;
>  	spin_unlock_irq(&rsp->rss_lock);
>  
> -	BUG_ON(need_wait && need_sync);
> -
>  	if (need_sync) {
>  		gp_ops[rsp->gp_type].sync();
>  		rsp->gp_state = GP_PASSED;
>  		wake_up_all(&rsp->gp_wait);
> +		if (WARN_ON_ONCE(need_wait))
> +			wait_event(rsp->gp_wait, rsp->gp_state == GP_PASSED);

This wait_event(gp_state == GP_PASSED) is pointless, note that this branch
does gp_state = GP_PASSED 2 lines above.

And if we add WARN_ON_ONCE(need_wait), then we should probably also add
WARN_ON_ONCE(need_sync) into the next "if (need_wait)" branch just for
symmetry.

So I'd suggest to either turn that BUG_ON(need_wait && need_sync) above
into WARN_ON_ONCE(wait && sync) or simply remove it.

Again, the only purpose of this BUG_ON() is to explain to the reader that
it is not (must not be) possible that, say, gp_state == GP_IDLE while
gp_count != 0.

----------------------------------------------------------------------------
Damn.

This suddenly reminds me that I rewrote this code completely, and you even
reviewed the new implementation and (iirc) acked it!

However, I failed to force myself to rewrite the comments, and that is why
I didn't send the "official" patch :/


May be some time...

Oleg.


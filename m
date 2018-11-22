Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22EDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7092A20685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7092A20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405734AbeKWBpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:45:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47674 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbeKWBpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 20:45:12 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B589C3164983;
        Thu, 22 Nov 2018 15:05:27 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.142])
        by smtp.corp.redhat.com (Postfix) with SMTP id 09B615C21E;
        Thu, 22 Nov 2018 15:05:25 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 22 Nov 2018 16:05:27 +0100 (CET)
Date:   Thu, 22 Nov 2018 16:05:24 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [Question] smp_wmb() in prepare_uprobe()
Message-ID: <20181122150524.GF28270@redhat.com>
References: <20181121224124.GB4016@andrea>
 <20181122123655.GD28270@redhat.com>
 <20181122134400.GA10327@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122134400.GA10327@andrea>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 22 Nov 2018 15:05:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22, Andrea Parri wrote:
>
> > See 142b18ddc81439acda4bc4231b291e99fe67d507 ("uprobes: Fix handle_swbp()
> > vs unregister() + register() race") and the comment above this rmb().
>
> Mmh..., at first glance, this suggests me that the above set_bit() and
> test_bit() to/from uprobe->flags are among these memory accesses.  But
> this doesn't make sense to me: these accesses do not "alternate" (i.e.,
> they both appear after the corresponding barrier..); instead I'd expect
> something like (on top of the above diff):
>
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 2d29977522017..a75b9a08dee54 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2178,10 +2178,18 @@ static void handle_swbp(struct pt_regs *regs)
>  	 * After we hit the bp, _unregister + _register can install the
>  	 * new and not-yet-analyzed uprobe at the same address, restart.
>  	 */
> -	smp_rmb(); /* pairs with the smp_wmb() in prepare_uprobe() */
>  	if (unlikely(!test_bit(UPROBE_COPY_INSN, &uprobe->flags)))
>  		goto out;
>
> +	/*
> +	 * Pairs with the smp_wmb() in prepare_uprobe().
> +	 *
> +	 * Guarantees that if we see the UPROBE_COPY_INSN bit set, then
> +	 * we must (can) also see the stores to &uprobe->arch performed
> +	 * by prepare_uprobe() (say).
> +	 */
> +	smp_rmb();

OOPS, you are right! Thanks.

Oleg.


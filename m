Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBFBC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57615214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gc+3AsB7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57615214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbeLFIRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:17:18 -0500
Received: from merlin.infradead.org ([205.233.59.134]:46346 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFIRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 03:17:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+4aWexOyAMuaR3Q8yxnhpD/XfI0eZvjTj4dnIj/xzSY=; b=Gc+3AsB73CX7Oh/POOqK5nYUT
        2ezVI8vKyu9L1PaUV7sR/ETaAfsaM8M/oO4GFd6+zTnEDVDH7l1Y258hsArAdwsuWBkzZ8VbpU9ab
        i8iYiS3gjNLU3A2nuDMk1gw7TQkjDY0uEhCzlZKU2D2tnv8JnmrSQRr46pod21V9vvNaOLLLcOJIx
        3plHguRdn1CUfYPE+NXjGhR2lihLv3bhlzGzpgDZiXutYm/HbR44xmVdSxolDYV64wrn5Ui8cvZ+K
        2chg7aR8UnEsmRLYqnW3SDtPZE377KpAhNDDplM+xaODdi2LDgHzsNSyMsjSykTKnmjoFuZIyi8uQ
        Kg7eOkbFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUoqL-0004vW-0f; Thu, 06 Dec 2018 08:17:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C7B2A2029F883; Thu,  6 Dec 2018 09:17:07 +0100 (CET)
Date:   Thu, 6 Dec 2018 09:17:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>, ldv@altlinux.org,
        esyr@redhat.com, Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 1/8] perf: Allow to block process in syscall tracepoints
Message-ID: <20181206081707.GF4234@hirez.programming.kicks-ass.net>
References: <20181205160509.1168-1-jolsa@kernel.org>
 <20181205160509.1168-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205160509.1168-2-jolsa@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 05:05:02PM +0100, Jiri Olsa wrote:
> @@ -10461,6 +10484,19 @@ SYSCALL_DEFINE5(perf_event_open,
>  			return -EINVAL;
>  	}
>  
> +	if (attr.block) {
> +		/*
> +		 * Allow only syscall tracepoints, check for syscall class
> +		 * is made in the tracepoint event_init callback.
> +		 */
> +		if (attr.type != PERF_TYPE_TRACEPOINT)
> +			return -EINVAL;
> +
> +		/* Allow to block only if we attach to a process. */
> +		if (pid == -1)
> +			return -EINVAL;
> +	}
> +
>  	/* Only privileged users can get physical addresses */
>  	if ((attr.sample_type & PERF_SAMPLE_PHYS_ADDR) &&
>  	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))

That's fairly horrible and will, when copied, lead to a giant mess.

Please see the whole exclusion patch set here:

  https://lkml.kernel.org/r/1543230756-15319-1-git-send-email-andrew.murray@arm.com

PERF_PMU_CAP_BLOCK sounds like something you'd want here.

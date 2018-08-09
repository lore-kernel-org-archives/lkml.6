Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4C0C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA3D21E21
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA3D21E21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732190AbeHIQmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 12:42:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39078 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730634AbeHIQmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 12:42:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3AE9540216EB;
        Thu,  9 Aug 2018 14:17:16 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6A9F710073B4;
        Thu,  9 Aug 2018 14:17:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  9 Aug 2018 16:17:16 +0200 (CEST)
Date:   Thu, 9 Aug 2018 16:17:13 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Milind Chabbi <chabbi.milind@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 4/5] perf/hw_breakpoint: Set breakpoint as disabled in
 modify_user_hw_breakpoint error path
Message-ID: <20180809141713.GB22636@redhat.com>
References: <20180809120305.20693-1-jolsa@kernel.org>
 <20180809120305.20693-5-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809120305.20693-5-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 09 Aug 2018 14:17:16 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 09 Aug 2018 14:17:16 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09, Jiri Olsa wrote:
>
> @@ -523,8 +523,10 @@ int modify_user_hw_breakpoint(struct perf_event *bp, struct perf_event_attr *att
>  		perf_event_disable(bp);
>
>  	err = modify_user_hw_breakpoint_check(bp, attr, false);
> -	if (err)
> +	if (err) {
> +		bp->attr.disabled = 1;
>  		return err;

Yes, but on the second thought... Can't we simply do

	int modify_user_hw_breakpoint(struct perf_event *bp, struct perf_event_attr *attr)
	{
		int err;

		/*
		 * modify_user_hw_breakpoint can be invoked with IRQs disabled and hence it
		 * will not be possible to raise IPIs that invoke __perf_event_disable.
		 * So call the function directly after making sure we are targeting the
		 * current task.
		 */
		if (irqs_disabled() && bp->ctx && bp->ctx->task == current)
			perf_event_disable_local(bp);
		else
			perf_event_disable(bp);

		err = modify_user_hw_breakpoint_check(bp, attr, false);

		if (!bp.attr->disabled)
			perf_event_enable(bp);

		return err;
	}

instead of this and the next patch?

We can do this because (as you pointed out) validate_hw_breakpoint() has already
gone in -tip tree, and (afaics) modify_user_hw_breakpoint_check() never changes
perf_event's state on failure, so we can safely "restart" this bp if it was enabled
before.

1. This is what we had before the recent f67b15037a7a50c57f72e69a6d59941ad90a0f0f
   "perf/hwbp: Simplify the perf-hwbp code, fix documentation".

   Note that this commit was actually the bug fix which introduced another problem
   fixed by your 2/5.

   But see above, perf_event_enable() is no longer unsafe after
   modify_user_hw_breakpoint_check(), we can restore the previous semantics.

2. This matches perf_event_modify_breakpoint(). Which btw can be simplified a bit,
   it too can simply do

		if (!bp->attr.disabled)
			_perf_event_enable(bp);

		return err;

Oleg.


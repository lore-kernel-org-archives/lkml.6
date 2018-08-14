Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D22BC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BFED2174C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BFED2174C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731882AbeHNNTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 09:19:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55890 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730067AbeHNNTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 09:19:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4C96E40200A3;
        Tue, 14 Aug 2018 10:32:34 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id B64622026D7E;
        Tue, 14 Aug 2018 10:32:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 14 Aug 2018 12:32:34 +0200 (CEST)
Date:   Tue, 14 Aug 2018 12:32:32 +0200
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
Subject: Re: [PATCH 5/5] perf/hw_breakpoint: Simplify breakpoint enable in
 perf_event_modify_breakpoint
Message-ID: <20180814103231.GC7268@redhat.com>
References: <20180810104730.3293-1-jolsa@kernel.org>
 <20180810104730.3293-6-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810104730.3293-6-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 14 Aug 2018 10:32:34 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 14 Aug 2018 10:32:34 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10, Jiri Olsa wrote:
>
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2867,16 +2867,11 @@ static int perf_event_modify_breakpoint(struct perf_event *bp,
>  	_perf_event_disable(bp);
>  
>  	err = modify_user_hw_breakpoint_check(bp, attr, true);
> -	if (err) {
> -		if (!bp->attr.disabled)
> -			_perf_event_enable(bp);
>  
> -		return err;
> -	}
> -
> -	if (!attr->disabled)
> +	if (!bp->attr.disabled)
>  		_perf_event_enable(bp);
> -	return 0;
> +
> +	return err;
>  }

Acked-by: Oleg Nesterov <oleg@redhat.com>


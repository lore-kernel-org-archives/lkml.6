Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE29C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BAF320652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BAF320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbeJVVpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 17:45:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:32851 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727587AbeJVVpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 17:45:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2018 06:26:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,412,1534834800"; 
   d="scan'208";a="243331380"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.212])
  by orsmga004.jf.intel.com with ESMTP; 22 Oct 2018 06:26:23 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, acme@kernel.org, jolsa@redhat.com,
        songliubraving@fb.com, eranian@google.com, tglx@linutronix.de,
        alexey.budankov@linux.intel.com, mark.rutland@arm.com,
        megha.dey@intel.com, frederic@kernel.org
Subject: Re: [RFC][PATCH] perf: Rewrite core context handling
In-Reply-To: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
References: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
Date:   Mon, 22 Oct 2018 16:26:22 +0300
Message-ID: <87lg6q6rk1.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> @@ -1926,8 +1920,9 @@ static void perf_group_detach(struct per
>  			add_event_to_groups(sibling, event->ctx);
>  
>  			if (sibling->state == PERF_EVENT_STATE_ACTIVE) {
> +				struct perf_event_pmu_context *pmu_ctx = event->pmu_ctx;
>  				struct list_head *list = sibling->attr.pinned ?
> -					&ctx->pinned_active : &ctx->flexible_active;
> +					&pmu_ctx->pinned_active : &pmu_ctx->flexible_active;
>  
>  				list_add_tail(&sibling->active_list, list);

Ok, since I'm getting to the bottom of things: the event::active_list is
actually event::active_entry, which also does exist, but is not used
anywhere other than its initialization. Let's maybe get rid of the _list?

Regards,
--
Alex

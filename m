Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CFFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48AA82075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfBVM5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 07:57:08 -0500
Received: from mga07.intel.com ([134.134.136.100]:64262 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbfBVM5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 07:57:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Feb 2019 04:57:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,399,1544515200"; 
   d="scan'208";a="126412110"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.178])
  by fmsmga008.fm.intel.com with ESMTP; 22 Feb 2019 04:57:05 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com
Subject: Re: [PATCH v1 1/1] perf: Optimistically use high order allocations for AUX buffers
In-Reply-To: <20190215114727.62648-2-alexander.shishkin@linux.intel.com>
References: <20190215114727.62648-1-alexander.shishkin@linux.intel.com> <20190215114727.62648-2-alexander.shishkin@linux.intel.com>
Date:   Fri, 22 Feb 2019 14:57:05 +0200
Message-ID: <87a7ioc76m.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Shishkin <alexander.shishkin@linux.intel.com> writes:

> Currently, the AUX buffer allocator will use high-order allocations
> for PMUs that don't support hardware scatter-gather chaining to ensure
> large contiguous blocks of pages, and always use an array of single
> pages otherwise.
>
> There is, however, a tangible performance benefit in using larger chunks
> of contiguous memory even in the latter case, that comes from not having
> to fetch the next page's address at every page boundary. In particular,
> a task running under Intel PT on an Atom CPU shows 1.5%-2% less runtime
> penalty with a single multi-page output region in snapshot mode (no PMI)
> than with multiple single-page output regions, from ~6% down to ~4%. For
> the snapshot mode it does make a difference as it is intended to run over
> long periods of time.
>
> For this reason, change the allocation policy to always optimistically
> start with the highest possible order when allocating pages for the AUX
> buffer, desceding until the allocation succeeds or order zero allocation
> fails.
>
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>

Does anybody want to pick this up?

Thanks,
--
Alex

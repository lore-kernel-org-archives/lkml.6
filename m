Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78601C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5137E20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733290AbfAaNKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:10:22 -0500
Received: from mga09.intel.com ([134.134.136.24]:58931 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726153AbfAaNKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:10:22 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 05:10:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,544,1539673200"; 
   d="scan'208";a="139509375"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga002.fm.intel.com with ESMTP; 31 Jan 2019 05:10:20 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id C2D93301201; Thu, 31 Jan 2019 05:10:20 -0800 (PST)
Date:   Thu, 31 Jan 2019 05:10:20 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kan.liang@linux.intel.com, acme@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, linux-kernel@vger.kernel.org, eranian@google.com,
        jolsa@redhat.com, namhyung@kernel.org,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH V3 01/13] perf/core, x86: Add PERF_SAMPLE_DATA_PAGE_SIZE
Message-ID: <20190131131020.GX6118@tassilo.jf.intel.com>
References: <1548858234-8872-1-git-send-email-kan.liang@linux.intel.com>
 <20190131123725.GB31516@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131123725.GB31516@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Aside from all the missin {}, I'm fairly sure this is broken since this
> happens from NMI context. This can interrupt switch_mm() and things like
> use_temporary_mm().

So the concern is that the sample is from before the switch, and then
looks it up in the wrong page tables if the PMI happens after the switch
due to sampling skid?

First this can happen only with PEBS, which doesn't have that
bad worst case skid (perhaps tens of cycles)

I doubt it is very likely because this problem could only happen
for user addresses because kernel page tables don't change. 

But we would be in the middle of the context 
switch (or use_temporary_mm) here, and there should be no
user space accesses within a tens of cycle window 
(except perhaps for the rseq address, but that's not a very
interesting case)

I assume the use_temporary_mm() cases are similar.

I suppose we could enforce flushing the PMU on such context switches,
but I would suspect while it's a valid theoretical problem, 
it's unlikely to be a real problem in practice.

Likely it means that large buffer PEBS cannot be ever used
with this option, but I guess that's ok.

-Andi


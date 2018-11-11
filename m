Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E28FC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 01:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDEE4208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 01:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDEE4208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbeKKKx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 05:53:57 -0500
Received: from mga17.intel.com ([192.55.52.151]:40441 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbeKKKx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 05:53:57 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Nov 2018 17:07:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,489,1534834800"; 
   d="scan'208";a="99271532"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga003.jf.intel.com with ESMTP; 10 Nov 2018 17:07:01 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 9075D30235B; Sat, 10 Nov 2018 17:07:02 -0800 (PST)
Date:   Sat, 10 Nov 2018 17:07:02 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Travis Downs <travis.downs@gmail.com>
Cc:     milian.wolff@kdab.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: PEBS level 2/3 breaks dwarf unwinding! [WAS: Re: Broken dwarf
 unwinding - wrong stack pointer register value?]
Message-ID: <20181111010702.GC6218@tassilo.jf.intel.com>
References: <2335309.gnWok9HYb4@agathebauer>
 <3227038.olIWmsCzzY@agathebauer>
 <20181105205119.GC25674@krava>
 <3799078.YBnU1OB0PF@agathebauer>
 <20181106001037.GQ6218@tassilo.jf.intel.com>
 <CAOBGo4za8hnGt1NUWy1Y1V12WycbxbYP0G0Sm=UT7T9dQ88vDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOBGo4za8hnGt1NUWy1Y1V12WycbxbYP0G0Sm=UT7T9dQ88vDg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 04:42:48PM -0500, Travis Downs wrote:
> I guess this problem doesn't occur for LBR unwinding since the LBR
> records are captured at the same
> moment in time as the PEBS record, so reflect the correct branch
> sequence.

Actually it happens with LBRs too, but it always gives the backtrace
consistently at the PMI trigger point.
 
> What would this fix mean for perf report when you use cycles:pp and
> cycles:ppp (or any PEBS based events)? The unwinding should generally
> work, but the IP at the top of that stack (from the PMI) will
> generally be different than that recorded by PEBS. The tree view and
> overhead calculations will be based on the captured stacks, I guess -
> but when I annotate, will the values I see correspond to the PEBS IPs
> or the PMI IPs?

Based on PEBS IPs.

It would be a good idea to add a check to perf report
that the two IPs are different, and if they differ
add some indicator to the sample. This could be a new sort key,
although that would waste some space on the screen, or something
else.

It wouldn't be cover all cases, for example if you have recursion
on the same function it might report the same IP even though
it's a different instance, but I presume that should be rare
enough to not be a problem.

-Andi

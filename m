Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626EBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B792214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B792214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbeKLNRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 08:17:48 -0500
Received: from mga18.intel.com ([134.134.136.126]:61699 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbeKLNRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 08:17:48 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2018 19:26:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,493,1534834800"; 
   d="scan'208";a="88540280"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga007.jf.intel.com with ESMTP; 11 Nov 2018 19:26:37 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id CF44A300E46; Sun, 11 Nov 2018 19:26:37 -0800 (PST)
Date:   Sun, 11 Nov 2018 19:26:37 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Travis Downs <travis.downs@gmail.com>
Cc:     Milian Wolff <milian.wolff@kdab.com>, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: PEBS level 2/3 breaks dwarf unwinding! [WAS: Re: Broken dwarf
 unwinding - wrong stack pointer register value?]
Message-ID: <20181112032637.GG6218@tassilo.jf.intel.com>
References: <2335309.gnWok9HYb4@agathebauer>
 <3227038.olIWmsCzzY@agathebauer>
 <20181105205119.GC25674@krava>
 <3799078.YBnU1OB0PF@agathebauer>
 <20181106001037.GQ6218@tassilo.jf.intel.com>
 <CAOBGo4za8hnGt1NUWy1Y1V12WycbxbYP0G0Sm=UT7T9dQ88vDg@mail.gmail.com>
 <20181111010702.GC6218@tassilo.jf.intel.com>
 <CAOBGo4zirLiKX8VcROAE=kAD0+qkF0E-cBv9DtBiQr=_obDv5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOBGo4zirLiKX8VcROAE=kAD0+qkF0E-cBv9DtBiQr=_obDv5w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 09:50:05PM -0500, Travis Downs wrote:
>    On Sat, Nov 10, 2018 at 8:07 PM Andi Kleen <ak@linux.intel.com> wrote:
> 
>      On Sat, Nov 10, 2018 at 04:42:48PM -0500, Travis Downs wrote:
>      > I guess this problem doesn't occur for LBR unwinding since the LBR
>      > records are captured at the same
>      > moment in time as the PEBS record, so reflect the correct branch
>      > sequence.
> 
>      Actually it happens with LBRs too, but it always gives the backtrace
>      consistently at the PMI trigger point.
> 
>    That's weird - so the LBR records are from the PMI point, but the rest of
>    the PEBS record comes from the PEBS trigger point? Or the LBR isn't part
>    of PEBS at all?

LBR is not part of PEBS, but is collected separately in the PMI handler.

>      > overhead calculations will be based on the captured stacks, I guess -
>      > but when I annotate, will the values I see correspond to the PEBS IPs
>      > or the PMI IPs?
> 
>      Based on PEBS IPs.
> 
>      It would be a good idea to add a check to perf report
>      that the two IPs are different, and if they differ
>      add some indicator to the sample. This could be a new sort key,
>      although that would waste some space on the screen, or something
>      else.
> 
>    In the case that PEBS events are used, the IP will differ essentially 100%
>    of the time, right? That is, there will always be *some* skid.

I wouldn't say that.  It depends on what the CPU is doing and the IPC
of the code.

Also the backtrace inconsistency can only happen if the sample races with
function return. If you don't then the backtrace will point
to the correct function, even though the unwind IP is different. 

For example in the common case where you profile a long loop it
is unlikely to happen.


>    indicating otherwise above), I could imagine a hybrid mode where LBR is
>    used to go back some number of calls and then dwarf or FP or whatever
>    unwinding takes over, because the further down the stack you do the more
>    likely the PEBS trigger point and PMI point are likely to have a
>    consistent stack.

Could collect numbers how often it happens, but it would surprise
me if anything complicated is worth it. I would just do the minimum fixes
to address the unwinder errors, and perhaps add the "unwind ip differs"
indication.

-Andi

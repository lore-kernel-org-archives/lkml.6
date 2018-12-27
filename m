Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2020DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 20:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29A1208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 20:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbeL0UvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 15:51:06 -0500
Received: from mga12.intel.com ([192.55.52.136]:45954 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727940AbeL0UvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 15:51:05 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2018 12:51:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,406,1539673200"; 
   d="scan'208";a="133288614"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga001.fm.intel.com with ESMTP; 27 Dec 2018 12:51:04 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id A537C300B65; Thu, 27 Dec 2018 12:51:04 -0800 (PST)
Date:   Thu, 27 Dec 2018 12:51:04 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, peterz@infradead.org, kan.liang@intel.com,
        mingo@redhat.com, rkrcmar@redhat.com, like.xu@intel.com,
        jannh@google.com, arei.gonglei@huawei.com
Subject: Re: [PATCH v4 10/10] KVM/x86/lbr: lazy save the guest lbr stack
Message-ID: <20181227205104.GG25620@tassilo.jf.intel.com>
References: <1545816338-1171-1-git-send-email-wei.w.wang@intel.com>
 <1545816338-1171-11-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545816338-1171-11-git-send-email-wei.w.wang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks. This looks a lot better than the earlier versions.

Some more comments.

On Wed, Dec 26, 2018 at 05:25:38PM +0800, Wei Wang wrote:
> When the vCPU is scheduled in:
> - if the lbr feature was used in the last vCPU time slice, set the lbr
>   stack to be interceptible, so that the host can capture whether the
>   lbr feature will be used in this time slice;
> - if the lbr feature wasn't used in the last vCPU time slice, disable
>   the vCPU support of the guest lbr switching.

time slice is the time from exit to exit?

This might be rather short in some cases if the workload does a lot of exits
(which I would expect PMU workloads to do) Would be better to use some
explicit time check, or at least N exits.

> 
> Upon the first access to one of the lbr related MSRs (since the vCPU was
> scheduled in):
> - record that the guest has used the lbr;
> - create a host perf event to help save/restore the guest lbr stack if
>   the guest uses the user callstack mode lbr stack;

This is a bit risky. It would be safer (but also more expensive)
to always safe even for any guest LBR use independent of callstack.

Otherwise we might get into a situation where
a vCPU context switch inside the guest PMI will clear the LBRs
before they can be read in the PMI, so some LBR samples will be fully
or partially cleared. This would be user visible.

In theory could try to detect if the guest is inside a PMI and
save/restore then, but that would likely be complicated. I would
save/restore for all cases.

> +static void
> +__always_inline vmx_set_intercept_for_msr(unsigned long *msr_bitmap, u32 msr,
> +					  int type, bool value);

__always_inline should only be used if it's needed for functionality,
or in a header.

The rest looks good.

-Andi


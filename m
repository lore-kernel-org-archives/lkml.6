Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87481C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 03:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 538EE214C6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 03:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731499AbeL1Dls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 22:41:48 -0500
Received: from mga05.intel.com ([192.55.52.43]:5033 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbeL1Dls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 22:41:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2018 19:41:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,407,1539673200"; 
   d="scan'208";a="121563877"
Received: from unknown (HELO [10.239.13.114]) ([10.239.13.114])
  by orsmga002.jf.intel.com with ESMTP; 27 Dec 2018 19:41:45 -0800
Message-ID: <5C259CBA.4030805@intel.com>
Date:   Fri, 28 Dec 2018 11:47:06 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Andi Kleen <ak@linux.intel.com>
CC:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, peterz@infradead.org, kan.liang@intel.com,
        mingo@redhat.com, rkrcmar@redhat.com, like.xu@intel.com,
        jannh@google.com, arei.gonglei@huawei.com
Subject: Re: [PATCH v4 10/10] KVM/x86/lbr: lazy save the guest lbr stack
References: <1545816338-1171-1-git-send-email-wei.w.wang@intel.com> <1545816338-1171-11-git-send-email-wei.w.wang@intel.com> <20181227205104.GG25620@tassilo.jf.intel.com>
In-Reply-To: <20181227205104.GG25620@tassilo.jf.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/2018 04:51 AM, Andi Kleen wrote:
> Thanks. This looks a lot better than the earlier versions.
>
> Some more comments.
>
> On Wed, Dec 26, 2018 at 05:25:38PM +0800, Wei Wang wrote:
>> When the vCPU is scheduled in:
>> - if the lbr feature was used in the last vCPU time slice, set the lbr
>>    stack to be interceptible, so that the host can capture whether the
>>    lbr feature will be used in this time slice;
>> - if the lbr feature wasn't used in the last vCPU time slice, disable
>>    the vCPU support of the guest lbr switching.
> time slice is the time from exit to exit?

It's the vCPU thread time slice (e.g. 100ms).


>
> This might be rather short in some cases if the workload does a lot of exits
> (which I would expect PMU workloads to do) Would be better to use some
> explicit time check, or at least N exits.

Did you mean further increasing the lazy time to multiple host thread
scheduling time slices?
What would be a good value for "N"?


>> Upon the first access to one of the lbr related MSRs (since the vCPU was
>> scheduled in):
>> - record that the guest has used the lbr;
>> - create a host perf event to help save/restore the guest lbr stack if
>>    the guest uses the user callstack mode lbr stack;
> This is a bit risky. It would be safer (but also more expensive)
> to always safe even for any guest LBR use independent of callstack.
>
> Otherwise we might get into a situation where
> a vCPU context switch inside the guest PMI will clear the LBRs
> before they can be read in the PMI, so some LBR samples will be fully
> or partially cleared. This would be user visible.
>
> In theory could try to detect if the guest is inside a PMI and
> save/restore then, but that would likely be complicated. I would
> save/restore for all cases.

Yes, it is easier to save for all the cases. But curious for the 
non-callstack
mode, it's just ponit sampling functions (kind of speculative in some 
degree).
Would rarely losing a few recordings important in that case?


>
>> +static void
>> +__always_inline vmx_set_intercept_for_msr(unsigned long *msr_bitmap, u32 msr,
>> +					  int type, bool value);
> __always_inline should only be used if it's needed for functionality,
> or in a header.

Thanks, will fix it.

Best,
Wei

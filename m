Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69278C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 05:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E710206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 05:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E710206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeIGJ7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 05:59:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:53790 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbeIGJ7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 05:59:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 22:20:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,340,1531810800"; 
   d="scan'208";a="89711020"
Received: from unknown (HELO [10.239.13.3]) ([10.239.13.3])
  by orsmga002.jf.intel.com with ESMTP; 06 Sep 2018 22:19:55 -0700
Message-ID: <5B920B96.6080803@intel.com>
Date:   Fri, 07 Sep 2018 13:24:38 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Andi Kleen <ak@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Liang, Kan" <kan.liang@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "Xu, Like" <like.xu@intel.com>
Subject: Re: [PATCH v2 6/8] perf/x86/intel/lbr: guest requesting KVM for lbr
 stack save/restore
References: <1536233456-12173-1-git-send-email-wei.w.wang@intel.com> <1536233456-12173-7-git-send-email-wei.w.wang@intel.com> <20180907032707.GN27886@tassilo.jf.intel.com>
In-Reply-To: <20180907032707.GN27886@tassilo.jf.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2018 11:27 AM, Andi Kleen wrote:
> On Thu, Sep 06, 2018 at 07:30:54PM +0800, Wei Wang wrote:
>> This patch adds an interface to enable a guest to request KVM to save
>> and restore the lbr stack on vCPU context switching.
>>
>> KVM couldn't capture the info about whether the guest is actively using
>> the lbr feature via the lbr enable bit in the debugctl MSR, because that
>> control bit is frequently enabled and disabled by the guest, and in some
>> csaes, it is disabled even when the guest is actively using the lbr
>> feature. For example, perf_pmu_sched_task in the guest disables the bit
>> before reading out the lbr stack. In this case, the bit is disabled though
>> the guest is still using the lbr feature.
>>
>> So, a KVM-specific MSR, MSR_KVM_PV_LBR_CTRL, is used by the guest at a
>> proper place to tell KVM if the LBR is actively in use or not. Basically,
>> the lbr user callstack mode needs the lbr stack to be saved/restored on a
>> context switching, so we set the ACTIVE bit of MSR_KVM_PV_LBR_CTRL only
>> when the user callstack mode is used. The KVM hypervisor will add the lbr
>> stack save/restore support on vCPU switching after the ACTIVE bit is set.
> PV is difficult because it requires changing all the users.

It needs changes of the guest driver, but remains transparent to guest 
user applications (e.g. the perf tool).
Btw, we tested it, and it works in guest as good as on the native linux.

This was thought of as the hardest part of this work. Let me just 
clarify it a little bit:

The fundamental function we want to achieve is
#1 when the vCPU is actively using the LBR feature,  save/restore the 
lbr stack when the vCPU is scheduled out/in;
#2 when the vCPU is NOT actively using the LBR feature, DON'T 
save/restore the lbr stack when the vCPU is scheduled out/in;

The key problem we need to solve is: how does the host know if the guest 
is actively using the lbr feature or not?

>
> Maybe a better approach would be a lazy restore of the LBRs:
>
> Don't restore the LBRs on context switch, but set the LBR MSRs to intercept.
> Then on the first access restore the LBRs and allow direct access to the
> MSRs again.
>
> Also when the LBRs haven't been set to direct access the state doesn't
> need to be saved.

This could achieve the above #1, but how would it solve #2 above? That 
is, after the guest uses the lbr feature for a while, the lbr stack has 
been passed through, then the guest doesn't use lbr any more, but the 
vCPU will still save/restore on switching?
(Host cannot know that the guest is not using lbr by the debugctl[0], 
the commit log above has some explanations about this)

Best,
Wei



Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EC7C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93BB2183F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfAHHsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 02:48:22 -0500
Received: from mga05.intel.com ([192.55.52.43]:8636 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727473AbfAHHsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 02:48:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2019 23:48:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,453,1539673200"; 
   d="scan'208";a="124180966"
Received: from unknown (HELO [10.239.13.114]) ([10.239.13.114])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Jan 2019 23:48:19 -0800
Message-ID: <5C34570D.6010208@intel.com>
Date:   Tue, 08 Jan 2019 15:53:49 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Jim Mattson <jmattson@google.com>, Andi Kleen <ak@linux.intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        like.xu@intel.com, Jann Horn <jannh@google.com>,
        arei.gonglei@huawei.com
Subject: Re: [PATCH v4 05/10] KVM/x86: expose MSR_IA32_PERF_CAPABILITIES to
 the guest
References: <1545816338-1171-1-git-send-email-wei.w.wang@intel.com> <1545816338-1171-6-git-send-email-wei.w.wang@intel.com> <CALMp9eTOV3Twep9gL-9S+Pe_k-=v17CcJTLb5=+7_pjvWf9RfQ@mail.gmail.com> <5C2DC132.9050103@intel.com> <CALMp9eQ0nzKBP7az72G+eRe8C4KQQUBdj+7oD_WJHSFfYkj+Vw@mail.gmail.com> <5C3318A1.9090009@intel.com> <CALMp9eSyC5arXkrFdJKCx=cG7uF6tVgkbSJbUJArf4cFje13rQ@mail.gmail.com> <20190107182012.GL6118@tassilo.jf.intel.com> <CALMp9eT2J=qFTEEpsym_aqeCRwyCquTYnY8=taZ3nY3rs8WeJA@mail.gmail.com>
In-Reply-To: <CALMp9eT2J=qFTEEpsym_aqeCRwyCquTYnY8=taZ3nY3rs8WeJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2019 02:48 AM, Jim Mattson wrote:
> On Mon, Jan 7, 2019 at 10:20 AM Andi Kleen <ak@linux.intel.com> wrote:
>>> The issue is compatibility. Prior to your change, reading this MSR
>>> from a VM would raise #GP. After your change, it won't. That means
>>> that if you have a VM migrating between hosts with kernel versions
>>> before and after this change, the results will be inconsistent. In the
>> No it will not be. All Linux kernel uses of this MSR are guarded
>> by a CPUID check.
> Linux usage is irrelevant to the architected behavior of the virtual
> CPU. According to volume 4 of the SDM, this MSR is only supported when
> CPUID.01H:ECX.PDCM [bit 15] is set. Therefore, kvm should raise #GP
> whenever a guest tries to read this MSR and the guest's
> CPUID.01H:ECX.PDCM [bit 15] is clear.
>

Probably one more check would be better:

if (!boot_cpu_has(X86_FEATURE_PDCM) ||
     !guest_cpuid_has(vcpu, X86_FEATURE_PDCM))
     return 1;

(host isn't expected to read this MSR when PDCM is not supported
by the guest, so don't have "!msr_info->host_initiate" added to above)

Best,
Wei

Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B45AC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F3A820989
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfAGJJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:09:48 -0500
Received: from mga04.intel.com ([192.55.52.120]:24564 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbfAGJJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:09:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2019 01:09:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,450,1539673200"; 
   d="scan'208";a="309576703"
Received: from unknown (HELO [10.239.13.114]) ([10.239.13.114])
  by fmsmga005.fm.intel.com with ESMTP; 07 Jan 2019 01:09:44 -0800
Message-ID: <5C3318A1.9090009@intel.com>
Date:   Mon, 07 Jan 2019 17:15:13 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Jim Mattson <jmattson@google.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        like.xu@intel.com, Jann Horn <jannh@google.com>,
        arei.gonglei@huawei.com
Subject: Re: [PATCH v4 05/10] KVM/x86: expose MSR_IA32_PERF_CAPABILITIES to
 the guest
References: <1545816338-1171-1-git-send-email-wei.w.wang@intel.com> <1545816338-1171-6-git-send-email-wei.w.wang@intel.com> <CALMp9eTOV3Twep9gL-9S+Pe_k-=v17CcJTLb5=+7_pjvWf9RfQ@mail.gmail.com> <5C2DC132.9050103@intel.com> <CALMp9eQ0nzKBP7az72G+eRe8C4KQQUBdj+7oD_WJHSFfYkj+Vw@mail.gmail.com>
In-Reply-To: <CALMp9eQ0nzKBP7az72G+eRe8C4KQQUBdj+7oD_WJHSFfYkj+Vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2019 11:25 PM, Jim Mattson wrote:
> On Wed, Jan 2, 2019 at 11:55 PM Wei Wang <wei.w.wang@intel.com> wrote:
>
>> Right, thanks. Probably better to change it to below:
>>
>> msr_info->data = 0;
>> data = native_read_msr(MSR_IA32_PERF_CAPABILITIES);
>> if (vcpu->kvm->arch.lbr_in_guest)
>>       msr_info->data |= (data & X86_PERF_CAP_MASK_LBR_FMT);
>>
> This still breaks backwards compatibility. Returning 0 and raising #GP
> are not the same.

I'm not sure about raising GP# in this case.

This PERF_CAP msr contains more things than the lbr format.
For example, a guest with lbr=false option could read it to get PEBS_FMT,
which is PERF_CAP[11:8]. We should offer those bits in this case.

When lbr=false, the lbr feature is not usable by the guest,
so I think whatever value (0 or other value) of the LBR_FMT bits that
we give to the guest might not be important.

Best,
Wei

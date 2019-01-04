Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1019C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD1D21871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbfADKDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 05:03:53 -0500
Received: from mga17.intel.com ([192.55.52.151]:53930 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbfADKDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 05:03:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2019 02:03:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,437,1539673200"; 
   d="scan'208";a="124040758"
Received: from unknown (HELO [10.239.13.114]) ([10.239.13.114])
  by orsmga001.jf.intel.com with ESMTP; 04 Jan 2019 02:03:50 -0800
Message-ID: <5C2F30CD.6010108@intel.com>
Date:   Fri, 04 Jan 2019 18:09:17 +0800
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
Subject: Re: [PATCH v4 04/10] KVM/x86: intel_pmu_lbr_enable
References: <1545816338-1171-1-git-send-email-wei.w.wang@intel.com> <1545816338-1171-5-git-send-email-wei.w.wang@intel.com> <CALMp9eRPvxPCnAnWr8+U98PzZLQ8LzeBRMyPk0qROKBzSzSnRQ@mail.gmail.com> <5C2DB81F.3000906@intel.com> <CALMp9eR0rkF-DuOWyB16q5r8y9DrefsMd1h4GfDkA8nmpWjMEg@mail.gmail.com>
In-Reply-To: <CALMp9eR0rkF-DuOWyB16q5r8y9DrefsMd1h4GfDkA8nmpWjMEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2019 11:34 PM, Jim Mattson wrote:
> On Wed, Jan 2, 2019 at 11:16 PM Wei Wang <wei.w.wang@intel.com> wrote:
>> On 01/03/2019 07:26 AM, Jim Mattson wrote:
>>> On Wed, Dec 26, 2018 at 2:01 AM Wei Wang <wei.w.wang@intel.com> wrote:
>>>> The lbr stack is architecturally specific, for example, SKX has 32 lbr
>>>> stack entries while HSW has 16 entries, so a HSW guest running on a SKX
>>>> machine may not get accurate perf results. Currently, we forbid the
>>>> guest lbr enabling when the guest and host see different lbr stack
>>>> entries.
>>> How do you handle live migration?
>> This feature is gated by the QEMU "lbr=true" option.
>> So if the lbr fails to work on the destination machine,
>> the destination side QEMU wouldn't be able to boot,
>> and migration will not happen.
> Yes, but then what happens?
>
> Fast forward to, say, 2021. You're decommissioning all Broadwell
> servers in your data center. You have to migrate the running VMs off
> of those Broadwell systems onto newer hardware. But, with the current
> implementation, the migration cannot happen. So, what do you do? I
> suppose you just never enable the feature in the first place. Right?

I'm not sure if that's the way people would do with their data centers.
What would be the point of decommissioning all the BDW machines when
there are important BDW VMs running?

The "lbr=true" option can also be disabled via QMP, which will disable the
kvm side lbr support. So if you really want to deal with the above case,
you could first disable the lbr feature on the source side, and then 
boot the
destination side QEMU without "lbr=true". The lbr feature will not be 
available
to use by the guest at the time you decide to migrate the guest to a
non-compatible physical machine.

The point of this patch is: If we couldn't offer our users accurate
lbr results, we'd better to have the feature disabled rather than
offering wrong results to confuse them.


Best,
Wei

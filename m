Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D6EC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44AA2152F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D44AA2152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732521AbeITRRg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 13:17:36 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6423 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727029AbeITRRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 13:17:35 -0400
Received: from DGGEML403-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id EC0837F6B9561;
        Thu, 20 Sep 2018 19:34:29 +0800 (CST)
Received: from DGGEML511-MBX.china.huawei.com ([169.254.1.77]) by
 DGGEML403-HUB.china.huawei.com ([fe80::74d9:c659:fbec:21fa%31]) with mapi id
 14.03.0399.000; Thu, 20 Sep 2018 19:34:26 +0800
From:   "Gonglei (Arei)" <arei.gonglei@huawei.com>
To:     Wei Wang <wei.w.wang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>
CC:     "kan.liang@intel.com" <kan.liang@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "like.xu@intel.com" <like.xu@intel.com>,
        "jannh@google.com" <jannh@google.com>
Subject: RE: [PATCH v3 0/5] Guest LBR Enabling
Thread-Topic: [PATCH v3 0/5] Guest LBR Enabling
Thread-Index: AQHUUM3nJATekp5+/E2br0cH7F7p0qT5Cang
Date:   Thu, 20 Sep 2018 11:34:26 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DB0F73EB@dggeml511-mbx.china.huawei.com>
References: <1537437959-8751-1-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1537437959-8751-1-git-send-email-wei.w.wang@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.18.62]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: kvm-owner@vger.kernel.org [mailto:kvm-owner@vger.kernel.org] On
> Behalf Of Wei Wang
> Sent: Thursday, September 20, 2018 6:06 PM
> To: linux-kernel@vger.kernel.org; kvm@vger.kernel.org; pbonzini@redhat.com;
> ak@linux.intel.com
> Cc: kan.liang@intel.com; peterz@infradead.org; mingo@redhat.com;
> rkrcmar@redhat.com; like.xu@intel.com; wei.w.wang@intel.com;
> jannh@google.com; Gonglei (Arei) <arei.gonglei@huawei.com>
> Subject: [PATCH v3 0/5] Guest LBR Enabling
> 
> Last Branch Recording (LBR) is a performance monitor unit (PMU) feature
> on Intel CPUs that captures branch related info. This patch series enables
> this feature to KVM guests.
> 
> Here is a conclusion of the fundamental methods that we use:
> 1) the LBR feature is enabled per guest via QEMU setting of
>    KVM_CAP_X86_GUEST_LBR;

Did you send the QEMU parts for guest LBR support?


Thanks,
-Gonglei

> 2) the LBR stack is passed through to the guest for direct accesses after
>    the guest's first access to any of the lbr related MSRs;
> 3) When the guest uses the LBR feature with the user callstack mode, the
>    host will help save/resotre the LBR stack when the vCPU is scheduled
>    out/in.
> 
> ChangeLog:
> v2->v3:
>     - replaces the pv approach with a lazy save approach to saving the lbr
>       stack on vCPU switching;
>     - destroy the host side perf event if the guest is torn down;
>     - remove the unnecessary event->pmu->stop() before calling
>       perf_event_release_kernel().
> v1->v2:
>     - add the per guest LBR capability, KVM_CAP_X86_GUEST_LBR;
>     - save/restore the LBR stack conditionally on the vCPU thread context
>       switching, instead of on VMX transitions;
>     - expose MSR_IA32_PERF_CAPABILITIES to the guest.
> 
> Like Xu (1):
>   KVM/x86/vPMU: Add APIs to support host save/restore the guest lbr
>     stack
> 
> Wei Wang (4):
>   perf/x86: add a function to get the lbr stack
>   KVM/x86: KVM_CAP_X86_GUEST_LBR
>   KVM/x86: expose MSR_IA32_PERF_CAPABILITIES to the guest
>   KVM/x86/lbr: lazy save the guest lbr stack
> 
>  arch/x86/events/intel/lbr.c       |  49 ++++++++++++-
>  arch/x86/events/perf_event.h      |   1 +
>  arch/x86/include/asm/kvm_host.h   |   7 ++
>  arch/x86/include/asm/perf_event.h |  22 ++++++
>  arch/x86/kvm/cpuid.c              |   2 +-
>  arch/x86/kvm/pmu.h                |   8 +++
>  arch/x86/kvm/pmu_intel.c          |  41 +++++++++++
>  arch/x86/kvm/vmx.c                | 144
> ++++++++++++++++++++++++++++++++++++++
>  arch/x86/kvm/x86.c                |  10 +++
>  include/uapi/linux/kvm.h          |   1 +
>  10 files changed, 281 insertions(+), 4 deletions(-)
> 
> --
> 2.7.4


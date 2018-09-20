Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843ACC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A1C21529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A1C21529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387453AbeITQT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 12:19:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:59584 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbeITQT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 12:19:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 03:37:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,398,1531810800"; 
   d="scan'208";a="74796067"
Received: from devel-ww.sh.intel.com ([10.239.48.110])
  by orsmga008.jf.intel.com with ESMTP; 20 Sep 2018 03:36:30 -0700
From:   Wei Wang <wei.w.wang@intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com
Cc:     kan.liang@intel.com, peterz@infradead.org, mingo@redhat.com,
        rkrcmar@redhat.com, like.xu@intel.com, wei.w.wang@intel.com,
        jannh@google.com, arei.gonglei@huawei.com
Subject: [PATCH v3 0/5] Guest LBR Enabling
Date:   Thu, 20 Sep 2018 18:05:54 +0800
Message-Id: <1537437959-8751-1-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Last Branch Recording (LBR) is a performance monitor unit (PMU) feature
on Intel CPUs that captures branch related info. This patch series enables
this feature to KVM guests.

Here is a conclusion of the fundamental methods that we use:
1) the LBR feature is enabled per guest via QEMU setting of
   KVM_CAP_X86_GUEST_LBR;
2) the LBR stack is passed through to the guest for direct accesses after
   the guest's first access to any of the lbr related MSRs;
3) When the guest uses the LBR feature with the user callstack mode, the
   host will help save/resotre the LBR stack when the vCPU is scheduled
   out/in.

ChangeLog:
v2->v3:
    - replaces the pv approach with a lazy save approach to saving the lbr
      stack on vCPU switching;
    - destroy the host side perf event if the guest is torn down;
    - remove the unnecessary event->pmu->stop() before calling
      perf_event_release_kernel().
v1->v2:
    - add the per guest LBR capability, KVM_CAP_X86_GUEST_LBR;
    - save/restore the LBR stack conditionally on the vCPU thread context
      switching, instead of on VMX transitions;
    - expose MSR_IA32_PERF_CAPABILITIES to the guest.

Like Xu (1):
  KVM/x86/vPMU: Add APIs to support host save/restore the guest lbr
    stack

Wei Wang (4):
  perf/x86: add a function to get the lbr stack
  KVM/x86: KVM_CAP_X86_GUEST_LBR
  KVM/x86: expose MSR_IA32_PERF_CAPABILITIES to the guest
  KVM/x86/lbr: lazy save the guest lbr stack

 arch/x86/events/intel/lbr.c       |  49 ++++++++++++-
 arch/x86/events/perf_event.h      |   1 +
 arch/x86/include/asm/kvm_host.h   |   7 ++
 arch/x86/include/asm/perf_event.h |  22 ++++++
 arch/x86/kvm/cpuid.c              |   2 +-
 arch/x86/kvm/pmu.h                |   8 +++
 arch/x86/kvm/pmu_intel.c          |  41 +++++++++++
 arch/x86/kvm/vmx.c                | 144 ++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c                |  10 +++
 include/uapi/linux/kvm.h          |   1 +
 10 files changed, 281 insertions(+), 4 deletions(-)

-- 
2.7.4


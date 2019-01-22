Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE83C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389632184D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfAWOGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:06:24 -0500
Received: from mga17.intel.com ([192.55.52.151]:53944 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfAWOGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:06:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2019 06:06:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,511,1539673200"; 
   d="scan'208";a="140622222"
Received: from local-michael-cet-test.sh.intel.com ([10.239.159.128])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jan 2019 06:06:21 -0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     pbonzini@redhat.com, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com, yi.z.zhang@intel.com, hjl.tools@gmail.com
Cc:     weijiang.yang@intel.com
Subject: [PATCH v2 0/7] This patch-set is to enable Guest CET support
Date:   Wed, 23 Jan 2019 04:59:02 +0800
Message-Id: <20190122205909.24165-1-weijiang.yang@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Control-flow Enforcement Technology (CET) provides protection against
return/jump-oriented programming (ROP) attacks. To make kvm Guest OS own
the capability, this patch-set is required. It enables CET related CPUID
report, xsaves/xrstors, vmx entry configuration etc. for Guest OS.

PATCH 1    : Define CET VMCS fields and bits.
PATCH 2/3  : Report CET feature support in CPUID.
PATCH 4    : Fix xsaves size calculation issue.
PATCH 5    : Pass through CET MSRs to Guest.
PATCH 6    : Set Guest CET state auto loading bit.
PATCH 7    : Enable CET xsaves bits support in XSS.

Changelog:
 v2:
 - Re-ordered patch sequence, combined one patch.
 - Added more description for CET related VMCS fields.
 - Added Host CET capability check while enabling Guest CET loading bit.
 - Added Host CET capability check while reporting Guest CPUID(EAX=7,
   EXC=0).
 - Modified code in reporting Guest CPUID(EAX=D,ECX>=1), make it clearer.
 - Added Host and Guest XSS mask check while setting bits for Guest XSS.


Yang Weijiang (7):
  KVM:VMX: Define CET VMCS fields and bits
  KVM:CPUID: Define CET CPUID bits and CR4.CET master enable bit.
  KVM:CPUID: Add CPUID support for CET xsaves component query.
  KVM:CPUID: Fix xsaves area size calculation for CPUID.(EAX=0xD,ECX=1).
  KVM:VMX: Pass through host CET related MSRs to Guest.
  KVM:VMX: Load Guest CET via VMCS when CET is enabled in Guest
  KVM:X86: Enable MSR_IA32_XSS bit 11 and 12 for CET xsaves/xrstors.

 arch/x86/include/asm/kvm_host.h |  3 +-
 arch/x86/include/asm/vmx.h      |  8 ++++
 arch/x86/kvm/cpuid.c            | 67 ++++++++++++++++++++++++---------
 arch/x86/kvm/vmx.c              | 60 +++++++++++++++++++++++++++--
 arch/x86/kvm/x86.c              |  4 ++
 arch/x86/kvm/x86.h              |  4 ++
 6 files changed, 125 insertions(+), 21 deletions(-)

-- 
2.17.1


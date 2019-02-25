Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE39C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8002147C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfBZGcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:32:45 -0500
Received: from mga17.intel.com ([192.55.52.151]:18105 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfBZGcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 01:32:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2019 22:32:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,414,1544515200"; 
   d="scan'208";a="141666029"
Received: from local-michael-cet-test.sh.intel.com ([10.239.159.128])
  by orsmga001.jf.intel.com with ESMTP; 25 Feb 2019 22:32:42 -0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     pbonzini@redhat.com, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com
Cc:     Yang Weijiang <weijiang.yang@intel.com>
Subject: [PATCH v3 0/8] This patch-set is to enable Guest CET support
Date:   Mon, 25 Feb 2019 21:27:08 +0800
Message-Id: <20190225132716.6982-1-weijiang.yang@intel.com>
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
PATCH 8    : Add CET MSR user space access interface.

Changelog:
 v3:
 - Modified patches to make Guest CET independent to Host enabling.
 - Added patch 8 to add user space access for Guest CET MSR access.
 - Modified code comments and patch description to reflect changes.
  
 v2:
 - Re-ordered patch sequence, combined one patch.
 - Added more description for CET related VMCS fields.
 - Added Host CET capability check while enabling Guest CET loading bit.
 - Added Host CET capability check while reporting Guest CPUID(EAX=7,
   EXC=0).
 - Modified code in reporting Guest CPUID(EAX=D,ECX>=1), make it clearer.
 - Added Host and Guest XSS mask check while setting bits for Guest XSS.


Yang Weijiang (8):
  KVM:VMX: Define CET VMCS fields and bits
  KVM:CPUID: Define CET CPUID bits and CR4.CET master enable bit.
  KVM:CPUID: Add CPUID support for Guest CET
  KVM:CPUID: Fix xsaves area size calculation for CPUID.(EAX=0xD,ECX=1).
  KVM:VMX: Pass through host CET related MSRs to Guest.
  KVM:VMX: Load Guest CET via VMCS when CET is enabled in Guest
  KVM:X86: Add XSS bit 11 and 12 support for CET xsaves/xrstors.
  KVM:X86: Add user-space read/write interface for CET MSRs.

 arch/x86/include/asm/kvm_host.h |  3 +-
 arch/x86/include/asm/vmx.h      |  8 ++++
 arch/x86/kvm/cpuid.c            | 67 ++++++++++++++++++++++++---------
 arch/x86/kvm/vmx.c              | 53 ++++++++++++++++++++++++--
 arch/x86/kvm/x86.c              | 46 ++++++++++++++++++++--
 arch/x86/kvm/x86.h              |  4 ++
 6 files changed, 157 insertions(+), 24 deletions(-)

-- 
2.17.1


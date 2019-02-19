Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DATE_IN_FUTURE_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791F0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9982147C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbfBRL0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 06:26:48 -0500
Received: from mga18.intel.com ([134.134.136.126]:35783 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727423AbfBRL0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 06:26:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2019 03:26:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,384,1544515200"; 
   d="scan'208";a="275885427"
Received: from vmm.bj.intel.com ([10.240.192.123])
  by orsmga004.jf.intel.com with ESMTP; 18 Feb 2019 03:26:43 -0800
From:   Luwei Kang <luwei.kang@intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, pbonzini@redhat.com, rkrcmar@redhat.com,
        peterz@infradead.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, kan.liang@linux.intel.com, ak@linux.intel.com,
        konrad.wilk@oracle.com, Janakarajan.Natarajan@amd.com,
        mattst88@gmail.com, tim.c.chen@linux.intel.com,
        Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH v2 0/2] Inject a PMI for KVM Guest when ToPA buffer is filled
Date:   Mon, 18 Feb 2019 19:26:06 -0500
Message-Id: <1550535968-7652-1-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each intel processor trace table of physical addresses (ToPA) entry
has an INT bit. If this bit is set, the processor will signal a
performance-monitoring interrupt (PMI) when the corresponding trace
output region is filled. This patch set will inject a PMI for Intel
Processor Trace when ToPA buffer is filled.

>From v1:
 - Exported a global function pointers may not a good chioce.
   Add a new member in kvm_guest_cbs to send Intel PT PMI for KVM guest.

Luwei Kang (2):
  KVM: x86: Inject PMI for KVM guest
  KVM: x86: Add support of clear Trace_ToPA_PMI status

 arch/x86/events/intel/core.c     |  6 +++++-
 arch/x86/include/asm/kvm_host.h  |  1 +
 arch/x86/include/asm/msr-index.h |  8 ++++++++
 arch/x86/kvm/vmx/pmu_intel.c     |  8 +++++++-
 arch/x86/kvm/x86.c               | 10 ++++++++++
 include/linux/perf_event.h       |  1 +
 6 files changed, 32 insertions(+), 2 deletions(-)

-- 
1.8.3.1


Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D40ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 170602148E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 170602148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeJSVqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 17:46:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:23847 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbeJSVp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 17:45:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2018 06:39:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,400,1534834800"; 
   d="scan'208";a="89603815"
Received: from svm-s2600wft.bj.intel.com ([10.240.193.45])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Oct 2018 06:39:45 -0700
From:   Yi Sun <yi.y.sun@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, jgross@suse.com,
        chao.p.peng@intel.com, chao.gao@intel.com,
        isaku.yamahata@intel.com, michael.h.kelley@microsoft.com,
        tianyu.lan@microsoft.com, Yi Sun <yi.y.sun@linux.intel.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Subject: [PATCH v1 0/2] Enable HvNotifyLongSpinWait for Hyper-V
Date:   Fri, 19 Oct 2018 21:13:53 +0800
Message-Id: <1539954835-34035-1-git-send-email-yi.y.sun@linux.intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HvNotifyLongSpinWait hypercall is used by a guest
OS to notify the hypervisor that the calling virtual
processor is attempting to acquire a resource that is
potentially held by another virtual processor within
the same Virtual Machine. This scheduling hint improves
the scalability of VMs with more than one virtual
processor on Hyper-V.

Per MSFT TLFS, the retry number is sent to hypervisor
only when the retry number exceeds the recommended
number. If recommended number is 0xFFFFFFFF, never retry.

The recommended number if got from EBX of Implementation
Recommendations MSR (0x40000004).

This patch set bases on latest tip branch because below
patch set has not been merged into main branch.
    [PATCH v4 0/2] Enable PV qspinlock for Hyper-V

Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>
Cc: Juergen Gross <jgross@suse.com>

Yi Sun (2):
  x86/hyperv: get number of spinlock retry on Hyper-V
  x86/hyperv: call HVCALL_NOTIFY_LONG_SPIN_WAIT

 arch/x86/hyperv/hv_spinlock.c       | 18 ++++++++++++++++++
 arch/x86/include/asm/mshyperv.h     |  4 ++++
 arch/x86/kernel/cpu/mshyperv.c      |  1 +
 kernel/locking/qspinlock_paravirt.h | 10 ++++++++++
 4 files changed, 33 insertions(+)

-- 
1.9.1


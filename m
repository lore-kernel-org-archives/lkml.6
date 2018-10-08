Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08BCC64EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9482088F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9482088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbeJHQGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 12:06:15 -0400
Received: from mga14.intel.com ([192.55.52.115]:6001 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbeJHQFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 12:05:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2018 01:55:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,356,1534834800"; 
   d="scan'208";a="93194658"
Received: from svm-s2600wft.bj.intel.com ([10.240.193.45])
  by fmsmga002.fm.intel.com with ESMTP; 08 Oct 2018 01:54:55 -0700
From:   Yi Sun <yi.y.sun@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, jgross@suse.com,
        chao.p.peng@intel.com, chao.gao@intel.com,
        isaku.yamahata@intel.com, michael.h.kelley@microsoft.com,
        tianyu.lan@microsoft.com, Yi Sun <yi.y.sun@linux.intel.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Subject: [PATCH v4 0/2] Enable PV qspinlock for Hyper-V
Date:   Mon,  8 Oct 2018 16:29:32 +0800
Message-Id: <1538987374-51217-1-git-send-email-yi.y.sun@linux.intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3->v4:
    - To avoid possible hang issue (if hv_qlock_wait can be
      interrupted, kick may happen before reading HV_X64_MSR_GUEST_IDLE
      so that hang happens), disable interrupt before READ_ONCE, then
      restore it after reading HV_X64_MSR_GUEST_IDLE.
v2->v3:
    - use "Hyper-V: " as the message prefix
    - remove unnecessary header files
    - remove unnecessary check in 'hv_qlock_wait'
    - fix compilation error on different platforms

v1->v2:
    - compile hv_spinlock.c only when CONFIG_PARAVIRT_SPINLOCKS enabled
    - merge v1 patch 2/3 to single patch
    - remove part of the boilerplate in hv_spinlock.c
    - declare hv_pvspin as __initdata
    - remove spin_wait_info and hv_notify_long_spin_wait because
      SpinWaitInfo is a standalone feature.
    - add comments for reading HV_X64_MSR_GUEST_IDLE
    - replace pr_warn to pr_info
    - use pr_fmt instead of the 'hv:' prefix
    - register callback function for smp_ops.smp_prepare_boot_cpu
      to initialize hyper-v spinlock

This patch adds the necessary Hyper-V specific code to allow
PV qspinlock work on Hyper-V.

In wait callback function, read HV_X64_MSR_GUEST_IDLE MSR
to trigger the guest's transition to the idle power state
which can be exited by an IPI even if IF flag is disabled.

In kick callback function, just send platform IPI to make
waiting vcpu exit idle state.

In vcpu_is_preempted callback function, return false directly
because Hyper-V does not provide such interface so far.


Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>
Cc: Juergen Gross <jgross@suse.com>

Yi Sun (2):
  X86/Hyper-V: Add Guest IDLE MSR support
  locking/pvqspinlock, hv: Enable PV qspinlock for Hyper-V

 Documentation/admin-guide/kernel-parameters.txt |  5 ++
 arch/x86/hyperv/Makefile                        |  4 ++
 arch/x86/hyperv/hv_spinlock.c                   | 85 +++++++++++++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h              |  5 ++
 arch/x86/include/asm/mshyperv.h                 |  1 +
 arch/x86/kernel/cpu/mshyperv.c                  | 14 ++++
 6 files changed, 114 insertions(+)
 create mode 100644 arch/x86/hyperv/hv_spinlock.c

-- 
1.9.1


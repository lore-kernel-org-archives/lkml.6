Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D0BC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65CE4206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65CE4206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbeIMOqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 10:46:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:49361 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbeIMOqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 10:46:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2018 02:37:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,368,1531810800"; 
   d="scan'208";a="90093124"
Received: from svm-s2600wft.bj.intel.com ([10.240.193.45])
  by orsmga001.jf.intel.com with ESMTP; 13 Sep 2018 02:37:44 -0700
From:   Yi Sun <yi.y.sun@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, chao.p.peng@intel.com, chao.gao@intel.com,
        isaku.yamahata@intel.com, michael.h.kelly@microsoft.com,
        tianyu.lan@microsoft.com, Yi Sun <yi.y.sun@linux.intel.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1 0/3] Enable PV qspinlock for Hyper-V
Date:   Thu, 13 Sep 2018 17:13:22 +0800
Message-Id: <1536830005-37260-1-git-send-email-yi.y.sun@linux.intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the necessary Hyper-V specific code to allow
PV qspinlock work on Hyper-V.

In wait callback function, read HV_X64_MSR_GUEST_IDLE MSR
to trigger the guest's transition to the idle power state
which can be exited by an IPI even if IF flag is disabled.
Beside that, make HVCALL_NOTIFY_LONG_SPIN_WAIT hypervall to
notify the hypervisor that the calling virtual processor is
attempting to acquire a resource that is potentially held
by another virtual processor within the same partition. This
scheduling hint improves the scalability of partitions with
more than one virtual processor.

In kick callback function, just send platform IPI to make
waiting vcpu exit idle state.

In vcpu_is_preempted callback function, return false directly
because Hyper-V does not provide such interface so far.


Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Jonathan Corbet <corbet@lwn.net>

Yi Sun (3):
  X86/Hyper-V: Add Guest IDLE MSR support
  locking/pvqspinlock, hv: Enable PV qspinlock for Hyper-V
  hv: add description for hv_nopvspin

 Documentation/admin-guide/kernel-parameters.txt |  5 ++
 arch/x86/hyperv/Makefile                        |  2 +-
 arch/x86/hyperv/hv_spinlock.c                   | 99 +++++++++++++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h              |  5 ++
 arch/x86/include/asm/mshyperv.h                 |  3 +
 arch/x86/kernel/smpboot.c                       |  2 +
 6 files changed, 115 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/hyperv/hv_spinlock.c

-- 
1.9.1


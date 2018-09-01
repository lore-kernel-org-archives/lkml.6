Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47767C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 02:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A8720845
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 02:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A8720845
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbeIBGfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 02:35:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:13094 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbeIBGfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 02:35:09 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Sep 2018 19:21:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,318,1531810800"; 
   d="scan'208";a="80211544"
Received: from dbxu-mobl.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.212.218])
  by orsmga003.jf.intel.com with ESMTP; 01 Sep 2018 19:20:58 -0700
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1fwI0X-0003Za-5R; Sun, 02 Sep 2018 10:20:57 +0800
Message-Id: <20180901124811.469883138@intel.com>
User-Agent: quilt/0.63-1
Date:   Sat, 01 Sep 2018 19:28:19 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Fengguang Wu <fengguang.wu@intel.com>
cc:     Peng DongX <dongx.peng@intel.com>
cc:     Liu Jingqi <jingqi.liu@intel.com>
cc:     Dong Eddie <eddie.dong@intel.com>
CC:     Dave Hansen <dave.hansen@intel.com>
cc:     Huang Ying <ying.huang@intel.com>
CC:     Brendan Gregg <bgregg@netflix.com>
cc:     kvm@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH 1/5] [PATCH 1/5] kvm: register in task_struct
References: <20180901112818.126790961@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=0001-kvm-register-in-task_struct.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The added pointer will be used by the /proc/PID/idle_bitmap code to
quickly identify QEMU task and walk EPT/NPT accordingly. For virtual
machines, the A bits will be set in guest page tables and EPT/NPT,
rather than the QEMU task page table.

This costs 8 bytes in task_struct which could be wasteful for the
majority normal tasks. The alternative is to add a flag only, and
let it find the corresponding VM in kvm vm_list.

Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 include/linux/sched.h | 10 ++++++++++
 virt/kvm/kvm_main.c   |  1 +
 2 files changed, 11 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 43731fe51c97..26c8549bbc28 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -38,6 +38,7 @@ struct cfs_rq;
 struct fs_struct;
 struct futex_pi_state;
 struct io_context;
+struct kvm;
 struct mempolicy;
 struct nameidata;
 struct nsproxy;
@@ -1179,6 +1180,9 @@ struct task_struct {
 	/* Used by LSM modules for access restriction: */
 	void				*security;
 #endif
+#if IS_ENABLED(CONFIG_KVM)
+        struct kvm                      *kvm;
+#endif
 
 	/*
 	 * New fields for task_struct should be added above here, so that
@@ -1898,4 +1902,10 @@ static inline void rseq_syscall(struct pt_regs *regs)
 
 #endif
 
+#if IS_ENABLED(CONFIG_KVM)
+static inline struct kvm *task_kvm(struct task_struct *t) { return t->kvm; }
+#else
+static inline struct kvm *task_kvm(struct task_struct *t) { return NULL; }
+#endif
+
 #endif
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 8b47507faab5..0c483720de8d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3892,6 +3892,7 @@ static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm)
 	if (type == KVM_EVENT_CREATE_VM) {
 		add_uevent_var(env, "EVENT=create");
 		kvm->userspace_pid = task_pid_nr(current);
+		current->kvm = kvm;
 	} else if (type == KVM_EVENT_DESTROY_VM) {
 		add_uevent_var(env, "EVENT=destroy");
 	}
-- 
2.15.0




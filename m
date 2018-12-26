Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D6AC43444
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEBFD218EA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbeLZNhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 08:37:13 -0500
Received: from mga04.intel.com ([192.55.52.120]:33941 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbeLZNhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 08:37:07 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2018 05:37:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,400,1539673200"; 
   d="scan'208";a="121185473"
Received: from wangdan1-mobl1.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.210.154])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Dec 2018 05:37:02 -0800
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1gc9Mr-0005Oy-IC; Wed, 26 Dec 2018 21:37:01 +0800
Message-Id: <20181226133351.894160986@intel.com>
User-Agent: quilt/0.65
Date:   Wed, 26 Dec 2018 21:15:00 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Nikita Leshenko <nikita.leshchenko@oracle.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Fengguang Wu <fengguang.wu@intel.com>
cc:     kvm@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
cc:     Fan Du <fan.du@intel.com>
cc:     Yao Yuan <yuan.yao@intel.com>
cc:     Peng Dong <dongx.peng@intel.com>
cc:     Huang Ying <ying.huang@intel.com>
CC:     Liu Jingqi <jingqi.liu@intel.com>
cc:     Dong Eddie <eddie.dong@intel.com>
cc:     Dave Hansen <dave.hansen@intel.com>
cc:     Zhang Yi <yi.z.zhang@linux.intel.com>
cc:     Dan Williams <dan.j.williams@intel.com>
Subject: [RFC][PATCH v2 14/21] kvm: register in mm_struct
References: <20181226131446.330864849@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=0009-kvm-register-in-mm_struct.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VM is associated with an address space and not a specific thread.

>From Documentation/virtual/kvm/api.txt:
   Only run VM ioctls from the same process (address space) that was used
   to create the VM.

CC: Nikita Leshenko <nikita.leshchenko@oracle.com>
CC: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 include/linux/mm_types.h |   11 +++++++++++
 virt/kvm/kvm_main.c      |    3 +++
 2 files changed, 14 insertions(+)

--- linux.orig/include/linux/mm_types.h	2018-12-23 19:58:06.993417137 +0800
+++ linux/include/linux/mm_types.h	2018-12-23 19:58:06.993417137 +0800
@@ -27,6 +27,7 @@ typedef int vm_fault_t;
 struct address_space;
 struct mem_cgroup;
 struct hmm;
+struct kvm;
 
 /*
  * Each physical page in the system has a struct page associated with
@@ -496,6 +497,10 @@ struct mm_struct {
 		/* HMM needs to track a few things per mm */
 		struct hmm *hmm;
 #endif
+
+#if IS_ENABLED(CONFIG_KVM)
+		struct kvm *kvm;
+#endif
 	} __randomize_layout;
 
 	/*
@@ -507,6 +512,12 @@ struct mm_struct {
 
 extern struct mm_struct init_mm;
 
+#if IS_ENABLED(CONFIG_KVM)
+static inline struct kvm *mm_kvm(struct mm_struct *mm) { return mm->kvm; }
+#else
+static inline struct kvm *mm_kvm(struct mm_struct *mm) { return NULL; }
+#endif
+
 /* Pointer magic because the dynamic array size confuses some compilers. */
 static inline void mm_init_cpumask(struct mm_struct *mm)
 {
--- linux.orig/virt/kvm/kvm_main.c	2018-12-23 19:58:06.993417137 +0800
+++ linux/virt/kvm/kvm_main.c	2018-12-23 19:58:06.993417137 +0800
@@ -727,6 +727,7 @@ static void kvm_destroy_vm(struct kvm *k
 	struct mm_struct *mm = kvm->mm;
 
 	kvm_uevent_notify_change(KVM_EVENT_DESTROY_VM, kvm);
+	mm->kvm = NULL;
 	kvm_destroy_vm_debugfs(kvm);
 	kvm_arch_sync_events(kvm);
 	spin_lock(&kvm_lock);
@@ -3224,6 +3225,8 @@ static int kvm_dev_ioctl_create_vm(unsig
 		fput(file);
 		return -ENOMEM;
 	}
+
+	kvm->mm->kvm = kvm;
 	kvm_uevent_notify_change(KVM_EVENT_CREATE_VM, kvm);
 
 	fd_install(r, file);



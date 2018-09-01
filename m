Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB73C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 02:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFCE420843
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 02:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFCE420843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbeIBGfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 02:35:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:13094 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726749AbeIBGfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 02:35:10 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Sep 2018 19:21:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,318,1531810800"; 
   d="scan'208";a="80211548"
Received: from dbxu-mobl.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.212.218])
  by orsmga003.jf.intel.com with ESMTP; 01 Sep 2018 19:20:58 -0700
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1fwI0X-0003Zq-7h; Sun, 02 Sep 2018 10:20:57 +0800
Message-Id: <20180901124811.703808090@intel.com>
User-Agent: quilt/0.63-1
Date:   Sat, 01 Sep 2018 19:28:23 +0800
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
Subject: [RFC][PATCH 5/5] [PATCH 5/5] kvm-ept-idle: enable module
References: <20180901112818.126790961@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=0005-kvm-ept-idle-enable-module.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 arch/x86/kvm/Kconfig  | 11 +++++++++++
 arch/x86/kvm/Makefile |  4 ++++
 2 files changed, 15 insertions(+)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 1bbec387d289..4c6dec47fac6 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -96,6 +96,17 @@ config KVM_MMU_AUDIT
 	 This option adds a R/W kVM module parameter 'mmu_audit', which allows
 	 auditing of KVM MMU events at runtime.
 
+config KVM_EPT_IDLE
+	tristate "KVM EPT idle page tracking"
+	depends on KVM_INTEL
+	depends on PROC_PAGE_MONITOR
+	---help---
+	  Provides support for walking EPT to get the A bits on Intel
+	  processors equipped with the VT extensions.
+
+	  To compile this as a module, choose M here: the module
+	  will be called kvm-ept-idle.
+
 # OK, it's a little counter-intuitive to do this, but it puts it neatly under
 # the virtualization menu.
 source drivers/vhost/Kconfig
diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index dc4f2fdf5e57..5cad0590205d 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -19,6 +19,10 @@ kvm-y			+= x86.o mmu.o emulate.o i8259.o irq.o lapic.o \
 kvm-intel-y		+= vmx.o pmu_intel.o
 kvm-amd-y		+= svm.o pmu_amd.o
 
+kvm-ept-idle-y		+= ept_idle.o
+
 obj-$(CONFIG_KVM)	+= kvm.o
 obj-$(CONFIG_KVM_INTEL)	+= kvm-intel.o
 obj-$(CONFIG_KVM_AMD)	+= kvm-amd.o
+
+obj-$(CONFIG_KVM_EPT_IDLE)	+= kvm-ept-idle.o
-- 
2.15.0




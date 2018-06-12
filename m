Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8516BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30CFE20891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DOLb/7Ig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30CFE20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934870AbeFLVBE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 17:01:04 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:1586 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933637AbeFLU4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1528836997; x=1560372997;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=aetijkW91Fp4XfXAl8frmA7sH4Dko/J8u338j2ApKUw=;
  b=DOLb/7IgN7/jcw4b0dlsfMpySBmoBkQnobhAVeQoUHmRlWQpUO5f0zHz
   4krpSYw/1M2rVWznUnV35EP6m73X5dWpvf0PbxcbNYMjFDt7Yc6aoDwI6
   XHrbuoebtXdHuYbbdZmI4GaKR2tZu+bn3il6NAqsE5WLu+mHrkbGfjd1F
   0=;
X-IronPort-AV: E=Sophos;i="5.51,216,1526342400"; 
   d="scan'208";a="617032495"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Jun 2018 20:56:34 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w5CKuVEa129961
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 12 Jun 2018 20:56:34 GMT
Received: from EX13D16UWC001.ant.amazon.com (10.43.162.117) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Jun 2018 20:56:32 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D16UWC001.ant.amazon.com (10.43.162.117) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Jun 2018 20:56:31 +0000
Received: from localhost (10.25.15.63) by mail-relay.amazon.com
 (10.43.162.232) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 12 Jun 2018 20:56:31 +0000
From:   Anchal Agarwal <anchalag@amazon.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <x86@kernel.org>
CC:     <boris.ostrovsky@oracle.com>, <konrad.wilk@oracle.com>,
        <roger.pau@citrix.com>, <netdev@vger.kernel.org>,
        <jgross@suse.com>, <xen-devel@lists.xenproject.org>,
        <linux-kernel@vger.kernel.org>, <kamatam@amazon.com>,
        <anchalag@amazon.com>, <fllinden@amazon.com>, <vallish@amazon.com>,
        <guruanb@amazon.com>, <eduval@amazon.com>, <rjw@rjwysocki.net>,
        <pavel@ucw.cz>, <len.brown@intel.com>, <linux-pm@vger.kernel.org>,
        <cyberax@amazon.com>
Subject: [RFC PATCH 05/12] x86/xen: add system core suspend and resume callbacks
Date:   Tue, 12 Jun 2018 20:56:12 +0000
Message-ID: <20180612205619.28156-6-anchalag@amazon.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180612205619.28156-1-anchalag@amazon.com>
References: <20180612205619.28156-1-anchalag@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Munehisa Kamata <kamatam@amazon.com>

Add Xen PVHVM specific system core callbacks for PM suspend and
hibernation support. The callbacks suspend and resume Xen primitives,
like shared_info, pvclock and grant table. Note that Xen suspend can
handle them in a different manner, but system core callbacks are called
from the context. So if the callbacks are called from Xen suspend
context, return immediately.

Signed-off-by: Munehisa Kamata <kamatam@amazon.com>
Signed-off-by: Anchal Agarwal <anchalag@amazon.com>
Reviewed-by: Munehisa Kamata <kamatam@amazon.com>
Reviewed-by: Eduardo Valentin <eduval@amazon.com>
---
 arch/x86/xen/enlighten_hvm.c |  1 +
 arch/x86/xen/suspend.c       | 53 ++++++++++++++++++++++++++++++++++++++++++++
 include/xen/xen-ops.h        |  2 ++
 3 files changed, 56 insertions(+)

diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index d24ad16..4196a65 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -202,6 +202,7 @@ static void __init xen_hvm_guest_init(void)
 	if (xen_feature(XENFEAT_hvm_callback_vector))
 		xen_have_vector_callback = 1;
 
+	xen_setup_syscore_ops();
 	xen_hvm_smp_init();
 	WARN_ON(xen_cpuhp_setup(xen_cpu_up_prepare_hvm, xen_cpu_dead_hvm));
 	xen_unplug_emulated_devices();
diff --git a/arch/x86/xen/suspend.c b/arch/x86/xen/suspend.c
index 1d83152..784c448 100644
--- a/arch/x86/xen/suspend.c
+++ b/arch/x86/xen/suspend.c
@@ -2,17 +2,22 @@
 #include <linux/types.h>
 #include <linux/tick.h>
 #include <linux/percpu-defs.h>
+#include <linux/syscore_ops.h>
+#include <linux/kernel_stat.h>
 
 #include <xen/xen.h>
 #include <xen/interface/xen.h>
+#include <xen/interface/memory.h>
 #include <xen/grant_table.h>
 #include <xen/events.h>
+#include <xen/xen-ops.h>
 
 #include <asm/cpufeatures.h>
 #include <asm/msr-index.h>
 #include <asm/xen/hypercall.h>
 #include <asm/xen/page.h>
 #include <asm/fixmap.h>
+#include <asm/pvclock.h>
 
 #include "xen-ops.h"
 #include "mmu.h"
@@ -82,3 +87,51 @@ void xen_arch_suspend(void)
 
 	on_each_cpu(xen_vcpu_notify_suspend, NULL, 1);
 }
+
+static int xen_syscore_suspend(void)
+{
+	struct xen_remove_from_physmap xrfp;
+	int ret;
+
+	/* Xen suspend does similar stuffs in its own logic */
+	if (xen_suspend_mode_is_xen_suspend())
+		return 0;
+
+	xrfp.domid = DOMID_SELF;
+	xrfp.gpfn = __pa(HYPERVISOR_shared_info) >> PAGE_SHIFT;
+
+	ret = HYPERVISOR_memory_op(XENMEM_remove_from_physmap, &xrfp);
+	if (!ret)
+		HYPERVISOR_shared_info = &xen_dummy_shared_info;
+
+	return ret;
+}
+
+static void xen_syscore_resume(void)
+{
+	/* Xen suspend does similar stuffs in its own logic */
+	if (xen_suspend_mode_is_xen_suspend())
+		return;
+
+	/* No need to setup vcpu_info as it's already moved off */
+	xen_hvm_map_shared_info();
+
+	pvclock_resume();
+
+	gnttab_resume();
+}
+
+/*
+ * These callbacks will be called with interrupts disabled and when having only
+ * one CPU online.
+ */
+static struct syscore_ops xen_hvm_syscore_ops = {
+	.suspend = xen_syscore_suspend,
+	.resume = xen_syscore_resume
+};
+
+void __init xen_setup_syscore_ops(void)
+{
+	if (xen_hvm_domain())
+		register_syscore_ops(&xen_hvm_syscore_ops);
+}
diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
index be78f6f..65f25bd 100644
--- a/include/xen/xen-ops.h
+++ b/include/xen/xen-ops.h
@@ -43,6 +43,8 @@ bool xen_suspend_mode_is_xen_suspend(void);
 bool xen_suspend_mode_is_pm_suspend(void);
 bool xen_suspend_mode_is_pm_hibernation(void);
 
+void xen_setup_syscore_ops(void);
+
 extern unsigned long *xen_contiguous_bitmap;
 
 #ifdef CONFIG_XEN_PV
-- 
2.7.4


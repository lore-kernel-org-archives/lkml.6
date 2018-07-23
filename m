Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211DFECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE06F20685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:44:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE06F20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388442AbeGWNpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:45:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49768 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388102AbeGWNpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:45:54 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E9F07CAB;
        Mon, 23 Jul 2018 12:44:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 046/107] xen: set cpu capabilities from xen_start_kernel()
Date:   Mon, 23 Jul 2018 14:41:40 +0200
Message-Id: <20180723122415.189796152@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122413.003644357@linuxfoundation.org>
References: <20180723122413.003644357@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juergen Gross <jgross@suse.com>

Upstream commit: 0808e80cb760de2733c0527d2090ed2205a1eef8 ("xen: set
cpu capabilities from xen_start_kernel()")

There is no need to set the same capabilities for each cpu
individually. This can easily be done for all cpus when starting the
kernel.

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/xen/enlighten.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -460,6 +460,14 @@ static void __init xen_init_cpuid_mask(v
 		cpuid_leaf1_ecx_set_mask = (1 << (X86_FEATURE_MWAIT % 32));
 }
 
+static void __init xen_init_capabilities(void)
+{
+	if (xen_pv_domain()) {
+		setup_clear_cpu_cap(X86_BUG_SYSRET_SS_ATTRS);
+		setup_force_cpu_cap(X86_FEATURE_XENPV);
+	}
+}
+
 static void xen_set_debugreg(int reg, unsigned long val)
 {
 	HYPERVISOR_set_debugreg(reg, val);
@@ -1587,6 +1595,7 @@ asmlinkage __visible void __init xen_sta
 
 	xen_init_irq_ops();
 	xen_init_cpuid_mask();
+	xen_init_capabilities();
 
 #ifdef CONFIG_X86_LOCAL_APIC
 	/*
@@ -1883,14 +1892,6 @@ bool xen_hvm_need_lapic(void)
 }
 EXPORT_SYMBOL_GPL(xen_hvm_need_lapic);
 
-static void xen_set_cpu_features(struct cpuinfo_x86 *c)
-{
-	if (xen_pv_domain()) {
-		clear_cpu_bug(c, X86_BUG_SYSRET_SS_ATTRS);
-		set_cpu_cap(c, X86_FEATURE_XENPV);
-	}
-}
-
 const struct hypervisor_x86 x86_hyper_xen = {
 	.name			= "Xen",
 	.detect			= xen_platform,
@@ -1898,7 +1899,6 @@ const struct hypervisor_x86 x86_hyper_xe
 	.init_platform		= xen_hvm_guest_init,
 #endif
 	.x2apic_available	= xen_x2apic_para_available,
-	.set_cpu_features       = xen_set_cpu_features,
 };
 EXPORT_SYMBOL(x86_hyper_xen);
 



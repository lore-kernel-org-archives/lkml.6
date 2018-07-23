Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90D2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B7B20685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7B7B20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388528AbeGWNpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:45:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49166 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388032AbeGWNpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:45:13 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6A6D0C9D;
        Mon, 23 Jul 2018 12:44:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jan Beulich <jbeulich@suse.com>,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 036/107] x86/xen: Zero MSR_IA32_SPEC_CTRL before suspend
Date:   Mon, 23 Jul 2018 14:41:30 +0200
Message-Id: <20180723122414.674999043@linuxfoundation.org>
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

commit 71c208dd54ab971036d83ff6d9837bae4976e623 upstream.

Older Xen versions (4.5 and before) might have problems migrating pv
guests with MSR_IA32_SPEC_CTRL having a non-zero value. So before
suspending zero that MSR and restore it after being resumed.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jan Beulich <jbeulich@suse.com>
Cc: stable@vger.kernel.org
Cc: xen-devel@lists.xenproject.org
Cc: boris.ostrovsky@oracle.com
Link: https://lkml.kernel.org/r/20180226140818.4849-1-jgross@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/xen/suspend.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/arch/x86/xen/suspend.c
+++ b/arch/x86/xen/suspend.c
@@ -1,11 +1,14 @@
 #include <linux/types.h>
 #include <linux/tick.h>
+#include <linux/percpu-defs.h>
 
 #include <xen/xen.h>
 #include <xen/interface/xen.h>
 #include <xen/grant_table.h>
 #include <xen/events.h>
 
+#include <asm/cpufeatures.h>
+#include <asm/msr-index.h>
 #include <asm/xen/hypercall.h>
 #include <asm/xen/page.h>
 #include <asm/fixmap.h>
@@ -68,6 +71,8 @@ static void xen_pv_post_suspend(int susp
 	xen_mm_unpin_all();
 }
 
+static DEFINE_PER_CPU(u64, spec_ctrl);
+
 void xen_arch_pre_suspend(void)
 {
 	if (xen_pv_domain())
@@ -84,6 +89,9 @@ void xen_arch_post_suspend(int cancelled
 
 static void xen_vcpu_notify_restore(void *data)
 {
+	if (xen_pv_domain() && boot_cpu_has(X86_FEATURE_SPEC_CTRL))
+		wrmsrl(MSR_IA32_SPEC_CTRL, this_cpu_read(spec_ctrl));
+
 	/* Boot processor notified via generic timekeeping_resume() */
 	if (smp_processor_id() == 0)
 		return;
@@ -93,7 +101,15 @@ static void xen_vcpu_notify_restore(void
 
 static void xen_vcpu_notify_suspend(void *data)
 {
+	u64 tmp;
+
 	tick_suspend_local();
+
+	if (xen_pv_domain() && boot_cpu_has(X86_FEATURE_SPEC_CTRL)) {
+		rdmsrl(MSR_IA32_SPEC_CTRL, tmp);
+		this_cpu_write(spec_ctrl, tmp);
+		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+	}
 }
 
 void xen_arch_resume(void)



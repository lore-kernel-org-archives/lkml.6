Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEF8ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E1D20685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E1D20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388652AbeGWNqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:46:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49958 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388102AbeGWNqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:46:03 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8E609C18;
        Mon, 23 Jul 2018 12:44:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 047/107] x86/amd: dont set X86_BUG_SYSRET_SS_ATTRS when running under Xen
Date:   Mon, 23 Jul 2018 14:41:41 +0200
Message-Id: <20180723122415.243662310@linuxfoundation.org>
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

From: David Woodhouse <dwmw@amazon.co.uk>

commit def9331a12977770cc6132d79f8e6565871e8e38 upstream

When running as Xen pv guest X86_BUG_SYSRET_SS_ATTRS must not be set
on AMD cpus.

This bug/feature bit is kind of special as it will be used very early
when switching threads. Setting the bit and clearing it a little bit
later leaves a critical window where things can go wrong. This time
window has enlarged a little bit by using setup_clear_cpu_cap() instead
of the hypervisor's set_cpu_features callback. It seems this larger
window now makes it rather easy to hit the problem.

The proper solution is to never set the bit in case of Xen.

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/kernel/cpu/amd.c |    5 +++--
 arch/x86/xen/enlighten.c  |    4 +---
 2 files changed, 4 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -791,8 +791,9 @@ static void init_amd(struct cpuinfo_x86
 		if (cpu_has(c, X86_FEATURE_3DNOW) || cpu_has(c, X86_FEATURE_LM))
 			set_cpu_cap(c, X86_FEATURE_3DNOWPREFETCH);
 
-	/* AMD CPUs don't reset SS attributes on SYSRET */
-	set_cpu_bug(c, X86_BUG_SYSRET_SS_ATTRS);
+	/* AMD CPUs don't reset SS attributes on SYSRET, Xen does. */
+	if (!cpu_has(c, X86_FEATURE_XENPV))
+		set_cpu_bug(c, X86_BUG_SYSRET_SS_ATTRS);
 }
 
 #ifdef CONFIG_X86_32
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -462,10 +462,8 @@ static void __init xen_init_cpuid_mask(v
 
 static void __init xen_init_capabilities(void)
 {
-	if (xen_pv_domain()) {
-		setup_clear_cpu_cap(X86_BUG_SYSRET_SS_ATTRS);
+	if (xen_pv_domain())
 		setup_force_cpu_cap(X86_FEATURE_XENPV);
-	}
 }
 
 static void xen_set_debugreg(int reg, unsigned long val)



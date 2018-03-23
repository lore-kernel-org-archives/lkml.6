Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1092440-1521803814-3-15164162109521963329
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521803814; b=Cg3UW+pGCGE9SXVKNbxewcDel0vJSzE4UeBKOYBCpSKeuJn
    qasFnCdRYpCnRod1eu3mTQu26RZOrSxXIjoRcdHCBbaYWZMKLzRE23/NLL532Q35
    +b0RiEyuUxqC2skCuKYmBB55i2+deWIW1KY6s8bizsQDs9hfEQQqfmJdna02JpXZ
    mbpyzPXtpCirxD32EpbroulxIEKptXGm/N8lmJj8yuYP+lWZv6lQlAjySmQFT4IY
    t+vt7RZEaSYKWa6ejKYVMUUDURcky5bp4BiS/K2696FNUFEGwhCn5Yo/w5FE7dpO
    owsJMZhOmCXTu07dqxFutMbj5ktUs5XFtYcGGbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803814; bh=EQezguyr+8KXquQBlyOkZxzsEb
    8o2IT4nOEKDTTc00M=; b=VCSHbISSt7bjcWZ1XSuu+qBw+8rrUzk1n1ntebXA9Y
    bIsT/XghyexkuS7QZwXQ2kRIt9AcE2Lff1R3cOKkbIk/J+wf9gknPnsfmkviwC82
    Hsol4wvO+Koral9jNTSN810j9rwdkkXDCLWVRdu+idN+INueeDF4HO3Q50jAYWUD
    uoFawta2hlyHXs1wTKj18GMCg6wV53F/rUV+71URMEuY4Zv8o2N1yPLOjNSXYZ6M
    jkBSWVTrOSzxPTRA+xAzKFPlV1/IVW1GnZdpjcpF0s+gbEzdl6a3XFD3YzXtxxGP
    3Y8S3AQU1cVfHgYIZB1BslZjEYawmyghqcobMWS9IPrA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751713AbeCWLQg (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:16:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42190 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932495AbeCWKJh (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:09:37 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 120/177] x86/xen: split xen_smp_prepare_boot_cpu()
Date: Fri, 23 Mar 2018 10:54:08 +0100
Message-Id: <20180323094210.546742681@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vitaly Kuznetsov <vkuznets@redhat.com>


[ Upstream commit a2d1078a35f9a38ae888aa6147e4ca32666154a1 ]

Split xen_smp_prepare_boot_cpu() into xen_pv_smp_prepare_boot_cpu() and
xen_hvm_smp_prepare_boot_cpu() to support further splitting of smp.c.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/xen/smp.c |   49 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 19 deletions(-)

--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -299,35 +299,46 @@ static void __init xen_filter_cpu_maps(v
 
 }
 
-static void __init xen_smp_prepare_boot_cpu(void)
+static void __init xen_pv_smp_prepare_boot_cpu(void)
 {
 	BUG_ON(smp_processor_id() != 0);
 	native_smp_prepare_boot_cpu();
 
-	if (xen_pv_domain()) {
-		if (!xen_feature(XENFEAT_writable_page_tables))
-			/* We've switched to the "real" per-cpu gdt, so make
-			 * sure the old memory can be recycled. */
-			make_lowmem_page_readwrite(xen_initial_gdt);
+	if (!xen_feature(XENFEAT_writable_page_tables))
+		/* We've switched to the "real" per-cpu gdt, so make
+		 * sure the old memory can be recycled. */
+		make_lowmem_page_readwrite(xen_initial_gdt);
 
 #ifdef CONFIG_X86_32
-		/*
-		 * Xen starts us with XEN_FLAT_RING1_DS, but linux code
-		 * expects __USER_DS
-		 */
-		loadsegment(ds, __USER_DS);
-		loadsegment(es, __USER_DS);
+	/*
+	 * Xen starts us with XEN_FLAT_RING1_DS, but linux code
+	 * expects __USER_DS
+	 */
+	loadsegment(ds, __USER_DS);
+	loadsegment(es, __USER_DS);
 #endif
 
-		xen_filter_cpu_maps();
-		xen_setup_vcpu_info_placement();
-	}
+	xen_filter_cpu_maps();
+	xen_setup_vcpu_info_placement();
+
+	/*
+	 * The alternative logic (which patches the unlock/lock) runs before
+	 * the smp bootup up code is activated. Hence we need to set this up
+	 * the core kernel is being patched. Otherwise we will have only
+	 * modules patched but not core code.
+	 */
+	xen_init_spinlocks();
+}
+
+static void __init xen_hvm_smp_prepare_boot_cpu(void)
+{
+	BUG_ON(smp_processor_id() != 0);
+	native_smp_prepare_boot_cpu();
 
 	/*
 	 * Setup vcpu_info for boot CPU.
 	 */
-	if (xen_hvm_domain())
-		xen_vcpu_setup(0);
+	xen_vcpu_setup(0);
 
 	/*
 	 * The alternative logic (which patches the unlock/lock) runs before
@@ -733,7 +744,7 @@ static irqreturn_t xen_irq_work_interrup
 }
 
 static const struct smp_ops xen_smp_ops __initconst = {
-	.smp_prepare_boot_cpu = xen_smp_prepare_boot_cpu,
+	.smp_prepare_boot_cpu = xen_pv_smp_prepare_boot_cpu,
 	.smp_prepare_cpus = xen_smp_prepare_cpus,
 	.smp_cpus_done = xen_smp_cpus_done,
 
@@ -772,5 +783,5 @@ void __init xen_hvm_smp_init(void)
 	smp_ops.cpu_die = xen_cpu_die;
 	smp_ops.send_call_func_ipi = xen_smp_send_call_function_ipi;
 	smp_ops.send_call_func_single_ipi = xen_smp_send_call_function_single_ipi;
-	smp_ops.smp_prepare_boot_cpu = xen_smp_prepare_boot_cpu;
+	smp_ops.smp_prepare_boot_cpu = xen_hvm_smp_prepare_boot_cpu;
 }

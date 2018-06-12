Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 10434C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAAD120891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XInkU9MP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAAD120891
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934745AbeFLU45 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:56:57 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:31600 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934335AbeFLU4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1528837004; x=1560373004;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Yw2zPwrO0M5CiRMiqXHX1y3V/D58hCoOhuENVMBy8i0=;
  b=XInkU9MPDdf3f6uxFg/qSThaABTbbrF1Jxp3imqy8PdtmZtvJSWFNS9x
   10T85wAPEBsnhYb6UKCzknGMMk+5n8XKXJlB8VPItOlDlsucpgfeJ070n
   R04yubTSoT9dtL44assI4eR12ooWGZ58JZ4cutW5TRIJx49L4zuxxHkWU
   k=;
X-IronPort-AV: E=Sophos;i="5.51,216,1526342400"; 
   d="scan'208";a="682679290"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Jun 2018 20:56:42 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w5CKueZc017015
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 12 Jun 2018 20:56:40 GMT
Received: from EX13D02UWB002.ant.amazon.com (10.43.161.80) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Jun 2018 20:56:37 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D02UWB002.ant.amazon.com (10.43.161.80) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Jun 2018 20:56:36 +0000
Received: from localhost (10.25.15.63) by mail-relay.amazon.com (10.43.61.243)
 with Microsoft SMTP Server id 15.0.1367.3 via Frontend Transport; Tue, 12 Jun
 2018 20:56:35 +0000
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
Subject: [RFC PATCH 09/12] x86/xen: save and restore steal clock
Date:   Tue, 12 Jun 2018 20:56:16 +0000
Message-ID: <20180612205619.28156-10-anchalag@amazon.com>
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

Save steal clock values of all present CPUs in the system core ops
suspend callbacks. Also, restore a boot CPU's steal clock in the system
core resume callback. For non-boot CPUs, restore after they're brought
up, because runstate info for non-boot CPUs are not active until then.

Signed-off-by: Munehisa Kamata <kamatam@amazon.com>
Signed-off-by: Anchal Agarwal <anchalag@amazon.com>
Reviewed-by: Munehisa Kamata <kamatam@amazon.com>
Reviewed-by: Eduardo Valentin <eduval@amazon.com>
---
 arch/x86/xen/suspend.c | 13 ++++++++++++-
 arch/x86/xen/time.c    |  3 +++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/suspend.c b/arch/x86/xen/suspend.c
index 784c448..dae0f74 100644
--- a/arch/x86/xen/suspend.c
+++ b/arch/x86/xen/suspend.c
@@ -91,12 +91,20 @@ void xen_arch_suspend(void)
 static int xen_syscore_suspend(void)
 {
 	struct xen_remove_from_physmap xrfp;
-	int ret;
+	int cpu, ret;
 
 	/* Xen suspend does similar stuffs in its own logic */
 	if (xen_suspend_mode_is_xen_suspend())
 		return 0;
 
+	for_each_present_cpu(cpu) {
+		/*
+		 * Nonboot CPUs are already offline, but the last copy of
+		 * runstate info is still accessible.
+		 */
+		xen_save_steal_clock(cpu);
+	}
+
 	xrfp.domid = DOMID_SELF;
 	xrfp.gpfn = __pa(HYPERVISOR_shared_info) >> PAGE_SHIFT;
 
@@ -118,6 +126,9 @@ static void xen_syscore_resume(void)
 
 	pvclock_resume();
 
+	/* Nonboot CPUs will be resumed when they're brought up */
+	xen_restore_steal_clock(smp_processor_id());
+
 	gnttab_resume();
 }
 
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index e0f1bcf..85f8534 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -523,6 +523,9 @@ static void xen_hvm_setup_cpu_clockevents(void)
 {
 	int cpu = smp_processor_id();
 	xen_setup_runstate_info(cpu);
+	if (cpu)
+		xen_restore_steal_clock(cpu);
+
 	/*
 	 * xen_setup_timer(cpu) - snprintf is bad in atomic context. Hence
 	 * doing it xen_hvm_cpu_notify (which gets called by smp_init during
-- 
2.7.4


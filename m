Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFAEECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E561920883
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E561920883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388860AbeGWNx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:53:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50966 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389014AbeGWNrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:47:42 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 18F14BDB;
        Mon, 23 Jul 2018 12:45:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 059/107] x86/bugs: Whitelist allowed SPEC_CTRL MSR values
Date:   Mon, 23 Jul 2018 14:41:53 +0200
Message-Id: <20180723122415.994188681@linuxfoundation.org>
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

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit 1115a859f33276fe8afb31c60cf9d8e657872558 upstream

Intel and AMD SPEC_CTRL (0x48) MSR semantics may differ in the
future (or in fact use different MSRs for the same functionality).

As such a run-time mechanism is required to whitelist the appropriate MSR
values.

[ tglx: Made the variable __ro_after_init ]
[ Srivatsa: Removed __ro_after_init for 4.4.y ]

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/kernel/cpu/bugs.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -34,6 +34,12 @@ static void __init ssb_select_mitigation
  */
 static u64 x86_spec_ctrl_base;
 
+/*
+ * The vendor and possibly platform specific bits which can be modified in
+ * x86_spec_ctrl_base.
+ */
+static u64 x86_spec_ctrl_mask = ~SPEC_CTRL_IBRS;
+
 void __init check_bugs(void)
 {
 	identify_boot_cpu();
@@ -116,7 +122,7 @@ static enum spectre_v2_mitigation spectr
 
 void x86_spec_ctrl_set(u64 val)
 {
-	if (val & ~(SPEC_CTRL_IBRS | SPEC_CTRL_RDS))
+	if (val & x86_spec_ctrl_mask)
 		WARN_ONCE(1, "SPEC_CTRL MSR value 0x%16llx is unknown.\n", val);
 	else
 		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base | val);
@@ -458,6 +464,7 @@ static enum ssb_mitigation_cmd __init __
 		switch (boot_cpu_data.x86_vendor) {
 		case X86_VENDOR_INTEL:
 			x86_spec_ctrl_base |= SPEC_CTRL_RDS;
+			x86_spec_ctrl_mask &= ~SPEC_CTRL_RDS;
 			x86_spec_ctrl_set(SPEC_CTRL_RDS);
 			break;
 		case X86_VENDOR_AMD:
@@ -481,7 +488,7 @@ static void ssb_select_mitigation()
 void x86_spec_ctrl_setup_ap(void)
 {
 	if (boot_cpu_has(X86_FEATURE_IBRS))
-		x86_spec_ctrl_set(x86_spec_ctrl_base & (SPEC_CTRL_IBRS | SPEC_CTRL_RDS));
+		x86_spec_ctrl_set(x86_spec_ctrl_base & ~x86_spec_ctrl_mask);
 }
 
 #ifdef CONFIG_SYSFS



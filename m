Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C241C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201F121653
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 201F121653
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389859AbeHNUpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:45:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59140 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390036AbeHNUaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:30:05 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 33B4DDD1;
        Tue, 14 Aug 2018 17:33:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.17 87/97] x86/speculation: Simplify sysfs report of VMX L1TF vulnerability
Date:   Tue, 14 Aug 2018 19:17:39 +0200
Message-Id: <20180814171436.445381682@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171433.160434170@linuxfoundation.org>
References: <20180814171433.160434170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini <pbonzini@redhat.com>

commit ea156d192f5257a5bf393d33910d3b481bf8a401 upstream

Three changes to the content of the sysfs file:

 - If EPT is disabled, L1TF cannot be exploited even across threads on the
   same core, and SMT is irrelevant.

 - If mitigation is completely disabled, and SMT is enabled, print "vulnerable"
   instead of "vulnerable, SMT vulnerable"

 - Reorder the two parts so that the main vulnerability state comes first
   and the detail on SMT is second.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -738,9 +738,15 @@ static ssize_t l1tf_show_state(char *buf
 	if (l1tf_vmx_mitigation == VMENTER_L1D_FLUSH_AUTO)
 		return sprintf(buf, "%s\n", L1TF_DEFAULT_MSG);
 
-	return sprintf(buf, "%s; VMX: SMT %s, L1D %s\n", L1TF_DEFAULT_MSG,
-		       cpu_smt_control == CPU_SMT_ENABLED ? "vulnerable" : "disabled",
-		       l1tf_vmx_states[l1tf_vmx_mitigation]);
+	if (l1tf_vmx_mitigation == VMENTER_L1D_FLUSH_EPT_DISABLED ||
+	    (l1tf_vmx_mitigation == VMENTER_L1D_FLUSH_NEVER &&
+	     cpu_smt_control == CPU_SMT_ENABLED))
+		return sprintf(buf, "%s; VMX: %s\n", L1TF_DEFAULT_MSG,
+			       l1tf_vmx_states[l1tf_vmx_mitigation]);
+
+	return sprintf(buf, "%s; VMX: %s, SMT %s\n", L1TF_DEFAULT_MSG,
+		       l1tf_vmx_states[l1tf_vmx_mitigation],
+		       cpu_smt_control == CPU_SMT_ENABLED ? "vulnerable" : "disabled");
 }
 #else
 static ssize_t l1tf_show_state(char *buf)



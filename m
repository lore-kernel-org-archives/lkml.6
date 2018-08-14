Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E125C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CACB021568
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CACB021568
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732686AbeHNSlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 14:41:55 -0400
Received: from mga18.intel.com ([134.134.136.126]:19665 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728978AbeHNSlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 14:41:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2018 08:54:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,238,1531810800"; 
   d="scan'208";a="81699484"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.132])
  by orsmga001.jf.intel.com with ESMTP; 14 Aug 2018 08:54:09 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     sean.j.christopherson@intel.com
Subject: [PATCH 1/2] KVM: vmx: Add defines for SGX ENCLS exiting
Date:   Tue, 14 Aug 2018 08:53:11 -0700
Message-Id: <20180814155312.19267-2-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814155312.19267-1-sean.j.christopherson@intel.com>
References: <20180814155312.19267-1-sean.j.christopherson@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware support for basic SGX virtualization adds a new execution
control (ENCLS_EXITING), VMCS field (ENCLS_EXITING_BITMAP) and exit
reason (ENCLS), that enables a VMM to intercept specific ENCLS leaf
functions, e.g. to inject faults when the VMM isn't exposing SGX to
a VM.  When ENCLS_EXITING is enabled, the VMM can set/clear bits in
the bitmap to intercept/allow ENCLS leaf functions in non-root, e.g.
setting bit 2 in the ENCLS_EXITING_BITMAP will cause ENCLS[EINIT]
to VMExit(ENCLS).

Note: EXIT_REASON_ENCLS was previously added by commit 1f5199927034
("KVM: VMX: add missing exit reasons").

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/include/asm/vmx.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 6aa8499e1f62..2665c10ece4c 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -74,6 +74,7 @@
 #define SECONDARY_EXEC_ENABLE_INVPCID		0x00001000
 #define SECONDARY_EXEC_ENABLE_VMFUNC            0x00002000
 #define SECONDARY_EXEC_SHADOW_VMCS              0x00004000
+#define SECONDARY_EXEC_ENCLS_EXITING		0x00008000
 #define SECONDARY_EXEC_RDSEED_EXITING		0x00010000
 #define SECONDARY_EXEC_ENABLE_PML               0x00020000
 #define SECONDARY_EXEC_XSAVES			0x00100000
@@ -213,6 +214,8 @@ enum vmcs_field {
 	VMWRITE_BITMAP_HIGH             = 0x00002029,
 	XSS_EXIT_BITMAP                 = 0x0000202C,
 	XSS_EXIT_BITMAP_HIGH            = 0x0000202D,
+	ENCLS_EXITING_BITMAP		= 0x0000202E,
+	ENCLS_EXITING_BITMAP_HIGH	= 0x0000202F,
 	TSC_MULTIPLIER                  = 0x00002032,
 	TSC_MULTIPLIER_HIGH             = 0x00002033,
 	GUEST_PHYSICAL_ADDRESS          = 0x00002400,
-- 
2.18.0


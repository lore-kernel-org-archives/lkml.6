Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF14FECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0402075B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B0402075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389327AbeGPIK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:10:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48184 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388522AbeGPIKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:10:24 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3DB5BCA5;
        Mon, 16 Jul 2018 07:44:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 18/43] x86/cpu: Provide a config option to disable static_cpu_has
Date:   Mon, 16 Jul 2018 09:36:23 +0200
Message-Id: <20180716073513.830018745@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073511.796555857@linuxfoundation.org>
References: <20180716073511.796555857@linuxfoundation.org>
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

From: Borislav Petkov <bp@suse.de>

commit 6e1315fe82308cd29e7550eab967262e8bbc71a3 upstream

This brings .text savings of about ~1.6K when building a tinyconfig. It
is off by default so nothing changes for the default.

Kconfig help text from Josh.

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
Link: http://lkml.kernel.org/r/1449481182-27541-5-git-send-email-bp@alien8.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/Kconfig                  |   11 +++++++++++
 arch/x86/include/asm/cpufeature.h |    2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -346,6 +346,17 @@ config X86_FEATURE_NAMES
 
 	  If in doubt, say Y.
 
+config X86_FAST_FEATURE_TESTS
+	bool "Fast CPU feature tests" if EMBEDDED
+	default y
+	---help---
+	  Some fast-paths in the kernel depend on the capabilities of the CPU.
+	  Say Y here for the kernel to patch in the appropriate code at runtime
+	  based on the capabilities of the CPU. The infrastructure for patching
+	  code at runtime takes up some additional space; space-constrained
+	  embedded systems may wish to say N here to produce smaller, slightly
+	  slower code.
+
 config X86_X2APIC
 	bool "Support x2apic"
 	depends on X86_LOCAL_APIC && X86_64 && (IRQ_REMAP || HYPERVISOR_GUEST)
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -422,7 +422,7 @@ extern const char * const x86_bug_flags[
  * fast paths and boot_cpu_has() otherwise!
  */
 
-#if __GNUC__ >= 4
+#if __GNUC__ >= 4 && defined(CONFIG_X86_FAST_FEATURE_TESTS)
 extern void warn_pre_alternatives(void);
 extern bool __static_cpu_has_safe(u16 bit);
 



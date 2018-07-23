Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8DFECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D4720856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D4720856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389626AbeGWNsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:48:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51470 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389592AbeGWNsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:48:04 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 538CDC83;
        Mon, 23 Jul 2018 12:46:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 091/107] x86/speculation: Rework speculative_store_bypass_update()
Date:   Mon, 23 Jul 2018 14:42:25 +0200
Message-Id: <20180723122418.050188313@linuxfoundation.org>
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

From: Thomas Gleixner <tglx@linutronix.de>

commit 0270be3e34efb05a88bc4c422572ece038ef3608 upstream

The upcoming support for the virtual SPEC_CTRL MSR on AMD needs to reuse
speculative_store_bypass_update() to avoid code duplication. Add an
argument for supplying a thread info (TIF) value and create a wrapper
speculative_store_bypass_update_current() which is used at the existing
call site.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/include/asm/spec-ctrl.h |    7 ++++++-
 arch/x86/kernel/cpu/bugs.c       |    2 +-
 arch/x86/kernel/process.c        |    4 ++--
 3 files changed, 9 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -42,6 +42,11 @@ extern void speculative_store_bypass_ht_
 static inline void speculative_store_bypass_ht_init(void) { }
 #endif
 
-extern void speculative_store_bypass_update(void);
+extern void speculative_store_bypass_update(unsigned long tif);
+
+static inline void speculative_store_bypass_update_current(void)
+{
+	speculative_store_bypass_update(current_thread_info()->flags);
+}
 
 #endif
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -596,7 +596,7 @@ static int ssb_prctl_set(struct task_str
 	 * mitigation until it is next scheduled.
 	 */
 	if (task == current && update)
-		speculative_store_bypass_update();
+		speculative_store_bypass_update_current();
 
 	return 0;
 }
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -334,10 +334,10 @@ static __always_inline void __speculativ
 		intel_set_ssb_state(tifn);
 }
 
-void speculative_store_bypass_update(void)
+void speculative_store_bypass_update(unsigned long tif)
 {
 	preempt_disable();
-	__speculative_store_bypass_update(current_thread_info()->flags);
+	__speculative_store_bypass_update(tif);
 	preempt_enable();
 }
 



Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A631C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13DE2087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:52:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F13DE2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbeI3EW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:22:28 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52037 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728758AbeI3ESf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:35 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N6E-0000H8-TO; Sat, 29 Sep 2018 22:48:31 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5w-0006s4-Ez; Sat, 29 Sep 2018 22:48:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Thomas Gleixner" <tglx@linutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        "David Woodhouse" <dwmw@amazon.co.uk>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.21431827@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 040/131] x86/speculation: Rework speculative_store_bypass_update()
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 0270be3e34efb05a88bc4c422572ece038ef3608 upstream.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/spec-ctrl.h | 7 ++++++-
 arch/x86/kernel/cpu/bugs.c       | 2 +-
 arch/x86/kernel/process.c        | 4 ++--
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
@@ -635,7 +635,7 @@ static int ssb_prctl_set(struct task_str
 	 * mitigation until it is next scheduled.
 	 */
 	if (task == current && update)
-		speculative_store_bypass_update();
+		speculative_store_bypass_update_current();
 
 	return 0;
 }
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -352,10 +352,10 @@ static __always_inline void __speculativ
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
 


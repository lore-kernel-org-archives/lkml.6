Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669F8C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3515920665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3515920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbeJXDH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:07:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:55078 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728817AbeJXDH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:07:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 11:43:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,417,1534834800"; 
   d="scan'208";a="243726564"
Received: from chang-linux-2.sc.intel.com ([10.3.52.139])
  by orsmga004.jf.intel.com with ESMTP; 23 Oct 2018 11:43:24 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [v3 01/12] taint: Introduce a new taint flag (insecure)
Date:   Tue, 23 Oct 2018 11:42:23 -0700
Message-Id: <20181023184234.14025-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181023184234.14025-1-chang.seok.bae@intel.com>
References: <20181023184234.14025-1-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For testing (or root-only) purposes, the new flag will serve to tag the
kernel taint accurately.

When adding a new feature support, patches need to be incrementally
applied and tested with temporal parameters. Currently, there is no flag
for this usage.

Suggested-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
---
 Documentation/sysctl/kernel.txt | 1 +
 include/linux/kernel.h          | 3 ++-
 kernel/panic.c                  | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/sysctl/kernel.txt b/Documentation/sysctl/kernel.txt
index 37a679501ddc..d682a6551365 100644
--- a/Documentation/sysctl/kernel.txt
+++ b/Documentation/sysctl/kernel.txt
@@ -1017,6 +1017,7 @@ ORed together. The letters are seen in "Tainted" line of Oops reports.
  32768 (K): The kernel has been live patched.
  65536 (X): Auxiliary taint, defined and used by for distros.
 131072 (T): The kernel was built with the struct randomization plugin.
+262144 (Z): The kernel is running in a known insecure configuration.
 
 ==============================================================
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d6aac75b51ba..38b2657d62d5 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -598,7 +598,8 @@ extern enum system_states {
 #define TAINT_LIVEPATCH			15
 #define TAINT_AUX			16
 #define TAINT_RANDSTRUCT		17
-#define TAINT_FLAGS_COUNT		18
+#define TAINT_INSECURE			18
+#define TAINT_FLAGS_COUNT		19
 
 struct taint_flag {
 	char c_true;	/* character printed when tainted */
diff --git a/kernel/panic.c b/kernel/panic.c
index 8b2e002d52eb..8db2ed9ec290 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -327,6 +327,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	[ TAINT_LIVEPATCH ]		= { 'K', ' ', true },
 	[ TAINT_AUX ]			= { 'X', ' ', true },
 	[ TAINT_RANDSTRUCT ]		= { 'T', ' ', true },
+	[ TAINT_INSECURE ]		= { 'Z', ' ', false },
 };
 
 /**
-- 
2.19.1


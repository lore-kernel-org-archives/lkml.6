Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A59C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD558218F0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbfBAUyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 15:54:37 -0500
Received: from mga18.intel.com ([134.134.136.126]:59549 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfBAUyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 15:54:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2019 12:54:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,549,1539673200"; 
   d="scan'208";a="140866323"
Received: from chang-linux-2.sc.intel.com ([10.3.52.165])
  by fmsmga004.fm.intel.com with ESMTP; 01 Feb 2019 12:54:36 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>
Cc:     Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 01/13] taint: Introduce a new taint flag (insecure)
Date:   Fri,  1 Feb 2019 12:53:06 -0800
Message-Id: <20190201205319.15995-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190201205319.15995-1-chang.seok.bae@intel.com>
References: <20190201205319.15995-1-chang.seok.bae@intel.com>
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
---
 Documentation/sysctl/kernel.txt | 1 +
 include/linux/kernel.h          | 3 ++-
 kernel/panic.c                  | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/sysctl/kernel.txt b/Documentation/sysctl/kernel.txt
index 379063e58326..fb4244515314 100644
--- a/Documentation/sysctl/kernel.txt
+++ b/Documentation/sysctl/kernel.txt
@@ -1064,6 +1064,7 @@ ORed together. The letters are seen in "Tainted" line of Oops reports.
  32768 (K): The kernel has been live patched.
  65536 (X): Auxiliary taint, defined and used by for distros.
 131072 (T): The kernel was built with the struct randomization plugin.
+262144 (Z): The kernel is running in a known insecure configuration.
 
 ==============================================================
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 8f0e68e250a7..dc149ff8cc52 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -599,7 +599,8 @@ extern enum system_states {
 #define TAINT_LIVEPATCH			15
 #define TAINT_AUX			16
 #define TAINT_RANDSTRUCT		17
-#define TAINT_FLAGS_COUNT		18
+#define TAINT_INSECURE			18
+#define TAINT_FLAGS_COUNT		19
 
 struct taint_flag {
 	char c_true;	/* character printed when tainted */
diff --git a/kernel/panic.c b/kernel/panic.c
index f121e6ba7e11..cb6b90538375 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -362,6 +362,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	[ TAINT_LIVEPATCH ]		= { 'K', ' ', true },
 	[ TAINT_AUX ]			= { 'X', ' ', true },
 	[ TAINT_RANDSTRUCT ]		= { 'T', ' ', true },
+	[ TAINT_INSECURE ]		= { 'Z', ' ', false },
 };
 
 /**
-- 
2.19.1


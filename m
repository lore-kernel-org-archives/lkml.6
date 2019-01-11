Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286B6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50002173B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbfAKCnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 21:43:14 -0500
Received: from mga03.intel.com ([134.134.136.65]:25646 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbfAKCnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 21:43:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2019 18:43:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,463,1539673200"; 
   d="scan'208";a="113837479"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jan 2019 18:43:12 -0800
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 10 Jan 2019 18:43:12 -0800
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 FMSMSX153.amr.corp.intel.com (10.18.125.6) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 10 Jan 2019 18:43:12 -0800
Received: from Mtest-h.sh.intel.com (10.239.127.40) by
 SHSMSX151.ccr.corp.intel.com (10.239.6.50) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 11 Jan 2019 10:43:09 +0800
From:   Haoyu Tang <haoyu.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
CC:     <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
        Nicolai Stange <nstange@suse.de>,
        "Haoyu Tang" <haoyu.tang@intel.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/fpu/init: Add __setup() functions back to fpu/init.c
Date:   Fri, 11 Jan 2019 10:45:53 +0800
Message-ID: <1547174753-31180-1-git-send-email-haoyu.tang@intel.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.239.127.40]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__setup() functions were removed in:

  commit 4f81cbafcce2 ("x86/fpu: Fix early FPU command-line parsing")

caused that FPU parameter is passed as an argument to init, the dummy
__setup() functions can avoid this.

Signed-off-by: Haoyu Tang <haoyu.tang@intel.com>
---
 arch/x86/kernel/fpu/init.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 6abd835..df325d0 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -301,3 +301,39 @@ void __init fpu__init_system(struct cpuinfo_x86 *c)
 
 	fpu__init_system_ctx_switch();
 }
+
+/* Although parse fpu parameters early before parse_early_param(),but
+ * __setup() is still mandatory in order not to pass fpu parameters
+ * into init as argument. At here, the interfaces don't need to set
+ * registers again, they are only used to indicate parse_args() that
+ * the parameter has been consumed.
+ */
+static int __init no_387(char *s)
+{
+	return 1;
+}
+__setup("no387", no_387);
+
+static int __init x86_noxsave_setup(char *s)
+{
+	return 1;
+}
+__setup("noxsave", x86_noxsave_setup);
+
+static int __init x86_noxsaveopt_setup(char *s)
+{
+	return 1;
+}
+__setup("noxsaveopt", x86_noxsaveopt_setup);
+
+static int __init x86_noxsaves_setup(char *s)
+{
+	return 1;
+}
+__setup("noxsaves", x86_noxsaves_setup);
+
+static int __init x86_nofxsr_setup(char *s)
+{
+	return 1;
+}
+__setup("nofxsr", x86_nofxsr_setup);
-- 
1.9.1


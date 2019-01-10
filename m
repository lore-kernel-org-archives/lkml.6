Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DB2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B192F20685
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbfAJPgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:36:54 -0500
Received: from mga07.intel.com ([134.134.136.100]:61408 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727753AbfAJPgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:36:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2019 07:36:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,461,1539673200"; 
   d="scan'208";a="105594419"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 10 Jan 2019 07:36:51 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 597C3E3; Thu, 10 Jan 2019 17:36:50 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] x86/mce: Switch to use new generic UUID API
Date:   Thu, 10 Jan 2019 17:36:45 +0200
Message-Id: <20190110153645.40649-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are new types and helpers that are supposed to be used in new code.

As a preparation to get rid of legacy types and API functions do
the conversion here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/cpu/mce/apei.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 1d9b3ce662a0..c038e5c00a59 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -64,11 +64,11 @@ void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 EXPORT_SYMBOL_GPL(apei_mce_report_mem_error);
 
 #define CPER_CREATOR_MCE						\
-	UUID_LE(0x75a574e3, 0x5052, 0x4b29, 0x8a, 0x8e, 0xbe, 0x2c,	\
-		0x64, 0x90, 0xb8, 0x9d)
+	GUID_INIT(0x75a574e3, 0x5052, 0x4b29, 0x8a, 0x8e, 0xbe, 0x2c,	\
+		  0x64, 0x90, 0xb8, 0x9d)
 #define CPER_SECTION_TYPE_MCE						\
-	UUID_LE(0xfe08ffbe, 0x95e4, 0x4be7, 0xbc, 0x73, 0x40, 0x96,	\
-		0x04, 0x4a, 0x38, 0xfc)
+	GUID_INIT(0xfe08ffbe, 0x95e4, 0x4be7, 0xbc, 0x73, 0x40, 0x96,	\
+		  0x04, 0x4a, 0x38, 0xfc)
 
 /*
  * CPER specification (in UEFI specification 2.3 appendix N) requires
@@ -135,7 +135,7 @@ ssize_t apei_read_mce(struct mce *m, u64 *record_id)
 		goto out;
 	/* try to skip other type records in storage */
 	else if (rc != sizeof(rcd) ||
-		 uuid_le_cmp(rcd.hdr.creator_id, CPER_CREATOR_MCE))
+		 !guid_equal(&rcd.hdr.creator_id, &CPER_CREATOR_MCE))
 		goto retry;
 	memcpy(m, &rcd.mce, sizeof(*m));
 	rc = sizeof(*m);
-- 
2.20.1


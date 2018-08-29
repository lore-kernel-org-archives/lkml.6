Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D01DC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003EA205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003EA205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbeH2VQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 17:16:31 -0400
Received: from mga18.intel.com ([134.134.136.126]:6998 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727428AbeH2VQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 17:16:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 10:18:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,303,1531810800"; 
   d="scan'208";a="68826401"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga007.jf.intel.com with ESMTP; 29 Aug 2018 10:18:36 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 7D910301BA8; Wed, 29 Aug 2018 10:18:36 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 02/10] tools, pager: Support overwriting the pager
Date:   Wed, 29 Aug 2018 10:18:26 -0700
Message-Id: <20180829171834.6590-3-andi@firstfloor.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829171834.6590-1-andi@firstfloor.org>
References: <20180829171834.6590-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Add an interface to the auto pager code that allows callers
to overwrite the pager.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/lib/subcmd/pager.c | 11 ++++++++++-
 tools/lib/subcmd/pager.h |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/lib/subcmd/pager.c b/tools/lib/subcmd/pager.c
index 9997a8805a82..e3d47b59b14d 100644
--- a/tools/lib/subcmd/pager.c
+++ b/tools/lib/subcmd/pager.c
@@ -23,6 +23,13 @@ void pager_init(const char *pager_env)
 	subcmd_config.pager_env = pager_env;
 }
 
+static const char *forced_pager;
+
+void force_pager(const char *pager)
+{
+	forced_pager = pager;
+}
+
 static void pager_preexec(void)
 {
 	/*
@@ -66,7 +73,9 @@ void setup_pager(void)
 	const char *pager = getenv(subcmd_config.pager_env);
 	struct winsize sz;
 
-	if (!isatty(1))
+	if (forced_pager)
+		pager = forced_pager;
+	if (!isatty(1) && !forced_pager)
 		return;
 	if (ioctl(1, TIOCGWINSZ, &sz) == 0)
 		pager_columns = sz.ws_col;
diff --git a/tools/lib/subcmd/pager.h b/tools/lib/subcmd/pager.h
index f1a53cf29880..a818964693ab 100644
--- a/tools/lib/subcmd/pager.h
+++ b/tools/lib/subcmd/pager.h
@@ -7,5 +7,6 @@ extern void pager_init(const char *pager_env);
 extern void setup_pager(void);
 extern int pager_in_use(void);
 extern int pager_get_columns(void);
+extern void force_pager(const char *);
 
 #endif /* __SUBCMD_PAGER_H */
-- 
2.17.1


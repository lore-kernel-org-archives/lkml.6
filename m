Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38614C04AB8
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 03:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE94F20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 03:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE94F20853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbeINIXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 04:23:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:27569 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbeINIXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 04:23:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2018 20:11:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,371,1531810800"; 
   d="scan'208";a="88646457"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga004.fm.intel.com with ESMTP; 13 Sep 2018 20:11:13 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 8CA59301A7E; Thu, 13 Sep 2018 20:11:13 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, kim.phillips@arm.com,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v4 2/8] tools, pager: Support overwriting the pager
Date:   Thu, 13 Sep 2018 20:10:32 -0700
Message-Id: <20180914031038.4160-3-andi@firstfloor.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180914031038.4160-1-andi@firstfloor.org>
References: <20180914031038.4160-1-andi@firstfloor.org>
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


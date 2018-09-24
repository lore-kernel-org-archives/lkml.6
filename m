Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A44DECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E52D214C1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvGUbiG4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E52D214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbeIXVF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:05:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730013AbeIXVF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:05:58 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3502A2087A;
        Mon, 24 Sep 2018 15:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537801403;
        bh=VV/G6+gZzOMOLp/+hf1zLWxESfvpI98h4bpIwn8g7jQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IvGUbiG4KbLzHSc5CvsESx3oGWIcFfnLyWm7jK/Fpj/YgQDE0IbVzu5eANRLraOu5
         ePAkqd9vEOFSJvv1idgxTKezRLAsViuWYkoNNXQ4CBoHiAdUtcCbhLHaFfxYRNBs80
         YJa9RH277mCb1pJnasxV45Aztt166W9TE3iwnxxw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/27] tools lib subcmd: Support overwriting the pager
Date:   Mon, 24 Sep 2018 12:02:18 -0300
Message-Id: <20180924150242.14235-4-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180924150242.14235-1-acme@kernel.org>
References: <20180924150242.14235-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Add an interface to the auto pager code that allows callers to overwrite
the pager.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20180918123214.26728-3-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.14.4


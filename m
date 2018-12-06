Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F500C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7432146F
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131843;
	bh=Lkz8snIB1byeiNcOE3w3UbpJFPl6yjhL6R9zal/ETHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uijrQQIW6dqZizctQDD9dq5QTo0f8S/dFFu+Be32VP1BaGUI/83sC1uDnYqb1A2aj
	 kNOZmGRt9ZO36GGNoUgGfcjExOqcE5fOERQt7zigR8NmSZBOIjcP4H37YAfVq0v7d0
	 GSGnfTHY+e+m/soHzAi+2BKxLrR71gxUUU3VX6gU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F7432146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbeLFVam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:30:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:49038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbeLFVai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:30:38 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D208F20989;
        Thu,  6 Dec 2018 21:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131838;
        bh=Lkz8snIB1byeiNcOE3w3UbpJFPl6yjhL6R9zal/ETHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EoTmEdsn4ZoM4kIJJStBE+aNtAtRKqyfwzWzxJdtFmiXlKePf9VIH+lHhoZszPxUJ
         rWSZDjQBkQAs5z8h7jNQEJgjH9xPzbzqs2ausJ8ZjKb4QDAK3mKJ6WK9oZK2XJCmNu
         sJCsK5HQJAzTQ3/uqu6vujeS6KxOes3nUG9m7AJM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 63/75] perf help: Remove needless use of strncpy()
Date:   Thu,  6 Dec 2018 18:25:50 -0300
Message-Id: <20181206212602.20474-64-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since we make sure the destination buffer has at least strlen(orig) + 1,
no need to do a strncpy(dest, orig, strlen(orig)), just use strcpy(dest,
orig).

This silences this gcc 8.2 warning on Alpine Linux:

  In function 'add_man_viewer',
      inlined from 'perf_help_config' at builtin-help.c:284:3:
  builtin-help.c:192:2: error: 'strncpy' output truncated before terminating nul copying as many bytes from a string as its length [-Werror=stringop-truncation]
    strncpy((*p)->name, name, len);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  builtin-help.c: In function 'perf_help_config':
  builtin-help.c:187:15: note: length computed here
    size_t len = strlen(name);
                 ^~~~~~~~~~~~

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: 078006012401 ("perf_counter tools: add in basic glue from Git")
Link: https://lkml.kernel.org/n/tip-2f69l7drca427ob4km8i7kvo@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-help.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
index 1c41b4eaf73c..3d29d0524a89 100644
--- a/tools/perf/builtin-help.c
+++ b/tools/perf/builtin-help.c
@@ -189,7 +189,7 @@ static void add_man_viewer(const char *name)
 	while (*p)
 		p = &((*p)->next);
 	*p = zalloc(sizeof(**p) + len + 1);
-	strncpy((*p)->name, name, len);
+	strcpy((*p)->name, name);
 }
 
 static int supported_man_viewer(const char *name, size_t len)
-- 
2.19.2


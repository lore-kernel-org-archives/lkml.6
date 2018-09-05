Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20457C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1D820839
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMIluB15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1D820839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbeIFCki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:40:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727843AbeIFCkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:40:37 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 884ED20857;
        Wed,  5 Sep 2018 22:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185305;
        bh=R0qb7C5Q0QhTb7x2qFEfiSDr3/izImxVhoM1pkP/xCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WMIluB15V6AFN3+hsOpGKUKki9VgnBU7Z3eGgNlC0RIgzNLg5NnfG9kQ+GkUV6mAR
         omJg6XwA9bBSmkUcArI6czV5Chdc80nZPJHHlDVclowPplFORiiLJHwSjqyQW+tLME
         /poczK6Y3scmW7liOatFZD69s6ookl3/LC8UMuNc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 76/77] perf map: Turn some pr_warning() to pr_debug()
Date:   Wed,  5 Sep 2018 19:04:39 -0300
Message-Id: <20180905220440.20256-77-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Annoying when using it with --stdio/--stdio2, so just turn them debug,
we can get those using -v.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-t3684lkugnf1w4lwcmpj9ivm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 36d0763311ef..3f07a587c8e6 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -320,12 +320,11 @@ int map__load(struct map *map)
 			build_id__sprintf(map->dso->build_id,
 					  sizeof(map->dso->build_id),
 					  sbuild_id);
-			pr_warning("%s with build id %s not found",
-				   name, sbuild_id);
+			pr_debug("%s with build id %s not found", name, sbuild_id);
 		} else
-			pr_warning("Failed to open %s", name);
+			pr_debug("Failed to open %s", name);
 
-		pr_warning(", continuing without symbols\n");
+		pr_debug(", continuing without symbols\n");
 		return -1;
 	} else if (nr == 0) {
 #ifdef HAVE_LIBELF_SUPPORT
@@ -334,12 +333,11 @@ int map__load(struct map *map)
 
 		if (len > sizeof(DSO__DELETED) &&
 		    strcmp(name + real_len + 1, DSO__DELETED) == 0) {
-			pr_warning("%.*s was updated (is prelink enabled?). "
+			pr_debug("%.*s was updated (is prelink enabled?). "
 				"Restart the long running apps that use it!\n",
 				   (int)real_len, name);
 		} else {
-			pr_warning("no symbols found in %s, maybe install "
-				   "a debug package?\n", name);
+			pr_debug("no symbols found in %s, maybe install a debug package?\n", name);
 		}
 #endif
 		return -1;
@@ -701,8 +699,7 @@ static int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp
 		if (verbose >= 2) {
 
 			if (use_browser) {
-				pr_warning("overlapping maps in %s "
-					   "(disable tui for more info)\n",
+				pr_debug("overlapping maps in %s (disable tui for more info)\n",
 					   map->dso->name);
 			} else {
 				fputs("overlapping maps:\n", fp);
-- 
2.14.4


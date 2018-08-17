Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106DCC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DD7218AA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3DD7218AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbeHQMvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:51:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37592 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725845AbeHQMvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:51:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 757BA401C96B;
        Fri, 17 Aug 2018 09:48:19 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 08813175BC;
        Fri, 17 Aug 2018 09:48:17 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 02/13] perf tools: Get rid of dso__needs_decompress call in symbol__disassemble
Date:   Fri, 17 Aug 2018 11:48:02 +0200
Message-Id: <20180817094813.15086-3-jolsa@kernel.org>
In-Reply-To: <20180817094813.15086-1-jolsa@kernel.org>
References: <20180817094813.15086-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 17 Aug 2018 09:48:19 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 17 Aug 2018 09:48:19 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to call dso__needs_decompress twice
in the function.

Link: http://lkml.kernel.org/n/tip-4lygwpnkdyed2rtiof4blint@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/annotate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e4268b948e0e..20061cf42288 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1629,6 +1629,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	char symfs_filename[PATH_MAX];
 	struct kcore_extract kce;
 	bool delete_extract = false;
+	bool decomp = false;
 	int stdout_fd[2];
 	int lineno = 0;
 	int nline;
@@ -1662,6 +1663,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 						 tmp, sizeof(tmp)) < 0)
 			goto out;
 
+		decomp = true;
 		strcpy(symfs_filename, tmp);
 	}
 
@@ -1748,7 +1750,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 out_remove_tmp:
 	close(stdout_fd[0]);
 
-	if (dso__needs_decompress(dso))
+	if (decomp)
 		unlink(symfs_filename);
 
 	if (delete_extract)
-- 
2.17.1


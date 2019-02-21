Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BED1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE08820880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550742123;
	bh=+o5NzInpq9YoLDChBUmyGZdOIg1BZViWAQCr4odQ/bU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=acqaSL8S9YW7aMhVE9ARm+3Jz11HKXFIMYuLijyf1E0X1EGK1YM3cKCazZivPKpzX
	 k9fF+UCf5iHed3PTSwHoety34HExbfrTkR1EO6rO2BrEpYTrshLPZjavafECrzmDHG
	 NSj5yyTPZJvlr5ATdEvDX4njTnJPQsfPdE11dYBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfBUJmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:42:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44458 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727440AbfBUJl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:41:58 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1F13230024A0;
        Thu, 21 Feb 2019 09:41:58 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E749560BE6;
        Thu, 21 Feb 2019 09:41:55 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 04/17] perf data: Fail check_backup in case of error
Date:   Thu, 21 Feb 2019 10:41:32 +0100
Message-Id: <20190221094145.9151-5-jolsa@kernel.org>
In-Reply-To: <20190221094145.9151-1-jolsa@kernel.org>
References: <20190221094145.9151-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 21 Feb 2019 09:41:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And display the error message from removing
the old data file:

  $ perf record ls
  Can't remove old data: Permission denied (perf.data.old)
  Perf session creation failed.

Not sure how to make fail the rename (after we successfully
remove the destination file/dir) to show the message,
anyway let's have it there.

Link: http://lkml.kernel.org/n/tip-6k0tikvlyugms7xxqs794jxz@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/data.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 0a3051cc0ea0..18e5d94b0e97 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -41,12 +41,24 @@ static int check_backup(struct perf_data *data)
 		return 0;
 
 	if (!stat(data->path, &st) && st.st_size) {
-		/* TODO check errors properly */
 		char oldname[PATH_MAX];
+
 		snprintf(oldname, sizeof(oldname), "%s.old",
 			 data->path);
-		rm_rf(oldname);
-		rename(data->path, oldname);
+
+		if (rm_rf(oldname)) {
+			pr_err("Can't remove old data: %s (%s)\n",
+			       strerror(errno), oldname);
+
+			return -1;
+		}
+
+		if (rename(data->path, oldname)) {
+			pr_err("Can't move data: %s (%s to %s)\n",
+			       strerror(errno),
+			       data->path, oldname);
+			return -1;
+		}
 	}
 
 	return 0;
-- 
2.17.2


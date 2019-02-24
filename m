Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07E3C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90EC1206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551035253;
	bh=nP9GP+JeDQTKjAjfFzPvE/81qNJJh/PiBWGJFeNEPAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T8iiaVpxL43t56KlOXYS80EorFZ39703M01I9N7VrukK3fuzuHxZ2WthCk3guFC7z
	 t/G6zunvJEp/ImHU1vN2Y6BR0jAXO3+KG6uzWXKtvDa+qJ4aOGlnG+NyBpNuPdQY8A
	 gCCIhtgaRmWoziY1maqgS1+eQEQtAIVx7DbeH/J0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbfBXTHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 14:07:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38042 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728376AbfBXTHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 14:07:24 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1AA07309587B;
        Sun, 24 Feb 2019 19:07:24 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-38.brq.redhat.com [10.40.204.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6683B6013A;
        Sun, 24 Feb 2019 19:07:21 +0000 (UTC)
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
Subject: [PATCH 07/20] perf data: Fail check_backup in case of error
Date:   Sun, 24 Feb 2019 20:06:43 +0100
Message-Id: <20190224190656.30163-8-jolsa@kernel.org>
In-Reply-To: <20190224190656.30163-1-jolsa@kernel.org>
References: <20190224190656.30163-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Sun, 24 Feb 2019 19:07:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And display the error message from removing
the old data file:

  $ perf record ls
  Can't remove old data: Permission denied (perf.data.old)
  Perf session creation failed.

  $ perf record ls
  Can't remove old data: Unknown file found (perf.data.old)
  Perf session creation failed.

Not sure how to make fail the rename (after we successfully
remove the destination file/dir) to show the message,
anyway let's have it there.

Link: http://lkml.kernel.org/n/tip-6k0tikvlyugms7xxqs794jxz@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/data.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index bbf9a299615e..d008c3973012 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -41,12 +41,27 @@ static int check_backup(struct perf_data *data)
 		return 0;
 
 	if (!stat(data->path, &st) && st.st_size) {
-		/* TODO check errors properly */
 		char oldname[PATH_MAX];
+		int ret;
+
 		snprintf(oldname, sizeof(oldname), "%s.old",
 			 data->path);
-		rm_rf_perf_data(oldname);
-		rename(data->path, oldname);
+
+		ret = rm_rf_perf_data(oldname);
+		if (ret) {
+			pr_err("Can't remove old data: %s (%s)\n",
+			       ret == -2 ?
+			       "Unknown file found" : strerror(errno),
+			       oldname);
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


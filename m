Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3164C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8008F21873
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129740;
	bh=i6cQx0kwLtjvLhLOE5LS1rVIrpzoiuSrIGwK41w4ogg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BXAaUzEM1KA82m6hphSpIhVxwbWt03CRSoaxJ7H/xdiqg+RDLBxhC7aCEdj1lYccv
	 A/q/Zbs0admcj8sxHX33ViQtAy76xc+9aOSbq6AaxgjgZ/cmfcQuN+UYzSKMu27QUJ
	 qUfja2pGphfmCq14OEr6b5CTInIJ/QoiTptJSJyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbfBYVWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:22:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:56336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729748AbfBYVWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:22:15 -0500
Received: from quaco.ghostprotocols.net (179-240-165-120.3g.claro.net.br [179.240.165.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A784921841;
        Mon, 25 Feb 2019 21:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129734;
        bh=i6cQx0kwLtjvLhLOE5LS1rVIrpzoiuSrIGwK41w4ogg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l/cwQBx7ifxlc/P27SEbb91r8AWjy6k4fCg0sgTG4C14X2UIwSsznFzCbSPWTFTji
         mLSeS78nHNRm50IBFwrnGl48S+b60kXvwPiFofcNicFE3bSIopFitHqW7ofPc9hSVT
         L4k8tFC+4Ev8ne720ZwhiaKv9TSKPYIADIwNIDYA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 23/37] perf data: Fail check_backup in case of error
Date:   Mon, 25 Feb 2019 18:20:21 -0300
Message-Id: <20190225212035.24781-24-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225212035.24781-1-acme@kernel.org>
References: <20190225212035.24781-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

And display the error message from removing the old data file:

  $ perf record ls
  Can't remove old data: Permission denied (perf.data.old)
  Perf session creation failed.

  $ perf record ls
  Can't remove old data: Unknown file found (perf.data.old)
  Perf session creation failed.

Not sure how to make fail the rename (after we successfully remove the
destination file/dir) to show the message, anyway let's have it there.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190224190656.30163-8-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.20.1


Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54CCC282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 15:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D6F20823
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 15:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549207829;
	bh=VxSnbSVTddb1kFWFQrzX6qN+TP4r0nsg2iJeWP/g4gI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t8acTsPVaQoA/b8AkEAWUGns+lcGaIxjY5r9fmEw0w1TBrrh1Im453s/JcrE4A4w5
	 YDaZfN5Nxl1K4TVpmryp6Ug7iIR1egV8w5kBOLkfXKVcWYhLDPIMe/yI9sBZQWwzAR
	 NgcuTIGTKFcvGGr94KbgUpfRHEW8ZhmuMk/WAe7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbfBCPa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 10:30:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfBCPaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 10:30:25 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 87B11C057F33;
        Sun,  3 Feb 2019 15:30:25 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-46.brq.redhat.com [10.40.204.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CEAE55C238;
        Sun,  3 Feb 2019 15:30:22 +0000 (UTC)
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
Subject: [PATCH 01/14] perf tools: Make rm_rf to remove single file
Date:   Sun,  3 Feb 2019 16:30:05 +0100
Message-Id: <20190203153018.9650-2-jolsa@kernel.org>
In-Reply-To: <20190203153018.9650-1-jolsa@kernel.org>
References: <20190203153018.9650-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Sun, 03 Feb 2019 15:30:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let rm_rf remove file if it's provided by path.

Link: http://lkml.kernel.org/n/tip-whhp3ej5795l9dc86xfyyp74@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/util.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 320b0fef249a..58b8d6a8bfbc 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -125,8 +125,14 @@ int rm_rf(const char *path)
 	char namebuf[PATH_MAX];
 
 	dir = opendir(path);
-	if (dir == NULL)
-		return 0;
+	if (dir == NULL) {
+		/*
+		 * The path does not exist or is not directory,
+		 * so there's no harm to try remove it. This way
+		 * rm_rf will work over single file.
+		 */
+		return unlink(path);
+	}
 
 	while ((d = readdir(dir)) != NULL && !ret) {
 		struct stat statbuf;
-- 
2.17.2


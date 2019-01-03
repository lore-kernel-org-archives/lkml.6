Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C05C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10A02070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546519612;
	bh=doxcHUHx/OLYg4CLe8Ludx4eJT3an1LV4qqTtHB4sxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2E+U179sK9MDMQkIrRHqcwsHpZc+jd9CJl4l7WI3uzkK0bcr4aNOc0qliwhjPYY7I
	 uA3VooQIA845gjyZf5mIHfD49aTJFjdMGl0ac6wkN2sHZg350jdJqi8LjsJH2IvX/K
	 t/mqw0RA2HOQvBWlKGcyaXiAo/LBNe6EWEcRfyr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731459AbfACMqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:46:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:42194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731149AbfACMqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:46:50 -0500
Received: from quaco.ghostprotocols.net (unknown [187.65.17.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 927EB2070D;
        Thu,  3 Jan 2019 12:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546519610;
        bh=doxcHUHx/OLYg4CLe8Ludx4eJT3an1LV4qqTtHB4sxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ylxPhr/cs2Xhb2AJJIiGFcExb40uLPFv1wa1tJP8DlTzy4++BjXpGOuDo2hlEGS8I
         S08NE34VUpzqsCV6QbCh2dECzQnDKxhvfS6WXcqtcYvpF9B5sWoq/1MXSRBE0P4HP6
         7llzXaCOvQweeQ0fFHLDHqPboIF4N6vKHXQRKgjo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 10/29] perf trace: Store the major number for a file when storing its pathname
Date:   Thu,  3 Jan 2019 09:45:50 -0300
Message-Id: <20190103124609.29672-11-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190103124609.29672-1-acme@kernel.org>
References: <20190103124609.29672-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We keep a table for the fds to map them back to pathnames when showing
'fd' based APIs such as write(), store as well the major number for the
device the path is in, to use in things like choosing the right ioctl
'cmd' beautifier.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-qjkds7bnk7v7fk2xhqsb0a4v@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 41ab524e128b..4b03f66b1735 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -60,6 +60,7 @@
 #include <linux/stringify.h>
 #include <linux/time64.h>
 #include <fcntl.h>
+#include <sys/sysmacros.h>
 
 #include "sane_ctype.h"
 
@@ -959,6 +960,7 @@ static size_t fprintf_duration(unsigned long t, bool calculated, FILE *fp)
 
 struct file {
 	char *pathname;
+	int  dev_maj;
 };
 
 /**
@@ -1068,6 +1070,9 @@ static int trace__set_fd_pathname(struct thread *thread, int fd, const char *pat
 	struct file *file = thread_trace__files_entry(ttrace, fd);
 
 	if (file != NULL) {
+		struct stat st;
+		if (stat(pathname, &st) == 0)
+			file->dev_maj = major(st.st_rdev);
 		file->pathname = strdup(pathname);
 		if (file->pathname)
 			return 0;
-- 
2.19.2


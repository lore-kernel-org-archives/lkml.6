Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C892AC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9497A21872
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546519609;
	bh=sO53KXOCqt7IbRspst/ge6bIlloY7nVb1Lx6etqdOZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DE6iTnoh/xxj+bCFXl8Nhjs5kwY/ZVnwryrFSbfTGuOmvLgxJWR9T8sab5HUKsIzb
	 cd2NrwiY0+a+yxX84D2UlFdAqArMnZQs/aUsXIs0fyWM4qx1JaR7uQYNCtfttOD1le
	 mL2RboKi9Wd8Kq6FH7K2W/VQ4Qs1yp8cCOHPhzuA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731446AbfACMqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:46:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:42120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731149AbfACMqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:46:47 -0500
Received: from quaco.ghostprotocols.net (unknown [187.65.17.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C1622184B;
        Thu,  3 Jan 2019 12:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546519607;
        bh=sO53KXOCqt7IbRspst/ge6bIlloY7nVb1Lx6etqdOZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UYPkCk43+L1TxCyxczJONVzhGdUHIkFg+6UxW41cqRdF/iCS24mq3nhmNbTaNWXfV
         v/XdlX4ZgScL1/n9QSsmN0aGk0hCKfb9pP9X0uwfW6Iq3UD5RYmoEPNAzQZR5LAzHH
         +n8qQqboWAhWyf+Mc1ulaG1IUYXQqEUfVtzrxHMA=
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
Subject: [PATCH 09/29] perf trace: Move the files table resizing to outside set_pathname()
Date:   Thu,  3 Jan 2019 09:45:49 -0300
Message-Id: <20190103124609.29672-10-acme@kernel.org>
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

So that we can have that table expanded when setting other attributes.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-hzvpe3qwafe6sqcq3bhtbxds@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d4bca74f282c..41ab524e128b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1040,15 +1040,13 @@ void syscall_arg__set_ret_scnprintf(struct syscall_arg *arg,
 
 static const size_t trace__entry_str_size = 2048;
 
-static int trace__set_fd_pathname(struct thread *thread, int fd, const char *pathname)
+static struct file *thread_trace__files_entry(struct thread_trace *ttrace, int fd)
 {
-	struct thread_trace *ttrace = thread__priv(thread);
-
 	if (fd > ttrace->files.max) {
 		struct file *nfiles = realloc(ttrace->files.table, (fd + 1) * sizeof(struct file));
 
 		if (nfiles == NULL)
-			return -1;
+			return NULL;
 
 		if (ttrace->files.max != -1) {
 			memset(nfiles + ttrace->files.max + 1, 0,
@@ -1061,9 +1059,21 @@ static int trace__set_fd_pathname(struct thread *thread, int fd, const char *pat
 		ttrace->files.max   = fd;
 	}
 
-	ttrace->files.table[fd].pathname = strdup(pathname);
+	return ttrace->files.table + fd;
+}
+
+static int trace__set_fd_pathname(struct thread *thread, int fd, const char *pathname)
+{
+	struct thread_trace *ttrace = thread__priv(thread);
+	struct file *file = thread_trace__files_entry(ttrace, fd);
+
+	if (file != NULL) {
+		file->pathname = strdup(pathname);
+		if (file->pathname)
+			return 0;
+	}
 
-	return ttrace->files.table[fd].pathname != NULL ? 0 : -1;
+	return -1;
 }
 
 static int thread__read_fd_path(struct thread *thread, int fd)
-- 
2.19.2


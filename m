Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF9AC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5541F21871
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546519625;
	bh=zWklHsiSbuItPxw8ZMhjQ+bM7MXMl2Yq1H0g3iIymZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QnqlNT9xR9oIwc/2F+irkri+5SJNTVrm4aeu20E5EgyFh47nc3sSwGwdcrTDopIw8
	 oFwCz3c/u/a9A63CFf7Wb1CQXtf1QXoPvW7hXS+4OzDiaF+7bJIqROzjgMofbHscfT
	 TEoSpsXwxBaVMq72H4W1RNclkdb+2Wy047RBhnRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbfACMrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:47:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:42402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730156AbfACMrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:47:03 -0500
Received: from quaco.ghostprotocols.net (unknown [187.65.17.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C8F92070D;
        Thu,  3 Jan 2019 12:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546519622;
        bh=zWklHsiSbuItPxw8ZMhjQ+bM7MXMl2Yq1H0g3iIymZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0QKSfOkzCL3ttJXYMqo9L3dsNiMEN6NS/Ih5eOlgfRXCfj+hRzm9k1/fRKAt3HdfL
         e5ImWWp//3yc+7d9Q+K88vNjEYR13gcgly7dPD7jJL0SrSslJo54fHL5u1fbHD8moU
         tWz8sCVQ8QkgZQgiBzqiZtqziv6ak2X8DmQg2px8=
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
Subject: [PATCH 14/29] perf trace beauty: Export function to get the files for a thread
Date:   Thu,  3 Jan 2019 09:45:54 -0300
Message-Id: <20190103124609.29672-15-acme@kernel.org>
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

So that beautifiers can access things like dev_maj.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-wm5o51f206c5pi063dsaeraq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       | 10 +++++-----
 tools/perf/trace/beauty/beauty.h |  7 +++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 4b03f66b1735..adbf28183560 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -958,11 +958,6 @@ static size_t fprintf_duration(unsigned long t, bool calculated, FILE *fp)
 	return printed + fprintf(fp, "): ");
 }
 
-struct file {
-	char *pathname;
-	int  dev_maj;
-};
-
 /**
  * filename.ptr: The filename char pointer that will be vfs_getname'd
  * filename.entry_str_pos: Where to insert the string translated from
@@ -1064,6 +1059,11 @@ static struct file *thread_trace__files_entry(struct thread_trace *ttrace, int f
 	return ttrace->files.table + fd;
 }
 
+struct file *thread__files_entry(struct thread *thread, int fd)
+{
+	return thread_trace__files_entry(thread__priv(thread), fd);
+}
+
 static int trace__set_fd_pathname(struct thread *thread, int fd, const char *pathname)
 {
 	struct thread_trace *ttrace = thread__priv(thread);
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 83c5b202e00e..139d485a6f16 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -32,6 +32,13 @@ size_t strarray__scnprintf_flags(struct strarray *sa, char *bf, size_t size, boo
 struct trace;
 struct thread;
 
+struct file {
+	char *pathname;
+	int  dev_maj;
+};
+
+struct file *thread__files_entry(struct thread *thread, int fd);
+
 struct strarrays {
 	int		nr_entries;
 	struct strarray **entries;
-- 
2.19.2


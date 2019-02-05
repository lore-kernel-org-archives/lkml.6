Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA6AC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EEDB217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549379271;
	bh=evhiwF7G831q1qfEykmLt8OlQ3oAc/SqkpptjGQf2H4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kOh8vVTA5pct3bPOL0WjkI9S+sWEYAHaf6eumRowIKrl+VLHfaYspJkQ90pGYUKsg
	 5K4+1Jcm91SBZablikWb4DElpCb+h760LvIxkO/6n0+RaUVFfYsC+2recqd6rXkz0a
	 Ag+qygiwN87a3oKpUqPTb7aPLYUL1rK1ZmRA90bA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbfBEPHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:07:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:42518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729731AbfBEPHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:07:41 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4665B21852;
        Tue,  5 Feb 2019 15:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549379260;
        bh=evhiwF7G831q1qfEykmLt8OlQ3oAc/SqkpptjGQf2H4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dz7VeCEolXylWEZBA1eXvsTULzyQcoC+K5JpbHEb+dUt3QA08foTO0e40/D3urcVa
         Zp1iFRLZPo6Spk0ihTgFrOEk0F1NZbZvPtKV7bIqTFJvDpuu/HWE57a+4otq/lkdcg
         L+xwPoWz8NHFpsEgTOeayLg4Waq4bwLU/CMKrA7I=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 7/8] perf trace: Support multiple "vfs_getname" probes
Date:   Tue,  5 Feb 2019 12:07:07 -0300
Message-Id: <20190205150708.9012-8-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205150708.9012-1-acme@kernel.org>
References: <20190205150708.9012-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

With a suitably defined "probe:vfs_getname" probe, 'perf trace' can
"beautify" its output, so syscalls like open() or openat() can print the
"filename" argument instead of just its hex address, like:

  $ perf trace -e open -- touch /dev/null
  [...]
       0.590 ( 0.014 ms): touch/18063 open(filename: /dev/null, flags: CREAT|NOCTTY|NONBLOCK|WRONLY, mode: IRUGO|IWUGO) = 3
  [...]

The output without such beautifier looks like:

     0.529 ( 0.011 ms): touch/18075 open(filename: 0xc78cf288, flags: CREAT|NOCTTY|NONBLOCK|WRONLY, mode: IRUGO|IWUGO) = 3

However, when the vfs_getname probe expands to multiple probes and it is
not the first one that is hit, the beautifier fails, as following:

     0.326 ( 0.010 ms): touch/18072 open(filename: , flags: CREAT|NOCTTY|NONBLOCK|WRONLY, mode: IRUGO|IWUGO) = 3

Fix it by hooking into all the expanded probes (inlines), now, for instance:

  [root@quaco ~]# perf probe -l
    probe:vfs_getname    (on getname_flags:73@fs/namei.c with pathname)
    probe:vfs_getname_1  (on getname_flags:73@fs/namei.c with pathname)
  [root@quaco ~]# perf trace -e open* sleep 1
       0.010 ( 0.005 ms): sleep/5588 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: RDONLY|CLOEXEC)   = 3
       0.029 ( 0.006 ms): sleep/5588 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: RDONLY|CLOEXEC)   = 3
       0.194 ( 0.008 ms): sleep/5588 openat(dfd: CWD, filename: /usr/lib/locale/locale-archive, flags: RDONLY|CLOEXEC) = 3
  [root@quaco ~]#

Works, further verified with:

  [root@quaco ~]# perf test vfs
  65: Use vfs_getname probe to get syscall args filenames   : Ok
  66: Add vfs_getname probe to get syscall args filenames   : Ok
  67: Check open filename arg using perf trace + vfs_getname: Ok
  [root@quaco ~]#

Reported-by: Michael Petlan <mpetlan@redhat.com>
Tested-by: Michael Petlan <mpetlan@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-mv8kolk17xla1smvmp3qabv1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index ed4583128b9c..b36061cd1ab8 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2514,19 +2514,30 @@ static size_t trace__fprintf_thread_summary(struct trace *trace, FILE *fp);
 
 static bool perf_evlist__add_vfs_getname(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evsel__newtp("probe", "vfs_getname");
+	bool found = false;
+	struct perf_evsel *evsel, *tmp;
+	struct parse_events_error err = { .idx = 0, };
+	int ret = parse_events(evlist, "probe:vfs_getname*", &err);
 
-	if (IS_ERR(evsel))
+	if (ret)
 		return false;
 
-	if (perf_evsel__field(evsel, "pathname") == NULL) {
+	evlist__for_each_entry_safe(evlist, evsel, tmp) {
+		if (!strstarts(perf_evsel__name(evsel), "probe:vfs_getname"))
+			continue;
+
+		if (perf_evsel__field(evsel, "pathname")) {
+			evsel->handler = trace__vfs_getname;
+			found = true;
+			continue;
+		}
+
+		list_del_init(&evsel->node);
+		evsel->evlist = NULL;
 		perf_evsel__delete(evsel);
-		return false;
 	}
 
-	evsel->handler = trace__vfs_getname;
-	perf_evlist__add(evlist, evsel);
-	return true;
+	return found;
 }
 
 static struct perf_evsel *perf_evsel__new_pgfault(u64 config)
-- 
2.20.1


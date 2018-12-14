Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7685C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497972080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730840AbeLNU1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:27:42 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40131 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730694AbeLNU1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:27:42 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBEKRApT1453585
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Dec 2018 12:27:10 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBEKR9h61453582;
        Fri, 14 Dec 2018 12:27:09 -0800
Date:   Fri, 14 Dec 2018 12:27:09 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-x52mx1ybq8128rtg9hjrj5qk@git.kernel.org>
Cc:     hpa@zytor.com, jolsa@kernel.org, wangnan0@huawei.com,
        tglx@linutronix.de, acme@redhat.com, daniel@iogearbox.net,
        ibobrik@gmail.com, adrian.hunter@intel.com, dsahern@gmail.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        namhyung@kernel.org, davem@davemloft.net, ast@kernel.org
Reply-To: namhyung@kernel.org, ast@kernel.org, davem@davemloft.net,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          dsahern@gmail.com, adrian.hunter@intel.com, ibobrik@gmail.com,
          daniel@iogearbox.net, acme@redhat.com, tglx@linutronix.de,
          wangnan0@huawei.com, hpa@zytor.com, jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf top: Allow passing a kallsyms file
Git-Commit-ID: 5f71b002bbc6d73b875f250db9a8093feac0d1cc
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5f71b002bbc6d73b875f250db9a8093feac0d1cc
Gitweb:     https://git.kernel.org/tip/5f71b002bbc6d73b875f250db9a8093feac0d1cc
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 27 Nov 2018 10:31:03 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 29 Nov 2018 20:42:49 -0300

perf top: Allow passing a kallsyms file

This basically replicates what was done for 'perf report' in:

   b226a5a72901 ("perf report: Allow user to specify path to kallsyms file")

This should help with resolving eBPF symbols, that are in kallsyms but,
of course, not in vmlinux.

Reported-by: Ivan Babrou <ibobrik@gmail.com>
Tested-by: Ivan Babrou <ibobrik@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Ahern <dsahern@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-x52mx1ybq8128rtg9hjrj5qk@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-top.txt | 3 +++
 tools/perf/builtin-top.c              | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index 808b664343c9..44d89fb9c788 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -70,6 +70,9 @@ Default is to monitor all CPUS.
 --ignore-vmlinux::
 	Ignore vmlinux files.
 
+--kallsyms=<file>::
+	kallsyms pathname
+
 -m <pages>::
 --mmap-pages=<pages>::
 	Number of mmap data pages (must be a power of two) or size
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index aa0c73e57924..1252d1759064 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1289,6 +1289,8 @@ int cmd_top(int argc, const char **argv)
 		   "file", "vmlinux pathname"),
 	OPT_BOOLEAN(0, "ignore-vmlinux", &symbol_conf.ignore_vmlinux,
 		    "don't load vmlinux even if found"),
+	OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name,
+		   "file", "kallsyms pathname"),
 	OPT_BOOLEAN('K', "hide_kernel_symbols", &top.hide_kernel_symbols,
 		    "hide kernel symbols"),
 	OPT_CALLBACK('m', "mmap-pages", &opts->mmap_pages, "pages",

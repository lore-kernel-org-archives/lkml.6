Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4064C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6EED2188F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6EED2188F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbeHROpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:45:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33653 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbeHROpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:45:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBbYnn1287267
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:37:34 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBbYAT1287264;
        Sat, 18 Aug 2018 04:37:34 -0700
Date:   Sat, 18 Aug 2018 04:37:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-talrnxps9p3qozk3aeh91fgv@git.kernel.org>
Cc:     wangnan0@huawei.com, hpa@zytor.com, jolsa@kernel.org,
        adrian.hunter@intel.com, tglx@linutronix.de, namhyung@kernel.org,
        acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        dsahern@gmail.com
Reply-To: hpa@zytor.com, wangnan0@huawei.com, jolsa@kernel.org,
          namhyung@kernel.org, tglx@linutronix.de, adrian.hunter@intel.com,
          acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
          dsahern@gmail.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf bpf: Make bpf__for_each_stdout_map() generic
Git-Commit-ID: 5941d856a90435b32a3296c0b7df8f0075430b81
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

Commit-ID:  5941d856a90435b32a3296c0b7df8f0075430b81
Gitweb:     https://git.kernel.org/tip/5941d856a90435b32a3296c0b7df8f0075430b81
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 6 Aug 2018 09:46:33 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 8 Aug 2018 15:55:55 -0300

perf bpf: Make bpf__for_each_stdout_map() generic

By passing a 'name' arg, that will eventually be used to setup more
"bpf-output" events, e.g. to create a event where to create raw_syscalls
like events that in addition to the syscall arguments will also copy the
pointer contents being passed from/to userspace.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-talrnxps9p3qozk3aeh91fgv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-loader.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 3d02ae38ec56..e864a7e0ff12 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -1529,12 +1529,15 @@ int bpf__apply_obj_config(void)
 	bpf_object__for_each_safe(obj, objtmp)	\
 		bpf_map__for_each(pos, obj)
 
-#define bpf__for_each_stdout_map(pos, obj, objtmp)	\
+#define bpf__for_each_map_named(pos, obj, objtmp, name)	\
 	bpf__for_each_map(pos, obj, objtmp) 		\
 		if (bpf_map__name(pos) && 		\
-			(strcmp("__bpf_stdout__", 	\
+			(strcmp(name, 			\
 				bpf_map__name(pos)) == 0))
 
+#define bpf__for_each_stdout_map(pos, obj, objtmp) \
+	 bpf__for_each_map_named(pos, obj, objtmp, "__bpf_stdout__")
+
 int bpf__setup_stdout(struct perf_evlist *evlist)
 {
 	struct bpf_map_priv *tmpl_priv = NULL;

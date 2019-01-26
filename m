Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D037C282C8
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6921C218CD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbfAZKLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 05:11:23 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38099 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfAZKLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 05:11:23 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0QAArcp513854
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 26 Jan 2019 02:10:53 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0QAArEv513851;
        Sat, 26 Jan 2019 02:10:53 -0800
Date:   Sat, 26 Jan 2019 02:10:53 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-56eplvf86r69wt3p35nh805z@git.kernel.org>
Cc:     mingo@kernel.org, acme@redhat.com, daniel@iogearbox.net,
        lclaudio@redhat.com, adrian.hunter@intel.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, wangnan0@huawei.com,
        namhyung@kernel.org, kafai@fb.com, tglx@linutronix.de, yhs@fb.com
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, wangnan0@huawei.com,
          kafai@fb.com, namhyung@kernel.org, tglx@linutronix.de,
          yhs@fb.com, mingo@kernel.org, daniel@iogearbox.net,
          acme@redhat.com, adrian.hunter@intel.com, lclaudio@redhat.com,
          jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf bpf: Convert pid_map() to bpf_map()
Git-Commit-ID: c657d76f9fb8379cc847d09f1448e4ac151790c7
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

Commit-ID:  c657d76f9fb8379cc847d09f1448e4ac151790c7
Gitweb:     https://git.kernel.org/tip/c657d76f9fb8379cc847d09f1448e4ac151790c7
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 24 Jan 2019 15:11:28 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 25 Jan 2019 15:12:10 +0100

perf bpf: Convert pid_map() to bpf_map()

First user, pid_t as the type, lets see how this goes with the BTF
routines.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/n/tip-56eplvf86r69wt3p35nh805z@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/include/bpf/bpf.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/tools/perf/include/bpf/bpf.h b/tools/perf/include/bpf/bpf.h
index 0482028c1d11..5df7ed9d9020 100644
--- a/tools/perf/include/bpf/bpf.h
+++ b/tools/perf/include/bpf/bpf.h
@@ -34,13 +34,7 @@ struct bpf_map SEC("maps") name = {				\
  *	  For the current need, 'perf trace --filter-pids', 64 should
  *	  be good enough, but this surely needs to be revisited.
  */
-#define pid_map(name, value_type)		\
-struct bpf_map SEC("maps") name = {		\
-	.type	     = BPF_MAP_TYPE_HASH,	\
-	.key_size    = sizeof(pid_t),		\
-	.value_size  = sizeof(value_type),	\
-	.max_entries = 64,			\
-}
+#define pid_map(name, value_type) bpf_map(name, HASH, pid_t, value_type, 64)
 
 static int (*bpf_map_update_elem)(struct bpf_map *map, void *key, void *value, u64 flags) = (void *)BPF_FUNC_map_update_elem;
 static void *(*bpf_map_lookup_elem)(struct bpf_map *map, void *key) = (void *)BPF_FUNC_map_lookup_elem;

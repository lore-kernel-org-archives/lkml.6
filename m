Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB501C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A687218E0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388662AbeLTSKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:10:47 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34741 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388648AbeLTSKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:10:46 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKIAcd03681948
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:10:38 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKIAbdW3681945;
        Thu, 20 Dec 2018 10:10:37 -0800
Date:   Thu, 20 Dec 2018 10:10:37 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-azwys8irxqx9053vpajr0k5h@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com,
        adrian.hunter@intel.com, jolsa@kernel.org, wangnan0@huawei.com,
        tglx@linutronix.de, namhyung@kernel.org, acme@redhat.com,
        mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
          acme@redhat.com, adrian.hunter@intel.com, tglx@linutronix.de,
          wangnan0@huawei.com, jolsa@kernel.org, namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf bpf: Move perf_event_output() from stdio.h to
 bpf.h
Git-Commit-ID: 61d007138a44dc69265cf948eadd1759edbd3875
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

Commit-ID:  61d007138a44dc69265cf948eadd1759edbd3875
Gitweb:     https://git.kernel.org/tip/61d007138a44dc69265cf948eadd1759edbd3875
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 12 Dec 2018 15:31:28 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 12:23:58 -0300

perf bpf: Move perf_event_output() from stdio.h to bpf.h

So that we don't always carry that __bpf_output__ map, leaving that to
the scripts wanting to use that facility.

'perf trace' will be changed to look if that map is present and only
setup the bpf-output events if so.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-azwys8irxqx9053vpajr0k5h@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/include/bpf/bpf.h   | 2 ++
 tools/perf/include/bpf/stdio.h | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/include/bpf/bpf.h b/tools/perf/include/bpf/bpf.h
index bd5d7b4d7760..e667577207dc 100644
--- a/tools/perf/include/bpf/bpf.h
+++ b/tools/perf/include/bpf/bpf.h
@@ -55,4 +55,6 @@ int _version SEC("version") = LINUX_VERSION_CODE;
 static int (*probe_read)(void *dst, int size, const void *unsafe_addr) = (void *)BPF_FUNC_probe_read;
 static int (*probe_read_str)(void *dst, int size, const void *unsafe_addr) = (void *)BPF_FUNC_probe_read_str;
 
+static int (*perf_event_output)(void *, struct bpf_map *, int, void *, unsigned long) = (void *)BPF_FUNC_perf_event_output;
+
 #endif /* _PERF_BPF_H */
diff --git a/tools/perf/include/bpf/stdio.h b/tools/perf/include/bpf/stdio.h
index 2899cb7bfed8..316af5b2ff35 100644
--- a/tools/perf/include/bpf/stdio.h
+++ b/tools/perf/include/bpf/stdio.h
@@ -9,9 +9,6 @@ struct bpf_map SEC("maps") __bpf_stdout__ = {
        .max_entries = __NR_CPUS__,
 };
 
-static int (*perf_event_output)(void *, struct bpf_map *, int, void *, unsigned long) =
-	(void *)BPF_FUNC_perf_event_output;
-
 #define puts(from) \
 	({ const int __len = sizeof(from); \
 	   char __from[__len] = from; \

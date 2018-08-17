Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1987C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 11:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B4E208EB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 11:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98B4E208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbeHQOtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 10:49:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45232 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726134AbeHQOtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 10:49:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 53F9B401BF62;
        Fri, 17 Aug 2018 11:46:02 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF9BE2142F20;
        Fri, 17 Aug 2018 11:46:00 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        =?UTF-8?q?Jaroslav=20=C5=A0karvada?= <jskarvad@redhat.com>,
        Joe Mario <jmario@redhat.com>
Subject: [PATCH 1/2] perf tools: Store real cpu number in the struct perf_mmap
Date:   Fri, 17 Aug 2018 13:45:55 +0200
Message-Id: <20180817114556.28000-2-jolsa@kernel.org>
In-Reply-To: <20180817114556.28000-1-jolsa@kernel.org>
References: <20180817114556.28000-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 17 Aug 2018 11:46:02 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 17 Aug 2018 11:46:02 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Storing the real cpu number in the struct perf_mmap, which
be used by python interface that allows user to read particular
memory map for given cpu.

Link: http://lkml.kernel.org/n/tip-a2h9hjs7abv42yiagxiz2sp8@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/evlist.c | 2 +-
 tools/perf/util/mmap.c   | 4 +++-
 tools/perf/util/mmap.h   | 4 +++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e7a4b31a84fb..26e1c02440f9 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -803,7 +803,7 @@ static int perf_evlist__mmap_per_evsel(struct perf_evlist *evlist, int idx,
 		if (*output == -1) {
 			*output = fd;
 
-			if (perf_mmap__mmap(&maps[idx], mp, *output)  < 0)
+			if (perf_mmap__mmap(&maps[idx], mp, *output, evlist_cpu)  < 0)
 				return -1;
 		} else {
 			if (ioctl(fd, PERF_EVENT_IOC_SET_OUTPUT, *output) != 0)
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index fc832676a798..2eac6dee0b9c 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -164,7 +164,8 @@ void perf_mmap__munmap(struct perf_mmap *map)
 	auxtrace_mmap__munmap(&map->auxtrace_mmap);
 }
 
-int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd)
+int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp,
+		    int fd, int cpu)
 {
 	/*
 	 * The last one will be done at perf_mmap__consume(), so that we
@@ -191,6 +192,7 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd)
 		return -1;
 	}
 	map->fd = fd;
+	map->cpu = cpu;
 
 	if (auxtrace_mmap__mmap(&map->auxtrace_mmap,
 				&mp->auxtrace_mp, map->base, fd))
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index d82294db1295..cc4fc8cc33ca 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -18,6 +18,7 @@ struct perf_mmap {
 	void		 *base;
 	int		 mask;
 	int		 fd;
+	int		 cpu;
 	refcount_t	 refcnt;
 	u64		 prev;
 	u64		 start;
@@ -60,7 +61,8 @@ struct mmap_params {
 	struct auxtrace_mmap_params auxtrace_mp;
 };
 
-int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd);
+int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp,
+		    int fd, int cpu);
 void perf_mmap__munmap(struct perf_mmap *map);
 
 void perf_mmap__get(struct perf_mmap *map);
-- 
2.17.1


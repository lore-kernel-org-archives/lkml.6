Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F75CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB8D2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB8D2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732716AbeHWMP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:15:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48807 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbeHWMP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:15:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7N8kSrv3191299
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 23 Aug 2018 01:46:28 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7N8kShA3191296;
        Thu, 23 Aug 2018 01:46:28 -0700
Date:   Thu, 23 Aug 2018 01:46:28 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-721f0dfc3ce821c6a32820ab63edfb48ed4af075@git.kernel.org>
Cc:     tglx@linutronix.de, namhyung@kernel.org, jskarvad@redhat.com,
        jmario@redhat.com, jolsa@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        acme@redhat.com, dsahern@gmail.com, mingo@kernel.org,
        peterz@infradead.org
Reply-To: jskarvad@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
          jmario@redhat.com, jolsa@kernel.org,
          alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
          hpa@zytor.com, peterz@infradead.org, mingo@kernel.org,
          acme@redhat.com, dsahern@gmail.com
In-Reply-To: <20180817114556.28000-3-jolsa@kernel.org>
References: <20180817114556.28000-3-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf python: Fix pyrf_evlist__read_on_cpu()
 interface
Git-Commit-ID: 721f0dfc3ce821c6a32820ab63edfb48ed4af075
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

Commit-ID:  721f0dfc3ce821c6a32820ab63edfb48ed4af075
Gitweb:     https://git.kernel.org/tip/721f0dfc3ce821c6a32820ab63edfb48ed4af075
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 17 Aug 2018 13:45:56 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 20 Aug 2018 08:54:59 -0300

perf python: Fix pyrf_evlist__read_on_cpu() interface

Jaroslav reported errors from valgrind over perf python script:

  # echo 0 > /sys/devices/system/cpu/cpu4/online
  # valgrind ./test.py
  ==7524== Memcheck, a memory error detector
  ...
  ==7524== Command: ./test.py
  ==7524==
  pid 7526 exited
  ==7524== Invalid read of size 8
  ==7524==    at 0xCC2C2B3: perf_mmap__read_forward (evlist.c:780)
  ==7524==    by 0xCC2A681: pyrf_evlist__read_on_cpu (python.c:959)
  ...
  ==7524==  Address 0x65c4868 is 16 bytes after a block of size 459,36..
  ==7524==    at 0x4C2B955: calloc (vg_replace_malloc.c:711)
  ==7524==    by 0xCC2F484: zalloc (util.h:35)
  ==7524==    by 0xCC2F484: perf_evlist__alloc_mmap (evlist.c:978)
  ...

The reason for this is in the python interface, that allows a script to
pass arbitrary cpu number, which is then used to access struct
perf_evlist::mmap array. That's obviously wrong and works only when if
all cpus are available and fails if some cpu is missing, like in the
example above.

This patch makes pyrf_evlist__read_on_cpu() search the evlist's maps
array for the proper map to access.

It's linear search at the moment. Based on the way how is the
read_on_cpu used, I don't think we need to be fast in here.  But we
could add some hash in the middle to make it fast/er.

We don't allow python interface to set write_backward event attribute,
so it's safe to check only evlist's mmaps.

Reported-by: Jaroslav Škarvada <jskarvad@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Joe Mario <jmario@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180817114556.28000-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index f74fbb652a4f..ce501ba14b08 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -11,6 +11,7 @@
 #include "cpumap.h"
 #include "print_binary.h"
 #include "thread_map.h"
+#include "mmap.h"
 
 #if PY_MAJOR_VERSION < 3
 #define _PyUnicode_FromString(arg) \
@@ -976,6 +977,20 @@ static PyObject *pyrf_evlist__add(struct pyrf_evlist *pevlist,
 	return Py_BuildValue("i", evlist->nr_entries);
 }
 
+static struct perf_mmap *get_md(struct perf_evlist *evlist, int cpu)
+{
+	int i;
+
+	for (i = 0; i < evlist->nr_mmaps; i++) {
+		struct perf_mmap *md = &evlist->mmap[i];
+
+		if (md->cpu == cpu)
+			return md;
+	}
+
+	return NULL;
+}
+
 static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 					  PyObject *args, PyObject *kwargs)
 {
@@ -990,7 +1005,10 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 					 &cpu, &sample_id_all))
 		return NULL;
 
-	md = &evlist->mmap[cpu];
+	md = get_md(evlist, cpu);
+	if (!md)
+		return NULL;
+
 	if (perf_mmap__read_init(md) < 0)
 		goto end;
 

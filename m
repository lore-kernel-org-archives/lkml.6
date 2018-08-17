Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2D3C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 11:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 433AA208EB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 11:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 433AA208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbeHQOtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 10:49:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726134AbeHQOtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 10:49:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2B17D40241C7;
        Fri, 17 Aug 2018 11:46:04 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D6782142F21;
        Fri, 17 Aug 2018 11:46:02 +0000 (UTC)
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
Subject: [PATCH 2/2] perf python: Fix pyrf_evlist__read_on_cpu interface
Date:   Fri, 17 Aug 2018 13:45:56 +0200
Message-Id: <20180817114556.28000-3-jolsa@kernel.org>
In-Reply-To: <20180817114556.28000-1-jolsa@kernel.org>
References: <20180817114556.28000-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 17 Aug 2018 11:46:04 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 17 Aug 2018 11:46:04 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

The reason for this is in the python interface, that allows
script to pass arbitrary cpu number, which is then used to
access struct perf_evlist::mmap array. That's obviously wrong
and works only when if all cpus are available and fails
if some cpu is missing, like in the example above.

This patch makes the pyrf_evlist__read_on_cpu search the
evlist's maps array for the proper map to access.

It's linear search at the moment. Based on the way how is the
read_on_cpu used, I don't think we need to be fast in here.
But we could add some hash in the middle to make it fast/er.

We don't allow python interface to set write_backward event
attribute, so it's safe to check only evlist's mmaps.

Reported-by: Jaroslav Škarvada <jskarvad@redhat.com>
Link: http://lkml.kernel.org/n/tip-nje64txu8bcop0ogjvbt8i54@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
 
-- 
2.17.1


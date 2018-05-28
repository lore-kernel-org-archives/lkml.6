Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424939AbeE1Lxm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:53:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423689AbeE1LJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:09:01 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 110/272] perf mmap: Fix accessing unmapped mmap in perf_mmap__read_done()
Date: Mon, 28 May 2018 12:02:23 +0200
Message-Id: <20180528100250.402370753@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kan Liang <kan.liang@linux.intel.com>

[ Upstream commit f58385f629c87a9e210108b39c1f4950d0363ad2 ]

There is a segmentation fault when running 'perf trace'. For example:

  [root@jouet e]# perf trace -e *chdir -o /tmp/bla perf report --ignore-vmlinux -i ../perf.data

The perf_mmap__consume() could unmap the mmap. It needs to check the
refcnt in perf_mmap__read_done().

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: ee023de05f35 ("perf mmap: Introduce perf_mmap__read_done()")
Link: http://lkml.kernel.org/r/1522071729-16776-1-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/mmap.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -344,5 +344,11 @@ out:
  */
 void perf_mmap__read_done(struct perf_mmap *map)
 {
+	/*
+	 * Check if event was unmapped due to a POLLHUP/POLLERR.
+	 */
+	if (!refcount_read(&map->refcnt))
+		return;
+
 	map->prev = perf_mmap__read_head(map);
 }

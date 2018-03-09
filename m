Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752041AbeCIIfB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:35:01 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48567 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751242AbeCIIe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:34:59 -0500
Date: Fri, 9 Mar 2018 00:34:49 -0800
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-j3j72vvn2d5j7tenlghdy195@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, jolsa@kernel.org, hpa@zytor.com,
        wangnan0@huawei.com, tglx@linutronix.de, adrian.hunter@intel.com,
        namhyung@kernel.org, acme@redhat.com, eranian@google.com,
        mingo@kernel.org, dsahern@gmail.com
Reply-To: tglx@linutronix.de, wangnan0@huawei.com, jolsa@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        dsahern@gmail.com, eranian@google.com, namhyung@kernel.org,
        adrian.hunter@intel.com, acme@redhat.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cgroup: Introduce cgroup__delete()
Git-Commit-ID: 9450d0d46c895cae99e922145aca20bd30533bc6
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  9450d0d46c895cae99e922145aca20bd30533bc6
Gitweb:     https://git.kernel.org/tip/9450d0d46c895cae99e922145aca20bd30533bc6
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 6 Mar 2018 10:08:10 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 7 Mar 2018 10:22:25 -0300

perf cgroup: Introduce cgroup__delete()

Just to make this code look more like other places in tools/perf.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-j3j72vvn2d5j7tenlghdy195@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cgroup.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 6ce291f45f2d..4dd52feb1ae6 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -144,12 +144,17 @@ found:
 	return 0;
 }
 
+static void cgroup__delete(struct cgroup *cgroup)
+{
+	close(cgroup->fd);
+	zfree(&cgroup->name);
+	free(cgroup);
+}
+
 void close_cgroup(struct cgroup *cgrp)
 {
 	if (cgrp && refcount_dec_and_test(&cgrp->refcnt)) {
-		close(cgrp->fd);
-		zfree(&cgrp->name);
-		free(cgrp);
+		cgroup__delete(cgrp);
 	}
 }
 

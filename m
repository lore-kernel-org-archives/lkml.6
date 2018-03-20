Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbeCTG3E (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:29:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51729 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751689AbeCTG2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:28:55 -0400
Date: Mon, 19 Mar 2018 23:28:31 -0700
From: tip-bot for Yisheng Xie <tipbot@zytor.com>
Message-ID: <tip-cff17205d6bd363703034510a84d66044aff176e@git.kernel.org>
Cc: acme@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, xieyisheng1@huawei.com,
        namhyung@kernel.org, mingo@kernel.org, peterz@infradead.org
Reply-To: alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        xieyisheng1@huawei.com, mingo@kernel.org, peterz@infradead.org,
        acme@redhat.com, tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <1520853957-36106-2-git-send-email-xieyisheng1@huawei.com>
References: <1520853957-36106-2-git-send-email-xieyisheng1@huawei.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf record: Avoid duplicate call of
 perf_default_config()
Git-Commit-ID: cff17205d6bd363703034510a84d66044aff176e
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

Commit-ID:  cff17205d6bd363703034510a84d66044aff176e
Gitweb:     https://git.kernel.org/tip/cff17205d6bd363703034510a84d66044aff176e
Author:     Yisheng Xie <xieyisheng1@huawei.com>
AuthorDate: Mon, 12 Mar 2018 19:25:57 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Mar 2018 13:55:58 -0300

perf record: Avoid duplicate call of perf_default_config()

We have brought perf_default_config to the very beginning at main(), so
it no need to call perf_default_config() once more for most of config in
perf-record but only for record.call-graph.

Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1520853957-36106-2-git-send-email-xieyisheng1@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index b81494587120..d33103291b02 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1279,10 +1279,12 @@ static int perf_record_config(const char *var, const char *value, void *cb)
 			return -1;
 		return 0;
 	}
-	if (!strcmp(var, "record.call-graph"))
-		var = "call-graph.record-mode"; /* fall-through */
+	if (!strcmp(var, "record.call-graph")) {
+		var = "call-graph.record-mode";
+		return perf_default_config(var, value, cb);
+	}
 
-	return perf_default_config(var, value, cb);
+	return 0;
 }
 
 struct clockid_map {

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752613AbeCYW0J (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:26:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43193 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752477AbeCYWZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:25:59 -0400
Date: Sun, 25 Mar 2018 15:25:20 -0700
From: tip-bot for Petr Machata <tipbot@zytor.com>
Message-ID: <tip-83428f2fad48e16fddff0cb445cb4fedf5afe4ab@git.kernel.org>
Cc: peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        namhyung@kernel.org, petrm@mellanox.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org
Reply-To: alexander.shishkin@linux.intel.com, peterz@infradead.org,
        mingo@kernel.org, tglx@linutronix.de, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, petrm@mellanox.com,
        acme@redhat.com, namhyung@kernel.org
In-Reply-To: <b1e565ecccf68064d8d54f37db5d028dda8fa522.1521675563.git.petrm@mellanox.com>
References: <b1e565ecccf68064d8d54f37db5d028dda8fa522.1521675563.git.petrm@mellanox.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf python: Reference Py_None before returning it
Git-Commit-ID: 83428f2fad48e16fddff0cb445cb4fedf5afe4ab
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

Commit-ID:  83428f2fad48e16fddff0cb445cb4fedf5afe4ab
Gitweb:     https://git.kernel.org/tip/83428f2fad48e16fddff0cb445cb4fedf5afe4ab
Author:     Petr Machata <petrm@mellanox.com>
AuthorDate: Thu, 22 Mar 2018 00:57:32 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 23 Mar 2018 16:45:20 -0300

perf python: Reference Py_None before returning it

Python None objects are handled just like all the other objects with
respect to their reference counting. Before returning Py_None, its
reference count thus needs to be bumped.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Petr Machata <petrm@mellanox.com>
Link: http://lkml.kernel.org/r/b1e565ecccf68064d8d54f37db5d028dda8fa522.1521675563.git.petrm@mellanox.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index b956868fd445..863b61478edd 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1004,8 +1004,10 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 			return PyErr_NoMemory();
 
 		evsel = perf_evlist__event2evsel(evlist, event);
-		if (!evsel)
+		if (!evsel) {
+			Py_INCREF(Py_None);
 			return Py_None;
+		}
 
 		pevent->evsel = evsel;
 

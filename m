Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6A3C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6AD3208E2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:04:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6AD3208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732422AbeGLOOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:14:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56249 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbeGLOOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:14:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6CE42fP3935212
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 12 Jul 2018 07:04:02 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6CE426L3935208;
        Thu, 12 Jul 2018 07:04:02 -0700
Date:   Thu, 12 Jul 2018 07:04:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Janne Huttunen <tipbot@zytor.com>
Message-ID: <tip-db0ba84c04ef2cf293aaada5ae97531127844d9d@git.kernel.org>
Cc:     janne.huttunen@nokia.com, acme@redhat.com, jskarvad@redhat.com,
        tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, namhyung@kernel.org, mingo@kernel.org,
        hpa@zytor.com, ak@linux.intel.com
Reply-To: acme@redhat.com, janne.huttunen@nokia.com, jskarvad@redhat.com,
          tglx@linutronix.de, alexander.shishkin@linux.intel.com,
          peterz@infradead.org, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, namhyung@kernel.org,
          ak@linux.intel.com, hpa@zytor.com, mingo@kernel.org
In-Reply-To: <1531133990-17485-1-git-send-email-janne.huttunen@nokia.com>
References: <1531133990-17485-1-git-send-email-janne.huttunen@nokia.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf script python: Fix dict reference counting
Git-Commit-ID: db0ba84c04ef2cf293aaada5ae97531127844d9d
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

Commit-ID:  db0ba84c04ef2cf293aaada5ae97531127844d9d
Gitweb:     https://git.kernel.org/tip/db0ba84c04ef2cf293aaada5ae97531127844d9d
Author:     Janne Huttunen <janne.huttunen@nokia.com>
AuthorDate: Mon, 9 Jul 2018 13:59:50 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 11 Jul 2018 09:45:24 -0400

perf script python: Fix dict reference counting

The dictionaries are attached to the parameter tuple that steals the
references and takes care of releasing them when appropriate.  The code
should not decrement the reference counts explicitly.  E.g. if libpython
has been built with reference debugging enabled, the superfluous DECREFs
will trigger this error when running perf script:

  Fatal Python error: Objects/tupleobject.c:238 object at
  0x7f10f2041b40 has negative ref count -1
  Aborted (core dumped)

If the reference debugging is not enabled, the superfluous DECREFs might
cause the dict objects to be silently released while they are still in
use. This may trigger various other assertions or just cause perf
crashes and/or weird and unexpected data changes in the stored Python
objects.

Signed-off-by: Janne Huttunen <janne.huttunen@nokia.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jaroslav Skarvada <jskarvad@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1531133990-17485-1-git-send-email-janne.huttunen@nokia.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/scripting-engines/trace-event-python.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 8b2eb6dbff4d..bc32e57d17be 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -908,14 +908,11 @@ static void python_process_tracepoint(struct perf_sample *sample,
 	if (_PyTuple_Resize(&t, n) == -1)
 		Py_FatalError("error resizing Python tuple");
 
-	if (!dict) {
+	if (!dict)
 		call_object(handler, t, handler_name);
-	} else {
+	else
 		call_object(handler, t, default_handler_name);
-		Py_DECREF(dict);
-	}
 
-	Py_XDECREF(all_entries_dict);
 	Py_DECREF(t);
 }
 
@@ -1235,7 +1232,6 @@ static void python_process_general_event(struct perf_sample *sample,
 
 	call_object(handler, t, handler_name);
 
-	Py_DECREF(dict);
 	Py_DECREF(t);
 }
 

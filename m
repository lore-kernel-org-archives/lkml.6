Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2485C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A8F2146F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OecuGFDJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A8F2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389887AbeGKUv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:51:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389657AbeGKUv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:51:26 -0400
Received: from jouet.localdomain (unknown [71.46.56.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B531820C0C;
        Wed, 11 Jul 2018 20:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531341920;
        bh=4I7oHjGCEpO4IwK+A0FD144nVWoB2oDs7xOpqXmPCjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OecuGFDJ6IOluK64SmB9PNmdNVgkt5Gk4ls+ni/3o7olP6TUgZwDXR0FtGmymo4aV
         Glu+MF0fQ0qS05RpqRlhpYyLA/QN6lQ2yzynHTepIaWxvL243I+IMAExKXjFjU5Kdj
         eUxOTzehENcwklTDhMSphIlIn3c5SATWak2HhktE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Janne Huttunen <janne.huttunen@nokia.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jaroslav Skarvada <jskarvad@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 13/14] perf script python: Fix dict reference counting
Date:   Wed, 11 Jul 2018 16:43:04 -0400
Message-Id: <20180711204305.12924-14-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180711204305.12924-1-acme@kernel.org>
References: <20180711204305.12924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Janne Huttunen <janne.huttunen@nokia.com>

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
 
-- 
2.14.4


Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69709C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD642147A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD642147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731835AbeHWMBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:01:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48314 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729390AbeHWMBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:01:46 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 042B9C7B;
        Thu, 23 Aug 2018 08:33:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Janne Huttunen <janne.huttunen@nokia.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jaroslav Skarvada <jskarvad@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 169/217] perf script python: Fix dict reference counting
Date:   Thu, 23 Aug 2018 09:54:42 +0200
Message-Id: <20180823075513.168612938@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Janne Huttunen <janne.huttunen@nokia.com>

[ Upstream commit db0ba84c04ef2cf293aaada5ae97531127844d9d ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/scripting-engines/trace-event-python.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -643,14 +643,11 @@ static void python_process_tracepoint(st
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
 
@@ -970,7 +967,6 @@ static void python_process_general_event
 
 	call_object(handler, t, handler_name);
 
-	Py_DECREF(dict);
 	Py_DECREF(t);
 }
 



Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C2DC1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E184920C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsdRtP7k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E184920C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387727AbeGKUu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:50:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733070AbeGKUu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:50:26 -0400
Received: from jouet.localdomain (unknown [71.46.56.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADFC520C0E;
        Wed, 11 Jul 2018 20:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531341859;
        bh=foqOkzwQY8ua8VEPbYPIsl/8sKIIGpwhzvtZsXtnoB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WsdRtP7kUV/T6iJAJGFoU/oL4M6Y+3fPG5qhpx9czdt3d0OjOq4DZzlv+bN7dohut
         BiM5rvf3j5FMe85mIFm7c/ckqN/zqpJD1mzw0Aj6kaw3+vRWPDV4RiLg/OAMnQPvpe
         Ztd7Haqy/7t1SEutITmwxYCJ8DMkHX90TxaBptQw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jeremy Cline <jeremy@jcline.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Herton Krzesinski <herton@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/14] perf tools: Generate a Python script compatible with Python 2 and 3
Date:   Wed, 11 Jul 2018 16:42:52 -0400
Message-Id: <20180711204305.12924-2-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180711204305.12924-1-acme@kernel.org>
References: <20180711204305.12924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Cline <jeremy@jcline.org>

When generating a Python script with "perf script -g python", produce
one that is compatible with Python 2 and 3. The difference between the
two generated scripts is:

  --- python2-perf-script.py	2018-05-08 15:35:00.865889705 -0400
  +++ python3-perf-script.py	2018-05-08 15:34:49.019789564 -0400
  @@ -7,6 +7,8 @@
   # be retrieved using Python functions of the form common_*(context).
   # See the perf-script-python Documentation for the list of available functions.

  +from __future__ import print_function
  +
   import os
   import sys

  @@ -18,10 +20,10 @@

   def trace_begin():
  -	print "in trace_begin"
  +	print("in trace_begin")

   def trace_end():
  -	print "in trace_end"
  +	print("in trace_end")

   def raw_syscalls__sys_enter(event_name, context, common_cpu,
   	common_secs, common_nsecs, common_pid, common_comm,
  @@ -29,26 +31,26 @@
   		print_header(event_name, common_cpu, common_secs, common_nsecs,
   			common_pid, common_comm)

  -		print "id=%d, args=%s" % \
  -		(id, args)
  +		print("id=%d, args=%s" % \
  +		(id, args))

  -		print 'Sample: {'+get_dict_as_string(perf_sample_dict['sample'], ', ')+'}'
  +		print('Sample: {'+get_dict_as_string(perf_sample_dict['sample'], ', ')+'}')

   		for node in common_callchain:
   			if 'sym' in node:
  -				print "\t[%x] %s" % (node['ip'], node['sym']['name'])
  +				print("\t[%x] %s" % (node['ip'], node['sym']['name']))
   			else:
  -				print "	[%x]" % (node['ip'])
  +				print("	[%x]" % (node['ip']))

  -		print "\n"
  +		print()

   def trace_unhandled(event_name, context, event_fields_dict, perf_sample_dict):
  -		print get_dict_as_string(event_fields_dict)
  -		print 'Sample: {'+get_dict_as_string(perf_sample_dict['sample'], ', ')+'}'
  +		print(get_dict_as_string(event_fields_dict))
  +		print('Sample: {'+get_dict_as_string(perf_sample_dict['sample'], ', ')+'}')

   def print_header(event_name, cpu, secs, nsecs, pid, comm):
  -	print "%-20s %5u %05u.%09u %8u %-20s " % \
  -	(event_name, cpu, secs, nsecs, pid, comm),
  +	print("%-20s %5u %05u.%09u %8u %-20s " % \
  +	(event_name, cpu, secs, nsecs, pid, comm), end="")

   def get_dict_as_string(a_dict, delimiter=' '):
   	return delimiter.join(['%s=%s'%(k,str(v))for k,v in sorted(a_dict.items())])

Signed-off-by: Jeremy Cline <jeremy@jcline.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Herton Krzesinski <herton@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/0100016341a7278a-d178c724-2b0f-49ca-be93-80a7d51aaa0d-000000@email.amazonses.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../util/scripting-engines/trace-event-python.c    | 29 +++++++++++-----------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 46e9e19ab1ac..8b2eb6dbff4d 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1627,6 +1627,7 @@ static int python_generate_script(struct pevent *pevent, const char *outfile)
 	fprintf(ofp, "# See the perf-script-python Documentation for the list "
 		"of available functions.\n\n");
 
+	fprintf(ofp, "from __future__ import print_function\n\n");
 	fprintf(ofp, "import os\n");
 	fprintf(ofp, "import sys\n\n");
 
@@ -1636,10 +1637,10 @@ static int python_generate_script(struct pevent *pevent, const char *outfile)
 	fprintf(ofp, "from Core import *\n\n\n");
 
 	fprintf(ofp, "def trace_begin():\n");
-	fprintf(ofp, "\tprint \"in trace_begin\"\n\n");
+	fprintf(ofp, "\tprint(\"in trace_begin\")\n\n");
 
 	fprintf(ofp, "def trace_end():\n");
-	fprintf(ofp, "\tprint \"in trace_end\"\n\n");
+	fprintf(ofp, "\tprint(\"in trace_end\")\n\n");
 
 	while ((event = trace_find_next_event(pevent, event))) {
 		fprintf(ofp, "def %s__%s(", event->system, event->name);
@@ -1675,7 +1676,7 @@ static int python_generate_script(struct pevent *pevent, const char *outfile)
 			"common_secs, common_nsecs,\n\t\t\t"
 			"common_pid, common_comm)\n\n");
 
-		fprintf(ofp, "\t\tprint \"");
+		fprintf(ofp, "\t\tprint(\"");
 
 		not_first = 0;
 		count = 0;
@@ -1736,31 +1737,31 @@ static int python_generate_script(struct pevent *pevent, const char *outfile)
 				fprintf(ofp, "%s", f->name);
 		}
 
-		fprintf(ofp, ")\n\n");
+		fprintf(ofp, "))\n\n");
 
-		fprintf(ofp, "\t\tprint 'Sample: {'+"
-			"get_dict_as_string(perf_sample_dict['sample'], ', ')+'}'\n\n");
+		fprintf(ofp, "\t\tprint('Sample: {'+"
+			"get_dict_as_string(perf_sample_dict['sample'], ', ')+'}')\n\n");
 
 		fprintf(ofp, "\t\tfor node in common_callchain:");
 		fprintf(ofp, "\n\t\t\tif 'sym' in node:");
-		fprintf(ofp, "\n\t\t\t\tprint \"\\t[%%x] %%s\" %% (node['ip'], node['sym']['name'])");
+		fprintf(ofp, "\n\t\t\t\tprint(\"\\t[%%x] %%s\" %% (node['ip'], node['sym']['name']))");
 		fprintf(ofp, "\n\t\t\telse:");
-		fprintf(ofp, "\n\t\t\t\tprint \"\t[%%x]\" %% (node['ip'])\n\n");
-		fprintf(ofp, "\t\tprint \"\\n\"\n\n");
+		fprintf(ofp, "\n\t\t\t\tprint(\"\t[%%x]\" %% (node['ip']))\n\n");
+		fprintf(ofp, "\t\tprint()\n\n");
 
 	}
 
 	fprintf(ofp, "def trace_unhandled(event_name, context, "
 		"event_fields_dict, perf_sample_dict):\n");
 
-	fprintf(ofp, "\t\tprint get_dict_as_string(event_fields_dict)\n");
-	fprintf(ofp, "\t\tprint 'Sample: {'+"
-		"get_dict_as_string(perf_sample_dict['sample'], ', ')+'}'\n\n");
+	fprintf(ofp, "\t\tprint(get_dict_as_string(event_fields_dict))\n");
+	fprintf(ofp, "\t\tprint('Sample: {'+"
+		"get_dict_as_string(perf_sample_dict['sample'], ', ')+'}')\n\n");
 
 	fprintf(ofp, "def print_header("
 		"event_name, cpu, secs, nsecs, pid, comm):\n"
-		"\tprint \"%%-20s %%5u %%05u.%%09u %%8u %%-20s \" %% \\\n\t"
-		"(event_name, cpu, secs, nsecs, pid, comm),\n\n");
+		"\tprint(\"%%-20s %%5u %%05u.%%09u %%8u %%-20s \" %% \\\n\t"
+		"(event_name, cpu, secs, nsecs, pid, comm), end=\"\")\n\n");
 
 	fprintf(ofp, "def get_dict_as_string(a_dict, delimiter=' '):\n"
 		"\treturn delimiter.join"
-- 
2.14.4


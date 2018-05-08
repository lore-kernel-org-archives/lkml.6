Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756091AbeEHVaN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 17:30:13 -0400
Received: from a8-53.smtp-out.amazonses.com ([54.240.8.53]:41244 "EHLO
        a8-53.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756020AbeEHV1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 17:27:45 -0400
From: Jeremy Cline <jeremy@jcline.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeremy Cline <jeremy@jcline.org>
Subject: [PATCH 1/8] perf tools: Generate a Python script compatible with Python 2 and 3
Date: Tue, 8 May 2018 21:27:43 +0000
Message-ID: <0100016341a7278a-d178c724-2b0f-49ca-be93-80a7d51aaa0d-000000@email.amazonses.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1525811971.git.jeremy@jcline.org>
References: <cover.1525811971.git.jeremy@jcline.org>
X-SES-Outgoing: 2018.05.08-54.240.8.53
Feedback-ID: 1.us-east-1.z18Isoc/FaoPOvCyJyi1mnTt8STwoRuibXVNoUcvG6g=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 .../scripting-engines/trace-event-python.c    | 29 ++++++++++---------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 10dd5fce082b..01d5f255ef62 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1393,6 +1393,7 @@ static int python_generate_script(struct pevent *pevent, const char *outfile)
 	fprintf(ofp, "# See the perf-script-python Documentation for the list "
 		"of available functions.\n\n");
 
+	fprintf(ofp, "from __future__ import print_function\n\n");
 	fprintf(ofp, "import os\n");
 	fprintf(ofp, "import sys\n\n");
 
@@ -1402,10 +1403,10 @@ static int python_generate_script(struct pevent *pevent, const char *outfile)
 	fprintf(ofp, "from Core import *\n\n\n");
 
 	fprintf(ofp, "def trace_begin():\n");
-	fprintf(ofp, "\tprint \"in trace_begin\"\n\n");
+	fprintf(ofp, "\tprint(\"in trace_begin\")\n\n");
 
 	fprintf(ofp, "def trace_end():\n");
-	fprintf(ofp, "\tprint \"in trace_end\"\n\n");
+	fprintf(ofp, "\tprint(\"in trace_end\")\n\n");
 
 	while ((event = trace_find_next_event(pevent, event))) {
 		fprintf(ofp, "def %s__%s(", event->system, event->name);
@@ -1441,7 +1442,7 @@ static int python_generate_script(struct pevent *pevent, const char *outfile)
 			"common_secs, common_nsecs,\n\t\t\t"
 			"common_pid, common_comm)\n\n");
 
-		fprintf(ofp, "\t\tprint \"");
+		fprintf(ofp, "\t\tprint(\"");
 
 		not_first = 0;
 		count = 0;
@@ -1502,31 +1503,31 @@ static int python_generate_script(struct pevent *pevent, const char *outfile)
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
2.17.0

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752127AbeDILHK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 07:07:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42380 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751676AbeDILHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 07:07:02 -0400
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: acme@redhat.com
Cc: mhiramat@kernel.org, kstewart@linuxfoundation.org, tglx@linutronix.de,
        pombredanne@nexb.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, uneedsihyeon@gmail.com, kjlx@templeofstupid.com,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH 2/3] perf/buildid-cache: Support --list option
Date: Mon,  9 Apr 2018 16:36:32 +0530
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180409110633.20767-1-ravi.bangoria@linux.vnet.ibm.com>
References: <20180409110633.20767-1-ravi.bangoria@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18040911-0040-0000-0000-0000044B4FC7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040911-0041-0000-0000-000020EF7377
Message-Id: <20180409110633.20767-3-ravi.bangoria@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-09_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804090121
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf buildid-cache allows to add/remove files into cache but there
is no option to list all cached files. Add --list option to list
all _valid_ cached files.

Ex,
  # perf buildid-cache --add /tmp/a.out
  # perf buildid-cache -l
    /tmp/a.out (8a86ef73e44067bca52cc3f6cd3e5446c783391c)

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
 tools/perf/Documentation/perf-buildid-cache.txt |  4 ++-
 tools/perf/builtin-buildid-cache.c              | 41 +++++++++++++++++++++++--
 2 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-buildid-cache.txt b/tools/perf/Documentation/perf-buildid-cache.txt
index 73c2650bd0db..3f285ba6e1f9 100644
--- a/tools/perf/Documentation/perf-buildid-cache.txt
+++ b/tools/perf/Documentation/perf-buildid-cache.txt
@@ -59,7 +59,9 @@ OPTIONS
 	exactly same build-id, that is replaced by new one. It can be used
 	to update kallsyms and kernel dso to vmlinux in order to support
 	annotation.
-
+-l::
+--list::
+	List all valid binaries from cache.
 -v::
 --verbose::
 	Be more verbose.
diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index 41db2cba77eb..50db05bd0cc6 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -25,6 +25,7 @@
 #include "util/session.h"
 #include "util/symbol.h"
 #include "util/time-utils.h"
+#include "util/probe-file.h"
 
 static int build_id_cache__kcore_buildid(const char *proc_dir, char *sbuildid)
 {
@@ -297,6 +298,25 @@ static int build_id_cache__update_file(const char *filename, struct nsinfo *nsi)
 	return err;
 }
 
+static void build_id_cache__show_all(void)
+{
+	struct strlist *bidlist;
+	struct str_node *nd;
+	char *buf;
+
+	bidlist = build_id_cache__list_all(true);
+	if (!bidlist) {
+		pr_debug("Failed to get buildids: -%d\n", errno);
+		return;
+	}
+	strlist__for_each_entry(nd, bidlist) {
+		buf = build_id_cache__origname(nd->s);
+		printf("%s (%s)\n", buf, nd->s);
+		free(buf);
+	}
+	strlist__delete(bidlist);
+}
+
 int cmd_buildid_cache(int argc, const char **argv)
 {
 	struct strlist *list;
@@ -304,6 +324,8 @@ int cmd_buildid_cache(int argc, const char **argv)
 	int ret = 0;
 	int ns_id = -1;
 	bool force = false;
+	bool list_files = false;
+	bool opts_flag = false;
 	char const *add_name_list_str = NULL,
 		   *remove_name_list_str = NULL,
 		   *purge_name_list_str = NULL,
@@ -327,6 +349,7 @@ int cmd_buildid_cache(int argc, const char **argv)
 		    "file(s) to remove"),
 	OPT_STRING('p', "purge", &purge_name_list_str, "file list",
 		    "file(s) to remove (remove old caches too)"),
+	OPT_BOOLEAN('l', "list", &list_files, "list all cached files"),
 	OPT_STRING('M', "missing", &missing_filename, "file",
 		   "to find missing build ids in the cache"),
 	OPT_BOOLEAN('f', "force", &force, "don't complain, do it"),
@@ -344,11 +367,18 @@ int cmd_buildid_cache(int argc, const char **argv)
 	argc = parse_options(argc, argv, buildid_cache_options,
 			     buildid_cache_usage, 0);
 
-	if (argc || (!add_name_list_str && !kcore_filename &&
-		     !remove_name_list_str && !purge_name_list_str &&
-		     !missing_filename && !update_name_list_str))
+	opts_flag = add_name_list_str || kcore_filename ||
+		remove_name_list_str || purge_name_list_str ||
+		missing_filename || update_name_list_str;
+
+	if (argc || !(list_files || opts_flag))
 		usage_with_options(buildid_cache_usage, buildid_cache_options);
 
+	/* -l is exclusive. It can not be used with other options. */
+	if (list_files && opts_flag)
+		usage_with_options_msg(buildid_cache_usage,
+			buildid_cache_options, "-l is exclusive.\n");
+
 	if (ns_id > 0)
 		nsi = nsinfo__new(ns_id);
 
@@ -366,6 +396,11 @@ int cmd_buildid_cache(int argc, const char **argv)
 
 	setup_pager();
 
+	if (list_files) {
+		build_id_cache__show_all();
+		goto out;
+	}
+
 	if (add_name_list_str) {
 		list = strlist__new(add_name_list_str, NULL);
 		if (list) {
-- 
2.14.3

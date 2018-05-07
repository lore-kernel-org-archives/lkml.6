Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752755AbeEGSoi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 14:44:38 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:47272 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752352AbeEGSog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 14:44:36 -0400
From: Josh Hunt <johunt@akamai.com>
To: mingo@redhat.com, acme@kernel.org
Cc: peterz@infradead.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, wangnan0@huawei.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, eranian@google.com, Josh Hunt <johunt@akamai.com>
Subject: [PATCH v2] perf tools: allow map files to specify DSO
Date: Mon,  7 May 2018 14:24:16 -0400
Message-Id: <1525717456-21475-1-git-send-email-johunt@akamai.com>
X-Mailer: git-send-email 1.9.1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-07_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805070183
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-07_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1805070183
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ability to specify a DSO in the /tmp/perf-<PID>.map file.
The DSO should be the first line in the file and readable by the
running user. If a valid DSO is found all other contents of the
file will be ignored. This allows things like callchain unwinding
with DWARF to work.

Suggested-by: Wang Nan <wangnan0@huawei.com>
Signed-off-by: Josh Hunt <johunt@akamai.com>
---
We have an application which uses huge pages for its text section, but
still needs the ability to do callchain unwinding with DWARF. We use
the perf-<PID>.map file setup to do symbol resolution and that works
great, but callchain unwinding fails.

A few months ago I mentioned this to Wang Nan and he suggested a way
around this problem could be to specify the path of the DSO in the map
file. The attached patch is my initial hack at this. Running with this
patch I can now get full callchain unwinding with DWARF.

FWIW LBR + map file works with callchains, but unfortunately there are
some cases where we still need DWARF.

I submitted an RFC as an earlier draft:
https://lkml.org/lkml/2018/4/24/1070

v2:
1. Rebase RFC patch to
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
2. Update jit-interface.txt as per Arnaldo's request

 tools/perf/Documentation/jit-interface.txt |  8 +++++---
 tools/perf/util/map.c                      | 32 ++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/jit-interface.txt b/tools/perf/Documentation/jit-interface.txt
index a8656f564915..8a25b979802f 100644
--- a/tools/perf/Documentation/jit-interface.txt
+++ b/tools/perf/Documentation/jit-interface.txt
@@ -3,13 +3,15 @@ by a JIT.
 
 The JIT has to write a /tmp/perf-%d.map  (%d = pid of process) file
 
-This is a text file.
+This is a text file and can have one of the following formats:
 
-Each line has the following format, fields separated with spaces:
+1) Each line has the following format, fields separated with spaces:
 
 START SIZE symbolname
 
 START and SIZE are hex numbers without 0x.
 symbolname is the rest of the line, so it could contain special characters.
 
-The ownership of the file has to match the process.
+2) A single line with the full pathname of the DSO to use.
+
+For both formats, the ownership of the file has to match the process.
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index c8fe836e4c3c..da3050b18e34 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -139,6 +139,31 @@ void map__init(struct map *map, u64 start, u64 end, u64 pgoff, struct dso *dso)
 	refcount_set(&map->refcnt, 1);
 }
 
+static bool replace_anon(char *mapfilename)
+{
+	FILE *file = NULL;
+	bool ret = false;
+
+	file = fopen(mapfilename, "r");
+	if (file != NULL) {
+		char *line = NULL;
+		size_t line_len, linesz=0;
+
+		line_len = getline(&line, &linesz, file);
+		if (line_len > 0) {
+			line[line_len-1] = '\0'; /* null terminate */
+			if (!access(line, R_OK)) {
+				strlcpy(mapfilename, line, line_len);
+				ret = true;
+			}
+		}
+		free(line);
+		fclose(file);
+	}
+
+	return ret;
+}
+
 struct map *map__new(struct machine *machine, u64 start, u64 len,
 		     u64 pgoff, u32 d_maj, u32 d_min, u64 ino,
 		     u64 ino_gen, u32 prot, u32 flags, char *filename,
@@ -170,6 +195,13 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 			snprintf(newfilename, sizeof(newfilename),
 				 "/tmp/perf-%d.map", nsi->pid);
 			filename = newfilename;
+			/*
+			 * Check to see if map file references DSO to use, if so, use it.
+			 */
+			if (anon && replace_anon(newfilename)) {
+				anon = 0;
+				filename = newfilename;
+			}
 		}
 
 		if (android) {
-- 
1.9.1

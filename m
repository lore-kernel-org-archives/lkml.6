Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751794AbeDILHC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 07:07:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59782 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750952AbeDILG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 07:06:58 -0400
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: acme@redhat.com
Cc: mhiramat@kernel.org, kstewart@linuxfoundation.org, tglx@linutronix.de,
        pombredanne@nexb.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, uneedsihyeon@gmail.com, kjlx@templeofstupid.com,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH 1/3] tools/parse-options: Add '\n' at the end of error messages
Date: Mon,  9 Apr 2018 16:36:31 +0530
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180409110633.20767-1-ravi.bangoria@linux.vnet.ibm.com>
References: <20180409110633.20767-1-ravi.bangoria@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18040911-0008-0000-0000-000004E85005
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040911-0009-0000-0000-00001E7B73C0
Message-Id: <20180409110633.20767-2-ravi.bangoria@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-09_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804090121
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few error messages does not have '\n' at the end and thus next
prompt gets printed in the same line. Ex,

  linux~$ perf buildid-cache -verbose --add ./a.out
   Error: did you mean `--verbose` (with two dashes ?)linux~$

Fix it.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
 tools/lib/subcmd/parse-options.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
index f6a1babcbac4..cb7154eccbdc 100644
--- a/tools/lib/subcmd/parse-options.c
+++ b/tools/lib/subcmd/parse-options.c
@@ -433,7 +433,7 @@ static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
 
 	if (ambiguous_option) {
 		 fprintf(stderr,
-			 " Error: Ambiguous option: %s (could be --%s%s or --%s%s)",
+			 " Error: Ambiguous option: %s (could be --%s%s or --%s%s)\n",
 			 arg,
 			 (ambiguous_flags & OPT_UNSET) ?  "no-" : "",
 			 ambiguous_option->long_name,
@@ -458,7 +458,7 @@ static void check_typos(const char *arg, const struct option *options)
 		return;
 
 	if (strstarts(arg, "no-")) {
-		fprintf(stderr, " Error: did you mean `--%s` (with two dashes ?)", arg);
+		fprintf(stderr, " Error: did you mean `--%s` (with two dashes ?)\n", arg);
 		exit(129);
 	}
 
@@ -466,7 +466,7 @@ static void check_typos(const char *arg, const struct option *options)
 		if (!options->long_name)
 			continue;
 		if (strstarts(options->long_name, arg)) {
-			fprintf(stderr, " Error: did you mean `--%s` (with two dashes ?)", arg);
+			fprintf(stderr, " Error: did you mean `--%s` (with two dashes ?)\n", arg);
 			exit(129);
 		}
 	}
-- 
2.14.3

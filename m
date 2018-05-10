Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753870AbeEJEhD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 00:37:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35718 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750854AbeEJEhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 00:37:02 -0400
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To: acme@kernel.org, mhiramat@kernel.org
Cc: jolsa@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH v2] perf buildid-cache: Warn --purge-all failures
Date: Thu, 10 May 2018 10:06:51 +0530
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180510102808.5fcc479ccda0dd0eb08b7383@kernel.org>
References: <20180510102808.5fcc479ccda0dd0eb08b7383@kernel.org>
X-TM-AS-GCONF: 00
x-cbid: 18051004-0008-0000-0000-000004F503E9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051004-0009-0000-0000-00001E894F11
Message-Id: <20180510043651.12189-1-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-10_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805100045
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warn perf buildid-cache --purge-all failures in non verbose mode.
Ex,

  $ sudo chown root:root /home/ravi/.debug -R
  $ sudo chmod 700 /home/ravi/.debug/ -R
  $ ./perf buildid-cache -P
    Couldn't remove some caches. Error: Permission denied.

Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/builtin-buildid-cache.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index 7a7403913b57..ef6b3cc8d57d 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -488,8 +488,12 @@ int cmd_buildid_cache(int argc, const char **argv)
 		}
 	}
 
-	if (purge_all)
-		ret = build_id_cache__purge_all();
+	if (purge_all) {
+		if (build_id_cache__purge_all()) {
+			pr_warning("Couldn't remove some caches. Error: %s.\n",
+				str_error_r(errno, sbuf, sizeof(sbuf)));
+		}
+	}
 
 	if (missing_filename)
 		ret = build_id_cache__fprintf_missing(session, stdout);
-- 
2.14.3

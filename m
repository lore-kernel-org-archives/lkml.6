Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752692AbeDFWSF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 18:18:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35766 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751807AbeDFWR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 18:17:29 -0400
From: Tim Tianyang Chen <tianyang.chen@oracle.com>
To: rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org, dhaval.giani@oracle.com,
        tim.tianyang.chen@alumni.upenn.edu,
        Tim Tianyang Chen <tianyang.chen@oracle.com>
Subject: [PATCH v3 2/4] ktest: add SigInt handling
Date: Fri,  6 Apr 2018 15:17:03 -0700
Message-Id: <1523053025-12424-3-git-send-email-tianyang.chen@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1523053025-12424-1-git-send-email-tianyang.chen@oracle.com>
References: <1523053025-12424-1-git-send-email-tianyang.chen@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8855 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=648
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804060222
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User can cancel tests and specify handler's behavior using option
'EMAIL_WHEN_CANCELED'.

Suggested-by: Dhaval Giani <dhaval.giani@oracle.com>
Signed-off-by: Tim Tianyang Chen <tianyang.chen@oracle.com>
---
 tools/testing/ktest/ktest.pl | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index a9a6318b1395..b0db4a6d3e97 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -4267,6 +4267,16 @@ sub send_email {
     }
 }
 
+sub cancel_test {
+    if ($email_when_canceled) {
+        send_email("KTEST: Your [$test_type] test was cancelled",
+                "Your test started at $script_start_time was cancelled: sig int");
+    }
+    die "\nCaught Sig Int, test interrupted: $!\n"
+}
+
+$SIG{INT} = qw(cancel_test);
+
 # First we need to do is the builds
 for (my $i = 1; $i <= $opt{"NUM_TESTS"}; $i++) {
 
-- 
1.8.3.1

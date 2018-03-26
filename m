Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751732AbeCZUR1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 16:17:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50894 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750983AbeCZUR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 16:17:26 -0400
From: Tim Tianyang Chen <tianyang.chen@oracle.com>
To: rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org, dhaval.giani@oracle.com
Subject: [PATCH v3 2/4] Ktest: add SigInt handling
Date: Mon, 26 Mar 2018 13:08:02 -0700
Message-Id: <1522094884-22718-3-git-send-email-tianyang.chen@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1522094884-22718-1-git-send-email-tianyang.chen@oracle.com>
References: <1522094884-22718-1-git-send-email-tianyang.chen@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8844 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=504
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803260203
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User can cancel tests and specify handler's behavior using option
'EMAIL_WHEN_CANCELED'.

Suggested-by: Dhaval Giani <dhaval.giani@oracle.com>
Signed-off-by: Tim Tianyang Chen <tianyang.chen@oracle.com>
---
 ktest.pl | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/ktest.pl b/ktest.pl
index 9469783bc6c1..8be12ee27d34 100755
--- a/ktest.pl
+++ b/ktest.pl
@@ -4269,6 +4269,16 @@ sub send_email {
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
2.15.1

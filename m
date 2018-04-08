Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753233AbeDHUU5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 16:20:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752821AbeDHUSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 16:18:37 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5AD2217DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180408201835.731168099@goodmis.org>
User-Agent: quilt/0.63-1
Date: Sun, 08 Apr 2018 16:17:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>,
        Scott Wood <swood@redhat.com>,
        Tim Tianyang Chen <tianyang.chen@oracle.com>,
        Dhaval Giani <dhaval.giani@oracle.com>
Subject: [for-next][PATCH 15/23] Ktest: Add SigInt handling
References: <20180408201708.346970379@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0015-Ktest-Add-SigInt-handling.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tim Tianyang Chen <tianyang.chen@oracle.com>

User can cancel tests and specify handler's behavior using option
'EMAIL_WHEN_CANCELED'.

Link: http://lkml.kernel.org/r/1522094884-22718-3-git-send-email-tianyang.chen@oracle.com

Suggested-by: Dhaval Giani <dhaval.giani@oracle.com>
Signed-off-by: Tim Tianyang Chen <tianyang.chen@oracle.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index bb43f8631c95..1646af526089 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -4144,6 +4144,16 @@ sub send_email {
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
2.16.3

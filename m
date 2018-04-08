Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753315AbeDHUVq (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 16:21:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:33968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752755AbeDHUSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 16:18:36 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0FA021851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180408201834.893337032@goodmis.org>
User-Agent: quilt/0.63-1
Date: Sun, 08 Apr 2018 16:17:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>,
        Scott Wood <swood@redhat.com>,
        Tim Tianyang Chen <tianyang.chen@oracle.com>
Subject: [for-next][PATCH 10/23] ktest.pl: Use diffconfig if available for failed config bisects
References: <20180408201708.346970379@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0010-ktest.pl-Use-diffconfig-if-available-for-failed-conf.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Check to see if diffconfig is available and use that to diff the configs
instead of using 'diff -u', as diffconfig produces much better output of
kernel config files. It checks the source directory for the executable.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 79c2f99629de..27505fef2dab 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -3114,10 +3114,14 @@ sub run_config_bisect_test {
 
 sub config_bisect_end {
     my ($good, $bad) = @_;
+    my $diffexec = "diff -u";
 
+    if (-f "$builddir/scripts/diffconfig") {
+	$diffexec = "$builddir/scripts/diffconfig";
+    }
     doprint "\n\n***************************************\n";
     doprint "No more config bisecting possible.\n";
-    doprint `diff -u $good $bad`;
+    run_command "$diffexec $good $bad", 1;
     doprint "***************************************\n\n";
 }
 
-- 
2.16.3

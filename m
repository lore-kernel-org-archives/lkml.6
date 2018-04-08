Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753042AbeDHUSo (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 16:18:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752781AbeDHUSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 16:18:36 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C8CC21852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180408201835.063916215@goodmis.org>
User-Agent: quilt/0.63-1
Date: Sun, 08 Apr 2018 16:17:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>,
        Scott Wood <swood@redhat.com>,
        Tim Tianyang Chen <tianyang.chen@oracle.com>
Subject: [for-next][PATCH 11/23] ktest.pl: Have ktest.pl pass -r to config-bisect.pl to reset bisect
References: <20180408201708.346970379@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0011-ktest.pl-Have-ktest.pl-pass-r-to-config-bisect.pl-to.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

If config-bisect.pl sees that a config_bisect has already been started, it
will ask on the command line if it should bisect or not. This will mess up
running config_bisect from ktest.pl.

Have ktest.pl pass in '-r' to config-bisect.pl and have config-bisect.pl
recognize that to reset without asking.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/config-bisect.pl | 21 ++++++++++++++-------
 tools/testing/ktest/ktest.pl         |  6 +++++-
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/tools/testing/ktest/config-bisect.pl b/tools/testing/ktest/config-bisect.pl
index 37cd796efa2b..b28feea7c363 100755
--- a/tools/testing/ktest/config-bisect.pl
+++ b/tools/testing/ktest/config-bisect.pl
@@ -52,11 +52,11 @@
 
 # If "good" or "bad" is not stated at the end, it will copy the good and
 # bad configs to the .tmp versions. If a .tmp version already exists, it will
-# warn before writing over them. If the last config is labeled "good", then
-# it will copy it to the good .tmp version. If the last config is labeled
-# "bad", it will copy it to the bad .tmp version. It will continue this until
-# it can not merge the two any more without the result being equal to either
-# the good or bad .tmp configs.
+# warn before writing over them (-r will not warn, and just write over them).
+# If the last config is labeled "good", then it will copy it to the good .tmp
+# version. If the last config is labeled "bad", it will copy it to the bad
+# .tmp version. It will continue this until it can not merge the two any more
+# without the result being equal to either the good or bad .tmp configs.
 
 my $start = 0;
 my $val = "";
@@ -67,6 +67,7 @@ my $tree = $pwd;
 my $build;
 
 my $output_config;
+my $reset_bisect;
 
 sub usage {
     print << "EOF"
@@ -654,6 +655,10 @@ while ($#ARGV >= 0) {
 	$tree = $val;
     }
 
+    elsif ($opt eq "-r") {
+	$reset_bisect = 1;
+    }
+
     elsif ($opt eq "-h") {
 	usage;
     }
@@ -721,8 +726,10 @@ if ($start) {
 	    $p = "$p$bad exists\n";
 	}
 
-	if (!read_yn "${p}Overwrite and start new bisect anyway?") {
-	    exit (-1);
+	if (!defined($reset_bisect)) {
+	    if (!read_yn "${p}Overwrite and start new bisect anyway?") {
+		exit (-1);
+	    }
 	}
     }
     run_command "cp $good_start $good" or die "failed to copy to $good\n";
diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 27505fef2dab..fe6a7bb7d7d9 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -3127,10 +3127,14 @@ sub config_bisect_end {
 
 sub run_config_bisect {
     my ($good, $bad, $last_result) = @_;
+    my $reset = "";
     my $cmd;
     my $ret;
 
-    run_command "$builddir/tools/testing/ktest/config-bisect.pl -b $outputdir $good $bad $last_result", 1;
+    if (!length($last_result)) {
+	$reset = "-r";
+    }
+    run_command "$builddir/tools/testing/ktest/config-bisect.pl $reset -b $outputdir $good $bad $last_result", 1;
 
     # config-bisect returns:
     #   0 if there is more to bisect
-- 
2.16.3

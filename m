Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753342AbeDHUVs (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 16:21:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752701AbeDHUSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 16:18:36 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEFB52184F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180408201834.614059672@goodmis.org>
User-Agent: quilt/0.63-1
Date: Sun, 08 Apr 2018 16:17:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>,
        Scott Wood <swood@redhat.com>,
        Tim Tianyang Chen <tianyang.chen@oracle.com>
Subject: [for-next][PATCH 09/23] ktest.pl: Allow for the config-bisect.pl output to display to console
References: <20180408201708.346970379@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0009-ktest.pl-Allow-for-the-config-bisect.pl-output-to-di.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

When commands are run in ktest, they are only displayed in the ktest log
file, but that is not sufficient for outputting the display for config
bisects. The result of a config bisect is not shown.

Add a way to display the output of "run_command" which is the subroutine
used by ktest to execute commands. Use this feature to display the output of
config-bisect.pl executions to see the progress as well as the result.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index ad00ce699749..79c2f99629de 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -1692,6 +1692,7 @@ sub run_command {
     my $end_time;
     my $dolog = 0;
     my $dord = 0;
+    my $dostdout = 0;
     my $pid;
 
     $command =~ s/\$SSH_USER/$ssh_user/g;
@@ -1710,9 +1711,15 @@ sub run_command {
     }
 
     if (defined($redirect)) {
-	open (RD, ">$redirect") or
-	    dodie "failed to write to redirect $redirect";
-	$dord = 1;
+	if ($redirect eq 1) {
+	    $dostdout = 1;
+	    # Have the output of the command on its own line
+	    doprint "\n";
+	} else {
+	    open (RD, ">$redirect") or
+		dodie "failed to write to redirect $redirect";
+	    $dord = 1;
+	}
     }
 
     my $hit_timeout = 0;
@@ -1734,6 +1741,7 @@ sub run_command {
 	}
 	print LOG $line if ($dolog);
 	print RD $line if ($dord);
+	print $line if ($dostdout);
     }
 
     waitpid($pid, 0);
@@ -3118,7 +3126,7 @@ sub run_config_bisect {
     my $cmd;
     my $ret;
 
-    run_command "$builddir/tools/testing/ktest/config-bisect.pl -b $outputdir $good $bad $last_result";
+    run_command "$builddir/tools/testing/ktest/config-bisect.pl -b $outputdir $good $bad $last_result", 1;
 
     # config-bisect returns:
     #   0 if there is more to bisect
-- 
2.16.3

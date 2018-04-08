Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752967AbeDHUSk (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 16:18:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:33912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752077AbeDHUSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 16:18:35 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E4F2183A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180408201833.524977350@goodmis.org>
User-Agent: quilt/0.63-1
Date: Sun, 08 Apr 2018 16:17:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>,
        Scott Wood <swood@redhat.com>,
        Tim Tianyang Chen <tianyang.chen@oracle.com>
Subject: [for-next][PATCH 02/23] ktest: Add CONNECT_TIMEOUT to change the connection timeout time
References: <20180408201708.346970379@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0002-ktest-Add-CONNECT_TIMEOUT-to-change-the-connection-t.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Before ktest issues a reboot, it will try to connect to the target machine
to make sure that it is still alive. If the target does not respond within 5
seconds, it will power cycle the box instead of issuing a reboot.

Five seconds may be too short, and ktest may unnecessarially power cycle the
box. I have found 25 seconds seems to be a better timeout for this purpose.
But even 25 may be too arbitrary. Add a CONNECT_TIMEOUT option to let the
user determine the timeout time before rebooting. By default, it has been
raised to 25 seconds.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl    | 7 +++++--
 tools/testing/ktest/sample.conf | 7 +++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 4eece2a9772c..a959b6f79ce5 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -59,6 +59,7 @@ my %default = (
     "GRUB_REBOOT"		=> "grub2-reboot",
     "SYSLINUX"			=> "extlinux",
     "SYSLINUX_PATH"		=> "/boot/extlinux",
+    "CONNECT_TIMEOUT"		=> 25,
 
 # required, and we will ask users if they don't have them but we keep the default
 # value something that is common.
@@ -163,6 +164,7 @@ my $store_failures;
 my $store_successes;
 my $test_name;
 my $timeout;
+my $connect_timeout;
 my $booted_timeout;
 my $detect_triplefault;
 my $console;
@@ -296,6 +298,7 @@ my %option_map = (
     "STORE_SUCCESSES"		=> \$store_successes,
     "TEST_NAME"			=> \$test_name,
     "TIMEOUT"			=> \$timeout,
+    "CONNECT_TIMEOUT"		=> \$connect_timeout,
     "BOOTED_TIMEOUT"		=> \$booted_timeout,
     "CONSOLE"			=> \$console,
     "CLOSE_CONSOLE_SIGNAL"	=> \$close_console_signal,
@@ -1328,8 +1331,8 @@ sub reboot {
     my ($time) = @_;
     my $powercycle = 0;
 
-    # test if the machine can be connected to within 5 seconds
-    my $stat = run_ssh("echo check machine status", 5);
+    # test if the machine can be connected to within a few seconds
+    my $stat = run_ssh("echo check machine status", $connect_timeout);
     if (!$stat) {
 	doprint("power cycle\n");
 	$powercycle = 1;
diff --git a/tools/testing/ktest/sample.conf b/tools/testing/ktest/sample.conf
index 6c58cd8bbbae..8df62c837dd1 100644
--- a/tools/testing/ktest/sample.conf
+++ b/tools/testing/ktest/sample.conf
@@ -725,6 +725,13 @@
 # (default 120)
 #TIMEOUT = 120
 
+# The timeout in seconds when to test if the box can be rebooted
+# or not. Before issuing the reboot command, a ssh connection
+# is attempted to see if the target machine is still active.
+# If the target does not connect within this timeout, a power cycle
+# is issued instead of a reboot.
+# CONNECT_TIMEOUT = 25
+
 # In between tests, a reboot of the box may occur, and this
 # is the time to wait for the console after it stops producing
 # output. Some machines may not produce a large lag on reboot
-- 
2.16.3

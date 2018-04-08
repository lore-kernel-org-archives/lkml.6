Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753298AbeDHUVp (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 16:21:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752489AbeDHUSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 16:18:36 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5268321855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180408201835.230817505@goodmis.org>
User-Agent: quilt/0.63-1
Date: Sun, 08 Apr 2018 16:17:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>,
        Scott Wood <swood@redhat.com>,
        Tim Tianyang Chen <tianyang.chen@oracle.com>
Subject: [for-next][PATCH 12/23] ktest.pl: Make finding config-bisect.pl dynamic
References: <20180408201708.346970379@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0012-ktest.pl-Make-finding-config-bisect.pl-dynamic.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Just looking for config-bisect.pl in the source tree can be risky,
especially, if the source tree being tested doesn't have config-bisect.pl in
place. Instead, allow the user to set where to find config-bisect.pl with a
new option CONFIG_BISECT_EXEC.

If this option is not set, by default, ktest.pl will look for
config-bisect.pl in the following locations:

 `pwd`/config-bisect.pl # where ktest.pl was called from
 `dirname /path/to/ktest.pl`/config-bisect.pl # where ktest.pl exists
 ${BUILD_DIR}/tools/testing/ktest/config-bisect.pl
   # where config-bisect.pl exists in the source tree.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl    | 27 ++++++++++++++++++++++++++-
 tools/testing/ktest/sample.conf | 10 ++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index fe6a7bb7d7d9..e04422d8f844 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -10,6 +10,7 @@ use Fcntl qw(F_GETFL F_SETFL O_NONBLOCK);
 use File::Path qw(mkpath);
 use File::Copy qw(cp);
 use FileHandle;
+use FindBin;
 
 my $VERSION = "0.2";
 
@@ -165,6 +166,7 @@ my $store_successes;
 my $test_name;
 my $timeout;
 my $connect_timeout;
+my $config_bisect_exec;
 my $booted_timeout;
 my $detect_triplefault;
 my $console;
@@ -206,6 +208,9 @@ my $install_time;
 my $reboot_time;
 my $test_time;
 
+my $pwd;
+my $dirname = $FindBin::Bin;
+
 # set when a test is something other that just building or install
 # which would require more options.
 my $buildonly = 1;
@@ -299,6 +304,7 @@ my %option_map = (
     "TEST_NAME"			=> \$test_name,
     "TIMEOUT"			=> \$timeout,
     "CONNECT_TIMEOUT"		=> \$connect_timeout,
+    "CONFIG_BISECT_EXEC"	=> \$config_bisect_exec,
     "BOOTED_TIMEOUT"		=> \$booted_timeout,
     "CONSOLE"			=> \$console,
     "CLOSE_CONSOLE_SIGNAL"	=> \$close_console_signal,
@@ -340,6 +346,7 @@ my %used_options;
 
 # default variables that can be used
 chomp ($variable{"PWD"} = `pwd`);
+$pwd = $variable{"PWD"};
 
 $config_help{"MACHINE"} = << "EOF"
  The machine hostname that you will test.
@@ -3134,7 +3141,7 @@ sub run_config_bisect {
     if (!length($last_result)) {
 	$reset = "-r";
     }
-    run_command "$builddir/tools/testing/ktest/config-bisect.pl $reset -b $outputdir $good $bad $last_result", 1;
+    run_command "$config_bisect_exec $reset -b $outputdir $good $bad $last_result", 1;
 
     # config-bisect returns:
     #   0 if there is more to bisect
@@ -3182,6 +3189,24 @@ sub config_bisect {
 	$good_config = $output_config;
     }
 
+    if (!defined($config_bisect_exec)) {
+	# First check the location that ktest.pl ran
+	my @locations = ( "$pwd/config-bisect.pl",
+			  "$dirname/config-bisect.pl",
+			  "$builddir/tools/testing/ktest/config-bisect.pl",
+			  undef );
+	foreach my $loc (@locations) {
+	    doprint "loc = $loc\n";
+	    $config_bisect_exec = $loc;
+	    last if (defined($config_bisect_exec && -x $config_bisect_exec));
+	}
+	if (!defined($config_bisect_exec)) {
+	    fail "Could not find an executable config-bisect.pl\n",
+		"  Set CONFIG_BISECT_EXEC to point to config-bisect.pl";
+	    return 1;
+	}
+    }
+
     # we don't want min configs to cause issues here.
     doprint "Disabling 'MIN_CONFIG' for this test\n";
     undef $minconfig;
diff --git a/tools/testing/ktest/sample.conf b/tools/testing/ktest/sample.conf
index 695983a72465..f5b58addb1d1 100644
--- a/tools/testing/ktest/sample.conf
+++ b/tools/testing/ktest/sample.conf
@@ -1179,6 +1179,16 @@
 #  Set it to "good" to test only the good config and set it
 #  to "bad" to only test the bad config.
 #
+# CONFIG_BISECT_EXEC (optional)
+#  The config bisect is a separate program that comes with ktest.pl.
+#  By befault, it will look for:
+#    `pwd`/config-bisect.pl # the location ktest.pl was executed from.
+#  If it does not find it there, it will look for:
+#    `dirname <ktest.pl>`/config-bisect.pl # The directory that holds ktest.pl
+#  If it does not find it there, it will look for:
+#    ${BUILD_DIR}/tools/testing/ktest/config-bisect.pl
+#  Setting CONFIG_BISECT_EXEC will override where it looks.
+#
 # Example:
 #   TEST_START
 #   TEST_TYPE = config_bisect
-- 
2.16.3

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753252AbeDHUU6 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 16:20:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752809AbeDHUSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 16:18:37 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A792183A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180408201835.559488633@goodmis.org>
User-Agent: quilt/0.63-1
Date: Sun, 08 Apr 2018 16:17:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>,
        Scott Wood <swood@redhat.com>,
        Tim Tianyang Chen <tianyang.chen@oracle.com>,
        Dhaval Giani <dhaval.giani@oracle.com>
Subject: [for-next][PATCH 14/23] Ktest: Add email support
References: <20180408201708.346970379@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0014-Ktest-Add-email-support.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tim Tianyang Chen <tianyang.chen@oracle.com>

Users can define optional variables to get email notifications.
Ktest can send emails when the script:
 * was started
 * failed with fatal errors and called dodie()
 * completed all testing

Users have to setup the mailer provided in config prior to using this script.
Supported mailers: mailx, mail, sendmail
mailer specific routines are _sendmail_send(), _mailx_send()

Link: http://lkml.kernel.org/r/1522094884-22718-2-git-send-email-tianyang.chen@oracle.com

Suggested-by: Dhaval Giani <dhaval.giani@oracle.com>
Signed-off-by: Tim Tianyang Chen <tianyang.chen@oracle.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 61 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index d4b22b5c425b..bb43f8631c95 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -23,6 +23,11 @@ my %evals;
 
 #default opts
 my %default = (
+    "MAILER"				=> "sendmail",  # default mailer
+    "EMAIL_ON_ERROR"		=> 1,
+    "EMAIL_WHEN_FINISHED"	=> 1,
+    "EMAIL_WHEN_CANCELED"	=> 0,
+    "EMAIL_WHEN_STARTED"	=> 0,
     "NUM_TESTS"			=> 1,
     "TEST_TYPE"			=> "build",
     "BUILD_TYPE"		=> "randconfig",
@@ -211,6 +216,15 @@ my $test_time;
 my $pwd;
 my $dirname = $FindBin::Bin;
 
+my $mailto;
+my $mailer;
+my $email_on_error;
+my $email_when_finished;
+my $email_when_started;
+my $email_when_canceled;
+
+my $script_start_time = localtime();
+
 # set when a test is something other that just building or install
 # which would require more options.
 my $buildonly = 1;
@@ -236,6 +250,12 @@ my $no_reboot = 1;
 my $reboot_success = 0;
 
 my %option_map = (
+    "MAILTO"				=> \$mailto,
+    "MAILER"				=> \$mailer,
+    "EMAIL_ON_ERROR"		=> \$email_on_error,
+    "EMAIL_WHEN_FINISHED"	=> \$email_when_finished,
+    "EMAIL_WHEN_STARTED"	=> \$email_when_started,
+    "EMAIL_WHEN_CANCELED"	=> \$email_when_canceled,
     "MACHINE"			=> \$machine,
     "SSH_USER"			=> \$ssh_user,
     "TMP_DIR"			=> \$tmpdir,
@@ -1430,6 +1450,11 @@ sub dodie {
 	print " See $opt{LOG_FILE} for more info.\n";
     }
 
+    if ($email_on_error) {
+        send_email("KTEST: critical failure for your [$test_type] test",
+                "Your test started at $script_start_time has failed with:\n@_\n");
+    }
+
     if ($monitor_cnt) {
 	    # restore terminal settings
 	    system("stty $stty_orig");
@@ -4099,6 +4124,26 @@ sub set_test_option {
     return eval_option($name, $option, $i);
 }
 
+sub _mailx_send {
+    my ($subject, $message) = @_;
+    system("$mailer -s \'$subject\' $mailto <<< \'$message\'");
+}
+
+sub _sendmail_send {
+    my ($subject, $message) = @_;
+    system("echo -e \"Subject: $subject\n\n$message\" | sendmail -t $mailto");
+}
+
+sub send_email {
+    if (defined($mailto) && defined($mailer)) {
+        if ($mailer eq "mail" || $mailer eq "mailx"){ _mailx_send(@_);}
+        elsif ($mailer eq "sendmail" ) { _sendmail_send(@_);}
+        else { doprint "\nYour mailer: $mailer is not supported.\n" }
+    } else {
+        print "No email sent: email or mailer not specified in config.\n"
+    }
+}
+
 # First we need to do is the builds
 for (my $i = 1; $i <= $opt{"NUM_TESTS"}; $i++) {
 
@@ -4139,9 +4184,15 @@ for (my $i = 1; $i <= $opt{"NUM_TESTS"}; $i++) {
     $start_minconfig_defined = 1;
 
     # The first test may override the PRE_KTEST option
-    if (defined($pre_ktest) && $i == 1) {
-	doprint "\n";
-	run_command $pre_ktest;
+    if ($i == 1) {
+        if (defined($pre_ktest)) {
+            doprint "\n";
+            run_command $pre_ktest;
+        }
+        if ($email_when_started) {
+            send_email("KTEST: Your [$test_type] test was started",
+                "Your test was started on $script_start_time");
+        }
     }
 
     # Any test can override the POST_KTEST option
@@ -4305,4 +4356,8 @@ if ($opt{"POWEROFF_ON_SUCCESS"}) {
 
 doprint "\n    $successes of $opt{NUM_TESTS} tests were successful\n\n";
 
+if ($email_when_finished) {
+    send_email("KTEST: Your [$test_type] test has finished!",
+            "$successes of $opt{NUM_TESTS} tests started at $script_start_time were successful!");
+}
 exit 0;
-- 
2.16.3

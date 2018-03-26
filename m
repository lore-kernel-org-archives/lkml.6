Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752004AbeCZUIy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 16:08:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35836 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751107AbeCZUIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 16:08:52 -0400
From: Tim Tianyang Chen <tianyang.chen@oracle.com>
To: rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org, dhaval.giani@oracle.com
Subject: [PATCH v3 1/4] Ktest: add email support
Date: Mon, 26 Mar 2018 13:08:01 -0700
Message-Id: <1522094884-22718-2-git-send-email-tianyang.chen@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1522094884-22718-1-git-send-email-tianyang.chen@oracle.com>
References: <1522094884-22718-1-git-send-email-tianyang.chen@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8844 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803260203
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users can define optional variables to get email notifications.
Ktest can send emails when the script:
 * was started
 * failed with fatal errors and called dodie()
 * completed all testing

Users have to setup the mailer provided in config prior to using this script.
Supported mailers: mailx, mail, sendmail
mailer specific routines are _sendmail_send(), _mailx_send()

Suggested-by: Dhaval Giani <dhaval.giani@oracle.com>
Signed-off-by: Tim Tianyang Chen <tianyang.chen@oracle.com>

---
    changes since v2:
    coding style fix for option maps and if statements
	moved sig int handeling to another patch
    changes since v1:
    added options for when to send emails to option_map
---
 ktest.pl | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/ktest.pl b/ktest.pl
index 0c8b61f8398e..9469783bc6c1 100755
--- a/ktest.pl
+++ b/ktest.pl
@@ -22,6 +22,11 @@ my %evals;
 
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
@@ -204,6 +209,15 @@ my $install_time;
 my $reboot_time;
 my $test_time;
 
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
@@ -229,6 +243,12 @@ my $no_reboot = 1;
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
@@ -1426,6 +1446,11 @@ sub dodie {
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
@@ -4224,6 +4249,26 @@ sub set_test_option {
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
 
@@ -4264,9 +4309,15 @@ for (my $i = 1; $i <= $opt{"NUM_TESTS"}; $i++) {
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
@@ -4430,4 +4481,8 @@ if ($opt{"POWEROFF_ON_SUCCESS"}) {
 
 doprint "\n    $successes of $opt{NUM_TESTS} tests were successful\n\n";
 
+if ($email_when_finished) {
+    send_email("KTEST: Your [$test_type] test has finished!",
+            "$successes of $opt{NUM_TESTS} tests started at $script_start_time were successful!");
+}
 exit 0;
-- 
2.15.1

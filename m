Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753079AbeDHUT2 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 16:19:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752939AbeDHUSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 16:18:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E432521840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180408201837.758159465@goodmis.org>
User-Agent: quilt/0.63-1
Date: Sun, 08 Apr 2018 16:17:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>,
        Scott Wood <swood@redhat.com>,
        Tim Tianyang Chen <tianyang.chen@oracle.com>
Subject: [for-next][PATCH 23/23] ktest.pl: Add MAIL_COMMAND option to define how to send email
References: <20180408201708.346970379@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0023-ktest.pl-Add-MAIL_COMMAND-option-to-define-how-to-se.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Allow the user to override the default way to send email. This will allow
the user to add their own mailer and format for sending email.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl    | 54 ++++++++++++++++++++++++++---------------
 tools/testing/ktest/sample.conf | 12 +++++++++
 2 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index f487f91ccf03..a14fc309d140 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -219,6 +219,7 @@ my $dirname = $FindBin::Bin;
 my $mailto;
 my $mailer;
 my $mail_path;
+my $mail_command;
 my $email_on_error;
 my $email_when_finished;
 my $email_when_started;
@@ -254,6 +255,7 @@ my %option_map = (
     "MAILTO"			=> \$mailto,
     "MAILER"			=> \$mailer,
     "MAIL_PATH"			=> \$mail_path,
+    "MAIL_COMMAND"		=> \$mail_command,
     "EMAIL_ON_ERROR"		=> \$email_on_error,
     "EMAIL_WHEN_FINISHED"	=> \$email_when_finished,
     "EMAIL_WHEN_STARTED"	=> \$email_when_started,
@@ -4133,16 +4135,6 @@ sub set_test_option {
     return eval_option($name, $option, $i);
 }
 
-sub _mailx_send {
-    my ($subject, $message) = @_;
-    run_command "$mail_path/$mailer -s \'$subject\' $mailto <<< \'$message\'";
-}
-
-sub _sendmail_send {
-    my ($subject, $message) = @_;
-    run_command "echo \'Subject: $subject\n\n$message\' | $mail_path/sendmail -t $mailto";
-}
-
 sub find_mailer {
     my ($mailer) = @_;
 
@@ -4160,22 +4152,44 @@ sub find_mailer {
     return undef;
 }
 
+sub do_send_mail {
+    my ($subject, $message) = @_;
+
+    if (!defined($mail_path)) {
+	# find the mailer
+	$mail_path = find_mailer $mailer;
+	if (!defined($mail_path)) {
+	    die "\nCan not find $mailer in PATH\n";
+	}
+    }
+
+    if (!defined($mail_command)) {
+	if ($mailer eq "mail" || $mailer eq "mailx") {
+	    $mail_command = "\$MAIL_PATH/\$MAILER -s \'\$SUBJECT\' \$MAILTO <<< \'\$MESSAGE\'";
+	} elsif ($mailer eq "sendmail" ) {
+	    $mail_command =  "echo \'Subject: \$SUBJECT\n\n\$MESSAGE\' | \$MAIL_PATH/\$MAILER -t \$MAILTO";
+	} else {
+	    die "\nYour mailer: $mailer is not supported.\n";
+	}
+    }
+
+    $mail_command =~ s/\$MAILER/$mailer/g;
+    $mail_command =~ s/\$MAIL_PATH/$mail_path/g;
+    $mail_command =~ s/\$MAILTO/$mailto/g;
+    $mail_command =~ s/\$SUBJECT/$subject/g;
+    $mail_command =~ s/\$MESSAGE/$message/g;
+
+    run_command $mail_command;
+}
+
 sub send_email {
+
     if (defined($mailto)) {
 	if (!defined($mailer)) {
 	    doprint "No email sent: email or mailer not specified in config.\n";
 	    return;
 	}
-	if (!defined($mail_path)) {
-	    # find the mailer
-	    $mail_path = find_mailer $mailer;
-	    if (!defined($mail_path)) {
-		die "\nCan not find $mailer in PATH\n";
-	    }
-	}
-        if ($mailer eq "mail" || $mailer eq "mailx"){ _mailx_send(@_);}
-        elsif ($mailer eq "sendmail" ) { _sendmail_send(@_);}
-        else { die "\nYour mailer: $mailer is not supported.\n" }
+	do_send_mail @_;
     }
 }
 
diff --git a/tools/testing/ktest/sample.conf b/tools/testing/ktest/sample.conf
index 86e7cffc45c0..6ca6ca0ce695 100644
--- a/tools/testing/ktest/sample.conf
+++ b/tools/testing/ktest/sample.conf
@@ -415,6 +415,18 @@
 # (default: for sendmail "/usr/sbin/sendmail", otherwise equals ${MAILER})
 #MAIL_EXEC = /usr/sbin/sendmail
 #
+# The command used to send mail, which uses the above options
+# can be modified. By default if the mailer is "sendmail" then
+#  MAIL_COMMAND = echo \'Subject: $SUBJECT\n\n$MESSAGE\' | $MAIL_PATH/$MAILER -t $MAILTO
+# For mail or mailx:
+#  MAIL_COMMAND = "$MAIL_PATH/$MAILER -s \'$SUBJECT\' $MAILTO <<< \'$MESSAGE\'
+# ktest.pl will do the substitution for MAIL_PATH, MAILER, MAILTO at the time
+#    it sends the mail if "$FOO" format is used. If "${FOO}" format is used,
+#    then the substitutions will occur at the time the config file is read.
+#    But note, MAIL_PATH and MAILER require being set by the config file if
+#     ${MAIL_PATH} or ${MAILER} are used, but not if $MAIL_PATH or $MAILER are.
+#MAIL_COMMAND = echo \'Subject: $SUBJECT\n\n$MESSAGE\' | $MAIL_PATH/$MAILER -t $MAILTO
+#
 # Errors are defined as those would terminate the script
 # (default 1)
 #EMAIL_ON_ERROR = 1
-- 
2.16.3

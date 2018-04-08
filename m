Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753167AbeDHUUO (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 16:20:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752914AbeDHUSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 16:18:38 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF0CE2183E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180408201836.731215096@goodmis.org>
User-Agent: quilt/0.63-1
Date: Sun, 08 Apr 2018 16:17:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>,
        Scott Wood <swood@redhat.com>,
        Tim Tianyang Chen <tianyang.chen@oracle.com>
Subject: [for-next][PATCH 19/23] ktest.pl: Add MAIL_PATH option to define where to find the mailer
References: <20180408201708.346970379@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0019-ktest.pl-Add-MAIL_PATH-option-to-define-where-to-fin.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The option MAIL_PATH lets the user decide how to find the mailer they are
using. For example, sendmail is usually located in /usr/sbin but is not
always in the path of non admin users. Have ktest look through the user's
PATH environment variable (adding /usr/sbin) as well, but if that's not good
enough, allow the user to define where to find the mailer.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

squash to mail exec

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl    | 36 +++++++++++++++++++++++++++++++-----
 tools/testing/ktest/sample.conf |  4 ++++
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 07d0a47816e4..637545bd9e98 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -23,7 +23,7 @@ my %evals;
 
 #default opts
 my %default = (
-    "MAILER"				=> "sendmail",  # default mailer
+    "MAILER"			=> "sendmail",  # default mailer
     "EMAIL_ON_ERROR"		=> 1,
     "EMAIL_WHEN_FINISHED"	=> 1,
     "EMAIL_WHEN_CANCELED"	=> 0,
@@ -218,6 +218,7 @@ my $dirname = $FindBin::Bin;
 
 my $mailto;
 my $mailer;
+my $mail_path;
 my $email_on_error;
 my $email_when_finished;
 my $email_when_started;
@@ -250,8 +251,9 @@ my $no_reboot = 1;
 my $reboot_success = 0;
 
 my %option_map = (
-    "MAILTO"				=> \$mailto,
-    "MAILER"				=> \$mailer,
+    "MAILTO"			=> \$mailto,
+    "MAILER"			=> \$mailer,
+    "MAIL_PATH"			=> \$mail_path,
     "EMAIL_ON_ERROR"		=> \$email_on_error,
     "EMAIL_WHEN_FINISHED"	=> \$email_when_finished,
     "EMAIL_WHEN_STARTED"	=> \$email_when_started,
@@ -4126,12 +4128,29 @@ sub set_test_option {
 
 sub _mailx_send {
     my ($subject, $message) = @_;
-    system("$mailer -s \'$subject\' $mailto <<< \'$message\'");
+    system("$mail_path/$mailer -s \'$subject\' $mailto <<< \'$message\'");
 }
 
 sub _sendmail_send {
     my ($subject, $message) = @_;
-    system("echo -e \"Subject: $subject\n\n$message\" | sendmail -t $mailto");
+    system("echo -e \"Subject: $subject\n\n$message\" | $mail_path/sendmail -t $mailto");
+}
+
+sub find_mailer {
+    my ($mailer) = @_;
+
+    my @paths = split /:/, $ENV{PATH};
+
+    # sendmail is usually in /usr/sbin
+    $paths[$#paths + 1] = "/usr/sbin";
+
+    foreach my $path (@paths) {
+	if (-x "$path/$mailer") {
+	    return $path;
+	}
+    }
+
+    return undef;
 }
 
 sub send_email {
@@ -4140,6 +4159,13 @@ sub send_email {
 	    doprint "No email sent: email or mailer not specified in config.\n";
 	    return;
 	}
+	if (!defined($mail_path)) {
+	    # find the mailer
+	    $mail_path = find_mailer $mailer;
+	    if (!defined($mail_path)) {
+		die "\nCan not find $mailer in PATH\n";
+	    }
+	}
         if ($mailer eq "mail" || $mailer eq "mailx"){ _mailx_send(@_);}
         elsif ($mailer eq "sendmail" ) { _sendmail_send(@_);}
         else { doprint "\nYour mailer: $mailer is not supported.\n" }
diff --git a/tools/testing/ktest/sample.conf b/tools/testing/ktest/sample.conf
index d1a2626aaa0a..86e7cffc45c0 100644
--- a/tools/testing/ktest/sample.conf
+++ b/tools/testing/ktest/sample.conf
@@ -411,6 +411,10 @@
 # (default sendmail)
 #MAILER = sendmail
 #
+# The executable to run
+# (default: for sendmail "/usr/sbin/sendmail", otherwise equals ${MAILER})
+#MAIL_EXEC = /usr/sbin/sendmail
+#
 # Errors are defined as those would terminate the script
 # (default 1)
 #EMAIL_ON_ERROR = 1
-- 
2.16.3

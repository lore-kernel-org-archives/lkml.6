Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752713AbeDFWle (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 18:41:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752586AbeDFWld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 18:41:33 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 417A9208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 6 Apr 2018 18:41:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tim Tianyang Chen <tianyang.chen@oracle.com>
Cc: linux-kernel@vger.kernel.org, dhaval.giani@oracle.com
Subject: Re: [PATCH v3 1/4] Ktest: add email support
Message-ID: <20180406184130.6809805c@gandalf.local.home>
In-Reply-To: <e0646238-e991-61c6-c32f-eee07742073c@oracle.com>
References: <1522094884-22718-1-git-send-email-tianyang.chen@oracle.com>
        <1522094884-22718-2-git-send-email-tianyang.chen@oracle.com>
        <20180406142409.6d98254b@gandalf.local.home>
        <e0646238-e991-61c6-c32f-eee07742073c@oracle.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Apr 2018 15:19:48 -0700
Tim Tianyang Chen <tianyang.chen@oracle.com> wrote:


> > The full path name needs to be here.
> >
> >   tools/testing/ktest/ktest.pl
> >  
> Sorry I was working on my private folder, version tracked with other 
> stuff. Just re-sent them.

I just fixed them up and pulled them in myself. ;-)

I also added the following on top of them (and testing this, live while
testing ftrace patches and other builds).

-- Steve

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 30a4c053f98b..837fa75cbb47 100755
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
+my $mail_exec;
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
+    "MAIL_EXEC"			=> \$mail_exec,
     "EMAIL_ON_ERROR"		=> \$email_on_error,
     "EMAIL_WHEN_FINISHED"	=> \$email_when_finished,
     "EMAIL_WHEN_STARTED"	=> \$email_when_started,
@@ -1431,7 +1433,14 @@ sub do_not_reboot {
 	($test_type eq "config_bisect" && $opt{"CONFIG_BISECT_TYPE[$i]"} eq "build");
 }
 
+my $in_die = 0;
+
 sub dodie {
+
+    # avoid recusion
+    return if ($in_die);
+    $in_die = 1;
+
     doprint "CRITICAL FAILURE... ", @_, "\n";
 
     my $i = $iteration;
@@ -4126,21 +4135,31 @@ sub set_test_option {
 
 sub _mailx_send {
     my ($subject, $message) = @_;
-    system("$mailer -s \'$subject\' $mailto <<< \'$message\'");
+
+    if (!defined($mail_exec)) {
+	$mail_exec = $mailer;
+    }
+    run_command "$mail_exec -s \'$subject\' $mailto <<< \'$message\'";
 }
 
 sub _sendmail_send {
     my ($subject, $message) = @_;
-    system("echo -e \"Subject: $subject\n\n$message\" | sendmail -t $mailto");
+
+    if (!defined($mail_exec)) {
+	$mail_exec = "/usr/sbin/sendmail";
+    }
+    run_command "echo \'Subject: $subject\n\n$message\' | $mail_exec -t $mailto";
 }
 
 sub send_email {
-    if (defined($mailto) && defined($mailer)) {
+    if (defined($mailto)) {
+	if (!defined($mailer)) {
+	    doprint "No email sent: email or mailer not specified in config.\n";
+	    return;
+	}
         if ($mailer eq "mail" || $mailer eq "mailx"){ _mailx_send(@_);}
         elsif ($mailer eq "sendmail" ) { _sendmail_send(@_);}
-        else { doprint "\nYour mailer: $mailer is not supported.\n" }
-    } else {
-        print "No email sent: email or mailer not specified in config.\n"
+        else { die "\nYour mailer: $mailer is not supported.\n" }
     }
 }
 
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

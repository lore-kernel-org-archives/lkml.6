Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752248AbeDGWvy (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 18:51:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:42320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752054AbeDGWvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 18:51:53 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC4E20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Sat, 7 Apr 2018 18:51:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tim Tianyang Chen <tianyang.chen@oracle.com>
Cc: linux-kernel@vger.kernel.org, dhaval.giani@oracle.com
Subject: Re: [PATCH v3 1/4] Ktest: add email support
Message-ID: <20180407185150.461d9a52@gandalf.local.home>
In-Reply-To: <d9720e54-4207-abf6-2ac2-b94ac847674e@oracle.com>
References: <1522094884-22718-1-git-send-email-tianyang.chen@oracle.com>
        <1522094884-22718-2-git-send-email-tianyang.chen@oracle.com>
        <20180406142409.6d98254b@gandalf.local.home>
        <e0646238-e991-61c6-c32f-eee07742073c@oracle.com>
        <20180406184130.6809805c@gandalf.local.home>
        <d9720e54-4207-abf6-2ac2-b94ac847674e@oracle.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Apr 2018 16:09:28 -0700
Tim Tianyang Chen <tianyang.chen@oracle.com> wrote:


> >   sub _sendmail_send {
> >       my ($subject, $message) = @_;
> > -    system("echo -e \"Subject: $subject\n\n$message\" | sendmail -t $mailto");
> > +
> > +    if (!defined($mail_exec)) {
> > +	$mail_exec = "/usr/sbin/sendmail";
> > +    }
> > +    run_command "echo \'Subject: $subject\n\n$message\' | $mail_exec -t $mailto";
> >   }
> >   
> Not sure if I understand why $mail_exec is necessary. Doesn't $mailer 
> already have a default? Wouldn't people just use $mailer to define the 
> executable they want to use? What if the $mailx_exec specified doesn't 
> use '-t' option?

sendmail isn't in my path, I had to specify the path name to find it.
Hmm, we could have "MAILER_PATH" to find it. I can change that.

Actually, what we should also add is the format to print it out.

MAIL_COMMAND = echo \'Subject: $SUBJECT\n\n$MESSAGE\' | sendmail -t ${MAILTO}

Note the difference between $SUBJECT, $MESSAGE and ${MAILTO}. When we
have ${FOO} that is a variable the user controls. But $FOO is a
variable that is hard coded for certain commands.

That may be better to have.

Here's my latest total diff:

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 30a4c053f98b..a14fc309d140 100755
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
@@ -218,6 +218,8 @@ my $dirname = $FindBin::Bin;
 
 my $mailto;
 my $mailer;
+my $mail_path;
+my $mail_command;
 my $email_on_error;
 my $email_when_finished;
 my $email_when_started;
@@ -250,8 +252,10 @@ my $no_reboot = 1;
 my $reboot_success = 0;
 
 my %option_map = (
-    "MAILTO"				=> \$mailto,
-    "MAILER"				=> \$mailer,
+    "MAILTO"			=> \$mailto,
+    "MAILER"			=> \$mailer,
+    "MAIL_PATH"			=> \$mail_path,
+    "MAIL_COMMAND"		=> \$mail_command,
     "EMAIL_ON_ERROR"		=> \$email_on_error,
     "EMAIL_WHEN_FINISHED"	=> \$email_when_finished,
     "EMAIL_WHEN_STARTED"	=> \$email_when_started,
@@ -1431,7 +1435,14 @@ sub do_not_reboot {
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
@@ -4124,23 +4135,61 @@ sub set_test_option {
     return eval_option($name, $option, $i);
 }
 
-sub _mailx_send {
-    my ($subject, $message) = @_;
-    system("$mailer -s \'$subject\' $mailto <<< \'$message\'");
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
 
-sub _sendmail_send {
+sub do_send_mail {
     my ($subject, $message) = @_;
-    system("echo -e \"Subject: $subject\n\n$message\" | sendmail -t $mailto");
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
 }
 
 sub send_email {
-    if (defined($mailto) && defined($mailer)) {
-        if ($mailer eq "mail" || $mailer eq "mailx"){ _mailx_send(@_);}
-        elsif ($mailer eq "sendmail" ) { _sendmail_send(@_);}
-        else { doprint "\nYour mailer: $mailer is not supported.\n" }
-    } else {
-        print "No email sent: email or mailer not specified in config.\n"
+
+    if (defined($mailto)) {
+	if (!defined($mailer)) {
+	    doprint "No email sent: email or mailer not specified in config.\n";
+	    return;
+	}
+	do_send_mail @_;
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

-- Steve

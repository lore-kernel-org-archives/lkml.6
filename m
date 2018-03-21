Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752519AbeCUPJm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 11:09:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:59452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752402AbeCUPJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 11:09:41 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19D852177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 21 Mar 2018 11:09:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tim Tianyang Chen <tianyang.chen@oracle.com>
Cc: linux-kernel@vger.kernel.org, dhaval.giani@oracle.com
Subject: Re: [PATCH 1/3] Ktest: add email support
Message-ID: <20180321110938.396a1595@gandalf.local.home>
In-Reply-To: <1513380011-15274-2-git-send-email-tianyang.chen@oracle.com>
References: <1513380011-15274-1-git-send-email-tianyang.chen@oracle.com>
        <1513380011-15274-2-git-send-email-tianyang.chen@oracle.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm really sorry for the late reply here. I finally took out time to
look at your patches. I've had my own set of ktest patches that I need
to push upstream that I haven't done so for over a year :-p


On Fri, 15 Dec 2017 15:20:09 -0800
Tim Tianyang Chen <tianyang.chen@oracle.com> wrote:

> Users can define optional variables to get email notifications.
> Ktest can send emails when the script:
>  * was started
>  * was cancelled by Ctrl-C
>  * failed with fatal errors and called dodie()
>  * completed all testing
> 
> Users have to setup the mailer provided in config prior to using this script.
> Supported mailers: mailx, mail, sendmail
> mailer specific routines are _sendmail_send(), _mailx_send()
> 
> Suggested-by: Dhaval Giani <dhaval.giani@oracle.com>
> Signed-off-by: Tim Tianyang Chen <tianyang.chen@oracle.com>
> 
> ---
> changes since v1:
>     added options for when to sendemails in the option_map
> ---
>  ktest.pl | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 70 insertions(+), 3 deletions(-)
> 
> diff --git a/ktest.pl b/ktest.pl
> index 0c8b61f8398e..91cae4470fe7 100755
> --- a/ktest.pl
> +++ b/ktest.pl
> @@ -22,6 +22,12 @@ my %evals;
>  
>  #default opts
>  my %default = (
> +    "MAILTO"                => "",

We don't need to add MAILTO here. We want it undefined.

> +    "MAILER"                => "sendmail",  # default mailer
> +    "EMAIL_ON_ERROR"        => 1,
> +    "EMAIL_WHEN_FINISHED"   => 1,
> +    "EMAIL_WHEN_CANCELED"   => 0,
> +    "EMAIL_WHEN_STARTED"    => 0,

Note, the above has whitespace issues. There should be tabs between the
option and its value.

>      "NUM_TESTS"			=> 1,
>      "TEST_TYPE"			=> "build",
>      "BUILD_TYPE"		=> "randconfig",
> @@ -204,6 +210,15 @@ my $install_time;
>  my $reboot_time;
>  my $test_time;
>  
> +my $mailto;
> +my $mailer;
> +my $email_on_error;
> +my $email_when_finished;
> +my $email_when_started;
> +my $email_when_canceled;
> +
> +my $script_start_time = localtime();
> +
>  # set when a test is something other that just building or install
>  # which would require more options.
>  my $buildonly = 1;
> @@ -229,6 +244,12 @@ my $no_reboot = 1;
>  my $reboot_success = 0;
>  
>  my %option_map = (
> +    "MAILTO"                => \$mailto,
> +    "MAILER"                => \$mailer,
> +    "EMAIL_ON_ERROR"        => \$email_on_error,
> +    "EMAIL_WHEN_FINISHED"   => \$email_when_finished,
> +    "EMAIL_WHEN_STARTED"    => \$email_when_started,
> +    "EMAIL_WHEN_CANCELED"   => \$email_when_canceled,

Same whitespace issues.

>      "MACHINE"			=> \$machine,
>      "SSH_USER"			=> \$ssh_user,
>      "TMP_DIR"			=> \$tmpdir,
> @@ -1426,6 +1447,11 @@ sub dodie {
>  	print " See $opt{LOG_FILE} for more info.\n";
>      }
>  
> +    if ($email_on_error) {
> +        send_email("KTEST: critical failure for your [$test_type] test",
> +                "Your test started at $script_start_time has failed with:\n@_\n");
> +    }
> +
>      if ($monitor_cnt) {
>  	    # restore terminal settings
>  	    system("stty $stty_orig");
> @@ -4224,6 +4250,37 @@ sub set_test_option {
>      return eval_option($name, $option, $i);
>  }
>  
> +sub _mailx_send {
> +    my ($subject, $message) = @_;
> +    system("$mailer -s \'$subject\' $mailto <<< \'$message\'");
> +}
> +
> +sub _sendmail_send {
> +    my ($subject, $message) = @_;
> +    system("echo -e \"Subject: $subject\n\n$message\" | sendmail -t $mailto");
> +}
> +
> +sub send_email {
> +    if ($mailto ne "" && $mailer ne "")

This shoudl be:
	if (defined($mailto) && defined($mailer)) {

Also, note that we use Linux C style. (if statements end with '{').

> +    {
> +        if ($mailer eq "mail" || $mailer eq "mailx"){ _mailx_send(@_);}
> +        elsif ($mailer eq "sendmail" ) { _sendmail_send(@_);}
> +        else { doprint "\nYour mailer: $mailer is not supported.\n" }
> +    }
> +    else
> +    {

Linux C style is:

	} else {

> +        print "No email sent: email or mailer not specified in config.\n"
> +    }
> +}
> +
> +$SIG{INT} = sub {
> +    if ($email_when_canceled) {
> +        send_email("KTEST: Your [$test_type] test was cancelled",
> +                "Your test started at $script_start_time was cancelled: sig int");

Shouldn't the die be outside the if statement?

> +        die "\nCaught Sig Int, test interrupted: $!\n"
> +    }
> +};

This should be a separate patch, as it adds different functionality to
the email support. Also, when you do add it, please make it a separate
function:

ie.

sub cancel_test {
    dodie "Caught SIGINT, test interrupted: $!\n"
}

$SIG{INT} = qw(cancel_test);

Other than that. Looks good.

-- Steve

> +
>  # First we need to do is the builds
>  for (my $i = 1; $i <= $opt{"NUM_TESTS"}; $i++) {
>  
> @@ -4264,9 +4321,15 @@ for (my $i = 1; $i <= $opt{"NUM_TESTS"}; $i++) {
>      $start_minconfig_defined = 1;
>  
>      # The first test may override the PRE_KTEST option
> -    if (defined($pre_ktest) && $i == 1) {
> -	doprint "\n";
> -	run_command $pre_ktest;
> +    if ($i == 1) {
> +        if (defined($pre_ktest)) {
> +            doprint "\n";
> +            run_command $pre_ktest;
> +        }
> +        if ($email_when_started) {
> +            send_email("KTEST: Your [$test_type] test was started",
> +                "Your test was started on $script_start_time");
> +        }
>      }
>  
>      # Any test can override the POST_KTEST option
> @@ -4430,4 +4493,8 @@ if ($opt{"POWEROFF_ON_SUCCESS"}) {
>  
>  doprint "\n    $successes of $opt{NUM_TESTS} tests were successful\n\n";
>  
> +if ($email_when_finished) {
> +    send_email("KTEST: Your [$test_type] test has finished!",
> +            "$successes of $opt{NUM_TESTS} tests started at $script_start_time were successful!");
> +}
>  exit 0;

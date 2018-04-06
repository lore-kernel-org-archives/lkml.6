Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753088AbeDFXMb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 19:12:31 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49598 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751982AbeDFXMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 19:12:30 -0400
Subject: Re: [PATCH v3 1/4] Ktest: add email support
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, dhaval.giani@oracle.com
References: <1522094884-22718-1-git-send-email-tianyang.chen@oracle.com>
 <1522094884-22718-2-git-send-email-tianyang.chen@oracle.com>
 <20180406142409.6d98254b@gandalf.local.home>
 <e0646238-e991-61c6-c32f-eee07742073c@oracle.com>
 <20180406184130.6809805c@gandalf.local.home>
From: Tim Tianyang Chen <tianyang.chen@oracle.com>
Organization: Oracle Corporation
Message-ID: <81730b00-fcd9-3ccc-bb84-51f69e7364c9@oracle.com>
Date: Fri, 6 Apr 2018 16:12:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180406184130.6809805c@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8855 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804060229
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I just fixed them up and pulled them in myself. ;-)
>
> I also added the following on top of them (and testing this, live while
> testing ftrace patches and other builds).
Thanks Steve!
> diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
> index 30a4c053f98b..837fa75cbb47 100755
> --- a/tools/testing/ktest/ktest.pl
> +++ b/tools/testing/ktest/ktest.pl
> @@ -23,7 +23,7 @@ my %evals;
>   
>   #default opts
>   my %default = (
> -    "MAILER"				=> "sendmail",  # default mailer
> +    "MAILER"			=> "sendmail",  # default mailer
Noticed this when I sent the new version.

>       "EMAIL_ON_ERROR"		=> 1,
>       "EMAIL_WHEN_FINISHED"	=> 1,
>       "EMAIL_WHEN_CANCELED"	=> 0,
> @@ -218,6 +218,7 @@ my $dirname = $FindBin::Bin;
>   
>   my $mailto;
>   my $mailer;
> +my $mail_exec;
>   my $email_on_error;
>   my $email_when_finished;
>   my $email_when_started;
> @@ -1431,7 +1433,14 @@ sub do_not_reboot {
>   	($test_type eq "config_bisect" && $opt{"CONFIG_BISECT_TYPE[$i]"} eq "build");
>   }
>   
> +my $in_die = 0;
> +
>   sub dodie {
> +
> +    # avoid recusion
> +    return if ($in_die);
> +    $in_die = 1;
> +
>       doprint "CRITICAL FAILURE... ", @_, "\n";
Good idea.
>   
>       my $i = $iteration;
> @@ -4126,21 +4135,31 @@ sub set_test_option {
>   
>   sub _mailx_send {
>       my ($subject, $message) = @_;
> -    system("$mailer -s \'$subject\' $mailto <<< \'$message\'");
> +
> +    if (!defined($mail_exec)) {
> +	$mail_exec = $mailer;
> +    }
> +    run_command "$mail_exec -s \'$subject\' $mailto <<< \'$message\'";
>   }
>   
>   sub _sendmail_send {
>       my ($subject, $message) = @_;
> -    system("echo -e \"Subject: $subject\n\n$message\" | sendmail -t $mailto");
> +
> +    if (!defined($mail_exec)) {
> +	$mail_exec = "/usr/sbin/sendmail";
> +    }
> +    run_command "echo \'Subject: $subject\n\n$message\' | $mail_exec -t $mailto";
>   }
>   
Not sure if I understand why $mail_exec is necessary. Doesn't $mailer 
already have a default? Wouldn't people just use $mailer to define the 
executable they want to use? What if the $mailx_exec specified doesn't 
use '-t' option?

Thanks,
Tim

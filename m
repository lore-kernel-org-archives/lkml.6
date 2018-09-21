Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D270ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 23:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE18821569
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 23:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE18821569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391679AbeIVFdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 01:33:21 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:50916 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725756AbeIVFdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 01:33:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 8E260C1410;
        Fri, 21 Sep 2018 23:42:10 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo01-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RIIJrZjONBxm; Fri, 21 Sep 2018 23:42:10 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id BC859C05EF;
        Fri, 21 Sep 2018 23:42:01 +0000 (UTC)
Subject: Re: [PATCH] selftests: watchdog: Add gettimeout and get|set
 pretimeout
To:     Jerry Hoemann <jerry.hoemann@hpe.com>, erosca@de.adit-jv.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <1537570526-65241-1-git-send-email-jerry.hoemann@hpe.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <0c6376ec-a3f4-7798-8f30-829480c41f79@kernel.org>
Date:   Fri, 21 Sep 2018 17:42:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537570526-65241-1-git-send-email-jerry.hoemann@hpe.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerry,

Thanks for the patch. A few comments below:

On 09/21/2018 04:55 PM, Jerry Hoemann wrote:
> Add command line arguments to call ioctl WDIOC_GETTIMEOUT,
> WDIOC_GETPRETIMEOUT and WDIOC_SETPRETIMEOUT.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> ---
>  tools/testing/selftests/watchdog/watchdog-test.c | 30 +++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
> index 6e29087..4861e2c 100644
> --- a/tools/testing/selftests/watchdog/watchdog-test.c
> +++ b/tools/testing/selftests/watchdog/watchdog-test.c
> @@ -19,7 +19,7 @@
>  
>  int fd;
>  const char v = 'V';
> -static const char sopts[] = "bdehp:t:";
> +static const char sopts[] = "bdehp:t:Tn:N";
>  static const struct option lopts[] = {
>  	{"bootstatus",          no_argument, NULL, 'b'},
>  	{"disable",             no_argument, NULL, 'd'},
> @@ -27,6 +27,9 @@
>  	{"help",                no_argument, NULL, 'h'},
>  	{"pingrate",      required_argument, NULL, 'p'},
>  	{"timeout",       required_argument, NULL, 't'},
> +	{"gettimeout",          no_argument, NULL, 'T'},
> +	{"pretimeout",    required_argument, NULL, 'n'},
> +	{"getpretimeout",       no_argument, NULL, 'N'},
>  	{NULL,                  no_argument, NULL, 0x0}
>  };
>  
> @@ -71,6 +74,9 @@ static void usage(char *progname)
>  	printf(" -h, --help          Print the help message\n");
>  	printf(" -p, --pingrate=P    Set ping rate to P seconds (default %d)\n", DEFAULT_PING_RATE);
>  	printf(" -t, --timeout=T     Set timeout to T seconds\n");
> +	printf(" -T, --gettimeout    Get the timeout\n");
> +	printf(" -n, --pretimeout    Set the pretimeout to T seconds\n");
> +	printf(" -N, --getpretimeout Get the pretimeout\n");

How are the new arguments used?

>  	printf("\n");
>  	printf("Parameters are parsed left-to-right in real-time.\n");
>  	printf("Example: %s -d -t 10 -p 5 -e\n", progname);

Please add an example usage for each of these new arguments.

> @@ -135,6 +141,28 @@ int main(int argc, char *argv[])
>  			else
>  				printf("WDIOC_SETTIMEOUT errno '%s'\n", strerror(errno));
>  			break;
> +		case 'T':
> +			ret = ioctl(fd, WDIOC_GETTIMEOUT, &flags);
> +			if (!ret)
> +				printf("Watchdog timeout set to %u seconds.\n", flags);

It would good to make this message different from the WDIOC_SETTIMEOUT message.
Please update it to reflect that this is the result of a WDIOC_GETTIMEOUT.

What would user intend to do with this GETTIMEOUT? Shouldn't this be the case that it
prints the current value and exits instead of the same logic as SETTIMEOUT option?

> +			else
> +				printf("WDIOC_GETTIMEOUT errno '%s'\n", strerror(errno))

Shouldn't this error be an exit condition?

> +			break;
> +		case 'n':
> +			flags = strtoul(optarg, NULL, 0);
> +			ret = ioctl(fd, WDIOC_SETPRETIMEOUT, &flags);
> +			if (!ret)
> +				printf("Watchdog pretimeout set to %u seconds.\n", flags);
> +			else
> +				printf("WDIOC_SETPRETIMEOUT errno '%s'\n", strerror(errno));
> +			break;
> +		case 'N':
> +			ret = ioctl(fd, WDIOC_GETPRETIMEOUT, &flags);
> +			if (!ret)
> +				printf("Watchdog pretimeout set to %u seconds.\n", flags);

It would good to make this message different from the WDIOC_GETPRETIMEOUT message.
Please update it to reflect that this is the result of a WDIOC_GETPRETIMEOUT

What would user intend to do with this GETTIMEOUT? Shouldn't this be the case that it
prints the current value and exits instead of the same logic as WDIOC_SETPRETIMEOUT?

> +			else
> +				printf("WDIOC_GETPRETIMEOUT errno '%s'\n", strerror(errno));

Shouldn't this error be an exit condition?

> +			break;
>  		default:
>  			usage(argv[0]);
>  			goto end;
> 

Also can you run this test as normal user?

thanks,
-- Shuah

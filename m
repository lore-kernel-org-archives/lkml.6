Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82FCC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBBA2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FBBA2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbeIZDAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 23:00:46 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:52919 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbeIZDAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 23:00:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 0B18222101;
        Tue, 25 Sep 2018 20:51:22 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo02-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id A21DjoFP08AY; Tue, 25 Sep 2018 20:51:22 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 408EE2209A;
        Tue, 25 Sep 2018 20:51:15 +0000 (UTC)
Subject: Re: [V2 PATCH] selftests: watchdog: Add gettimeout and get|set
 pretimeout
To:     Jerry Hoemann <jerry.hoemann@hpe.com>, erosca@de.adit-jv.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <1537817767-78918-1-git-send-email-jerry.hoemann@hpe.com>
 <1537817767-78918-2-git-send-email-jerry.hoemann@hpe.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <16941ebb-85ca-ad4c-de7b-c26f193ca611@kernel.org>
Date:   Tue, 25 Sep 2018 14:51:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537817767-78918-2-git-send-email-jerry.hoemann@hpe.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerry,

On 09/24/2018 01:36 PM, Jerry Hoemann wrote:
> Add command line arguments to call ioctl WDIOC_GETTIMEOUT,
> WDIOC_GETPRETIMEOUT and WDIOC_SETPRETIMEOUT.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> ---
>  tools/testing/selftests/watchdog/watchdog-test.c | 33 +++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
> index 6e29087..3e8e393 100644
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
> @@ -71,9 +74,13 @@ static void usage(char *progname)
>  	printf(" -h, --help          Print the help message\n");
>  	printf(" -p, --pingrate=P    Set ping rate to P seconds (default %d)\n", DEFAULT_PING_RATE);
>  	printf(" -t, --timeout=T     Set timeout to T seconds\n");
> +	printf(" -T, --gettimeout    Get the timeout\n");
> +	printf(" -n, --pretimeout=T  Set the pretimeout to T seconds\n");
> +	printf(" -N, --getpretimeout Get the pretimeout\n");
>  	printf("\n");
>  	printf("Parameters are parsed left-to-right in real-time.\n");
>  	printf("Example: %s -d -t 10 -p 5 -e\n", progname);
> +	printf("Example: %s -t 12 -T -n 7 -N\n", progname);

Would this work the way you want it though, since -N now is oneshot?
Should this be just "printf("Example: %s -t 12 -T -n 7\n", progname); ??

The rest looks good to me.

>  }
>  
>  int main(int argc, char *argv[])
> @@ -135,6 +142,30 @@ int main(int argc, char *argv[])
>  			else
>  				printf("WDIOC_SETTIMEOUT errno '%s'\n", strerror(errno));
>  			break;
> +		case 'T':
> +			oneshot = 1;
> +			ret = ioctl(fd, WDIOC_GETTIMEOUT, &flags);
> +			if (!ret)
> +				printf("WDIOC_GETTIMEOUT returns %u seconds.\n", flags);
> +			else
> +				printf("WDIOC_GETTIMEOUT errno '%s'\n", strerror(errno));
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
> +			oneshot = 1;
> +			ret = ioctl(fd, WDIOC_GETPRETIMEOUT, &flags);
> +			if (!ret)
> +				printf("WDIOC_GETPRETIMEOUT returns %u seconds.\n", flags);
> +			else
> +				printf("WDIOC_GETPRETIMEOUT errno '%s'\n", strerror(errno));
> +			break;
>  		default:
>  			usage(argv[0]);
>  			goto end;
> 

thanks,
-- Shuah

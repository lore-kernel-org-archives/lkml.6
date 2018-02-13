Return-Path: <shuahkh@osg.samsung.com>
X-Google-Smtp-Source: AH8x224k1Lv0XrZ6oVcJ9N2T/lsFNCuNkURalrqDgBDa0hNFk3JfOzIocOncTEgoPbHAnGymwPrK
ARC-Seal: i=1; a=rsa-sha256; t=1518557164; cv=none;
        d=google.com; s=arc-20160816;
        b=0wNug6uXco/yPYLAp3m86Jq5WsS2pTWobs9a+wLx04p02htr95dpBL8chVousNrhzb
         UT5P8djNbD4LsS9o9BoQA0DG23/hq0D8bhGw9wyAA/Ff1+F9twx5klfm9ONf9Bm160xX
         IfkReTIkkAnWX7nmiQCm94NHS85MVns1AjCJSwtZB7dsWrMZ+l4wsRKC9aOkgAUc61QK
         9smUWhUTz7Zi/lSOJ+m64M7L+94dr6RoFgrzyAncwzU0YDp5EKHsHrQuSc2Y5w30oBOo
         NDLzT5LJ5Ew0mEPJ6aBWyRof8HRZK8dVfcIm9+iQba7vzsQB4wngTdWHmd5g/CQocA8Y
         QQWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=v+eOE97UhVLxPwXgQEI08YIZOHfVvI4WSLrpZYL/Dc0=;
        b=wV3ESTy6w5hrc/8v7Enx6X6OB7K9+S/adv+8OZWjvSbGOdz4u2x4ylT9qG/PhWu3oW
         xJXwP/HiMxQGYiiiE2yGTTOdvm87CYKZ6xHB1DNuxRsoj+OZlzankNE06F1S2F662Eve
         /nw2p+OffqjtoS2SJM+5zpaZbVSb0wNMo/pcYN2o5kjHnNjlzUO6XSLocAXxdzxo13G8
         6/qSaZvrh/Ic5tg3w5ZTrGHALw2jFq4OhoZAnzCnRHx4fhwh/1KkZkVm8E+bBUEPWF+V
         1izVZpHBKyPQpT3p0B+lPLO3GQQyDU03KjS7r5QI9O1VVObeYIeJj5QudSl0uD8KpB51
         Kt5w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of shuahkh@osg.samsung.com designates 64.30.133.232 as permitted sender) smtp.mailfrom=shuahkh@osg.samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of shuahkh@osg.samsung.com designates 64.30.133.232 as permitted sender) smtp.mailfrom=shuahkh@osg.samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Subject: Re: [PATCH] selftests/android: Fix line continuation in Makefile
To: =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>,
 linux-kselftest@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>, Darren Hart <dvhart@infradead.org>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Pintu Agarwal <pintu.ping@gmail.com>,
 open list <linux-kernel@vger.kernel.org>,
 Shuah Khan <shuahkh@osg.samsung.com>
References: <1517961219-17700-1-git-send-email-daniel.diaz@linaro.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <b343b99b-0c55-1032-cc6e-dacd367f7e8f@osg.samsung.com>
Date: Tue, 13 Feb 2018 14:25:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1517961219-17700-1-git-send-email-daniel.diaz@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591697740031389880?=
X-GMAIL-MSGID: =?utf-8?q?1592322597710159517?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/06/2018 04:52 PM, Daniel Díaz wrote:
> The Makefile lacks a couple of line continuation backslashes
> in an `if' clause, which can make the subsequent rsync
> command go awry over the whole filesystem (`rsync -a / /`).
> 
>   /bin/sh: -c: line 5: syntax error: unexpected end of file
>   make[1]: [all] Error 1 (ignored)
>   TEST=$DIR"_test.sh"; \
>                   if [ -e $DIR/$TEST ]; then
>   /bin/sh: -c: line 2: syntax error: unexpected end of file
>   make[1]: [all] Error 1 (ignored)
>   rsync -a $DIR/$TEST $BUILD_TARGET/;
>   [...a myriad of:]
>   [  rsync: readlink_stat("...") failed: Permission denied (13)]
>   [  skipping non-regular file "..."]
>   [  rsync: opendir "..." failed: Permission denied (13)]
>   [and many other errors...]
>   fi
>   make[1]: fi: Command not found
>   make[1]: [all] Error 127 (ignored)
>   done
>   make[1]: done: Command not found
>   make[1]: [all] Error 127 (ignored)
> 
> Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
> ---
>  tools/testing/selftests/android/Makefile | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/android/Makefile b/tools/testing/selftests/android/Makefile
> index 1a74922..f6304d2 100644
> --- a/tools/testing/selftests/android/Makefile
> +++ b/tools/testing/selftests/android/Makefile
> @@ -11,11 +11,11 @@ all:
>  		BUILD_TARGET=$(OUTPUT)/$$DIR;	\
>  		mkdir $$BUILD_TARGET  -p;	\
>  		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;\
> -		#SUBDIR test prog name should be in the form: SUBDIR_test.sh
> +		#SUBDIR test prog name should be in the form: SUBDIR_test.sh \
>  		TEST=$$DIR"_test.sh"; \
> -		if [ -e $$DIR/$$TEST ]; then
> -			rsync -a $$DIR/$$TEST $$BUILD_TARGET/;
> -		fi
> +		if [ -e $$DIR/$$TEST ]; then \
> +			rsync -a $$DIR/$$TEST $$BUILD_TARGET/; \
> +		fi \
>  	done
>  
>  override define RUN_TESTS
> 

Thanks for the patch. Applied to linux-kselftest fixes for 4.16-rc3

thanks,
-- Shuah

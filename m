Return-Path: <tcminyard@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524145252; cv=none;
        d=google.com; s=arc-20160816;
        b=YVwk7l3uz8/AC4FepsepWMTbF9ksMUKJYyHkpTHtuWwvoD7cT3n0CnVNGZcAOnAQyR
         /Hc6eFD0RliJPTdYZz4dPtysCkPKba8acyMUeximKekqTU/UzsIYndAEixpLdasoRye2
         oOxT8cn6jYSY0vKxEj2Fbiciouv/0LHdAZJ/VLH4aq5V4Yp1+85qn4vpJiWzsNryijy8
         jC2YTPOXELs8Zeuxtp3Lv7/OAlmbMsIbfkfYk1nhfB9TgBXDHAaDXYhoJzN0FdwK32dU
         WnuOC+Yws5cl6PD+jV7mi1U2DTeN2zMpC67/0ixgbsRDC/77B1TIU3EeepRzdb76Pgnc
         Kdow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:reply-to
         :sender:dkim-signature:arc-authentication-results;
        bh=HcXZNGwCM9uW5Z5fND2NJyWguiogObg0X8jMIimaLqE=;
        b=LO021S9ALeXUY8gnm9uRBdo8KKpYRHJUBIx1xyy2FbVJGQTQz5DSkrPRfceAg2zkEx
         fxTSDJ3lcqD+AoLHOodeO/51XBGbDfIyOkD5OEoPDP4txxGkuWF0LWiGTesd+UFeLS4q
         HyIqmlr10AoGBb8XlW9kyHeesrQchCdg1/NUZiE6vQLeonirdfV4ECU39WSym8sHySk5
         Og9eoW8C7iK7AEFOf85XK96UKSCAnLggS2f5cXrDQ779hsZf0rbQDKN5lDDo5d/lBM8U
         OGItjWRgKFS/zXPsi9e9+uFeeW0JYu1PSYSgGzMCaa7Z/qe688AmPSUClgW7XF2FE/l8
         jDEA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=WAhThcBU;
       spf=pass (google.com: domain of tcminyard@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tcminyard@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=WAhThcBU;
       spf=pass (google.com: domain of tcminyard@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tcminyard@gmail.com
X-Google-Smtp-Source: AIpwx4/Y8mI+fu75rUELcx+a0q9eIX71g4QY5UEKLZM1vaLm+YaB2Z29cy5Yc16v0NAAvWNDV8AXvg==
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
Subject: Re: [PATCH] ipmi_ssif: Fix uninitialized variable issue
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Corey Minyard <cminyard@mvista.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20180419132429.GA13997@embeddedor.com>
From: Corey Minyard <minyard@acm.org>
Message-ID: <738f2ba2-b0db-9120-4590-eade830dde25@acm.org>
Date: Thu, 19 Apr 2018 08:40:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180419132429.GA13997@embeddedor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598181106409658883?=
X-GMAIL-MSGID: =?utf-8?q?1598182131775443283?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/19/2018 08:24 AM, Gustavo A. R. Silva wrote:
> Currently, function ssif_remove returns _rv_, which is a variable that
> is never initialized.
>
> Fix this by removing variable _rv_ and return 0 instead.

This fix is in my next tree now, thanks for catching this before it got 
any further than that.

-corey

> Addresses-Coverity-ID: 1467999 ("Uninitialized scalar variable")
> Fixes: 6a0d23ed338e ("ipmi: ipmi_unregister_smi() cannot fail, have it
> return void")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>   drivers/char/ipmi/ipmi_ssif.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> index ecabfe2..37f9ae2 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -1227,7 +1227,6 @@ static int ssif_remove(struct i2c_client *client)
>   	struct ssif_info *ssif_info = i2c_get_clientdata(client);
>   	struct ipmi_smi *intf;
>   	struct ssif_addr_info *addr_info;
> -	int rv;
>   
>   	if (!ssif_info)
>   		return 0;
> @@ -1247,7 +1246,7 @@ static int ssif_remove(struct i2c_client *client)
>   		}
>   	}
>   
> -	return rv;
> +	return 0;
>   }
>   
>   static int do_cmd(struct i2c_client *client, int len, unsigned char *msg,

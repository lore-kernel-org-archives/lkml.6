Return-Path: <kernel-hardening-return-12844-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx484lWS1SuqhNNy2oR/pjAw14qU8daHs5B2aleF8kEv2LTazi5Xc9OJTKHW0NcA0lCctR1uu
ARC-Seal: i=1; a=rsa-sha256; t=1522657931; cv=none;
        d=google.com; s=arc-20160816;
        b=Me8M9Y4mrtaNhopOQp9CJ0zPT7xHLk4MFk/F2tA23STJD14lTHP8tvfUypsPTXdlK8
         rOhG8su1b8NAFTaO6LtLbK9hk3SStD/0XmZzZ5rK0aq1VlasNgP2h7M6u5yTsHqbNN8F
         fPgcJKd+SvyYzNkiWzKQ7yVlSWlw/Je9xm17iwu2O1WXMnL1FOh3Dja37taGRr8Q37cf
         RAi8giKOlbIr5gVyHnXzsuA0GSvRsFYrNwh7BXMbJxpClNIP0YCxG8nqEMQh8LU7ztSa
         qhMokmZIbwPAK3dyIWuVPiEdMJO91mgu3nk6Abex4nfxcZQj/jE4cuZZy3LJyyEUXWAq
         0yiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=3lDJHsG6MMVh5IRSGZJKTQwgystZk4PBNaWNub81rVc=;
        b=FB0buiKF9BXLCx375ljMkdI+WaOcJKVjHp0sQ4qqndNgYlnFJ955oPz5DU7gIvCeSQ
         Qx13l7Fq9h5A2LwLcnbKGpoNCU/ZHVDpbPVDXlhGXd+7mL23Qot087s9nBz3ilosKYTo
         WF9i/dvpfC9fC/1k7AFeCQ63wX2tGD5Vz6J7iytPO6FywRa08zi5hLFv8UhbzpQFOBiO
         JlyUfS7yiHcKdyzBwOSC1c+XPxoVFFo1E9KToBIWERrrdcVMHTdnWKFeOEd8R1IDriZW
         MiXNtNgdFc5Zpbd7H4xIaEXIOIxxelUYNO3I0GVuE+/GYs08CuKV6mMH5MSLOG7PzVEk
         /zIg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12844-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12844-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12844-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12844-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Mon, 2 Apr 2018 10:31:50 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Laura Abbott <labbott@redhat.com>,
	Linus Walleij <linus.walleij@linaro.org>, kbuild-all@01.org,
	Kees Cook <keescook@chromium.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] gpio: fix ifnullfree.cocci warnings
Message-ID: <20180402083150.GA8013@wunner.de>
References: <alpine.DEB.2.20.1803300829580.2870@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1803300829580.2870@hadrien>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596343288243285153?=
X-GMAIL-MSGID: =?utf-8?q?1596622563334445823?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 30, 2018 at 08:32:56AM +0200, Julia Lawall wrote:
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2774,8 +2773,7 @@ int gpiod_get_array_value_complex(bool r
>  			trace_gpio_value(desc_to_gpio(desc), 1, value);
>  		}
> 
> -		if (slowpath)
> -			kfree(slowpath);
> +		kfree(slowpath);
>  	}
>  	return 0;
>  }
> @@ -3020,8 +3018,7 @@ int gpiod_set_array_value_complex(bool r
>  		if (count != 0)
>  			gpio_chip_set_multiple(chip, mask, bits);
> 
> -		if (slowpath)
> -			kfree(slowpath);
> +		kfree(slowpath);
>  	}
>  	return 0;
>  }

The problem I see here is that kfree may not be in L1 cache,
and in that case checking for non-NULL locally in this function
should actually be cheaper.

Note that kfree() need only be called in the slowpath, which
is the *unlikely* case.  Letting the branch predictor assume
that kfree() is not called is the right thing to do here.

The function is a hot path, on the Revolution Pi open source PLCs
we're calling it every 250 usec to poll digital inputs and update
digital outputs.

Would "if (unlikely(slowpath))" be sufficient to make coccinelle
happy?  That's what I'd suggest then.

Otherwise "if (unlikely(chip->ngpio > FASTPATH_NGPIO))" could be used,
though that might be minimally slower due to the pointer chasing.


> @@ -2758,8 +2758,7 @@ int gpiod_get_array_value_complex(bool r
> 
>  		ret = gpio_chip_get_multiple(chip, mask, bits);
>  		if (ret) {
> -			if (slowpath)
> -				kfree(slowpath);
> +			kfree(slowpath);
>  			return ret;
>  		}
> 

This particular change on the other hand is fine because the kfree()
is occurring in an error path, which we'll normally not enter anyway.

Thanks,

Lukas

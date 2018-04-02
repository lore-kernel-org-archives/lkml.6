Return-Path: <kernel-hardening-return-12845-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49nUAbzoTku1WCGBuAVi7iPTMds5qBVxuKg3rHovGJdWyfr1gt6oxFRPmiUROS1cNFJkUm1
ARC-Seal: i=1; a=rsa-sha256; t=1522659924; cv=none;
        d=google.com; s=arc-20160816;
        b=MpIJ+Yw/09/mTvFjhlBIuYVk7LHUCLVO+dVW4j8lY7FwYSrL102GKLVOCSqNv0lT6u
         Ca99uNwrgXSFuoKbfnSGzqGwfbywfeC0seWgPpYa0QQJUFC7LR2+0ctIva1nAl8OfKvZ
         8JNahLIQoNMFmStLxcQIQREgWUhkR9/Hmxv3CeEdDwXJnMDJzttkX8kMyYXdA7PQZYMp
         WQT/kqstFRm5yy1d4gTB9q8vpp3n/kLdAi5mrdt9Nb0SHBx+35q6La3a8QspRsZhe4gg
         YOwDpSSQgzwi1kHt7E41c5yxrxxssLXWdwbcqDNKQ2c+1vZ/KX/hvLa5A6FJJmN4ZqEq
         Ll9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=VB6l8boct6xCVQ5/Iv5WiHUHKxRBPuR8x3ywqJDq/KI=;
        b=yPmy2eZyRMBVDI33U2SDP6x72nVJdobv9LFWfI93ZLF8pn9/u4NKzE/IPeZV62gapA
         RhqxndZX8mijYNJ5TPNLL7NsN/UKborHxJp60Xt5jOTD4+h6n2tQBWP5UyvbcS+kVhYC
         9znA4PHdMpI/fXUDyb+tXF3QULq5dbXc1uP6GeTJhKGGZAxrDYdhU/DnDtcCSUnF4NF4
         PpFLdFaIqX7Bz862n/0rEqyTl77efmZFJPAgXoWMNDmPmhMCkJeiGcEAj/wMmyUc5C2l
         enWfyFMHN6AYig5b1gy0rhftvSXZZKo8y1kkvp6IwTkvALifxmlluHc+HOGii4cVU1E1
         mdig==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12845-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12845-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12845-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12845-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-IronPort-AV: E=Sophos;i="5.48,395,1517871600";
   d="scan'208";a="260585507"
Date: Mon, 2 Apr 2018 11:04:58 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Lukas Wunner <lukas@wunner.de>
cc: Laura Abbott <labbott@redhat.com>,
    Linus Walleij <linus.walleij@linaro.org>, kbuild-all@01.org,
    Kees Cook <keescook@chromium.org>, linux-gpio@vger.kernel.org,
    linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
    Rasmus Villemoes <linux@rasmusvillemoes.dk>,
    Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] gpio: fix ifnullfree.cocci warnings
In-Reply-To: <20180402083150.GA8013@wunner.de>
Message-ID: <alpine.DEB.2.20.1804021102370.3198@hadrien>
References: <alpine.DEB.2.20.1803300829580.2870@hadrien> <20180402083150.GA8013@wunner.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596343288243285153?=
X-GMAIL-MSGID: =?utf-8?q?1596624653015795959?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Mon, 2 Apr 2018, Lukas Wunner wrote:

> On Fri, Mar 30, 2018 at 08:32:56AM +0200, Julia Lawall wrote:
> > --- a/drivers/gpio/gpiolib.c
> > +++ b/drivers/gpio/gpiolib.c
> > @@ -2774,8 +2773,7 @@ int gpiod_get_array_value_complex(bool r
> >  			trace_gpio_value(desc_to_gpio(desc), 1, value);
> >  		}
> >
> > -		if (slowpath)
> > -			kfree(slowpath);
> > +		kfree(slowpath);
> >  	}
> >  	return 0;
> >  }
> > @@ -3020,8 +3018,7 @@ int gpiod_set_array_value_complex(bool r
> >  		if (count != 0)
> >  			gpio_chip_set_multiple(chip, mask, bits);
> >
> > -		if (slowpath)
> > -			kfree(slowpath);
> > +		kfree(slowpath);
> >  	}
> >  	return 0;
> >  }
>
> The problem I see here is that kfree may not be in L1 cache,
> and in that case checking for non-NULL locally in this function
> should actually be cheaper.
>
> Note that kfree() need only be called in the slowpath, which
> is the *unlikely* case.  Letting the branch predictor assume
> that kfree() is not called is the right thing to do here.
>
> The function is a hot path, on the Revolution Pi open source PLCs
> we're calling it every 250 usec to poll digital inputs and update
> digital outputs.
>
> Would "if (unlikely(slowpath))" be sufficient to make coccinelle
> happy?  That's what I'd suggest then.

I think that indeed it would not complain any more in this case.  But at
least from kbuild, you shouldn't get another report on this, even if you
don't change it.  Of course, someone else running the script could find
the issue again.  If it would seem appropriate to you, adding a comment
would also at least capture the knowledge that the change is not wanted.

julia

>
> Otherwise "if (unlikely(chip->ngpio > FASTPATH_NGPIO))" could be used,
> though that might be minimally slower due to the pointer chasing.
>
>
> > @@ -2758,8 +2758,7 @@ int gpiod_get_array_value_complex(bool r
> >
> >  		ret = gpio_chip_get_multiple(chip, mask, bits);
> >  		if (ret) {
> > -			if (slowpath)
> > -				kfree(slowpath);
> > +			kfree(slowpath);
> >  			return ret;
> >  		}
> >
>
> This particular change on the other hand is fine because the kfree()
> is occurring in an error path, which we'll normally not enter anyway.
>
> Thanks,
>
> Lukas
>

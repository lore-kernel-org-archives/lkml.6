Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519772953; cv=none;
        d=google.com; s=arc-20160816;
        b=TRzNJzq2joVbHPz8h4+5dly2AvecRUWESAEywkuVydX6AU5nPrlJJ+6t/Mcn4nRkK8
         EfO2bHLR8+d2t2ab1aN34sMnrnJi2tVvc+ADf2s65X7P1cqfbpbaMj1bPhu5GBPyZHOu
         +mAY1u95AWRynWA7SMNyoQvAEXI/rI4Hb+9gHefNrSQRauZmNQSCK+6M+oOsqoSovwSd
         gEtm4gavbPRjDVEnI3wyjwCs/jrHV21IB2wWZT5AQne/x5vnwM69S8g9p5nas2ZhFGj8
         Vz/0Z8Ku6wkGMQB6d2LXVyOOvccBklbEUxAGabdbUV78azcQnzpSMM8OWH0GN16GXWLo
         9RmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=FxkggFmv9/FNt561TSor/bmaoDYxJzcD3XigtfEEQsU=;
        b=fQAN1U6VPLTeMiStogachDp8nPZzEO5pwiN+btZI1cpvc27uPcXgsG2EqgSZ8RUiy1
         zwM1X26tzdtl3hyccljtm5/9luxMIcdXoInlN1hodA0feJGkstcv/zLfG7vogkfOBGGs
         ka/kKE6NjgSN1NZnwt1Ha8KfLw7qGQ2dpqJWoAXdGYE7o7DFwBifubDymdSMpE2fLoZR
         0n1/GD2Q+/ItIVtFl7aKvGyar5ouxEYpZg1U5ypeM40bL8r/ErDRoIvoQE0JPs+6O/Si
         ipvZaJadgrunvsFjE6Dn+zvu4fwlOr8E+2Ew9lPkGkYUFeYJPBvW+tn3MCbsEnOfMffv
         g3Dg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=azzXOFlO;
       dkim=pass header.i=@chromium.org header.s=google header.b=X+5XwvrM;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=azzXOFlO;
       dkim=pass header.i=@chromium.org header.s=google header.b=X+5XwvrM;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELufjqXSkq8qibEsu+Ecd0sH0ywk/KZ0+CUoUocmueA8YO41p2NbFUFt+KZN1KI36JBzvllixdUH2O/7YoY4X7s=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180224024613.24078-3-mcgrof@kernel.org>
References: <20180224024613.24078-1-mcgrof@kernel.org> <20180224024613.24078-3-mcgrof@kernel.org>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Feb 2018 15:09:12 -0800
X-Google-Sender-Auth: OfAYreA96UorjfSf69qPvm23LTc
Message-ID: <CAGXu5jK85Ws=ZhN5r=m1Z8hj_nJYzH-X4+Q+xo1N-hgY7YZrQA@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] test_firmware: replace syfs fallback check with
 kconfig_has helper
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Martin Fuzzey <mfuzzey@parkeon.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>, David Howells <dhowells@redhat.com>, pali.rohar@gmail.com,
	Takashi Iwai <tiwai@suse.de>, arend.vanspriel@broadcom.com,
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, nbroeking@me.com,
	Vikram Mulukutla <markivx@codeaurora.org>, stephen.boyd@linaro.org,
	Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	Abhay_Salunke@dell.com, bjorn.andersson@linaro.org, jewalt@lgsinnovations.com,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593248714473643725?=
X-GMAIL-MSGID: =?utf-8?q?1593597444471837629?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 6:46 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> Now that we have a kconfig checker just use that instead of relying
> on testing a sysfs directory being present, since our requirements
> are spelled out.

I don't see the reason to depend on config.gz, but it's a reasonable
requirement for a test build.

> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  tools/testing/selftests/firmware/fw_fallback.sh | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/firmware/fw_fallback.sh b/tools/testing/selftests/firmware/fw_fallback.sh
> index a42e437363d9..40b6c1d3e832 100755
> --- a/tools/testing/selftests/firmware/fw_fallback.sh
> +++ b/tools/testing/selftests/firmware/fw_fallback.sh
> @@ -49,10 +49,7 @@ kconfig_has()
>
>  DIR=/sys/devices/virtual/misc/test_firmware
>
> -# CONFIG_FW_LOADER_USER_HELPER has a sysfs class under /sys/class/firmware/
> -# These days no one enables CONFIG_FW_LOADER_USER_HELPER so check for that
> -# as an indicator for CONFIG_FW_LOADER_USER_HELPER.
> -HAS_FW_LOADER_USER_HELPER=$(if [ -d /sys/class/firmware/ ]; then echo yes; else echo no; fi)
> +HAS_FW_LOADER_USER_HELPER=$(kconfig_has CONFIG_FW_LOADER_USER_HELPER=y)
>  HAS_FW_LOADER_USER_HELPER_FALLBACK=$(kconfig_has CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y)
>
>  if [ "$HAS_FW_LOADER_USER_HELPER" = "yes" ]; then
> --
> 2.16.2
>



-- 
Kees Cook
Pixel Security

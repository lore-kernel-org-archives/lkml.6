Return-Path: <ruslan.bilovol@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524696805; cv=none;
        d=google.com; s=arc-20160816;
        b=S+3FIqwRuf9+G+NmGbSv7DOwd2rmPxb9JyD6dqw69auZlZWG40/jaZw8qbBTKkLV0F
         g6eiwN9ms/cn7fG1Gl+kvlRvQff/UQXDbxUEHrow9zYc0r+RxsOEmk+Jk4wj84tyrgWp
         7MRdBrhM8/f40qxsQVoV5u9Be6Yl3zNIWkyG5KPKwny/xd212RYtKDudkmAJiiQA6Jc5
         Wv8pdBoKJtFggdO8GSAPTSBVZypgjOGHJl2Tfq0YEeubLGq88pFIALieh6v1gxTRTkJ/
         c1PTker8eNhGoG6ogDPx4sltGJZKPcqBz6qEOePIMaXo80mjbV4Syd/TkFDKvbhJPiC1
         i8eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=xAUqOeYgDWHpwHMdnnz9hTyGLwc06JIK6VyDHjwWGD4=;
        b=im/ssTNXRNvbwamSivYLDoQTSeHpUkn/LXV3YFZBE3XkamNmi37XAejQgcLhAWG9rC
         XQ/grevP8i6vdu/TjsQl1idoSDeLr/DDdco3tKYsODOJY9hStRIlxVprm+qvOvoqrMi8
         P0TLvOTyCuqK3RZGje+srv4LEgr+ESU1q5qVNJMC4islzyeDNLRLcRg/vp6etaxZ7+HL
         6KzCBa2Iej/LDkBLz8wSq9CHcPjfhspEOc91pcwNzDXfjZPkyF9Pj9rHOpb1OH3OTWaY
         EdrlTa8Ve0+aZBVC7i2N7vfhXxnE13CbtLMctTBdcgTmuFNZFw8+oS9gkolVWzz51kyA
         3SLw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ffefzYDv;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ffefzYDv;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/ZcJm0ClQnaAfpo4vH29vZKMs9J0jQdcIUmSzDBe0MvQeNfnmVhZlzUENZvQZZyAEZn2iqFQGUgkzJ93WFB0Q=
MIME-Version: 1.0
In-Reply-To: <20180424172445.31928-4-jorge.sanjuan@codethink.co.uk>
References: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
 <20180424172445.31928-1-jorge.sanjuan@codethink.co.uk> <20180424172445.31928-4-jorge.sanjuan@codethink.co.uk>
From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Date: Thu, 26 Apr 2018 01:53:24 +0300
Message-ID: <CAB=otbRfM0UWsvUDbx+WBqfh9pEgmq2-SNupZt19iSr+i9vzvw@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 3/4] ALSA: usb-audio: Use Class Specific
 EP for UAC3 devices.
To: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Cc: Takashi Iwai <tiwai@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598285489825871167?=
X-GMAIL-MSGID: =?utf-8?q?1598760477563706693?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 8:24 PM, Jorge Sanjuan
<jorge.sanjuan@codethink.co.uk> wrote:
> bmAtributes offset doesn't exist in the UAC3 CS_EP descriptor.
> Hence, checking for pitch control as if it was UAC2 doesn't make
> any sense. Use the defined UAC3 offsets instead.
>
> Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>

Reviewed-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>

> ---
>  sound/usb/stream.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/sound/usb/stream.c b/sound/usb/stream.c
> index 956be9f7c72a..5ed334575fc7 100644
> --- a/sound/usb/stream.c
> +++ b/sound/usb/stream.c
> @@ -576,7 +576,7 @@ static int parse_uac_endpoint_attributes(struct snd_usb_audio *chip,
>
>         if (protocol == UAC_VERSION_1) {
>                 attributes = csep->bmAttributes;
> -       } else {
> +       } else if (protocol == UAC_VERSION_2) {
>                 struct uac2_iso_endpoint_descriptor *csep2 =
>                         (struct uac2_iso_endpoint_descriptor *) csep;
>
> @@ -585,6 +585,13 @@ static int parse_uac_endpoint_attributes(struct snd_usb_audio *chip,
>                 /* emulate the endpoint attributes of a v1 device */
>                 if (csep2->bmControls & UAC2_CONTROL_PITCH)
>                         attributes |= UAC_EP_CS_ATTR_PITCH_CONTROL;
> +       } else { /* UAC_VERSION_3 */
> +               struct uac3_iso_endpoint_descriptor *csep3 =
> +                       (struct uac3_iso_endpoint_descriptor *) csep;
> +
> +               /* emulate the endpoint attributes of a v1 device */
> +               if (le32_to_cpu(csep3->bmControls) & UAC2_CONTROL_PITCH)
> +                       attributes |= UAC_EP_CS_ATTR_PITCH_CONTROL;
>         }
>
>         return attributes;
> --
> 2.11.0
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

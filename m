Return-Path: <ruslan.bilovol@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524557021; cv=none;
        d=google.com; s=arc-20160816;
        b=jVtUmezg9VftVkUhTOREKJQKLPqBSmnDaC7CGyBd635s0MBxEI2b2g6zkqUDe87qCB
         XMBXEkv1dmPnpHGo7wRsQhmUljr8t9heK/rFsdez8lSBCpM61L15pGpnrJoWxG0rPOC5
         50jBxOqFuBpcX/Y18tahPYz7fyrt+mfb0jyrGsLye4cVih875b+6jfXGOYNlh8JQuLBM
         L7akD25vudpEMQK0Adq2CbU9Q8WeLCKEsdUEeA1e95Pekkenq16VWzBtYgBPL5Ratx9h
         RCTdF6iSOgDAIAithtdI3x5Qa1t+IOo9rxydA9ycM4HpdDaIFEVrQ1hW4C2/m9RJYFZv
         8CBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Th8ZSDHqzoPR+JMst1A3t+bwrxnwTvaNvcvxWmLLQM0=;
        b=oDA0h/B+bDqynzbsmhkO5b0/AhYF0VAopES7FQ5GrcK8skUMZ+LpzDpy//Asi/6RcE
         AeGvcp5nJ0QUL2gWs+F0PpFtwWzYBKwDJ/RivoTdkJ0kcIHv45ZP8Amu8V/aj/4S6inD
         7ksvEcDi5/iO0+jffeW+xwuEhhDZ6YOgdLpAnMzvr9lFR532m2IxWGspfUa6CPt6ST4n
         HMCPosguEh+8ih3cKw55gAQe5WAsCG0YtYz/N+zAU9YGOwh4MWe49tKNAw5zP6ZcNJmq
         tcbNn7ezEI9Qblr7wd1dHafinIS5x8MQwE2Ey83Pm6SDDePVgfE1IO2hOe9Evtdrxhh8
         YZEw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MrXndC9u;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MrXndC9u;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48Y/H3nmQ5I0MvllxQ8aRqUiV1s6gwtnqCYOfvUYkEBgm4KStKB7zUvtrxPVBILpe46Iwt9HVMTBsr7oMuf4U0=
MIME-Version: 1.0
In-Reply-To: <20180420170327.31569-3-jorge.sanjuan@codethink.co.uk>
References: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk> <20180420170327.31569-3-jorge.sanjuan@codethink.co.uk>
From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Date: Tue, 24 Apr 2018 11:03:40 +0300
Message-ID: <CAB=otbQur-_pvTNccni-sNYuemo2aeiyahXUBZLoSALxphAzaA@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 2/4] ALSA: usb-audio: ADC3: Fix channel
 mapping conversion for ADC3.
To: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Cc: Takashi Iwai <tiwai@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	alsa-devel@alsa-project.org, Michael Drake <michael.drake@codethink.co.uk>,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598285488536876967?=
X-GMAIL-MSGID: =?utf-8?q?1598613903050516309?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 20, 2018 at 8:03 PM, Jorge Sanjuan
<jorge.sanjuan@codethink.co.uk> wrote:
> From: Michael Drake <michael.drake@codethink.co.uk>
>
> The channel mapping is defined by bChRelationship, not bChPurpose.
>
> Signed-off-by: Michael Drake <michael.drake@codethink.co.uk>
> ---
>  sound/usb/stream.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/usb/stream.c b/sound/usb/stream.c
> index 6a8f5843334e..956be9f7c72a 100644
> --- a/sound/usb/stream.c
> +++ b/sound/usb/stream.c
> @@ -349,7 +349,7 @@ snd_pcm_chmap_elem *convert_chmap_v3(struct uac3_cluster_header_descriptor
>                          * TODO: this conversion is not complete, update it
>                          * after adding UAC3 values to asound.h
>                          */
> -                       switch (is->bChPurpose) {
> +                       switch (is->bChRelationship) {

Good catch!

Somehow I overlooked this, so in my case of Generic Audio it is always
mono.

Reviewed-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>

>                         case UAC3_CH_MONO:
>                                 map = SNDRV_CHMAP_MONO;
>                                 break;
> --
> 2.11.0
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

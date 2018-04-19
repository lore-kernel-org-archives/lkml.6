Return-Path: <achant@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524131018; cv=none;
        d=google.com; s=arc-20160816;
        b=wuiQgVLGSlqXdS89iQqFcafFSITdi9kzhqaCGQAvkpz+482MNOkA2mxPpRjt3k0s1h
         mWK1Csm/vaEEOVmjIchaHWblChf1QUOCpJTJE4bQMMgEwRNB4rTr6FN+AoXzlBssZKYe
         J8iETjNn1sl+RSIdByHxQtjkJLWgoW77Orh7tOe0FzHZi6hk+llglNFzxNg5upIP3ySc
         /KOfkpyutl3yAUQKq4dr7dV5+sGOUaz6GzXCQGGpoba3IYiOHK8T82ue9EYvefXliwGu
         m3XosUzelmQU5oLU0MJ3hxPoMjiIrqpTlvkx9GMhVfIoIVVWjhyhSGuG9+0ZQ7kaXL7o
         FsfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=cQRSJMMRYwzeAbETa8tD/QEfufv/ewphMKFAPe8IZRI=;
        b=kqtVyfdYjjb2Z/TBT3z+S6kBCJf5FiwHsm/MiGl+55xTpXb+86FZYcQn/uoY3ekGPF
         MpxNabvdXr//LT5kk8plrdt55tXKFDfeFlnJOuzJU2/ovEkc/DgSS1kAkGo7NJCEIcre
         YImvOxxyybWU1DRv15+3ZauGldYbLuEu3F8cDeZzJi9YJM5r+MNA2IkCkp/8eX5y5oR7
         Lh8UhFghRhMAKtdcxrIJDE9iTFaJuaAhGKa50jafQNgcDD7gxTUsZuWa8ctsQN3jPK+6
         COUV8zfwWTYlKO8bqdGTwAYbzmXB76cNRtqiaSVo+rLPtHawuOKClcA090ArxBMfgbke
         l06Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Sk8k8RMP;
       spf=pass (google.com: domain of achant@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=achant@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Sk8k8RMP;
       spf=pass (google.com: domain of achant@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=achant@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx4/eLYxq4ne+hwYrq7RPBGIi56YJi/guO+fpO179Ud/x75Jh54sl2hzoHKMWrYT8ndOKvF4tZpf0LuVYpzOwWlg=
MIME-Version: 1.0
In-Reply-To: <1523658266-2259-5-git-send-email-ruslan.bilovol@gmail.com>
References: <1523658266-2259-1-git-send-email-ruslan.bilovol@gmail.com> <1523658266-2259-5-git-send-email-ruslan.bilovol@gmail.com>
From: Andrew Chant <achant@google.com>
Date: Thu, 19 Apr 2018 17:42:57 +0800
Message-ID: <CANVWZtHn9jYczuhZiKyeC5yf1jjeKFySHv6RkY0ekDj5fD1h+w@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 4/4] ALSA: usb: add UAC3 BADD profiles support
To: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>, Jorge <jorge.sanjuan@codethink.co.uk>,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597671512160670217?=
X-GMAIL-MSGID: =?utf-8?q?1598167206872490609?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 14, 2018 at 6:24 AM, Ruslan Bilovol
<ruslan.bilovol@gmail.com> wrote:
> Recently released USB Audio Class 3.0 specification
> contains BADD (Basic Audio Device Definition) document
> which describes pre-defined UAC3 configurations.
>
> BADD support is mandatory for UAC3 devices, it should be
> implemented as a separate USB device configuration.
> As per BADD document, class-specific descriptors
> shall not be included in the Device=E2=80=99s Configuration
> descriptor ("inferred"), but host can guess them
> from BADD profile number, number of endpoints and
> their max packed sizes.
>
> This patch adds support of all BADD profiles from the spec
>
> Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
> ---
>  sound/usb/card.c       |  14 +++
>  sound/usb/clock.c      |   9 +-
>  sound/usb/mixer.c      | 313 +++++++++++++++++++++++++++++++++++++++++++=
++++--
>  sound/usb/mixer_maps.c |  65 ++++++++++
>  sound/usb/stream.c     |  83 +++++++++++--
>  sound/usb/usbaudio.h   |   2 +
>  6 files changed, 466 insertions(+), 20 deletions(-)

> --- a/sound/usb/mixer_maps.c
> +++ b/sound/usb/mixer_maps.c
> @@ -482,3 +482,68 @@ struct usbmix_ctl_map {
>         { 0 } /* terminator */
>  };
>
> +/*
> + * Control map entries for UAC3 BADD profiles
> + */
> +
> +static struct usbmix_name_map uac3_badd_generic_io_map[] =3D {
> +       { UAC3_BADD_FU_ID2, "Generic Out Playback" },
> +       { UAC3_BADD_FU_ID5, "Generic In Capture" },
> +       { 0 }                                   /* terminator */
> +};
> +static struct usbmix_name_map uac3_badd_headphone_map[] =3D {
> +       { UAC3_BADD_FU_ID2, "Headphone Playback" },
> +       { 0 }                                   /* terminator */
> +};
> +static struct usbmix_name_map uac3_badd_speaker_map[] =3D {
> +       { UAC3_BADD_FU_ID2, "Speaker Playback" },
> +       { 0 }                                   /* terminator */
> +};
> +static struct usbmix_name_map uac3_badd_microphone_map[] =3D {
> +       { UAC3_BADD_FU_ID5, "Mic Capture" },
> +       { 0 }                                   /* terminator */
> +};
> +/* Covers also 'headset adapter' profile */
> +static struct usbmix_name_map uac3_badd_headset_map[] =3D {
> +       { UAC3_BADD_FU_ID2, "Headset Playback" },
> +       { UAC3_BADD_FU_ID5, "Headset Capture" },
> +       { UAC3_BADD_FU_ID7, "Side Tone Mixing" },
Can you please call this "Sidetone"?
This better matches other Sidetone control names in the sound tree and
makes it compatible with existing Android userspace usage.

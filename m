Return-Path: <ruslan.bilovol@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524512876; cv=none;
        d=google.com; s=arc-20160816;
        b=gq9ST+am0zN1NhOLmbig/6XdUlOSmLV2zUskpEX5uMrD7HdZoKPDixn2ZXJXsd8d8Z
         1mMlf5QSjidn836kbXxc4ypJADxm++kbMpq/kGQgwxXuu+BMzYHff4kCnICGfXReO84m
         H5Qcenz8uf5Y7YE0Rwkjn7KYzB5LsVrAFGeb6xvKt4jh5su/Rs196GBKPObU+Z7kYba4
         4W6lr70Pu9Y3o0rmwECkD/OKbqTSkMqmbo6t9EEn3xt/QjG6baBXr6HL93PEvEdmCL1Z
         qNwVvbhRmKQFJTR5dJbwjtKq2HMizt5oXfk5c9qt5AndeJcwq5UmxN7ig1LoH38oncad
         E2Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=JdmvFIiTxJzwEOd4xKaN1uj3w1Gr0yyBeBFnAGVTDJY=;
        b=ELHJe4//Ak6nAYxukbVszeZ/kxNtig4kNUU1kmveLYkoa/8VccqnpQzmxwkz0KGEwn
         CIQgihZ6XjI1rUB7cF+XFSuzu4HranX6uyhhNO7M7OcuAp4spbDoI/MvuUkYLdnz6rZb
         IM/f6NWhSzKXAUKvf+dRT1pKADJ3+GKbSeLO7lqCejiln5BBZYzmdstFnQsvYiJo0HaV
         L8fLhRJjvjnItMFPyZZ7UaEPgZat1VYibRcSVswWs1opKdmusoAZ9MP5An59vlhVyHE3
         BQj0vInjSsE4dN89J/LBrfvCDYzZ/ZaJbaa/esgDbe50rfw+VMRfO7E0xKcpnRZZ01RT
         HkEg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rPC/k96A;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rPC/k96A;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48Oux54v6MiK0Pl52IpLZzXAtkB52svgdZ5L7lj0o6pY+iiGKzyJ7CjNyHjwq80CiS0jg8SXlQyAxrcO60ab7A=
MIME-Version: 1.0
In-Reply-To: <CANVWZtHn9jYczuhZiKyeC5yf1jjeKFySHv6RkY0ekDj5fD1h+w@mail.gmail.com>
References: <1523658266-2259-1-git-send-email-ruslan.bilovol@gmail.com>
 <1523658266-2259-5-git-send-email-ruslan.bilovol@gmail.com> <CANVWZtHn9jYczuhZiKyeC5yf1jjeKFySHv6RkY0ekDj5fD1h+w@mail.gmail.com>
From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Date: Mon, 23 Apr 2018 22:47:55 +0300
Message-ID: <CAB=otbSQ3=_257gn8SK=mAATOeZRzHigpjQcZR_prw6YG327jg@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 4/4] ALSA: usb: add UAC3 BADD profiles support
To: Andrew Chant <achant@google.com>
Cc: Takashi Iwai <tiwai@suse.com>, Jorge <jorge.sanjuan@codethink.co.uk>,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597671512160670217?=
X-GMAIL-MSGID: =?utf-8?q?1598567613582435847?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 12:42 PM, Andrew Chant <achant@google.com> wrote:
> On Sat, Apr 14, 2018 at 6:24 AM, Ruslan Bilovol
> <ruslan.bilovol@gmail.com> wrote:
>> Recently released USB Audio Class 3.0 specification
>> contains BADD (Basic Audio Device Definition) document
>> which describes pre-defined UAC3 configurations.
>>
>> BADD support is mandatory for UAC3 devices, it should be
>> implemented as a separate USB device configuration.
>> As per BADD document, class-specific descriptors
>> shall not be included in the Device=E2=80=99s Configuration
>> descriptor ("inferred"), but host can guess them
>> from BADD profile number, number of endpoints and
>> their max packed sizes.
>>
>> This patch adds support of all BADD profiles from the spec
>>
>> Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
>> ---
>>  sound/usb/card.c       |  14 +++
>>  sound/usb/clock.c      |   9 +-
>>  sound/usb/mixer.c      | 313 ++++++++++++++++++++++++++++++++++++++++++=
+++++--
>>  sound/usb/mixer_maps.c |  65 ++++++++++
>>  sound/usb/stream.c     |  83 +++++++++++--
>>  sound/usb/usbaudio.h   |   2 +
>>  6 files changed, 466 insertions(+), 20 deletions(-)
>
>> --- a/sound/usb/mixer_maps.c
>> +++ b/sound/usb/mixer_maps.c
>> @@ -482,3 +482,68 @@ struct usbmix_ctl_map {
>>         { 0 } /* terminator */
>>  };
>>
>> +/*
>> + * Control map entries for UAC3 BADD profiles
>> + */
>> +
>> +static struct usbmix_name_map uac3_badd_generic_io_map[] =3D {
>> +       { UAC3_BADD_FU_ID2, "Generic Out Playback" },
>> +       { UAC3_BADD_FU_ID5, "Generic In Capture" },
>> +       { 0 }                                   /* terminator */
>> +};
>> +static struct usbmix_name_map uac3_badd_headphone_map[] =3D {
>> +       { UAC3_BADD_FU_ID2, "Headphone Playback" },
>> +       { 0 }                                   /* terminator */
>> +};
>> +static struct usbmix_name_map uac3_badd_speaker_map[] =3D {
>> +       { UAC3_BADD_FU_ID2, "Speaker Playback" },
>> +       { 0 }                                   /* terminator */
>> +};
>> +static struct usbmix_name_map uac3_badd_microphone_map[] =3D {
>> +       { UAC3_BADD_FU_ID5, "Mic Capture" },
>> +       { 0 }                                   /* terminator */
>> +};
>> +/* Covers also 'headset adapter' profile */
>> +static struct usbmix_name_map uac3_badd_headset_map[] =3D {
>> +       { UAC3_BADD_FU_ID2, "Headset Playback" },
>> +       { UAC3_BADD_FU_ID5, "Headset Capture" },
>> +       { UAC3_BADD_FU_ID7, "Side Tone Mixing" },
> Can you please call this "Sidetone"?
> This better matches other Sidetone control names in the sound tree and
> makes it compatible with existing Android userspace usage.

I have no any objections, "Side Tone" was in UAC3 documentation, but
"Sidetone" is OK too, so will change it

Thanks,
Ruslan

Return-Path: <ruslan.bilovol@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526290575; cv=none;
        d=google.com; s=arc-20160816;
        b=gm1xU4mpAJtADh7zIN6wYM9z0bGDBchYfJ7fCCmzOGEQBwCU/ODFYqPKmGfvTtgX3R
         RCvKD3GwQYDrRk5UTF5ZsUGvx0oxVjtD8mEAw1zn2dp/CKriorCLE/2fDCqULPiOBBa3
         JHoUQ4SoWTZQPiNAhHlFkReItwWinDXLaHB3/12SUxdjlrDOU8rBTVMhlfGPOHPwqJTu
         GnAkXcD/+ucLzYOatcJlhZyADeHT7bOWjG0uOQgEnMfQJvQvPw/kWkVHZ+mRncdSdK3o
         Hg/asw4Vg5xLt8mPR3wUPrSWD2kUWln4D8XExjfbeyD9hDkaRz2YRlobpgp+Fvc8gVZN
         9E1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=gvldIfEnic4F9aNRZBHS6OnUZLVvxTOgidLWde0Yot4=;
        b=p11UPFozZB+0IuQaJfP/7/02EY1plpwB0y+burN9oy/V3YgrJWo6UmkBJITuE2EC0k
         tIE20z1Pxkldg55g623E0RARbbQuHsBFBpgP5VLgLIAqEdvElktQ+Hkny3zki29/nlXY
         UIIfRq+OSZDAzBdxxxN4uBARKCIo0iopR65kEJFO+LZ45OKi5AkVCNpWkImiwCiyhf4F
         3/7WzgYEr3giHBQq2yLKa3/e+WcITTxcgOB8uamhFEiV/K2kd73Ek4I4mFDEVgnnO8c1
         0wiIyJRYRasOuX8hSqYt+oSVMXWpJFEE7bOCHGglQFydSHrjmwNBESfAZ5I7nbN/8o/5
         gkPw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=uXkzU1HM;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=uXkzU1HM;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZoqI4sCdXqioLeLXzQxpoXISLF7liHzRHf0Bjv7tq/6DohZesy+NlcMtTh1M1DFcDofZV0Lb04LKmlZRnkMQv4=
MIME-Version: 1.0
In-Reply-To: <e2088eb5-381f-3ad4-8e59-381a729346d0@codethink.co.uk>
References: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
 <20180511152537.32267-1-jorge.sanjuan@codethink.co.uk> <20180511152537.32267-5-jorge.sanjuan@codethink.co.uk>
 <e2088eb5-381f-3ad4-8e59-381a729346d0@codethink.co.uk>
From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Date: Mon, 14 May 2018 12:36:14 +0300
Message-ID: <CAB=otbRx01uackLJtaOKCzT9tc5V9Nc62tV42Pie3rTd-exrKQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] ALSA: usb-audio: UAC3: Parse Input Terminal number
 of channels.
To: Jorge <jorge.sanjuan@codethink.co.uk>
Cc: Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600181868703215105?=
X-GMAIL-MSGID: =?utf-8?q?1600431665926846157?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 11:54 AM, Jorge <jorge.sanjuan@codethink.co.uk> wrote:
>
>
> On 11/05/18 16:25, Jorge Sanjuan wrote:
>>
>> Obtain the number of channels for the Input Terminal from the
>> Logical Cluster Descriptor. This achieves a useful minimal parsing
>> of this unit so it can be used in other units in the topology.
>>
>> Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
>> ---
>>   sound/usb/mixer.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
>> index 431f3c319839..19b25fbc7437 100644
>> --- a/sound/usb/mixer.c
>> +++ b/sound/usb/mixer.c
>> @@ -903,9 +903,9 @@ static int check_input_term(struct mixer_build *state,
>> int id,
>>                                  * recursion calls */
>>                                 term->id = id;
>>                                 term->type =
>> le16_to_cpu(d->wTerminalType);
>> +                               term->channels =
>> get_cluster_channels_v3(state, d->wClusterDescrID);
>
>
>
> Sorry about this. I just spotted that I should have used the helper function
> I added to access d->wClusterDescrID `uac3_mixer_unit_wClusterDescrID`.
>
> I got the sparse warning for the endianess and realized that. I'll resend
> this one patch.

While here, please add checking output of get_cluster_channels_v3() as
it can return negative errno.

BTW, I've just tested your Mixer patches and this is the only comment I have
so far.

Thanks,
Ruslan

>
>>   -                             /* REVISIT: UAC3 IT doesn't have
>> channels/cfg */
>> -                               term->channels = 0;
>> +                               /* REVISIT: UAC3 IT doesn't have channels
>> cfg */
>>                                 term->chconfig = 0;
>>                                 term->name =
>> le16_to_cpu(d->wTerminalDescrStr);
>>
>

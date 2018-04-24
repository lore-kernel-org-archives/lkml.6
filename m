Return-Path: <ruslan.bilovol@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524556304; cv=none;
        d=google.com; s=arc-20160816;
        b=lcaHObIHRXn8B+2hAVWIvpZcw7wXTtTiw+WPhsFuIHGDKTPymZAts2AAXjd0jhfStE
         /8a1rUnLw4dagYuNDDs1nm/MaWnquItiumSAU5DvnGUdwerLYPyp+sOsGgtVpq1Og8Bj
         ogd7IZfAdrMopPz+ApSuCqfnXMy8fLFGhNjNzInFZpowo9MovPKG3YG0RQF49ASFVhxH
         MguBo3ZRg86wr4w2aX+x6m/cu1db78+7t2FtAe/VB2u3E08UsoWNMFZdgzIFzqCzcgdx
         RoN2jguBjppA2W4z9V3iTnm72cgsIKCL46XKm3+3aU3fUyonTRwiNbhg5YlT3Hq2Vexp
         3lag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=hI74kssGDBdtLU66N7OlMYHeHFByoIdl6xJlEvDaiA0=;
        b=gi41xy2ZR6oy0xkUIDvcqD96yO9LbOo1SqS5sDkm/BxmNnp+uz/YOtikyQXDxUP6H2
         e+RpvTFf9ep9/YTpSncy8LtBfx02xofv8S6Sh0LeSszQJgSDnH4dEDCjMp9pDNcDLMCg
         DBj5wIfiFjqXy56PEMnEqHuzg7KTye/MQgk5hzYtonIPQ6awrlGx7UVr6gmwabyNfC1x
         Fgq0otSLyy8U4yiZJEoL4unNeLhP7RYnIhj4eKVxi4+C9HoyPxCKCezfWuNmywzqPwgg
         LQS0zpnQnST2sF1Nq+FRfZ7mvpR+OsrYAwNdIHZz0hK8/WwS8lg9xidSaJti3/z/WRMV
         WGgA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fcnOuDro;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fcnOuDro;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+1t99l/yK1lywSapa44qqLFkJ+PQmVNKFV4oRjPmAkc15DyRg2Ko4arUlbH27vfcLZT8iOiTeW9xSbe9js6Rg=
MIME-Version: 1.0
In-Reply-To: <s5ha7tzzefw.wl-tiwai@suse.de>
References: <1523658266-2259-1-git-send-email-ruslan.bilovol@gmail.com>
 <1523658266-2259-5-git-send-email-ruslan.bilovol@gmail.com> <s5ha7tzzefw.wl-tiwai@suse.de>
From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Date: Tue, 24 Apr 2018 10:51:43 +0300
Message-ID: <CAB=otbScsVWvE35WM8xGrsqYDjntaUgFRM3XSuzktsjZo9op1g@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 4/4] ALSA: usb: add UAC3 BADD profiles support
To: Takashi Iwai <tiwai@suse.de>
Cc: Jorge <jorge.sanjuan@codethink.co.uk>, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597671512160670217?=
X-GMAIL-MSGID: =?utf-8?q?1598613151507575660?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 1:19 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Sat, 14 Apr 2018 00:24:26 +0200,
> Ruslan Bilovol wrote:
>>
>> +static void build_feature_ctl_badd(struct usb_mixer_interface *mixer,
>> +                           unsigned int ctl_mask, int control, int unitid,
>> +                           const struct usbmix_name_map *badd_map)
>> +{
> ....
>> +     kctl = snd_ctl_new1(&usb_feature_unit_ctl, cval);
>> +
>> +     if (!kctl) {
>> +             usb_audio_err(mixer->chip, "cannot malloc kcontrol\n");
>
> No need for error message after malloc failure.  The kernel is already
> chatty about it.

Okay. BTW, I'm trying to avoid separate badd variant of
build_feature_ctl(), so this most probably will go away.

There are many existing places in usb-snd which can be cleaned
up though.

>
>
>> +static int snd_usb_mixer_controls_badd(struct usb_mixer_interface *mixer,
>> +                                    int ctrlif)
>> +{
>> +     struct usb_device *dev = mixer->chip->dev;
>> +     struct usb_interface_assoc_descriptor *assoc;
>> +     int badd_profile = mixer->chip->badd_profile;
>> +     const struct usbmix_ctl_map *map;
>> +     int p_chmask = 0, c_chmask = 0, st_chmask = 0;
>> +     int i;
>> +
>> +     assoc = usb_ifnum_to_if(dev, ctrlif)->intf_assoc;
>> +
>> +     /* Detect BADD capture/playback channels from AS EP descriptors */
>> +     for (i = 0; i < assoc->bInterfaceCount; i++) {
>> +             int intf = assoc->bFirstInterface + i;
>> +
>> +             if (intf != ctrlif) {
>
> In this case, it's better to skip like
>
>                 if (intf == ctrlif)
>                         continue;
>
> so that we can save an indentation for the whole long block.

Good point, will do it

>
>> +     switch (badd_profile) {
>> +     default:
>> +             return -EINVAL;
>> +     case UAC3_FUNCTION_SUBCLASS_GENERIC_IO:
>> +             /*
>> +              * BAIF, BAOF or combination of both
>> +              * IN: Mono or Stereo cfg, Mono alt possible
>> +              * OUT: Mono or Stereo cfg, Mono alt possible
>> +              */
>> +             /* c_chmask := DYNAMIC */
>> +             /* p_chmask := DYNAMIC */
>> +             if (!c_chmask && !p_chmask) {
>> +                     usb_audio_err(mixer->chip,
>> +                             "BADD GENERIC_IO profile: no channels?\n");
>> +                     return -EINVAL;
>> +             }
>> +             break;
>
> Maybe we can simplify the whole switch/case with a table lookup.

Yes, it should be possible, I'll implent it that way

Thanks,
Ruslan

> For example,
>
>         for (f = uac3_func_tables; f->name; f++) {
>                 if (badd_profile == f->subclass)
>                         break;
>         }
>         if (!f->name)
>                 return -EINVAL;
>         if (!uac3_func_has_valid_channels(mixer, f, c_chmask, p_chmask))
>                 return -EINVAL;
>         st_chmask = f->st_chmask;
>
> and in uac3_func_has_valid_channels(),
>
> static bool uac3_func_has_valid_channels()
> {
>         if ((f->c_chmask < 0 && !c_chmask) ||
>             (f->c_chmask >= 0 && f->c_chmask != c_chmask)) {
>                 usb_audio_warn(mixer->chip, "BAAD %s c_chmask mismatch",
>                                 f->name);
>                 return false;
>         }
>         if ((f->p_chmask < 0 && !p_chmask) ||
>             (f->p_chmask >= 0 && f->p_chmask != p_chmask)) {
>                 usb_audio_warn(mixer->chip, "BAAD %s p_chmask mismatch",
>                                 f->name);
>                 return false;
>         }
>         return true;
> }
>
>
> thanks,
>
> Takashi

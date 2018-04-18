Return-Path: <ruslan.bilovol@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524012108; cv=none;
        d=google.com; s=arc-20160816;
        b=UJGaye4IygN1BWY7A7XFHzK72UA5HXLRsVl2GxKGRaJVnlcHFl5px67nuAEamraD2D
         ajn59ri76ZAeLG+8B2Jrc1HBnojWNK/u8pW+3CZ+dNobG5csWht6UB4tfesaTAfnxMwr
         DBmDngmEr6VPG7jqBlByvcmjpLFh+xkDuqg+TImcVQOyVLiec0qkYqZ8NswTyMnL5tB/
         iX03HFDh8FB4Cpo/dGc7Ed1y1pUmGU9E/Pxqkj5oXDWT7Qeb3qyR33CQowcfypF/GJbd
         2TdWwiXi7/mzzdjZims3nI1SbVurGVAN5FpHXhvZXmQxlxCKF3b94J+t5wHmk2nXTf2f
         jHcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=/bMQ9I7Bu98CIWaBV37VqZ6sC0GgiAPe/+X3bkjc0WI=;
        b=HOKvFF8GejvtgA6Y2M27jaD6Qlje2iSmq6Gc7ZpEmaUxOi5fLEDxWF+potR1sVFFrJ
         wcK7SJ+Wdjju2MkdoiHHXDZP3Y7xvHYgJ8k/ZYTAYSBiKyrYY+oBnXlGUjDn6tp75a+I
         GqtYUicRUNb0RHPkiopDmCsPnBXrg7rTahS51YGnvd9qkkCHFnUDIEYL3g+RGTfRWVhd
         kcwaEmsNxMsCg5dMrYFfBpPQ6JpbS4NkXK1/h0p9WZYkiS0IP54wzLcyeHqo8kO5jHrB
         E2FsBmb5iap5hHthAse2+WFxtGs8aQl8ez8sfXNcin0+MtCrXJBsrw4T9HUaOKa45cSC
         fUyg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=l6LeFO0U;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=l6LeFO0U;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/yvcj3xoMNA/2cz4y8Vh5pcXlGGnGZf3mZJlqKYODmzXFJqS19jdKq1K2Usw2XIKtNxlLyAXtqu10q8nMOj+Y=
MIME-Version: 1.0
In-Reply-To: <298440e44133287c3f86a0cae2fd08e1@codethink.com>
References: <1523658266-2259-1-git-send-email-ruslan.bilovol@gmail.com>
 <1523658266-2259-5-git-send-email-ruslan.bilovol@gmail.com> <298440e44133287c3f86a0cae2fd08e1@codethink.com>
From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Date: Wed, 18 Apr 2018 03:41:47 +0300
Message-ID: <CAB=otbRVOF+EU+Hm+oAN6S1MjTYpwKNBVFnBRYG62u_92hEtMQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] ALSA: usb: add UAC3 BADD profiles support
To: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Cc: Takashi Iwai <tiwai@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597671512160670217?=
X-GMAIL-MSGID: =?utf-8?q?1598042520674466073?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 14, 2018 at 8:55 PM, Jorge Sanjuan
<jorge.sanjuan@codethink.co.uk> wrote:
>
>
> On 2018-04-13 23:24, Ruslan Bilovol wrote:
>>
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
>
>
> Right. I would have thought that, since BADD is a subset of UAC3, it may =
be
> simpler to fill the Class Specific descriptors buffer and let the UAC3 pa=
th
> intact as it would result in the same behavior (for UAC3 and BADD configs=
)
> without the need to add that much code to the mixer, which is already qui=
te
> big.
>
> In the patch I proposed [1], the Class Specific buffer is filled once wit=
h
> the BADD descriptors, which are already UAC3 compliant, so the driver wou=
ld
> handle the rest in the same way it would do with an UAC3 configuration.

That was looking as a good idea to me as well when I seen patch [1] first
time. However, after thinking a bit more, I realized that in mixer.c we
just need to initialize from one to three feature units for any BADD profil=
e.
Mentioned Feature Units are simple and can have only Volume/Mute controls.
We also have nothing to do with Mixer Unit (which exists in BAIOF
topology) since it doesn't have any controls.
Most of the code there is to just detect all possible combinations of
channels, topologies (BAIF, BAOF, BAIOF, BAIF+BAOF) for BADD profiles,
and to add some meaningful names for feature unit controls, which
are missing in the descriptors.
The only change in the mixer.c I'm unhappy with is to have separate
build_feature_ctl_badd() function that is nothing else but simplified
version of build_feature_ctl() function; but I already have an idea how to
reuse original one for BADD case.

Changes to stream.c are very simple and straightforward, almost all
values are common/predefined for all BADD profiles except channel
numbers and sample size.

So as a boottom line direct changes to mixer/stream code seems more
easy and understandable in this particular case rather than generating
all needed class-specific desriptors. And we have all BADD profiles
support in this quite short patch.

Thanks,
Ruslan

>
> I will keep an eye on this as I'd need to do some work based on this
> instead.
>
> [1] https://www.spinics.net/lists/alsa-devel/msg71617.html
>
> Thanks,
>
> Jorge
>
>>
>> This patch adds support of all BADD profiles from the spec
>>
>> Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
>> ---
>>  sound/usb/card.c       |  14 +++
>>  sound/usb/clock.c      |   9 +-
>>  sound/usb/mixer.c      | 313
>> +++++++++++++++++++++++++++++++++++++++++++++++--
>>  sound/usb/mixer_maps.c |  65 ++++++++++
>>  sound/usb/stream.c     |  83 +++++++++++--
>>  sound/usb/usbaudio.h   |   2 +
>>  6 files changed, 466 insertions(+), 20 deletions(-)
>>
>> diff --git a/sound/usb/card.c b/sound/usb/card.c
>> index 4d866bd..47ebc50 100644
>> --- a/sound/usb/card.c
>> +++ b/sound/usb/card.c
>> @@ -307,6 +307,20 @@ static int snd_usb_create_streams(struct
>> snd_usb_audio *chip, int ctrlif)
>>                         return -EINVAL;
>>                 }
>>
>> +               if (protocol =3D=3D UAC_VERSION_3) {
>> +                       int badd =3D assoc->bFunctionSubClass;
>> +
>> +                       if (badd !=3D UAC3_FUNCTION_SUBCLASS_FULL_ADC_3_=
0 &&
>> +                           (badd < UAC3_FUNCTION_SUBCLASS_GENERIC_IO ||
>> +                            badd > UAC3_FUNCTION_SUBCLASS_SPEAKERPHONE)=
)
>> {
>> +                               dev_err(&dev->dev,
>> +                                       "Unsupported UAC3 BADD
>> profile\n");
>> +                               return -EINVAL;
>> +                       }
>> +
>> +                       chip->badd_profile =3D badd;
>> +               }
>> +
>>                 for (i =3D 0; i < assoc->bInterfaceCount; i++) {
>>                         int intf =3D assoc->bFirstInterface + i;
>>
>> diff --git a/sound/usb/clock.c b/sound/usb/clock.c
>> index 0b030d8..17673f3 100644
>> --- a/sound/usb/clock.c
>> +++ b/sound/usb/clock.c
>> @@ -587,8 +587,15 @@ int snd_usb_init_sample_rate(struct snd_usb_audio
>> *chip, int iface,
>>         default:
>>                 return set_sample_rate_v1(chip, iface, alts, fmt, rate);
>>
>> -       case UAC_VERSION_2:
>>         case UAC_VERSION_3:
>> +               if (chip->badd_profile >=3D
>> UAC3_FUNCTION_SUBCLASS_GENERIC_IO) {
>> +                       if (rate !=3D UAC3_BADD_SAMPLING_RATE)
>> +                               return -ENXIO;
>> +                       else
>> +                               return 0;
>> +               }
>> +       /* fall through */
>> +       case UAC_VERSION_2:
>>                 return set_sample_rate_v2v3(chip, iface, alts, fmt, rate=
);
>>         }
>>  }
>> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
>> index 301ad61..e5c3b0d 100644
>> --- a/sound/usb/mixer.c
>> +++ b/sound/usb/mixer.c
>> @@ -112,14 +112,12 @@ enum {
>>  #include "mixer_maps.c"
>>
>>  static const struct usbmix_name_map *
>> -find_map(struct mixer_build *state, int unitid, int control)
>> +find_map(const struct usbmix_name_map *p, int unitid, int control)
>>  {
>> -       const struct usbmix_name_map *p =3D state->map;
>> -
>>         if (!p)
>>                 return NULL;
>>
>> -       for (p =3D state->map; p->id; p++) {
>> +       for (; p->id; p++) {
>>                 if (p->id =3D=3D unitid &&
>>                     (!control || !p->control || control =3D=3D p->contro=
l))
>>                         return p;
>> @@ -1333,6 +1331,76 @@ static struct usb_feature_control_info
>> *get_feature_control_info(int control)
>>         return NULL;
>>  }
>>
>> +static void build_feature_ctl_badd(struct usb_mixer_interface *mixer,
>> +                             unsigned int ctl_mask, int control, int
>> unitid,
>> +                             const struct usbmix_name_map *badd_map)
>> +{
>> +       struct usb_feature_control_info *ctl_info;
>> +       unsigned int len =3D 0;
>> +       struct snd_kcontrol *kctl;
>> +       struct usb_mixer_elem_info *cval;
>> +       const struct usbmix_name_map *map;
>> +
>> +       map =3D find_map(badd_map, unitid, control);
>> +       if (!map)
>> +               return;
>> +
>> +       cval =3D kzalloc(sizeof(*cval), GFP_KERNEL);
>> +       if (!cval)
>> +               return;
>> +       snd_usb_mixer_elem_init_std(&cval->head, mixer, unitid);
>> +       cval->control =3D control;
>> +       cval->cmask =3D ctl_mask;
>> +
>> +       ctl_info =3D get_feature_control_info(control);
>> +       if (!ctl_info) {
>> +               kfree(cval);
>> +               return;
>> +       }
>> +       cval->val_type =3D ctl_info->type;
>> +
>> +       if (ctl_mask =3D=3D 0) {
>> +               cval->channels =3D 1;     /* master channel */
>> +       } else {
>> +               int i, c =3D 0;
>> +
>> +               for (i =3D 0; i < 2; i++)
>> +                       if (ctl_mask & (1 << i))
>> +                               c++;
>> +               cval->channels =3D c;
>> +       }
>> +
>> +       kctl =3D snd_ctl_new1(&usb_feature_unit_ctl, cval);
>> +
>> +       if (!kctl) {
>> +               usb_audio_err(mixer->chip, "cannot malloc kcontrol\n");
>> +               kfree(cval);
>> +               return;
>> +       }
>> +       kctl->private_free =3D snd_usb_mixer_elem_free;
>> +       len =3D check_mapped_name(map, kctl->id.name,
>> sizeof(kctl->id.name));
>> +
>> +       append_ctl_name(kctl, control =3D=3D UAC_FU_MUTE ? " Switch" : "
>> Volume");
>> +
>> +       /* get min/max values */
>> +       get_min_max_with_quirks(cval, 0, kctl);
>> +
>> +       if (control =3D=3D UAC_FU_VOLUME) {
>> +               check_mapped_dB(map, cval);
>> +               if (cval->dBmin < cval->dBmax || !cval->initialized) {
>> +                       kctl->tlv.c =3D snd_usb_mixer_vol_tlv;
>> +                       kctl->vd[0].access |=3D
>> +                               SNDRV_CTL_ELEM_ACCESS_TLV_READ |
>> +                               SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK;
>> +               }
>> +       }
>> +
>> +       usb_audio_dbg(mixer->chip, "[%d] FU [%s] ch =3D %d, val =3D
>> %d/%d/%d\n",
>> +                     cval->head.id, kctl->id.name, cval->channels,
>> +                     cval->min, cval->max, cval->res);
>> +       snd_usb_mixer_add_control(&cval->head, kctl);
>> +}
>> +
>>  static void build_feature_ctl(struct mixer_build *state, void *raw_desc=
,
>>                               unsigned int ctl_mask, int control,
>>                               struct usb_audio_term *iterm, int unitid,
>> @@ -1353,7 +1421,7 @@ static void build_feature_ctl(struct mixer_build
>> *state, void *raw_desc,
>>                 return;
>>         }
>>
>> -       map =3D find_map(state, unitid, control);
>> +       map =3D find_map(state->map, unitid, control);
>>         if (check_ignored_ctl(map))
>>                 return;
>>
>> @@ -1806,7 +1874,7 @@ static void build_mixer_unit_ctl(struct
>> mixer_build *state,
>>         struct snd_kcontrol *kctl;
>>         const struct usbmix_name_map *map;
>>
>> -       map =3D find_map(state, unitid, 0);
>> +       map =3D find_map(state->map, unitid, 0);
>>         if (check_ignored_ctl(map))
>>                 return;
>>
>> @@ -2105,7 +2173,7 @@ static int build_audio_procunit(struct
>> mixer_build *state, int unitid,
>>
>>                 if (!(controls[valinfo->control / 8] & (1 <<
>> ((valinfo->control % 8) - 1))))
>>                         continue;
>> -               map =3D find_map(state, unitid, valinfo->control);
>> +               map =3D find_map(state->map, unitid, valinfo->control);
>>                 if (check_ignored_ctl(map))
>>                         continue;
>>                 cval =3D kzalloc(sizeof(*cval), GFP_KERNEL);
>> @@ -2308,7 +2376,7 @@ static int parse_audio_selector_unit(struct
>> mixer_build *state, int unitid,
>>         if (desc->bNrInPins =3D=3D 1) /* only one ? nonsense! */
>>                 return 0;
>>
>> -       map =3D find_map(state, unitid, 0);
>> +       map =3D find_map(state->map, unitid, 0);
>>         if (check_ignored_ctl(map))
>>                 return 0;
>>
>> @@ -2495,6 +2563,226 @@ static int snd_usb_mixer_dev_free(struct
>> snd_device *device)
>>  }
>>
>>  /*
>> + * create mixer controls for UAC3 BADD profiles
>> + *
>> + * UAC3 BADD device doesn't contain CS descriptors thus we will guess
>> everything
>> + *
>> + * BADD device may contain Mixer Unit, which doesn't have any controls,
>> skip it
>> + */
>> +static int snd_usb_mixer_controls_badd(struct usb_mixer_interface *mixe=
r,
>> +                                      int ctrlif)
>> +{
>> +       struct usb_device *dev =3D mixer->chip->dev;
>> +       struct usb_interface_assoc_descriptor *assoc;
>> +       int badd_profile =3D mixer->chip->badd_profile;
>> +       const struct usbmix_ctl_map *map;
>> +       int p_chmask =3D 0, c_chmask =3D 0, st_chmask =3D 0;
>> +       int i;
>> +
>> +       assoc =3D usb_ifnum_to_if(dev, ctrlif)->intf_assoc;
>> +
>> +       /* Detect BADD capture/playback channels from AS EP descriptors =
*/
>> +       for (i =3D 0; i < assoc->bInterfaceCount; i++) {
>> +               int intf =3D assoc->bFirstInterface + i;
>> +
>> +               if (intf !=3D ctrlif) {
>> +                       struct usb_interface *iface;
>> +                       struct usb_host_interface *alts;
>> +                       struct usb_interface_descriptor *altsd;
>> +                       unsigned int maxpacksize;
>> +                       char dir_in;
>> +                       int chmask, num;
>> +
>> +                       iface =3D usb_ifnum_to_if(dev, intf);
>> +                       num =3D iface->num_altsetting;
>> +
>> +                       if (num < 2)
>> +                               return -EINVAL;
>> +
>> +                       /*
>> +                        * The number of Channels in an AudioStreaming
>> interface
>> +                        * and the audio sample bit resolution (16 bits =
or
>> 24
>> +                        * bits) can be derived from the wMaxPacketSize
>> field in
>> +                        * the Standard AS Audio Data Endpoint descripto=
r
>> in
>> +                        * Alternate Setting 1
>> +                        */
>> +                       alts =3D &iface->altsetting[1];
>> +                       altsd =3D get_iface_desc(alts);
>> +
>> +                       if (altsd->bNumEndpoints < 1)
>> +                               return -EINVAL;
>> +
>> +                       /* check direction */
>> +                       dir_in =3D (get_endpoint(alts, 0)->bEndpointAddr=
ess
>> & USB_DIR_IN);
>> +                       maxpacksize =3D le16_to_cpu(get_endpoint(alts,
>> 0)->wMaxPacketSize);
>> +
>> +                       switch (maxpacksize) {
>> +                       default:
>> +                               usb_audio_err(mixer->chip,
>> +                                       "incorrect wMaxPacketSize 0x%x f=
or
>> BADD profile\n",
>> +                                       maxpacksize);
>> +                               return -EINVAL;
>> +                       case UAC3_BADD_EP_MAXPSIZE_SYNC_MONO_16:
>> +                       case UAC3_BADD_EP_MAXPSIZE_ASYNC_MONO_16:
>> +                       case UAC3_BADD_EP_MAXPSIZE_SYNC_MONO_24:
>> +                       case UAC3_BADD_EP_MAXPSIZE_ASYNC_MONO_24:
>> +                               chmask =3D 1;
>> +                               break;
>> +                       case UAC3_BADD_EP_MAXPSIZE_SYNC_STEREO_16:
>> +                       case UAC3_BADD_EP_MAXPSIZE_ASYNC_STEREO_16:
>> +                       case UAC3_BADD_EP_MAXPSIZE_SYNC_STEREO_24:
>> +                       case UAC3_BADD_EP_MAXPSIZE_ASYNC_STEREO_24:
>> +                               chmask =3D 3;
>> +                               break;
>> +                       }
>> +
>> +                       if (dir_in)
>> +                               c_chmask =3D chmask;
>> +                       else
>> +                               p_chmask =3D chmask;
>> +               }
>> +       }
>> +
>> +       usb_audio_dbg(mixer->chip,
>> +               "UAC3 BADD profile 0x%x: detected c_chmask=3D%d
>> p_chmask=3D%d\n",
>> +               badd_profile, c_chmask, p_chmask);
>> +
>> +       /* check the mapping table */
>> +       for (map =3D uac3_badd_usbmix_ctl_maps; map->id; map++) {
>> +               if (map->id =3D=3D badd_profile) {
>> +                       mixer->ignore_ctl_error =3D map->ignore_ctl_erro=
r;
>> +                       break;
>> +               }
>> +       }
>> +
>> +       if (!map->id)
>> +               return -EINVAL;
>> +
>> +       switch (badd_profile) {
>> +       default:
>> +               return -EINVAL;
>> +       case UAC3_FUNCTION_SUBCLASS_GENERIC_IO:
>> +               /*
>> +                * BAIF, BAOF or combination of both
>> +                * IN: Mono or Stereo cfg, Mono alt possible
>> +                * OUT: Mono or Stereo cfg, Mono alt possible
>> +                */
>> +               /* c_chmask :=3D DYNAMIC */
>> +               /* p_chmask :=3D DYNAMIC */
>> +               if (!c_chmask && !p_chmask) {
>> +                       usb_audio_err(mixer->chip,
>> +                               "BADD GENERIC_IO profile: no
>> channels?\n");
>> +                       return -EINVAL;
>> +               }
>> +               break;
>> +       case UAC3_FUNCTION_SUBCLASS_HEADPHONE:
>> +               /* BAOF; Stereo only cfg, Mono alt possible */
>> +               if (p_chmask !=3D 3)
>> +                       usb_audio_warn(mixer->chip,
>> +                               "BADD HEADPHONE p_chmask mismatch:
>> expected 3 actual %d\n",
>> +                               p_chmask);
>> +               p_chmask =3D 3;
>> +               break;
>> +       case UAC3_FUNCTION_SUBCLASS_SPEAKER:
>> +               /* BAOF; Mono or Stereo cfg, Mono alt possible */
>> +               /* p_chmask :=3D DYNAMIC */
>> +               if (!p_chmask) {
>> +                       usb_audio_err(mixer->chip,
>> +                               "BADD SPEAKER profile: no playback
>> channels?\n");
>> +                       return -EINVAL;
>> +               }
>> +               break;
>> +       case UAC3_FUNCTION_SUBCLASS_MICROPHONE:
>> +               /* BAIF; Mono or Stereo cfg, Mono alt possible */
>> +               /* c_chmask :=3D DYNAMIC */
>> +               if (!c_chmask) {
>> +                       usb_audio_err(mixer->chip,
>> +                               "BADD MICROPHONE profile: no capture
>> channels?\n");
>> +                       return -EINVAL;
>> +               }
>> +               break;
>> +       case UAC3_FUNCTION_SUBCLASS_HEADSET:
>> +               /*
>> +                * BAIOF
>> +                * IN: Mono only
>> +                * OUT: Mono or Stereo cfg, Mono alt possible
>> +                */
>> +               if (c_chmask !=3D 1)
>> +                       usb_audio_warn(mixer->chip,
>> +                               "BADD HEADSET c_chmask mismatch: expecte=
d
>> 1 actual %d\n",
>> +                               c_chmask);
>> +               c_chmask =3D 1;
>> +               st_chmask =3D 1;
>> +               /* p_chmask :=3D DYNAMIC */
>> +               if (!p_chmask) {
>> +                       usb_audio_err(mixer->chip,
>> +                               "BADD HEADSET profile: no playback
>> channels?\n");
>> +                       return -EINVAL;
>> +               }
>> +               break;
>> +       case UAC3_FUNCTION_SUBCLASS_HEADSET_ADAPTER:
>> +               /* BAIOF; IN: Mono only; OUT: Stereo only, Mono alt
>> possible */
>> +               if (c_chmask !=3D 1)
>> +                       usb_audio_warn(mixer->chip,
>> +                               "BADD HEADSET_ADAPTER c_chmask mismatch:
>> expected 1 actual %d\n",
>> +                               c_chmask);
>> +               if (p_chmask !=3D 3)
>> +                       usb_audio_warn(mixer->chip,
>> +                               "BADD HEADSET_ADAPTER p_chmask mismatch:
>> expected 3 actual %d\n",
>> +                               p_chmask);
>> +               c_chmask =3D 1;
>> +               st_chmask =3D 1;
>> +               p_chmask =3D 3;
>> +               break;
>> +       case UAC3_FUNCTION_SUBCLASS_SPEAKERPHONE:
>> +               /* BAIF + BAOF; IN: Mono only; OUT: Mono only */
>> +               if (c_chmask !=3D 1)
>> +                       usb_audio_warn(mixer->chip,
>> +                               "BADD SPEAKERPHONE c_chmask mismatch:
>> expected 1 actual %d\n",
>> +                               c_chmask);
>> +               if (p_chmask !=3D 1)
>> +                       usb_audio_warn(mixer->chip,
>> +                               "BADD SPEAKERPHONE p_chmask mismatch:
>> expected 1 actual %d\n",
>> +                               p_chmask);
>> +               c_chmask =3D 1;
>> +               p_chmask =3D 1;
>> +               break;
>> +       }
>> +
>> +       /* Playback */
>> +       if (p_chmask) {
>> +               /* Master channel, always writable */
>> +               build_feature_ctl_badd(mixer, 0, UAC_FU_MUTE,
>> +                                      UAC3_BADD_FU_ID2, map->map);
>> +               /* Mono/Stereo volume channels, always writable */
>> +               build_feature_ctl_badd(mixer, p_chmask, UAC_FU_VOLUME,
>> +                                      UAC3_BADD_FU_ID2, map->map);
>> +       }
>> +
>> +       /* Capture */
>> +       if (c_chmask) {
>> +               /* Master channel, always writable */
>> +               build_feature_ctl_badd(mixer, 0, UAC_FU_MUTE,
>> +                                      UAC3_BADD_FU_ID5, map->map);
>> +               /* Mono/Stereo volume channels, always writable */
>> +               build_feature_ctl_badd(mixer, c_chmask, UAC_FU_VOLUME,
>> +                                      UAC3_BADD_FU_ID5, map->map);
>> +       }
>> +
>> +       /* Side tone-mixing */
>> +       if (st_chmask) {
>> +               /* Master channel, always writable */
>> +               build_feature_ctl_badd(mixer, 0, UAC_FU_MUTE,
>> +                                      UAC3_BADD_FU_ID7, map->map);
>> +               /* Mono volume channel, always writable */
>> +               build_feature_ctl_badd(mixer, 1, UAC_FU_VOLUME,
>> +                                      UAC3_BADD_FU_ID7, map->map);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +/*
>>   * create mixer controls
>>   *
>>   * walk through all UAC_OUTPUT_TERMINAL descriptors to search for mixer=
s
>> @@ -2838,9 +3126,14 @@ int snd_usb_create_mixer(struct snd_usb_audio
>> *chip, int ctrlif,
>>                 break;
>>         }
>>
>> -       if ((err =3D snd_usb_mixer_controls(mixer)) < 0 ||
>> -           (err =3D snd_usb_mixer_status_create(mixer)) < 0)
>> +       if (mixer->protocol =3D=3D UAC_VERSION_3 &&
>> +                       chip->badd_profile >=3D
>> UAC3_FUNCTION_SUBCLASS_GENERIC_IO) {
>> +               if ((err =3D snd_usb_mixer_controls_badd(mixer, ctrlif))=
 <
>> 0)
>> +                       goto _error;
>> +       } else if ((err =3D snd_usb_mixer_controls(mixer)) < 0 ||
>> +                       (err =3D snd_usb_mixer_status_create(mixer)) < 0=
) {
>>                 goto _error;
>> +       }
>>
>>         snd_usb_mixer_apply_create_quirk(mixer);
>>
>> diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
>> index 9038b2e..13f03c8 100644
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
>> +       { 0 }                                   /* terminator */
>> +};
>> +static struct usbmix_name_map uac3_badd_speakerphone_map[] =3D {
>> +       { UAC3_BADD_FU_ID2, "Speaker Playback" },
>> +       { UAC3_BADD_FU_ID5, "Mic Capture" },
>> +       { 0 }                                   /* terminator */
>> +};
>> +
>> +static struct usbmix_ctl_map uac3_badd_usbmix_ctl_maps[] =3D {
>> +       {
>> +               .id =3D UAC3_FUNCTION_SUBCLASS_GENERIC_IO,
>> +               .map =3D uac3_badd_generic_io_map,
>> +       },
>> +       {
>> +               .id =3D UAC3_FUNCTION_SUBCLASS_HEADPHONE,
>> +               .map =3D uac3_badd_headphone_map,
>> +       },
>> +       {
>> +               .id =3D UAC3_FUNCTION_SUBCLASS_SPEAKER,
>> +               .map =3D uac3_badd_speaker_map,
>> +       },
>> +       {
>> +               .id =3D UAC3_FUNCTION_SUBCLASS_MICROPHONE,
>> +               .map =3D uac3_badd_microphone_map,
>> +       },
>> +       {
>> +               .id =3D UAC3_FUNCTION_SUBCLASS_HEADSET,
>> +               .map =3D uac3_badd_headset_map,
>> +       },
>> +       {
>> +               .id =3D UAC3_FUNCTION_SUBCLASS_HEADSET_ADAPTER,
>> +               .map =3D uac3_badd_headset_map,
>> +       },
>> +       {
>> +               .id =3D UAC3_FUNCTION_SUBCLASS_SPEAKERPHONE,
>> +               .map =3D uac3_badd_speakerphone_map,
>> +       },
>> +       { 0 } /* terminator */
>> +};
>> diff --git a/sound/usb/stream.c b/sound/usb/stream.c
>> index 586d664..ea5a13e0 100644
>> --- a/sound/usb/stream.c
>> +++ b/sound/usb/stream.c
>> @@ -798,15 +798,67 @@ static int parse_uac_endpoint_attributes(struct
>> snd_usb_audio *chip,
>>         struct uac3_input_terminal_descriptor *input_term;
>>         struct uac3_output_terminal_descriptor *output_term;
>>         struct uac3_cluster_header_descriptor *cluster;
>> -       struct uac3_as_header_descriptor *as;
>> +       struct uac3_as_header_descriptor *as =3D NULL;
>>         struct uac3_hc_descriptor_header hc_header;
>>         struct snd_pcm_chmap_elem *chmap;
>> +       unsigned char badd_profile;
>> +       u64 badd_formats  =3D 0;
>>         unsigned int num_channels;
>>         struct audioformat *fp;
>>         u16 cluster_id, wLength;
>>         int clock =3D 0;
>>         int err;
>>
>> +       badd_profile =3D chip->badd_profile;
>> +
>> +       if (badd_profile >=3D UAC3_FUNCTION_SUBCLASS_GENERIC_IO) {
>> +               unsigned int maxpacksize =3D
>> +                       le16_to_cpu(get_endpoint(alts,
>> 0)->wMaxPacketSize);
>> +
>> +               switch (maxpacksize) {
>> +               default:
>> +                       dev_err(&dev->dev,
>> +                               "%u:%d : incorrect wMaxPacketSize for BA=
DD
>> profile\n",
>> +                               iface_no, altno);
>> +                       return NULL;
>> +               case UAC3_BADD_EP_MAXPSIZE_SYNC_MONO_16:
>> +               case UAC3_BADD_EP_MAXPSIZE_ASYNC_MONO_16:
>> +                       badd_formats =3D SNDRV_PCM_FMTBIT_S16_LE;
>> +                       num_channels =3D 1;
>> +                       break;
>> +               case UAC3_BADD_EP_MAXPSIZE_SYNC_MONO_24:
>> +               case UAC3_BADD_EP_MAXPSIZE_ASYNC_MONO_24:
>> +                       badd_formats =3D SNDRV_PCM_FMTBIT_S24_3LE;
>> +                       num_channels =3D 1;
>> +                       break;
>> +               case UAC3_BADD_EP_MAXPSIZE_SYNC_STEREO_16:
>> +               case UAC3_BADD_EP_MAXPSIZE_ASYNC_STEREO_16:
>> +                       badd_formats =3D SNDRV_PCM_FMTBIT_S16_LE;
>> +                       num_channels =3D 2;
>> +                       break;
>> +               case UAC3_BADD_EP_MAXPSIZE_SYNC_STEREO_24:
>> +               case UAC3_BADD_EP_MAXPSIZE_ASYNC_STEREO_24:
>> +                       badd_formats =3D SNDRV_PCM_FMTBIT_S24_3LE;
>> +                       num_channels =3D 2;
>> +                       break;
>> +               }
>> +
>> +               chmap =3D kzalloc(sizeof(*chmap), GFP_KERNEL);
>> +               if (!chmap)
>> +                       return ERR_PTR(-ENOMEM);
>> +
>> +               if (num_channels =3D=3D 1) {
>> +                       chmap->map[0] =3D SNDRV_CHMAP_MONO;
>> +               } else {
>> +                       chmap->map[0] =3D SNDRV_CHMAP_FL;
>> +                       chmap->map[1] =3D SNDRV_CHMAP_FR;
>> +               }
>> +
>> +               chmap->channels =3D num_channels;
>> +               clock =3D UAC3_BADD_CS_ID9;
>> +               goto found_clock;
>> +       }
>> +
>>         as =3D snd_usb_find_csint_desc(alts->extra, alts->extralen,
>>                                      NULL, UAC_AS_GENERAL);
>>         if (!as) {
>> @@ -922,18 +974,31 @@ static int parse_uac_endpoint_attributes(struct
>> snd_usb_audio *chip,
>>         if (snd_usb_get_speed(dev) =3D=3D USB_SPEED_HIGH)
>>                 fp->maxpacksize =3D (((fp->maxpacksize >> 11) & 3) + 1)
>>                                 * (fp->maxpacksize & 0x7ff);
>> -       fp->attributes =3D parse_uac_endpoint_attributes(chip, alts,
>> -                                                      UAC_VERSION_3,
>> -                                                      iface_no);
>>         fp->clock =3D clock;
>>         fp->chmap =3D chmap;
>>         INIT_LIST_HEAD(&fp->list);
>>
>> -       /* ok, let's parse further... */
>> -       if (snd_usb_parse_audio_format_v3(chip, fp, as, stream) < 0) {
>> -               kfree(fp->rate_table);
>> -               kfree(fp);
>> -               return NULL;
>> +       if (badd_profile >=3D UAC3_FUNCTION_SUBCLASS_GENERIC_IO) {
>> +               fp->attributes =3D 0; /* No attributes */
>> +
>> +               fp->fmt_type =3D UAC_FORMAT_TYPE_I;
>> +               fp->formats =3D badd_formats;
>> +
>> +               fp->nr_rates =3D 0;       /* SNDRV_PCM_RATE_CONTINUOUS *=
/
>> +               fp->rate_min =3D UAC3_BADD_SAMPLING_RATE;
>> +               fp->rate_max =3D UAC3_BADD_SAMPLING_RATE;
>> +               fp->rates =3D SNDRV_PCM_RATE_CONTINUOUS;
>> +
>> +       } else {
>> +               fp->attributes =3D parse_uac_endpoint_attributes(chip, a=
lts,
>> +
>> UAC_VERSION_3,
>> +                                                              iface_no)=
;
>> +               /* ok, let's parse further... */
>> +               if (snd_usb_parse_audio_format_v3(chip, fp, as, stream) =
<
>> 0) {
>> +                       kfree(fp->rate_table);
>> +                       kfree(fp);
>> +                       return NULL;
>> +               }
>>         }
>>
>>         return fp;
>> diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
>> index 4d5c89a..1bb5e2c 100644
>> --- a/sound/usb/usbaudio.h
>> +++ b/sound/usb/usbaudio.h
>> @@ -49,6 +49,8 @@ struct snd_usb_audio {
>>         int num_suspended_intf;
>>         int sample_rate_read_error;
>>
>> +       int badd_profile;               /* UAC3 BADD profile */
>> +
>>         struct list_head pcm_list;      /* list of pcm streams */
>>         struct list_head ep_list;       /* list of audio-related endpoin=
ts
>> */
>>         int pcm_devs;

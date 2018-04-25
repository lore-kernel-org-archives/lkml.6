Return-Path: <ruslan.bilovol@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524695756; cv=none;
        d=google.com; s=arc-20160816;
        b=xN3iiGfpZ4epNgq79rhvjshGyB8Mxa3TaotfVGD39aS/1c5/UBBrFWPITX/Btayvzj
         hLMZwhqRBcjwiugBP6O05ApCodOva6CtjtXzF8ZTH9eZY0qg1cAj/E569+65gE6rsBxn
         VK8u1TcBAuLVpsLoI9NIbHj3bhXexPbu3g41Ici7Y1PHoKpWcBjZaIbBSq6GBF45DUN0
         2v1IqJt1kblU4gMl6rrTgi8ydltLbonwRHPdX4BOODMpA9zXV3RiURRCgVMt/ZLnv312
         /fyaGQ9/dwI3/MM+ACirHCoETElhuKfe7I3yTVxeTl7Fjx0TakEbpuZo3ngx1Zf64/h+
         RpxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=KyR/yJfkanXQWrCN6t4LO7jOmrz9emLaM97NaI8gLg8=;
        b=KxNECTzPD3qhJ0CKcx16OPButlkWyRDRhPwg79jP6ZC7IkaYbFSCTkiZEjni0amawl
         rIKapY7kazmvLtsrcE6/KJpY+btuhp0yndP/NbO0eb6UWY5txPAF09iGPiOMjc0riM38
         tqIPW0G11XTwueeE4hbSuaFcMBmz1ZvuO8KUUqCewCdamf2AcsFJyUdHLiI2dIrSMuWh
         pACvqlxTxU5M2K+yjUKlD8ihoX4y2JTnCIrjXOYP2YWyETXiGtN9+6+3Lw//Va631qL7
         0S7Fi3d4qR8Y8x8KHQNAoCuXnKSwLcR2o3l3BexFnnggQK/IZXK1XciyVBlA4f4DI/YZ
         jb+g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZiaazV5F;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZiaazV5F;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49oEPnI+b0GmTbbPqCmot4Bx7sVg+sljuWjSO4Q7K6JVha4g+83LaaI21E2TT6h3e9EB/24Z7rCfIN4/qjafhU=
MIME-Version: 1.0
In-Reply-To: <20180424172445.31928-2-jorge.sanjuan@codethink.co.uk>
References: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
 <20180424172445.31928-1-jorge.sanjuan@codethink.co.uk> <20180424172445.31928-2-jorge.sanjuan@codethink.co.uk>
From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Date: Thu, 26 Apr 2018 01:35:55 +0300
Message-ID: <CAB=otbQPX4QW8DKNGTS1dCRg2FUp46KCYL+ADnG=VkWPjg3YuQ@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 1/4] ALSA: usb-audio: UAC3. Add support
 for mixer unit.
To: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Cc: Takashi Iwai <tiwai@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598285487518505397?=
X-GMAIL-MSGID: =?utf-8?q?1598759377664484748?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

 On Tue, Apr 24, 2018 at 8:24 PM, Jorge Sanjuan
<jorge.sanjuan@codethink.co.uk> wrote:
> This adds support for the MIXER UNIT in UAC3. All the information
> is obtained from the (HIGH CAPABILITY) Cluster's header. We don't
> read the rest of the logical cluster to obtain the channel config
> as that wont make any difference in the current mixer behaviour.
>
> The name of the mixer unit is not yet requested as there is not
> support for the UAC3 Class Specific String requests.
>
> Tested in an UAC3 device working as a HEADSET with a basic mixer
> unit (same as the one in the BADD spec) with no controls.

The patch looks OK in general, but I have few comments

>
> Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
> ---
>  include/uapi/linux/usb/audio.h | 13 +++++--
>  sound/usb/mixer.c              | 87 ++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 93 insertions(+), 7 deletions(-)
>
> diff --git a/include/uapi/linux/usb/audio.h b/include/uapi/linux/usb/audio.h
> index 3a78e7145689..f9be472cd025 100644
> --- a/include/uapi/linux/usb/audio.h
> +++ b/include/uapi/linux/usb/audio.h
> @@ -285,9 +285,16 @@ static inline __u8 uac_mixer_unit_iChannelNames(struct uac_mixer_unit_descriptor
>  static inline __u8 *uac_mixer_unit_bmControls(struct uac_mixer_unit_descriptor *desc,
>                                               int protocol)

Name of this function is ambiguous, that's because UAC1 mixer unit
has only bmControls bitmap, whereas UAC2/3 mixer unit has two
bitmaps (bmMixerControls and bmControls), in latter case this func
returns pointer to bmMixerControls.

Maybe in the future we will need to rename it, but at least having
comment which clarifies that in case of UAC2/3 this function actually
returns pointer to bmMixerControls here will be helpful for code readers.

>  {
> -       return (protocol == UAC_VERSION_1) ?
> -               &desc->baSourceID[desc->bNrInPins + 4] :
> -               &desc->baSourceID[desc->bNrInPins + 6];
> +       switch (protocol) {
> +       case UAC_VERSION_1:
> +               return &desc->baSourceID[desc->bNrInPins + 4];
> +       case UAC_VERSION_2:
> +               return &desc->baSourceID[desc->bNrInPins + 6];
> +       case UAC_VERSION_3:
> +               return &desc->baSourceID[desc->bNrInPins + 2];
> +       default:
> +               return NULL;
> +       }
>  }
>
>  static inline __u8 uac_mixer_unit_iMixer(struct uac_mixer_unit_descriptor *desc)
> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> index 301ad61ed426..bf701b466a4e 100644
> --- a/sound/usb/mixer.c
> +++ b/sound/usb/mixer.c
> @@ -719,6 +719,66 @@ static int get_term_name(struct mixer_build *state, struct usb_audio_term *iterm
>  }
>
>  /*
> + * Get logical cluster information for UAC3 devices.
> + */
> +static int get_cluster_channels_v3(struct mixer_build *state, unsigned int cluster_id)
> +{
> +       struct uac3_cluster_header_descriptor c_header;
> +       int err;
> +
> +       err = snd_usb_ctl_msg(state->chip->dev,
> +                       usb_rcvctrlpipe(state->chip->dev, 0),
> +                       UAC3_CS_REQ_HIGH_CAPABILITY_DESCRIPTOR,
> +                       USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
> +                       cluster_id,
> +                       snd_usb_ctrl_intf(state->chip),
> +                       &c_header, sizeof(c_header));
> +       if (err < 0)
> +               goto error;
> +       if (err != sizeof(c_header)) {
> +               err = -EIO;
> +               goto error;
> +       }
> +
> +       return c_header.bNrChannels;
> +
> +error:
> +       usb_audio_err(state->chip, "cannot request logical cluster ID: %d (err: %d)\n", cluster_id, err);
> +       return err;
> +}
> +
> +/*
> + * Get number of channels for a Mixer Unit.
> + */
> +static int uac_mixer_unit_get_channels(struct mixer_build *state,
> +                                      struct uac_mixer_unit_descriptor *desc)
> +{
> +       int mu_channels;
> +
> +       if (desc->bLength < 11)
> +               return -EINVAL;
> +       if (!desc->bNrInPins)
> +               return -EINVAL;
> +
> +       switch (state->mixer->protocol) {
> +       case UAC_VERSION_1:
> +       case UAC_VERSION_2:
> +       default:
> +               mu_channels = uac_mixer_unit_bNrChannels(desc);
> +               break;
> +       case UAC_VERSION_3:
> +               mu_channels = get_cluster_channels_v3(state,
> +                               le16_to_cpu(desc->baSourceID[desc->bNrInPins]));

It would be good to create and use some helper here, for example implement
uac3_mixer_unit_wClusterDescrID() similar to uac_mixer_unit_bNrChannels().
It will put all this conversation to a single place and will improve
code readability.

> +               break;
> +       }
> +
> +       if (!mu_channels)
> +               return -EINVAL;
> +
> +       return mu_channels;
> +}
> +
> +/*
>   * parse the source unit recursively until it reaches to a terminal
>   * or a branched unit.
>   */
> @@ -865,6 +925,18 @@ static int check_input_term(struct mixer_build *state, int id,
>                                 term->name = le16_to_cpu(d->wClockSourceStr);
>                                 return 0;
>                         }
> +                       case UAC3_MIXER_UNIT: {
> +                               struct uac_mixer_unit_descriptor *d = p1;
> +
> +                               err = uac_mixer_unit_get_channels(state, d);
> +                               if (err < 0)
> +                                       return err;
> +
> +                               term->channels = err;
> +                               term->type = d->bDescriptorSubtype << 16; /* virtual type */
> +
> +                               return 0;
> +                       }
>                         default:
>                                 return -ENODEV;
>                         }
> @@ -1801,7 +1873,7 @@ static void build_mixer_unit_ctl(struct mixer_build *state,
>                                  struct usb_audio_term *iterm)
>  {
>         struct usb_mixer_elem_info *cval;
> -       unsigned int num_outs = uac_mixer_unit_bNrChannels(desc);
> +       unsigned int num_outs;
>         unsigned int i, len;
>         struct snd_kcontrol *kctl;
>         const struct usbmix_name_map *map;
> @@ -1814,6 +1886,10 @@ static void build_mixer_unit_ctl(struct mixer_build *state,
>         if (!cval)
>                 return;
>
> +       num_outs = uac_mixer_unit_get_channels(state, desc);
> +       if (num_outs < 0)
> +               return;

This will produce an extra USB control request in UAC3 case, which we can
avoid if add num_outs to input parameters of build_mixer_unit_ctl() function.
This function is used only once inside of parse_audio_mixer_unit() which already
has channels number request and all needed checks.

Thanks,
Ruslan

> +
>         snd_usb_mixer_elem_init_std(&cval->head, state->mixer, unitid);
>         cval->control = in_ch + 1; /* based on 1 */
>         cval->val_type = USB_MIXER_S16;
> @@ -1878,14 +1954,17 @@ static int parse_audio_mixer_unit(struct mixer_build *state, int unitid,
>         int input_pins, num_ins, num_outs;
>         int pin, ich, err;
>
> -       if (desc->bLength < 11 || !(input_pins = desc->bNrInPins) ||
> -           !(num_outs = uac_mixer_unit_bNrChannels(desc))) {
> +       err = uac_mixer_unit_get_channels(state, desc);
> +       if (err < 0) {
>                 usb_audio_err(state->chip,
>                               "invalid MIXER UNIT descriptor %d\n",
>                               unitid);
> -               return -EINVAL;
> +               return err;
>         }
>
> +       num_outs = err;
> +       input_pins = desc->bNrInPins;
> +
>         num_ins = 0;
>         ich = 0;
>         for (pin = 0; pin < input_pins; pin++) {
> --
> 2.11.0
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

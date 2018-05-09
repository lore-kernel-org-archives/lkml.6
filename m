Return-Path: <ruslan.bilovol@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525903874; cv=none;
        d=google.com; s=arc-20160816;
        b=NBDe5dN2wqyM29ZeDmazXxH875HFkb8BV+5hrombEfsuYMFk1PJZl6fDH+wRLyOAWv
         L8b0uojQxBTjiAdTXrdyyj0juB91zmVrQj5eaJp9JkuG5dAKgUT9R+4NX2vpkNhpWJgs
         X9Ph1n1HmLiO7CMBx8CFx8mkphe+0rTm/InoJdGuALUdxHZNw9QVkPQdhpyHBwuAWVhz
         iqz9+75OFGxOuztin5uQMmZDFRgho8sxW1zG0lU+XA+3tNbC/+pi8pnl+iTh6T9MhHY7
         KlSniBwVn3gzZXdzWEnCNs0OJXlKycIeaSkS3sq4uAwOX1/GtJ4/1GpdE4PhiH57P6FD
         RuWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=IeQSXC5YXaG5inp5oRMEEoVCRoJvQHqb1d7BcXVU9jQ=;
        b=AeOKDvtnJFjIgnYsEe6kbhp/O/XLFNpZp1WjJm32YKqc2t0ZC95xPENhvPChNs1uic
         jzOZ1YWl6ljyx0Ed6Pw/PS3A9PpBwWxvykuVadGL2xVSxjk2AJwMuV5ou6DDbPpUzkV7
         9Wi72o05YMduU03a5Cl/H0WxihjNff2jYT7mAzhHbwFhVVpJehnx7UlnA96AQKox933F
         Ea6vXDfkzk+Xb8YBakBCO8p8eEagTAfZHcdfyuy+zJfam+/ryf+cUWaeMbpaH0DiFMON
         nyMZM+/f+ExpA9SyXDp4KGBim/AdqM3gKP9uocARamDmt3nosKndeg1rGgzB682Y+T4V
         qC/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=upujpKWw;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=upujpKWw;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZr7UMZ6/ECHXwNPsxErslu5XxzDBT7kbKbaeWfsJnyOgsg3vhuhLwHN+ovekWu4s/RqqYGkjg9njP0PY/dWG/I=
MIME-Version: 1.0
In-Reply-To: <52c0eb21-0a69-7a2b-da8a-2d33ad4e11d2@codethink.co.uk>
References: <20180424172445.31928-2-jorge.sanjuan@codethink.co.uk>
 <20180427170649.27334-1-jorge.sanjuan@codethink.co.uk> <CAB=otbRKf57D52VRZgE=4XCLYaT9xE7eNsyLrBqmaghgB7LCfQ@mail.gmail.com>
 <52c0eb21-0a69-7a2b-da8a-2d33ad4e11d2@codethink.co.uk>
From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Date: Thu, 10 May 2018 01:11:13 +0300
Message-ID: <CAB=otbRqvHPsqbgqV2_Z9c3nf73AFNrcNhV_se_Hn26TbYHfww@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] ALSA: usb-audio: UAC3. Add support for mixer unit.
To: Jorge <jorge.sanjuan@codethink.co.uk>
Cc: Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598285487518505397?=
X-GMAIL-MSGID: =?utf-8?q?1600026181265324933?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 8, 2018 at 12:43 PM, Jorge <jorge.sanjuan@codethink.co.uk> wrote:
>
>
> On 04/05/18 01:57, Ruslan Bilovol wrote:
>>
>> On Fri, Apr 27, 2018 at 8:06 PM, Jorge Sanjuan
>> <jorge.sanjuan@codethink.co.uk> wrote:
>>>
>>> This adds support for the MIXER UNIT in UAC3. All the information
>>> is obtained from the (HIGH CAPABILITY) Cluster's header. We don't
>>> read the rest of the logical cluster to obtain the channel config
>>> as that wont make any difference in the current mixer behaviour.
>>>
>>> The name of the mixer unit is not yet requested as there is not
>>> support for the UAC3 Class Specific String requests.
>>>
>>> Tested in an UAC3 device working as a HEADSET with a basic mixer
>>> unit (same as the one in the BADD spec) with no controls.
>>
>>
>> So, after deeper looking into the code and after testing this patch,
>> in your usecase (mixer with no controls) you'll never execute
>> build_mixer_unit_ctl(), correct? So did you try to just fix issues with
>> incorrect parsing of mixer unit descriptor?
>>
>>>
>>> Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
>>> ---
>>>   include/uapi/linux/usb/audio.h | 19 +++++++--
>>>   sound/usb/mixer.c              | 88
>>> ++++++++++++++++++++++++++++++++++++++----
>>>   2 files changed, 97 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/include/uapi/linux/usb/audio.h
>>> b/include/uapi/linux/usb/audio.h
>>> index 3a78e7145689..13d98e6e0db1 100644
>>> --- a/include/uapi/linux/usb/audio.h
>>> +++ b/include/uapi/linux/usb/audio.h
>>> @@ -285,9 +285,22 @@ static inline __u8
>>> uac_mixer_unit_iChannelNames(struct uac_mixer_unit_descriptor
>>>   static inline __u8 *uac_mixer_unit_bmControls(struct
>>> uac_mixer_unit_descriptor *desc,
>>>                                                int protocol)
>>>   {
>>> -       return (protocol == UAC_VERSION_1) ?
>>> -               &desc->baSourceID[desc->bNrInPins + 4] :
>>> -               &desc->baSourceID[desc->bNrInPins + 6];
>>> +       switch (protocol) {
>>> +       case UAC_VERSION_1:
>>> +               return &desc->baSourceID[desc->bNrInPins + 4];
>>> +       case UAC_VERSION_2:
>>> +               return &desc->baSourceID[desc->bNrInPins + 6];
>>> +       case UAC_VERSION_3:
>>> +               return &desc->baSourceID[desc->bNrInPins + 2];
>>> +       default:
>>> +               return NULL;
>>> +       }
>>> +}
>>> +
>>> +static inline __u16 uac3_mixer_unit_wClusterDescrID(struct
>>> uac_mixer_unit_descriptor *desc)
>>> +{
>>> +       return (desc->baSourceID[desc->bNrInPins + 1] << 8) |
>>> +               desc->baSourceID[desc->bNrInPins];
>>>   }
>>>
>>>   static inline __u8 uac_mixer_unit_iMixer(struct
>>> uac_mixer_unit_descriptor *desc)
>>> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
>>> index 301ad61ed426..3503f4840ec3 100644
>>> --- a/sound/usb/mixer.c
>>> +++ b/sound/usb/mixer.c
>>> @@ -719,6 +719,66 @@ static int get_term_name(struct mixer_build *state,
>>> struct usb_audio_term *iterm
>>>   }
>>>
>>>   /*
>>> + * Get logical cluster information for UAC3 devices.
>>> + */
>>> +static int get_cluster_channels_v3(struct mixer_build *state, unsigned
>>> int cluster_id)
>>> +{
>>> +       struct uac3_cluster_header_descriptor c_header;
>>> +       int err;
>>> +
>>> +       err = snd_usb_ctl_msg(state->chip->dev,
>>> +                       usb_rcvctrlpipe(state->chip->dev, 0),
>>> +                       UAC3_CS_REQ_HIGH_CAPABILITY_DESCRIPTOR,
>>> +                       USB_RECIP_INTERFACE | USB_TYPE_CLASS |
>>> USB_DIR_IN,
>>> +                       cluster_id,
>>> +                       snd_usb_ctrl_intf(state->chip),
>>> +                       &c_header, sizeof(c_header));
>>> +       if (err < 0)
>>> +               goto error;
>>> +       if (err != sizeof(c_header)) {
>>> +               err = -EIO;
>>> +               goto error;
>>> +       }
>>> +
>>> +       return c_header.bNrChannels;
>>> +
>>> +error:
>>> +       usb_audio_err(state->chip, "cannot request logical cluster ID: %d
>>> (err: %d)\n", cluster_id, err);
>>> +       return err;
>>> +}
>>> +
>>> +/*
>>> + * Get number of channels for a Mixer Unit.
>>> + */
>>> +static int uac_mixer_unit_get_channels(struct mixer_build *state,
>>> +                                      struct uac_mixer_unit_descriptor
>>> *desc)
>>> +{
>>> +       int mu_channels;
>>> +
>>> +       if (desc->bLength < 11)
>>> +               return -EINVAL;
>>> +       if (!desc->bNrInPins)
>>> +               return -EINVAL;
>>> +
>>> +       switch (state->mixer->protocol) {
>>> +       case UAC_VERSION_1:
>>> +       case UAC_VERSION_2:
>>> +       default:
>>> +               mu_channels = uac_mixer_unit_bNrChannels(desc);
>>> +               break;
>>> +       case UAC_VERSION_3:
>>> +               mu_channels = get_cluster_channels_v3(state,
>>> +                               uac3_mixer_unit_wClusterDescrID(desc));
>>> +               break;
>>> +       }
>>> +
>>> +       if (!mu_channels)
>>> +               return -EINVAL;
>>> +
>>> +       return mu_channels;
>>> +}
>>> +
>>> +/*
>>>    * parse the source unit recursively until it reaches to a terminal
>>>    * or a branched unit.
>>>    */
>>> @@ -865,6 +925,18 @@ static int check_input_term(struct mixer_build
>>> *state, int id,
>>>                                  term->name =
>>> le16_to_cpu(d->wClockSourceStr);
>>>                                  return 0;
>>>                          }
>>> +                       case UAC3_MIXER_UNIT: {
>>> +                               struct uac_mixer_unit_descriptor *d = p1;
>>> +
>>> +                               err = uac_mixer_unit_get_channels(state,
>>> d);
>>> +                               if (err < 0)
>>> +                                       return err;
>>> +
>>> +                               term->channels = err;
>>> +                               term->type = d->bDescriptorSubtype << 16;
>>> /* virtual type */
>>> +
>>> +                               return 0;
>>> +                       }
>>>                          default:
>>>                                  return -ENODEV;
>>>                          }
>>> @@ -1797,11 +1869,10 @@ static int parse_audio_feature_unit(struct
>>> mixer_build *state, int unitid,
>>>    */
>>>   static void build_mixer_unit_ctl(struct mixer_build *state,
>>>                                   struct uac_mixer_unit_descriptor *desc,
>>> -                                int in_pin, int in_ch, int unitid,
>>> -                                struct usb_audio_term *iterm)
>>> +                                int in_pin, int in_ch, int num_outs,
>>> +                                int unitid, struct usb_audio_term
>>> *iterm)
>>>   {
>>>          struct usb_mixer_elem_info *cval;
>>> -       unsigned int num_outs = uac_mixer_unit_bNrChannels(desc);
>>>          unsigned int i, len;
>>>          struct snd_kcontrol *kctl;
>>>          const struct usbmix_name_map *map;
>>> @@ -1878,14 +1949,17 @@ static int parse_audio_mixer_unit(struct
>>> mixer_build *state, int unitid,
>>>          int input_pins, num_ins, num_outs;
>>>          int pin, ich, err;
>>>
>>> -       if (desc->bLength < 11 || !(input_pins = desc->bNrInPins) ||
>>> -           !(num_outs = uac_mixer_unit_bNrChannels(desc))) {
>>> +       err = uac_mixer_unit_get_channels(state, desc);
>>> +       if (err < 0) {
>>>                  usb_audio_err(state->chip,
>>>                                "invalid MIXER UNIT descriptor %d\n",
>>>                                unitid);
>>> -               return -EINVAL;
>>> +               return err;
>>>          }
>>>
>>> +       num_outs = err;
>>> +       input_pins = desc->bNrInPins;
>>> +
>>>          num_ins = 0;
>>>          ich = 0;
>>>          for (pin = 0; pin < input_pins; pin++) {
>>> @@ -1912,7 +1986,7 @@ static int parse_audio_mixer_unit(struct
>>> mixer_build *state, int unitid,
>>>                                  }
>>>                          }
>>>                          if (ich_has_controls)
>>> -                               build_mixer_unit_ctl(state, desc, pin,
>>> ich,
>>> +                               build_mixer_unit_ctl(state, desc, pin,
>>> ich, num_outs,
>>>                                                       unitid, &iterm);
>>
>>
>> So with current sources we will never reach this place. In your
>> usecase (mixer with no
>> controls) it obviously won't go inside.
>> However, I created a mixer with controls but still
>> build_mixer_unit_ctl() isn't executed.
>> This is because UAC3 input terminal parsing always returns 0 channels,
>> this is
>> what still needs to be implemented (see comment "REVISIT: UAC3 IT doesn't
>> have channels/cfg" in check_input_term)
>
>
> Thanks for testing this!
>
> I missed that one with the number of input channels. Regarding the "REVISIT:
> UAC3 IT doesn't have channels/cfg" comment, we can easily fix that using the
> helper function I added in this patch for reading the logical cluster's
> number of channels `get_cluster_channels_v3`. The channel config bitmap I
> don't see it being used at all so parsing iterm.channels should be enough.
> Any thoughts?
>

I looked into the sources, it seems you are right, we need only number of
channels to proceed with mixer unit created.

I can hack your patch and test it in a few days, or feel free to send v4

Thanks,
Ruslan

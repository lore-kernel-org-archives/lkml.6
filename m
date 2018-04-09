Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752127AbeDIDBt (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 23:01:49 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:41909 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752057AbeDIDBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 23:01:43 -0400
X-Google-Smtp-Source: AIpwx4+v5p2yY9LZVn8aSzrvWDAaJ+sad+Yte0TgqfC/DNxw480+TQ0P+kbOLyCf4XU27wa+X+9U4O6RA16d/2FiJ8M=
MIME-Version: 1.0
In-Reply-To: <s5ho9j01x0g.wl-tiwai@suse.de>
References: <20180402073313.13247-1-jian-hong@endlessm.com>
 <s5hwoxp3kyz.wl-tiwai@suse.de> <CAPpJ_eeYthiOiEMijRAvk05JR7cZLFpSiV8mVCHjxv_GL5Bjpg@mail.gmail.com>
 <s5ho9j01x0g.wl-tiwai@suse.de>
From: Jian-Hong Pan <jian-hong@endlessm.com>
Date: Mon, 9 Apr 2018 11:01:41 +0800
Message-ID: <CAPpJ_ed8NiqJHz8uFRdpqs0Sf_DKLUWJyb213oHyLUyXEdPXKA@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda/realtek: Enable audio line out on ASUS D640SA
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Hui Wang <hui.wang@canonical.com>,
        linux@endlessm.com, Jaroslav Kysela <perex@perex.cz>,
        Kailang Yang <kailang@realtek.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3932FSD017547

2018-04-03 17:04 GMT+08:00 Takashi Iwai <tiwai@suse.de>:
> On Tue, 03 Apr 2018 10:43:02 +0200,
> Jian-Hong Pan wrote:
>>
>> 2018-04-02 19:29 GMT+08:00 Takashi Iwai <tiwai@suse.de>:
>> >
>> > On Mon, 02 Apr 2018 09:33:13 +0200,
>> > Jian-Hong Pan wrote:
>> > >
>> > > This ASUS D640SA desktop whose mother board is D640MB has
>> > > - two jacks which are a headphone and a mic on the front panel,
>> > > - three jacks which are a mic, a line out and a line in on the rear panel
>> > > - one internal speaker.
>> > >
>> > > If I plug a headphone to the front headphone jack, there will be sound
>> > > through the headphone jack, and no sound through the internal speaker.
>> > > If I unplug the headphone from the the headphone jack, there will be
>> > > sound through the internal speaker.  And always no sound through rear
>> > > line out, when I plug a headphone or an externel speaker to the rear
>> > > line out jack.
>> > >
>> > > Besides, I had checked and toggled the Auto-Mute Mode in alsamixer, but
>> > > the rear line out still was not working.  Then I checked the sound
>> > > settings in GUI, and found there was no "Line Out" could be chosen, only
>> > > the "Headphones" and "HDMI/DisplayPort".
>> > > However, system does know that there is an "Intel PCH Line Out".
>> > >
>> > > [   10.089082] snd_hda_codec_realtek hdaudioC0D0: autoconfig for
>> > > ALC887-VD: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
>> > > [   10.089083] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=1
>> > > (0x1a/0x0/0x0/0x0/0x0)
>> > > [   10.089084] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1
>> > > (0x1b/0x0/0x0/0x0/0x0)
>> > > [   10.089085] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
>> > > [   10.089086] snd_hda_codec_realtek hdaudioC0D0:    inputs:
>> > > [   10.089087] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=0x18
>> > > [   10.089088] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=0x19
>> > > [   10.089089] snd_hda_codec_realtek hdaudioC0D0:      Line=0x15
>> > > [   10.104387] input: HDA Intel PCH Rear Mic as
>> > > /devices/pci0000:00/0000:00:1f.3/sound/card0/input9
>> > > [   10.104416] input: HDA Intel PCH Front Mic as
>> > > /devices/pci0000:00/0000:00:1f.3/sound/card0/input10
>> > > [   10.104441] input: HDA Intel PCH Line as
>> > > /devices/pci0000:00/0000:00:1f.3/sound/card0/input11
>> > > [   10.104467] input: HDA Intel PCH Line Out as
>> > > /devices/pci0000:00/0000:00:1f.3/sound/card0/input12
>> > > [   10.104494] input: HDA Intel PCH Front Headphone as
>> > > /devices/pci0000:00/0000:00:1f.3/sound/card0/input13
>> > >
>> > > Consequently, I checked the pin widgets' default configuration values:
>> > > - Node 0x14 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
>> > >     Pin Default 0x01014010: [Jack] Line Out at Ext Rear
>> > >
>> > > - Node 0x1b [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
>> > >     Pin Default 0x02214030: [Jack] HP Out at Ext Front
>> > >
>> > > Because the headphone jack (Node ID:0x1b) locates on the desktop's front
>> > > panel, not rear panel, I change the headphone jack's configuration from
>> > > primary chassis to separate chassis.  So, the configuration value of
>> > > Node ID:0x1b should be 0x22214030.
>> >
>> > This is OK, but...
>> >
>> > > Additionally, I toggle the Auto-Mute Mode of Realtek codecs to “Speaker
>> > > Only” which makes signal outputs through line out jack when the "Line
>> > > Out" is chosen in the sound settings.
>> >
>> > ... this is a matter of taste, and I don't think it good to set a
>> > different default from others.  You can change it once and save it via
>> > alsactl.
>>
>> The default state of Auto-Mute Mode of Realtek codec on this machine is
>> "Line Out + Speaker".
>> This disallows to output audio signal through the line out jack, even I already
>> choose the "Line Out" as the audio output device in the sound settings.
>> It means there is no way to use the line out jack in "Line Out + Speaker" state
>> of Auto-Mute Mode on this machine.
>
> It's a setup issue by PA, and it's not specific to this device at
> all.  If PA wants the independent output, it can change to auto-mute
> off by itself.
>
>> To enhance the user experience, especially the new one who first uses Linux,
>> changing this machine's Auto-Mute Mode to "Speaker Only" state, which allows
>> to output the audio signal through the line out jack, will be the better choice.
>>
>> By the way, if the "Headphones" is chosen as the audio output device in the
>> sound settings, the audio signal will not output through the line out jack
>> automatically.
>>
>> Therefore, I think this part of the quirk is still needed on this machine.
>
> Again, this isn't about the machine configuration, but a generic PA
> problem.  Fixing it in a device-specific fixup is no right way.

Thanks for the hint which is about the PulseAudio.
I will try to figure out the fix for the Auto-Mute problem with
PulseAudio first.
And the pin configuration fixup may be not need or still needed, after the try.

Thanks,

Jian-Hong Pan

>
> thanks,
>
> Takashi

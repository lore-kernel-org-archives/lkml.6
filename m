Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F2DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 05:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A81C208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 05:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=godking.net header.i=@godking.net header.b="mWm9hI7J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A81C208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=godking.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbeK0Qa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 11:30:56 -0500
Received: from s18231873.onlinehome-server.info ([217.160.179.168]:42978 "EHLO
        godking.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728171AbeK0Qaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 11:30:55 -0500
Received: from localhost (localhost [IPv6:::1])
        by godking.net (Postfix) with ESMTPS id 49FA21D2AE85E;
        Mon, 26 Nov 2018 23:34:04 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=godking.net; s=mail;
        t=1543296846; bh=CXBBLuNxomz4x/wTWSKlzf2sHjqB1zQm1DFTurHpcyc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=mWm9hI7Jn1Y9GucRvOTBAX7A27T8gljsd2KmBDbKiJH0Cqsy2S9CmqxEtrhzx+1rm
         x1PnRuM7EdeJyFHq1/RD6kkMQn5oN3+HywSpBq9z3AE5r/+c0d7SxIpf4agSL/TH7R
         husagIkCIwhGv96YirDDMYdesoQ9qqlMnFI2JNDepNfnvJWj0ep95/xu4Xhd6yx5HX
         ZbHC82tPCUo/kcbGPpr5spVvjGix8JHxokk4ylzExGxrh+ABpHBCT+v9L5a/zijWaE
         xFn9TgueMp+R6SuOIqwYpeI1xbGriQzZoFZxD/+vmcZPnqwo9DbuEP9VLwEY82OJyF
         PYVHSzskZ+XQQ==
Date:   Mon, 26 Nov 2018 21:34:02 -0800 (PST)
From:   Alexander Kappner <agk@godking.net>
X-X-Sender: ak@REDDOT
To:     Takashi Iwai <tiwai@suse.de>
cc:     Alexander Kappner <agk@godking.net>, Jim.Qu@amd.com,
        bhelgaas@google.com, guneshwor.o.singh@intel.com, perex@perex.cz,
        hdegoede@redhat.com, lukas@wunner.de, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [snd_hda_intel] snd_hda_intel causes high CPU lockup and system
 instability if mic disabled in BIOS on Lenovo P50
In-Reply-To: <s5hpnus6yb5.wl-tiwai@suse.de>
Message-ID: <alpine.DEB.2.11.1811262126040.2578@REDDOT>
References: <alpine.DEB.2.11.1811251505140.20766@REDDOT> <s5hpnus6yb5.wl-tiwai@suse.de>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




On Mon, 26 Nov 2018, Takashi Iwai wrote:

> On Mon, 26 Nov 2018 00:17:15 +0100,
> Alexander Kappner wrote:
>>
>> My Lenovo P50 laptop has a BIOS option to disable the microphone. When
>> this option gets chosen, the snd_hda_intel driver causes high CPU load
>> on a single kworker thread, spinning on "process_unsol_events", and
>> system
>> instability. This behavior occurs from the time that the snd_hda_intel
>> module is loaded, irrespective of whether anything is attempting to access
>> the mic. The sound output still works.
>>
>> When in this state, the module cannot be removed cleanly; attempting to
>> remove it (even without rmmod -f) triggers an oops.
>>
>> I have attached two exemplary dmesg outputs. Strangely enough, the exact
>> location of the oops varies, but further up the call chain, I always see
>> process_unsol_events.
>>
>> When the mic is not disabled in the BIOS, the module works stable,
>> regardless whether or not the mic is muted in ALSA.
>>
>> I wasn't able to pinpoint the root cause. Any pointers on where to
>> start? Much appreciated.
>
> Could you load snd-hda-intel driver with probe_only=1 option, and give
> alsa-info.sh output (run it with --no-upload option)?  This should
> leave only the codec probing without configuring, so we can see the
> codec widget contents and check the emulator.
>
>
> thanks,
>
> Takashi
>

Hi Takashi,

thank you for looking into this. Please see quoted below the output of 
alsa-info.sh (after "modprobe snd_hda_intel probe_only=1").

Best regards




upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.64
!!################################

!!Script ran on: Tue Nov 27 05:25:14 UTC 2018


!!Linux Distribution
!!------------------

Debian GNU/Linux 8 \n \l PRETTY_NAME="Debian GNU/Linux 8 (jessie)" NAME="Debian GNU/Linux" ID=debian HOME_URL="http://www.debian.org/" SUPPORT_URL="http://www.debian.org/support" BUG_REPORT_URL="https://bugs.debian.org/"


!!DMI Information
!!---------------

Manufacturer:      LENOVO
Product Name:      20ENCTO1WW
Product Version:   ThinkPad P50
Firmware Version:  N1EET62W (1.35 )
Board Vendor:      LENOVO
Board Name:        20ENCTO1WW


!!ACPI Device Status Information
!!---------------

/sys/bus/acpi/devices/ACPI0003:00/status 	 15
/sys/bus/acpi/devices/LEN0068:00/status 	 15
/sys/bus/acpi/devices/LNXPOWER:00/status 	 1
/sys/bus/acpi/devices/LNXPOWER:01/status 	 1
/sys/bus/acpi/devices/LNXPOWER:02/status 	 1
/sys/bus/acpi/devices/LNXPOWER:03/status 	 1
/sys/bus/acpi/devices/LNXVIDEO:00/status 	 15
/sys/bus/acpi/devices/PNP0103:00/status 	 15
/sys/bus/acpi/devices/PNP0C0A:00/status 	 31
/sys/bus/acpi/devices/PNP0C0F:00/status 	 9
/sys/bus/acpi/devices/PNP0C0F:01/status 	 9
/sys/bus/acpi/devices/PNP0C0F:02/status 	 9
/sys/bus/acpi/devices/PNP0C0F:03/status 	 9
/sys/bus/acpi/devices/PNP0C0F:04/status 	 9
/sys/bus/acpi/devices/PNP0C0F:05/status 	 9
/sys/bus/acpi/devices/PNP0C0F:06/status 	 9
/sys/bus/acpi/devices/PNP0C0F:07/status 	 9
/sys/bus/acpi/devices/device:3e/status 	 15


!!Kernel Information
!!------------------

Kernel release:    4.19.0-rc4
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         unknown
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     k4.19.0-rc4
Library version:    1.0.28
Utilities version:  1.0.28


!!Loaded ALSA modules
!!-------------------



!!Sound Servers on this system
!!----------------------------

Pulseaudio:
       Installed - Yes (/usr/bin/pulseaudio)
       Running - No


!!Soundcards recognised by ALSA
!!-----------------------------

  0 [PCH            ]: HDA-Intel - HDA Intel PCH
                       HDA Intel PCH at 0xc4940000 irq 151
  1 [NVidia         ]: HDA-Intel - HDA NVidia
                       HDA NVidia at 0xc3000000 irq 17


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1f.3 Audio device: Intel Corporation Device a170 (rev 31)
01:00.1 Audio device: NVIDIA Corporation Device 0fbc (rev a1)


!!Advanced information - PCI Vendor/Device/Subsystem ID's
!!-------------------------------------------------------

00:1f.3 0403: 8086:a170 (rev 31)
 	Subsystem: 17aa:222e
--
01:00.1 0403: 10de:0fbc (rev a1)
 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-


!!Modprobe options (Sound related)
!!--------------------------------

snd_pcsp: index=-2
snd_usb_audio: index=-2
snd_atiixp_modem: index=-2
snd_intel8x0m: index=-2
snd_via82xx_modem: index=-2


!!Loaded sound module options
!!---------------------------


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Realtek ID 298
Address: 0
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x10ec0298
Subsystem Id: 0x17aa222e
Revision Id: 0x100103
No Modem Function Group found
Default PCM:
     rates [0x60]: 44100 48000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
   Power states:  D0 D1 D2 D3 D3cold CLKSTOP EPSS
   Power: setting=D0, actual=D0
GPIO: io=8, o=0, i=0, unsolicited=1, wake=0
   IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
   IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
   IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
   IO[3]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
   IO[4]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
   IO[5]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
   IO[6]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
   IO[7]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Node 0x02 [Audio Output] wcaps 0x41d: Stereo Amp-Out
   Amp-Out caps: ofs=0x7f, nsteps=0x7f, stepsize=0x01, mute=0
   Amp-Out vals:  [0x7f 0x7f]
   Converter: stream=0, channel=0
   PCM:
     rates [0x60]: 44100 48000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
Node 0x03 [Audio Output] wcaps 0x41d: Stereo Amp-Out
   Amp-Out caps: ofs=0x7f, nsteps=0x7f, stepsize=0x01, mute=0
   Amp-Out vals:  [0x7f 0x7f]
   Converter: stream=0, channel=0
   PCM:
     rates [0x60]: 44100 48000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
Node 0x04 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x05 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x06 [Audio Output] wcaps 0x411: Stereo
   Converter: stream=0, channel=0
   PCM:
     rates [0x40]: 48000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x08 [Audio Input] wcaps 0x10051b: Stereo Amp-In
   Amp-In caps: ofs=0x43, nsteps=0x7f, stepsize=0x01, mute=1
   Amp-In vals:  [0xc3 0xc3]
   Converter: stream=0, channel=0
   SDI-Select: 0
   PCM:
     rates [0x60]: 44100 48000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
   Connection: 1
      0x23
Node 0x09 [Audio Input] wcaps 0x10051b: Stereo Amp-In
   Amp-In caps: ofs=0x43, nsteps=0x7f, stepsize=0x01, mute=1
   Amp-In vals:  [0xc3 0xc3]
   Converter: stream=0, channel=0
   SDI-Select: 0
   PCM:
     rates [0x60]: 44100 48000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
   Connection: 1
      0x22
Node 0x0a [Audio Input] wcaps 0x100511: Stereo
   Converter: stream=0, channel=0
   SDI-Select: 0
   PCM:
     rates [0x40]: 48000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
   Connection: 1
      0x25
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
   Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
   Amp-In vals:  [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x09 0x09]
   Connection: 4
      0x18 0x19 0x1a 0x1d
Node 0x0c [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x80 0x80]
   Connection: 2
      0x02 0x0b
Node 0x0d [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00]
   Connection: 1
      0x03
Node 0x0e [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0f [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x10 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x11 [Audio Input] wcaps 0x10051b: Stereo Amp-In
   Amp-In caps: ofs=0x43, nsteps=0x7f, stepsize=0x01, mute=1
   Amp-In vals:  [0xc3 0xc3]
   Converter: stream=0, channel=0
   SDI-Select: 0
   PCM:
     rates [0x60]: 44100 48000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
   Connection: 1
      0x24
Node 0x12 [Pin Complex] wcaps 0x40040b: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Pincap 0x00000020: IN
   Pin Default 0x90a60140: [Fixed] Mic at Int N/A
     Conn = Digital, Color = Unknown
     DefAssociation = 0x4, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x00:
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
Node 0x13 [Pin Complex] wcaps 0x40040b: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Pincap 0x00000020: IN
   Pin Default 0x40000000: [N/A] Line Out at Ext N/A
     Conn = Unknown, Color = Unknown
     DefAssociation = 0x0, Sequence = 0x0
   Pin-ctls: 0x00:
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
Node 0x14 [Pin Complex] wcaps 0x40050d: Stereo Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x00010010: OUT EAPD
   EAPD 0x0:
   Pin Default 0x90170110: [Fixed] Speaker at Int N/A
     Conn = Analog, Color = Unknown
     DefAssociation = 0x1, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x40: OUT
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
   Connection: 2
      0x0c* 0x0d
Node 0x15 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x16 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x17 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x0001001c: OUT HP EAPD Detect
   EAPD 0x0:
   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x00:
   Unsolicited: tag=00, enabled=0
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
   Connection: 3
      0x0c* 0x0d 0x06
Node 0x18 [Pin Complex] wcaps 0x40048b: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Pincap 0x00003724: IN Detect
     Vref caps: HIZ 50 GRD 80 100
   Pin Default 0x03a11030: [Jack] Mic at Ext Left
     Conn = 1/8, Color = Black
     DefAssociation = 0x3, Sequence = 0x0
   Pin-ctls: 0x20: IN VREF_HIZ
   Unsolicited: tag=00, enabled=0
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
Node 0x19 [Pin Complex] wcaps 0x40048b: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Pincap 0x00003724: IN Detect
     Vref caps: HIZ 50 GRD 80 100
   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x00: VREF_HIZ
   Unsolicited: tag=00, enabled=0
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
Node 0x1a [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x0001373c: IN OUT HP EAPD Detect
     Vref caps: HIZ 50 GRD 80 100
   EAPD 0x0:
   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x00: VREF_HIZ
   Unsolicited: tag=00, enabled=0
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
   Connection: 2
      0x0c* 0x0d
Node 0x1b [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1c [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1d [Pin Complex] wcaps 0x400400: Mono
   Pincap 0x00000020: IN
   Pin Default 0x40648605: [N/A] Modem Line at Ext N/A
     Conn = RCA, Color = Purple
     DefAssociation = 0x0, Sequence = 0x5
   Pin-ctls: 0x20: IN
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
Node 0x1e [Pin Complex] wcaps 0x400501: Stereo
   Pincap 0x00000014: OUT Detect
   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x00:
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
   Connection: 1
      0x06
Node 0x1f [Pin Complex] wcaps 0x400401: Stereo
   Pincap 0x00000024: IN Detect
   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x00:
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
   Processing caps: benign=0, ncoeff=150
Node 0x21 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x00 0x00]
   Pincap 0x0000001c: OUT HP Detect
   Pin Default 0x03211020: [Jack] HP Out at Ext Left
     Conn = 1/8, Color = Black
     DefAssociation = 0x2, Sequence = 0x0
   Pin-ctls: 0x00:
   Unsolicited: tag=00, enabled=0
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=D0, actual=D0
   Connection: 2
      0x0c* 0x0d
Node 0x22 [Audio Selector] wcaps 0x300101: Stereo
   Connection: 6
      0x18* 0x19 0x1a 0x1d 0x0b 0x12
Node 0x23 [Audio Selector] wcaps 0x300101: Stereo
   Connection: 6
      0x18 0x19 0x1a* 0x1d 0x0b 0x13
Node 0x24 [Audio Selector] wcaps 0x300101: Stereo
   Connection: 2
      0x12* 0x13
Node 0x25 [Audio Selector] wcaps 0x300101: Stereo
   Connection: 1
      0x1f
Codec: Nvidia GPU 60 HDMI/DP
Address: 0
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x10de0060
Subsystem Id: 0x00000000
Revision Id: 0x100100
No Modem Function Group found
Default PCM:
     rates [0x0]:
     bits [0x0]:
     formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
   Power states:  D0 D1 D2 D3 CLKSTOP EPSS
   Power: setting=D0, actual=D0
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x04 [Pin Complex] wcaps 0x407381: 8-Channels Digital CP
   Control: name="IEC958 Playback Con Mask", index=0, device=0
   Control: name="IEC958 Playback Pro Mask", index=0, device=0
   Control: name="IEC958 Playback Default", index=0, device=0
   Control: name="IEC958 Playback Switch", index=0, device=0
   Pincap 0x09000094: OUT Detect HBR HDMI DP
   Pin Default 0x185600f0: [Jack] Digital Out at Int HDMI
     Conn = Digital, Color = Unknown
     DefAssociation = 0xf, Sequence = 0x0
   Pin-ctls: 0x00:
   Unsolicited: tag=01, enabled=1
   Connection: 4
      0x08* 0x09 0x0a 0x0b
Node 0x05 [Pin Complex] wcaps 0x407381: 8-Channels Digital CP
   Control: name="IEC958 Playback Con Mask", index=1, device=0
   Control: name="IEC958 Playback Pro Mask", index=1, device=0
   Control: name="IEC958 Playback Default", index=1, device=0
   Control: name="IEC958 Playback Switch", index=1, device=0
   Pincap 0x09000094: OUT Detect HBR HDMI DP
   Pin Default 0x185600f0: [Jack] Digital Out at Int HDMI
     Conn = Digital, Color = Unknown
     DefAssociation = 0xf, Sequence = 0x0
   Pin-ctls: 0x00:
   Unsolicited: tag=02, enabled=1
   Connection: 4
      0x08* 0x09 0x0a 0x0b
Node 0x06 [Pin Complex] wcaps 0x407381: 8-Channels Digital CP
   Pincap 0x09000094: OUT Detect HBR HDMI DP
   Pin Default 0x585600f0: [N/A] Digital Out at Int HDMI
     Conn = Digital, Color = Unknown
     DefAssociation = 0xf, Sequence = 0x0
   Pin-ctls: 0x00:
   Unsolicited: tag=00, enabled=0
   Connection: 4
      0x08* 0x09 0x0a 0x0b
Node 0x07 [Pin Complex] wcaps 0x407381: 8-Channels Digital CP
   Control: name="IEC958 Playback Con Mask", index=2, device=0
   Control: name="IEC958 Playback Pro Mask", index=2, device=0
   Control: name="IEC958 Playback Default", index=2, device=0
   Control: name="IEC958 Playback Switch", index=2, device=0
   Pincap 0x09000094: OUT Detect HBR HDMI DP
   Pin Default 0x185600f0: [Jack] Digital Out at Int HDMI
     Conn = Digital, Color = Unknown
     DefAssociation = 0xf, Sequence = 0x0
   Pin-ctls: 0x00:
   Unsolicited: tag=03, enabled=1
   Connection: 4
      0x08* 0x09 0x0a 0x0b
Node 0x08 [Audio Output] wcaps 0x62b1: 8-Channels Digital Stripe
   Converter: stream=0, channel=0
   Digital:
   Digital category: 0x0
   IEC Coding Type: 0x0
   PCM:
     rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
     bits [0xe]: 16 20 24
     formats [0x5]: PCM AC3
   Unsolicited: tag=00, enabled=0
Node 0x09 [Audio Output] wcaps 0x62b1: 8-Channels Digital Stripe
   Converter: stream=0, channel=0
   Digital:
   Digital category: 0x0
   IEC Coding Type: 0x0
   PCM:
     rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
     bits [0xe]: 16 20 24
     formats [0x5]: PCM AC3
   Unsolicited: tag=00, enabled=0
Node 0x0a [Audio Output] wcaps 0x62b1: 8-Channels Digital Stripe
   Converter: stream=0, channel=0
   Digital:
   Digital category: 0x0
   IEC Coding Type: 0x0
   PCM:
     rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
     bits [0xe]: 16 20 24
     formats [0x5]: PCM AC3
   Unsolicited: tag=00, enabled=0
Node 0x0b [Audio Output] wcaps 0x62b1: 8-Channels Digital Stripe
   Converter: stream=0, channel=0
   Digital:
   Digital category: 0x0
   IEC Coding Type: 0x0
   PCM:
     rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
     bits [0xe]: 16 20 24
     formats [0x5]: PCM AC3
   Unsolicited: tag=00, enabled=0
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116,  3 Nov 26 21:24 /dev/snd/controlC0
crw-rw----+ 1 root audio 116,  8 Nov 26 21:24 /dev/snd/controlC1
crw-rw----+ 1 root audio 116,  2 Nov 26 21:24 /dev/snd/hwC0D0
crw-rw----+ 1 root audio 116,  7 Nov 26 21:24 /dev/snd/hwC1D0
crw-rw----+ 1 root audio 116,  4 Nov 26 21:24 /dev/snd/pcmC1D3p
crw-rw----+ 1 root audio 116,  5 Nov 26 21:24 /dev/snd/pcmC1D7p
crw-rw----+ 1 root audio 116,  6 Nov 26 21:24 /dev/snd/pcmC1D8p
crw-rw----+ 1 root audio 116, 33 Nov 26 21:24 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  80 Nov 26 21:24 .
drwxr-xr-x 3 root root 220 Nov 26 21:24 ..
lrwxrwxrwx 1 root root  12 Nov 26 21:24 pci-0000:00:1f.3 -> ../controlC0
lrwxrwxrwx 1 root root  12 Nov 26 21:24 pci-0000:01:00.1 -> ../controlC1


!!Aplay/Arecord output
!!--------------------

APLAY

No protocol specified
xcb_connection_has_error() returned true
XDG_RUNTIME_DIR (/run/user/1000) is not owned by us (uid 0), but by uid 1000! (This could e g happen if you try to connect to a non-root PulseAudio as a root user, over the native protocol. Don't do that.)
**** List of PLAYBACK Hardware Devices ****
card 1: NVidia [HDA NVidia], device 3: HDMI 0 [HDMI 0]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 1: NVidia [HDA NVidia], device 7: HDMI 1 [HDMI 1]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 1: NVidia [HDA NVidia], device 8: HDMI 2 [HDMI 2]
   Subdevices: 1/1
   Subdevice #0: subdevice #0

ARECORD

No protocol specified
xcb_connection_has_error() returned true
XDG_RUNTIME_DIR (/run/user/1000) is not owned by us (uid 0), but by uid 1000! (This could e g happen if you try to connect to a non-root PulseAudio as a root user, over the native protocol. Don't do that.)
**** List of CAPTURE Hardware Devices ****

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [PCH]

No protocol specified
xcb_connection_has_error() returned true
XDG_RUNTIME_DIR (/run/user/1000) is not owned by us (uid 0), but by uid 1000! (This could e g happen if you try to connect to a non-root PulseAudio as a root user, over the native protocol. Don't do that.)
Card hw:0 'PCH'/'HDA Intel PCH at 0xc4940000 irq 151'
   Mixer name	: ''
   Components	: 'HDA:10ec0298,17aa222e,00100103'
   Controls      : 2
   Simple ctrls  : 2
No protocol specified
xcb_connection_has_error() returned true
XDG_RUNTIME_DIR (/run/user/1000) is not owned by us (uid 0), but by uid 1000! (This could e g happen if you try to connect to a non-root PulseAudio as a root user, over the native protocol. Don't do that.)
Simple mixer control 'PCM',0
   Capabilities: pvolume
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 255
   Mono:
   Front Left: Playback 255 [100%] [0.00dB]
   Front Right: Playback 255 [100%] [0.00dB]
Simple mixer control 'Digital',0
   Capabilities: cvolume
   Capture channels: Front Left - Front Right
   Limits: Capture 0 - 120
   Front Left: Capture 120 [100%] [30.00dB]
   Front Right: Capture 120 [100%] [30.00dB]

!!-------Mixer controls for card 1 [NVidia]

No protocol specified
xcb_connection_has_error() returned true
XDG_RUNTIME_DIR (/run/user/1000) is not owned by us (uid 0), but by uid 1000! (This could e g happen if you try to connect to a non-root PulseAudio as a root user, over the native protocol. Don't do that.)
Card hw:1 'NVidia'/'HDA NVidia at 0xc3000000 irq 17'
   Mixer name	: 'Nvidia GPU 60 HDMI/DP'
   Components	: 'HDA:10de0060,00000000,00100100'
   Controls      : 21
   Simple ctrls  : 3
No protocol specified
xcb_connection_has_error() returned true
XDG_RUNTIME_DIR (/run/user/1000) is not owned by us (uid 0), but by uid 1000! (This could e g happen if you try to connect to a non-root PulseAudio as a root user, over the native protocol. Don't do that.)
Simple mixer control 'IEC958',0
   Capabilities: pswitch pswitch-joined
   Playback channels: Mono
   Mono: Playback [on]
Simple mixer control 'IEC958',1
   Capabilities: pswitch pswitch-joined
   Playback channels: Mono
   Mono: Playback [on]
Simple mixer control 'IEC958',2
   Capabilities: pswitch pswitch-joined
   Playback channels: Mono
   Mono: Playback [on]


!!Alsactl output
!!--------------

--startcollapse--
state.PCH {
 	control.1 {
 		iface MIXER
 		name 'PCM Playback Volume'
 		value.0 255
 		value.1 255
 		comment {
 			access 'read write user'
 			type INTEGER
 			count 2
 			range '0 - 255'
 			tlv '0000000100000008ffffec1400000014'
 			dbmin -5100
 			dbmax 0
 			dbvalue.0 0
 			dbvalue.1 0
 		}
 	}
 	control.2 {
 		iface MIXER
 		name 'Digital Capture Volume'
 		value.0 120
 		value.1 120
 		comment {
 			access 'read write user'
 			type INTEGER
 			count 2
 			range '0 - 120'
 			tlv '0000000100000008fffff44800000032'
 			dbmin -3000
 			dbmax 3000
 			dbvalue.0 3000
 			dbvalue.1 3000
 		}
 	}
}
state.NVidia {
 	control.1 {
 		iface CARD
 		name 'HDMI/DP,pcm=3 Jack'
 		value false
 		comment {
 			access read
 			type BOOLEAN
 			count 1
 		}
 	}
 	control.2 {
 		iface MIXER
 		name 'IEC958 Playback Con Mask'
 		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
 		comment {
 			access read
 			type IEC958
 			count 1
 		}
 	}
 	control.3 {
 		iface MIXER
 		name 'IEC958 Playback Pro Mask'
 		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
 		comment {
 			access read
 			type IEC958
 			count 1
 		}
 	}
 	control.4 {
 		iface MIXER
 		name 'IEC958 Playback Default'
 		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
 		comment {
 			access 'read write'
 			type IEC958
 			count 1
 		}
 	}
 	control.5 {
 		iface MIXER
 		name 'IEC958 Playback Switch'
 		value true
 		comment {
 			access 'read write'
 			type BOOLEAN
 			count 1
 		}
 	}
 	control.6 {
 		iface PCM
 		device 3
 		name ELD
 		value ''
 		comment {
 			access 'read volatile'
 			type BYTES
 			count 0
 		}
 	}
 	control.7 {
 		iface CARD
 		name 'HDMI/DP,pcm=7 Jack'
 		value false
 		comment {
 			access read
 			type BOOLEAN
 			count 1
 		}
 	}
 	control.8 {
 		iface MIXER
 		name 'IEC958 Playback Con Mask'
 		index 1
 		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
 		comment {
 			access read
 			type IEC958
 			count 1
 		}
 	}
 	control.9 {
 		iface MIXER
 		name 'IEC958 Playback Pro Mask'
 		index 1
 		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
 		comment {
 			access read
 			type IEC958
 			count 1
 		}
 	}
 	control.10 {
 		iface MIXER
 		name 'IEC958 Playback Default'
 		index 1
 		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
 		comment {
 			access 'read write'
 			type IEC958
 			count 1
 		}
 	}
 	control.11 {
 		iface MIXER
 		name 'IEC958 Playback Switch'
 		index 1
 		value true
 		comment {
 			access 'read write'
 			type BOOLEAN
 			count 1
 		}
 	}
 	control.12 {
 		iface PCM
 		device 7
 		name ELD
 		value ''
 		comment {
 			access 'read volatile'
 			type BYTES
 			count 0
 		}
 	}
 	control.13 {
 		iface CARD
 		name 'HDMI/DP,pcm=8 Jack'
 		value false
 		comment {
 			access read
 			type BOOLEAN
 			count 1
 		}
 	}
 	control.14 {
 		iface MIXER
 		name 'IEC958 Playback Con Mask'
 		index 2
 		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
 		comment {
 			access read
 			type IEC958
 			count 1
 		}
 	}
 	control.15 {
 		iface MIXER
 		name 'IEC958 Playback Pro Mask'
 		index 2
 		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
 		comment {
 			access read
 			type IEC958
 			count 1
 		}
 	}
 	control.16 {
 		iface MIXER
 		name 'IEC958 Playback Default'
 		index 2
 		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
 		comment {
 			access 'read write'
 			type IEC958
 			count 1
 		}
 	}
 	control.17 {
 		iface MIXER
 		name 'IEC958 Playback Switch'
 		index 2
 		value true
 		comment {
 			access 'read write'
 			type BOOLEAN
 			count 1
 		}
 	}
 	control.18 {
 		iface PCM
 		device 8
 		name ELD
 		value ''
 		comment {
 			access 'read volatile'
 			type BYTES
 			count 0
 		}
 	}
 	control.19 {
 		iface PCM
 		device 3
 		name 'Playback Channel Map'
 		value.0 0
 		value.1 0
 		value.2 0
 		value.3 0
 		value.4 0
 		value.5 0
 		value.6 0
 		value.7 0
 		comment {
 			access 'read write'
 			type INTEGER
 			count 8
 			range '0 - 36'
 		}
 	}
 	control.20 {
 		iface PCM
 		device 7
 		name 'Playback Channel Map'
 		value.0 0
 		value.1 0
 		value.2 0
 		value.3 0
 		value.4 0
 		value.5 0
 		value.6 0
 		value.7 0
 		comment {
 			access 'read write'
 			type INTEGER
 			count 8
 			range '0 - 36'
 		}
 	}
 	control.21 {
 		iface PCM
 		device 8
 		name 'Playback Channel Map'
 		value.0 0
 		value.1 0
 		value.2 0
 		value.3 0
 		value.4 0
 		value.5 0
 		value.6 0
 		value.7 0
 		comment {
 			access 'read write'
 			type INTEGER
 			count 8
 			range '0 - 36'
 		}
 	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
snd_hda_codec_hdmi
snd_hda_intel
snd_hda_codec
snd_hwdep
snd_hda_core
snd_pcm
snd_timer
nvidia_modeset
zfs
zunicode
zlua
nvidia
iwlmvm
mac80211
btusb
btrtl
btbcm
btintel
iwlwifi
bluetooth
qmi_wwan
cfg80211
ecdh_generic
thinkpad_acpi
rfkill
zcommon
znvpair
zavl
icp
spl
sdhci_pci
cqhci
sdhci
mmc_block
rtsx_pci_sdmmc
rtsx_pci
mfd_core


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x12 0x90a60140
0x13 0x40000000
0x14 0x90170110
0x17 0x411111f0
0x18 0x03a11030
0x19 0x411111f0
0x1a 0x411111f0
0x1d 0x40648605
0x1e 0x411111f0
0x1f 0x411111f0
0x21 0x03211020

/sys/class/sound/hwC0D0/driver_pin_configs:

/sys/class/sound/hwC0D0/user_pin_configs:

/sys/class/sound/hwC0D0/init_verbs:

/sys/class/sound/hwC0D0/hints:

/sys/class/sound/hwC1D0/init_pin_configs:
0x04 0x185600f0
0x05 0x185600f0
0x06 0x585600f0
0x07 0x185600f0

/sys/class/sound/hwC1D0/driver_pin_configs:

/sys/class/sound/hwC1D0/user_pin_configs:

/sys/class/sound/hwC1D0/init_verbs:

/sys/class/sound/hwC1D0/hints:


!!ALSA/HDA dmesg
!!--------------

[    1.259752] ACPI: Added _OSI(Linux-Dell-Video)
[    1.259877] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    1.260005] ACPI: EC: EC started
--
[    2.455918] rtc_cmos 00:02: setting system clock to 2018-11-27 05:20:26 UTC (1543296026)
[    2.456097] ALSA device list:
[    2.456206]   No soundcards found.
[    2.457801] Freeing unused kernel image memory: 1644K
--
[   19.049747] wlan0: associated
[  266.605307] snd_hda_intel 0000:01:00.1: enabling device (0000 -> 0002)
[  266.605349] snd_hda_intel 0000:01:00.1: Disabling MSI
[  266.605355] snd_hda_intel 0000:01:00.1: Handle vga_switcheroo audio client
[  267.192262] input: HDA NVidia HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input10
[  267.192455] input: HDA NVidia HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input11
[  267.192605] input: HDA NVidia HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input12




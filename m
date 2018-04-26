Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754010AbeDZHwU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 03:52:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59277 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753068AbeDZHwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 03:52:16 -0400
X-Google-Smtp-Source: AIpwx49uNQlBG7Hp7lONoy0qQlzuu4Gn/j/2Y2WCIoc9b0H/sb17EGHUL9SaYS4KpeE9NAT4pfVzOg==
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [alsa-devel] [PATCH v4 3/3] ALSA: hda: Disabled unused audio
 controller for Dell platforms with Switchable Graphics
From: Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20180424211347.GA18258@wunner.de>
Date: Thu, 26 Apr 2018 15:52:08 +0800
Cc: =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Takashi Iwai <tiwai@suse.de>, mjg59@srcf.ucam.org,
        dvhart@infradead.org, andy@infradead.org,
        Mario Limonciello <mario.limonciello@dell.com>,
        alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Content-Transfer-Encoding: 8bit
Message-Id: <A9269F25-2239-4E3C-A3B3-FFDD69A90DD0@canonical.com>
References: <20180420094432.13133-1-kai.heng.feng@canonical.com>
 <20180420094432.13133-3-kai.heng.feng@canonical.com>
 <s5hbmeew01d.wl-tiwai@suse.de>
 <E5D0F76C-0A83-4D2C-81F7-BD5768C0A7DC@canonical.com>
 <20180423080844.yh6ndicpu6mwy336@pali>
 <FF30493D-012C-41E8-B379-85138E1EDE05@canonical.com>
 <20180424211347.GA18258@wunner.de>
To: Lukas Wunner <lukas@wunner.de>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Apr 25, 2018, at 5:13 AM, Lukas Wunner <lukas@wunner.de> wrote:
>
> On Mon, Apr 23, 2018 at 04:18:35PM +0800, Kai Heng Feng wrote:
>>> On Apr 23, 2018, at 4:08 PM, Pali RohÃ¡r <pali.rohar@gmail.com> wrote:
>>> On Monday 23 April 2018 16:04:55 Kai Heng Feng wrote:
>>>>> On Apr 20, 2018, at 8:10 PM, Takashi Iwai <tiwai@suse.de> wrote:
>>>>> On Fri, 20 Apr 2018 11:44:32 +0200, Kai-Heng Feng wrote:
>>>>>> Now it's a typical discrete-only system. HDMI audio comes from AMD  
>>>>>> audio
>>>>>> controller, others from Intel audio controller.
>>>>>>
>>>>>> When SG is enabled, the unused AMD audio contoller still exposes its
>>>>>> sysfs, so userspace still opens the control file and stream. If
>>>>>> userspace tries to output sound through the stream, it hangs the  
>>>>>> system.
>>>>>
>>>>> Hm, could you give more information about how it hangs?
>>>>
>>>> Well, I should say "it hangs the userspace process" instead.
>>>>
>>>> $ speaker-test -t wav -c 2 -D hw:CARD=HDMI,DEV=3
>>>> ...and it just stopped. Can't Ctrl+C to break it.
>>>
>>> So userspace process cannot be killed at all? Then it is different bug
>>> in kernel and disabling pci device is just a workaround. Not a real fix.
>>>
>>> I would propose to find out what happen and why it cannot be killed
>>> (probably it stuck somewhere in kernel) and fix it properly.
>>
>> That's because the audio device got runtime suspended by the graphics.
>>
>> In this case, if we really want to use the the discrete audio, then we  
>> also
>> need to wake up the graphics.
>> The discrete audio is totally useless when SG is enabled, so my approach  
>> is
>> just to disable it.
>
> I don't quite follow, that should be fixed by commit 07f4f97d7b4b
> ("vga_switcheroo: Use device link for HDA controller") which landed
> in v4.17-rc1.

Looks like I hit a new bug: the discrete GFX and its audio controller never  
enters to D3.
The GFX can enter to D3 with my prosed patch.

>
> My understanding was that with SG enabled, the external DP/HDMI ports
> are muxed to the Intel GPU, so audio can only be streamed to external
> displays by the Intel HDA, not by the HDA integrated into the discrete
> AMD/Nvidia GPU.  Audio streamed to the latter would essentially end up
> in a blackhole.  And preventing the user from seeing such useless audio
> devices was the sole purpose of this commit.  Am I missing something?

Yes this is the intention.

Kai-Heng

>
> Thanks,
>
> Lukas

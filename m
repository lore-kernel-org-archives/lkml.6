Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754756AbeCRVeI (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 17:34:08 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:53639 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754304AbeCRVeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 17:34:06 -0400
X-Google-Smtp-Source: AG47ELuu80TwCNmhgIVps6GKqcjcM2UfWE+ZZDVLpUbwTopahtWkE+8ktED1hTc4WGXXBboBhkkfNg==
Subject: Re: [Possible REGRESSION, 4.16-rc4] Error updating SMART data during
 runtime and could not connect to lvmetad at some boot attempts
To: Martin Steigerwald <martin@lichtvoll.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Tejun Heo <tj@kernel.org>
References: <27165802.vQ9JbjrmvU@merkaba> <3573548.kp1edD77Gq@merkaba>
 <1e708e58-5ba7-8ce9-2edf-6cc7ba5f80c3@redhat.com>
 <4373847.u3KAOBid1D@merkaba>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <d9c6e12b-a1ea-92e1-04ba-010e3db7c480@redhat.com>
Date: Sun, 18 Mar 2018 22:34:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <4373847.u3KAOBid1D@merkaba>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14-03-18 13:48, Martin Steigerwald wrote:
> Hans de Goede - 14.03.18, 12:05:
>> Hi,
>>
>> On 14-03-18 12:01, Martin Steigerwald wrote:
>>> Hans de Goede - 11.03.18, 15:37:
>>>> Hi Martin,
>>>>
>>>> On 11-03-18 09:20, Martin Steigerwald wrote:
>>>>> Hello.
>>>>>
>>>>> Since 4.16-rc4 (upgraded from 4.15.2 which worked) I have an issue
>>>>> with SMART checks occassionally failing like this:
>>>>>
>>>>> smartd[28017]: Device: /dev/sdb [SAT], is in SLEEP mode, suspending
>>>>> checks
>>>>> udisksd[24408]: Error performing housekeeping for drive
>>>>> /org/freedesktop/UDisks2/drives/INTEL_SSDSA2CW300G3_[…]: Error updating
>>>>> SMART data: Error sending ATA command CHECK POWER MODE: Unexpected sense
>>>>> data returned:#0120000: 0e 09 0c 00  00 00 ff 00  00 00 00 00  00 00 50
>>>>> 00    ..............P.#0120010: 00 00 00 00  00 00 00 00  00 00 00 00
>>>>> 00
>>>>> 00 00 00    ................#012 (g-io-error-quark, 0) merkaba
>>>>> udisksd[24408]: Error performing housekeeping for drive
>>>>> /org/freedesktop/UDisks2/drives/Crucial_CT480M500SSD3_[…]: Error
>>>>> updating
>>>>> SMART dat a: Error sending ATA command CHECK POWER MODE: Unexpected
>>>>> sense
>>>>> data returned:#0120000: 01 00 1d 00  00 00 0e 09  0c 00 00 00  ff 00 00
>>>>> 00    ................#0120010: 00 0 0 00 00  50 00 00 00  00 00 00 00
>>>>> 00 00 00 00    ....P...........#012 (g-io-error-quark, 0)
>>>>>
>>>>> (Intel SSD is connected via SATA, Crucial via mSATA in a ThinkPad T520)
>>>>>
>>>>> However when I then check manually with smartctl -a | -x | -H the device
>>>>> reports SMART data just fine.
>>>>>
>>>>> As smartd correctly detects that device is in sleep mode, this may be an
>>>>> userspace issue in udisksd.
>>>>>
>>>>> Also at some boot attempts the boot hangs with a message like "could not
>>>>> connect to lvmetad, scanning manually for devices". I use BTRFS RAID 1
>>>>> on to LVs (each on one of the SSDs). A configuration that requires a
>>>>> manual
>>>>> adaption to InitRAMFS in order to boot (basically vgchange -ay before
>>>>> btrfs device scan).
>>>>>
>>>>> I wonder whether that has to do with the new SATA LPM policy stuff, but
>>>>> as
>>>>> I had issues with
>>>>>
>>>>> 3 => Medium power with Device Initiated PM enabled
>>>>>
>>>>> (machine did not boot, which could also have been caused by me
>>>>> accidentally
>>>>> removing all TCP/IP network support in the kernel with that setting)
>>>>>
>>>>> I set it back to
>>>>>
>>>>> CONFIG_SATA_MOBILE_LPM_POLICY=0
>>>>>
>>>>> (firmware settings)
>>>>
>>>> Right, so at that settings the LPM policy changes are effectively
>>>> disabled and cannot explain your SMART issues.
>>>>
>>>> Still I would like to zoom in on this part of your bug report, because
>>>> for Fedora 28 we are planning to ship with
>>>> CONFIG_SATA_MOBILE_LPM_POLICY=3
>>>> and AFAIK Ubuntu has similar plans.
>>>>
>>>> I suspect that the issue you were seeing with
>>>> CONFIG_SATA_MOBILE_LPM_POLICY=3 were with the Crucial disk ? I've
>>>> attached
>>>> a patch for you to test, which disabled LPM for your model Crucial SSD
>>>> (but
>>>> keeps it on for the Intel disk) if you can confirm that with that patch
>>>> you
>>>> can run with
>>>> CONFIG_SATA_MOBILE_LPM_POLICY=3 without issues that would be great.
>>>
>>> With 4.16-rc5 with CONFIG_SATA_MOBILE_LPM_POLICY=3 the system successfully
>>> booted three times in a row. So feel free to add tested-by.
>>
>> Thanks.
>>
>> To be clear, you're talking about 4.16-rc5 with the patch I made to
>> blacklist the Crucial disk I assume, not just plain 4.16-rc5, right ?
> 
> 4.16-rc5 with your
> 
> 0001-libata-Apply-NOLPM-quirk-to-Crucial-M500-480GB-SSDs.patch

I was about to submit this upstream and was planning on extending it to
also cover the 960GB version, which lead to me doing a quick google.
Judging from the google results it seems that there are multiple firmware
versions of this SSD out there and I wonder if you are perhaps running
an older version of the firmware. If you do:

dmesg | grep Crucial_CT480M500

You should see something like this:

ata2.00: ATA-9: Crucial_CT480M500SSD3, MU03, max UDMA/133

I'm interested in the "MU03" part, what is that in your case?

Note I'm not saying we should not do the NOLPM quirk, but maybe we
can limit it to older firmware.

Regards,

Hans

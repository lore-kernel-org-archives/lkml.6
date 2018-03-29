Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbeC2HVc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 03:21:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33248 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750774AbeC2HVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 03:21:31 -0400
X-Google-Smtp-Source: AIpwx48AFm9Ayi4s9TRJ977hd0fV6HMP3HU/ZFRJu6cJwKOTaivTZjb3G1pI3Zls9tu04ZaDkHaeRQ==
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: `do_IRQ: 1.55 No irq handler for vector` on ASRock E350M1
From: Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <13724e9f-a6f3-ece2-b007-741e45ef3660@amd.com>
Date: Thu, 29 Mar 2018 15:21:22 +0800
Cc: "Morton, Eric" <Eric.Morton@amd.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Paul Menzel <pmenzel+linux-irq@molgen.mpg.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Content-Transfer-Encoding: 8bit
Message-Id: <D5A69EE0-5ADD-42A2-A7E1-AB557C82B8D8@canonical.com>
References: <8bb6b660-ce08-37a7-d1ab-38a690595856@molgen.mpg.de>
 <alpine.DEB.2.21.1802231914590.1437@nanos.tec.linutronix.de>
 <20180223190950.GJ4981@pd.tnic>
 <61f2fc82-4eee-8678-c37a-dc300dde4edf@molgen.mpg.de>
 <alpine.DEB.2.21.1802240941190.1825@nanos.tec.linutronix.de>
 <c84da3a5-107c-2ddc-d108-ebb33df49719@amd.com>
 <20180226163102.GM4377@pd.tnic>
 <0337DBEF-58BD-447A-A828-DE1A7CEF21E4@amd.com>
 <13724e9f-a6f3-ece2-b007-741e45ef3660@amd.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom & Thomas,

> On Feb 27, 2018, at 12:42 AM, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 2/26/2018 10:37 AM, Morton, Eric wrote:
>> Thomas,
>>
>> Yazen dug out PLAT-21393 as sounding like this issue. I haven't had a  
>> chance to digest it.
>
> Yes, internally to AMD, that was the bug that tracked the issue I was
> referring to.

There's also another user [1] affected by this issue.

Ethernet r8169 failed to work after system suspend:

[ 150.944101] do_IRQ: 3.37 No irq handler for vector
[ 150.944105] r8169 0000:01:00.0 enp1s0: link down

It's a regression started from v4.15-rc5.

[1] https://bugs.launchpad.net/bugs/1752772

Kai-Heng

>
> Thanks,
> Tom
>
>> Eric
>>
>> ﻿On 2/26/18, 10:31 AM, "Borislav Petkov" <bp@alien8.de> wrote:
>>
>>     On Mon, Feb 26, 2018 at 10:14:10AM -0600, Tom Lendacky wrote:
>>> On 2/24/2018 2:59 AM, Thomas Gleixner wrote:
>>>> On Sat, 24 Feb 2018, Paul Menzel wrote:
>>>>> Am 23.02.2018 um 20:09 schrieb Borislav Petkov:
>>>>>> On Fri, Feb 23, 2018 at 07:18:34PM +0100, Thomas Gleixner wrote:
>>>>>>> Borislav is seeing similar issues on larger AMD machines. The  
>>>>>>> interrupt
>>>>>>> seems to come from BIOS/microcode during bringup of secondary CPUs  
>>>>>>> and we
>>>>>>> have no idea why.
>>>>>>
>>>>>> Paul, can you boot 4.14 and grep your dmesg for something like:
>>>>>>
>>>>>> [    0.000000] spurious 8259A interrupt: IRQ7. >
>>>>>> ?
>>>>>
>>>>> No, I do not see that. Please find the logs attached.
>>>>
>>>> From your 4.14 log:
>>>>
>>>> Feb 19 09:48:06.843173 kodi kernel: CPU 0 irqstacks, hard=e9b0a000  
>>>> soft=e9b0c000
>>>> Feb 19 09:48:06.843216 kodi kernel: spurious 8259A interrupt: IRQ7.
>>>
>>> I think I remember seeing something like this previously and it turned  
>>> out
>>> to be a BIOS bug.  All the AP's were enabled to work with the legacy 8259
>>> interrupt controller.  In an SMP system, only one processor in the system
>>> should be configured to handle legacy 8259 interrupts (ExtINT delivery
>>> mode - see Intel's SDM, Volume 3, section 10.5.1, Delivery Mode).  Once
>>> the BIOS was fixed, the spurious interrupt message went away.
>>>
>>> I believe at some point during UEFI, the APs were exposed to an ExtINT
>>> interrupt.  Since they were configured to handle ExtINT delivery mode and
>>> interrupts were not yet enabled, the interrupt was left pending.  When  
>>> the
>>> APs were started by the OS and interrupts were enabled, the interrupt
>>> triggered. Since the original pending interrupt was handled by the BSP,
>>> there was no longer an interrupt actually pending, so the 8259 responds
>>> with IRQ 7 when queried by the OS.  This occurred for each AP.
>>
>>     Interesting - is this something that can happen on Zen too?
>>
>>     Because I have such reports too.
>>
>>     --
>>     Regards/Gruss,
>>         Boris.
>>
>>     Good mailing practices for 400: avoid top-posting and trim the reply.

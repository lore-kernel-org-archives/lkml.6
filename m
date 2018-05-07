Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752715AbeEGPNt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 11:13:49 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38252 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752691AbeEGPNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 11:13:36 -0400
X-Google-Smtp-Source: AB8JxZpIBr7VDe6R6bBLDwK+cYmkB9RvAlVP8i4m495khMTrRIlNlN4f7OuVU2inKznAPWgvlefk+A==
Subject: Re: [J-core] [PATCH v5 00/22] sh: LANDISK and R2Dplus convert to
 device tree
To: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <E7B2D113-C30D-4A32-AFB6-DC91DDADE0E8@physik.fu-berlin.de>
 <20171117191706.GF1627@brightrain.aerifal.cx>
 <7193aa1b-50e3-11d4-f93d-f567e2e06b8c@physik.fu-berlin.de>
 <20180105212857.GR1627@brightrain.aerifal.cx>
 <20180503013708.GC1392@brightrain.aerifal.cx>
 <20180503023320.GD1392@brightrain.aerifal.cx>
 <048ab147-21b8-045d-d21c-e1be2dd0e954@physik.fu-berlin.de>
 <87k1sgtf8t.wl-ysato@users.sourceforge.jp>
 <5f690985-e905-deb9-aa4f-51561463ae22@physik.fu-berlin.de>
 <9051f0a5-bc75-b49e-c8c3-aa877be1979e@landley.net>
 <20180507144306.GG1392@brightrain.aerifal.cx>
From: Rob Landley <rob@landley.net>
Message-ID: <775bc754-0181-6a13-d625-825bf601eb77@landley.net>
Date: Mon, 7 May 2018 10:13:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180507144306.GG1392@brightrain.aerifal.cx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/07/2018 09:43 AM, Rich Felker wrote:
> On Mon, May 07, 2018 at 08:40:35AM -0500, Rob Landley wrote:
>> On 05/07/2018 06:00 AM, John Paul Adrian Glaubitz wrote:
>>> I have been able to boot my own kernel on my USL-5P device, but
>>> I could never get it to detect the IDE controller. Do I need
>>> an additional patch for that?
>>
>> On a related note, is there a list of boards anywhere? I'm working on a 7760
>> system at $DAYJOB, Rich has a landisk which according to
>> https://www.openbsd.org/landisk.html is an SH7751R, and Sato-san says that
>> QEMU's -r2d emulates that too? ("RTS7751R2Dplus is QEMU-SH4 target. So easy
>> trying.")
>>
>> What other boards do we need to covert to device tree? arch/sh/boards has 15 C
>> files and 19 subdirectories, but I dunno the status of any of them...
> 
> I think asking "what we need to convert" is at least slightly
> mis-framed. Once the basics for device tree support are in place
> (basically patches 06-09), which boards are supported by device tree
> is mostly a matter of (1) whether the hardware drivers you want to use
> have bindings and use modern kernel interfaces, and (2) someone
> writing the dts files.

(3) being able to test the result on real hardware.

We can _add_ device tree support without that, but can we remove the old board
files without it?

> I don't mind holding off a little bit on removal of the legacy board
> file support if it's hard to get enough hardware working right away
> with device tree, but I do want to move towards getting rid of it as
> soon as we can, since it's a large volume of code cutting into my
> ability to have a good maintainer-level understanding of the arch/sh
> tree and has a lot of crufty, unmaintained parallel infrastructure
> duplicating stuff that can be done in cleaner and more modern ways
> (see the threads on early platform device stuff, rtc drivers, etc.).

The process may include a deprecation of hardware nobody has anymore, with call
for testers, for a year or so before deleting stuff. (And then the old stuff's
in git if somebody finds a board and wants to fish it out.)

Also, I'd really like QEMU support to act as a first class board. At least 256
megs of ram (so you can do native compiles on it), serial support that works
(enabling the FIFO broke it because they don't implement the '15 bits of silence
triggers a flush timer' part, so data gets stranded in the buffer until enough
comes in to fill it the rest of the way which is a pain to type at when it's a
serial console), multiple hard drives, and so on.

I'd be fine with virtio but there's no virtio devices on that target I've
noticed yet, although maybe I just haven't figured out how to enable it...

> Rich

Rob

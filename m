Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751410AbeDDMzY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 08:55:24 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:52298 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750842AbeDDMzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 08:55:22 -0400
X-Google-Smtp-Source: AIpwx4+bd0m7S4DUrtaKx0o55Vytp9SwTAqHWWhHWDLkOPofmHGi/+fXljowDKIi0olIynQi+Ra4enp2ZNnQy7lLxIw=
MIME-Version: 1.0
In-Reply-To: <20180403211326.4907f1bc@laptop64.home>
References: <20180402122536.5083-1-jandryuk@gmail.com> <20180402123435.5587-1-jandryuk@gmail.com>
 <20180403211326.4907f1bc@laptop64.home>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Wed, 4 Apr 2018 08:55:20 -0400
Message-ID: <CAKf6xpu4=kLuqZqFsxqFCzLMyLBZyi3C9W_yyssEt=56dhF6RA@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: i801: blacklist Host Notify on HP EliteBook G3 850
To: Andreas Radke <andyrtr@archlinux.org>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>,
        benjamin.tissoires@redhat.com, aduggan@synaptics.com,
        linux-i2c@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 3, 2018 at 3:13 PM, Andreas Radke <andyrtr@archlinux.org> wrote:
> Am Mon,  2 Apr 2018 08:34:35 -0400
> schrieb Jason Andryuk <jandryuk@gmail.com>:
>
>> The HP EliteBook G3 850 has a weird bug where a subsequent cold boot
>> hangs while plugged in if Linux enables the Host Notify features of
>> i2c-i801.  The cold boot hang depends on how the system boots.  It
>> does not hang on UEFI Grub text boot or legacy Grub text boot.  But
>> it does hang on legacy Grub graphical boot and Intel Boot Agent PXE
>> text boot. Booting unplugged is not affected.
>>
>> Disabling the Host Notify feature with disable_feature=0x20 works
>> around the bug, so automatically do so based on DMI information.
>>
>> More information can be found here:
>> https://www.spinics.net/lists/linux-i2c/msg33938.html
>
> I'm faced with similar cold boot issues on my HP ProBook 430 G4 model.
> Trying your hint with adding
> "options i2c_i801 disable_features=0x20"
> to /etc/modprobe.d/i2c_i801.conf doesn't seem to solve it for me.

Maybe verify the option is set by checking
/sys/module/i2c_i801/parameters/disable_features ?  Looks like dmesg
should also report "SMBus Host Notify disabled by user" when disabled.
I run with i801 built-in, so I was specifying the option on the kernel
command line.

> My system boots legacy grub in text mode (KMS) and seems to keep hanging
> even with that option set.

Your cold boot hang is in legacy grub itself?  Legacy grub text mode
actually doesn't hang my G3 850 - it was switching to the graphical
splash screen that seemed to do it.  PXE booting via F12 was another
consistent way to hang.  It was very early in the PXE boot code -
before it checked the link status.  So you could try that with it just
plugged into a switch even if you don't have a PXE boot setup.

>From my previous post:
"""
The Boot Agent hang prints "Client Mac Addr 00-11-22-33-44-55<cursor>"
and hangs.  A normal boot prints a GUID on the same line and
continues.
"""

Otherwise, unfortunately, it might just be a different issue.

> Do you have any further idea?

For the G3 850, I bisected to the commit introducing i801 Host Notify
support.  It's time consuming, but you could do the same.  I first
noticed the issue when I moved from a working stable 4.4 to stable
4.14.  I tried some fedora kernels in between which narrowed down the
bisect range.  You could similarly grab and test pre-compiled kernels
to more quickly hone in on the regression range.

Regards,
Jason

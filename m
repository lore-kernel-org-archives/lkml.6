Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752967AbeDDVZ4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 17:25:56 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:34492 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751749AbeDDVZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 17:25:54 -0400
X-Google-Smtp-Source: AIpwx4/3r27RaiMq3pASLhRVPgmAs32TGXxma8oeytvG1CpDSCFauQIeFmU/EaAOYATVRKoqi0emJN14jZLjgmfrH3o=
MIME-Version: 1.0
In-Reply-To: <3265889.eu5sbW8aRz@natalenko.name>
References: <10360653.ov98egbaqx@natalenko.name> <CAGXu5jLwyot++C2EXs+032Lz5WdG65GsEJ-Q55rfhSbkG1Nh+A@mail.gmail.com>
 <3265889.eu5sbW8aRz@natalenko.name>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 4 Apr 2018 14:25:51 -0700
X-Google-Sender-Auth: 2VakgCmm7edjiGaWi1ywHDeok-o
Message-ID: <CAGXu5jL++CEmLzFtGMVMhGWBzHpsRNJPTsEoc7Pw1dP--=azCA@mail.gmail.com>
Subject: Re: usercopy whitelist woe in scsi_sense_cache
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: David Windsor <dave@nullcore.net>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w34LQ1ij019221

On Wed, Apr 4, 2018 at 1:49 PM, Oleksandr Natalenko
<oleksandr@natalenko.name> wrote:
> Hi.
>
> On středa 4. dubna 2018 22:21:53 CEST Kees Cook wrote:
>>
>> ...
>> That means scsi_sense_cache should be 96 bytes in size? But a 22 byte
>> read starting at offset 94 happened? That seems like a 20 byte read
>> beyond the end of the SLUB object? Though if it were reading past the
>> actual end of the object, I'd expect the hardened usercopy BUG (rather
>> than the WARN) to kick in. Ah, it looks like
>> /sys/kernel/slab/scsi_sense_cache/slab_size shows this to be 128 bytes
>> of actual allocation, so the 20 bytes doesn't strictly overlap another
>> object (hence no BUG):
>> ...
>
>
> Actually, I can trigger a BUG too:
>
> [  129.259213] usercopy: Kernel memory exposure attempt detected from SLUB
> object 'scsi_sense_cache' (offset 119, size 22)!

Wow, yeah, that's totally outside the slub object_size. How did you
trigger this? Just luck or something specific?

> [  129.265167] ------------[ cut here ]------------
> [  129.267579] kernel BUG at mm/usercopy.c:100!
>
> And also offset can be different, as you may see:
>
> [   55.993224] Bad or missing usercopy whitelist? Kernel memory exposure
> attempt detected from SLUB object 'scsi_sense_cache' (offset 76, size 22)!
> [   55.998678] WARNING: CPU: 0 PID: 1305 at mm/usercopy.c:81 usercopy_warn
> +0x7e/0xa0
>
> It looks like only the size stays the same.

I'd really like to understand how the buffer position can be
changing... I'd expect that to break all kinds of things (i.e.
free()ing the slab later would break too...)

>> Can you send me your .config? What SCSI drivers are you using in the
>> VM and on the real server?
>
> This is an Arch kernel with a config available here [1].
>
> For both server and VM "lspci -vv" shows "ahci" in use. Is this what you are
> asking for?

I think so, yeah.

>> Are you able to see what ioctl()s smartctl is issuing? I'll try to
>> reproduce this on my end...
>
> As per [2], strace shows "SG_IO" requests. Is this detailed enough?

That's useful, yeah. I'll try Douglas's suggestion of "smartctl -r
scsiioctl,3 ..." too.

> Thanks for looking into it.

Thanks for the report! I hope someone more familiar with sg_io() can
help explain the changing buffer offset... :P

-Kees

-- 
Kees Cook
Pixel Security

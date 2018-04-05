Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751356AbeDEOVj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 10:21:39 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:37428 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbeDEOVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 10:21:37 -0400
X-Google-Smtp-Source: AIpwx49keZVvIQnt01MtkmD8DObrMBhuWeTpCd/XKAmr+Ocb2xNACCcTr+kYQ3w4kOS+hbSQ4GzAcsPoVRPI2LIPCvU=
MIME-Version: 1.0
In-Reply-To: <7fc01f67a561ce1fad676fc34c2249e7@natalenko.name>
References: <10360653.ov98egbaqx@natalenko.name> <CAGXu5jLwyot++C2EXs+032Lz5WdG65GsEJ-Q55rfhSbkG1Nh+A@mail.gmail.com>
 <3265889.eu5sbW8aRz@natalenko.name> <CAGXu5jL++CEmLzFtGMVMhGWBzHpsRNJPTsEoc7Pw1dP--=azCA@mail.gmail.com>
 <7fc01f67a561ce1fad676fc34c2249e7@natalenko.name>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 5 Apr 2018 07:21:31 -0700
X-Google-Sender-Auth: tif0dVkqJ5OlnzzdS72CcwHtkp8
Message-ID: <CAGXu5jKhiE512yQXp90M+Wie=8RkpMZT-Yi_9BgjfKwibP433g@mail.gmail.com>
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
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w35ELh4w027127

On Thu, Apr 5, 2018 at 2:56 AM, Oleksandr Natalenko
<oleksandr@natalenko.name> wrote:
> Hi.
>
> 04.04.2018 23:25, Kees Cook wrote:
>>
>> Thanks for the report! I hope someone more familiar with sg_io() can
>> help explain the changing buffer offset... :P
>
>
> Also, FYI, I kept the server running with smartctl periodically invoked, and
> it was still triggering BUGs, however, I consider them to be more or less
> harmless until the server got stuck with high I/O wait this morning after
> next smartctl invocation. So, it isn't harmless, it seems…
>
> It could be unrelated, of course, since the journal didn't give me any hint
> (or a stack trace) on what happened, thus I'll monitor how things behave
> without smartctl too.

I had a VM running over night with:

[1]   Running                 while :; do
    smartctl -a /dev/sda > /dev/null;
done &
[2]-  Running                 while :; do
    ls --color=auto -lR / > /dev/null 2> /dev/null;
done &
[3]+  Running                 while :; do
    sleep $(( $RANDOM % 100 )); sync; echo 3 > /proc/sys/vm/drop_caches;
done &

and I haven't seen the issue. :(

FWIW, I'm using the ahci qemu driver:

-drive file=disk-image.raw,if=none,id=drive0,format=raw \
-device ahci,id=bus0 \
-device ide-drive,bus=bus0.0,drive=drive0

Does this match your qemu instance?

-Kees

-- 
Kees Cook
Pixel Security

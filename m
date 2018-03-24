Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752720AbeCXWf5 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 18:35:57 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:40908 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752597AbeCXWf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 18:35:56 -0400
X-Google-Smtp-Source: AG47ELuzeJxwlnMxjHz3d/rpDtZ1YBuhwJBMPuGxvyFXasmz9hn2pllAhteiSGo7cavZj7tFf7+6MVzhUu4hvBRGEAU=
MIME-Version: 1.0
In-Reply-To: <305249de-7892-fca4-b462-a493aa65d177@molgen.mpg.de>
References: <305249de-7892-fca4-b462-a493aa65d177@molgen.mpg.de>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sat, 24 Mar 2018 22:35:54 +0000
Message-ID: <CAKv+Gu84h2+zofb4v-QrVE7rqCrGC7MaHEw7tB+z2J8DczjoKw@mail.gmail.com>
Subject: Re: efisubsys_init takes more than a few milliseconds
To: Paul Menzel <pmenzel+linux-efi@molgen.mpg.de>
Cc: linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2OMa1Y0021210

Hello Paul,

On 24 March 2018 at 22:10, Paul Menzel <pmenzel+linux-efi@molgen.mpg.de> wrote:
> Dear Ard,
>
>
> According to `initcall_debug`, `efisubsys_init` takes more than a few
> milliseconds to execute on a Dell XPS 13 9370 (Intel(R) Core(TM) i7-8550U
> CPU @ 1.80GHz).
>
>> ```
>> […]
>> [ 0.144474] calling  efisubsys_init+0x0/0x2cf @ 1
>> [ 0.144474] Registered efivars operations
>> [ 0.173690] initcall efisubsys_init+0x0/0x2cf returned 0 after 27343 usecs
>> […]
>> ```
>
>
> To get a vanilla Linux kernel to boot in well under one second, it’d be nice
> if the time could be improved. Do you know, why it takes so long?
>
> According to `bootgraph.py` from pm-graph [1][2] it takes even a little
> longer.
>
>> efisubsys_init: start=690.841, end=720.493, length(w/o overhead)=31.250
>> ms, return=0
>
>
> There are several dozen calls to `virt_efi_get_next_variable()` all but one
> taking around 0.335 ms. This path needs to be optimized. Is that possible?
>

That depends. These are firmware calls, so to make these calls faster,
you need to modify the firmware, not the kernel.

We may be able to make more intrusive changes to get rid of this
delay, e.g., spin up a special kernel thread, but I'd have to check in
more detail. In the mean time, you can try passing 'efi=noruntime' to
the kernel.


> To reproduce this, clone the pm-graph repository [2], use `sudo
> ./bootgraph.py -f -fstat -maxdepth 10 -manual` to see what to add to
> `/boot/grub/grub.cfg`. Then reboot, and execute `sudo ./bootgraph.py -f
> -fstat -maxdepth 10`.
>
> If your system is powerful enough, you can use a higher maximum depth. I
> didn’t get around how `-cgfilter` works to get smaller HTML files.
>
>
> Kind regards,
>
> Paul
>
>
> [1] https://01.org/suspendresume
> [2] https://github.com/01org/pm-graph

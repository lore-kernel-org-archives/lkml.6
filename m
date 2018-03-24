Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752651AbeCXWKc (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 18:10:32 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:36623 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752229AbeCXWKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 18:10:31 -0400
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
From: Paul Menzel <pmenzel+linux-efi@molgen.mpg.de>
Subject: efisubsys_init takes more than a few milliseconds
Message-ID: <305249de-7892-fca4-b462-a493aa65d177@molgen.mpg.de>
Date: Sat, 24 Mar 2018 23:10:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Ard,


According to `initcall_debug`, `efisubsys_init` takes more than a few 
milliseconds to execute on a Dell XPS 13 9370 (Intel(R) Core(TM) 
i7-8550U CPU @ 1.80GHz).

> ```
> […]
> [    0.144474] calling  efisubsys_init+0x0/0x2cf @ 1
> [    0.144474] Registered efivars operations
> [    0.173690] initcall efisubsys_init+0x0/0x2cf returned 0 after 27343 usecs
> […]
> ```

To get a vanilla Linux kernel to boot in well under one second, it’d be 
nice if the time could be improved. Do you know, why it takes so long?

According to `bootgraph.py` from pm-graph [1][2] it takes even a little 
longer.

> efisubsys_init: start=690.841, end=720.493, length(w/o overhead)=31.250 ms, return=0

There are several dozen calls to `virt_efi_get_next_variable()` all but 
one taking around 0.335 ms. This path needs to be optimized. Is that 
possible?

To reproduce this, clone the pm-graph repository [2], use `sudo 
./bootgraph.py -f -fstat -maxdepth 10 -manual` to see what to add to 
`/boot/grub/grub.cfg`. Then reboot, and execute `sudo ./bootgraph.py -f 
-fstat -maxdepth 10`.

If your system is powerful enough, you can use a higher maximum depth. I 
didn’t get around how `-cgfilter` works to get smaller HTML files.


Kind regards,

Paul


[1] https://01.org/suspendresume
[2] https://github.com/01org/pm-graph

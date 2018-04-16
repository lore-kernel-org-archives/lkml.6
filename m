Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753299AbeDPGHP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 02:07:15 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:39784 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbeDPGHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 02:07:13 -0400
X-Google-Smtp-Source: AIpwx4+j7GgbdK8YHDs1CyHH3nDV+LFTTT0crbB3Ds6dTE86iSGBhmNarZOERt7bCzLbBtXoUzh/XA==
Date: Mon, 16 Apr 2018 08:07:09 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: instant reboot caused by 194a9749c73d650c0
Message-ID: <20180416060709.mnzk7fb5y45dnpmg@gmail.com>
References: <5ecfeb13-84e4-f1ef-bd30-391674b2050a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ecfeb13-84e4-f1ef-bd30-391674b2050a@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Eric Dumazet <eric.dumazet@gmail.com> wrote:

> Hi Kirill
> 
> For some reason, my hosts instantly crash at boot time, with absolutely no log on console.
> 
> Bisection pointed to :
> 
> $ git bisect bad
> 194a9749c73d650c0b1dfdee04fb0bdf0a888ba8 is the first bad commit
> commit 194a9749c73d650c0b1dfdee04fb0bdf0a888ba8
> Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Date:   Mon Mar 12 13:02:46 2018 +0300
> 
>     x86/boot/compressed/64: Handle 5-level paging boot if kernel is above 4G

Could you please send your .config? These early boot problems are sometimes build 
and Kconfig environment sensitive.

A high level description of your hardware and the distro you are using would also 
be useful.

Kirill, I'm curious about this change:

-       /* Calculate address we are running at */
-       call    1f
-1:     popl    %edi
-       subl    $1b, %edi
+       /* Calculate address of paging_enabled() once we are executing in the 
trampoline */
+       leal    paging_enabled - trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_OFFSET(%ecx), %eax

Here we change the calculation from a "discover where we are executing" method to 
a calculation method (which is fundamentally more fragile) - why?

Thanks,

	Ingo

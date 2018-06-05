Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbeFESLp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 14:11:45 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38306 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751769AbeFESLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 14:11:44 -0400
X-Google-Smtp-Source: ADUXVKI1FfpGNc8lSN+mb9W4bZo/U3/6d9h+MdNK/Ci+TbFJnT2NPG6fgmw3e9I+G1MfgxCLQpGc2AnG5/y6AUuIFek=
MIME-Version: 1.0
References: <CA+55aFxhx_tKGm02UySguvbyfB_7oTF31QfgOHCK0YkBvmfV0g@mail.gmail.com>
 <8f46ed9a-85c0-8df4-2d1e-d268cbc9d0e9@mageia.org>
In-Reply-To: <8f46ed9a-85c0-8df4-2d1e-d268cbc9d0e9@mageia.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 5 Jun 2018 11:11:32 -0700
Message-ID: <CA+55aFwJAbr8_Xs0ZX9K2iAr8bf=ZgNnKTLopQe6jPCgEBemrA@mail.gmail.com>
Subject: Re: building in 32bit chroot on x86_64 host broken (was: Linux 4.17)
To: tmb@mageia.org, Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 10:51 AM Thomas Backlund <tmb@mageia.org> wrote:
>
> Is this intentional ? If so, why ? If not, how can I fix it ?

It shouldn't be intentional. And I don't see anythin ghaving changed
in this area. We still have

  config 64BIT
        bool "64-bit kernel" if ARCH = "x86"
        default ARCH != "i386"

which is what it was in 4.16 too.

Of course, we also have (in the main Makefile)

  SUBARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \

and

  ARCH            ?= $(SUBARCH)

so if you don't set ARCH explicitly, it will always translate "i686"
into "x86", so it will default to 64-bit.

None of this is new to 4.17, though. Are you sure you didn't use to
have an ARCH=i386 somewhere?

Because this works for me:

    make ARCH=i386 oldconfig

and it's how I have done cross-builds before (although honestly, I
don't do them very often).

But adding Masahiro to the cc in case he sees something I've missed.

Of course, doing a bisect on *when* it broke for you would be good
too. You don't need to actually build the kernel, you can just bisect
the configuration phase (and even automate it with "git bisect run" if
you want to).

                 Linus

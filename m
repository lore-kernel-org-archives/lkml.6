Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752556AbeFETOI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:14:08 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:38180 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752139AbeFETOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:14:06 -0400
X-Google-Smtp-Source: ADUXVKKpa0XCJSjamIKvzDdD+wnws6gJfqTm+uzTWRgLGOYXM40xgPTIQqKnEl7hR77gxlgJZSc2VXh8AjECXappjEM=
MIME-Version: 1.0
References: <CA+55aFxhx_tKGm02UySguvbyfB_7oTF31QfgOHCK0YkBvmfV0g@mail.gmail.com>
 <8f46ed9a-85c0-8df4-2d1e-d268cbc9d0e9@mageia.org> <CA+55aFwJAbr8_Xs0ZX9K2iAr8bf=ZgNnKTLopQe6jPCgEBemrA@mail.gmail.com>
 <7a5458da-4222-7480-00ed-a51bed2c1e39@mageia.org> <CA+55aFyD0OMV1eoc9wh_hLcnRhHq2FwJf4EZcORmHPNxTRSX9Q@mail.gmail.com>
 <daf0fbba-6357-1748-d583-bcb5edf067ec@mageia.org>
In-Reply-To: <daf0fbba-6357-1748-d583-bcb5edf067ec@mageia.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 5 Jun 2018 12:13:54 -0700
Message-ID: <CA+55aFwiyuA4fKztofM-fdDSc+ZH9aAR1xksL8ZWRDE-pdXruw@mail.gmail.com>
Subject: Re: building in 32bit chroot on x86_64 host broken
To: tmb@mageia.org, Ulf Magnusson <ulfalizer@gmail.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 11:50 AM Thomas Backlund <tmb@mageia.org> wrote:
> >
> > but why do you care?
>
> Because without it running the build in the 32bit chroot will get the
> initial reported issue:

Ahh. I can re-create that now.

Yes, doing

      make ARCH=i386 allnoconfig

followed by

      make oldconfig

is broken. And doing a trivial "git bisect run" to pinpoint where
CONFIG_64BIT goes away gives us

f467c5640c29ad258c3cd8186a776c82fc3b8057 is the first bad commit

which does that

  "kconfig: only write '# CONFIG_FOO is not set' for visible symbols"

and it turns out that CONFIG_64BIT is not a visible symbol on x86-32,
because that question is disabled when ARCH != "x86".

        bool "64-bit kernel" if ARCH = "x86"

And the problem with that, is that *next* time around this config file
is used, because we don't have that

  # CONFIG_64BIT is not set

line, we don't turn it into

  CONFIG_64BIT=n

and then the "depends on" in X86_64

  config X86_64
          def_bool y
          depends on 64BIT

no longer hides it.

Hmm. Ulf, Masahiro, comments?

Should we just revert that commit?

Thomas, can you verify that a

        git revert f467c5640c29ad258c3cd8186a776c82fc3b8057

fixes the problem for you?

              Linus

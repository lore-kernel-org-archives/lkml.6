Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751978AbeFETfc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:35:32 -0400
Received: from mx1.yrkesakademin.fi ([85.134.45.194]:52939 "EHLO
        mx1.yrkesakademin.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751816AbeFETfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:35:31 -0400
Subject: Re: building in 32bit chroot on x86_64 host broken
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Ulf Magnusson <ulfalizer@gmail.com>
CC: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CA+55aFxhx_tKGm02UySguvbyfB_7oTF31QfgOHCK0YkBvmfV0g@mail.gmail.com>
 <8f46ed9a-85c0-8df4-2d1e-d268cbc9d0e9@mageia.org>
 <CA+55aFwJAbr8_Xs0ZX9K2iAr8bf=ZgNnKTLopQe6jPCgEBemrA@mail.gmail.com>
 <7a5458da-4222-7480-00ed-a51bed2c1e39@mageia.org>
 <CA+55aFyD0OMV1eoc9wh_hLcnRhHq2FwJf4EZcORmHPNxTRSX9Q@mail.gmail.com>
 <daf0fbba-6357-1748-d583-bcb5edf067ec@mageia.org>
 <CA+55aFwiyuA4fKztofM-fdDSc+ZH9aAR1xksL8ZWRDE-pdXruw@mail.gmail.com>
From: Thomas Backlund <tmb@mageia.org>
Message-ID: <28026f53-714a-b76d-00da-562c7612e265@mageia.org>
Date: Tue, 5 Jun 2018 22:35:43 +0259
MIME-Version: 1.0
In-Reply-To: <CA+55aFwiyuA4fKztofM-fdDSc+ZH9aAR1xksL8ZWRDE-pdXruw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-WatchGuard-Spam-ID: str=0001.0A0C0208.5B16E603.016C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-WatchGuard-Spam-Score: 0, clean; 0, virus threat unknown
X-WatchGuard-Mail-Client-IP: 85.134.45.194
X-WatchGuard-Mail-From: tmb@mageia.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Den 2018-06-05 kl. 22:13, skrev Linus Torvalds:
> On Tue, Jun 5, 2018 at 11:50 AM Thomas Backlund <tmb@mageia.org> wrote:
>>> but why do you care?
>> Because without it running the build in the 32bit chroot will get the
>> initial reported issue:
> Ahh. I can re-create that now.
>
> Yes, doing
>
>        make ARCH=i386 allnoconfig
>
> followed by
>
>        make oldconfig
>
> is broken. And doing a trivial "git bisect run" to pinpoint where
> CONFIG_64BIT goes away gives us
>
> f467c5640c29ad258c3cd8186a776c82fc3b8057 is the first bad commit
>
> which does that
>
>    "kconfig: only write '# CONFIG_FOO is not set' for visible symbols"
>
> and it turns out that CONFIG_64BIT is not a visible symbol on x86-32,
> because that question is disabled when ARCH != "x86".
>
>          bool "64-bit kernel" if ARCH = "x86"
>
> And the problem with that, is that *next* time around this config file
> is used, because we don't have that
>
>    # CONFIG_64BIT is not set
>
> line, we don't turn it into
>
>    CONFIG_64BIT=n
>
> and then the "depends on" in X86_64
>
>    config X86_64
>            def_bool y
>            depends on 64BIT
>
> no longer hides it.
>
> Hmm. Ulf, Masahiro, comments?
>
> Should we just revert that commit?
>
> Thomas, can you verify that a
>
>          git revert f467c5640c29ad258c3cd8186a776c82fc3b8057
>
> fixes the problem for you?
>
>                Linus

Yep, that fixes it so it works both  in the 32bit chroot and on the 
64bit host

--
Thomas

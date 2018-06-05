Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751995AbeFESXJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 14:23:09 -0400
Received: from mx2.yrkesakademin.fi ([85.134.45.195]:30035 "EHLO
        mx2.yrkesakademin.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751849AbeFESXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 14:23:08 -0400
Subject: Re: building in 32bit chroot on x86_64 host broken
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CA+55aFxhx_tKGm02UySguvbyfB_7oTF31QfgOHCK0YkBvmfV0g@mail.gmail.com>
 <8f46ed9a-85c0-8df4-2d1e-d268cbc9d0e9@mageia.org>
 <CA+55aFwJAbr8_Xs0ZX9K2iAr8bf=ZgNnKTLopQe6jPCgEBemrA@mail.gmail.com>
From: Thomas Backlund <tmb@mageia.org>
Message-ID: <7a5458da-4222-7480-00ed-a51bed2c1e39@mageia.org>
Date: Tue, 5 Jun 2018 21:23:19 +0259
MIME-Version: 1.0
In-Reply-To: <CA+55aFwJAbr8_Xs0ZX9K2iAr8bf=ZgNnKTLopQe6jPCgEBemrA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-WatchGuard-Spam-ID: str=0001.0A0C0204.5B16D50C.0022,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-WatchGuard-Spam-Score: 0, clean; 0, virus threat unknown
X-WatchGuard-Mail-Client-IP: 85.134.45.195
X-WatchGuard-Mail-From: tmb@mageia.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Den 2018-06-05 kl. 21:11, skrev Linus Torvalds:
> On Tue, Jun 5, 2018 at 10:51 AM Thomas Backlund <tmb@mageia.org> wrote:
>> Is this intentional ? If so, why ? If not, how can I fix it ?
> It shouldn't be intentional. And I don't see anythin ghaving changed
> in this area. We still have
>
>    config 64BIT
>          bool "64-bit kernel" if ARCH = "x86"
>          default ARCH != "i386"
>
> which is what it was in 4.16 too.
>
> Of course, we also have (in the main Makefile)
>
>    SUBARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
>
> and
>
>    ARCH            ?= $(SUBARCH)
>
> so if you don't set ARCH explicitly, it will always translate "i686"
> into "x86", so it will default to 64-bit.
>
> None of this is new to 4.17, though. Are you sure you didn't use to
> have an ARCH=i386 somewhere?
>
> Because this works for me:
>
>      make ARCH=i386 oldconfig
>
> and it's how I have done cross-builds before (although honestly, I
> don't do them very often).
>
> But adding Masahiro to the cc in case he sees something I've missed.
>
> Of course, doing a bisect on *when* it broke for you would be good
> too. You don't need to actually build the kernel, you can just bisect
> the configuration phase (and even automate it with "git bisect run" if
> you want to).
>
>                   Linus


Taking back the earlier " IGNORE " part...

This happends on the 64bit host:

# make ARCH=i386 oldconfig

--- .config.old 2018-06-05 21:17:07.829954548 +0300
+++ .config     2018-06-05 21:17:43.367487580 +0300
@@ -1,8 +1,7 @@
  #
  # Automatically generated file; DO NOT EDIT.
-# Linux/i386 4.16.12 Kernel Configuration
+# Linux/i386 4.17.0 Kernel Configuration
  #
-# CONFIG_64BIT is not set




So something _does_ strip away the needed config bit

So any ideas, or should I start bisecting ?

--
Thomas

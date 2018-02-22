Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751411AbeBVVWk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 16:22:40 -0500
Received: from mail-ua0-f179.google.com ([209.85.217.179]:36279 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751155AbeBVVWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 16:22:39 -0500
X-Google-Smtp-Source: AH8x226iBR4rECQ+sGOg7odK8vnAmjixFGMfvdYXZnaYv+9zR4EfAF1TXgKa5IlVpn+y2bQG7bt+D7TWJFTO5yXGWU8=
MIME-Version: 1.0
In-Reply-To: <66556bf7-3e67-5793-081e-76a01f598374@prevas.dk>
References: <20180222174140.GA3154@beast> <CA+55aFxDh-69p0Lr52icct6-3PGcsHaZmMqHwks8HptdmdxvTg@mail.gmail.com>
 <66556bf7-3e67-5793-081e-76a01f598374@prevas.dk>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 22 Feb 2018 13:22:37 -0800
X-Google-Sender-Auth: uep_ZaAsEHYbQcA4arY1TxHxTig
Message-ID: <CAGXu5jK2BA03xi6UCM66buAXemc1SdOmtGsxOSUdGNidxb4Hsw@mail.gmail.com>
Subject: Re: [PATCH v3] kconfig.h: Include compiler types to avoid missed
 struct attributes
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Patrick McLean <chutzpah@gentoo.org>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 1:07 PM, Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
> On 2018-02-22 19:04, Linus Torvalds wrote:
>>
>> Lookie here (in a fully built tree):
>>
>>     find . -name '*.o.cmd' |
>>         xargs grep -L linux/compiler_types.h |
>>         xargs grep -l linux/kconfig.h |
>>         while read i; do
>>             j=$(echo $i | sed 's/\.o.cmd$/\.c/' | sed 's:/\.:/:');
>>             test -f $j && echo $j;
>>         done
>>
>> shows that a number of files don't end up depending on that header
>> file, even though it's included (that "grep -l linux/kconfig,h"
>> triggers on the command itself having that "-include linux/kconfig.h"
>> line).
>>
>> It looks like "gcc -M" just doesn't list any files that get included
>> on the command line with "-include".
>
> It does, both per the documentation and testing it. But fixdep
> explicitly removes include/linux/kconfig.h along with
> include/generated/autoconf.h and a few others. So when you rebuilt after
> adding the #include to kconfig.h, I think nothing actually got built,
> and no new .o.cmd files got generated.
>
> Doing a clean build does make include/linux/compiler_{types,gcc}.h and
> the various fake include/config/.... they "depend" on appear in e.g.
> lib/.clz_tab.o.cmd.

I'm seeing the same. If I do:

$ find . -name '*.o.cmd' | xargs rm
$ make allmodconfig
$ make -j...
...
$ find-command-above...

I get no hits. And doing spot-testing shows dep changes are detected:

$ ls -l fs/nfsd/nfs4xdr.o
-rw-rw-r-- 1 kees kees 276088 Feb 22 13:15 fs/nfsd/nfs4xdr.o
$ make fs/nfsd/nfs4xdr.o
...generated-files-only...
$ ls -l fs/nfsd/nfs4xdr.o
-rw-rw-r-- 1 kees kees 276088 Feb 22 13:15 fs/nfsd/nfs4xdr.o
$ touch include/linux/compiler_types.h
$ make fs/nfsd/nfs4xdr.o
...various...
  CC [M]  fs/nfsd/nfs4xdr.o
$ ls -l fs/nfsd/nfs4xdr.o
-rw-rw-r-- 1 kees kees 276088 Feb 22 13:21 fs/nfsd/nfs4xdr.o

Am I missing something?

> The whole point of fixdep and the include/config hierarchy is to be able
> to remove the dependency on autoconf.h, but I'm not sure I understand
> why kconfig.h itself is also forcibly removed.

Is there a mode where we're now rebuilding too much?

-Kees

-- 
Kees Cook
Pixel Security

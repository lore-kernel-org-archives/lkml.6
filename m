Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbeBVVIf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 16:08:35 -0500
Received: from mail02.prevas.se ([62.95.78.10]:15849 "EHLO mail02.prevas.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751119AbeBVVIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 16:08:34 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GlAADvL49a/2h+ugUNUBoBAQEBAQIBA?=
 =?us-ascii?q?QEBCAEBAQGJNZlxCyeBFpZiggIKhTQCgwUVAQIBAQEBAQECA4Y1AQEBAyNWEAs?=
 =?us-ascii?q?YAgImAgJXBgEMCAEBtRJugieFAIN3ghcBAQEBAQEBAQIBAQEBASOBD4QKg36CE?=
 =?us-ascii?q?AyCeYULgy+CZQWSVpFpCYJOk0CCIIo/h2WYKoE8NYF1TXKCRIMIgW6NXwEBAQ?=
X-IPAS-Result: =?us-ascii?q?A2GlAADvL49a/2h+ugUNUBoBAQEBAQIBAQEBCAEBAQGJNZl?=
 =?us-ascii?q?xCyeBFpZiggIKhTQCgwUVAQIBAQEBAQECA4Y1AQEBAyNWEAsYAgImAgJXBgEMC?=
 =?us-ascii?q?AEBtRJugieFAIN3ghcBAQEBAQEBAQIBAQEBASOBD4QKg36CEAyCeYULgy+CZQW?=
 =?us-ascii?q?SVpFpCYJOk0CCIIo/h2WYKoE8NYF1TXKCRIMIgW6NXwEBAQ?=
X-IronPort-AV: E=Sophos;i="5.47,378,1515452400";
   d="scan'208";a="3113737"
Subject: Re: [PATCH v3] kconfig.h: Include compiler types to avoid missed
 struct attributes
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Cc: Patrick McLean <chutzpah@gentoo.org>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180222174140.GA3154@beast>
 <CA+55aFxDh-69p0Lr52icct6-3PGcsHaZmMqHwks8HptdmdxvTg@mail.gmail.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <66556bf7-3e67-5793-081e-76a01f598374@prevas.dk>
Date: Thu, 22 Feb 2018 22:07:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFxDh-69p0Lr52icct6-3PGcsHaZmMqHwks8HptdmdxvTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-22 19:04, Linus Torvalds wrote:
> 
> Lookie here (in a fully built tree):
> 
>     find . -name '*.o.cmd' |
>         xargs grep -L linux/compiler_types.h |
>         xargs grep -l linux/kconfig.h |
>         while read i; do
>             j=$(echo $i | sed 's/\.o.cmd$/\.c/' | sed 's:/\.:/:');
>             test -f $j && echo $j;
>         done
> 
> shows that a number of files don't end up depending on that header
> file, even though it's included (that "grep -l linux/kconfig,h"
> triggers on the command itself having that "-include linux/kconfig.h"
> line).
> 
> It looks like "gcc -M" just doesn't list any files that get included
> on the command line with "-include".

It does, both per the documentation and testing it. But fixdep
explicitly removes include/linux/kconfig.h along with
include/generated/autoconf.h and a few others. So when you rebuilt after
adding the #include to kconfig.h, I think nothing actually got built,
and no new .o.cmd files got generated.

Doing a clean build does make include/linux/compiler_{types,gcc}.h and
the various fake include/config/.... they "depend" on appear in e.g.
lib/.clz_tab.o.cmd.

The whole point of fixdep and the include/config hierarchy is to be able
to remove the dependency on autoconf.h, but I'm not sure I understand
why kconfig.h itself is also forcibly removed.

Rasmus

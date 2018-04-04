Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752215AbeDDQDp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 12:03:45 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:45441 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751503AbeDDQDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 12:03:42 -0400
X-Google-Smtp-Source: AIpwx4/uTlFqznWifTNqqIsFt12/yI+yKMOzIfEDV/hnNsK0A/3BNgzH6fZOWZ5tql2cYji8YQZNZ1pwEON7Au8xC4c=
MIME-Version: 1.0
In-Reply-To: <20180404.115215.419039708931754897.davem@davemloft.net>
References: <20180404121347.3089169-1-arnd@arndb.de> <20180404.115215.419039708931754897.davem@davemloft.net>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 4 Apr 2018 18:03:41 +0200
X-Google-Sender-Auth: bMC13N7Kr2Nxo1pvVmVqSP9INsw
Message-ID: <CAK8P3a0um2irY2P_3xffqRcmu5mJ+iA9iO4eW5381zBBmPRQfg@mail.gmail.com>
Subject: Re: [PATCH] netdevsim: remove incorrect __net_initdata annotations
To: David Miller <davem@davemloft.net>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>,
        David Ahern <dsa@cumulusnetworks.com>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 4, 2018 at 5:52 PM, David Miller <davem@davemloft.net> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Wed,  4 Apr 2018 14:12:39 +0200
>
>> The __net_initdata section cannot currently be used for structures that
>> get cleaned up in an exitcall using unregister_pernet_operations:
>>
>> WARNING: vmlinux.o(.text+0x868c34): Section mismatch in reference from the function nsim_devlink_exit() to the (unknown reference) .init.data:(unknown)
>> The function nsim_devlink_exit() references
>> the (unknown reference) __initdata (unknown).
>> This is often because nsim_devlink_exit lacks a __initdata
>> annotation or the annotation of (unknown) is wrong.
>> WARNING: vmlinux.o(.text+0x868c64): Section mismatch in reference from the function nsim_devlink_init() to the (unknown reference) .init.data:(unknown)
>> WARNING: vmlinux.o(.text+0x8692bc): Section mismatch in reference from the function nsim_fib_exit() to the (unknown reference) .init.data:(unknown)
>> WARNING: vmlinux.o(.text+0x869300): Section mismatch in reference from the function nsim_fib_init() to the (unknown reference) .init.data:(unknown)
>>
>> As that warning tells us, discarding the structure after a module is
>> loaded would lead to a undefined behavior when that module is removed.
>>
>> It might be possible to change that annotation so it has no effect for
>> loadable modules, but I have not figured out exactly how to do that, and
>> we want this to be fixed in -rc1.
>>
>> This just removes the annotations, just like we do for all other such
>> modules.
>>
>> Fixes: 37923ed6b8ce ("netdevsim: Add simple FIB resource controller via devlink")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Hmmm...
>
> __net_initdata defines to nothing if network namespaces are enabled.
>
> That's the whole point.
>
> Therefore, if NETNS is disabled, "unregister_pernet_operations" cannot
> happen and this is the only time when __net_initdata actually does
> something.

The problem happens with CONFIG_NETNS=n: __net_initdata turns into
__initdata, and nsim_fib_net_ops is referenced from a function that is
not marked __init (i.e. nsim_fib_exit).

The logic to turn __net_initdata into __init only makes sense for
subsystems that have no way to be unregistered, i.e. code which is
always built-in, or non-unloadable modules.

       Arnd

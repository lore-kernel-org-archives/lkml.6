Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752102AbeDDPwS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 11:52:18 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:40624 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751588AbeDDPwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 11:52:17 -0400
Date: Wed, 04 Apr 2018 11:52:15 -0400 (EDT)
Message-Id: <20180404.115215.419039708931754897.davem@davemloft.net>
To: arnd@arndb.de
Cc: jakub.kicinski@netronome.com, dsa@cumulusnetworks.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netdevsim: remove incorrect __net_initdata annotations
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180404121347.3089169-1-arnd@arndb.de>
References: <20180404121347.3089169-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed,  4 Apr 2018 14:12:39 +0200

> The __net_initdata section cannot currently be used for structures that
> get cleaned up in an exitcall using unregister_pernet_operations:
> 
> WARNING: vmlinux.o(.text+0x868c34): Section mismatch in reference from the function nsim_devlink_exit() to the (unknown reference) .init.data:(unknown)
> The function nsim_devlink_exit() references
> the (unknown reference) __initdata (unknown).
> This is often because nsim_devlink_exit lacks a __initdata
> annotation or the annotation of (unknown) is wrong.
> WARNING: vmlinux.o(.text+0x868c64): Section mismatch in reference from the function nsim_devlink_init() to the (unknown reference) .init.data:(unknown)
> WARNING: vmlinux.o(.text+0x8692bc): Section mismatch in reference from the function nsim_fib_exit() to the (unknown reference) .init.data:(unknown)
> WARNING: vmlinux.o(.text+0x869300): Section mismatch in reference from the function nsim_fib_init() to the (unknown reference) .init.data:(unknown)
> 
> As that warning tells us, discarding the structure after a module is
> loaded would lead to a undefined behavior when that module is removed.
> 
> It might be possible to change that annotation so it has no effect for
> loadable modules, but I have not figured out exactly how to do that, and
> we want this to be fixed in -rc1.
> 
> This just removes the annotations, just like we do for all other such
> modules.
> 
> Fixes: 37923ed6b8ce ("netdevsim: Add simple FIB resource controller via devlink")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Hmmm...

__net_initdata defines to nothing if network namespaces are enabled.

That's the whole point.

Therefore, if NETNS is disabled, "unregister_pernet_operations" cannot
happen and this is the only time when __net_initdata actually does
something.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752492AbeCPSa0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 14:30:26 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:35684 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750876AbeCPSaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 14:30:25 -0400
Date: Fri, 16 Mar 2018 14:30:21 -0400 (EDT)
Message-Id: <20180316.143021.1158193720540239477.davem@davemloft.net>
To: linux@dominikbrodowski.net
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH -next 00/22] remove in-kernel syscall invocations (part
 2 == netdev)
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180316170614.5392-1-linux@dominikbrodowski.net>
References: <20180316170614.5392-1-linux@dominikbrodowski.net>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominik Brodowski <linux@dominikbrodowski.net>
Date: Fri, 16 Mar 2018 18:05:52 +0100

> The rationale of this change is described in patch 1 of part 1[*] as follows:
> 
> 	The syscall entry points to the kernel defined by SYSCALL_DEFINEx()
> 	and COMPAT_SYSCALL_DEFINEx() should only be called from userspace
> 	through kernel entry points, but not from the kernel itself. This
> 	will allow cleanups and optimizations to the entry paths *and* to
> 	the parts of the kernel code which currently need to pretend to be
> 	userspace in order to make use of syscalls.
> 
> At present, these patches are based on v4.16-rc5; there is one trivial
> conflict against net-next. Dave, I presume that you prefer to take them
> through net-next? If you want to, I can re-base them against net-next.
> If you prefer otherwise, though, I can route them as part of my whole
> syscall series.

So the transformations themeselves are relatively trivial, so on that
aspect I don't have any problems with these changes.

But overall I have to wonder.

I imagine one of the things you'd like to do is declare that syscall
entries use a different (better) argument passing scheme.  For
example, passing values in registers instead of on the stack.

But in situations where you split out the system call function
completely into one of these "helpers", the compiler is going
to have two choices:

1) Expand the helper into the syscall function inline, thus we end up
   with two copies of the function.

2) Call the helper from the syscall function.  Well, then the compiler
   will need to pop the syscal obtained arguments from the registers
   onto the stack.

So this doesn't seem like such a total win to me.

Maybe you can explain things better to ease my concerns.

About merging, I'm fine with you taking this via your tree.  I do not
see there being any terribly difficult conflicts arising (famous
last words).

Thanks.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbeCORG1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 13:06:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751829AbeCORGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 13:06:15 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 649E620855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 15 Mar 2018 13:06:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v3] vsprintf: Prevent crash when dereferencing invalid
 pointers
Message-ID: <20180315130612.4b4cd091@vmware.local.home>
In-Reply-To: <0c52c2f1-60d8-bb8a-80f2-c699d47659d3@rasmusvillemoes.dk>
References: <CAKwiHFgTbFof34oc59OU3M1=-PTzstv0uxSmoiRc8TJPJPMHVw@mail.gmail.com>
        <20180306092513.ibodfsnv4xrxdlub@pathway.suse.cz>
        <1520330185.10722.401.camel@linux.intel.com>
        <20180307155244.b45c3fb5vcxb4q2l@pathway.suse.cz>
        <CA+55aFxr5eg_fWjyhcYFU4CSOoVP_GeB79cYa=8mUk7J1cUG7A@mail.gmail.com>
        <20180308141824.bfk2pr6wmjh4ytdi@pathway.suse.cz>
        <CA+55aFyDbr4JpiPoHXq=3wJu+WVCLZPpAVsmY=5HVStawmEiRw@mail.gmail.com>
        <CA+55aFwaNTC2HV9ERDFWCrmhvgZ58SKMM+ik9Ypr3i-ZUyU6Fw@mail.gmail.com>
        <20180309150153.3sxbbpd6jdn2d5yy@pathway.suse.cz>
        <CA+55aFwT-Vd+sVdAVemUjUvkNYFiLyVMHZxv9hF6KzRM7i4Yrg@mail.gmail.com>
        <20180314140947.rs3b6i5gguzzu5wi@pathway.suse.cz>
        <0c52c2f1-60d8-bb8a-80f2-c699d47659d3@rasmusvillemoes.dk>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Mar 2018 23:12:36 +0100
Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> Question: probe_kernel_read seems to allow (mapped) userspace addresses.
> Is that really what we want? Sure, some %p* just format the pointed-to
> bytes directly (as an IP address or raw hex dump or whatnot), but some
> (e.g. %pD, and %pV could be particularly fun) do another dereference.
> I'm not saying it would be easy for an attacker to get a userpointer
> passed to %pV, but there's a lot of places that end up calling vsnprintf
> (not just printk and friends). Isn't there some cheap address comparison
> one can do to rule that out completely?

We allow it today right? Why should we stop it now. For debugging I
will sometimes add printk()s to write out content in userspace. Since
the kernel maps all memory in its own space, there's nothing we are
protecting by not letting the kernel read userspace but be OK letting
it read anything in kernel space.

-- Steve

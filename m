Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeCPOcM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 10:32:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750748AbeCPOcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 10:32:10 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F1E72177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 16 Mar 2018 10:32:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH v3] vsprintf: Prevent crash when dereferencing invalid
 pointers
Message-ID: <20180316103207.47d3ece7@gandalf.local.home>
In-Reply-To: <20180316085556.t3j65zyuyjzro3n3@pathway.suse.cz>
References: <CA+55aFwaNTC2HV9ERDFWCrmhvgZ58SKMM+ik9Ypr3i-ZUyU6Fw@mail.gmail.com>
        <20180309150153.3sxbbpd6jdn2d5yy@pathway.suse.cz>
        <CA+55aFwT-Vd+sVdAVemUjUvkNYFiLyVMHZxv9hF6KzRM7i4Yrg@mail.gmail.com>
        <20180314140947.rs3b6i5gguzzu5wi@pathway.suse.cz>
        <20180315075842.GD3628@jagdpanzerIV>
        <20180315080309.GF3628@jagdpanzerIV>
        <20180315130117.7c2fb761@vmware.local.home>
        <20180316011852.GA5139@jagdpanzerIV>
        <CA+55aFzLQvPCB-A2ZN9h86pBDbNC1RXwzB=URRKFcJpXFzanig@mail.gmail.com>
        <20180316055346.GB5139@jagdpanzerIV>
        <20180316085556.t3j65zyuyjzro3n3@pathway.suse.cz>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Mar 2018 09:55:56 +0100
Petr Mladek <pmladek@suse.com> wrote:

> I am not sure if it is worth it. I think that we would catch 99% of
> problems by checking the first byte.

Then it should be commented as such. Something like:

 /*
  * This is not a fool-proof test. 99.9% of the time that this will
  * fault is due to a bad pointer, not one that crosses into bad memory.
  * Just test the address to make sure it doesn't fault due to a poorly
  * added printk during debugging.
  */

> 
> This patch was motivated by a code clean up rather than bug reports.
> The original patch removed two more strict checks and kept only
> the check for pure NULL. I suggested that it was the wrong way to
> go...
> 
> I do not want to go suddenly to the other extreme. I suggest to start
> with simple check for the first byte and see how often it helps
> in the real life. We could always extend it later.

Fair enough. If this is just code clean up, then sure, we don't need to
cover all cases. But it should definitely be commented about why this
is added, and if in the future we really do want this to be more
robust, then we can extend it.

-- Steve

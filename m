Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752487AbeFAPJi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:09:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751422AbeFAPJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:09:34 -0400
X-Google-Smtp-Source: ADUXVKJhphRX6/4NFwpmSIvnBdcYhDNUBSI3MuaiQzZpFSLU9K1aQChvUvsV6loDMYUcxX3VOrom7+qJCqJ1i3E4hkk=
MIME-Version: 1.0
References: <1527857873.4674.11.camel@gmx.de> <20180601132055.GT12198@hirez.programming.kicks-ass.net>
In-Reply-To: <20180601132055.GT12198@hirez.programming.kicks-ass.net>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 1 Jun 2018 08:09:20 -0700
X-Gmail-Original-Message-ID: <CALCETrV-NFtUT8cyqxHKxyeKOpp95p80U1vMxPD-wj6vPDAeqg@mail.gmail.com>
Message-ID: <CALCETrV-NFtUT8cyqxHKxyeKOpp95p80U1vMxPD-wj6vPDAeqg@mail.gmail.com>
Subject: Re: 4.13..4.14 scheduling overhead regression (bisected - b956575bed91)
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mike Galbraith <efault@gmx.de>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 1, 2018 at 6:21 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jun 01, 2018 at 02:57:53PM +0200, Mike Galbraith wrote:
> > b956575bed91ecfb136a8300742ecbbf451471ab is the first bad commit
> > commit b956575bed91ecfb136a8300742ecbbf451471ab
> > Author: Andy Lutomirski <luto@kernel.org>
> > Date:   Mon Oct 9 09:50:49 2017 -0700
> >
> >     x86/mm: Flush more aggressively in lazy TLB mode
>
> Oh boy... Maybe we should start looking at that optimization Andy
> mentioned.

Jolly.

>
> IIRC all page freeing does indeed go through tlb_remove_page(), it
> shouldn't be too hard to make that work.

Before we go too far down this rabbit hole, let's figure out what's
actually going on.  Mike, does your system have PCID?  If it does,
then my proposed optimization wouldn't do anything.

Can you try inverting the return value of
tlb_defer_switch_to_init_mm() and seeing if the result changes?

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752864AbeDRSRi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 14:17:38 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:46160 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752705AbeDRSRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 14:17:34 -0400
Date: Wed, 18 Apr 2018 19:17:23 +0100
From: Russell King <rmk@armlinux.org.uk>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: linux-next: build failure after merge of the arm-current tree
Message-ID: <20180418181722.GA7852@flint.armlinux.org.uk>
References: <20180418133155.0931baf7@canb.auug.org.au>
 <20180418175442.GA7234@flint.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418175442.GA7234@flint.armlinux.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 06:54:42PM +0100, Russell King wrote:
> On Wed, Apr 18, 2018 at 01:31:55PM +1000, Stephen Rothwell wrote:
> > Hi Russell,
> > 
> > After merging the arm-current tree, today's linux-next build
> > (lots of configs) failed like this:
> > 
> > /bin/sh: 1: arithmetic expression: expecting primary: " "
> > (lots of these)
> > 
> > Caused by commit
> > 
> >   fe680ca02c1e ("ARM: replace unnecessary perl with sed and the shell $(( )) operator")
> > 
> > (pointed out by Michael Ellerman)
> > 
> > Our /bin/sh is dash not bash ...
> 
> I tested this on 32-bit ARM with dash:
> 
> foo# dash
> # echo $(($(nm /boot/vmlinux-4.16.0+ | sed -n -e 's/^\([^ ]*\) B __bss_start$/-0x\1/p' -e 's/^\([^ ]*\) B __bss_stop$/+0x\1/p') ))
> 6409680
> #
> 
> Any clues what '/bin/sh: 1: arithmetic expression: expecting primary: " "'
> actually means in reality?
> 
> I don't see why you should end up with lots of them either, unless maybe
> the sed expression isn't working for you.
> 
> The sed expression should end up producing output such as:
> 
> -0xc09138c4
> +0xc0f30694
> 
> and that's it, two values, one preceded by a + and the other by a -.

Hmm, I guess it's a result of:

# echo $(( ))
dash: 4: arithmetic expression: expecting primary: " "

which points to the sed expression producing no output.  If that's the
case, then something else went wrong with the build earlier - there
should be no case where the built vmlinux does not contain the
__bss_start and __bss_stop symbols on ARM, since every kernel contains
a .bss section.

Olof's autobuilder shows no errors, but that could be because it's
using bash - I don't know.  kernelci.org also shows no failures.

I think more information is needed to debug this, such as:

- does nm of the vmlinux contain the __bss_start and __bss_stop
  symbols, and are they formatted as one would expect (iow, marked
  as a global BSS symbol?)
- does the nm | sed pipeline produce the expected output when run
  outside of everything else?
- does dash evaluate the output correctly outside of the makefile?

As I'm not currently aware of a failing environment that I have
access to, I'm not able to debug this myself, sorry.

-- 
Russell King
ARM architecture Linux Kernel maintainer

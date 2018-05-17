Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752204AbeEQNQo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 09:16:44 -0400
Received: from gate.crashing.org ([63.228.1.57]:33667 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751976AbeEQNQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 09:16:42 -0400
Date: Thu, 17 May 2018 08:15:50 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] powerpc/32be: use stmw/lmw for registers save/restore in asm
Message-ID: <20180517131550.GR17342@gate.crashing.org>
References: <7fbae252f24ec4d30f52f57a549901fa3f799f8f.1523984745.git.christophe.leroy@c-s.fr> <a94e38e1dbe0c38ce5b363fac29ab6e65fd9985a.1523984745.git.christophe.leroy@c-s.fr> <87zi0ymqj6.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zi0ymqj6.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 10:10:21PM +1000, Michael Ellerman wrote:
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> > arch/powerpc/Makefile activates -mmultiple on BE PPC32 configs
> > in order to use multiple word instructions in functions entry/exit
> 
> True, though that could be a lot simpler because the MULTIPLEWORD value
> is only used for PPC32, which is always big endian. I'll send a patch
> for that.

Do you mean in the kernel?  Many 32-bit processors can do LE, and many
do not implement multiple or string insns in LE mode.

> > The patch does the same for the asm parts, for consistency
> >
> > On processors like the 8xx on which insn fetching is pretty slow,
> > this speeds up registers save/restore
> 
> OK. I've always heard that they should be avoided, but that's coming
> from 64-bit land.
> 
> I guess we've been enabling this for all 32-bit targets for ever so it
> must be a reasonable option.

On 603, load multiple (and string) are one cycle slower than doing all the
loads separately, and store is essentially the same as separate stores.
On 7xx and 7xxx both loads and stores are one cycle slower as multiple
than as separate insns.

load/store multiple are nice for saving/storing registers.


Segher

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755172AbeDZIzt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 04:55:49 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:46268 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754813AbeDZIzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 04:55:46 -0400
Date: Thu, 26 Apr 2018 10:55:40 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Shakeel Butt <shakeelb@google.com>
cc: Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        stable@kernel.org, linuxram@us.ibm.com,
        Dave Hansen <dave.hansen@intel.com>, mpe@ellerman.id.au,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, shuah@kernel.org
Subject: Re: [PATCH 4/9] x86, pkeys: override pkey when moving away from
 PROT_EXEC
In-Reply-To: <CALvZod5NTauM6MHW7D=h0mTDNYFd-1QyWrOxnhiixCgtHP=Taw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1804261054540.1584@nanos.tec.linutronix.de>
References: <20180326172721.D5B2CBB4@viggo.jf.intel.com> <20180326172727.025EBF16@viggo.jf.intel.com> <CALvZod5NTauM6MHW7D=h0mTDNYFd-1QyWrOxnhiixCgtHP=Taw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2018, Shakeel Butt wrote:
> On Mon, Mar 26, 2018 at 5:27 PM, Dave Hansen
> <dave.hansen@linux.intel.com> wrote:
> >
> > From: Dave Hansen <dave.hansen@linux.intel.com>
> >
> > I got a bug report that the following code (roughly) was
> > causing a SIGSEGV:
> >
> >         mprotect(ptr, size, PROT_EXEC);
> >         mprotect(ptr, size, PROT_NONE);
> >         mprotect(ptr, size, PROT_READ);
> >         *ptr = 100;
> >
> > The problem is hit when the mprotect(PROT_EXEC)
> > is implicitly assigned a protection key to the VMA, and made
> > that key ACCESS_DENY|WRITE_DENY.  The PROT_NONE mprotect()
> > failed to remove the protection key, and the PROT_NONE->
> > PROT_READ left the PTE usable, but the pkey still in place
> > and left the memory inaccessible.
> >
> > To fix this, we ensure that we always "override" the pkee
> > at mprotect() if the VMA does not have execute-only
> > permissions, but the VMA has the execute-only pkey.
> >
> > We had a check for PROT_READ/WRITE, but it did not work
> > for PROT_NONE.  This entirely removes the PROT_* checks,
> > which ensures that PROT_NONE now works.
> >
> > Reported-by: Shakeel Butt <shakeelb@google.com>
> >
> > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Fixes: 62b5f7d013f ("mm/core, x86/mm/pkeys: Add execute-only protection keys support")
> 
> Hi Dave, are you planning to send the next version of this patch or
> going with this one?

Right, some enlightment would be appreciated. I'm lost in the dozen
different threads discussing this back and forth.

Thanks,

	tglx

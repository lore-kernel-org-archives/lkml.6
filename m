Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753528AbeCRJa7 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 05:30:59 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58308 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbeCRJa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 05:30:58 -0400
Date: Sun, 18 Mar 2018 10:30:48 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ram Pai <linuxram@us.ibm.com>
cc: Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dave.hansen@intel.com, mpe@ellerman.id.au, mingo@kernel.org,
        akpm@linux-foundation.org, shuah@kernel.org
Subject: Re: [PATCH 1/3] x86, pkeys: do not special case protection key 0
In-Reply-To: <20180317232425.GH1060@ram.oc3035372033.ibm.com>
Message-ID: <alpine.DEB.2.21.1803181029220.1509@nanos.tec.linutronix.de>
References: <20180316214654.895E24EC@viggo.jf.intel.com> <20180316214656.0E059008@viggo.jf.intel.com> <20180317232425.GH1060@ram.oc3035372033.ibm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Mar 2018, Ram Pai wrote:
> On Fri, Mar 16, 2018 at 02:46:56PM -0700, Dave Hansen wrote:
> > 
> > From: Dave Hansen <dave.hansen@linux.intel.com>
> > 
> > mm_pkey_is_allocated() treats pkey 0 as unallocated.  That is
> > inconsistent with the manpages, and also inconsistent with
> > mm->context.pkey_allocation_map.  Stop special casing it and only
> > disallow values that are actually bad (< 0).
> > 
> > The end-user visible effect of this is that you can now use
> > mprotect_pkey() to set pkey=0.
> > 
> > This is a bit nicer than what Ram proposed because it is simpler
> > and removes special-casing for pkey 0.  On the other hand, it does
> > allow applciations to pkey_free() pkey-0, but that's just a silly
> > thing to do, so we are not going to protect against it.
> 
> So your proposal 
> (a) allocates pkey 0 implicitly, 
> (b) does not stop anyone from freeing pkey-0
> (c) and allows pkey-0 to be explicitly associated with any address range.
> correct?
> 
> My proposal
> (a) allocates pkey 0 implicitly, 
> (b) stops anyone from freeing pkey-0
> (c) and allows pkey-0 to be explicitly associated with any address range.
> 
> So the difference between the two proposals is just the freeing part i.e (b).
> Did I get this right?

Yes, and that's consistent with the other pkeys.

> Its a philosophical debate; allow the user to shoot-in-the-feet or stop
> from not doing so. There is no clear answer either way. I am fine either
> way.

The user can shoot himself already with the other pkeys, so adding another
one does not matter and is again consistent.

Thanks,

	tglx

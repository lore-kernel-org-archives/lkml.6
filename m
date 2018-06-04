Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751765AbeFDWOw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 18:14:52 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40876 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751697AbeFDWOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 18:14:50 -0400
X-Google-Smtp-Source: ADUXVKIl6fYW61og3lBEstXLtdm+J2he8OI2YP+fn1f23z8S4v8wzjVb7sKIty6ihOGtqXiP1U9PEQ==
Date: Mon, 4 Jun 2018 15:14:46 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] bitmap: Add bitmap_alloc(), bitmap_zalloc() and
 bitmap_free()
Message-ID: <20180604221446.GI164893@dtor-ws>
References: <20180601083120.40352-1-andriy.shevchenko@linux.intel.com>
 <20180601183343.GA222005@dtor-ws>
 <cfe3fa909edd73ba84dd367a11a570866647a3f4.camel@linux.intel.com>
 <20180604215723.GH164893@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180604215723.GH164893@dtor-ws>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 02:57:23PM -0700, Dmitry Torokhov wrote:
> On Mon, Jun 04, 2018 at 12:59:54PM +0300, Andy Shevchenko wrote:
> > On Fri, 2018-06-01 at 11:33 -0700, Dmitry Torokhov wrote:
> > > Hi Andy,
> > > 
> > > On Fri, Jun 01, 2018 at 11:31:18AM +0300, Andy Shevchenko wrote:
> > > > A lot of code become ugly because of open coding allocations for
> > > > bitmaps.
> > > > 
> > > > Introduce three helpers to allow users be more clear of intention
> > > > and keep their code neat.
> > > > 
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > 
> > > This looks nice and I like how it simplifies drivers.
> > 
> > Thanks!
> > 
> > >  How do we merge
> > > this? 
> > 
> > I suppose through 'input' tree if there is no objections.
> 
> OK, let's wait for objections for a few days.
> 
> > 
> > > > ---
> > > >  include/linux/bitmap.h | 16 ++++++++++++++++
> > > >  1 file changed, 16 insertions(+)
> > > > 
> > > > diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> > > > index 1ee46f492267..845822425393 100644
> > > > --- a/include/linux/bitmap.h
> > > > +++ b/include/linux/bitmap.h
> > > > @@ -6,6 +6,7 @@
> > > >  
> > > >  #include <linux/types.h>
> > > >  #include <linux/bitops.h>
> > > > +#include <linux/slab.h>
> > > >  #include <linux/string.h>
> > > >  #include <linux/kernel.h>
> > > >  
> > > > @@ -104,6 +105,21 @@
> > > >   * contain all bit positions from 0 to 'bits' - 1.
> > > >   */
> > > >  
> > > > +static inline unsigned long *bitmap_alloc(unsigned int nbits, gfp_t
> > > > flags)
> > > > +{
> > > > +	return kmalloc_array(BITS_TO_LONGS(nbits), sizeof(unsigned
> > > > long), flags);
> > > > +}
> > > > +
> > > > +static inline unsigned long *bitmap_zalloc(unsigned int nbits,
> > > > gfp_t flags)
> > > > +{
> > > > +	return kcalloc(BITS_TO_LONGS(nbits), sizeof(unsigned long),
> > > > flags);
> > > 
> > > 	retrun bitmap_alloc(nbits, flags | __GFP_ZERO);
> > > 
> > > ?
> > 
> > I though about this, but decide not to rely on linux/gfp.h.
> > If you think explicit __GFP_ZERO is better, I can replace in v2, or if
> 
> I like it ;) and we already do it for kcalloc done via kmalloc_array
> with __GFP_ZERO or kzalloc (kmalloc with __GFP_ZERO).
> 
> > you have a chance to do that when applying it would be appreciated.
> 
> Yeah, I can do that, no problem.

Ugh, there is circular dependency:

  CC      arch/x86/kernel/asm-offsets.s
In file included from ./include/linux/cpumask.h:12:0,
                 from ./arch/x86/include/asm/cpumask.h:5,
                 from ./arch/x86/include/asm/msr.h:11,
                 from ./arch/x86/include/asm/processor.h:21,
                 from ./arch/x86/include/asm/cpufeature.h:5,
                 from ./arch/x86/include/asm/thread_info.h:53,
                 from ./include/linux/thread_info.h:38,
                 from ./arch/x86/include/asm/preempt.h:7,
                 from ./include/linux/preempt.h:81,
                 from ./include/linux/spinlock.h:51,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:6,
                 from ./include/linux/slab.h:15,
                 from ./include/linux/crypto.h:24,
                 from arch/x86/kernel/asm-offsets.c:9:
./include/linux/bitmap.h: In function ‘bitmap_alloc’:
./include/linux/bitmap.h:110:9: error: implicit declaration of function ‘kmalloc_array’ [-Werror=implicit-function-declaration]
  return kmalloc_array(BITS_TO_LONGS(nbits), sizeof(unsigned long), flags);
         ^~~~~~~~~~~~~
./include/linux/bitmap.h:110:9: warning: return makes pointer from integer without a cast [-Wint-conversion]
  return kmalloc_array(BITS_TO_LONGS(nbits), sizeof(unsigned long), flags);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

So we have slab.h ... -> cpumask.h -> bitmap.h -> slab.h -> BOOM

We will probably have to move implementation into lib/bitmap.h. I think
that should be OK. Can you make the change?

Thanks.

-- 
Dmitry

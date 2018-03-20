Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeCTDNF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 23:13:05 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33818 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750968AbeCTDNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 23:13:02 -0400
X-Google-Smtp-Source: AG47ELsgtJtB8xLyT8uL680RcvXMmrWYe+Tf0kGtTMOrOORUf0pW0awyfmCLnEbj/DscLYtVJRAVQg==
Date: Tue, 20 Mar 2018 12:12:55 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>, herbert@gondor.apana.org.au,
        ard.biesheuvel@linaro.org, catalin.marinas@arm.com,
        julien.thierry@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        dhowells@redhat.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, mpe@ellerman.id.au,
        bauerman@linux.vnet.ibm.com, akpm@linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>, davem@davemloft.net,
        vgoyal@redhat.com
Subject: Re: [PATCH v8 01/13] resource: add walk_system_ram_res_rev()
Message-ID: <20180320031253.bwxat2dr3sns5uj4@dragonfly>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        herbert@gondor.apana.org.au, ard.biesheuvel@linaro.org,
        catalin.marinas@arm.com, julien.thierry@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, dhowells@redhat.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, mpe@ellerman.id.au,
        bauerman@linux.vnet.ibm.com, akpm@linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>, davem@davemloft.net,
        vgoyal@redhat.com
References: <20180222111732.23051-1-takahiro.akashi@linaro.org>
 <20180222111732.23051-2-takahiro.akashi@linaro.org>
 <20180223083619.GA4433@dhcp-128-65.nay.redhat.com>
 <20180320014318.GA2514@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320014318.GA2514@localhost.localdomain>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baoquan,

On Tue, Mar 20, 2018 at 09:43:18AM +0800, Baoquan He wrote:
> On 02/23/18 at 04:36pm, Dave Young wrote:
> > Hi AKASHI,
> > 
> > On 02/22/18 at 08:17pm, AKASHI Takahiro wrote:
> > > This function, being a variant of walk_system_ram_res() introduced in
> > > commit 8c86e70acead ("resource: provide new functions to walk through
> > > resources"), walks through a list of all the resources of System RAM
> > > in reversed order, i.e., from higher to lower.
> > > 
> > > It will be used in kexec_file implementation on arm64.
> > 
> > I remember there was an old discussion about this, it should be added
> > in patch log why this is needed.
> 
> It's used to load kernel/initrd at the top of system RAM, and this is
> consistent with user space kexec behaviour.
> 
> In x86 64, Vivek didn't do like this since there's no reverse iomem
> resource iterating function, he just chose a match RAM region bottom up,
> then put kernel/initrd top down in the found RAM region. This is
> different than kexec_tools utility. I am considering to change resource
> sibling as double list, seems AKASHI's way is easier to be accepted by
> people. So I will use this one to change x86 64 code.
> 
> Hi AKASHI,
> 
> About arm64 kexec_file patches, will you post recently? Or any other
> plan?

A short answer is yes, but my new version won't include this specific patch.
So please feel free to add it to your own patch set if you want.

The reason that I'm going to remove it is that we will make a modification
on /proc/iomem due to a bug fixing and then we will have to have our own 
"walking" routine.

Thanks,
-Takahiro AKASHI

> Thanks
> Baoquan
> 
> > 
> > > 
> > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > Cc: Vivek Goyal <vgoyal@redhat.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > > ---
> > >  include/linux/ioport.h |  3 +++
> > >  kernel/resource.c      | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 60 insertions(+)
> > > 
> > > diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> > > index da0ebaec25f0..f12d95fe038b 100644
> > > --- a/include/linux/ioport.h
> > > +++ b/include/linux/ioport.h
> > > @@ -277,6 +277,9 @@ extern int
> > >  walk_system_ram_res(u64 start, u64 end, void *arg,
> > >  		    int (*func)(struct resource *, void *));
> > >  extern int
> > > +walk_system_ram_res_rev(u64 start, u64 end, void *arg,
> > > +			int (*func)(struct resource *, void *));
> > > +extern int
> > >  walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
> > >  		    void *arg, int (*func)(struct resource *, void *));
> > >  
> > > diff --git a/kernel/resource.c b/kernel/resource.c
> > > index e270b5048988..bdaa93407f4c 100644
> > > --- a/kernel/resource.c
> > > +++ b/kernel/resource.c
> > > @@ -23,6 +23,8 @@
> > >  #include <linux/pfn.h>
> > >  #include <linux/mm.h>
> > >  #include <linux/resource_ext.h>
> > > +#include <linux/string.h>
> > > +#include <linux/vmalloc.h>
> > >  #include <asm/io.h>
> > >  
> > >  
> > > @@ -486,6 +488,61 @@ int walk_mem_res(u64 start, u64 end, void *arg,
> > >  				     arg, func);
> > >  }
> > >  
> > > +int walk_system_ram_res_rev(u64 start, u64 end, void *arg,
> > > +				int (*func)(struct resource *, void *))
> > > +{
> > > +	struct resource res, *rams;
> > > +	int rams_size = 16, i;
> > > +	int ret = -1;
> > > +
> > > +	/* create a list */
> > > +	rams = vmalloc(sizeof(struct resource) * rams_size);
> > > +	if (!rams)
> > > +		return ret;
> > > +
> > > +	res.start = start;
> > > +	res.end = end;
> > > +	res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> > > +	i = 0;
> > > +	while ((res.start < res.end) &&
> > > +		(!find_next_iomem_res(&res, IORES_DESC_NONE, true))) {
> > > +		if (i >= rams_size) {
> > > +			/* re-alloc */
> > > +			struct resource *rams_new;
> > > +			int rams_new_size;
> > > +
> > > +			rams_new_size = rams_size + 16;
> > > +			rams_new = vmalloc(sizeof(struct resource)
> > > +							* rams_new_size);
> > > +			if (!rams_new)
> > > +				goto out;
> > > +
> > > +			memcpy(rams_new, rams,
> > > +					sizeof(struct resource) * rams_size);
> > > +			vfree(rams);
> > > +			rams = rams_new;
> > > +			rams_size = rams_new_size;
> > > +		}
> > > +
> > > +		rams[i].start = res.start;
> > > +		rams[i++].end = res.end;
> > > +
> > > +		res.start = res.end + 1;
> > > +		res.end = end;
> > > +	}
> > > +
> > > +	/* go reverse */
> > > +	for (i--; i >= 0; i--) {
> > > +		ret = (*func)(&rams[i], arg);
> > > +		if (ret)
> > > +			break;
> > > +	}
> > > +
> > > +out:
> > > +	vfree(rams);
> > > +	return ret;
> > > +}
> > > +
> > >  #if !defined(CONFIG_ARCH_HAS_WALK_MEMORY)
> > >  
> > >  /*
> > > -- 
> > > 2.16.2
> > > 
> > 
> > Thanks
> > Dave
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec

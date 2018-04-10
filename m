Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752491AbeDJH57 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 03:57:59 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:53895 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752369AbeDJH55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 03:57:57 -0400
X-Originating-IP: 2.224.242.101
Date: Tue, 10 Apr 2018 09:57:52 +0200
From: jacopo mondi <jacopo@jmondi.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        laurent.pinchart@ideasonboard.com, robin.murphy@arm.com,
        dalias@libc.org, ysato@users.sourceforge.jp, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH] base: dma-mapping: Postpone cpu addr translation on
 mmap()
Message-ID: <20180410075752.GB20945@w540>
References: <1523293148-18726-1-git-send-email-jacopo+renesas@jmondi.org>
 <20180409175251.GA5426@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="n5G3y24fV3/VEqbx"
Content-Disposition: inline
In-Reply-To: <20180409175251.GA5426@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n5G3y24fV3/VEqbx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Christoph,

On Mon, Apr 09, 2018 at 10:52:51AM -0700, Christoph Hellwig wrote:
> On Mon, Apr 09, 2018 at 06:59:08PM +0200, Jacopo Mondi wrote:
> > I'm still a bit puzzled on what happens if dma_mmap_from_dev_coherent() fails.
> > Does a dma_mmap_from_dev_coherent() failure guarantee anyhow that the
> > successive virt_to_page() isn't problematic as it is today?
> > Or is it the
> >  	if (off < count && user_count <= (count - off))
> > check that makes the translation safe?
>
> It doesn't.  I think one major issue is that we should not simply fall
> to dma_common_mmap if no method is required, but need every instance of
> dma_map_ops to explicitly opt into an mmap method that is known to work.

I see.. this patch thus just postpones the problem...

>
> >  #ifndef CONFIG_ARCH_NO_COHERENT_DMA_MMAP
> >  	unsigned long user_count = vma_pages(vma);
> >  	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> > -	unsigned long pfn = page_to_pfn(virt_to_page(cpu_addr));
> >  	unsigned long off = vma->vm_pgoff;
> > +	unsigned long pfn;
> >
> >  	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> >
> > @@ -235,6 +235,7 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
> >  		return ret;
> >
> >  	if (off < count && user_count <= (count - off)) {
> > +		pfn = page_to_pfn(virt_to_page(cpu_addr));
> >  		ret = remap_pfn_range(vma, vma->vm_start,
> >  				      pfn + off,
> >  				      user_count << PAGE_SHIFT,
>
> Why not:
>
> 		ret = remap_pfn_range(vma, vma->vm_start,
> 				page_to_pfn(virt_to_page(cpu_addr)) + off,
>
> and save the temp variable?

Sure, it's better... Should I send a v2 or considering your above
comment this patch is just a mitigation and should be ditched in
favour of a proper solution (which requires a much more considerable amount
of work though)?

Thanks
   j

--n5G3y24fV3/VEqbx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJazG6AAAoJEHI0Bo8WoVY86H0P/2SMs4laMyttAVmvylDfTO4w
p8rssvBm/Qt20vZDkznGlLX2++8JAY4AMtdwjEvx+RrJHzvvjoziIYEIguZFv1IA
8sM/N2i7+4KpHeJsUJtQ0ckcxbxyGXZsz2BOMsUFtmsa0lo0U0B1W9mCfpxaj5sn
MApicnmKxUBlfbbFzgoug4+l2bdOWkWtO1Es6t9Ky08kUySfcHq38InjrnyOGC3V
ERjohSe5N8+FMzySnnpDQ2tqkCJ03vOrQa4WG301fsLADrkWzQ6qmItfyfIe3k2X
8A8VScaqG1u2p4yNUoJfmfKvGWkEmiiz6rqyesOVQHkCmmrDNyT+lpZsejpWg/qQ
HhG7f8q72CxMY4vsj8j2o5fSc9LNplVabEAGCOBDvU+S4SQcWTapnMhGv1hEXNzW
P3eMzDTcLQwmRoOHd1ZLkRKVtpWanH5UZQYsnLIg2dtz3j2x5JGE9N7W7CeMWsyn
9nGmY47qBvnNszGNY5R/wBTzaiPzbsFM0uKfW9eeedxHwb3yR1S+f7qeBKHm/H7u
rpUPOYU6GaJyxfjUUE+t+dFJYKrUf3VTxMCbViEAZBu5HgG9LiveADvSLyNPxJec
tMkTMv2Tplq9GxiFDNB+nZGlr7DwMpoWc/5qZg+v0TshwdtLony7cdtD0Us+Gg9t
oe7/84v/+s4N7PLfgU6I
=BwgV
-----END PGP SIGNATURE-----

--n5G3y24fV3/VEqbx--

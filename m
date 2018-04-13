Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752245AbeDMQaR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 12:30:17 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:53265 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbeDMQaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 12:30:15 -0400
X-Originating-IP: 2.224.242.101
Date: Fri, 13 Apr 2018 18:30:09 +0200
From: jacopo mondi <jacopo@jmondi.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        laurent.pinchart@ideasonboard.com, robin.murphy@arm.com,
        dalias@libc.org, ysato@users.sourceforge.jp, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH] base: dma-mapping: Postpone cpu addr translation on
 mmap()
Message-ID: <20180413163009.GE6666@w540>
References: <1523293148-18726-1-git-send-email-jacopo+renesas@jmondi.org>
 <20180409175251.GA5426@infradead.org>
 <20180410075752.GB20945@w540>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZRyEpB+iJ+qUx0kp"
Content-Disposition: inline
In-Reply-To: <20180410075752.GB20945@w540>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZRyEpB+iJ+qUx0kp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello again,

On Tue, Apr 10, 2018 at 09:57:52AM +0200, jacopo mondi wrote:
> Hi Christoph,
>
> On Mon, Apr 09, 2018 at 10:52:51AM -0700, Christoph Hellwig wrote:
> > On Mon, Apr 09, 2018 at 06:59:08PM +0200, Jacopo Mondi wrote:
> > > I'm still a bit puzzled on what happens if dma_mmap_from_dev_coherent() fails.
> > > Does a dma_mmap_from_dev_coherent() failure guarantee anyhow that the
> > > successive virt_to_page() isn't problematic as it is today?
> > > Or is it the
> > >  	if (off < count && user_count <= (count - off))
> > > check that makes the translation safe?
> >
> > It doesn't.  I think one major issue is that we should not simply fall
> > to dma_common_mmap if no method is required, but need every instance of
> > dma_map_ops to explicitly opt into an mmap method that is known to work.
>
> I see.. this patch thus just postpones the problem...
>
> >
> > >  #ifndef CONFIG_ARCH_NO_COHERENT_DMA_MMAP
> > >  	unsigned long user_count = vma_pages(vma);
> > >  	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> > > -	unsigned long pfn = page_to_pfn(virt_to_page(cpu_addr));
> > >  	unsigned long off = vma->vm_pgoff;
> > > +	unsigned long pfn;
> > >
> > >  	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> > >
> > > @@ -235,6 +235,7 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
> > >  		return ret;
> > >
> > >  	if (off < count && user_count <= (count - off)) {
> > > +		pfn = page_to_pfn(virt_to_page(cpu_addr));
> > >  		ret = remap_pfn_range(vma, vma->vm_start,
> > >  				      pfn + off,
> > >  				      user_count << PAGE_SHIFT,
> >
> > Why not:
> >
> > 		ret = remap_pfn_range(vma, vma->vm_start,
> > 				page_to_pfn(virt_to_page(cpu_addr)) + off,
> >
> > and save the temp variable?
>
> Sure, it's better... Should I send a v2 or considering your above
> comment this patch is just a mitigation and should be ditched in
> favour of a proper solution (which requires a much more considerable amount
> of work though)?

Don't want to be insistent, but I didn't get from your reply if a v2
is welcome or not :)

Thanks
  j

--ZRyEpB+iJ+qUx0kp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJa0NsRAAoJEHI0Bo8WoVY8GF0QAKn83Ua0fVq/WitRlPQoYE74
Re1T8GJjmZXt9DjEnbJtpUye+lQzEQn10NyOGGHX6OMwHI3AnZ2C5QNUZzvdJ/+7
RPHml+RV4pzBW9/nVz7iIqnutjdCYI6qzn+8nfedLlUPvaSx/kxFPhLMzpOJFzkS
BHFqJF8XE2jI7BGMwOFArbfi/VQIcRWItQgyxUQ3wx7k6cnReB5CUBJ1BnvQW6Pq
a1ZI1mcmHz/CYwHlzVRPRzPDjWnIzimb1qeFIg0SSqVjSb3N+gsC5D2y/UeAxmfW
NGQ/JcP1Rmrp6oaNCg+TWFVQERtPJcS1MxXdgfmbTlnqcfTFjqIcTYCtR7G+GjFM
JTUPZA8sjQED4qQYDxzulfa83MsBrJFb8EdiP6d+9So8+nhY0PiK8EIw1QHevP+O
8pcqB2WIPn6Tg9Wzot2XAxSiXarZ4YYQSck0Zt0o7tKzFO7mmunbyaSmz6A5KVcV
uLWemrQcKpyTCp3+NUvGpTM1gjmbXaZjtqVjTTznu7lc0smMmTAxHLCq/Bt12xIk
abnFAz+HQ6qjRnDQsYc1D8tsoXgbzOf7HZrQA46TPIbzBa19HqNSsyUz+k0yTLdc
PNjTxN2JGvUZIZtsi0SET4itmnyBsgJjZjibVhGrRnv2mli+ubvnnpHfdyFWSILA
AB1G1Nw8H2wQlCrVZLEy
=BgWl
-----END PGP SIGNATURE-----

--ZRyEpB+iJ+qUx0kp--

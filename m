Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751240AbeEBHqz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 03:46:55 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:35347 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750920AbeEBHqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 03:46:53 -0400
X-Originating-IP: 2.224.242.101
Date: Wed, 2 May 2018 09:46:31 +0200
From: jacopo mondi <jacopo@jmondi.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: ysato@users.sourceforge.jp, dalias@libc.org,
        thomas.petazzoni@free-electrons.com, robin.murphy@arm.com,
        geert@linux-m68k.org, sergei.shtylyov@cogentembedded.com,
        linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sh: mm: Fix unprotected access to struct device
Message-ID: <20180502074600.GC27261@w540>
References: <1524044555-20610-1-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UnaWdueM1EBWVRzC"
Content-Disposition: inline
In-Reply-To: <1524044555-20610-1-git-send-email-jacopo+renesas@jmondi.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UnaWdueM1EBWVRzC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi again Christoph,

    The gentle ping actually applies to this version of the patch.

Sorry for the confusion.
Thanks
   j

On Wed, Apr 18, 2018 at 11:42:35AM +0200, Jacopo Mondi wrote:
> With commit ce88313069c36eef80f21fd7 ("arch/sh: make the DMA mapping
> operations observe dev->dma_pfn_offset") the generic DMA allocation
> function on which the SH 'dma_alloc_coherent()' function relies on,
> accesses the 'dma_pfn_offset' field of struct device.
>
> Unfortunately the 'dma_generic_alloc_coherent()' function is called from
> several places with a NULL struct device argument, halting the CPU
> during the boot process.
>
> This patch fixes the issue by protecting access to dev->dma_pfn_offset,
> with a trivial check for validity. It also passes a valid 'struct device'
> in the 'platform_resource_setup_memory()' function which is the main user
> of 'dma_alloc_coherent()', and inserts a WARN_ON() check to remind to future
> (and existing) bogus users of this function to provide a valid 'struct device'
> whenever possible.
>
> Fixes: ce88313069c36eef80f21fd7 ("arch/sh: make the DMA mapping operations observe dev->dma_pfn_offset")
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
>
> ---
> v2 -> v3:
> - remove (now) useless parenthesis around pfn assignement as suggested
>   by Sergei
> - Add changelog to the patch, which I forgot in v2
>
> v1 -> v2:
> - Move WARN_ON() closer to dev validity check as suggested by Geert
>
> ---
>  arch/sh/mm/consistent.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
> index 8ce9869..f1b4469 100644
> --- a/arch/sh/mm/consistent.c
> +++ b/arch/sh/mm/consistent.c
> @@ -59,7 +59,9 @@ void *dma_generic_alloc_coherent(struct device *dev, size_t size,
>
>  	split_page(pfn_to_page(virt_to_phys(ret) >> PAGE_SHIFT), order);
>
> -	*dma_handle = virt_to_phys(ret) - PFN_PHYS(dev->dma_pfn_offset);
> +	*dma_handle = virt_to_phys(ret);
> +	if (!WARN_ON(!dev))
> +		*dma_handle -= PFN_PHYS(dev->dma_pfn_offset);
>
>  	return ret_nocache;
>  }
> @@ -69,9 +71,12 @@ void dma_generic_free_coherent(struct device *dev, size_t size,
>  			       unsigned long attrs)
>  {
>  	int order = get_order(size);
> -	unsigned long pfn = (dma_handle >> PAGE_SHIFT) + dev->dma_pfn_offset;
> +	unsigned long pfn = dma_handle >> PAGE_SHIFT;
>  	int k;
>
> +	if (!WARN_ON(!dev))
> +		pfn += dev->dma_pfn_offset;
> +
>  	for (k = 0; k < (1 << order); k++)
>  		__free_pages(pfn_to_page(pfn + k), 0);
>
> @@ -143,7 +148,7 @@ int __init platform_resource_setup_memory(struct platform_device *pdev,
>  	if (!memsize)
>  		return 0;
>
> -	buf = dma_alloc_coherent(NULL, memsize, &dma_handle, GFP_KERNEL);
> +	buf = dma_alloc_coherent(&pdev->dev, memsize, &dma_handle, GFP_KERNEL);
>  	if (!buf) {
>  		pr_warning("%s: unable to allocate memory\n", name);
>  		return -ENOMEM;
> --
> 2.7.4
>

--UnaWdueM1EBWVRzC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJa6WzXAAoJEHI0Bo8WoVY8VHgQAJ+f+VrWABtAj1hPotWX8Mxb
GbTWMa5uMBOrDckb3bSTWqpIu4cW+nKfLbLSWFNNNZiy2VfzyH95sqqYQdgt0XZB
X/iAduQx5bfLxPziOiYSrzB8AAN7L8MQ5ZEvCXkoSo1Lx6vKoLgbdpGgYSrdhjZQ
iz4cUu/MxFHt3MbPwlFTeNqMQg55ZwCh1QHC9RlqcpAWXRkz07Mbox9L0Wl+9F/S
Zwlbo6i/K1QRzmoCCq+RAAmHAAw2nCQwUNB/FyCXQgntACHVpSsDFdRT8sAzqmoL
v7MkpXUXEZqvNF6dWLUIWlo8+Cw8jZBctFZb4QqvTGnwY7qVj65x1OBnffHDvER1
2L25LOBVN+VaoD00SmgIz2pLFl0CcOfwJBRqfPsRro0dxChvmxjWQOJ3Tp4a2/D1
q+PW8h6tj1AyyytkVJgi0VM5cimj4TcbBtufm/QQqVQUtghqUeLk6XRwb4JtvwQx
t9qnbNo5ch/Ox1k7foYQrHEymgac+GVuuEfX5P1R8X54QrQ9VeiFoPS+lOUd/Qxj
iWxzBKG3egX1zyodYuJK4cs/kcjWh8HSL8cro9LkznEqcjlTXW2SMlnQTG6wPjnQ
o2kDJDjPfKxEGxgB0PioALF5Ha9qiciw2HARleNdoL3mcvVZiqViLJVGkbc8Kg6I
24PCZUT1CSudq2qg4xT6
=WEro
-----END PGP SIGNATURE-----

--UnaWdueM1EBWVRzC--

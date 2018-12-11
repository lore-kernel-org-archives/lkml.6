Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F39C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2802084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="THwArCwQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D2802084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbeLKWbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:31:02 -0500
Received: from ozlabs.org ([203.11.71.1]:44387 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbeLKWbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:31:02 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43DvmL3jGfz9s0t;
        Wed, 12 Dec 2018 09:30:58 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544567458;
        bh=FDY2+hCE3w5qrnkEPTJemW1ZlNu07a/gLw0K4Hm605w=;
        h=Date:From:To:Cc:Subject:From;
        b=THwArCwQS3H0Tn6wjvbx5FK3YvsmS7gc8s6FWWuuBtm+FDTCTXY9oAakCxufPdmAe
         A5SkIcZWc/Fi1JbJfKwp1KXzxtqbySPp1zpP0aszuxbYRO2jNl+dTZUEMZ+1fIgNGD
         EKy9sIa0ZAQqLvIXZnzH067nai7l3LsZprV8Uhyer53wT3jsMItkUYypWsKevRMVH3
         cKze3LtOlyDJpucSRAH53+iRTKo5hC7ax6frMfZQGHeVwxK0peYTqtDvOTvjI6jkpx
         Ao1JqJWPRZGQrPY6GnEiF6DmbeWXKfwkWwHoCBa35OWdExHx/aitMAo55m3ymdMwlI
         W0ecbhcNtQ0MQ==
Date:   Wed, 12 Dec 2018 09:30:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>, Christoph Hellwig <hch@lst.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: linux-next: manual merge of the sparc-next tree with the
 dma-mapping tree
Message-ID: <20181212093042.00fbf6be@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/97qMfsJlzkB6j6fAWO5DwPk"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/97qMfsJlzkB6j6fAWO5DwPk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the sparc-next tree got a conflict in:

  arch/sparc/kernel/ioport.c

between commit:

  53b7670e5735 ("sparc: factor the dma coherent mapping into helper")

from the dma-mapping tree and commit:

  86ef771ed543 ("sparc: Use DT node full_name instead of name for resources=
")

from the sparc-next tree.

I fixed it up (see below - the resolution looks more complex than it
is) and can carry the fix as necessary. This is now fixed as far as
linux-next is concerned, but any non trivial conflicts should be
mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/sparc/kernel/ioport.c
index 51c128d80193,aeaad04fdd14..000000000000
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@@ -245,46 -247,97 +245,46 @@@ static void _sparc_free_io(struct resou
  	release_resource(res);
  }
 =20
 -#ifdef CONFIG_SBUS
 -
 -void sbus_set_sbus64(struct device *dev, int x)
 -{
 -	printk("sbus_set_sbus64: unsupported\n");
 -}
 -EXPORT_SYMBOL(sbus_set_sbus64);
 -
 -/*
 - * Allocate a chunk of memory suitable for DMA.
 - * Typically devices use them for control blocks.
 - * CPU may access them without any explicit flushing.
 - */
 -static void *sbus_alloc_coherent(struct device *dev, size_t len,
 -				 dma_addr_t *dma_addrp, gfp_t gfp,
 -				 unsigned long attrs)
 +unsigned long sparc_dma_alloc_resource(struct device *dev, size_t len)
  {
 -	struct platform_device *op =3D to_platform_device(dev);
 -	unsigned long len_total =3D PAGE_ALIGN(len);
 -	unsigned long va;
  	struct resource *res;
 -	int order;
 -
 -	/* XXX why are some lengths signed, others unsigned? */
 -	if (len <=3D 0) {
 -		return NULL;
 -	}
 -	/* XXX So what is maxphys for us and how do drivers know it? */
 -	if (len > 256*1024) {			/* __get_free_pages() limit */
 -		return NULL;
 -	}
 -
 -	order =3D get_order(len_total);
 -	va =3D __get_free_pages(gfp, order);
 -	if (va =3D=3D 0)
 -		goto err_nopages;
 =20
 -	if ((res =3D kzalloc(sizeof(struct resource), GFP_KERNEL)) =3D=3D NULL)
 -		goto err_nomem;
 +	res =3D kzalloc(sizeof(*res), GFP_KERNEL);
 +	if (!res)
 +		return 0;
- 	res->name =3D dev->of_node->name;
++	res->name =3D dev->of_node->full_name;
 =20
 -	if (allocate_resource(&_sparc_dvma, res, len_total,
 -	    _sparc_dvma.start, _sparc_dvma.end, PAGE_SIZE, NULL, NULL) !=3D 0) {
 -		printk("sbus_alloc_consistent: cannot occupy 0x%lx", len_total);
 -		goto err_nova;
 +	if (allocate_resource(&_sparc_dvma, res, len, _sparc_dvma.start,
 +			      _sparc_dvma.end, PAGE_SIZE, NULL, NULL) !=3D 0) {
 +		printk("%s: cannot occupy 0x%zx", __func__, len);
 +		kfree(res);
 +		return 0;
  	}
 =20
 -	// XXX The sbus_map_dma_area does this for us below, see comments.
 -	// srmmu_mapiorange(0, virt_to_phys(va), res->start, len_total);
 -	/*
 -	 * XXX That's where sdev would be used. Currently we load
 -	 * all iommu tables with the same translations.
 -	 */
 -	if (sbus_map_dma_area(dev, dma_addrp, va, res->start, len_total) !=3D 0)
 -		goto err_noiommu;
 -
 -	res->name =3D op->dev.of_node->full_name;
 -
 -	return (void *)(unsigned long)res->start;
 -
 -err_noiommu:
 -	release_resource(res);
 -err_nova:
 -	kfree(res);
 -err_nomem:
 -	free_pages(va, order);
 -err_nopages:
 -	return NULL;
 +	return res->start;
  }
 =20
 -static void sbus_free_coherent(struct device *dev, size_t n, void *p,
 -			       dma_addr_t ba, unsigned long attrs)
 +bool sparc_dma_free_resource(void *cpu_addr, size_t size)
  {
 +	unsigned long addr =3D (unsigned long)cpu_addr;
  	struct resource *res;
 -	struct page *pgv;
 =20
 -	if ((res =3D lookup_resource(&_sparc_dvma,
 -	    (unsigned long)p)) =3D=3D NULL) {
 -		printk("sbus_free_consistent: cannot free %p\n", p);
 -		return;
 +	res =3D lookup_resource(&_sparc_dvma, addr);
 +	if (!res) {
 +		printk("%s: cannot free %p\n", __func__, cpu_addr);
 +		return false;
  	}
 =20
 -	if (((unsigned long)p & (PAGE_SIZE-1)) !=3D 0) {
 -		printk("sbus_free_consistent: unaligned va %p\n", p);
 -		return;
 +	if ((addr & (PAGE_SIZE - 1)) !=3D 0) {
 +		printk("%s: unaligned va %p\n", __func__, cpu_addr);
 +		return false;
  	}
 =20
 -	n =3D PAGE_ALIGN(n);
 -	if (resource_size(res) !=3D n) {
 -		printk("sbus_free_consistent: region 0x%lx asked 0x%zx\n",
 -		    (long)resource_size(res), n);
 -		return;
 +	size =3D PAGE_ALIGN(size);
 +	if (resource_size(res) !=3D size) {
 +		printk("%s: region 0x%lx asked 0x%zx\n",
 +			__func__, (long)resource_size(res), size);
 +		return false;
  	}
 =20
  	release_resource(res);

--Sig_/97qMfsJlzkB6j6fAWO5DwPk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwQOpIACgkQAVBC80lX
0GxKoQf/U6JMU5TY7Rb9MHtoSLZ4Uf9dnGdzAMv3QmrQzqwVLL2ZvRNFyRhjlg6Z
cnlHqVf2ugqVT69QvNeBpyT2QRJb3nwNZWVo/H493BxYCSZE4VUlgwWSwwJyyg51
QMSNEqE6ByPSu83OeUj6bBwaCbIEEvuajkldncu67sQxiXS9sGxDdf0BNsSENL4a
oXWRNbuderqFeUhCrv3FXVMIg43I6qTVXuueJkNEF8rqAptECEbVsmO73TgN4BIo
xp8ewftGwGn9b2hQN43URqTxK3yrWFHmSMQMUGYahccgUMz/ScWIfQ609i5U4D+M
wYAGQWCvVNNzVH4fN6lz8FG+jokvug==
=V0Wc
-----END PGP SIGNATURE-----

--Sig_/97qMfsJlzkB6j6fAWO5DwPk--

Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B9FC282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5084A20870
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ubuKcplW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbfAaCkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 21:40:37 -0500
Received: from ozlabs.org ([203.11.71.1]:44441 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfAaCkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 21:40:37 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43qkxG0ywZz9s4s;
        Thu, 31 Jan 2019 13:40:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548902434;
        bh=aDtlllvo8hXnwE0n5VUk+ub3tnkcZywc5F4fD7PIbz0=;
        h=Date:From:To:Cc:Subject:From;
        b=ubuKcplWcLveFPWUO/Av5G8vUsqaHng26FPUUSUF6pZsiP2uou1KeY0vQwS8GRpXe
         C072AqZDMwpvwMla1qAL2nj9x0YUEzAW2m0QYbB9ftVh8OnJBPXaVqZGbV64PMKPlV
         ipzavTXcQurflFblJAwxwxAUQajg0NIj2w8PD34ds1N9SuDDVXQuzEwo9J/+5uagNE
         Ots7mchln99qQAKFmHDTb9zmPmS9Xf2zF4DwiykZgkE0Jt5oqKBjPoBEo3ndLQ6Zbc
         bkXAqIq2S3ObTTFswfZ0VR0MPxoNY63zpLgsPlFeT06X4hss34ajznfgKuraal6uUb
         vwssF50k9qE9w==
Date:   Thu, 31 Jan 2019 13:40:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the vhost tree with the pci tree
Message-ID: <20190131134033.1ed0021d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/hPh8DgZ=ib+x5tNHOt/Hbr3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hPh8DgZ=ib+x5tNHOt/Hbr3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vhost tree got a conflict in:

  drivers/pci/setup-bus.c

between commit:

  51c48b310183 ("PCI: Probe bridge window attributes once at enumeration-ti=
me")

from the pci tree and commit:

  955156f34e7d ("PCI: avoid bridge feature re-probing on hotplug")

from the vhost tree.

I fixed it up (hopefully - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/pci/setup-bus.c
index 1941bb0a6c13,d5c25d465d97..000000000000
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@@ -735,17 -735,50 +735,26 @@@ int pci_claim_bridge_resource(struct pc
     base/limit registers must be read-only and read as 0. */
  static void pci_bridge_check_ranges(struct pci_bus *bus)
  {
 -	u16 io;
 -	u32 pmem;
  	struct pci_dev *bridge =3D bus->self;
 -	struct resource *b_res;
 -
 -	b_res =3D &bridge->resource[PCI_BRIDGE_RESOURCES];
 +	struct resource *b_res =3D &bridge->resource[PCI_BRIDGE_RESOURCES];
 =20
+ 	/*
+ 	 * Don't re-check after this was called once already:
+ 	 * important since bridge might be in use.
+ 	 * Note: this is only reliable because as per spec all PCI to PCI
+ 	 * bridges support memory unconditionally so IORESOURCE_MEM is set.
+ 	 */
+ 	if (b_res[1].flags & IORESOURCE_MEM)
+ 		return;
+=20
  	b_res[1].flags |=3D IORESOURCE_MEM;
 =20
 -	pci_read_config_word(bridge, PCI_IO_BASE, &io);
 -	if (!io) {
 -		pci_write_config_word(bridge, PCI_IO_BASE, 0xe0f0);
 -		pci_read_config_word(bridge, PCI_IO_BASE, &io);
 -		pci_write_config_word(bridge, PCI_IO_BASE, 0x0);
 -	}
 -	if (io)
 +	if (bridge->io_window)
  		b_res[0].flags |=3D IORESOURCE_IO;
 =20
 -	/*  DECchip 21050 pass 2 errata: the bridge may miss an address
 -	    disconnect boundary by one PCI data phase.
 -	    Workaround: do not use prefetching on this device. */
 -	if (bridge->vendor =3D=3D PCI_VENDOR_ID_DEC && bridge->device =3D=3D 0x0=
001)
 -		return;
 -
 -	pci_read_config_dword(bridge, PCI_PREF_MEMORY_BASE, &pmem);
 -	if (!pmem) {
 -		pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE,
 -					       0xffe0fff0);
 -		pci_read_config_dword(bridge, PCI_PREF_MEMORY_BASE, &pmem);
 -		pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE, 0x0);
 -	}
 -	if (pmem) {
 +	if (bridge->pref_window) {
  		b_res[2].flags |=3D IORESOURCE_MEM | IORESOURCE_PREFETCH;
 -		if ((pmem & PCI_PREF_RANGE_TYPE_MASK) =3D=3D
 -		    PCI_PREF_RANGE_TYPE_64) {
 +		if (bridge->pref_64_window) {
  			b_res[2].flags |=3D IORESOURCE_MEM_64;
  			b_res[2].flags |=3D PCI_PREF_RANGE_TYPE_64;
  		}

--Sig_/hPh8DgZ=ib+x5tNHOt/Hbr3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxSYCEACgkQAVBC80lX
0Gxfqgf+I4oKR99AHQbwwfWlsMekEB9AT2rUtkCXzTwQRqQLwPsyCQl9CsdZ69Tw
+hIt8/qR6i35noLRv+sKUDi2Zaw5ybntXmqDwDiz29xtVfHvCOPeRGHLjy7ad/2X
bpvGD9KSCidEth3fELtGZMTtSwW5xVwPPCTGFnMrYpkFzjDa6ApJreb9ZVKPKJik
5FRT1iHPN5uC45X0UJEDuYVoDjLOEUxvSHqwemUAl85odYwf5bymoLIRyhOlG8sZ
BBEEWJEO/mUxH53AL9PCLPx6Lk+M3XynVBjQX44pheoT+rLtiM2GWqCXz7UUSK1Z
0AZdiLV8aAoDaa9x8W6VwuLDipd0vg==
=Bqf0
-----END PGP SIGNATURE-----

--Sig_/hPh8DgZ=ib+x5tNHOt/Hbr3--

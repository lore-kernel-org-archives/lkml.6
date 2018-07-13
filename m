Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AC9ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FCA92147E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="cocG8nAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FCA92147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387796AbeGMAZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 20:25:30 -0400
Received: from ozlabs.org ([203.11.71.1]:45923 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387751AbeGMAZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 20:25:30 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
        id 41RYDn0fd7z9s0n; Fri, 13 Jul 2018 10:13:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1531440809;
        bh=3/oxBKJTXUQJBEaSvnLRV0l+ykqnjtwZ2L4oJ0tiJBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cocG8nATpLlZcZW9r8hS86VEgur7rqalXqjoYryeEW+vJoPpuNaDbc+A6Qu5G/EEw
         oqVE00HJrZW4b/wEVnzaOEbCoccQWXhPSvduQbg/bDLcOO+cSoZVVSiAYk6eHqwRnI
         psf9BiKh/1ZaLn4WB5Zycw/N5NBt8c+oneRn0O3g=
Date:   Fri, 13 Jul 2018 10:13:23 +1000
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio-pci: Disable binding to PFs with SR-IOV enabled
Message-ID: <20180713001323.GU22363@umbus.fritz.box>
References: <20180712223243.9593.24855.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f6M9UaX53EEZorp0"
Content-Disposition: inline
In-Reply-To: <20180712223243.9593.24855.stgit@gimli.home>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f6M9UaX53EEZorp0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 12, 2018 at 04:33:04PM -0600, Alex Williamson wrote:
> We expect to receive PFs with SR-IOV disabled, however some host
> drivers leave SR-IOV enabled at unbind.  This puts us in a state where
> we can potentially assign both the PF and the VF, leading to both
> functionality as well as security concerns due to lack of managing the
> SR-IOV state as well as vendor dependent isolation from the PF to VF.
> If we were to attempt to actively disable SR-IOV on driver probe, we
> risk VF bound drivers blocking, potentially risking live lock
> scenarios.  Therefore simply refuse to bind to PFs with SR-IOV enabled
> with a warning message indicating the issue.  Users can resolve this
> by re-binding to the host driver and disabling SR-IOV before
> attempting to use the device with vfio-pci.
>=20
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  drivers/vfio/pci/vfio_pci.c |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index b423a309a6e0..f372f209c5c2 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -1189,6 +1189,19 @@ static int vfio_pci_probe(struct pci_dev *pdev, co=
nst struct pci_device_id *id)
>  	if (pdev->hdr_type !=3D PCI_HEADER_TYPE_NORMAL)
>  		return -EINVAL;
> =20
> +	/*
> +	 * Prevent binding to PFs with VFs enabled, this too easily allows
> +	 * userspace instance with VFs and PFs from the same device, which
> +	 * cannot work.  Disabling SR-IOV here would initiate removing the
> +	 * VFs, which would unbind the driver, which is prone to blocking
> +	 * if that VF is also in use by vfio-pci.  Just reject these PFs
> +	 * and let the user sort it out.
> +	 */
> +	if (pci_num_vf(pdev)) {
> +		pci_warn(pdev, "Cannot bind to PF with SR-IOV enabled\n");
> +		return -EBUSY;
> +	}
> +
>  	group =3D vfio_iommu_group_get(&pdev->dev);
>  	if (!group)
>  		return -EINVAL;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--f6M9UaX53EEZorp0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltH7qMACgkQbDjKyiDZ
s5JHuBAAg9gZqelUvQLVcCqTiRfA1NGnjish/cVQHYqg30GcUESKiz/L9mBDd2F7
bowsF1nQG8x0XH28PEe+211y1dcWV7EhNdAsKunFnmUkHB5FzXiYeo/tHN+9DGuk
ZsgZwAw7l6u98stgo22Ka0cxG1iVqncTMZDjZmcdt5pc+my33V3GfZkyv3CADf+J
dB5y7pSmSP2SuuWL1vlmN7hPAQHbfOX5kaxoyvkWrQ7vGttCTCThFUXI7rXV0eOM
qjztZNtRrPAynpPN0eIXAMs9qJE+4DqP+DUiteCqlRA4LHIisoRBdwX3OAuL9IE0
pcfgU1yw1Ic1pjOq2CZtHhm8p3O+urdalwXWSRQW34lEarrHK9S+z+htwMkp2JeJ
sS0Vmm1q9/o3QYbYmxyuIZk18gRIMDgqnwLw8RsMPiltkF/b2VU2kLUduMA0J7r/
DHtgeBXEb5mWDuhkGhAGsKdyneQaA+IUfPh6Fjs9EsZEz6iv5FtY6ss2P4kUh+f+
pi/DgQaktA9z0Nz2rdfG5GOtGXFm+OKKQhhTo16Ikxq6q/ouF6zo9sjBrs1bhv9F
U7x5N6jvaJsD/feFLJImDEr7KA9xg8Beku8ZL3p5S27Zxz0xehAsaak/l8dxH21T
LTxWHcIcfsQnfVBTWaNsHjxc9HVFVrKEaa/FAJg4EnaJ4FkACCg=
=U7kh
-----END PGP SIGNATURE-----

--f6M9UaX53EEZorp0--

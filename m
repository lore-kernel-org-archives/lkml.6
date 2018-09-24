Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A59C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A982098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s34SPuea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A982098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbeIXRMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:12:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35082 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeIXRMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:12:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id o16so5929525wrx.2;
        Mon, 24 Sep 2018 04:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WPvUTrqyS4MieS9r9r3nD0J2RpN0+lRV9mvPSksF8j0=;
        b=s34SPueaCGLqqVy0hOqJVHThpwTWF8xC0BM9Gp+QgmXFtJW6q+5C7Og0aaS8LT/sDz
         ZUqyN3xWdFdj+S9wqOyrsv1kz9SraD71Y88pFECArX5C06TKmkeci/kdO+EBNSfbj9L/
         u88/ahmGvh4JAdlqN21qypjBokexMZp/EibD4TtQLmshMBZ4AIVA4wkT7ThSWbSXG0kI
         AZt9GV5X/x/X01vRowuPEwkl7hdwWnyOWhhzoN8Ola6OUi0+w1xluxrsrBYMle3gO/th
         7Kc/EPKBvHyt/RQHrJJ9sLafxyAY2wjQFFGBGZVjbOr9lgtOebBX2PhAN/prphXMS4ye
         2RPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WPvUTrqyS4MieS9r9r3nD0J2RpN0+lRV9mvPSksF8j0=;
        b=t77m55OYw6UFgMqCiuvLOtZ7Qpa8CL/JLoXj6/UUn6kU6UYT9jMYTShAa3AnzIaDuT
         HOglfQYXF/yAo2143fu5eilow6o14g409+TVD8tP0KtwSTBBtOqZcgxvxYFYxP+qnY5U
         0LrRV+mqZh9AUrQLJwtq9b+tV/qrP/fFE/9GJWxPhuvnTMNJURj0KVhi9io/0QcnSUA9
         GKNKUJKP5vzK4FcuovDHuYG9Q4wt8JijE8iY943VDaiwClVNilLfUI4sbNmkKyaogLV2
         wahKYzGBKeVi9KDt+lTQ7QRcev2aiFq/8ww7g0MLqEOJkrOnuWcFYeGkLaxHs0N3uIjf
         p5gw==
X-Gm-Message-State: ABuFfohlho8iTMrRAFM7oNW+n6q0ys4QGzmW/s+sCMorMdSOj6okzeI7
        s9vdfavUZNn91KZnxfxQ9jo=
X-Google-Smtp-Source: ACcGV63Y+MKsJTWnbrSQywgCF0G6XVz2sMjPkk42lengJk7WlsKP0C2lv4H+NdltiVGq9Q497V9+Jg==
X-Received: by 2002:adf:9051:: with SMTP id h75-v6mr8402935wrh.65.1537787449224;
        Mon, 24 Sep 2018 04:10:49 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id z21-v6sm10506969wmi.29.2018.09.24.04.10.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 04:10:48 -0700 (PDT)
Date:   Mon, 24 Sep 2018 13:10:47 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 19/20] iommu/tegra: gart: Simplify clients-tracking
 code
Message-ID: <20180924111047.GP21032@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-20-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h9WqFG8zn/Mwlkpe"
Content-Disposition: inline
In-Reply-To: <20180924004153.8232-20-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h9WqFG8zn/Mwlkpe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 03:41:52AM +0300, Dmitry Osipenko wrote:
> GART is a simple IOMMU provider that has single address space. There is
> no need to setup global clients list and manage it for tracking of the
> active domain, hence lot's of code could be safely removed and replaced
> with a simpler alternative.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/iommu/tegra-gart.c | 157 +++++++++----------------------------
>  1 file changed, 39 insertions(+), 118 deletions(-)
>=20
> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
> index 306e9644a676..7182445c3b76 100644
> --- a/drivers/iommu/tegra-gart.c
> +++ b/drivers/iommu/tegra-gart.c
> @@ -19,7 +19,6 @@
> =20
>  #include <linux/io.h>
>  #include <linux/iommu.h>
> -#include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> @@ -42,30 +41,20 @@
>  #define GART_PAGE_MASK						\
>  	(~(GART_PAGE_SIZE - 1) & ~GART_ENTRY_PHYS_ADDR_VALID)
> =20
> -struct gart_client {
> -	struct device		*dev;
> -	struct list_head	list;
> -};
> -
>  struct gart_device {
>  	void __iomem		*regs;
>  	u32			*savedata;
>  	u32			page_count;	/* total remappable size */
>  	dma_addr_t		iovmm_base;	/* offset to vmm_area */
>  	spinlock_t		pte_lock;	/* for pagetable */
> -	struct list_head	client;
> -	spinlock_t		client_lock;	/* for client list */
> +	spinlock_t		dom_lock;	/* for active domain */
> +	unsigned int		active_devices;	/* number of active devices */
>  	struct iommu_domain	*active_domain;	/* current active domain */
>  	struct device		*dev;
> =20
>  	struct iommu_device	iommu;		/* IOMMU Core handle */
>  };
> =20
> -struct gart_domain {
> -	struct iommu_domain domain;		/* generic domain handle */
> -	struct gart_device *gart;		/* link to gart device   */
> -};
> -
>  static struct gart_device *gart_handle; /* unique for a system */
> =20
>  static bool gart_debug;
> @@ -73,11 +62,6 @@ static bool gart_debug;
>  #define GART_PTE(_pfn)						\
>  	(GART_ENTRY_PHYS_ADDR_VALID | ((_pfn) << PAGE_SHIFT))
> =20
> -static struct gart_domain *to_gart_domain(struct iommu_domain *dom)
> -{
> -	return container_of(dom, struct gart_domain, domain);
> -}
> -
>  /*
>   * Any interaction between any block on PPSB and a block on APB or AHB
>   * must have these read-back to ensure the APB/AHB bus transaction is
> @@ -166,128 +150,69 @@ static inline bool gart_iova_range_valid(struct ga=
rt_device *gart,
>  static int gart_iommu_attach_dev(struct iommu_domain *domain,
>  				 struct device *dev)
>  {
> -	struct gart_domain *gart_domain =3D to_gart_domain(domain);
>  	struct gart_device *gart =3D gart_handle;
> -	struct gart_client *client, *c;
> -	int err =3D 0;
> -
> -	client =3D kzalloc(sizeof(*c), GFP_KERNEL);
> -	if (!client)
> -		return -ENOMEM;
> -	client->dev =3D dev;
> -
> -	spin_lock(&gart->client_lock);
> -	list_for_each_entry(c, &gart->client, list) {
> -		if (c->dev =3D=3D dev) {
> -			dev_err(gart->dev, "GART: %s is already attached\n",
> -				dev_name(dev));
> -			err =3D -EINVAL;
> -			goto fail;
> -		}
> -	}
> -	if (gart->active_domain && gart->active_domain !=3D domain) {
> -		dev_err(gart->dev,
> -			"GART: Only one domain can be active at a time\n");
> -		err =3D -EINVAL;
> -		goto fail;
> -	}
> -	gart->active_domain =3D domain;
> -	gart_domain->gart =3D gart;
> -	list_add(&client->list, &gart->client);
> -	spin_unlock(&gart->client_lock);
> -	dev_dbg(gart->dev, "GART: Attached %s\n", dev_name(dev));
> -	return 0;
> +	int ret =3D 0;
> =20
> -fail:
> -	kfree(client);
> -	spin_unlock(&gart->client_lock);
> -	return err;
> -}
> +	spin_lock(&gart->dom_lock);
> =20
> -static void __gart_iommu_detach_dev(struct iommu_domain *domain,
> -				    struct device *dev)
> -{
> -	struct gart_domain *gart_domain =3D to_gart_domain(domain);
> -	struct gart_device *gart =3D gart_domain->gart;
> -	struct gart_client *c;
> -
> -	list_for_each_entry(c, &gart->client, list) {
> -		if (c->dev =3D=3D dev) {
> -			list_del(&c->list);
> -			kfree(c);
> -			if (list_empty(&gart->client)) {
> -				gart->active_domain =3D NULL;
> -				gart_domain->gart =3D NULL;
> -			}
> -			dev_dbg(gart->dev, "GART: Detached %s\n",
> -				dev_name(dev));
> -			return;
> -		}
> +	if (gart->active_domain && gart->active_domain !=3D domain) {
> +		ret =3D -EBUSY;

This omits the error message and returns -EBUSY instead of -EINVAL. Was
this intended? For what it's worth, I do agree with the changes, it's
just that I think you could've made those in the earlier patch that
introduced them.

But this is all one series and the end result looks fine, so no need to
be that picky.

> +	} else if (dev->archdata.iommu !=3D domain) {
> +		dev->archdata.iommu =3D domain;
> +		gart->active_domain =3D domain;
> +		gart->active_devices++;
>  	}
> =20
> -	dev_err(gart->dev, "GART: Couldn't find %s to detach\n",
> -		dev_name(dev));
> +	spin_unlock(&gart->dom_lock);
> +
> +	return ret;
>  }
> =20
>  static void gart_iommu_detach_dev(struct iommu_domain *domain,
>  				  struct device *dev)
>  {
> -	struct gart_domain *gart_domain =3D to_gart_domain(domain);
> -	struct gart_device *gart =3D gart_domain->gart;
> +	struct gart_device *gart =3D gart_handle;
> +
> +	spin_lock(&gart->dom_lock);
> =20
> -	spin_lock(&gart->client_lock);
> -	__gart_iommu_detach_dev(domain, dev);
> -	spin_unlock(&gart->client_lock);
> +	if (dev->archdata.iommu =3D=3D domain) {
> +		dev->archdata.iommu =3D NULL;
> +
> +		if (--gart->active_devices =3D=3D 0)
> +			gart->active_domain =3D NULL;
> +	}
> +
> +	spin_unlock(&gart->dom_lock);
>  }
> =20
>  static struct iommu_domain *gart_iommu_domain_alloc(unsigned type)
>  {
> -	struct gart_domain *gart_domain;
> -	struct gart_device *gart;
> +	struct gart_device *gart =3D gart_handle;
> +	struct iommu_domain *domain;
> =20
>  	if (type !=3D IOMMU_DOMAIN_UNMANAGED)
>  		return NULL;
> =20
> -	gart =3D gart_handle;
> -	if (!gart)
> -		return NULL;
> -
> -	gart_domain =3D kzalloc(sizeof(*gart_domain), GFP_KERNEL);
> -	if (!gart_domain)
> -		return NULL;
> -
> -	gart_domain->domain.geometry.aperture_start =3D gart->iovmm_base;
> -	gart_domain->domain.geometry.aperture_end =3D gart->iovmm_base +
> +	domain =3D kzalloc(sizeof(*domain), GFP_KERNEL);
> +	if (domain) {
> +		domain->geometry.aperture_start =3D gart->iovmm_base;
> +		domain->geometry.aperture_end =3D gart->iovmm_base +
>  					gart->page_count * GART_PAGE_SIZE - 1;
> -	gart_domain->domain.geometry.force_aperture =3D true;
> +		domain->geometry.force_aperture =3D true;
> +	}
> =20
> -	return &gart_domain->domain;
> +	return domain;
>  }
> =20
>  static void gart_iommu_domain_free(struct iommu_domain *domain)
>  {
> -	struct gart_domain *gart_domain =3D to_gart_domain(domain);
> -	struct gart_device *gart =3D gart_domain->gart;
> -
> -	if (gart) {
> -		spin_lock(&gart->client_lock);
> -		if (!list_empty(&gart->client)) {
> -			struct gart_client *c, *tmp;
> -
> -			list_for_each_entry_safe(c, tmp, &gart->client, list)
> -				__gart_iommu_detach_dev(domain, c->dev);
> -		}
> -		spin_unlock(&gart->client_lock);
> -	}
> -
> -	kfree(gart_domain);
> +	kfree(domain);
>  }

Doesn't this now make it possible to free a potentially active domain?

> =20
>  static int gart_iommu_map(struct iommu_domain *domain, unsigned long iov=
a,
>  			  phys_addr_t pa, size_t bytes, int prot)
>  {
> -	struct gart_domain *gart_domain =3D to_gart_domain(domain);
> -	struct gart_device *gart =3D gart_domain->gart;
> +	struct gart_device *gart =3D gart_handle;

Hmm... this now introduces more uses of the gart_handle that I hoped we
could get rid of. I think we could still keep around struct gart_domain
and just make sure it is unique. The small amounts of casting here seem
mostly harmless to me, especially since they will be nops, so we end up
with just one dereference to get at the struct gart_device. I think the
benefits of not having this global variable around are worth the one
dereference here.

Thierry

--h9WqFG8zn/Mwlkpe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluoxjcACgkQ3SOs138+
s6HTWw//e8HTYSGv/C7bxs7HXJw4ZPbBBu+ENfZQtKIWijjpxe7cpKf2aq7cFGTR
n3loG2bTObd0jPWumWSmYlAiJrdbsmwjkUn3WluWRMn+bAyOduSrPVnY4I3PR1VP
weY9Eix7Kq8yNHVfRN3cB5a7fnxJE0WZdz5tSuIk7pTbCBw7nvSnZYWKf28TRmPU
15ia07yzt8if+Ad9RmBKutNqTDhpSpaABBtW/bwV3vvd5h3Y3U9MwGuSKzPMKUd6
fVsUfZKN6840XzHa9M48nsdmwtHgc6IpuSN+39IBPsXySxCEHW8W+gV2r96YYJZN
5Yf5Xgr7gUJ+UyqklV04JJvc/R6Ytq3O5tWUMIBqc7hD6aCOF5olOCvhk3feQfIP
Yh/GqO00XJIguok470nOreuuG9PZjjSuvUKh3MkvY1gB4b+Q5yc8UwYYGLOISJ3h
OdOfusQYnrZ6iZtCy4GdD1bUbgDAHJOkZrPvp/7czz/6ZKIYX1LQx+KI85SKIoir
shMqTo+WYUE9SZbqpXbiNzvjIkbgADGTaK7d+MzbK53skEVZu+eadB+uIPic50Yz
LICPjUNbjTcstbBhirQ0KpAq/LV/DTG27Tt+K+5T9yBFHQuTvr+FMbs67Xx9xTxr
P25nutaN0pW1xrVxbq2QTB2c3VP4iGMLzEsGrbphJNTkwoBP38c=
=kdoF
-----END PGP SIGNATURE-----

--h9WqFG8zn/Mwlkpe--

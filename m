Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B664C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3739620861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7yI+gOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfAWKuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:50:51 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42863 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfAWKuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 05:50:51 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so1827840wrx.9;
        Wed, 23 Jan 2019 02:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C7mbt1UXpCz9krsR7DvmG4utKLF+6zPFKIQ2LKN//TA=;
        b=b7yI+gOwdfsV+BSAn9gQMoLKrVXm0ch3mI4ZYC4UqE1klkgLWrSTMFggr+i2fMgCgo
         3u6v/+342s784M7IhgKJJwKoJPy/3M8OS9Pb11Xb3wQjyeUI71FVEdilcWTKpGOUD5cJ
         d/80JS98WOO9taIYMy6e3YL8xKCmrhZ8D3JhHJilChtbaMDsq4wBpP+MopbaFQByyjf+
         1TTgh2ne2GJELGk83M/q/RFc9trjnlorkSEg/nwd8vut8r9EdcoDyjBKFYDRDg9HD8Od
         5lHs4ngqC8Th0Q3iTJetiSE03rN4tc3LXdw2k7eZTbz1l+uFBs3yrchIfe+tMIvOMJXQ
         1THg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C7mbt1UXpCz9krsR7DvmG4utKLF+6zPFKIQ2LKN//TA=;
        b=YoyYCKXk93LzHCDBZ2VGB8mi4XwwMtukEG16+C49fF5hAY+sDeUU580pAgBVZ+dU0l
         SUfbgFuirFu0k224ZJ4bO8XTH4m3IJUgRzG5uounmJ0i0RGw5qhrDL5XVYMpcM1V6OE/
         bbILergesNjfb9vFUJGrh+XRq+8RLScNDoU+W028RH7lWsyDTS5tAfDcZq2/FZAaKbRC
         CehRscCbg+OxfC9UmKRe41cmKFJOa8/2+VwOTWWGx6xJ5iwrYmU3E+t5ZrHjoqquhDWa
         G6RcyJb/RYf9krB9Pp8AFbWZ+2o8mwPk2VhzEQOzfctLAYrnh13wLNm176x5dI+snU7A
         i7hg==
X-Gm-Message-State: AJcUukexb6PKjAKaAJt1MriYieZeToon7ew2mJWNd0+0JNHYlmCMpTa4
        BEi+LUqBM/CuDF6C/kKXFstTfSyK46w=
X-Google-Smtp-Source: ALg8bN4mgcPLnmG7kzUpqdRGLTjVaysDA3ZQ8shbuAFYdxhnwi7le1Ocby23yzaqgtciowRj/9G9Bg==
X-Received: by 2002:adf:f550:: with SMTP id j16mr2106571wrp.258.1548240649116;
        Wed, 23 Jan 2019 02:50:49 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id b129sm46398874wmd.24.2019.01.23.02.50.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 02:50:48 -0800 (PST)
Date:   Wed, 23 Jan 2019 11:50:47 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: linux-next: Fixes tags need some work in the dma-mapping-fixes
 tree
Message-ID: <20190123105047.GA18410@ulmo>
References: <20190123074747.7cd44f12@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <20190123074747.7cd44f12@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 23, 2019 at 07:47:47AM +1100, Stephen Rothwell wrote:
> Hi Christoph,
>=20
> In commit
>=20
>   702e8ed37bed ("arm64/xen: fix xen-swiotlb cache flushing")

Hi Christoph,

I'm not subscribed to any of the mailing list that the above patch was
reviewed on, so I'm replying here because it is the only reference that
I have.

The above commit breaks the build on 64-bit ARM, like so:

	  CC      drivers/xen/swiotlb-xen.o
	In file included from drivers/xen/swiotlb-xen.c:47:
	arch/arm64/include/asm/xen/page-coherent.h: In function 'xen_dma_map_page':
	arch/arm64/include/asm/xen/page-coherent.h:53:16: error: 'pfn' undeclared =
(first use in this function)
	  if (pfn_valid(pfn))
			^~~
	arch/arm64/include/asm/xen/page-coherent.h:53:16: note: each undeclared id=
entifier is reported only once for each function it appears in
	arch/arm64/include/asm/xen/page-coherent.h:50:7: warning: unused variable =
'local' [-Wunused-variable]
	  bool local =3D (page_pfn <=3D dev_pfn) &&
	       ^~~~~

Given that the "local" variable is unused, it seems like maybe a chunk
is missing from the commit and it may have been meant to look like this:

diff --git a/arch/arm64/include/asm/xen/page-coherent.h b/arch/arm64/includ=
e/asm/xen/page-coherent.h
index 77e36decc50c..d88e56b90b93 100644
--- a/arch/arm64/include/asm/xen/page-coherent.h
+++ b/arch/arm64/include/asm/xen/page-coherent.h
@@ -50,7 +50,7 @@ static inline void xen_dma_map_page(struct device *hwdev,=
 struct page *page,
  bool local =3D (page_pfn <=3D dev_pfn) &&
   (dev_pfn - page_pfn < compound_pages);

- if (pfn_valid(pfn))
+ if (local)
   dma_direct_map_page(hwdev, page, offset, size, dir, attrs);
  else
   __xen_dma_map_page(hwdev, page, dev_addr, offset, size, dir, attrs);

Thierry

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxIRwQACgkQ3SOs138+
s6GhZhAAuRKSdCg40WcUgwLZBlCRKVwAoaRgNYvZpKjWX0ucxuN1SNCf684+qE4w
HwUldlcbLD6CTXIR9tX4jC/j1WWsM5N5OcsXTj/eo//njO5SZC0C8yuneuljeuPb
avwcnPSSYOC76LvTnXZxaiAMF3T7yT4RznJkee7g+cJZiAG3s+ww2wS3V+pEZzeh
DVJelRFdVSJNhPrI1pyp4Flfho2qu89o3fIp5fBOn3MBKwHe2hpYQs7lbC9fMFM0
Hj/TTY70YLIAzLf7+PatOh+pXZpBIfvySn1SxJg2WsTz/OOgEMvaHq0eCG5e5f3I
q0HlC6s5YKb68t6HZf8B5lhWB3PnHoOlW/1sxIVSMLrUEidNmV5QztbygX9sBuvI
0d6TKxtQ+C3NclrFho3Gux3QZ+cqcykDI+XDxyhBrrphB0pc+LF2SEQhoW/83ook
x2+wyRAZfWzKEC2VH/LGEA1jDQI6HoDzCDtQUb1RsQjVLu9/uKVoE2Rfd2ROsZDi
JzwrC619LDLdbHNCJD8VEnlp4gd6735sbttbD1yAM+dj4FBt5vzFTPseXaPnXqQ2
wibVUij6nC0fIFTENyeEQW49yEBb4gACR1BGWfyLkzMRl2ZqXJ6IQSt1HyOyiu+U
4lhzrUPLWiyVksW6VCYxq2OQRQQUvtaYRlsbY9Cyc1asZiBn/sc=
=gH1L
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--

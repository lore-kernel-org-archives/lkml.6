Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57C1C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E93321473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3aI42wy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E93321473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeJRTC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 15:02:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727495AbeJRTC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 15:02:27 -0400
Received: from localhost (unknown [213.57.179.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8839220869;
        Thu, 18 Oct 2018 11:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539860519;
        bh=dTAtJoTeL99+vTpwiNi6nWvIBYgXOCRaPPQ4l0+LRO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O3aI42wyjHj+ENkSq1wovFeCUrB8nT394H0qkGfuOKZFMe3/9ZY0GKCFBMfMjbmSb
         pQ3C4CTEJ8Syzvn4h7QE/3i8z3fDXFeQ3f6gslw1rS2q3DLeBhF7gfWmsLBhHjsHi1
         KFuMh9Swhx5W9plRpK/l0U4sffc7W/VYksSlU208=
Date:   Thu, 18 Oct 2018 14:01:55 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/hns: Use 64-bit arithmetic instead of 32-bit
Message-ID: <20181018110155.GH5007@mtr-leonro.mtl.com>
References: <20181018080258.GA1720@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline
In-Reply-To: <20181018080258.GA1720@embeddedor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 18, 2018 at 10:02:58AM +0200, Gustavo A. R. Silva wrote:
> Cast *max_num_sg* to u64 in order to give the compiler complete
> information about the proper arithmetic to use.
>
> Notice that such variable is used in a context that expects an
> expression of type u64 (64 bits, unsigned) and the following
> expression is currently being evaluated using 32-bit
> arithmetic:

And what is wrong with that?
Please fix static analyzer tool instead of fixing proper C code.

Thanks

>
> length = max_num_sg * page_size;
>
> Addresses-Coverity-ID: 1474517 ("Unintentional integer overflow")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_mr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
> index 521ad2a..d479d5e 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_mr.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
> @@ -1219,7 +1219,7 @@ struct ib_mr *hns_roce_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
>  	int ret;
>
>  	page_size = 1 << (hr_dev->caps.pbl_buf_pg_sz + PAGE_SHIFT);
> -	length = max_num_sg * page_size;
> +	length = (u64)max_num_sg * page_size;
>
>  	if (mr_type != IB_MR_TYPE_MEM_REG)
>  		return ERR_PTR(-EINVAL);
> --
> 2.7.4
>

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbyGgjAAoJEORje4g2clinEbgQAMQxaoNws6n8a+P3oQPc32fT
jdbDLhhgQZYnVRVn4i4kRegae1ipUfHO99CJHioqmtfARMuHIPJY+lISRc3w4YEq
0CKM6Ej8C9vrORCTeBHxfTER6YeglanT4X4hvqxlbtsyLwqCSa0+uhCTIrmw9gfC
DDLd43l468YfiNTB0DgoKnqL3DhrzvV4y+LpNautd5nGx+toZh1wTxoCZphuzio/
zCZhpbrr8HrjLzDreEXLkdhgzHajN2z3t09Dfgr0hVefs3Wjj+v6g6AU5t0d6Cf5
O+xKjS+fFBejOAhKQ+h9oq/isYrV9PYSrQwydas/53XSf/AnHXJJo7zq0sD41/BH
dviY6lvJ0awXiRua9A2nzewEYQ7PZThodPlx+IuYj0y49o7+Md4UwNOyngzy7nsd
6sLU/MDoNBiQyizBRd+VblcuzJ5dLotGHFGuRVZYFZZZztojTpF/i1lYG26qK3Gv
mYOEakKYXe4iFAfUaiYEIvbAr1cZG43eLYeZuUzWgAtwP7FD9C/Ifj24iyPToqD+
hgvomTPwGCGfkuXijLDUFVNDbJ95inCVSDS0pF3xHmovH1DGp1TXTQdq0orGKiAm
uV0UA8kKIsHMt2z7Dk6JKj2nXggfGQJI/IJYjqoumpbNLc3TRWIgmDG5Fo03qzoq
pXHiJeMR0FXDV6i7FCCE
=1ivn
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--

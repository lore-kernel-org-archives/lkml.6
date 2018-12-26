Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A85C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF35214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545853795;
	bh=mX9AmJnouUwVBXatZv9MWSYuIwKFsYX+jN4IaNqT84I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y+LIVHqDAIU1oHsqXNNbDnTPSKIvHsPg1BC1R720WY/zTLCH2w3LjhTCFNB1iFFbp
	 Snq+zPN8MsGuPgux2XXTPQnkhFf3V3gatgtrIzypsT0ILKdiemQHDuZKp/ZJNYFzXd
	 EYKJ7frhDixEqPEg/EuvwdoWmBQw321fOazO+330=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbeLZTty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 14:49:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:47070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbeLZTty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 14:49:54 -0500
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63B02214D8;
        Wed, 26 Dec 2018 19:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545853792;
        bh=mX9AmJnouUwVBXatZv9MWSYuIwKFsYX+jN4IaNqT84I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ut/OxAtvm0wkioUsE9cpPW4v50jaw81BdM+j7bxr4/NX9Y/fOUohW09thrJb7D+CV
         DLgtJqa5HIRhv3ZNw//AvvPn9FcqWp3fZBZJhtDyk7TrjTUqBItPkycfVqf3NKpXa/
         uo1R47xcusQ6Z4v8LjeTr0JBpcxHlVXSa03jaj+4=
Date:   Wed, 26 Dec 2018 21:49:44 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Parav Pandit <parav@mellanox.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Alex Estrin <alex.estrin@intel.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] infiniband: add checks for the status of nla_put
Message-ID: <20181226194944.GI10329@mtr-leonro.mtl.com>
References: <20181226021141.71538-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KdquIMZPjGJQvRdI"
Content-Disposition: inline
In-Reply-To: <20181226021141.71538-1-kjlu@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 25, 2018 at 08:11:39PM -0600, Kangjie Lu wrote:
> The fix inserts multiple checks for nla_put, and issues warnings if it
> fails.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---

I didn't look very close, but it strange that failure in nla_put()
doesn't follow by canceling of netlink message.

Plus extensive usage of pr_warn() is not needed here.

Thanks



>  drivers/infiniband/core/sa_query.c | 39 ++++++++++++++++++------------
>  1 file changed, 24 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
> index be5ba5e15496..0e5d7a6dde36 100644
> --- a/drivers/infiniband/core/sa_query.c
> +++ b/drivers/infiniband/core/sa_query.c
> @@ -775,28 +775,37 @@ static void ib_nl_set_path_rec_attrs(struct sk_buff *skb,
>  	/* Now build the attributes */
>  	if (comp_mask & IB_SA_PATH_REC_SERVICE_ID) {
>  		val64 = be64_to_cpu(sa_rec->service_id);
> -		nla_put(skb, RDMA_NLA_F_MANDATORY | LS_NLA_TYPE_SERVICE_ID,
> -			sizeof(val64), &val64);
> +		if (nla_put(skb, RDMA_NLA_F_MANDATORY | LS_NLA_TYPE_SERVICE_ID,
> +			sizeof(val64), &val64))
> +			pr_warn("nla_put failed\n");
> +	}
> +	if (comp_mask & IB_SA_PATH_REC_DGID) {
> +		if (nla_put(skb, RDMA_NLA_F_MANDATORY | LS_NLA_TYPE_DGID,
> +			sizeof(sa_rec->dgid), &sa_rec->dgid))
> +			pr_warn("nla_put failed\n");
> +	}
> +	if (comp_mask & IB_SA_PATH_REC_SGID) {
> +		if (nla_put(skb, RDMA_NLA_F_MANDATORY | LS_NLA_TYPE_SGID,
> +			sizeof(sa_rec->sgid), &sa_rec->sgid))
> +			pr_warn("nla_put failed\n");
> +	}
> +	if (comp_mask & IB_SA_PATH_REC_TRAFFIC_CLASS) {
> +		if (nla_put(skb, RDMA_NLA_F_MANDATORY | LS_NLA_TYPE_TCLASS,
> +			sizeof(sa_rec->traffic_class), &sa_rec->traffic_class))
> +			pr_warn("nla_put failed\n");
>  	}
> -	if (comp_mask & IB_SA_PATH_REC_DGID)
> -		nla_put(skb, RDMA_NLA_F_MANDATORY | LS_NLA_TYPE_DGID,
> -			sizeof(sa_rec->dgid), &sa_rec->dgid);
> -	if (comp_mask & IB_SA_PATH_REC_SGID)
> -		nla_put(skb, RDMA_NLA_F_MANDATORY | LS_NLA_TYPE_SGID,
> -			sizeof(sa_rec->sgid), &sa_rec->sgid);
> -	if (comp_mask & IB_SA_PATH_REC_TRAFFIC_CLASS)
> -		nla_put(skb, RDMA_NLA_F_MANDATORY | LS_NLA_TYPE_TCLASS,
> -			sizeof(sa_rec->traffic_class), &sa_rec->traffic_class);
>
>  	if (comp_mask & IB_SA_PATH_REC_PKEY) {
>  		val16 = be16_to_cpu(sa_rec->pkey);
> -		nla_put(skb, RDMA_NLA_F_MANDATORY | LS_NLA_TYPE_PKEY,
> -			sizeof(val16), &val16);
> +		if (nla_put(skb, RDMA_NLA_F_MANDATORY | LS_NLA_TYPE_PKEY,
> +			sizeof(val16), &val16))
> +			pr_warn("nla_put failed\n");
>  	}
>  	if (comp_mask & IB_SA_PATH_REC_QOS_CLASS) {
>  		val16 = be16_to_cpu(sa_rec->qos_class);
> -		nla_put(skb, RDMA_NLA_F_MANDATORY | LS_NLA_TYPE_QOS_CLASS,
> -			sizeof(val16), &val16);
> +		if (nla_put(skb, RDMA_NLA_F_MANDATORY | LS_NLA_TYPE_QOS_CLASS,
> +			sizeof(val16), &val16))
> +			pr_warn("nla_put failed\n");
>  	}
>  }
>
> --
> 2.17.2 (Apple Git-113)
>

--KdquIMZPjGJQvRdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcI9tXAAoJEORje4g2clinJG0QALp3DTEw0ouwT2G6r5s1ReMh
1naoBDXwbmqqfNvBbPatEYjZc0t/9pigxjtQAeuQhYqtBXWz+sPOkCkq+vuxIPA0
uRQgeoRVdRGT7opN5A/I4y6tANZkLDq4kuFIdAQ/1uqtcTDOqevRvNTrc3YLiZXU
TQrHn1qqrDwnnn2I8aFpHkhDpdytFQPY9dp4G1yxyJ89Be917s6JvF6NBaZgZOGE
U5tcOpwbcfbDI8rIg9VH7NJQnTViq9cvne6dMZEJhtlQBZrI06snOvnag/DrvhcD
acJR/S2bBCSK5QP6SvAoq6Bg1O+OWyqPENQwSrZAB9Di0/v66Z5iYWa21yuUXbww
P2/qd5xNnLO+q0wXDhpbx+DKdc9nWqzNWlETxvL8uA/LweTyVXJnQLxuKxsrjYjT
QDYjU79ZggDXHHUUsxgb8h/jydQB9uqUV1F1f/b1SuYb+LGpOiFr/2nJ1A7wcLtW
wQnjfNQ88IzA2Z30AnN8gN+pAhsxVlInhoii5yE/cFbOlGLq+aFoBl+JlS1YqsL2
30sYBX6atTcc9Y6fY4slKirBxmON5Rx8iK+LGG5QOm8NQvr1bfg5uUDypqjseDRH
svlB+iSXf6WOEAMalUlJfx6Yu+KtonFWBHKPmDPywYodFrzpIBBfSY389615rxl1
qFjo6xZD1Gz2a2NJs5Qi
=r9E5
-----END PGP SIGNATURE-----

--KdquIMZPjGJQvRdI--

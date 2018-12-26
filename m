Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B42BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C302171F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545853854;
	bh=erKgMFZ3BsufRUt8mRnOG/GhsZlfjWyIbqJAORm8I/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=a6ArRH2frrULxxHIJG3pZMdEW06K0nxYtNoZ6BJi5DwkusmGvUCTwAdPC7qoponFA
	 JMXCyMDRxCv6Mq3hg3vP4yXo9proyENILD7Ie6Cx22Dn4TZuewzghNulBMSy+GV5AP
	 ER0k9hmf5nm8sxD/UTft+xlCzJV3uO1OXAzxNk9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbeLZTux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 14:50:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:48572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbeLZTuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 14:50:52 -0500
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B9D8214D8;
        Wed, 26 Dec 2018 19:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545853852;
        bh=erKgMFZ3BsufRUt8mRnOG/GhsZlfjWyIbqJAORm8I/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XwJX/zHt0MybHVzWj3z21BTTgs1tqB5JDAmbGP3dLFvgRYxN1B0EFNaIc4mEz0Teu
         glLhUyykTNKQtQIYcgJtbfLAXcW3MZRgzTRAefNr50hs33vnTCzFiuLn/Z+du7iB7G
         mtEdN7cg+Fg5NMOL906TEdqcLYKC3TP9zF7PqOpg=
Date:   Wed, 26 Dec 2018 21:50:47 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Parav Pandit <parav@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] infiniband: fix a missing check of nla_put
Message-ID: <20181226195047.GJ10329@mtr-leonro.mtl.com>
References: <20181226020549.71446-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZInfyf7laFu/Kiw7"
Content-Disposition: inline
In-Reply-To: <20181226020549.71446-1-kjlu@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZInfyf7laFu/Kiw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 25, 2018 at 08:05:48PM -0600, Kangjie Lu wrote:
> nla_put() may fail. The fix adds a check for its return value, and
> returns -EMSGSIZE if it fails.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/infiniband/core/addr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

The same comment as on previous patch, lack of netlink cancel.

Thanks

>
> diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
> index 0dce94e3c495..32d033ebaa5b 100644
> --- a/drivers/infiniband/core/addr.c
> +++ b/drivers/infiniband/core/addr.c
> @@ -178,7 +178,8 @@ static int ib_nl_ip_send_msg(struct rdma_dev_addr *dev_addr,
>  	/* Construct the family header first */
>  	header = skb_put(skb, NLMSG_ALIGN(sizeof(*header)));
>  	header->ifindex = dev_addr->bound_dev_if;
> -	nla_put(skb, attrtype, size, daddr);
> +	if (nla_put(skb, attrtype, size, daddr))
> +		return -EMSGSIZE;
>
>  	/* Repair the nlmsg header length */
>  	nlmsg_end(skb, nlh);
> --
> 2.17.2 (Apple Git-113)
>

--ZInfyf7laFu/Kiw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcI9uXAAoJEORje4g2clinvZQQAK2kFeJEmwUqnAYizaDHkfoZ
F1u+4N78dylgtkzdrYS/X+/7XzpxjLAI11VMIVkCDn2PYxqQeZe71PWXsdic17Dz
bbW0E7zAOdhEveuxvLR45Y9q/LTiMX+HbkgozHmsPOjwcs3N4KIJLmMVdxUPpBjz
I8ymm/pMVzuPrwvgfv3WaKrnplpej+DNXj/I2SSsXfKMpyIFXmJXHHxBjCcMd8ER
3ROKt+u9jyRNhPDpTmdQku2xRa3lPuGv+xBPxVw3jX4PFHXWSZYxvXTLImFP4AcY
VPrKLP49MjXzDmG0opQ6hwvxym7DEDJailfzcnUk2q3dh9U6bT14R0/tnHW0GQ4a
S4rsKOEFs3W6kHP9jTwP2g/x7RVS8NLMYxUHzWBh4QKPsVVF2tKn9XnnE652Ub/Y
rU1Or/GmBuO0Y5FuJtEpgvSMIgJnnGTRfUc/wtrDqYYBoaRsYWD0GpnqokMO93+N
RlX01H8Ypg+rpJ2yAFh/wh6hhab34FUnJy6M+XfXdUFLeA4zrolJNiW2xM/N3NCs
olM5ExtFX3ctvSvo13OITAY/v403pC8p1jBOCsZhalSqNOsyxT1QKUZagixt3coa
TEa3Bels3rnsaaVMuEKv+RnBz/UA2vR2dHK/Fhs2tHbxye3faAmTdYnqmrZxrnDE
zL3Xyi6038Xkhk9kLaQt
=wnZW
-----END PGP SIGNATURE-----

--ZInfyf7laFu/Kiw7--

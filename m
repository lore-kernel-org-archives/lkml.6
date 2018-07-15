Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA5BECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 06:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A9A22089E
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 06:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="va7yj0hC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A9A22089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbeGOG0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 02:26:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbeGOG0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 02:26:01 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D41352089E;
        Sun, 15 Jul 2018 06:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531634656;
        bh=U6WZwaKW4KL2HyxhqLumFNuR0UZ9bAJCNQYasKrua50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=va7yj0hCfkuYsCdRaY/HJN7QQ+7M/z5vXs6d2/E+awocLEcq6UOQfXajLpqdI9oXv
         apWHGwlOFBHtVcnv875vBq8xCfVRFcQ8cfTB7tuIc68sCzC2cJLtVcQCYZaBlO2Rkg
         PZ59zc25dD+mWxelFi7pbX6rNnMJJ8pBGh2M0lRA=
Date:   Sun, 15 Jul 2018 09:04:13 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Or Gerlitz <gerlitz.or@gmail.com>
Cc:     Daniel Jurgens <danielj@mellanox.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>, gerald.gibson@oracle.com,
        Qing Huang <qing.huang@oracle.com>
Subject: Re: [PATCH] IB/mlx5: avoid binding a new mpi unit to the same
 devices repeatedly
Message-ID: <20180715060413.GB3152@mtr-leonro.mtl.com>
References: <20180713235021.18141-1-qing.huang@oracle.com>
 <CAJ3xEMi5zF83aA_SWfYT+JtWGGhqRhLyTKe-qYwevSBLuiK=cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <CAJ3xEMi5zF83aA_SWfYT+JtWGGhqRhLyTKe-qYwevSBLuiK=cA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 14, 2018 at 06:57:01PM +0300, Or Gerlitz wrote:
> On Sat, Jul 14, 2018 at 2:50 AM, Qing Huang <qing.huang@oracle.com> wrote:
> > When a CX5 device is configured in dual-port RoCE mode, after creating
> > many VFs against port 1, creating the same number of VFs against port 2
> > will flood kernel/syslog with something like
> > "mlx5_*:mlx5_ib_bind_slave_port:4266:(pid 5269): port 2 already
> > affiliated."
> >
> > So basically, when traversing mlx5_ib_dev_list, mlx5_ib_add_slave_port()
> > shouldn't repeatedly attempt to bind the new mpi data unit to every device
> > on the list until it finds an unbound device.
>
> Daniel,
>
> What is mpi data unit?

Or,

"mpi" is multi-port information needed for multi-port IB devices
resource sharing.

In simple words, "mpi" holds mapping information between
affiliated ports (master vs. slave) and IB device which it is connected.

Most probably, "mpi data unit" was meant "mpi struct" by Qing.

BTW, Daniel is OOO till 7-23.

Thanks

>
> Or.
>
> >
> > Reported-by: Gerald Gibson <gerald.gibson@oracle.com>
> > Signed-off-by: Qing Huang <qing.huang@oracle.com>
> > ---
> >  drivers/infiniband/hw/mlx5/main.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> > index b3ba9a2..1ddd1d3 100644
> > --- a/drivers/infiniband/hw/mlx5/main.c
> > +++ b/drivers/infiniband/hw/mlx5/main.c
> > @@ -6068,7 +6068,8 @@ static void *mlx5_ib_add_slave_port(struct mlx5_core_dev *mdev, u8 port_num)
> >
> >         mutex_lock(&mlx5_ib_multiport_mutex);
> >         list_for_each_entry(dev, &mlx5_ib_dev_list, ib_dev_list) {
> > -               if (dev->sys_image_guid == mpi->sys_image_guid)
> > +               if (dev->sys_image_guid == mpi->sys_image_guid &&
> > +                   !dev->port[mlx5_core_native_port_num(mdev) - 1].mp.mpi)
> >                         bound = mlx5_ib_bind_slave_port(dev, mpi);
> >
> >                 if (bound) {
> > --
> > 2.9.3
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbSuPdAAoJEORje4g2clinNSsP/Rt0jglILNvL/VB9eMbAGJEb
+RfVjfxIzuCQOKCGCtcGjWp4GHXcpdUQRzPiqm/NwZ7evq/jJBd9z98PKmYdGySF
JtDpuCg8xiN8dFau/rSBkWcQL9MgBBfUBi3QFs1ptdh4cQ5eaNLyZDdm/SS+3Iyw
7TYq5PTVHh2ZUHsTciUMTwMCZjoU5umPzvmliVgrEgseHqkp2fYTRYxj9nYA9lAV
yoMN82mgvVdF8kNlW2iKxC8hBMqmU6pxhfY56tszMr8laq+LGKzvWCzolBfeKcP7
jozVL4bVfMix8sjHRQ7BW9KsYVIl4kv3K2Y2E1Ma8sThRho/5s5ExkGd8L7Fvw1F
VBLM4sI6CSAn2IzqeAV5EkS86NAFjjKYivaWWUQ1B+KRetdSD5cJ27sLcB26vFpJ
0fJvzc6YLfAIosll5M7i/4q7MVbGHXZi6ladMtxs4Ysmw4VvvuHz4Z4BU/szrX8d
tWBRa6l1jpBLipP5MYZIVYEgL2C4w551vQGB5jFfQuBdJsPdLs2CI6x9OzL5Oavu
/gvsAjNN9vLzVr51CqR4YhbbCMhuIiIKbv9c+YpQ8BEYUohOdjoAMKra7pcyFepT
69/c24L07KHOzG48juX4dZExA2i8QRc5531EkpOvWMlvFgiunhRTa6Ah9vy+etUE
aYN7fryest4z2xBVtzMq
=JzvT
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--

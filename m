Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B79C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324EA24B6A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cW88tssU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 324EA24B6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933113AbeGCGVQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:21:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932767AbeGCGVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:21:14 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BE3124B6A;
        Tue,  3 Jul 2018 06:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530598874;
        bh=zDvxJKRuXStnqxpvizO5kOMOZVK5oAs/VqYGDveVPQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cW88tssUUOkqaSqu/RrgDfszwXPewg+Lc+jMovV28PrDoBuAMRRt/pYFeEDYE1Lzz
         StUbH37Fdbktkgna/3FAz30ngVPmwSSZrx+JQJ8L+YHrI3ngOjpscytqgRKI3HN1bn
         jgypA7wfQ+y4g+xxD5q6l+K+Xof7xxj3ZFxct4/8=
Date:   Tue, 3 Jul 2018 09:21:11 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Tarick Bedeir <tarick@google.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, edumazet@google.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/mlx4: Test port number before querying type.
Message-ID: <20180703062111.GC3014@mtr-leonro.mtl.com>
References: <20180702210234.107361-1-tarick@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5dNcufZ4prhark0F"
Content-Disposition: inline
In-Reply-To: <20180702210234.107361-1-tarick@google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5dNcufZ4prhark0F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 02, 2018 at 02:02:34PM -0700, Tarick Bedeir wrote:
> rdma_ah_find_type() can reach into ib_device->port_immutable with a
> potentially out-of-bounds port number, so check that the port number is
> valid first.
>
> Fixes: 44c58487d51a ("IB/core: Define 'ib' and 'roce' rdma_ah_attr types")
> Signed-off-by: Tarick Bedeir <tarick@google.com>
> ---
>  drivers/infiniband/hw/mlx4/qp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
> index f045491f2c14..4f1dabecf9a5 100644
> --- a/drivers/infiniband/hw/mlx4/qp.c
> +++ b/drivers/infiniband/hw/mlx4/qp.c
> @@ -4034,9 +4034,9 @@ static void to_rdma_ah_attr(struct mlx4_ib_dev *ibdev,
>  	u8 port_num = path->sched_queue & 0x40 ? 2 : 1;
>
>  	memset(ah_attr, 0, sizeof(*ah_attr));
> -	ah_attr->type = rdma_ah_find_type(&ibdev->ib_dev, port_num);
>  	if (port_num == 0 || port_num > dev->caps.num_ports)

Did you get any warning from any checker about out-of-bounds access?

According to the line above, port_num can be 2 or 1 which are valid ports for mlx4
and the check above doesn't do much.

>  		return;
> +	ah_attr->type = rdma_ah_find_type(&ibdev->ib_dev, port_num);
>
>  	if (ah_attr->type == RDMA_AH_ATTR_TYPE_ROCE)
>  		rdma_ah_set_sl(ah_attr, ((path->sched_queue >> 3) & 0x7) |
> --
> 2.18.0.399.gad0ab374a1-goog
>

--5dNcufZ4prhark0F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbOxXXAAoJEORje4g2clinN2MQAJtwK6k9TMWgpNCT/oqmaGSs
d9z4rXf+s5dv4nbpy8b8bdBsDnT/Z+nDOt0tMhOmcdQN6WZL4fiixLBiEn6uQ0q3
sY1zbxQrcB7l22WX4eIiGHc/kFMCx/SWqd5tCNRMS7Tt79QJ/yqcilv06MBWjDAW
Ii7wmIWDjhsz5DvXzvAhDweqGDKa4AyDI6kEflL8iGfQR+vaZ1xEVDXcXd0fF6gD
cwwecW15wi0lXi+Y3fA4766Vgapfrdbkf94DEhdbuRtMjYDiTmxizHwIpSkyLgA6
+L8guzRUU8kizUvrFnjgq54eUvM6QashIWBgUCn7of4xLndWRU6G5REFPy3YpfBw
az9MK1MufpW/s/opnoQsB9K3tF1+rZQxfL0ZTbhN5wwx+hb2YkUxrLcQZqYZvfWh
wt8LojJxvQs2pVcosxhc5Hn0gCKCMPODmZBS7Et5JZierarucCnIRiOxonHF5uky
CcovlIU2CDsYXHELCq8DJOTA095K08fNYwEuT7Ylksa3j0QKAfdUtbLYbTpAcHjz
NAa9oahiNLS/lmYFS2djQVdlE1MgXxQv6G1XJIICgTT52d1zTFoAgMBWgGalpNOJ
gQJQR8fg7G0VOc4BC7pszXjVx+uYJSV+9S+oyNdlohtz8DbiR8EFkL3wpAuAx27Z
qC/BgfnYDAXDvdtzqt/7
=Y39f
-----END PGP SIGNATURE-----

--5dNcufZ4prhark0F--

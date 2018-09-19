Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8364EC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E78F2098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="DMEihecc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E78F2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732082AbeIST14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 15:27:56 -0400
Received: from mail-eopbgr10041.outbound.protection.outlook.com ([40.107.1.41]:40434
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730876AbeIST1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 15:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nhmN6auOcjEdQC4QPI+X2tfN9rgr/JUTG9poebcN38=;
 b=DMEiheccUnDGPW69chK9GGftoLG5UTqth/m+DmUiANrk9GiXVMoHoM7h7vO5bWjoRswrIjFapzBHNh6zL/N1zk2qXp2vxzyVI7DAbCQQrdF7Jw9bNODhd8mXTxPUlZ/hnMEamdaKkoRoC87cUZDmIUeVLZM3oEOrxjGTMDWBKyo=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) by
 VI1PR0501MB2048.eurprd05.prod.outlook.com (10.167.195.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Wed, 19 Sep 2018 13:47:10 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::2851:14bb:c7f4:56ce]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::2851:14bb:c7f4:56ce%4]) with mapi id 15.20.1143.017; Wed, 19 Sep 2018
 13:47:10 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH -next] RDMA/core: Properly return the error code of
 rdma_set_src_addr_rcu
Thread-Topic: [PATCH -next] RDMA/core: Properly return the error code of
 rdma_set_src_addr_rcu
Thread-Index: AQHUUBRUMBeLC7whKEyssGk8ViIAxKT3nVEA
Date:   Wed, 19 Sep 2018 13:47:09 +0000
Message-ID: <VI1PR0501MB22718B17DA968E8B8C2A0EC3D11C0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <20180919122838.28184-1-yuehaibing@huawei.com>
In-Reply-To: <20180919122838.28184-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [68.203.16.89]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2048;6:AaLZUQAhOSj75b22XvtJvR3Pzv5YLHK0qmOsmQBWV4tJ+22S/OjpUnyclnXq3p+UtReoEcf8SLZAWKbQJEPGtzli0ifv2bbOWseXPIUKiChYiBvVFS8RNw86YnoY/D6Bb40TDoUWT/3jTlwGQo1Xqu/5cd4QLyTYFq9nRSVvQFwnQH+7kyDXsGETXReNE53HvjaSqXoRyIiPLxuv1f/97cr5GPpkMWFVUe32hcC5GN577jjNuTZ7yujYEx9x7ndjpRUgawQ0mL7xyO7RM40jfbEAdJjMYgNoXxSMochtPtfXyZ5aCL3fpGs2hOeDG7eGPrY7xzOQj0HUamukMKUbduvmxXkTZqgenFJKoKmXWGJLurTlQp9TOd/79oxXCSRqcmiSo7mi6p7tz3v3/HsChYMmLWbNtuy/C8lf1YHfB/eHXyvPERwYn/dvgGzadci9ssg6Q4/13xaY6yhE6CM7Fg==;5:kIxDtwVWn31uVGOLQ7UyrOgrcVD0AtofszWhqXtocBeMIR5npuGr1WYoJULiT6tSBnMqcuyOJm4peeZZp1/8kF1Ion+rNmc+/JX6qKz/5d7B+O2UgaIqLtijlHG2f9H3f6aC1Jz7/AFamHnAmwnfplvspk7G/BNbKwfxOBdqoBE=;7:/i2wticnWIJFkOJdyza95MRu6xEMIiY25t1+z3HrZbo5QKdslysumiBYYsuQ6ovi3Mj1+KP3iqPATw9dYFqtIzfgIX806nGPHrVrDe8LHBsum2kRCoJq4uhycZ0EgWPhhlSf5blbN62TZJ5dVoU2GgFepbmUgEZn1gvboY59ORyOLKefnl+b1FGpXltWFLGD6cGqqgInkU96DFAJQMm8yLe8VV/9EBPy/7xX1RnFwUJDY92Qgdaxb0N2oofv6uv6
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 74eb0537-00bf-482b-4b2c-08d61e366592
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2048;
x-ms-traffictypediagnostic: VI1PR0501MB2048:
x-microsoft-antispam-prvs: <VI1PR0501MB20485A25943AB5E66D029DB8D11C0@VI1PR0501MB2048.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699050);SRVR:VI1PR0501MB2048;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2048;
x-forefront-prvs: 0800C0C167
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39860400002)(396003)(136003)(189003)(13464003)(199004)(86362001)(7696005)(229853002)(105586002)(2900100001)(305945005)(81156014)(81166006)(68736007)(6636002)(6436002)(26005)(6506007)(5660300001)(53546011)(186003)(2501003)(14454004)(33656002)(2906002)(53936002)(8676002)(256004)(9686003)(7736002)(74316002)(66066001)(102836004)(97736004)(446003)(6116002)(4326008)(6246003)(486006)(55016002)(476003)(25786009)(8936002)(478600001)(5250100002)(54906003)(3846002)(99286004)(106356001)(110136005)(316002)(76176011)(11346002)(2201001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2048;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SjaOyTDiHxZdD6/pxUgs9PUcP98wgqja+1YWv6KtS1B8oQ88+oYB5HjcdXmcjOhfMyylsO7oCKcWTgfBqrtZO+UmzXeaWXaq8CRMs8Nk8up3jLLRXENRxuKjDXVrz8JIkfF78ZlrPc2SWoVhqQ9moYqiWjN5uCV4ekNqthsnl6hH2nPvKdD30NRe2g10xBm5O9imVrx9ldfbz+A5l8Z4FkI8TPYM32fJRafxvcgdz3KIpt6iJKyxw/ZxISYgLTGAEuPbjzXSILe/9BxLIIWojQZ9NF29blRzo4WAmvUxPt4fHpjIO0goy2jjcG+mn2iWhRNzIdZWvBr/c2RHVackff0aj1PFC+RJdozJ8Soaa8c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74eb0537-00bf-482b-4b2c-08d61e366592
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2018 13:47:09.8445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: YueHaibing <yuehaibing@huawei.com>
> Sent: Wednesday, September 19, 2018 7:29 AM
> To: dledford@redhat.com; jgg@ziepe.ca; leon@kernel.org; Parav Pandit
> <parav@mellanox.com>; Daniel Jurgens <danielj@mellanox.com>
> Cc: linux-kernel@vger.kernel.org; linux-rdma@vger.kernel.org; YueHaibing
> <yuehaibing@huawei.com>
> Subject: [PATCH -next] RDMA/core: Properly return the error code of
> rdma_set_src_addr_rcu
>=20
> rdma_set_src_addr_rcu should check copy_src_l2_addr fails, rather than
> always return 0. Also copy_src_l2_addr should return 'ret' as its return =
value
> while rdma_translate_ip fails.
>=20
> Fixes: c31d4b2ddf07 ("RDMA/core: Protect against changing dst->dev during
> destination resolve")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/infiniband/core/addr.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/add=
r.c
> index 7a0356c..8a31b11 100644
> --- a/drivers/infiniband/core/addr.c
> +++ b/drivers/infiniband/core/addr.c
> @@ -468,7 +468,7 @@ static int addr_resolve_neigh(const struct dst_entry
> *dst,
>  	return ret;
>  }
>=20
> -static void copy_src_l2_addr(struct rdma_dev_addr *dev_addr,
> +static int copy_src_l2_addr(struct rdma_dev_addr *dev_addr,
>  			     const struct sockaddr *dst_in,
>  			     const struct dst_entry *dst,
>  			     const struct net_device *ndev)
> @@ -492,6 +492,8 @@ static void copy_src_l2_addr(struct rdma_dev_addr
> *dev_addr,
>  						RDMA_NETWORK_IPV6;
>  	else
>  		dev_addr->network =3D RDMA_NETWORK_IB;
> +
> +	return ret;
>  }
>=20
>  static int rdma_set_src_addr_rcu(struct rdma_dev_addr *dev_addr, @@ -
> 499,6 +501,7 @@ static int rdma_set_src_addr_rcu(struct rdma_dev_addr
> *dev_addr,
>  				 const struct sockaddr *dst_in,
>  				 const struct dst_entry *dst)
>  {
> +	int ret;
>  	struct net_device *ndev =3D READ_ONCE(dst->dev);
>=20
>  	*ndev_flags =3D ndev->flags;
> @@ -515,8 +518,8 @@ static int rdma_set_src_addr_rcu(struct
> rdma_dev_addr *dev_addr,
>  			return -ENODEV;
>  	}
>=20
> -	copy_src_l2_addr(dev_addr, dst_in, dst, ndev);
> -	return 0;
> +	ret =3D copy_src_l2_addr(dev_addr, dst_in, dst, ndev);
> +	return ret;
>  }
>=20
>  static int set_addr_netns_by_gid_rcu(struct rdma_dev_addr *addr)
> --
> 2.7.0
>=20
Reviewed-by: Parav Pandit <parav@mellanox.com>

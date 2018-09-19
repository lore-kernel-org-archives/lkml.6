Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E99ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 773402150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="XJwjBvbB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 773402150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732305AbeIST5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 15:57:50 -0400
Received: from mail-eopbgr30061.outbound.protection.outlook.com ([40.107.3.61]:18496
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731230AbeIST5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 15:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRwu4OP8Cl6ursndU505xsoSEm4sRYdoZoX4xQrK2ZA=;
 b=XJwjBvbBpWA5b2yP55O8nknBWbX5kjukvDwxOeiehT8C2enCZm0ogSPkqzLqDzG6iRWhrKBvlguVDrr0B1+NixZHnHv/CD3CmGWvPDcbkym36ipIt1RonvulfVNY7l2v/Io5GbNjQs445gkUdhAbsGxaR/U4zfEsG4VDG3oPkjQ=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) by
 VI1PR0501MB2720.eurprd05.prod.outlook.com (10.172.15.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.14; Wed, 19 Sep 2018 14:19:37 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::2851:14bb:c7f4:56ce]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::2851:14bb:c7f4:56ce%4]) with mapi id 15.20.1143.017; Wed, 19 Sep 2018
 14:19:36 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Parav Pandit <parav@mellanox.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH -next] RDMA/core: Properly return the error code of
 rdma_set_src_addr_rcu
Thread-Topic: [PATCH -next] RDMA/core: Properly return the error code of
 rdma_set_src_addr_rcu
Thread-Index: AQHUUBRUMBeLC7whKEyssGk8ViIAxKT3nVEAgAAJznA=
Date:   Wed, 19 Sep 2018 14:19:36 +0000
Message-ID: <VI1PR0501MB2271C1E6857010F66064CAF6D11C0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <20180919122838.28184-1-yuehaibing@huawei.com>
 <VI1PR0501MB22718B17DA968E8B8C2A0EC3D11C0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
In-Reply-To: <VI1PR0501MB22718B17DA968E8B8C2A0EC3D11C0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [68.203.16.89]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2720;6:p07s1fbGZa9cVNS7NpeYHnR13mebdlgeFRIh5LbvKO0nV8wMWZwHW5yYVloB9E1fc7Edooc18Z0bHpSb7+qOXBR2WkYES2X/CCNkFDEZaQ/fOqH+J41ASh1RFieZqYZrBet1u/Qyx2m3uocoysENv8MN7DLZiaQxq81F7ecDv5ivis1ptMlFwQyqz4+RDLvBofsvAtSnOYfhtF08lFbsLJ8Bb0Ue+vZnQeiasUDxjDXduXsF6A3a2pg4MKdpWiFAn4HdC5ydhFMZEpT3MGovnNfwusB0NUOQ3AQvShTPqZnz9fg9aLd8cXIgfxIjUFnFzDYQoeG+PMERMKTEjWfRr7xlPEbe4+UrbQTZvLxPfuKDE3IgfjwvkNbg6x3isx81N/NycFC6O04Ryp66Af1psUcIi7bHaNU69DFwrEMPNr9pZsPGJC8WEE/8Uee3kGtb5K/ZeVrwokgyd7IuHOB/iQ==;5:HLqMWxvR6ln2baEV5c6l46wduEPPzsLd5uLeHw7KNWDtXiQESnWc7GkdemQ7Jl6mz4EqXLmYydheLwCPRbzh2OgZbBIIreBwfZ6vuvJ1x38gDDVRrbqyUQJRdLxTVXS2Y7qObsRBpGfspwjV9i6ilUaAQMhbh45JTu/Yhpfp7Vo=;7:/dhwqzHbhdqjrld9EVhmPLMgNW6EqB7lZmETnf6ZyjnCelnTn0SdXYVwNhEV+31S8iP4mRf75YTtRLTYX9KxjAJIozyJfoZ2Joh0q9L701XVTkH7QulTOT1RUQzcLWiwG/hfqjefUe0T5eAU3tS9oAG51u9fd2J8mHmIzVlyM1KfGsdBUuJw49mep5MuZzoYu7ogvpeoUfAZk0RWn3QT0WekMrT1+QAr3O8tnYbMmreYJHzj79QfM3FWEvkRTsFw
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7aaedb75-2fd3-42e7-8036-08d61e3aee08
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2720;
x-ms-traffictypediagnostic: VI1PR0501MB2720:
x-microsoft-antispam-prvs: <VI1PR0501MB272016BD646550793CAE0AF7D11C0@VI1PR0501MB2720.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:VI1PR0501MB2720;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2720;
x-forefront-prvs: 0800C0C167
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(366004)(39860400002)(396003)(13464003)(199004)(189003)(478600001)(446003)(97736004)(54906003)(7736002)(2201001)(305945005)(81156014)(110136005)(229853002)(74316002)(316002)(9686003)(68736007)(8936002)(6246003)(2940100002)(6436002)(55016002)(8676002)(256004)(81166006)(4326008)(106356001)(66066001)(53546011)(93156006)(102836004)(5660300001)(5250100002)(105586002)(2501003)(99286004)(76176011)(6506007)(6636002)(33656002)(6116002)(7696005)(53936002)(11346002)(2900100001)(486006)(476003)(3846002)(26005)(2906002)(14454004)(25786009)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2720;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 295lJjLIAO1194/J0yTpVvZLjwJP3X1L5b8Xmhu4FgGstS0Y3RHl6T4FV63mxg6Q5ogVgqX/NIXfqtijNriFbItdUYJqPkKpgfs+t7F3aoz/lYI/jM0HbOe1NvnTuSvT9/Dh7cLgmuun7Y/29sooiqUGHrz9rKZgwoJ9LwctAlwuYqqU9MGEXRL54MwV1PhNLdTzQXGGIIv3iLCYcjnOxMzQqYHTBpJnBE0RXYLkYQzLGw9j2W8XYTG7akgGEcDRF1zvhECfA6g4ucem55tMziu2Mak3OXHFfwlyVUMIBLUuwyESixctiIgUx7MvgmOwaudfqFlzf07ZQO1BGwC58uMYmeN3kqO3OwHNik6Rq2w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aaedb75-2fd3-42e7-8036-08d61e3aee08
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2018 14:19:36.8693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2720
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi YueHaibing,

> -----Original Message-----
> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Parav Pandit
> Sent: Wednesday, September 19, 2018 8:47 AM
> To: YueHaibing <yuehaibing@huawei.com>; dledford@redhat.com;
> jgg@ziepe.ca; leon@kernel.org; Daniel Jurgens <danielj@mellanox.com>
> Cc: linux-kernel@vger.kernel.org; linux-rdma@vger.kernel.org
> Subject: RE: [PATCH -next] RDMA/core: Properly return the error code of
> rdma_set_src_addr_rcu
>=20
>=20
>=20
> > -----Original Message-----
> > From: YueHaibing <yuehaibing@huawei.com>
> > Sent: Wednesday, September 19, 2018 7:29 AM
> > To: dledford@redhat.com; jgg@ziepe.ca; leon@kernel.org; Parav Pandit
> > <parav@mellanox.com>; Daniel Jurgens <danielj@mellanox.com>
> > Cc: linux-kernel@vger.kernel.org; linux-rdma@vger.kernel.org;
> > YueHaibing <yuehaibing@huawei.com>
> > Subject: [PATCH -next] RDMA/core: Properly return the error code of
> > rdma_set_src_addr_rcu
> >
> > rdma_set_src_addr_rcu should check copy_src_l2_addr fails, rather than
> > always return 0. Also copy_src_l2_addr should return 'ret' as its
> > return value while rdma_translate_ip fails.
> >
> > Fixes: c31d4b2ddf07 ("RDMA/core: Protect against changing dst->dev
> > during destination resolve")
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >  drivers/infiniband/core/addr.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/addr.c
> > b/drivers/infiniband/core/addr.c index 7a0356c..8a31b11 100644
> > --- a/drivers/infiniband/core/addr.c
> > +++ b/drivers/infiniband/core/addr.c
> > @@ -468,7 +468,7 @@ static int addr_resolve_neigh(const struct
> > dst_entry *dst,
> >  	return ret;
> >  }
> >
> > -static void copy_src_l2_addr(struct rdma_dev_addr *dev_addr,
> > +static int copy_src_l2_addr(struct rdma_dev_addr *dev_addr,
> >  			     const struct sockaddr *dst_in,
> >  			     const struct dst_entry *dst,
> >  			     const struct net_device *ndev) @@ -492,6 +492,8
> @@ static
> > void copy_src_l2_addr(struct rdma_dev_addr *dev_addr,
> >  						RDMA_NETWORK_IPV6;
> >  	else
> >  		dev_addr->network =3D RDMA_NETWORK_IB;
> > +
> > +	return ret;
> >  }
> >
> >  static int rdma_set_src_addr_rcu(struct rdma_dev_addr *dev_addr, @@ -
> > 499,6 +501,7 @@ static int rdma_set_src_addr_rcu(struct rdma_dev_addr
> > *dev_addr,
> >  				 const struct sockaddr *dst_in,
> >  				 const struct dst_entry *dst)
> >  {
> > +	int ret;
> >  	struct net_device *ndev =3D READ_ONCE(dst->dev);
> >
> >  	*ndev_flags =3D ndev->flags;
> > @@ -515,8 +518,8 @@ static int rdma_set_src_addr_rcu(struct
> > rdma_dev_addr *dev_addr,
> >  			return -ENODEV;
> >  	}
> >
> > -	copy_src_l2_addr(dev_addr, dst_in, dst, ndev);
> > -	return 0;
> > +	ret =3D copy_src_l2_addr(dev_addr, dst_in, dst, ndev);
> > +	return ret;
> >  }
> >
> >  static int set_addr_netns_by_gid_rcu(struct rdma_dev_addr *addr)
> > --
> > 2.7.0
> >
> Reviewed-by: Parav Pandit <parav@mellanox.com>

Can you please correct the alignment for copy_src_l2_addr() with this chang=
e from void to int for rest of the function arguments.


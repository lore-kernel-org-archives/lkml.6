Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACA5C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 03:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC152098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 03:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="D4G1+l/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC152098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbeJDKZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 06:25:28 -0400
Received: from mail-eopbgr20074.outbound.protection.outlook.com ([40.107.2.74]:38709
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726279AbeJDKZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 06:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TxHvS1pdYhgUTIUhWaBotwUn0/bzAjzJFRQ7eOEGUE=;
 b=D4G1+l/XPDkLqh3ebKLllB9Sjvq/+fVumE2lGt6l1jeXl4I50J4H3bzVJfFGxgKSUhcxCl4gnGiEoqIJpqRsh2Nb0ZDaeFyKZv19kI5aFZPS4rcP/RINDQt0UrwerGVXh6s8sx9g9jH+8P6IKbBIEcv4ZJuGCqRPAGnTcdgDj7Q=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) by
 VI1PR0501MB2415.eurprd05.prod.outlook.com (10.168.135.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.18; Thu, 4 Oct 2018 03:34:13 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::e4c2:d0a4:ae7c:7d29]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::e4c2:d0a4:ae7c:7d29%10]) with mapi id 15.20.1185.026; Thu, 4 Oct 2018
 03:34:13 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "leon@kernel.org" <leon@kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>
Subject: RE: [PATCHv1] RDMA/core: Check error status of
 rdma_find_ndev_for_src_ip_rcu
Thread-Topic: [PATCHv1] RDMA/core: Check error status of
 rdma_find_ndev_for_src_ip_rcu
Thread-Index: AQHUUbv0He77yOgtWky+XYLnap0KHKUOb/YQgAAF8wCAAAx2YA==
Date:   Thu, 4 Oct 2018 03:34:12 +0000
Message-ID: <VI1PR0501MB2271E20E0F47CB4D00738DC6D1EA0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <1537542022-4451-1-git-send-email-parav@mellanox.com>
 <VI1PR0501MB2271905AAC309C636C0B63B7D1EA0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <20181004024812.GA18596@ziepe.ca>
In-Reply-To: <20181004024812.GA18596@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [107.77.217.183]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2415;6:ytUTVhMe7N+AsJZ0ginNFx89ChKAHQDGhkGbQAzzB/qffHp5TaB6S+uWydte9NIdz3e+R9/eI+x+8BniGQa2QBNG2y0b0mj9Imh4M2TkARMQrV8wiziR7R+47ggzuQOjbdDo+3QBuNs+8x/sKP7Vpe72hix+fpKR4zr/YwmREIQdm+0ChG9WXDLEsOeyYmBy1UUMtE20/JnLYD5Ys4h5dTgzNEhmC6M556M7+S055GLqdzWW2YlS3I9npo1Z0xWF4zz71bJhItDOyelts1kCp6SFH7Jlb7XRdt+wsduGJ758khsB25tKa5AIQv7SdqMx2CyZ3h/NhuTX4zbHMjwh50ZEEZWrttLrxmb60dyd7mcgKD3oi0aKuRLC+wQDDjhQSGUQ5uuiBO68Epmuh3JepRRcqMvrQUP+vMlB7kb91Wc13jiTrZAJMx8iVheNWK4pRd+hoyWkaAtm8tD7qpiezg==;5:LWTW+YmplNv45X+MOVMaxVXhgotN16/FwuwMAZ6fsdLBxeMWo78TEkNw8Sa55lI+mwGoQFaFM73X2vA5W18ca4BAXtmVf/Ocw05wd0EbCkE5XZ+qvbsgE54w8Ltr6sUL6CFFVd5ZPeZv4Jzi895DwgLd7zVsqgxAXvAwHLmdcdA=;7:hrSwIpXYDoLCKuFbeoEDWMU2EI7kC8nqlP94XTUO1cbw6FWLzCKVDD+3D3/llFrmT7KgZQarzFEZl6tqGWM1vBvk8r9syh9zazjRaPUVZzr635EkNCOMQO1DPUJEkZBoyZ7aM/GyWi77FWoHIqjwUyEGra6JMpDlDis0NnRKqkpGRxZwWBo5YM/G8jcnhVanFaR27zNlIxtOdWvoqMwBqqvePxTNHxCytaXO9sk1XZcjclFbAztT5Pf7WCFNfi0y
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a608d7ce-4778-44ca-9a18-08d629aa4100
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2415;
x-ms-traffictypediagnostic: VI1PR0501MB2415:
x-microsoft-antispam-prvs: <VI1PR0501MB24157DCB1D8EC50211BB640CD1EA0@VI1PR0501MB2415.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(215639381216008);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051);SRVR:VI1PR0501MB2415;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2415;
x-forefront-prvs: 0815F8251E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(396003)(376002)(346002)(13464003)(199004)(189003)(256004)(6506007)(8936002)(97736004)(33656002)(5660300001)(68736007)(6916009)(81166006)(81156014)(8676002)(476003)(102836004)(486006)(99286004)(25786009)(7696005)(66066001)(86362001)(53546011)(74316002)(7736002)(76176011)(305945005)(54906003)(446003)(26005)(186003)(11346002)(2906002)(478600001)(3846002)(6116002)(316002)(53936002)(9686003)(2900100001)(14454004)(229853002)(71200400001)(71190400001)(5250100002)(4326008)(105586002)(106356001)(6246003)(55016002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2415;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hDA7Fy0KiuAYsNin8hHEj367laXDTOi0ulna8V5X7+LBdfbJ2aZRqFRc0odI/D3IhgCeNwlGt4eANXvh4fOI4hTN4ovM4oaDOLXH4FPSeN5eiC94mA9gYAZjqvAfjGLnYvUjqqfxDTaHgNUua3X/GVZEl9DoIqawtLkqaVNUV+J61MuhT6wnMuIj5qi83QU001lCma5GaltBATIx1mnhRtRITWFsaB/OHtGEeORY4gWMa7Xijpqt4vlIqN6s96Uu3hatY0h6KysFb6FoKm8ddsGJ2PZ1og0Q7h6L8aYdorZgKRMA4o1F52RgqIFoREYUITZ2dK6kX0AqSTElwjp5nlY4lfaZiF5m6PKxdvClbUQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a608d7ce-4778-44ca-9a18-08d629aa4100
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 03:34:13.0100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2415
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Jason Gunthorpe
> Sent: Wednesday, October 3, 2018 9:48 PM
> To: Parav Pandit <parav@mellanox.com>
> Cc: linux-rdma@vger.kernel.org; linux-kernel@vger.kernel.org;
> leon@kernel.org; Daniel Jurgens <danielj@mellanox.com>;
> dledford@redhat.com
> Subject: Re: [PATCHv1] RDMA/core: Check error status of
> rdma_find_ndev_for_src_ip_rcu
>=20
> On Thu, Oct 04, 2018 at 02:28:54AM +0000, Parav Pandit wrote:
> > Hi Doug, Jason,
> >
> > > From: Parav Pandit <parav@mellanox.com>
> > > Sent: Friday, September 21, 2018 10:00 AM
> > > To: linux-rdma@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > leon@kernel.org; jgg@ziepe.ca; syzkaller-bugs@googlegroups.com;
> > > Daniel Jurgens <danielj@mellanox.com>; dledford@redhat.com
> > > Cc: Parav Pandit <parav@mellanox.com>
> > > Subject: [PATCHv1] RDMA/core: Check error status of
> > > rdma_find_ndev_for_src_ip_rcu
> > >
> > > rdma_find_ndev_for_src_ip_rcu() returns either valid netdev pointer
> > > or ERR_PTR().
> > > Instead of checking for NULL, check for error.
> > >
> > > Fixes: caf1e3ae9fa6 ("RDMA/core Introduce and use
> > > rdma_find_ndev_for_src_ip_rcu")
> > > Reported-by: syzbot+20c32fa6ff84a2d28c36@syzkaller.appspotmail.com
> > > Signed-off-by: Parav Pandit <parav@mellanox.com>
> > > drivers/infiniband/core/addr.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/core/addr.c
> > > b/drivers/infiniband/core/addr.c index c2ca9e4..3c07eeb 100644
> > > +++ b/drivers/infiniband/core/addr.c
> > > @@ -513,8 +513,8 @@ static int rdma_set_src_addr_rcu(struct
> > > rdma_dev_addr *dev_addr,
> > >  		 * loopback IP address.
> > >  		 */
> > >  		ndev =3D rdma_find_ndev_for_src_ip_rcu(dev_net(ndev),
> > > dst_in);
> > > -		if (!ndev)
> > > -			return -ENODEV;
> > > +		if (IS_ERR(ndev))
> > > +			return PTR_ERR(ndev);
> > >  	}
> > >
> > >  	return copy_src_l2_addr(dev_addr, dst_in, dst, ndev);
> >
> > Can you please review this fix?  I got below report from syzbot that
> > it tested the patch and reproducer didn't trigger.
>=20
> It is very strange, but this patch does not show up in rdma's patch works=
.
>=20
> This happened to Dennis as well for one patch, I'm afraid as a general ru=
le,
> people will need to check that patchworks has thier patches, and maybe ta=
lk
> to LF IT about why things have gone missing.
>=20
> I would guess it is some spam filter issue?
Not sure, may be something wrong in my mail client configuration.
Most patches are through Leon so I will continue it that way for now.

>=20
> I have applied this patch from my email.
Thanks a lot.

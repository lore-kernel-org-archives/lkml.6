Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756F6C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90F7208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="L0CufUog"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E90F7208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388827AbeG0ReB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 13:34:01 -0400
Received: from mail-eopbgr30064.outbound.protection.outlook.com ([40.107.3.64]:13392
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388614AbeG0ReB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 13:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83AAJY4sDR4Lm+Hg6Q9MMF4YgCXvH8npg6iM6+Tehlc=;
 b=L0CufUogiA6VUIL/oJL1mrelaI+64sd2EvyiH+BWeAUNtpCoQUUiQVjYqeO7t8zF1J8Os9UoAskVy12qEq8+ftvZahQTd9lpKoHcArwt4Cq53gbGwKVP1e7PyX0rIYTctKWpyBzmxRocu0H/hwjj0TaDFC7EWn+bWjwFbVlSUg0=
Received: from VI1PR0502MB3008.eurprd05.prod.outlook.com (10.175.21.22) by
 VI1PR0502MB3711.eurprd05.prod.outlook.com (52.134.8.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Fri, 27 Jul 2018 16:11:21 +0000
Received: from VI1PR0502MB3008.eurprd05.prod.outlook.com
 ([fe80::743f:c0ff:da0c:8786]) by VI1PR0502MB3008.eurprd05.prod.outlook.com
 ([fe80::743f:c0ff:da0c:8786%7]) with mapi id 15.20.0995.019; Fri, 27 Jul 2018
 16:11:21 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: RE: [PATCH rdma] IB/cache: Restore compatibility for ib_query_gid
Thread-Topic: [PATCH rdma] IB/cache: Restore compatibility for ib_query_gid
Thread-Index: AQHUJcIPCAEQUI0qvk+qMYqSwf1nDqSjOscAgAAB+wCAAABUIA==
Date:   Fri, 27 Jul 2018 16:11:20 +0000
Message-ID: <VI1PR0502MB3008B2E503A83C20E00C0451D12A0@VI1PR0502MB3008.eurprd05.prod.outlook.com>
References: <20180727155402.GA15253@ziepe.ca>
 <VI1PR0502MB3008B0D78AB418E263819EE7D12A0@VI1PR0502MB3008.eurprd05.prod.outlook.com>
 <20180727160904.GE9497@ziepe.ca>
In-Reply-To: <20180727160904.GE9497@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0502MB3711;6:+O7ZGOqzS/OtGdr0hRQCgqe+zCVT9XXsT867xb1BMEpQpwHD5zDLdd/4kPi0C+j42LDmVMjdGmTB55TqvAnSah0LKPiphRd0TZ4L/E475TqLUHMyJgGKRWbLWcsgZcB9Mjyf89mADCEDZzBoiH4Vsp1IcQoPhNuP9NWSWCq4u+JY+amiWOZDXfdjp4F/m3XSkIcusYnjiskqHO2uIsD6GM11nGi/v0MVWGSraiLPFPSoB2dnhLCYPEzqnbSfjzbJvDoY9MFDfdPZjp+TOrN9QkCXSiY52PF9XPE4oTsRQpbYCV8kJv1CYM8ZedBDmqofoJenuqe0UW+wYZXxRtFlEkqUJWJaSqAFWra5W95HxaD9l/53WRJXvmvxA/YQrllD3/DUK73ngLfCdlSi2L+Ei75dxgrmAV0tsPZw1jL9PMHwj7wI/0YwR9n/yl1rTEv3s+G5dvpEeX2/qrZSXvSJ/Q==;5:4SDdflXQ1/dZRDxnh1sRByJ6oX01yqRbifuT/8J0EGyttYvUFThlqTrtaC2tJgsDWPYBY3sFnlRqURQv2vk2sg3VG5nHxecEtke3OfVtfTvZdIjGxy5Zdnjtt3NqgL0Jh65YEyHO+6tI3JPOGXHZkyRpy6e6G+qdtTLFKL0RnJE=;7:TfFkHYsDhZfSovESz8NPM5dQF0ZFj83WmFxQYvRAW2fNhR/c+rZ833j5E1Wn7oEwy7GeDafbPP4IaG1f6OkFpshH9IjC2JSoALPMqao1tPKCoL0QuOS/b/2OI73++Y0qf62VV8aMKUZ5fVTpNS0ChWd4AGH4aAVB+pX8hfLeTjuUWVhoDiwKnKTNcoJYJANoZPoZSm2TqE+uCrGr6akaYTvlo77XUO45THQ2oxcejGgqyLb9hBZw4q7AqANSGRzb
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 283a9d8e-d176-4cde-14da-08d5f3db97b9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0502MB3711;
x-ms-traffictypediagnostic: VI1PR0502MB3711:
x-microsoft-antispam-prvs: <VI1PR0502MB3711BDDCABB9687F4AF7B70CD12A0@VI1PR0502MB3711.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(84791874153150)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0502MB3711;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0502MB3711;
x-forefront-prvs: 07467C4D33
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(346002)(376002)(396003)(13464003)(189003)(199004)(966005)(486006)(86362001)(476003)(8936002)(478600001)(5660300001)(14454004)(446003)(11346002)(25786009)(5250100002)(9686003)(107886003)(4326008)(68736007)(53936002)(6436002)(6246003)(6306002)(2900100001)(6916009)(55016002)(7696005)(6506007)(106356001)(105586002)(26005)(7736002)(33656002)(53546011)(186003)(81156014)(2906002)(81166006)(14444005)(99286004)(8676002)(3846002)(97736004)(305945005)(256004)(66066001)(229853002)(6116002)(54906003)(74316002)(102836004)(76176011)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB3711;H:VI1PR0502MB3008.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uJx90vqypq1fdOm9TMhv59xAzZdjNUBGPG921kjEwSddayc08H0xMEF/Zqv6zNfCKLhAYpD3hqsNnSazzHrQMUyY7WZ/d+Gdp3ZFzPB1gmmvcCG/0xDTCrSVW4a9YXXfSoLbTD88sZ0ZKT69acPs3eJaawaeN6KS9OhixdGg+IIDCCQ9DxdeJ4hiy6rWrZemQlT68AgfRRZltg3u809V9zXVdDRcE7JVr2oM5NDP88XxW/Yj8nJg+I+VenupwK1qBo0c6z8pl484pd4d+syJGfcqwM8RSoBbANppIyP1Zg8rhMrxi1Wx0tkjwqE/iA9nnsK+mwsPQ0fR9keSizSovwqrsA5lrB4t01s5Xhw9dxo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 283a9d8e-d176-4cde-14da-08d5f3db97b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2018 16:11:21.0118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Friday, July 27, 2018 11:09 AM
> To: Parav Pandit <parav@mellanox.com>
> Cc: linux-rdma@vger.kernel.org; Stephen Rothwell <sfr@canb.auug.org.au>;
> David Miller <davem@davemloft.net>; Networking <netdev@vger.kernel.org>;
> Doug Ledford <dledford@redhat.com>; Linux-Next Mailing List <linux-
> next@vger.kernel.org>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; Ursula Braun <ubraun@linux.ibm.com>; Leon
> Romanovsky <leonro@mellanox.com>
> Subject: Re: [PATCH rdma] IB/cache: Restore compatibility for ib_query_gi=
d
>=20
> On Fri, Jul 27, 2018 at 04:04:33PM +0000, Parav Pandit wrote:
> >
> >
> > > From: Jason Gunthorpe
> > > Sent: Friday, July 27, 2018 10:54 AM
> > > To: linux-rdma@vger.kernel.org; Stephen Rothwell
> > > <sfr@canb.auug.org.au>
> > > Cc: David Miller <davem@davemloft.net>; Networking
> > > <netdev@vger.kernel.org>; Doug Ledford <dledford@redhat.com>;
> > > Linux-Next Mailing List <linux-next@vger.kernel.org>; Linux Kernel
> > > Mailing List <linux- kernel@vger.kernel.org>; Parav Pandit
> > > <parav@mellanox.com>; Ursula Braun <ubraun@linux.ibm.com>; Leon
> > > Romanovsky <leonro@mellanox.com>; linux- rdma@vger.kernel.org
> > > Subject: [PATCH rdma] IB/cache: Restore compatibility for
> > > ib_query_gid
> > >
> > > Code changes in smc have become so complicated this cycle that the
> > > RDMA patches to remove ib_query_gid in smc create too complex merge
> conflicts.
> > > Allow those conflicts to be resolved by using the net/smc hunks by
> > > providing a compatibility wrapper. During the second phase of the
> > > merge window this wrapper will be deleted and smc updated to use the =
new
> API.
> > >
> > > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> > > include/rdma/ib_cache.h | 24 ++++++++++++++++++++++++
> > >  1 file changed, 24 insertions(+)
> > >
> > > The resolution Stephen had to make is too complicated, I think we
> > > should go this way instead. Parav can send a patch to DaveM during
> > > the 2nd half of the merge window to safely update SMC and delete this
> wrapper.
> > >
> > Last night Stephen send the changes, if Ursula can test it, its
> > preferred but if that is not possible, I am with below approach too.
>=20
> Thing is one of us has to explain to Linus how to handle this conflict, a=
s
> Stephen's resolutions do not automatically go him.
>=20
> Given how much new code the resolution introduces, I prefer to not send i=
t to
> Linus..
>=20
Ok. Sounds good.

> > > Parav, can you check this?
> > >
> > > Ursula, this is only for SMC, are you able to test SMC with it? You
> > > will need to apply it to the RDMA tree here:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h
> > > =3Dfor-next
> > >
> > > Thanks,
> > > Jason
> > >
> > > diff --git a/include/rdma/ib_cache.h b/include/rdma/ib_cache.h index
> > > 1108d422027696..c7e9b42b96e5b8 100644
> > > +++ b/include/rdma/ib_cache.h
> > > @@ -132,4 +132,28 @@ const struct ib_gid_attr
> > > *rdma_get_gid_attr(struct ib_device *device,
> > >  					    u8 port_num, int index);
> > >  void rdma_put_gid_attr(const struct ib_gid_attr *attr);  void
> > > rdma_hold_gid_attr(const struct ib_gid_attr *attr);
> > > +
> > > +/*
> > > + * This is to be removed. It only exists to make merging rdma and sm=
c
> simpler.
> > > + */
> > > +static inline __deprecated int ib_query_gid(struct ib_device *device=
,
> > > +					    u8 port_num, int index,
> > > +					    union ib_gid *gid,
> > > +					    struct ib_gid_attr *attr_out) {
> > > +	const struct ib_gid_attr *attr;
> > > +
> > > +	attr =3D rdma_get_gid_attr(device,port_num,index);
> > White space after each variable is needed to avoid warnings.
>=20
> Woops, no problem.
>=20
> > > +	if (IS_ERR(attr))
> > > +		return PTR_ERR(attr);
> > > +
> > > +	if (attr->ndev)
> > > +		dev_hold(attr->ndev);
> > > +	*attr_out =3D *attr;
> > > +
> > > +	rdma_put_gid_attr(attr);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  #endif /* _IB_CACHE_H */
> >
> > Rest looks fine.
> > RB: parav@mellanox.com
>=20
> In future please spell out the Reviewed-by - patchworks will automate col=
lecting
> the tags and add it to the patch, otherwise maintainers have to do it by =
hand.
>=20
I see. I will do it correctly now on using Reviewed-by.

> Thanks,
> Jason

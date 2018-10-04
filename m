Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EACC00449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 02:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C60520856
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 02:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="E5yek9Ox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C60520856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbeJDJUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 05:20:03 -0400
Received: from mail-eopbgr20047.outbound.protection.outlook.com ([40.107.2.47]:18512
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726277AbeJDJUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 05:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aszaQJVEdvHV4WLEmT2ZSv7sTuhBvYMe+Zltv69qmw8=;
 b=E5yek9OxTthsaSKTqqow80EXd6okr3Q6BpFD+B86CfhFJ7PfYocvBgIUYcbmYZ1h9/7o6Imtg+JNAORGgjfPUExXTPIEpxvOiaVYDfhq9g6WXa0KUdRSgQ/jOfwXM+wXA6m01lEV51LlY7364t5ETjPksuJHgmAWbRFpeqKidrw=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) by
 VI1PR0501MB2446.eurprd05.prod.outlook.com (10.168.136.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.22; Thu, 4 Oct 2018 02:28:54 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::e4c2:d0a4:ae7c:7d29]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::e4c2:d0a4:ae7c:7d29%10]) with mapi id 15.20.1185.026; Thu, 4 Oct 2018
 02:28:54 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Parav Pandit <parav@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "leon@kernel.org" <leon@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>
Subject: RE: [PATCHv1] RDMA/core: Check error status of
 rdma_find_ndev_for_src_ip_rcu
Thread-Topic: [PATCHv1] RDMA/core: Check error status of
 rdma_find_ndev_for_src_ip_rcu
Thread-Index: AQHUUbv0He77yOgtWky+XYLnap0KHKUOb/YQ
Date:   Thu, 4 Oct 2018 02:28:54 +0000
Message-ID: <VI1PR0501MB2271905AAC309C636C0B63B7D1EA0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <1537542022-4451-1-git-send-email-parav@mellanox.com>
In-Reply-To: <1537542022-4451-1-git-send-email-parav@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [107.77.217.183]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2446;6:1okqJ3QOYbpMxRnLI5GI+hSnJPqM4C4+XCUfHrs5wY6rnYWJ/i4M7DBlk/7IwiIIbk/SAe5CN+E4VfqtSAdLTK5uoSPfuoRo7/T2BjTvn4zwBUMWIkajxjNa4Q9HGxA/LKBCv5KzJJPUpY1B5reZ61eIN4MoLjQYHYtmBJZmLVoHygXOOZ8Z7GLxdc6BS73SWZoTX4vIL+OqubsLe0dwv9yHFFk2A5Vcdutd7P3Qj5FrtNKSYiu46al2NiloWvp3AGMKT/JbJU7/jSNBr5DzVh1JTjYSjK17s+sHtit5aYktabTypii8ag9NlToGqhpVKTJ7VvRXno6fKSiR6jHj21EBy+jkEltWNRgA0JazgD8ayTtT5/zxbp1SQ9omylnR0dUGlakBX6TJAqsnQun4FoCzJi2IDQkWuTSVie31AZQDVYrjVjFwTg+SaPPS2lrBp7Yb2+3Np7ct9JbVdilZ4A==;5:RjcXF9q1J4huz/N76fUoP86oHB5bDh3Po9VFfloL5sgz8aC/J3PBVTTIv4zqSTDtZqK8DnJhbNVTA2gHv6D19n4yqBlm7c55g10oGVl6Teu9CAPe5HSEBJvwF9TP8EmtZLgLsC3b9i7OyeTRVHS0WMKIUGNXj4qOT1WMndhvjR4=;7:ePJ8SI2KW0jDR83Op6JI8MuclE+8dXrYBv5T0+mA288Eb4vIHtn9qsPAZ1gFOcK274P2RuRuiIFhBxHBNbonElLev30gHck2Wbr4AzVfIG7WHBIvOxf9Eo44iatyKLU2ejszC5pk8KqSo10+Pz79OfKjBRcFAZZSTJdZ4W/Wr0MIs623r1x5Yb8NlOXbqM9jOUQUceFvaGxDbMshTXd/nrfCv0N3LGIaaFevFNNHMmpFSybtW328nLE4XMT9veSO
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 679da5e7-d5b4-4c14-8007-08d629a1217c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2446;
x-ms-traffictypediagnostic: VI1PR0501MB2446:
x-microsoft-antispam-prvs: <VI1PR0501MB24467209C762EC6B040D22F8D1EA0@VI1PR0501MB2446.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(215639381216008)(84791874153150)(45079756050767)(189930954265078);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR0501MB2446;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2446;
x-forefront-prvs: 0815F8251E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(39860400002)(136003)(396003)(199004)(189003)(13464003)(25786009)(26005)(305945005)(476003)(7736002)(11346002)(74316002)(186003)(45080400002)(102836004)(446003)(2906002)(478600001)(486006)(81166006)(110136005)(68736007)(2900100001)(2501003)(5250100002)(6436002)(2201001)(66066001)(8676002)(316002)(81156014)(8936002)(105586002)(966005)(106356001)(229853002)(71200400001)(71190400001)(76176011)(33656002)(14454004)(7696005)(6306002)(9686003)(53936002)(6246003)(6116002)(3846002)(6506007)(53546011)(256004)(97736004)(86362001)(575784001)(5660300001)(99286004)(55016002)(99710200001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2446;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 81C4ADX151bKj0wSPmJLuiSaS3Lcpk4NmnLsGSbkvGU0fjwswdCXM521pYgwSe9rtsBGtF8SR0euBfLoaRf9+g+xm+EI7tPGH18L5gVQ71XDLrhmXPk5Z3txtq+jnGObHRKaMikwEtNuKIDlPfjX6nYnHOLx4s3EHvGRyCScG6ixu/WZRs11JZZdlPSetrto56xrRxEGNV9JVqS/dKZAc2lcJB/G6OqCwI7h+SukbN6n58QUMQbDAdGLRbaUr7uZVsAA183At8M1JNUnApw1UPcfmmW4Eo7Nl+yQV75jJPzbGug9JpVRGoY+3PWzqJAZOn8cautW2I7HmvmHizFG0FwNBrNBFlNWfBvVBla/62Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 679da5e7-d5b4-4c14-8007-08d629a1217c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 02:28:54.6453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2446
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug, Jason,

> -----Original Message-----
> From: Parav Pandit <parav@mellanox.com>
> Sent: Friday, September 21, 2018 10:00 AM
> To: linux-rdma@vger.kernel.org; linux-kernel@vger.kernel.org;
> leon@kernel.org; jgg@ziepe.ca; syzkaller-bugs@googlegroups.com; Daniel
> Jurgens <danielj@mellanox.com>; dledford@redhat.com
> Cc: Parav Pandit <parav@mellanox.com>
> Subject: [PATCHv1] RDMA/core: Check error status of
> rdma_find_ndev_for_src_ip_rcu
>=20
> rdma_find_ndev_for_src_ip_rcu() returns either valid netdev pointer or
> ERR_PTR().
> Instead of checking for NULL, check for error.
>=20
> Fixes: caf1e3ae9fa6 ("RDMA/core Introduce and use
> rdma_find_ndev_for_src_ip_rcu")
> Reported-by: syzbot+20c32fa6ff84a2d28c36@syzkaller.appspotmail.com
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> ---
>  drivers/infiniband/core/addr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/add=
r.c
> index c2ca9e4..3c07eeb 100644
> --- a/drivers/infiniband/core/addr.c
> +++ b/drivers/infiniband/core/addr.c
> @@ -513,8 +513,8 @@ static int rdma_set_src_addr_rcu(struct
> rdma_dev_addr *dev_addr,
>  		 * loopback IP address.
>  		 */
>  		ndev =3D rdma_find_ndev_for_src_ip_rcu(dev_net(ndev),
> dst_in);
> -		if (!ndev)
> -			return -ENODEV;
> +		if (IS_ERR(ndev))
> +			return PTR_ERR(ndev);
>  	}
>=20
>  	return copy_src_l2_addr(dev_addr, dst_in, dst, ndev);
> --
> 1.8.3.1

Can you please review this fix?
I got below report from syzbot that it tested the patch and reproducer didn=
't trigger.

Report:

syzbot has tested the proposed patch and the reproducer did not trigger =20
crash:

Reported-and-tested-by: =20
syzbot+20c32fa6ff84a2d28c36@syzkaller.appspotmail.com

Tested on:

commit:         41ab1cb7d1cd RDMA/cma: Introduce and use cma_ib_acquire_de.=
.
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git=
 =20
for-next
kernel config:  https://emea01.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Fsyzkaller.appspot.com%2Fx%2F.config%3Fx%3D112cc1aec8b19ba4&amp;da=
ta=3D02%7C01%7Cparav%40mellanox.com%7Ce0a5662bb6aa4fdee43508d6298c9e60%7Ca6=
52971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C636742081267605003&amp;sdata=3DXiJ=
9F0gNuDvCWt0m2qzS6SbocXbFXIdWEHe%2BaJuvvcM%3D&amp;reserved=3D0
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
patch:          https://emea01.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Fsyzkaller.appspot.com%2Fx%2Fpatch.diff%3Fx%3D10558231400000&amp;d=
ata=3D02%7C01%7Cparav%40mellanox.com%7Ce0a5662bb6aa4fdee43508d6298c9e60%7Ca=
652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C636742081267605003&amp;sdata=3Dda=
0p6AW3YnXmFVrSaR%2FxSrB%2Bj%2Bml%2B5AXx%2B%2FKG4Kjb1M%3D&amp;reserved=3D0

Note: testing is done by a robot and is best-effort only.


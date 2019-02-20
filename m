Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194CBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C659D2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="FklWR8IY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfBTTRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 14:17:53 -0500
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:46186 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725798AbfBTTRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 14:17:52 -0500
Received: from pps.filterd (m0098779.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1KJGMRN013064;
        Wed, 20 Feb 2019 13:17:47 -0600
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2058.outbound.protection.outlook.com [104.47.46.58])
        by mx0b-00010702.pphosted.com with ESMTP id 2qr6dxnxbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 20 Feb 2019 13:17:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yttjp9w7Z+Ipy6TD281XvbpF+7P7MvbYLNFroRQVb9k=;
 b=FklWR8IYG4L8NuoMiyUel84oH1yQGONoxjmFSQmHe6pIdnSt3yBojytbEQ/9x1vlg3N3qYKE2LVJaMatuSoNonECRPxwuB+8HHFbkMg4Wp+IB/NQrEihDUimQMYwmryIm5RJag/Y5I6ux+2b2HminbNPxm8C2ggh6+Bef2fmwCc=
Received: from BN6PR04MB0963.namprd04.prod.outlook.com (10.174.233.163) by
 BN6PR04MB1075.namprd04.prod.outlook.com (10.174.233.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Wed, 20 Feb 2019 19:17:45 +0000
Received: from BN6PR04MB0963.namprd04.prod.outlook.com
 ([fe80::c98f:5fe:e801:6c2f]) by BN6PR04MB0963.namprd04.prod.outlook.com
 ([fe80::c98f:5fe:e801:6c2f%7]) with mapi id 15.20.1643.014; Wed, 20 Feb 2019
 19:17:45 +0000
From:   Julia Cartwright <julia@ni.com>
To:     Joerg Roedel <joro@8bytes.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH] iommu/dmar: fix buffer overflow during PCI bus
 notification
Thread-Topic: [PATCH] iommu/dmar: fix buffer overflow during PCI bus
 notification
Thread-Index: AQHUyTvVSa/02Z1JH0OVA6u/ktCK3KXpD3EA
Date:   Wed, 20 Feb 2019 19:17:45 +0000
Message-ID: <20190220191744.GC1076@jcartwri.amer.corp.natinst.com>
References: <20190220164630.11087-1-julia@ni.com>
In-Reply-To: <20190220164630.11087-1-julia@ni.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:805:3e::26) To BN6PR04MB0963.namprd04.prod.outlook.com
 (2603:10b6:405:43::35)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [130.164.62.191]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e09b492c-ef44-4107-252d-08d6976817d6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BN6PR04MB1075;
x-ms-traffictypediagnostic: BN6PR04MB1075:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;BN6PR04MB1075;23:iUWHsfPv5PRo+uaM8et3yy2fqEpjiyxV30J7PycBZ?=
 =?us-ascii?Q?8iXukdW1nURIbTbZASiFi54awIHyLt3b1DRbDAaPXPGV232Mr/GZwmQ+Dmh3?=
 =?us-ascii?Q?FA8bmD0Jv/O1DSm3pwcqoeIZl4zll8vcHneVyUQuGbEnB31oa6DPOTiW0tjj?=
 =?us-ascii?Q?EGU9wRk4xVtiCBEX3rMng4/iZoYgggiJMmQdQfuMs+aBE6Ke6lUih8Y/1kIA?=
 =?us-ascii?Q?y4bvwTtdfa+Md0opxD6Lw2XCrRhJ7++EvUcZFPV+NMF1p4v+S0Em2HxKe4Xy?=
 =?us-ascii?Q?OQPgM/suaO0Usmgs/V0HS0+H1hyWU5Wl0gMbglMmhX5Ik6RXPoPdk8YJnGeS?=
 =?us-ascii?Q?QOqpCvAaUdKVrZjZKo87g2RBiWsD+374PTQCprsqtxn5EC1FoVQ+JDrR7s7Y?=
 =?us-ascii?Q?+W9SXpaphaZZjSiuHw2LZydrm5UJacR0MmOFWWIIgHPYQXkDuzmDOqG0156n?=
 =?us-ascii?Q?AW31TgoK0tC/kYHkhHFAMbrZQaQRsdQgNzRr7FGdUeYOYDmUlNULc6y3OG3N?=
 =?us-ascii?Q?xFRVyOb/2tkkamSsw7XLB/WkJXP1G2FRNsRrJiTMj6a/74v2CcYxlcFRV1l+?=
 =?us-ascii?Q?oPjw1lKzdW+fcPdjEFPkdm9Q/GTjQuOZjKPC0Z8t63N3/dxhhwzlw0JrAono?=
 =?us-ascii?Q?hckJ1geYuIc86XHdtkqsOxCa/9IzURKkNXNUxX1vAqH1MIsmIcpzxOtyOfv8?=
 =?us-ascii?Q?qtCbjjApB8CFAhoaLVPARQAJHaeGN7ahLggvem5eiW3SGp1PTuyA6l9z9tJl?=
 =?us-ascii?Q?uTPtQaHFjPBuoGMIVyaL3U/ZGHLwrJzShxWGbsqsjwDKpSh+5h+UOfe+38tQ?=
 =?us-ascii?Q?gAAq1csen29htrVL0P+kfu1eEaLhewYJXK8WUkdo5RFcMx+Bd7/xqa8J+Vg1?=
 =?us-ascii?Q?Vx4cpSTCLd+AWG5AQ1ScLz4eOWVNyoq4djQg0waC5dqyv48AvVrn0TYWAPv9?=
 =?us-ascii?Q?J+USqrMQNdrCEeDCRxzGSl1eH62gaPiX1lgKOhIY+YKjHhDCXIkOccmCgYC+?=
 =?us-ascii?Q?n7FF88d5PaKEs/E5e0ze1QSpTaKJzSjvR8UPoVQDvhCQHxexz+5uOqDowsUI?=
 =?us-ascii?Q?yo9w7S6N5sN4rrjaMvhoLl1E1oeYDWcr0BW300OIAws4/b4iMCXMtmwf5/Zr?=
 =?us-ascii?Q?g0kXOpF9xn7K1I1zf4uD7WAzTQy0hiHTA01j/9aFOPLkMtzTwNKb1vtsou8M?=
 =?us-ascii?Q?Y3fw62zEN/mkM2N5qPn0msZSANln6ZAo9TZqF0l/v+DB1IiL6n61JypR6z2H?=
 =?us-ascii?Q?xIXa3obk1wpmY/dJ+PNXQFAAXS0YD8safL+9oWJ?=
x-microsoft-antispam-prvs: <BN6PR04MB10754966F9B2B1F58B9DDB88F47D0@BN6PR04MB1075.namprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(376002)(346002)(366004)(199004)(189003)(6486002)(478600001)(6246003)(2906002)(6506007)(102836004)(386003)(316002)(6916009)(8676002)(81156014)(66066001)(54906003)(186003)(8936002)(68736007)(14454004)(81166006)(33656002)(6436002)(25786009)(53936002)(106356001)(305945005)(446003)(6116002)(15650500001)(1076003)(5660300002)(3846002)(99286004)(14444005)(256004)(26005)(105586002)(97736004)(33896004)(52116002)(76176011)(7736002)(229853002)(11346002)(71190400001)(9686003)(6512007)(71200400001)(476003)(4326008)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR04MB1075;H:BN6PR04MB0963.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Jkt30x/wHDSWE7umY/RAoq1J7E1TOlYIxh1ej7W6+9qDDCjJCbLKngUwQvJ5SKmCd6LOy51r3XN9+MEjETtCeZ9oC8n74MWaYdXx0UyzwaFVq0mxXQBb8+GFGYRdhr59h1ldu/qOMvN9dUuizulFYafFx+g1353I4w+1Z8VAQNWNJyg0QDlnxCefunUWzxjPrD9AoA3Bd5gqMPOoUg3cyLwZ2JRSXeMxK6eAeyJvTHDnPv1OF6wNTkV64pMelMqkQfdUMPUXa55Kw5/ML13MQ2OnjZmJIu6ZYev+ngiVfrN2US3V2EaWlMdP565eCom5gXyE2bJrtPFe3RmxsFSY+r9hsWqX+RTVP8d2Fq4J3ikKMZ+cckqS6A7hl47uwoXRedFfJn2TEIRCjBVoLv9t0ho12fWAIhwyMYVFYdp/Kg0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ECF6261C902C224A8193E495D6ADE262@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e09b492c-ef44-4107-252d-08d6976817d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 19:17:45.1326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB1075
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-20_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902200132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 10:46:31AM -0600, Julia Cartwright wrote:
> Commit 57384592c433 ("iommu/vt-d: Store bus information in RMRR PCI
> device path") changed the type of the path data, however, the change in
> path type was not reflected in size calculations.  Update to use the
> correct type and prevent a buffer overflow.
>=20
> This bug manifests in systems with deep PCI hierarchies, and can lead to
> an overflow of the static allocated buffer (dmar_pci_notify_info_buf),
> or can lead to overflow of slab-allocated data.
>=20
>    BUG: KASAN: global-out-of-bounds in dmar_alloc_pci_notify_info+0x1d5/0=
x2e0
>    Write of size 1 at addr ffffffff90445d80 by task swapper/0/1
>    CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.14.87-rt49-0=
2406-gd0a0e96 #1
>    Call Trace:
>     ? dump_stack+0x46/0x59
>     ? print_address_description+0x1df/0x290
[..]
>    The buggy address belongs to the variable:
>     dmar_pci_notify_info_buf+0x40/0x60
>=20
> Fixes: 57384592c433 ("iommu/vt-d: Store bus information in RMRR PCI devic=
e path")
> Signed-off-by: Julia Cartwright <julia@ni.com>
> ---
>  drivers/iommu/dmar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> index 6b7df25e1488..9c49300e9fb7 100644
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/dmar.c
> @@ -145,7 +145,7 @@ dmar_alloc_pci_notify_info(struct pci_dev *dev, unsig=
ned long event)
>  		for (tmp =3D dev; tmp; tmp =3D tmp->bus->self)
>  			level++;
> =20
> -	size =3D sizeof(*info) + level * sizeof(struct acpi_dmar_pci_path);
> +	size =3D sizeof(*info) + level * sizeof(info->path[0]);

This is probably a candidate for struct_size() instead, if that's what
is preferred.

   Julia

Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CCDC5AE5E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD4AC2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Eks+nOcS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbfASBO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 20:14:29 -0500
Received: from mail-eopbgr820090.outbound.protection.outlook.com ([40.107.82.90]:15136
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727128AbfASBO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 20:14:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4dcSRQK9eWXESTiFP3hcE4Xm7HHJdqu+bz/lR0M1/4=;
 b=Eks+nOcSHSDmDXmwMXulB+cwXz0Btsz0gEa0OGpeuTJuPc64uddka1b8w1zQqDVbFqsHL1Q3v7qJ8b/6CRI7PGXK6GhmElH7DBSWKjKYbh1dfn8jbt4aSC8uQldCVSoZuW+1PiWwoTYrl6oQ4Ikzi/VQHgyHBjqtgfD25yiW/B8=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0759.namprd21.prod.outlook.com (10.173.192.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1558.8; Sat, 19 Jan 2019 01:14:26 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::e596:e32f:3aa3:2461]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::e596:e32f:3aa3:2461%7]) with mapi id 15.20.1558.009; Sat, 19 Jan 2019
 01:14:26 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH hyperv-fixes,3/3] Fix hash key value reset after other ops
Thread-Topic: [PATCH hyperv-fixes,3/3] Fix hash key value reset after other
 ops
Thread-Index: AQHUrG5Z1y662GMC/0SdOEM998vVRqW1z21Q
Date:   Sat, 19 Jan 2019 01:14:25 +0000
Message-ID: <CY4PR21MB0773301A98C99B1CEDF16C3DD79D0@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20190115005144.4494-1-haiyangz@linuxonhyperv.com>
 <20190115005144.4494-4-haiyangz@linuxonhyperv.com>
In-Reply-To: <20190115005144.4494-4-haiyangz@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-01-19T01:14:23.7727997Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=80af289d-dfa5-4aa9-b021-bf2100b5dde7;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [2001:4898:80e8:a:e112:b8a4:906c:6906]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0759;6:Mowg/AJUYMFCgKZpoDOFQ0xeOGkHesEEKIC88iU4YdSZEr6xHIiZL3vvnPmibtrwS9OuerW/+Ziq9SpF3skIymUpM+EyfDCpc5i6GV9Xx0nZGun69l91sBzP2SroipnbL31YOSv3NDQLuKFhlvNyMjuQ4Qbadt8wnTDNm7ZUvIFPC6/oMKUgi4maUnijcCLikhEEBXjzlvpA3jYtjphigz7O6ius9hIMNxnw9mqrLEzxiU5wS2+/aZ8idLKVUDzkSjvohX1+oRn7eA6dALOd/z4CrjUYQeWG73t1lXlYJYfDoJypaq43cxxXejYGEPRHBSpXBozwD92dMqlXFxNeWndH97COOABNWOPC6WP6laiYS9uNQ3zyJ6SPOmwI9pgG2MNkoxpww0GhCSphWSzx3Ada4SlZ2Oy5+xvfrTP7+1DvbB/muO8tKRhtqD1RNFKQPRnkwMCy1egkJbcwa08sCw==;5:05P1clMXzUrmy3Y1gvlcGPHTGCExeFmsyn4RIeaAexyXamvU8sMFCjkbMiKw14xCG5tSOy6TTDo/RbKL9AlguBjmoaNe8KWKUMeX8epi8GqPdlUgDgbzsKE6w4/z5jddahDds5k/nZ5slz+x/ROdk6oxLgBqWSCJozpcdse1sxKrcy/zXDR5Gba/oSwBJCurFFDQQlCtBBEgKlT4iztkfg==;7:xUtkMEcqwPB93bAPC2Af6lrJ29cBA5QR/sTWhXRcbHnRrIccbjRDFubpSFZzd8h4Wkad0Gyl2V8Pi/JfEysKLxt5ONkQ7s1xVBz29DhiwS/17JpDwbqLzV2yXKobzAKderXkh1GQoqd0SLTdeLTj2g==
x-ms-office365-filtering-correlation-id: 325802e3-8d5e-40c8-eeef-08d67dab7426
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0759;
x-ms-traffictypediagnostic: CY4PR21MB0759:
x-ms-exchange-purlcount: -3
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB07591BEFE6D9A4BEBF415EE4D79D0@CY4PR21MB0759.namprd21.prod.outlook.com>
x-forefront-prvs: 09222B39F5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(346002)(376002)(366004)(136003)(199004)(189003)(6116002)(10290500003)(10090500001)(7696005)(7736002)(102836004)(4744005)(6506007)(305945005)(186003)(46003)(68736007)(6436002)(229853002)(76176011)(478600001)(5024004)(6346003)(2906002)(97736004)(5660300001)(71200400001)(71190400001)(55016002)(256004)(4326008)(8990500004)(74316002)(14444005)(22452003)(14454004)(8936002)(33656002)(25786009)(446003)(2501003)(86612001)(316002)(6246003)(54906003)(81156014)(110136005)(11346002)(476003)(105586002)(53936002)(8676002)(486006)(99286004)(86362001)(106356001)(81166006)(1511001)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0759;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OtAqD7LjG2ql7h5+sowlvQyUZvNMN3q5giWqh9r9SYuavZruHldraybJ78Z2yr/lINO4+yND0ZRzK8GODzWioHopHFE+rrq7MqDfLNZ2Uj9tcpO3QO5UynbECQYdHi6rs3qjyMABWETz/zgTAg0gOECOvR5IM2jd1SeFLDYIwQuCW1SEamiv56U/H5mMb46SpriZh71g/pnXXcUKRa/9YTxC6znAwX9b1sO9IrQXEMqWvQg0/dfxHmfTar/tGLcQkB5zp4BH4vle4EQUY5QEx3ks8YsB90zy/Drkejk56R+vfvc50OPOVHBFXQzomKeBk3WKOFs6u1DAFxPXQxX9GZy7mW2Z2Jdrn4YLE3nF3kfJ3ufuWQ3hM22p5B+bnovOBRn3ntUn1qGn2VIFynGznTWcOjXv9xtQjJhevThcWWQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 325802e3-8d5e-40c8-eeef-08d67dab7426
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2019 01:14:25.8630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0759
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiyang Zhang <haiyangz@microsoft.com> Sent: Monday, January 14, 2019=
 4:52 PM
>=20
> Changing mtu, channels, or buffer sizes ops call to netvsc_attach(),
> rndis_set_subchannel(), which always reset the hash key to default
> value. That will override hash key changed previously. This patch
> fixes the problem by save the hash key, then restore it when we re-
> add the netvsc device.
>=20
> Fixes: ff4a44199012 ("netvsc: allow get/set of RSS indirection table")
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/net/hyperv/hyperv_net.h   | 10 +++++++---
>  drivers/net/hyperv/netvsc.c       |  2 +-
>  drivers/net/hyperv/netvsc_drv.c   |  5 ++++-
>  drivers/net/hyperv/rndis_filter.c |  9 +++++++--
>  4 files changed, 19 insertions(+), 7 deletions(-)
>=20
Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FC6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 03:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D36B21850
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 03:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbeLSDLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 22:11:21 -0500
Received: from mail-eopbgr680045.outbound.protection.outlook.com ([40.107.68.45]:61072
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727494AbeLSDLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 22:11:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QainyYeoOSScs9c80aPYp1OGwfjwBqG6Aito5PSHlw=;
 b=eQJntHdqboWPqXWxJB7JCp7TiQMWyaBua6IcCZgRvytXTviqwr2G/DYDyxT5ARHDceR1yOWLxAKlD1BaiHP5oKuWJfHqe0B+BAUat+7wJ6HnPJvWdL7TDCJy1AROKW7Nek2pj+mrnW7RG1xhAAx4LzTQXofrjlp6HIayqRPv7Ck=
Received: from SN6PR03MB4398.namprd03.prod.outlook.com (20.177.255.219) by
 SN6PR03MB3518.namprd03.prod.outlook.com (52.135.80.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Wed, 19 Dec 2018 03:11:16 +0000
Received: from SN6PR03MB4398.namprd03.prod.outlook.com
 ([fe80::7c2a:de77:a4ce:5ccc]) by SN6PR03MB4398.namprd03.prod.outlook.com
 ([fe80::7c2a:de77:a4ce:5ccc%3]) with mapi id 15.20.1425.024; Wed, 19 Dec 2018
 03:11:16 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
CC:     Marcin Wojtas <mw@semihalf.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev <netdev@vger.kernel.org>,
        =?iso-8859-1?Q?Gr=E9gory_Clement?= <gregory.clement@bootlin.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        "nadavh@marvell.com" <nadavh@marvell.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Stefan Chulski <stefanc@marvell.com>,
        David Miller <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net] net: mvneta: fix operation for 64K PAGE_SIZE
Thread-Topic: [PATCH net] net: mvneta: fix operation for 64K PAGE_SIZE
Thread-Index: AQHUkVET6MmkkP0I6kWJw6RDslXtBqWB3MQAgAAt/wCAAIlbgIAC2LgA
Date:   Wed, 19 Dec 2018 03:11:16 +0000
Message-ID: <20181219110546.63f68f4b@xhacker.debian>
References: <1544533009-12425-1-git-send-email-mw@semihalf.com>
        <20181216.124120.731491122771817496.davem@davemloft.net>
        <CAPv3WKfz4AkODzJ+gsV=u6ve5YnZEdUhZF5+VmFPQa4mp9okUw@mail.gmail.com>
        <20181217083735.4c6599b3@windsurf>
In-Reply-To: <20181217083735.4c6599b3@windsurf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR04CA0020.apcprd04.prod.outlook.com
 (2603:1096:404:15::32) To SN6PR03MB4398.namprd03.prod.outlook.com
 (2603:10b6:805:fd::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR03MB3518;6:fNgS0p6XGSwVjwRU0hAvcOUVUKjdLsA5wHnc0PUI4kckMxcYDy/p027FSXoyOzhjJ5/3EPn/Xq/8kYmSDHF8nl50J0d2ywHM8FClorsJ832ZJqqWVBJstjJiK591M3RV79Cx0F2Gox6GXYGsxfebtWfHvXd16MYjIyw39k8CvjyOlF61LjjBedQWu2ESiqSIL571mNBBJYcu9uU2hQkMRctC/WE3x/vJ0RXME7weZ3Bk8P3G9lOxvusYoTA9ALRnKHKAyoZaTRlrei+sWd0HX+yux6bprksDq1F26DYbjXGGAr1rZjqbxeFsCje9ctUtr8Rkd8gzNt2fxcRFj+KfUv9IlQVM3OssP3ksnhUBkcpvN8xx8IWkACzo3jgWpsT1eMOyURBAEPhqPbcwbqXCzVb5BwDM0VdKgUzIjNNWqAKetMCyBeDmbM0dBy8rGGMyzaYd7ecpY2vLt95EDGQdUA==;5:x5Z9x8lH7RZJedickzEUagojlUcjGqIfZwN5lGbaEgHxDAS9AqqXYSv3FqOtgOmHxumYWwptWRD3Koa7MO19kNXVAYXiqWsjaBbOG7Y9WiKjK6oHlLyjQAheKMY609uQM8IG3r0MQL9VdTQ0GnhqLtOnwmX3hmBYfC+//u2atDA=;7:PraXAqgdGAJdQoulEMVFAD8SsMHCaDv62kwDA5EOJQYZU54WqZWDdUE5ow7GRE1cqFZZ+R4NsGm5+mwkoLWu6fzSHqXIuYHgdF+DGY92XZF3WV+li9MCwlIIoXc9Q1nR2F47Pn95ciCN5Garq3VRDw==
x-ms-office365-filtering-correlation-id: 905303be-2706-488b-03d4-08d6655fa378
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR03MB3518;
x-ms-traffictypediagnostic: SN6PR03MB3518:
x-microsoft-antispam-prvs: <SN6PR03MB35180A50CE6C11134C84C635EDBE0@SN6PR03MB3518.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:SN6PR03MB3518;BCL:0;PCL:0;RULEID:;SRVR:SN6PR03MB3518;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(39860400002)(396003)(346002)(199004)(189003)(6246003)(81166006)(14444005)(9686003)(386003)(256004)(11346002)(53936002)(6512007)(6506007)(71200400001)(76176011)(3846002)(52116002)(33896004)(26005)(6916009)(71190400001)(6116002)(6436002)(6486002)(229853002)(186003)(7416002)(316002)(305945005)(102836004)(2906002)(5660300001)(54906003)(8936002)(105586002)(93886005)(99286004)(86362001)(7736002)(476003)(66066001)(478600001)(25786009)(4326008)(68736007)(97736004)(486006)(14454004)(8676002)(72206003)(446003)(81156014)(1076003)(106356001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB3518;H:SN6PR03MB4398.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ka+IsRnlFRU/WwdlR8ioIeY4Rl//kIhzywgi2PtINlEDooQKZuwDrJ5KToRHHDoanmt7cPaAeiDIPfvGq8U2/xsbem8rlQg8fhQ6w4Xw3u/ywtxSU6FznEVhq+UyOB2+vnigFABXX1AhgodczdbRdL9uTdk8sW1h/yxPspICmiIRTBUFpFAe8dugq+C2KDk5BhLNHqy+G8u2v6aXzhBfp6Ae/CvfG8AGHTR9iRSSRWe8s4V9v0E8tE8i5C56RlM1dMkFnihbFTN+KgDj+33SiB/GDl1glkZVvLDXPh2SqHtZJ63kRDgbpmRsH0lU7yB0
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <085743CFB054304999D36D3A0EABF3B2@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 905303be-2706-488b-03d4-08d6655fa378
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 03:11:16.1826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3518
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Dec 2018 08:37:35 +0100 Thomas Petazzoni wrote:

> Hello Marcin,
>=20
> On Mon, 17 Dec 2018 00:25:58 +0100, Marcin Wojtas wrote:
>=20
> > Thanks. Indeed, the patch is valid as a fix for current version of SW
> > BM. However, because this concept is broken, I will rework it and
> > submit patch/patches some time early 2019. =20
>=20
> I know some people are working on XDP support in mvneta, and this work
> also needs to change parts of the memory allocation strategy in this
> driver. I'd suggest to get in touch with those folks. Antoine can give
> you the contact details, I don't have them off-hand. Or perhaps they
> will see this e-mail :-)

Great. So the problem of current memory allocation is seen, glad to
know reworking is going on.

Besides the memory waste, there's another issue with commit 7e47fd84b56b
it always allocates page, so the rx is mapped with dmap_map_page(), but
the unmap routine isn't updated, there's mismatch here.

thanks

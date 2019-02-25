Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13200C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20692084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="YyXadmDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfBYTIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 14:08:47 -0500
Received: from mail-eopbgr720111.outbound.protection.outlook.com ([40.107.72.111]:44183
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726481AbfBYTIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 14:08:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rH5w24EAid8rB8Hhjggl/5sOuEzJCBNYMWWIzJJT18=;
 b=YyXadmDADKmWUWBvB56j4ylGCexw25VzIUALT9uRP8klaA7qK1rAZgPsigdzxOcST1SNh4TmHHUXw8S9xR+UpMhEzxRugrF2HPVRKWYbN6H7vjyHBut01vKFTASETULZmHQVUeXHSxOtBnZnge/Rd41+bGf8hRsfVLKyJIW7u8o=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1343.namprd22.prod.outlook.com (10.174.162.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Mon, 25 Feb 2019 19:08:41 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 19:08:41 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH v2 06/10] MIPS: SGI-IP27: rework HUB interrupts
Thread-Topic: [PATCH v2 06/10] MIPS: SGI-IP27: rework HUB interrupts
Thread-Index: AQHUyiurzWbMzN87kEymZXjaLAEQOqXw5rCA
Date:   Mon, 25 Feb 2019 19:08:40 +0000
Message-ID: <MWHPR2201MB12774C9FC45701E0D543A9DBC17A0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190219155728.19163-7-tbogendoerfer@suse.de>
In-Reply-To: <20190219155728.19163-7-tbogendoerfer@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:a03:40::38) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67716b51-27c9-4828-953c-08d69b54a752
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1343;
x-ms-traffictypediagnostic: MWHPR2201MB1343:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR2201MB1343;23:C25ok5IwOnZHZ5C1eho9zC0K0OjGzz4UtIEse?=
 =?iso-8859-1?Q?iBx2lNbNqv7UaZGQtJBW1ZEYyIem1BEHUltbQTWBQvfhXjbhPMCbkDO3gM?=
 =?iso-8859-1?Q?1vBTyq/hEMxsIeXV2Uhsy6qjlA5rxSYgtT/ZrkbCc9oQ/MQiLLVdJP/ccY?=
 =?iso-8859-1?Q?xKxQtOIeNVPLHaKLvaQ1jWDZO8AtUAC9BB7wMTNip0qJIx1aDUjA4PUAcl?=
 =?iso-8859-1?Q?ECPXIL145r6LpQ6NtrtbYZG6ZhswrfgnxqbXny8yN27WVD0s+jpQ1zBBmw?=
 =?iso-8859-1?Q?itJ02Z5LsQyE5H3R9pnwI9IX6g2NJrg1DYWaRyTW2QNMbwB5kpFD+Gxfv9?=
 =?iso-8859-1?Q?YCRH1++LooUrQJiNM80muCSFdHOVksu3YVMbGM1W7RUDIbOkiCWFtGHKYs?=
 =?iso-8859-1?Q?tsy16/ezpszlHLfRoLb7H8eK9HpvJz60uLQUmiT0YVbUukDRKwfPvPWs0H?=
 =?iso-8859-1?Q?6lo3xA82erS5GcJL7WBR0+jr/z0n3XdCzd7ropu0fJcGhhHhkNhLlFclKe?=
 =?iso-8859-1?Q?6ZVExlCoS8amjUMW191iEYxOgxnRjxwvoYg4+XuIQr717rppXF+vzKstsO?=
 =?iso-8859-1?Q?haysan/NDi+rxwUDN+Iz7RcMDuNmy3wZV0dbHwjHrVEjOgwkQkHI0fs9mP?=
 =?iso-8859-1?Q?gVCkfHl6LehoBgITFKhhlYN58V9Q5Vq5XNwv0TMZE7JsdwjXow4eFqPpdq?=
 =?iso-8859-1?Q?+RHyel4VsP00O10YFiPmXqZQDpQTNaWT0EJb2+LgfZ36XC1gMFtYWdPqih?=
 =?iso-8859-1?Q?Wexz5UYLDnwk0NNgcYIsCmxu8EX7i1r+BigkgCoE1lRPm129hkqYret58N?=
 =?iso-8859-1?Q?tURflwatOutyEvOCbOPlkOaYZDYeukpepSEvIWfZoGyZkf2QQwzaUfZYi9?=
 =?iso-8859-1?Q?UuFYrA9JllAByCFtL8ZweOee3zJDC4XWpzPlSQRQ8PdGM8FgjpMx2562Ii?=
 =?iso-8859-1?Q?90jgTeSYTwy7mdUd1+Zj1lkHB+P+1fxjlJA0hTv6Z7Vmwpy65u4XNN1gRw?=
 =?iso-8859-1?Q?B1lbihzaayBweiVUZtRgYlLJlsZUQ4rZrRPnL6yiWo0F8U6jWjckTjOW/V?=
 =?iso-8859-1?Q?BZN6Gt2KIFZ85imWuTeXfZSh74GgBZEm2d8dvE3xzLu6yEBrdyAS6+fegM?=
 =?iso-8859-1?Q?+Zt1Ppl7sy/MKC1F3X0jotHWpETtQy0w3/gzMf15vFCiF6ghpJBf05Ee/T?=
 =?iso-8859-1?Q?K8SD7cG8Wl7xqyM2imR4Lr9inDAoWTFUx8LYdNuom8cy3VDMjWWncp3LdV?=
 =?iso-8859-1?Q?iYB+gusHUXhSpOL4rweIn2dp08xC4WRgxQRHtnAfDz0doGf5uInNKQjj6X?=
 =?iso-8859-1?Q?1lWU1/eAKLEBjGmS7tSQtser0ujMC5h/eCXMn96ngSM777Q=3D=3D?=
x-microsoft-antispam-prvs: <MWHPR2201MB1343B833D049EE98FCFE1A9AC17A0@MWHPR2201MB1343.namprd22.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(136003)(346002)(39840400004)(199004)(189003)(316002)(33656002)(26005)(6916009)(71190400001)(71200400001)(52116002)(256004)(42882007)(54906003)(55016002)(2906002)(76176011)(99286004)(7696005)(9686003)(6116002)(3846002)(186003)(7736002)(305945005)(102836004)(44832011)(386003)(6506007)(74316002)(486006)(11346002)(476003)(53936002)(446003)(8676002)(106356001)(8936002)(81156014)(81166006)(6246003)(105586002)(66066001)(4744005)(68736007)(25786009)(4326008)(97736004)(229853002)(14454004)(5660300002)(478600001)(52536013)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1343;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GoH6B3sCfBlDxAxj6LwdGTM73aDxG2ceXkDubgoKLKkwvB5V6OImuLty4ZU60ge/aVXvyPcVxr+RU3p712iJBde6H74GEuaIA96O9d2VilbzH1hlq3nr84nuMQ0yz+AgU5b6g4sEtRVAxkOKlVOqNJ0s9wX6uZCiJabNXaniNo+uUj+U6PETwbF0CefhC11Yl7Boj5PDaTQdrncUpe+OB/nG6rhg02xbUW4YMj16M/4EN8hgZeeEx3k28N3PoiPSwR7Euip+9W9FFEf3OXZi7gLcsOTBdhJUr2TMS+gWRoV8Z1WTbwizomUd9Y8wWUIQktOKTRehjZ53t9nbJla2g/VvoblhtPMFXJYYelVeaduVFwUBdOd2lBN79owEs2osEppC5IQZWT5hihhooLxYujwaKaCwgyx6IuZHnH9FdYs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67716b51-27c9-4828-953c-08d69b54a752
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 19:08:40.5098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1343
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thomas Bogendoerfer wrote:
> This commit rearranges the HUB interrupt code by using MIPS_IRQ_CPU
> interrupt handling code and modern Linux IRQ framework features to get
> rid of global arrays. It also adds support for irq affinity setting.
>=20
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]

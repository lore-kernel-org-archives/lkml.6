Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5596C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677D22177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="fxo5XYLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbfBRL2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 06:28:01 -0500
Received: from mail-eopbgr50088.outbound.protection.outlook.com ([40.107.5.88]:20288
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727423AbfBRL1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 06:27:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMX7KHTrkqmhhe7gWzILSrkQX+85ML/6tHdenMQqE5A=;
 b=fxo5XYLCEU6M7/lPLlBeqNJYi+XdZaeNC+4afEX9eG7Do6WtHBlcdqP75H6ilVxvlut+2N7+xIg9uMbITKUmjnJUK+RAfb1ei+T/kyeJVGeoVgKB0Fa4hiDYhdeoOvSnUr+/t/s0ZofR47x6h2ixz/Fmb8pqYqFoke4uQrhaK9c=
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com (52.134.93.10) by
 AM0PR08MB4514.eurprd08.prod.outlook.com (20.179.32.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Mon, 18 Feb 2019 11:26:57 +0000
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::6cf2:41c2:1a33:9b18]) by AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::6cf2:41c2:1a33:9b18%3]) with mapi id 15.20.1622.020; Mon, 18 Feb 2019
 11:26:57 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     John Stultz <john.stultz@linaro.org>
CC:     "Andrew F. Davis" <afd@ti.com>, Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?iso-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>,
        Christoph Hellwig <hch@infradead.org>,
        Liam Mark <lmark@codeaurora.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, nd <nd@arm.com>
Subject: Re: [PATCH v2] staging: android: ion: Allocate from heap ID directly
 without mask
Thread-Topic: [PATCH v2] staging: android: ion: Allocate from heap ID directly
 without mask
Thread-Index: AQHUt1KdPElFkHXe9k+icWeJGBgTbKXfqYyAgAEgeICAAIkxgIAEN9sA
Date:   Mon, 18 Feb 2019 11:26:57 +0000
Message-ID: <20190218112656.fkbdflsifbxjy6v6@DESKTOP-E1NTVVP.localdomain>
References: <20190128214408.25442-1-afd@ti.com>
 <CALAqxLXb53nsBJtb958sMzpr-fnXxqFE0s2B6YJzoGcswv50wg@mail.gmail.com>
 <20190215105057.jujgm4k77rhkvmo7@DESKTOP-E1NTVVP.localdomain>
 <CALAqxLU=L3Y7KJEo9c-Nu1rS3EquofGf1UGWBWqAO+Qke72Ekw@mail.gmail.com>
In-Reply-To: <CALAqxLU=L3Y7KJEo9c-Nu1rS3EquofGf1UGWBWqAO+Qke72Ekw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.49]
x-clientproxiedby: LO2P265CA0041.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::29) To AM0PR08MB3025.eurprd08.prod.outlook.com
 (2603:10a6:208:5c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe607ca5-0761-40c3-15e2-08d69593fde5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB4514;
x-ms-traffictypediagnostic: AM0PR08MB4514:
nodisclaimer: True
x-microsoft-exchange-diagnostics: 1;AM0PR08MB4514;20:wkqsXeZNaju8ZzlKgABePq+5cfuSyrT+FaNEXPqb5dFHgRq4qvp0c/SsImWib9d4dV1aap9Uk5x62ItQYwFvIeJ/7PgJxRwyC3Oz33Y2YLjSLqYEyg+C4XGPSwEmFFS/ptUWREs9g8RhhbrMry33M09imfKb91BP6fdCYHX4k2E=
x-microsoft-antispam-prvs: <AM0PR08MB4514F9FA60DECC6458FA47DDF0630@AM0PR08MB4514.eurprd08.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(346002)(39860400002)(366004)(199004)(189003)(81166006)(8936002)(486006)(25786009)(68736007)(8676002)(305945005)(5660300002)(7736002)(81156014)(97736004)(476003)(86362001)(1076003)(6246003)(66066001)(44832011)(6506007)(105586002)(71200400001)(106356001)(478600001)(6436002)(7416002)(186003)(71190400001)(76176011)(102836004)(53546011)(11346002)(72206003)(26005)(14454004)(386003)(3846002)(6116002)(6486002)(229853002)(99286004)(54906003)(316002)(58126008)(52116002)(9686003)(6512007)(256004)(93886005)(4326008)(6916009)(53936002)(2906002)(446003)(33896004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4514;H:AM0PR08MB3025.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Xsq3kfeMpGuPUEeRYI8OQ8cXiQ8Dg/j0hM4pHD1GJc6sypzg49tf8Yd8tLM3aSZeSEV1TsA5KIW1ST/9+q0YdE/o82V2NKbzijbvYt1C4va3VjQF1GwnPJCGvkLQowAjYVlqKJVZGJnx5x0DTY66tZJlqfcx4EhSdxmdIB8Ul0htd2NflHYZySdZ9gdrapC5l2BYxwfs01wyWpKgJvid5GTwD+5cR9h1dDsXmxjcN1BmaWlruAVKOhRKgzHq0/92p/LfltoiUcUjMsaNiPP3gtmWKeC/nwkb5VLNOLB/0r23hlb3tciXfgm9WkMFXjoBLEXRfc7Z9sSkZJ5TTI2KsELEArUTLBhd7/NBLI+5yyIkIMoaUSDAyZoMIeUjeSomX16OqbprssK3j6/Uy8tukjrJHIB9B15VpltjS3LwzTY=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <163CD559665D0F40AE1104D0A2CCD0ED@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe607ca5-0761-40c3-15e2-08d69593fde5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 11:26:56.9492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4514
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 11:01:59AM -0800, John Stultz wrote:
> On Fri, Feb 15, 2019 at 2:51 AM Brian Starkey <Brian.Starkey@arm.com> wro=
te:
> >
> > Hi John,
> >
> > On Thu, Feb 14, 2019 at 09:38:29AM -0800, John Stultz wrote:
> > >
> > [snip]
> >
> > > Some thoughts, as this ABI break has the potential to be pretty painf=
ul.
> > >
> > > 1) Unfortunately, this ABI is exposed *through* libion via
> > > ion_alloc/ion_alloc_fd out to gralloc implementations. Which means it
> > > will have a wider impact to vendor userland code.
> >
> > I figured libion could fairly easily loop through all the set bits in
> > heap_mask and call the ioctl for each until it succeeds. That
> > preserves the old behaviour from the libion clients' perspective.
>=20
> Potentially, though that implicitly still caps the heaps to 32.  So
> I'm not sure what the net benefit would be.
>=20

It's purely a transitionary compatibility measure. Users of the old
API inherit the old limitation - they shouldn't care about that.

Alongside it, we'd want to add new function(s) exposing whatever the
new API is.

Cheers,
-Brian

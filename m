Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EB9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62393214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="nfBvWTQN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62393214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732023AbeKVDaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 22:30:19 -0500
Received: from mail-eopbgr00087.outbound.protection.outlook.com ([40.107.0.87]:4176
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730781AbeKVDaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 22:30:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cFzlPWoAxT6W7Sc2Bhf59J5A/MKN/NzXXO6xLwZaAA=;
 b=nfBvWTQNjZAxLy6xypCioyGywrpnr/C2agFqWfkDyEs9XpYOyk95p3LurEjReIEKpqdAFR/m3tLujvUfXfYR3oL0qaLixU2bwGWLhg/Z4mVyuGc9mjxpu2kCVsIfnc3Lyf1yR9r8e+Mi9heyqtUjmaHVn2m0kGdb3nuTG29660g=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2303.eurprd08.prod.outlook.com (10.172.13.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Wed, 21 Nov 2018 16:55:02 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac%9]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 16:55:01 +0000
From:   Dave Rodgman <dave.rodgman@arm.com>
To:     "Markus F.X.J. Oberhumer" <markus@oberhumer.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     nd <nd@arm.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Matt Sealey <Matt.Sealey@arm.com>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "rpurdie@openedhand.com" <rpurdie@openedhand.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>,
        Sonny Rao <sonnyrao@google.com>
Subject: Re: [PATCH 0/6] lib/lzo: performance improvements
Thread-Topic: [PATCH 0/6] lib/lzo: performance improvements
Thread-Index: AQHUgZI88EDtuaHmFU63dmJG+DkKO6VaPZmAgAA1IoA=
Date:   Wed, 21 Nov 2018 16:55:01 +0000
Message-ID: <992dd863-0143-38c9-6f6d-7cb1bb6fd15d@arm.com>
References: <VI1PR0802MB25289788BFADB136CE08AADA8FDA0@VI1PR0802MB2528.eurprd08.prod.outlook.com>
 <5BF56151.5090201@oberhumer.com>
In-Reply-To: <5BF56151.5090201@oberhumer.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.53]
x-clientproxiedby: CWXP265CA0041.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:2d::29) To VI1PR0802MB2528.eurprd08.prod.outlook.com
 (2603:10a6:800:b0::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dave.rodgman@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2303;6:c9udRNgJ0Kg0/RbEXKT78Nftdf6aoQc+w7M11PqJCE6PtuSEkquOjdgNwiiz+f3tzfqBPHJSV+1oM3pUx2Z0vyn4Lh+qheav0VBmZaLOD6L0VK9G03rrp9PgUdtSykzm60dQj4zh+VT5hZMeMdGkl9S1b7CPNzUdOAgMt5IT2GXfjIsgslS3CvZMurNQNVXvFBbpT5cIMgSRRgHUyPKu5qjh+BxDBogvpipgn7dtgbdWBH3W4C3Yl+HssqPeUnItfyjJpxAYd6+Ob1hWT9l1hl7WSpnsuudzr7LTxzMumDPH76Vw5qmIKLDmSY24PndLwOkHGi67mO4iVkasaSjy3ELz6MoKHCB8YDULEJv55KYjVibUpTYxhXI0zetSN1FteDFtSNzD8Suj6MSKxt0KrG0bLaXGeT6rg11WOrVq8aqKmStSnQ3Ki1Tlr5kfDaHSZGtay6o4m0ZONbbuChTFnw==;5:3tQ+eia5eskTDjzAaySxZMzNTegwgeD/0UH6G2fdhj2LRXkaZWkfbUxTr4bmkXhthUzgOY47ejiHVlH3dCf8+r64VfQUhoHsJdolabPK+L28uIKeIuRfjbN1YO2WlzBqZYJI0zq7e/Wto+1J2vHubUyP6cwFg9pc06m+4zdqMsQ=;7:9WzqJNj1EkXMcTjoi88QenCiGAK6XcwpghCke2hCnd/EVdQKOjEytBKMSOwPEILI5jyoL6MjOfIvb0MzlZ8ChMoBBfwRQOZ0yJtns6K2EDr0mPuW9ovIQRsKqoNrN+W/vQKtGZoF3Pv0Su+gtUAnQQ==
x-ms-office365-filtering-correlation-id: 3bdce13f-3f67-4d99-8022-08d64fd213ab
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2303;
x-ms-traffictypediagnostic: VI1PR0802MB2303:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB2303174F64BE91B4ED0E51D28FDA0@VI1PR0802MB2303.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231442)(944501410)(52105112)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0802MB2303;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0802MB2303;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(396003)(376002)(136003)(366004)(346002)(189003)(199004)(76176011)(66066001)(106356001)(105586002)(2501003)(71200400001)(71190400001)(4326008)(52116002)(6506007)(386003)(81156014)(6246003)(26005)(186003)(39060400002)(53936002)(8676002)(256004)(25786009)(31686004)(53546011)(14454004)(68736007)(102836004)(8936002)(31696002)(81166006)(86362001)(36756003)(99286004)(2900100001)(6116002)(446003)(2616005)(6306002)(476003)(11346002)(5660300001)(6512007)(6486002)(229853002)(14444005)(3846002)(2906002)(97736004)(110136005)(54906003)(44832011)(7736002)(4001150100001)(966005)(478600001)(305945005)(316002)(486006)(6436002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2303;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pTPCJs4+c7IN/0d/zjfWuMuFC+17FdDkl3CUWT7P2pLwtaAPzYN5PGOX/9q/EO3qr4Wwiti15RBU2ych1bpPw7xJzkHJYnbu6zDqRXnCK2QonXO9wvvXuqpBeT0jPjE7g9DC+PfJ0OgJnCp/x0sViKvpTupyAK+19Jqs4Wh9KjmcGXYZ47pDDZD1TugdE9cphtJmdr51QNLW/IjZW8Ka1Z71QGFnBAfuoeoX1iXLePUH/fZe3lMSdqWPRuDbmA+Re+prbuhjp4kWGMBul7Voj4HlRq6qZG2o1ol3R9BrDj6rsXZH0cOhXEu/xx+Guq9s5CQWqA9RrVRu9OTrkrbeaqeifaPCM0ZkoIV6qCiHFuM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <03F39B7CC4827F4C9AB4695EEDD2D64A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bdce13f-3f67-4d99-8022-08d64fd213ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 16:55:01.8736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2303
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2018 1:44 pm, Markus F.X.J. Oberhumer wrote:

> I think the three patches
>=20
>    [PATCH 2/6] lib/lzo: enable 64-bit CTZ on Arm
>    [PATCH 3/6] lib/lzo: 64-bit CTZ on Arm aarch64
>    [PATCH 4/6] lib/lzo: fast 8-byte copy on arm64
>=20
> should be applied in any case - could you please make an extra
> pull request out of these and try to get them merged as fast
> as possible. Thanks.

The three patches you mention give around 10-25% performance uplift=20
(mostly on compression). I'll look at generating a pull request for these.

>    [PATCH 1/6] lib/lzo: clean-up by introducing COPY16
>=20
> does not really affect the resulting code at the moment, but please
> note that in one case the actual copy unit is not allowed to
> be greater 8 bytes (which might be implied by the name "COPY16").
> So this needs more work like an extra COPY16_BY_8() macro.

I'll leave Matt to comment on this one, as it's his patch.

> As for your your "lzo-rle" improvements I'll have a look.
>=20
> Please note that the first byte value 17 is actually valid when using
> external dictionaries ("lzo1x_decompress_dict_safe()" in the LZO source
> code). While this functionality is not present in the Linux kernel at
> the moment it might be worrisome wrt future enhancements.

I wasn't aware of the external dictionary concern. Do you have any=20
suggestions for an alternative instruction that we could use instead=20
that would not be used by the existing lzo algorithm at the start of the=20
stream? If there isn't anything suitable, then we'd have to choose=20
between backwards compatibility (not a huge issue, if lzo-rle were to be=20
kept as a separate algorithm to lzo, but certainly nice to have) vs.=20
allowing for the possibility of introducing external dictionaries in future=
.

> Finally I'm wondering if your chart comparisions just compares the "lzo-r=
le"
> patch or also includes the ARM64 improvments - I cannot understand where =
a
> 20% speedup should come from if you have 0% zeros.

The chart does indeed include the other improvements, so this is where=20
the performance uplift on the left hand side of the chart (i.e., random=20
data) comes from.

Thanks for taking a look at this.

Dave

>=20
> Cheers,
> Markus
>=20
>=20
>=20
> On 2018-11-21 13:06, Dave Rodgman wrote:
>> This patch series introduces performance improvements for lzo.
>>
>> The improvements fall into two categories: general Arm-specific optimisa=
tions
>> (e.g., more efficient memory access); and the introduction of a special =
case
>> for handling runs of zeros (which is a common case for zram) using run-l=
ength
>> encoding.
>>
>> The introduction of RLE modifies the bitstream such that it can't be dec=
oded
>> by old versions of lzo (the new lzo-rle can correctly decode old bitstre=
ams).
>> To avoid possible issues where data is persisted on disk (e.g., squashfs=
), the
>> final patch in this series separates lzo-rle into a separate algorithm
>> alongside lzo, so that the new lzo-rle is (by default) only used for zra=
m and
>> must be explicitly selected for other use-cases. This final patch could =
be
>> omitted if the consensus is that we'd rather avoid proliferation of lzo
>> variants.
>>
>> Overall, performance is improved by around 1.1 - 4.8x (data-dependent: d=
ata
>> with many zero runs shows higher improvement). Under real-world testing =
with
>> zram, time spent in (de)compression during swapping is reduced by around=
 27%.
>> The graph below shows the weighted round-trip throughput of lzo, lz4 and
>> lzo-rle, for randomly generated 4k chunks of data with varying levels of
>> entropy. (To calculate weighted round-trip throughput, compression perfo=
rmance
>> is emphasised to reflect the fact that zram does around 2.25x more compr=
ession
>> than decompression. (Results and overall trends are fairly similar for
>> unweighted).
>>
>> https://drive.google.com/file/d/18GU4pgRVCLNN7wXxynz-8R2ygrY2IdyE/view
>>
>> Contributors:
>> Dave Rodgman <dave.rodgman@arm.com>
>> Matt Sealey <matt.sealey@arm.com>
>>
>=20

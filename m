Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254A8C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E877420811
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="WPOMY3aR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731283AbfBFQjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:39:03 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:34479 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730520AbfBFQjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:39:00 -0500
X-IronPort-AV: E=Sophos;i="5.58,340,1544511600"; 
   d="scan'208";a="25918709"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 06 Feb 2019 09:38:58 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 6 Feb 2019 09:38:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKZHa2Lx0GnxI5GkhY9uWd+auB0UGx/NwHs/yIdn26g=;
 b=WPOMY3aRoaI519SwbRrtSqNChU0r7IbRUG9L2HUxCIa9pJi7te2quV2Z4E5VTFQRyTztqPE3EQLwAj2rGX2iZ8ahPj3SadRiCmJuouzdeT6bCTNWdtWpxtRkFulaV0ZgKQ9+N3jtbFA12iy0oxqS28rZv1K3OISsQdMqeqQiFAQ=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1521.namprd11.prod.outlook.com (10.172.23.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Wed, 6 Feb 2019 16:38:56 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Wed, 6 Feb 2019
 16:38:56 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <bbrezillon@kernel.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <Cyrille.Pitchen@microchip.com>,
        <bugalski.piotr@gmail.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v6 01/13] spi: atmel-quadspi: cache MR value to avoid a
 write access
Thread-Topic: [PATCH v6 01/13] spi: atmel-quadspi: cache MR value to avoid a
 write access
Thread-Index: AQHUvXjafo7rsA240EGmjwHrAHFLbqXS8WQAgAAIiAA=
Date:   Wed, 6 Feb 2019 16:38:56 +0000
Message-ID: <e4bf079b-5f8b-3eca-2f2c-bf0fdd563fba@microchip.com>
References: <20190205173254.16388-1-tudor.ambarus@microchip.com>
 <20190205173254.16388-2-tudor.ambarus@microchip.com>
 <20190206160816.GD17630@sirena.org.uk>
In-Reply-To: <20190206160816.GD17630@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0302CA0003.eurprd03.prod.outlook.com
 (2603:10a6:800:e9::13) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1521;6:2PmT2u7gB4TtMIH4ywepAe2vTTJiyM1GSbBpSE2cEMpDMTH6T+f9i06rDusImYcBIWwTDqELJxDOUtwSqykGwaRG5/ZZ/PuPj3IVPLMLMO8VcQyJtYQqIXwzYrsUxwHb7KqqaCWCbnUJSSEQ9vCzAxQeOvvwMe+7HGiW0qMSb776f1NDn0uPFqw95MuQZYirdrb0Ny9gKvTC9KqEu4uqLiL+Nq+xN6AzmH+JPuoNAoDiowqhodo/mbwT5ZOADnNdbPhoLZOyAVQ9MOcVnCX1JG7a08f35dYcv4vrlAp+eWr2GKZHWyBPWmMesZRHnnAaq8PiZCd+UUPgDz3mBdz9VCjBsjnSKbLWFIzZln57S/8FEjGXNNR3sLn0n8St7ItpkxtJohXD9Fr8mWmhV9/brNEd1y+kp48AAMfgo+T4ZPeG05R88gW6VV29xYuZL+OPXy36Blx9qQ9G5RJgk8Unvw==;5:2eTWQs++/0dnhCeOTQPl8vz4wpJTdefVp3be3ylgau4CL7OJZkAoGww/tXta3sby0m+wdvxQtW0jCQYdN1m5FhusW4w2MJdzZWIO31TuPyZ08vpDhtHcBCG0oPKkalBP6nk8yXjRLxlGgJSQ8rehelqJFLESpAWaZXjmXz/YGyjIjaLZoN/kVjt4aIUtS4RBoQ6NVETdGCp5icYVxe2W8A==;7:mSM5Xa5eOhI0gpMaeHFrM5Poc2yq2P1DjVTVVJRvA0MobyjSlU9oWWCsMnTXkWlbLKxT01pJS/BU1lkOqm1bpQ3b7GRbtB7LuQMEaa+A09/93QSBsc323/74Z7Q+X5D/vT5R0sb394Rmzym+t4TB9w==
x-ms-office365-filtering-correlation-id: 08ea044f-d316-45aa-353c-08d68c51963d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1521;
x-ms-traffictypediagnostic: BN6PR11MB1521:
x-microsoft-antispam-prvs: <BN6PR11MB1521CEC1993C0E37B1ACBF94F06F0@BN6PR11MB1521.namprd11.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(396003)(366004)(199004)(189003)(6512007)(8936002)(53936002)(81166006)(53546011)(305945005)(4744005)(31696002)(2906002)(229853002)(31686004)(72206003)(102836004)(7736002)(106356001)(71200400001)(478600001)(36756003)(25786009)(26005)(71190400001)(6506007)(386003)(97736004)(68736007)(7416002)(99286004)(446003)(486006)(6486002)(86362001)(2501003)(4326008)(6436002)(476003)(2616005)(52116002)(11346002)(76176011)(54906003)(66066001)(256004)(81156014)(6246003)(186003)(14454004)(14444005)(3846002)(6116002)(105586002)(110136005)(316002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1521;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aQjjgzueJYSFETypf1yvnZoMfjNxoSeBk/NfrSV1jjJHP+1C3jdzBamwupDq83+xkybuekTBj6Gs0xz5Y0wV6wAtSOyjCWreHS9BFfdBofrthjz4xgN7cuDqsT+0u87e72MHHjeub4DJze6tQxwbnZLHVQxkom87bvBRt9yTO/5bD0vKmGwkGZlyfKzNa8LC36J0idagmzRDaj8kmCF1nSAwRokw/xBwgqyvlB3zqlJHv0U14An4OtOcvt6oWoMDBu+wrdOjr1zxn859QAdYK+YJPMYYn6T6JtTKnDa46r1KlBm8OYolUVKsfaS9FRv14sJY+8x5MfFNf035hDudbBh6mPfFiBu2UdxLtpYEE014BlAFL4lJeDJdDbtCsHp0cqBB2QkBCgv+DBYwc7lrZj57NRkfBhwZSeZ/DTBqAgs=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <089B4078EFC14B44A80F68AD99A0062E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ea044f-d316-45aa-353c-08d68c51963d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 16:38:53.8869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1521
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/06/2019 06:08 PM, Mark Brown wrote:
> On Tue, Feb 05, 2019 at 05:33:06PM +0000, Tudor.Ambarus@microchip.com wro=
te:
>> From: Tudor Ambarus <tudor.ambarus@microchip.com>
>>
>> Set the controller by default in Serial Memory Mode (SMM) at probe.
>> Cache Mode Register (MR) value to avoid write access when setting
>> the controller in serial memory mode at exec_op().
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>> ---
>> v6: no change
>> v5: collect R-b
>=20
> You say you've collected a reviewed-by for this but there's no
> reviewed-by on the patch?
>=20

Not intended. 8/13 has the same problem. I guess I added the R-b tags after
formatting the patches, this may explain why they're gone now.

Boris, can you please add your R-b tag on 8/13 too?

Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D935FC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C3420855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="jW6TgRQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C3420855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbeKJCiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:38:15 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:22927 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbeKJCiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:38:15 -0500
X-IronPort-AV: E=Sophos;i="5.54,483,1534834800"; 
   d="scan'208";a="20177804"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 09 Nov 2018 09:56:50 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 9 Nov 2018 09:56:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uH/5FVAL6My3DN7fkCwRGU6DLFYmDLDbOwxsSD5NUPw=;
 b=jW6TgRQRpcO2sAeFH5QdL8bnKvs8ZJpBy2ptfLEidEFLlC+USPqP/F9rh/sE9ip3kjip7M5gAc2zKuaXIVeZx/555vdHbUv7VOcgP/4JEbLMbKUHbHzd6UHGrgTEib0YSehmfztPLL6n6ws7IbqJ7myIxaGpv+SX4sqRYZLvlBU=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1905.namprd11.prod.outlook.com (10.175.100.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Fri, 9 Nov 2018 16:56:47 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa%5]) with mapi id 15.20.1294.034; Fri, 9 Nov 2018
 16:56:47 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@bootlin.com>, <marek.vasut@gmail.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yogeshnarayan.gaur@nxp.com>, <cyrille.pitchen@wedev4u.fr>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 0/5] mtd: spi-nor: fixes found when debugging smpt
Thread-Topic: [PATCH v2 0/5] mtd: spi-nor: fixes found when debugging smpt
Thread-Index: AQHUeE0zK2ltj9Ul4UG1UmImfkI3+Q==
Date:   Fri, 9 Nov 2018 16:56:46 +0000
Message-ID: <20181109165644.30534-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0231.eurprd07.prod.outlook.com
 (2603:10a6:802:58::34) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1905;6:g2YTX+TfrM5Mk9/yP2C67eAnOh4zpnDBtY4KGEX24BWC2HKuNpsdCkRi5Am1cXWOR4BL8E6Sd+DefxpVy4vT2cKujhUzsMoPz5e3AZre6NzYwG4bcg2L89Eg86G2Poi0piHL3tYgqBlT+Y2CMxq3J2W4TcC/gsWZk7PZrrTQYWxRYbol3Gd5L6Z8Xgti+j7LM+GTrY4IOkmZn1rwLGisYMsqthUByAJgzZsVvFH34obettjkp0Ch5yJ2SCjFt70O+YHSt2odP8mNvTGRIzv2cNcja04/UFlpLerN1r3411HYqlVjjK8lOUEZbac9o5C3v8cU7cAARcCI3iKeyyCmolvFUfoL1+071OgET66ykCW114rq27BPXHwhZC3/00p8kCKtC1RcCcTZ4Q14ZbfXdGUt6Q0dc+hrO56YsyN9Bh4j3votCgcj4F04cp9fXtlntlehHswvGm2X5AeiKtCtLg==;5:rfIvZhJtFqa8qgInR4WdNBadvLnR3Gv8eijluilWkwL+t7NH+7LW7ovQJ5xCr1QNeQdyHaLfU0UimIEz9ZqbMw6wtGZSOUWLi01BsT01F5h1Kj2TW+qgoaXUwGHccvOcOqCMo2pl/AMlC640BzFa5/urAwmkDAYPVItUtJrzG2k=;7:c5GsSNz42bf7iMUVHfsd2oa2U6qA+lQMjPMJGfF1OHI5IdqRCP74WPRoRSnFDKHwjA7S07zuhHbfyHRnZy6VQYjwaKLPIgBuMsMZkirt7h6AOlSaNg63M+KvY9fASwj9iHsYL2tVQouU6f19XoUziA==
x-ms-office365-filtering-correlation-id: 4cb08ba8-8078-463a-0373-08d64664552f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1905;
x-ms-traffictypediagnostic: BN6PR11MB1905:
x-microsoft-antispam-prvs: <BN6PR11MB1905D14FF2544C90C6BE42FCF0C60@BN6PR11MB1905.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231382)(944501410)(52105095)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1905;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1905;
x-forefront-prvs: 08512C5403
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(39860400002)(346002)(136003)(189003)(199004)(6486002)(8936002)(68736007)(3846002)(81156014)(486006)(8676002)(316002)(71190400001)(2616005)(110136005)(6116002)(14444005)(256004)(86362001)(66066001)(2201001)(39060400002)(186003)(102836004)(54906003)(71200400001)(7736002)(305945005)(14454004)(81166006)(6436002)(5660300001)(2501003)(97736004)(26005)(2906002)(1076002)(476003)(72206003)(4326008)(99286004)(6512007)(52116002)(478600001)(386003)(2900100001)(105586002)(25786009)(106356001)(107886003)(6506007)(53936002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1905;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: x3zn8JthoV9Xl+gvlYvN+oZQOIKgVFE9KsWNoue15/73+uToA59fHJ6flZzFKkihXiG4eW+cyEGvmVHBwOsUdgVR73NJ+UIcZu456kZWp7t+68Lzv2e1q2BijcbS9OXeE7qRfuD2GB552Iji90E8iHa7NrVpcl6bKEwEQ9FGSuwK3ZzZSynvib0i7lG/m9zF3hFVVnbzcxUsdn8gW+zaDCuD3NCOUe4/kh3P/RYWMFr0PLlJXFQMOZPTYVNsyddr8Zb+a8G8yrNJgD7XmLfh/0EyKaBaaNaLnGDLvTp9Ha+i3wcUHYf8GZVZD0yDe9+KlCgQH0/z66FJy9yxFEcFq8Y3UmsS8hEeyP/ZD5+OA6Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb08ba8-8078-463a-0373-08d64664552f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2018 16:56:46.8259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1905
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bunch of fixes that we found while debugging the roll back to
SPINOR_OP_READ_1_1_4_4B in case smpt parser fails.

Boris, Yogesh,

Now I'm looking for a fix in case the smpt detection commands
define variable address length and dummy bytes. Will follow.

v2:
- drop patches 3 and 6
- update fixes tag for the first patch
- add fixes tags for other patches
- typo, blank line, rename variable, add comment

Tudor Ambarus (5):
  mtd: spi-nor: don't drop sfdp data if optional parsers fail
  mtd: spi-nor: fix iteration over smpt array
  mtd: spi-nor: don't overwrite errno in spi_nor_get_map_in_use()
  mtd: spi_nor: pass DMA-able buffer to spi_nor_read_raw()
  mtd: spi-nor: remove unneeded smpt zeroization

 drivers/mtd/spi-nor/spi-nor.c | 85 ++++++++++++++++++++++++++++++++-------=
----
 1 file changed, 63 insertions(+), 22 deletions(-)

--=20
2.9.4


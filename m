Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5D3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 21:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC121208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 21:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="ItsCqTLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC121208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbeKPIAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 03:00:35 -0500
Received: from mail-eopbgr700040.outbound.protection.outlook.com ([40.107.70.40]:29946
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725856AbeKPIAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 03:00:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTWslaBmevFXvscNk0YYm2qZpGAcU4ETN2ax2xdM8F4=;
 b=ItsCqTLUg4yeGIlZ+t0uu0mM7kW4rrCrdbhFwwTB+lECClZFSKjjascX6djR8sfnKZeLFMvgYxviXPuuzHoYqSWa9uYDU5v9fP5CEzftezuuEitc39cIbEB6GA7VO0C7aiejq2Ig2KsXUlrAM29zaIYiZKGE0iqL/i5E2wMOB3E=
Received: from SN6PR07MB5326.namprd07.prod.outlook.com (52.135.105.33) by
 SN6PR07MB4863.namprd07.prod.outlook.com (52.135.75.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.31; Thu, 15 Nov 2018 21:50:57 +0000
Received: from SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::f0b9:acf9:7513:c149]) by SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::f0b9:acf9:7513:c149%5]) with mapi id 15.20.1294.045; Thu, 15 Nov 2018
 21:50:57 +0000
From:   Robert Richter <rrichter@cavium.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
CC:     Will Deacon <will.deacon@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        John Garry <john.garry@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Richter, Robert" <Robert.Richter@cavium.com>
Subject: [PATCH 0/2] irqchip/gic-v3-its: Use CMA for its table allocation
Thread-Topic: [PATCH 0/2] irqchip/gic-v3-its: Use CMA for its table allocation
Thread-Index: AQHUfS1KKJ7l48455Ey90kOzGtmdXw==
Date:   Thu, 15 Nov 2018 21:50:57 +0000
Message-ID: <20181115215012.23922-1-rrichter@cavium.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0701CA0059.eurprd07.prod.outlook.com
 (2603:10a6:203:2::21) To SN6PR07MB5326.namprd07.prod.outlook.com
 (2603:10b6:805:73::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Robert.Richter@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.180.169.238]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR07MB4863;6:R5g5+zUAKcvFOUqSmItbyUKKH0VeYd7gdtymfViAjZhr76135aVf26UEdy7IvqY40pK/Kq6whx205FvEa/6PvgYxq06Lb6Yj4Rf515aWgh3upuZoylZQ1PdAC6ABWZf685uBJ216qKyBSSNTxpK1/AImDOf4PeZ0cIzJ111EfZf0resYZt+h0RhYDfzgnNKQJ/0eWVN4Nvds6tJaMcg+q8bAgIdqHUR/1p72Qf75HAWW0/Cfr3LGFjfTY6OyHQjS7HI30L5D6W6pxSudm5jW0gWUD+H/No70FTxkCS4eQY5Iiz6yVY/rg4wLbV+Ycuf7TLu1gfAchBkrQlBpMDEhl9f9iXDNjlU97XM7/ddPn1vvNJIdXKo4Zj6pWMAwqSMdIvW/Bf8dg84xbkl4pBzhe/Lp9lCyqfj3tb7Otiz4v0D78OBVg3Bz8mPsowVqKA7F0FccKLHEvtnX9sNXd320pw==;5:Q+GHcjlq6ny3wbL3uosANuv+5t5WbPwoOmRp80qe4OlWTanl3vciVRl2jPwr0e+ZxYMMu5zRwGh7PWAV5Zrtxelg/ipOm9h5zR5R/FhYsJ5zhLwuvA8GQmrv3t6QqylHgrzlcJpuCjtIdRqDkBCcm2EFGOajymktimiz7dNwGvI=;7:aSTwdkioDHpLbiKh6r9i7fFoz3aS9W5eAlpLzf7MGPRsAG7vRTmMkwj104kc2XNeOZciEONWukABvRHNdJYhxdGetTfUOKAqbyt7XEGL5NPiZcOMwLiTSgvmDBxF84vuhSSUpun0zEWHlw0GrL+hRQ==
x-ms-office365-filtering-correlation-id: cb5415b5-ac0d-4c97-0105-08d64b446c9e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4863;
x-ms-traffictypediagnostic: SN6PR07MB4863:
x-microsoft-antispam-prvs: <SN6PR07MB4863B2AF63F06815FB44D8E2F1DC0@SN6PR07MB4863.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231415)(944501410)(52105112)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:SN6PR07MB4863;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4863;
x-forefront-prvs: 08572BD77F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(186003)(386003)(6436002)(106356001)(966005)(26005)(6506007)(72206003)(14454004)(6486002)(97736004)(3846002)(6116002)(68736007)(105586002)(2906002)(8936002)(81156014)(81166006)(8676002)(1076002)(102836004)(316002)(99286004)(54906003)(66066001)(110136005)(2900100001)(7416002)(256004)(39060400002)(305945005)(52116002)(71200400001)(71190400001)(6512007)(486006)(476003)(2616005)(107886003)(25786009)(6306002)(7736002)(5660300001)(4326008)(36756003)(53936002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4863;H:SN6PR07MB5326.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wmKm/bPYKCNs/7mDPJ+4ZDCPNXh5wp8V0XeGoZ8PBg+NY0oGnyfXH7b7TcIFBtoFdx7ZTL3pp4SMhX/4LuL5YjRqwAmBIJomTvsqVHHWUODV78cRw2OLqreCKxEfrgzn3/JWpKgaVDOtvSjGhZQ7xlEPkmNkVN9TBF0tvKyQxELA8TSZQ9pxMueAl4DaykR+eSisB6Lzd2v7VH4dsJeRDu132EVwF7uRoGsmKjQKNYG8IEH5nn/m1XEc01VALk5n58+47NdI9Sr62xF4HiJtEOBmGMyNfuRvnZBeaKkDf1SGVFKDbWdie8qBRPYNgbH98pkmVOXBUxlWPePeVkSoJPsKByDbP83jMOpCGoiRxyY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5415b5-ac0d-4c97-0105-08d64b446c9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2018 21:50:57.7481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4863
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gicv3-its device table may have a size of up to 16MB (Cavium
ThunderX). With 4k pagesize the maximum size of memory allocation is
4MB. This series implements the use of CMA for allocation of large its
tables. To achieve this we need to make an its node a kernel device
(patch #1) and rework the its table allocation code (patch #2). Both
can only be done after the arch_initcall and thus this patch series
bases on my previous series that implements late its initialization:

      https://patchwork.kernel.org/cover/10673117/

Using its nodes as kernel devices has the side effect to ease the
release of resources (devres used) and device based messages (dev_*
printk variants used).

The new its table allocator still uses the old scheme for small tables
to allow a further rework that supports NUMA-aware its tables.

Robert Richter (2):
  irqchip/gic-v3-its: Handle its nodes as kernel devices
  irqchip/gic-v3-its: Use CMA for allocation of large device tables

 drivers/irqchip/irq-gic-v3-its.c | 224 +++++++++++++++++++++++------------=
----
 1 file changed, 135 insertions(+), 89 deletions(-)

--=20
2.11.0


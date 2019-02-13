Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74F7C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFB5222C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BdwgK5Ve";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hshCeRMU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733189AbfBMGch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 01:32:37 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:24582 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733120AbfBMGcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 01:32:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550039545; x=1581575545;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VGSTh2Ic6u1arTIsot2MkHbC7XHLwGF1acoeESpQzbQ=;
  b=BdwgK5Ve8jEeFtXO/53djh8LCZtmzsBQITgrY4WKL8HTZq2u0WbGjYe+
   IFFR16onpY1chiDfY8drr9ahy9UjMNkDHd6SG16wLfl722ExsT6jjPu3b
   7YXTB+ukeSnCtCgQabjLDbgvdhAZxgPvNsyxwYarKBcFQeoTk0+EUHDyG
   5dE2LUEgsVwC3kB0ZXm4yYUHa/MWsDwFp3UTZnwYa1F3XAsp+Qu0yLVZs
   di+BZS8KqMj0WAGqMY5doMdFrKfFDXqFe7I53aryCSyBmNEtfVMMbn608
   fTf23A+xsO2uru7i66hcdXZG6YU2RgSMy8/fx4+7/6voNvB1TVMOc8xa0
   w==;
X-IronPort-AV: E=Sophos;i="5.58,364,1544457600"; 
   d="scan'208";a="206244739"
Received: from mail-by2nam03lp2059.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.59])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2019 14:32:25 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+0AVyeEHd1iUHRkPUD6vRsiNWlv2R9o902vTqIBfs0=;
 b=hshCeRMUfED75B40rkwk3cj7ye4rWUVrvKdr1BzJQMJhNKJFOxAnkeXEvX8pbEfz5dSbd9FKwj7kez5oOYdxxcBojB0+AdoiCQixMcSe8oeZJb6zYzVlVFnUxkO6zqbvLpMjrPPp5P9zuUxwysaBqjSrggK2Xb8FgTNv1aYMUbE=
Received: from DM6PR04MB6059.namprd04.prod.outlook.com (20.178.226.89) by
 DM6PR04MB5628.namprd04.prod.outlook.com (20.179.51.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 06:32:24 +0000
Received: from DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::d006:5be7:c3f:ba6c]) by DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::d006:5be7:c3f:ba6c%2]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 06:32:24 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v4 6/6] RISC-V: Free-up initrd in free_initrd_mem()
Thread-Topic: [PATCH v4 6/6] RISC-V: Free-up initrd in free_initrd_mem()
Thread-Index: AQHUw2XhneCVLsk8fkmL4zO8eU0wjg==
Date:   Wed, 13 Feb 2019 06:32:24 +0000
Message-ID: <20190213063127.28703-7-anup.patel@wdc.com>
References: <20190213063127.28703-1-anup.patel@wdc.com>
In-Reply-To: <20190213063127.28703-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR0101CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::13) To DM6PR04MB6059.namprd04.prod.outlook.com
 (2603:10b6:5:129::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [129.253.179.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4a4d949-0354-4ba6-aa2d-08d6917d03da
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR04MB5628;
x-ms-traffictypediagnostic: DM6PR04MB5628:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DM6PR04MB5628;23:jIBM9UNBTMzLGYMG/O1KmV5JJLWKYMUXVEzs8/o?=
 =?iso-8859-1?Q?wRXaXeL62cwJgu3JaoXfEVe/8AkirCuknz4C22ERxhgHL5LSK4pzsYPSCd?=
 =?iso-8859-1?Q?gwoJEic2gMytAerdH7VUIyVKfLm3eEH/mtJC7ch1jiyKIBwwzoqHJtv8Hh?=
 =?iso-8859-1?Q?ELXi+r3X27Hdlq6fc7gUQ0Yevw4oMzuWK0hCQa15I//67Y/siyZMLckINo?=
 =?iso-8859-1?Q?c0PhSCy/jrODCkJL1uVjz5pEQYAqlvngBTOZtFNg0aHsYBX25Qc5iv0EEY?=
 =?iso-8859-1?Q?csgM8ND3cQouc7nI9TuM1W+OFfvvZ1N0y2j/0kvWGoKCWfDcDEecFlO2cf?=
 =?iso-8859-1?Q?MOpGHvkqQbvIRI8mLCUKwDmqBsnuMGnp056TmH7Fm12M1dRHn4G68a7dm/?=
 =?iso-8859-1?Q?p0MK98c3e9jJ97oHcIg/uSF/MiclnNzV0WA7cErHSAEskOLEYm6ajjRfxs?=
 =?iso-8859-1?Q?t8r1CWAR99f0TR4F4jbxTertRWxzOmjwHcEY/S3KZzzHtKJbHdGdVflPCM?=
 =?iso-8859-1?Q?nivUsEdcabVXDGDnBEHrVUj3WhY/qI1ScxFPCPKNZ/ZbSZuvpbCtzsO+aC?=
 =?iso-8859-1?Q?WPEQRd0ZfResT8TTtOwKzJCFeaXWHCi7MV8mqEWH0lSpQmWVGRwoSS1whQ?=
 =?iso-8859-1?Q?IHYPF+Fl9da6tR2VlEmDj87OkOEkiQ3H0dzuOlvPnTbLfMagWaWET5XX0w?=
 =?iso-8859-1?Q?tF5FWDi+axlNflyAHKS82fSX//38C1Wn9cVx59BhR5rc0GEKvQjbj1LzDq?=
 =?iso-8859-1?Q?cM9D7H1RkjFHMRNLb//4nQ/IkKfgNfOQ/2BhTpkuLPpcpMHLqbFGWn9fG4?=
 =?iso-8859-1?Q?mfqbFRXolZ3j8q9PitTVaNvkSIZkhRPaN64XUMBSBxgoaF5L0lGo+78e5V?=
 =?iso-8859-1?Q?FwMif8kfADwqNdLQuAd/HJeZL2dSN/jNTuarWG9A5t++xMdjgcHvsdhMN9?=
 =?iso-8859-1?Q?Nf090g9nw4OUpShY+tByBVR6S0FPRnqF6GPmJag5Cvc1RtNLfamJb8R4GC?=
 =?iso-8859-1?Q?1Kdz9LH412h8jtPXUOunzRmFxrrnZeEa4eKip7y7pMS86DiXFG4eJer0Cs?=
 =?iso-8859-1?Q?yanOfZxO40BzfCwNkB5hHmB74+tJqWz2feNCg8dcHnhjgUBCDPghBAfnKX?=
 =?iso-8859-1?Q?2BvG82IxZtpvi8UFdPpUlzy1Y9xLIAKOLymShlF14/3vBN1VvvQDOqeax7?=
 =?iso-8859-1?Q?RTeBKEIIXCxo8quky519KFAcRMM4ZvNoCDytTPqn8EARGl3RzXkgb1S48Z?=
 =?iso-8859-1?Q?oGqKAvtu5Do4djcvFz34PbmYGi+9IUUBZi6zskyVCTxtzg+blmcGHHrSJM?=
 =?iso-8859-1?Q?fvz712i4NGkgnFK3hOBJhle?=
x-microsoft-antispam-prvs: <DM6PR04MB56287652B0C0E7CDFD4F768D8D660@DM6PR04MB5628.namprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(14454004)(478600001)(4326008)(106356001)(97736004)(86362001)(50226002)(66066001)(102836004)(2906002)(6436002)(256004)(14444005)(6512007)(105586002)(72206003)(25786009)(26005)(53936002)(6486002)(36756003)(4744005)(316002)(186003)(8676002)(7736002)(81166006)(81156014)(8936002)(110136005)(54906003)(11346002)(2616005)(6116002)(71200400001)(3846002)(71190400001)(68736007)(2171002)(52116002)(76176011)(6506007)(386003)(99286004)(1076003)(305945005)(476003)(44832011)(486006)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB5628;H:DM6PR04MB6059.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: w/SxbdvuIYHo0lN9hTcaTjqsfQU8IJ7l4xNMO1lRUTs3sizL21jq2vLFXnDg27Y6woOnkiBIx92EfKWgW1wlSey4jtlY2ofcpFXops/AevFtQfaWGH6VP6sdbltXgvfFYQsDHp2yq6DNaAW79j4Z2Sl2627Y7LJfbIl/GYGnZn5mGyolAq2uklRQKnrgjB+MZrQNm2CJqHus2TxIAHHXQwiKcGn0oUMsO2nG00ZAnbaAWN2IadEmvLVsACgjHoVwR+66jviYwlb/zGlJx2N6HbqXZWAaH4aPgRxENg0QD1XKUJ6+yHV9PoDyJfiYALKsC8NIQp9o0VIG1+5a4jdK/I6bkG2bBJmyQ7N9sl1VivqPqB8ErhpsNzdQJG/unVgGmj4H8XZEgEoCBFmqTIr/YtKwezwH5VPoXtv9e2x7i1A=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a4d949-0354-4ba6-aa2d-08d6917d03da
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 06:32:21.3546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5628
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should free-up initrd memory in free_initrd_mem() instead
of doing nothing.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/kernel/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 9cd583b6d1cd..c22b873de856 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -97,8 +97,9 @@ static void __init setup_initrd(void)
 	initrd_end =3D 0;
 }
=20
-void free_initrd_mem(unsigned long start, unsigned long end)
+void __init free_initrd_mem(unsigned long start, unsigned long end)
 {
+	memblock_free(__pa(start), end - start);
 }
 #endif /* CONFIG_BLK_DEV_INITRD */
=20
--=20
2.17.1


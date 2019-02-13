Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEACC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0CC222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iXNJjKsc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mwIr/vyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403914AbfBMLyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:54:05 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:35255 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391971AbfBMLxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:53:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550058834; x=1581594834;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hdynpLsXwVKwcClFb4N8UkG4HyfxmZo8SJfWqKU4gbc=;
  b=iXNJjKscDwybg7MQGln8PHDO7SAWB88qJdSZsCYPFbQsPfS6pozFKE3x
   L1sdu4IXBelcJGzKEHGtJ0lXyd2GFd6AJhsSCN8mtSVLQ9kriRWLlUzWK
   apN2752a6HK9DtQspROBPVvUoMOhQwkJi99SujpiALXmx9z9vDFw/trij
   8GixEmYxaO95LWsxIQ0B+se6BOYp9MxTQRCxJMs/58J7F/sIIJnb4V4cX
   lCyTpnLfPitGn4ntd8ffUvE3Wb775YxrLNtJzcuaTw1SgBCJzgWz8dj7s
   fLIxDuwfin3oNoeDX9vpgyeqDgq6fkzgII8BBJ4yxxIDEj5p5s1Cz7+nz
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,365,1544457600"; 
   d="scan'208";a="101095245"
Received: from mail-by2nam01lp2050.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.50])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2019 19:53:53 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZN5zUH1x1xZWl7BtTWHLtybsd33DX9UC1Eh7RejOP0=;
 b=mwIr/vyPbuT2ZifYFDqKWipjDgC5/GFrsLCBLKeb/BHwsqM2UlloEw95hM+1bu4lo6jnTbJ8RRgdL6iF6ozuY2dkrCVsNPCXA1AR/R9ubCMXUi+Gmoyi6M0RoJNk7la7/u5c69NunMxOAMhX8Zr/swzqS1n5WAiN3MKkoxVeCkA=
Received: from DM6PR04MB6059.namprd04.prod.outlook.com (20.178.226.89) by
 DM6PR04MB4458.namprd04.prod.outlook.com (20.176.104.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 11:53:52 +0000
Received: from DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::d006:5be7:c3f:ba6c]) by DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::d006:5be7:c3f:ba6c%2]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 11:53:52 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v6 5/5] RISC-V: Free-up initrd in free_initrd_mem()
Thread-Topic: [PATCH v6 5/5] RISC-V: Free-up initrd in free_initrd_mem()
Thread-Index: AQHUw5LJNBZjt056iESEmmv3JNu8Cw==
Date:   Wed, 13 Feb 2019 11:53:51 +0000
Message-ID: <20190213115301.103989-6-anup.patel@wdc.com>
References: <20190213115301.103989-1-anup.patel@wdc.com>
In-Reply-To: <20190213115301.103989-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR0101CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::17) To DM6PR04MB6059.namprd04.prod.outlook.com
 (2603:10b6:5:129::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [49.207.52.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 535f05c4-daa7-4d09-c1fb-08d691a9ec07
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR04MB4458;
x-ms-traffictypediagnostic: DM6PR04MB4458:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DM6PR04MB4458;23:3HjocLzHNbh/M6pXTkTBAZ4Xc5VNOaBoTX/RdSO?=
 =?iso-8859-1?Q?Mxxu8Ftzvqv006hMN2M323tfywA9UhAAnkx/hjlAmJ/6mJa+wacg96e3Qs?=
 =?iso-8859-1?Q?rye+SunHovmD99NmUwuT/aXsr6i0xRQ2FIyoeVxJ8C9Y7SMMSn9y+VlL07?=
 =?iso-8859-1?Q?i9bskONLt9yWItENHDKYGCHPkkmcbhq7YnyZRDiK38c42ozsMhmGJRRCQI?=
 =?iso-8859-1?Q?PMbYA/dHooIloJcb5cXVJMHwxhS9MSzwlqFPYk4QPbPEZjTxfh7zTK4I6w?=
 =?iso-8859-1?Q?Uzd3Bkq9McKpZovUnIVQ7DVlC+ltwRYLKovOb927uRlyW1tHpywT05MJVq?=
 =?iso-8859-1?Q?KaNlcf7ShL/8jHnlZQ4dlFWnjJzZWjBknl8vNICCoN7C2QavHxj37dHlEy?=
 =?iso-8859-1?Q?VT9R51o6IQefrgnfx0e1CIGEG2Noq+XODvbcUqY1LO3TaE7iufiawYu7Hq?=
 =?iso-8859-1?Q?He9N27RNh3BfaRjMK4QnIxpqt4Fj6qCtib2U79Y7eRsbNBzP7xc7cdjxI0?=
 =?iso-8859-1?Q?+xegVQqsUrGy0PqobE1JniZvoPwTXzobPSG5eotDhATroTr2XTsZTfn2U/?=
 =?iso-8859-1?Q?SZSW7ImJH5pkjFxmJU9HqDTPYieOfBhkL6QmP/m/5elGndPEaE8roJfLMg?=
 =?iso-8859-1?Q?hbVU08onU3ux7jr/leJl7H8Tz8Dbe07/SqiCR8poQolX8puyjCr8grlipO?=
 =?iso-8859-1?Q?7qFPjY87pkRwsavS5CCIIvwEgq6rKxm/Fy9Nz1TP+1dLMcWg4TmPYdOb4t?=
 =?iso-8859-1?Q?mJeQZTbZz/aj4bsIcTC3rj7yHAKIYX1c3YXLM7f9iafgs252PRc6JKEFQh?=
 =?iso-8859-1?Q?Mc889gsIh0oEYjamEnYtQY0RuByV8ZYMKryuGuLLXSI2uk7Lgw5uD/ACXg?=
 =?iso-8859-1?Q?/EHrfAmJMNeQDjZhYjBzmYPUwNacAmU1eZCHJha+C5a38dKfajTX4gphun?=
 =?iso-8859-1?Q?HOXY4bPeMY9AVl0usYT87gFJvHeAs344d59PDVzlyZQs5BEDLh4mDjhb3u?=
 =?iso-8859-1?Q?egIXgh6dkIVAzN2yd6TkuKlGGqZrofngYhjQ8NVYoFYK5JVuHXsUp71bWX?=
 =?iso-8859-1?Q?S7cGvpf/dHBN0jgHMcCZZt2I3b5kZRUE5Z17U9jAmBrB/mWKPFdt7jXIlM?=
 =?iso-8859-1?Q?qPW5YYkRJtO40xcygyG5qDlPISdnj5XlCnqqL2Z8HzO48PFYPrxP/7MvfF?=
 =?iso-8859-1?Q?YiOfGR0A1ZCtAR64yQEDPCsdVFKSxes1cqqWr7Sdk8ZgPXgX6GaZ5VNeRY?=
 =?iso-8859-1?Q?TcPOsKsK/NIACI+y+xP5y4WTHRf/xAd7zHIikSBEfnJKwI5nsLk14t2XwO?=
 =?iso-8859-1?Q?K6ECANTNvf8E3NKjiGHoOdAQdhmP29HUbezfP/jHC2ilg=3D=3D?=
x-microsoft-antispam-prvs: <DM6PR04MB44585D8CCD1EBF47D0643EE18D660@DM6PR04MB4458.namprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(136003)(396003)(199004)(189003)(53936002)(25786009)(6436002)(71200400001)(6116002)(3846002)(6486002)(86362001)(99286004)(71190400001)(72206003)(76176011)(2906002)(54906003)(52116002)(476003)(106356001)(305945005)(110136005)(44832011)(14454004)(316002)(2616005)(68736007)(7736002)(486006)(97736004)(66066001)(50226002)(4326008)(14444005)(26005)(11346002)(446003)(186003)(478600001)(256004)(6506007)(81166006)(6512007)(36756003)(102836004)(8676002)(8936002)(1076003)(4744005)(2171002)(105586002)(81156014)(386003)(55236004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB4458;H:DM6PR04MB6059.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ym4sZ/BQNXxOf94Sz+dndBzNFZWfld/M7is8WBI7zGE/8qYh7tl+N5uazXrh2fkOQEau554eHiPw1F/SQ66UIwHvEopedFAo7iYJkwjE60x/lQty896zFqdkAMclhBQyMncl7rHtSjZ4r22f95+lT5YDDDyp8Pxd4+Qlqo4p45rrU+4D3MgPfS4hHHrvh+dWuly4oEphEpfakTqd//l0QqbUYXEFm+YUEhJyhKh2PhjeJLGdHyyywdk5ctNXr/RkSBM35vAqymvf/qmQTXQELiufOGjzNBocG14aP3Pqjh1DdbfM2aC8VqYRznMe24zqCXJv1DLUlUF77wJG5WsRbVefYLp1X3LXUXjAOJQfNWl8P0frpIaEqGhSKUoqgIpHL44MWMZtXTWQpP3dWGDW2wvU3JzV2LtGpuhx9t+CaQo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 535f05c4-daa7-4d09-c1fb-08d691a9ec07
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 11:53:48.5595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4458
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should free-up initrd memory in free_initrd_mem() instead
of doing nothing.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/mm/init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index b1167a6f5a92..aabf1869c54b 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -94,8 +94,9 @@ static void __init setup_initrd(void)
 	initrd_end =3D 0;
 }
=20
-void free_initrd_mem(unsigned long start, unsigned long end)
+void __init free_initrd_mem(unsigned long start, unsigned long end)
 {
+	free_reserved_area((void *)start, (void *)end, -1, "initrd");
 }
 #endif /* CONFIG_BLK_DEV_INITRD */
=20
--=20
2.17.1


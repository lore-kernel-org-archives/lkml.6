Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7D3C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E14222C7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="O2Pjb3Pz";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="n9U81Ohf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390285AbfBMIHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:07:15 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:38764 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729612AbfBMIHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:07:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550045235; x=1581581235;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=6WeSCiRSu6UdblUgBrYgCaXXRhmyt197U9/hWBfuA7o=;
  b=O2Pjb3PzyjLuWRHa3M4sVtgmmIh+Ry988r2lLlwIFMAXihOJVP7P1tpQ
   5aAfKIM8OPnr3ilcz+JReFohmKUparYvApG6vFptRPSUYilFIMujz08KB
   n+JkV0FpSOGWYkRQ3Y4+EsfVa0hayOiORcnkw/yXom573MqWPZckrNaup
   3FmNwFvK54K0Mfs/osQ9HcpWR3Ill8CTOvNYI0WJY47zwwNo7FcWa/TyT
   CJoju+kLZzQnACr0Y5p55sEy7Cv+270vmHnrxJ22uflhj+Z4U8Z+87BRJ
   WEkS+qG2xn/6Yg1ve/iKX0eUAClv7+DtMEFARUyfyYwTvyVcc4Fw9fQFA
   A==;
X-IronPort-AV: E=Sophos;i="5.58,365,1544457600"; 
   d="scan'208";a="101081325"
Received: from mail-co1nam05lp2054.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.54])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2019 16:07:14 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0ZBb4vmRQGDf4po6uKrZaPgqM/+l2NS4IFjm7csBTE=;
 b=n9U81Ohfg9ezrXkIZANdoGZMZci/dlWuD3RzR9yNKxQ3n/9+Dkph2PDgbqlF5kQ+Sdunc8GzFwLyCegAFDWvFXWRdG1wDAbCOmvS+9khGOqGVE+NpCqKPPVjxsFxHxoJUdv5O23DQEB9NqKkHksoteSEjuQf7Gt2J0s/ZUs5678=
Received: from DM6PR04MB6059.namprd04.prod.outlook.com (20.178.226.89) by
 DM6PR04MB5993.namprd04.prod.outlook.com (20.178.225.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 08:07:12 +0000
Received: from DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::d006:5be7:c3f:ba6c]) by DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::d006:5be7:c3f:ba6c%2]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 08:07:11 +0000
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
Subject: [PATCH v5 0/6] Fixmap support and MM cleanups
Thread-Topic: [PATCH v5 0/6] Fixmap support and MM cleanups
Thread-Index: AQHUw3MfSMgaYNX/s0uqtVAV6C/Fpg==
Date:   Wed, 13 Feb 2019 08:07:11 +0000
Message-ID: <20190213080647.68204-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0140.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::34) To DM6PR04MB6059.namprd04.prod.outlook.com
 (2603:10b6:5:129::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [129.253.179.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6d6b75d-6541-43dd-f9bb-08d6918a41e3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR04MB5993;
x-ms-traffictypediagnostic: DM6PR04MB5993:
x-ms-exchange-purlcount: 1
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DM6PR04MB5993;23:Ho7w9jEDNvJHcWEiUUO/PrC8y/wO6xUglCrwNcD?=
 =?iso-8859-1?Q?THSWhJRpP/U76jMOf19fc4j3s6aO1rB+oZfqAQKB/k5/5rEFBoPoxShTJw?=
 =?iso-8859-1?Q?YwpuRDjjYgxf6WtDRepBJXuNEHRKcA6/Ve1kdUNSqfzyS8wnIAL5LEUXKH?=
 =?iso-8859-1?Q?y/pgAn6OF/cnWXL+0Wvg2+QZDdtKiVMSzP30MeqF0OC7BqoxApYHBX0W57?=
 =?iso-8859-1?Q?iXdRyyHIJfgvidhtidVfbTzfU6xkPYmeHcIRS4gSgGzi/I1S41LqX3ozvS?=
 =?iso-8859-1?Q?RSG76ZCu1IVxQkko39hR5QvLj8t88s/pCDI194zCEgGwAAot9IMvU6Dn8o?=
 =?iso-8859-1?Q?Ne8yOt1RZeaBGU72ebRxC8YTMCx2MTQfhuTM3C4RyUwrehe3ObRj0EWzUn?=
 =?iso-8859-1?Q?eSrp67DiY6BTEmdWDoqETHGF+M+HI2+RQNp+2R4ViRPzzhYTiyhL7Y+O7g?=
 =?iso-8859-1?Q?5K87I07ENnBEyrFrrCKNv1BReyCfE+hDByppLAb6SsdoU91KLanJ7A7IbA?=
 =?iso-8859-1?Q?1MxCHeECcymUEsd0bPBjRDBHUJ26r2plGsVGO4v8qBs3bI6UIJS2Zf7eEn?=
 =?iso-8859-1?Q?39dpEYtD1IO/mEtXxv5Jltvdfl2b/5ZrmXDgXECvp/JY2NEG+x4gH1PpGv?=
 =?iso-8859-1?Q?kKLs/Tia5Gem7FutA3pjvBwE2RfBJsDTpfRswBDQQecjxXvFPLOQf09p5f?=
 =?iso-8859-1?Q?f7YeDDEgmDL821oKEiutotSq47WgxlEGfqFQIo6LiT1lz5aMozBTavmqHS?=
 =?iso-8859-1?Q?15sqr9G+qOQcTs69lYit8KmEZkhFoxYnQMQ8lSWdpGY88NT8V3ChNIGbAB?=
 =?iso-8859-1?Q?F6PlCG4lTSRkMIIYfSSMVbqhy5JWzCxGQNn+3p7WVwz5VrcQLbR8FutE0B?=
 =?iso-8859-1?Q?CbZsBw3aCqJSUC5qUS/vgw/hVCZbmOViadRp64S6wkMpLJWdRIgUjTn5+G?=
 =?iso-8859-1?Q?IW78AJV+NoC9xDIQsY86LTkj5eJ0LcJa9Ddwsc9QVHNn8PKPid9GS+jWtb?=
 =?iso-8859-1?Q?JylVckdceTozARdrCPcfKDe3pRYxgffCASzRZfF2VDZ0pfPS5WWE+7xRCD?=
 =?iso-8859-1?Q?78eJH1+KFcllFVsdWLh0BYdkBQzJHH2quDZcUtvaFTLG+hsqLOIYzDkxab?=
 =?iso-8859-1?Q?iILP6D41TRpBiXWi8OURHVv0t1D4KlgjdoAN9QSzdZtiJTW/oBWOL9XmyD?=
 =?iso-8859-1?Q?k0hV9SO+Sm/vljk9BCKaVfbIbblhAraLZXuAtconBw4UdjieZTypt8WpuB?=
 =?iso-8859-1?Q?CJTJc47K6uC8F/CtMAMbr1G+f1J16kLYl+fowR9yPZyaoTdep+ndvTA+39?=
 =?iso-8859-1?Q?sM=3D?=
x-microsoft-antispam-prvs: <DM6PR04MB59939DDAAEECE563F326EDD08D660@DM6PR04MB5993.namprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(346002)(136003)(366004)(54534003)(199004)(189003)(6512007)(99286004)(53936002)(50226002)(6306002)(386003)(6116002)(52116002)(105586002)(3846002)(106356001)(110136005)(6506007)(25786009)(256004)(54906003)(86362001)(6436002)(316002)(2171002)(36756003)(6486002)(97736004)(4326008)(81166006)(66066001)(8676002)(68736007)(102836004)(72206003)(476003)(2906002)(81156014)(1076003)(966005)(14454004)(71200400001)(71190400001)(8936002)(7736002)(305945005)(26005)(186003)(486006)(2616005)(478600001)(44832011);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB5993;H:DM6PR04MB6059.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yHUIUzrO3dCajqQ0iXQYnwg86pJBJ+pM7IGoeNHOWDJMLBYnsGyskuQlvxbBiT8YwH3T8ehxNlJBTCKpGB0KqVSQBLv+9PK64Ys1djVlen+cdQk/V0Yz7yuTxf5qYfz4zzDp4n237Kpy30nhkfTiEbzaEA7ZFJ0jyLLoGqF2nIq2hVw1JUQ6UHg+bL7lQN15stvBoD1dzm2GIAfG7R+PNeO6CtQAib5FewmiI8PcA++80WwyLEemO0iaeIPdsedRbc1k7UawjQozUNKcoyrH/Xxzf50mdY9/eMw8sXyqp0tC+MHsGa7xVspVcwM0zpTI3YhTbZTcYCF+QnBBGEJW2/NLDdYcgxmompjV+YLKgerbCSkvBkjBG+CbQ0Q57IKI+dqin3FtjAINgCkadvhTh1rk7X/yRxN1W0ORMzmp1Qc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d6b75d-6541-43dd-f9bb-08d6918a41e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 08:07:08.5625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5993
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset does:
1. Moves MM related code from kernel/setup.c to mm/init.c
2. Implements compile-time fixed mappings

Using fixed mappings, we get earlyprints even without SBI calls.

For example, we can now use kernel parameter
"earlycon=3Duart8250,mmio,0x10000000"
to get early prints on QEMU virt machine without using SBI calls.

The patchset is tested on QEMU virt machine. It is based on
Linux-5.0-rc6 and can be found at riscv_fixmap_v5 branch of:
https://github.com/avpatel/linux.git.

Changes since v4:
 - Use free_reserved_area() instead of memblock_free() in PATCH6

Changes since v3:
 - Re-worked and simplified PATCH6

Changes since v2:
 - Fixed commit description of PATCH6
 - Ensured commit description of all PATCH use upto 72
   characters per line

Changes since v1:
 - Use more characters per line in changelog of PATCH3
 - Removed #ifndef __ASSEMBLY__ from PATCH5
 - Use more characters per line in commets of PATCH5
 - Added PATCH6 to implement keepinitrd kernel parameter

Anup Patel (6):
  RISC-V: Move free_initrd_mem() to kernel/setup.c
  RISC-V: Setup init_mm before parse_early_param()
  RISC-V: Move setup_bootmem() to mm/init.c
  RISC-V: Move setup_vm() to mm/init.c
  RISC-V: Implement compile-time fixed mappings
  RISC-V: Free-up initrd in free_initrd_mem()

 arch/riscv/Kconfig               |   3 +
 arch/riscv/include/asm/fixmap.h  |  44 +++++++++++
 arch/riscv/include/asm/pgtable.h |   1 +
 arch/riscv/kernel/setup.c        | 107 +++-----------------------
 arch/riscv/mm/init.c             | 124 ++++++++++++++++++++++++++++++-
 5 files changed, 180 insertions(+), 99 deletions(-)
 create mode 100644 arch/riscv/include/asm/fixmap.h

--=20
2.17.1


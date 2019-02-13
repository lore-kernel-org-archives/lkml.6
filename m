Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F0AC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18973222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VoPmgeHM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WueOUuka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390488AbfBMIH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:07:56 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:26136 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731261AbfBMIHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:07:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550045275; x=1581581275;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mVPMs9C8+6CQAaDj6NugfLu86pA3zkPXJHHWwQpuR9w=;
  b=VoPmgeHMUNQbaitKP+QU+CtqZsLTzDX5GELvAF9WL8tkvPvk269CgwXJ
   oR9G9QtQQQteAY+AXQ2ST103Q2/gulQjET2dTWmkQDapHw2GSB568boW0
   DCYc1gfkopcZf8rxK1uCQNN/MT9j+imvfc58JhIaKkPrnV/1KcVlN8FFm
   3zCUJze6+ARxArP7ziSWCINSOzJIWjarn99ECsX3S4qTHIV5cCrGfo5hm
   J443NsT7TIeZwtqP7E4nFC0K17rmD7FlKUhLvQqWLGa8j2X1HsEJOOGBJ
   fPYCet+Ismj674XSjyw6Clfboj9ODxMqt/nbnBDZhBJh0O29qkhlOUOGD
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,365,1544457600"; 
   d="scan'208";a="102402348"
Received: from mail-co1nam05lp2058.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.58])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2019 16:07:54 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAFENJ0ckmNmp39g4DgIRLAtQx1PuVea/P1XlwG4f1o=;
 b=WueOUukaWaWiB4Q5/PNhCfOXDWlyQPbN7rLwxsoj0zhqqLlE43kClnZc5uyOJxB52YcTWhB7orr/UVBpx1qQTrU+roCjU9pwEIyx0NUVCcxwIDjZVeo2YrP12D5aAC/GWUrp9ABRHRJfi4coTewh7o+ro6/mVMBGj1U9HR4kzSQ=
Received: from DM6PR04MB6059.namprd04.prod.outlook.com (20.178.226.89) by
 DM6PR04MB5993.namprd04.prod.outlook.com (20.178.225.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 08:07:52 +0000
Received: from DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::d006:5be7:c3f:ba6c]) by DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::d006:5be7:c3f:ba6c%2]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 08:07:52 +0000
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
Subject: [PATCH v5 6/6] RISC-V: Free-up initrd in free_initrd_mem()
Thread-Topic: [PATCH v5 6/6] RISC-V: Free-up initrd in free_initrd_mem()
Thread-Index: AQHUw3M3QH97A0lstE6SewwvrcIfpw==
Date:   Wed, 13 Feb 2019 08:07:52 +0000
Message-ID: <20190213080647.68204-7-anup.patel@wdc.com>
References: <20190213080647.68204-1-anup.patel@wdc.com>
In-Reply-To: <20190213080647.68204-1-anup.patel@wdc.com>
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
x-ms-office365-filtering-correlation-id: b63cb087-1be9-43f7-f066-08d6918a59f6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR04MB5993;
x-ms-traffictypediagnostic: DM6PR04MB5993:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DM6PR04MB5993;23:nZoSFga0WrTqsE2lMz/Yi20cgjCC24DMQVMbeMJ?=
 =?iso-8859-1?Q?TZAUuEcYEatOHuMX6FCeqXcIkcUjF14KsB5Xs5d10VZSqYxJ6UAmmOdFkk?=
 =?iso-8859-1?Q?CSwTOdjJWwssHxhj+zsDm25dWHRs3M/yscESuqya9xhq6NpfcKviJYLQBk?=
 =?iso-8859-1?Q?z0AeRMny6AZ7Sr2n+2YbYCTDj82f57Cvazm7P6gVa7p7hRgWqsa6HYNKJ+?=
 =?iso-8859-1?Q?VtoKYhXH/3s8fTBnexfhWZgvY1LzRG5goXKZjoZydgipzEdUXvbL+AxeFT?=
 =?iso-8859-1?Q?E36oRkFCifSZGZNHlARNVasWgB5ONZyvNqwW9QWE78TcpTSEgFANTUacU4?=
 =?iso-8859-1?Q?lXu4m4MWQ+71FdZb5rJHZOMQiQ4QMUbHBodhFK8mkdXevRio3CkCWlZK+f?=
 =?iso-8859-1?Q?+/62yqUg4GDCrQu3Mc4aaA0eYB/bLBlGP+p0klywJqYNtngPgGXPYcOVr8?=
 =?iso-8859-1?Q?nRVgDnTfciIVbpV6D9ZdOgA5mHFYQS/jOukm/GcJ5RxLSe3tGFryd65OI8?=
 =?iso-8859-1?Q?6rTG7WrzdXn+jqYw65p/Rm7MNc84V2xsfVLvppwlDvtjVh7BGTOLte1b6F?=
 =?iso-8859-1?Q?5Q7MlGtaCoeIHn/8Bmhp9ZzpCjJ5L5qnChXSFMaPDdKCVKCFfEOL4VWWfT?=
 =?iso-8859-1?Q?3ZeggnwSQX+ruaA3F3lTC/3zUW8XgGA9QuAqhE4AuQUdTBx/rq7UBRL1xH?=
 =?iso-8859-1?Q?QxUiiDbjUK69G3JK0BGlI2eJmM0ffOehZTcno8Ku76oKnep9OAah4H80lE?=
 =?iso-8859-1?Q?bgNocMqcIuErUlUv4+2N61bKn10Mu8KSYfpQWdbb+DhC3kGgurnpGPGpjt?=
 =?iso-8859-1?Q?41MA3U2qJM6Y4XDR9f21lSig3UI0ft2NRkRxkMA/o+bGdYZHGeFnU7fNt0?=
 =?iso-8859-1?Q?PmN/x5VsY5QFxNQdcitwoRHe4l5Ygl9J60Z17zChKSUjF5s5NoOCugv1fK?=
 =?iso-8859-1?Q?ryZD1TVdXYsBDp/5Qr2QB8tIeaYgX18ASUBepOdT16vQGT+dT4dumhRUmS?=
 =?iso-8859-1?Q?DlJ0f/vKZGb1k6vrdxg0W6LEFdy9/DgsJDJkLs9Bif4ITexDSgxaYFOA14?=
 =?iso-8859-1?Q?GWsl5G0fHZTzeQ6fBSKPAaZzeH2mZpyMZojU2qMbILBy1dB/5zKnYOSDLt?=
 =?iso-8859-1?Q?iT6sjwM9415SPJEoIuaRzJ0MLsW67+GXrjypgpOkLklwrqN9GTobCJoMLT?=
 =?iso-8859-1?Q?9cYQfnIqIhaPR/6tYx2L0PkSnv+zlle/3G3tVczgexxXW+daSWOQzMmQsL?=
 =?iso-8859-1?Q?AfJg10gghKnQuiaeqB6RZXsqXZdJsV7F3jBoce7ZQhaGdJZ4TtyUp70QQa?=
 =?iso-8859-1?Q?glitghn5zXkOb39vUKW1B5/?=
x-microsoft-antispam-prvs: <DM6PR04MB5993623481A37676F746A5588D660@DM6PR04MB5993.namprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(346002)(136003)(366004)(199004)(189003)(6512007)(99286004)(53936002)(50226002)(386003)(6116002)(52116002)(105586002)(3846002)(106356001)(76176011)(110136005)(6506007)(25786009)(256004)(54906003)(86362001)(6436002)(316002)(2171002)(14444005)(36756003)(6486002)(97736004)(4326008)(81166006)(66066001)(8676002)(68736007)(4744005)(102836004)(72206003)(476003)(2906002)(11346002)(446003)(81156014)(1076003)(14454004)(71200400001)(71190400001)(8936002)(7736002)(305945005)(26005)(186003)(486006)(2616005)(478600001)(44832011);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB5993;H:DM6PR04MB6059.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /LFrOUpjCdpohcnQkb8T5xadw1Q7Wd66uxsOWCkLwkVOrsqlyuV3Xpg51jmE9AKeo1omQTdyWNnKfRz3hY/rm1bTgsyPwAygqHDQthu2OobNZojNDC2ErQJ5dmtJXj6SBi02+1Kv95kMx7x3iLOSoF0EGTD/sfVInkgseykxQfD8/FAz+XWu4u7JZvD7DSMedEA2qYB10o79+yyyjVcoi2jJzPWK9IOVbdcg1q4l50pbcRO4hpm/dCUczSV3C+DxGkqSkkYJjmVGeD36F5mpwyc86KeBFXehhDdhqqp/8EDOpnLZ2HQafnDpie7kcbj1ptyWqKZ/cIXM2OcFEN0+a7NBiVjoSO6keGD92JRjrqBZJyYviT0yULxN1XdNqZefmCn5ilqFz6s1ynXmOzkSrhH8Apu4q6myMmzSkghoEiw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b63cb087-1be9-43f7-f066-08d6918a59f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 08:07:48.9622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5993
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
index 9cd583b6d1cd..ed8dd28ca98c 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -97,8 +97,9 @@ static void __init setup_initrd(void)
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


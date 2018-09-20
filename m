Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1784AECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC04A21521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IAqiIx6K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC04A21521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387460AbeITI2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:28:33 -0400
Received: from mail-by2nam01on0122.outbound.protection.outlook.com ([104.47.34.122]:34106
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726000AbeITI2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hq2WYq7dVxbP0VTLf2SnI4xacuMwJyEEkDbU8RxaUxI=;
 b=IAqiIx6K9BchUT/S18scgmCwHzFx5SjKWly1oJ9x08hcTuwUtNHBr4LrpU2Tuu12B9oGscfENU6ylSIs0h38rshK54vhhiDjjFQbJIr/OtyMdL2CNoo3pJwYojPhAww6B3lr23+EE7CdGUHxjuM8okJsbqhSVgwtgjC+rHNhK4k=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Thu, 20 Sep 2018 02:47:27 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:47:27 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Tony Lindgren <tony@atomide.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 03/56] bus: ti-sysc: Fix module register ioremap
 for larger offsets
Thread-Topic: [PATCH AUTOSEL 4.18 03/56] bus: ti-sysc: Fix module register
 ioremap for larger offsets
Thread-Index: AQHUUIxEQIMBuwL6LU25b/5oK9xUsg==
Date:   Thu, 20 Sep 2018 02:47:27 +0000
Message-ID: <20180920024716.58490-3-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0149;6:MpgqQz8zpH4IAVkqffeu10J1ux20Lipf7REux6rNKyU4P66kBoRziBADTPqBpA6QVWd78DIhDxGB6gSfScZHliXkERkAn18FQ9syYC2H3PAgQznB58OKIXC1xYQvXNeLhKeDgDczdxgR4TUfACu39i5oxWd+ZvlRvDpiHpcLGi7eVxE+AJ2yN0raF9i8WXsY11ULPfqaF4J3ve/w8wPrep0wWV4ZJZLN2U3pTDvNm9Lc0PvXQmyOD0WZf14m7awpLRczWq7VIIHu26HeSFa+p5rUx7ZU2454OXi7qshKnJTN5vNm+IOHL+aLX/cytGYNwJ0U7XGK2y0PUFheWdKE5EMQYOPT8pL18YmYab4JLHQo0LsisB7QlNgjj7l3OZhr3Sx/+ySeRXHDioe6LT7qQLrjl9TJqGtv7uUaPQfKtXxA89q5i/4fLHROLMZfym6mDlYGlwJ/KVeEnY/E0XW9VA==;5:seVdAHWL9RsYmqMavuTcAf9NNZDc3dhel61Ux+MYrO8PRwMYUOKQekVQb2PTSjq9exf1deypwQJeipbztedsh9YqcXn02RnFlIAUJeVQ2KPOhTiECtZyXdrq7OZlU/XlMFDRvJ/yCv4Gxif+AqoKLT/JVe9uIYFEfkU2Tct1urA=;7:mGKZhKww1jhJgS+iWIdbipnw/QwLgg+dE0t4GE+JYOLwnDzK0FUzZlGQGF2soB/lpIYDedBSE4igK3TNXuMImurJCu5tkN4Wgv07yIH/Ukg+B5VG6Hwiph9ZyTDkgEuXlFahSbR+MOVXjHZOmE7yxsX4cwDNGMIbG1BnYZ0UiUH1L0t6gyoOuny1S3Odc6Nr1upnCvbdjB2p5TFP5t+RUuEFE7OgXCuBd2SW3zowx2ZbtlNfhkZ1pq6Cvv+R2Tvc
x-ms-office365-filtering-correlation-id: 23d36536-3385-4860-dca3-08d61ea36708
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
x-microsoft-antispam-prvs: <CY4PR21MB014931A048D4E3430A535E86FB130@CY4PR21MB0149.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0149;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0149;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(376002)(396003)(39860400002)(199004)(189003)(86612001)(7736002)(81156014)(305945005)(10090500001)(81166006)(8676002)(105586002)(106356001)(66066001)(2900100001)(6116002)(3846002)(1076002)(486006)(5660300001)(2616005)(476003)(14454004)(478600001)(72206003)(76176011)(22452003)(6346003)(316002)(99286004)(26005)(186003)(6506007)(102836004)(54906003)(110136005)(446003)(11346002)(4326008)(25786009)(107886003)(36756003)(6436002)(6486002)(86362001)(2501003)(5250100002)(71200400001)(2906002)(71190400001)(68736007)(8936002)(10290500003)(6512007)(217873002)(97736004)(53936002)(14444005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: REZl+kDWkPoBAmkQj+ES1+o6gf89YZl6+SPQrZVRb/fJigJyU3I3vHFvw4rDR5h2r6ufUW2H/k6bPzDiPLR6/gDXRfhjHjiwOVV4FVBsN5mnxsX9tCbEkUo4dn4Pk8oRXNoYpZMVO+dKPw2uIBwQ7HR1KwdXx3K27zH1zGNtQyCCPAgYmgHiCv33BgzbUehlSVzQ9BYRtDMA7x4uCsPo/sSPt3fCS4Zpe92BmP1e/8xz+V2Y6xPyXLwVydwbUkEceIoBc7rrO+A5NZv3mS9C01Jv31WIYHTpJtuIkIobRc+5JXgpY7baoyTuNmsdTnCre5A/EWHmI1I9qYEJE9sapaAvZBDxP0lsbd6qvX9274s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d36536-3385-4860-dca3-08d61ea36708
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:27.4921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 0ef8e3bb974af56346b34393e643d491d9141c66 ]

We can have the interconnect target module control registers pretty
much anywhere within the module range. The current code attempts an
incomplete optimization of the ioremap size but does it wrong and
it only works for registers at the beginning of the module.

Let's just use the largest control register to calculate the ioremap
size. The ioremapped range is for most part cached anyways so there
is no need for size optimization. Let's also update the comments
accordingly.

Fixes: 0eecc636e5a2 ("bus: ti-sysc: Add minimal TI sysc interconnect
target driver")
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/bus/ti-sysc.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 80d60f43db56..b31bf03ea497 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -490,32 +490,29 @@ static int sysc_check_registers(struct sysc *ddata)
=20
 /**
  * syc_ioremap - ioremap register space for the interconnect target module
- * @ddata: deviec driver data
+ * @ddata: device driver data
  *
  * Note that the interconnect target module registers can be anywhere
- * within the first child device address space. For example, SGX has
- * them at offset 0x1fc00 in the 32MB module address space. We just
- * what we need around the interconnect target module registers.
+ * within the interconnect target module range. For example, SGX has
+ * them at offset 0x1fc00 in the 32MB module address space. And cpsw
+ * has them at offset 0x1200 in the CPSW_WR child. Usually the
+ * the interconnect target module registers are at the beginning of
+ * the module range though.
  */
 static int sysc_ioremap(struct sysc *ddata)
 {
-	u32 size =3D 0;
-
-	if (ddata->offsets[SYSC_SYSSTATUS] >=3D 0)
-		size =3D ddata->offsets[SYSC_SYSSTATUS];
-	else if (ddata->offsets[SYSC_SYSCONFIG] >=3D 0)
-		size =3D ddata->offsets[SYSC_SYSCONFIG];
-	else if (ddata->offsets[SYSC_REVISION] >=3D 0)
-		size =3D ddata->offsets[SYSC_REVISION];
-	else
-		return -EINVAL;
+	int size;
=20
-	size &=3D 0xfff00;
-	size +=3D SZ_256;
+	size =3D max3(ddata->offsets[SYSC_REVISION],
+		    ddata->offsets[SYSC_SYSCONFIG],
+		    ddata->offsets[SYSC_SYSSTATUS]);
+
+	if (size < 0 || (size + sizeof(u32)) > ddata->module_size)
+		return -EINVAL;
=20
 	ddata->module_va =3D devm_ioremap(ddata->dev,
 					ddata->module_pa,
-					size);
+					size + sizeof(u32));
 	if (!ddata->module_va)
 		return -EIO;
=20
--=20
2.17.1

Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD79BECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B690208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XJda+kae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B690208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbeIOGvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:51:05 -0400
Received: from mail-sn1nam01on0098.outbound.protection.outlook.com ([104.47.32.98]:58848
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728462AbeIOGvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UO95+xvAgAT8qmvkUbJw7syQEamsrQhUvnbXvDfSC10=;
 b=XJda+kaed43Rs4ZgpXq1KvT8XV+CHzq6BoT+e/S4kqYAJSRuCRN4zUPOyjTE2/xy8zPxBHJA3syx9njlnAFlv0rLUSWC9nSLGaU9iooP89+Fr4uE0LgnyyN+Ms4q+gIwtcF4Bsx6/1C6o8/2cjT4GXJ4VxFlZK7rMaTHxjhwMtk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Sat, 15 Sep 2018 01:33:28 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:33:28 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mikko Perttunen <mperttunen@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 57/57] clk: tegra: bpmp: Don't crash when a clock
 fails to register
Thread-Topic: [PATCH AUTOSEL 4.14 57/57] clk: tegra: bpmp: Don't crash when a
 clock fails to register
Thread-Index: AQHUTJQM2bKNHbaYJ0qUIu9tm5Rezg==
Date:   Sat, 15 Sep 2018 01:33:04 +0000
Message-ID: <20180915013223.179909-57-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:qafC2TFSLUl68z3NLW9y9AVQi679HXOurG/fEYZg1FetblQK3Xv/NgyiFNIRPCe1ZEfYtHAJ8WOvpq0ggvKGx6Aqu94ZaWS2dqHHEK5QRjhGkXUpWpyqsg+IltCgS3voyyCf7dD5rx0CEnSs3xVZNRQq7VGNLIuJhgYbuAKNR3f3kCbDMDS8z1LwApHOn1YyZ9ih6PI09EfAGZ3U7vO8cmLE26BQFsfHryzykUH8i9l/GprrHugzWSFwYZCmOKNfwMMeDHgljDnERNzl5aaVcRlue9iB5rgiikSkhHimzNI4R1ol+h0sT2rCpsg4RQ78vcXreQ05kfSuVyovwrNUx/YeK3TOaTnuSarqHJghmsiq7ByWLSY84GchPoxX17KQAictbeIniXO8ZQqXEwaQdm8I96A2M3jQ3/1POXa+76j2xIr2uDJMz1hDWZRAINZAfssaCJdkTa1tw2al3Htbdw==;5:5xHKKdX2j3mAKmZW33m1FNi/Tf8CJ4JcA+XUVDktMO2HJd7egzsL5Vm8rvXTvglxwkz8bmcBTaxF2uz18Efday1q79l4CtGGSIjs6Xw8dvSwNOZDXKPVF+qWY+D7tcSGKKa1A266XxI/FRBf04RnWxn6SU4e8F6oBaJsQnOYLs8=;7:MQeye81MJgIExgu/KjDQ2Zolwtkm1kVUwq2puzh7uqyT4KepgJYRAy5i0pb787skwDWCnRLCbLL5hmbZu1V6docHzj7pdLJlcN3QCHXsWMn9yuZ8vWmDAEXXMzX+U8HBfT2bd8Wrqc+vQT60QaRo0mRbzzHl+l+c8CJJZkbu2w3wslF9wUTJ/+exkYr7gX1fZXKQEGBH25PLHQQld1g1MU8Xf/MyjcAZE53MJYXKaFlyw9Loo8+MKFv51MLIgiUi
x-ms-office365-filtering-correlation-id: 5e783f56-f089-408c-a054-08d61aab3cdb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB085593058455253391E3619FFB180@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(18589796830644);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231353)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39860400002)(366004)(396003)(189003)(199004)(102836004)(6506007)(305945005)(7736002)(10090500001)(575784001)(86612001)(86362001)(106356001)(97736004)(107886003)(186003)(6666003)(26005)(6346003)(5660300001)(256004)(5250100002)(6486002)(105586002)(6512007)(2501003)(2900100001)(22452003)(6436002)(99286004)(316002)(8676002)(76176011)(53936002)(54906003)(36756003)(110136005)(10290500003)(72206003)(478600001)(68736007)(66066001)(81166006)(81156014)(8936002)(486006)(1076002)(3846002)(446003)(14454004)(6116002)(476003)(11346002)(2616005)(217873002)(4326008)(2906002)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: +771q9Z1nthpdWiHuceKCLU4F4kW1j96bdCW2RqFjiSTfGT3nHS5/TtDYlUSXqNES/fhF2y3oWX7FQOXY2JZOJo2O5XIUhz9q/7niygxOJNAbTm3swDP93HLFfp6wJ9HC/T9e5c9MJ93/GioTqitIXBLBcigM9nC5tLP29tweSq/v5G/9hiXjswkDWk51XZf9/j0NXnB8H6YmNEL5ZvZwBL+rqUGJNXzQx49l36DioZiGgUYbT5l51kbjnuwElcefyjb2n3VBmYQR/9KLJDo/ASEeDewUI6lisVGmV0L0FIGZ2mDIv4FM2znk5JJdndPnwr9OaTRh0lF9iK2syXINzkYv1GKrOKbOJv56xkkBfo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e783f56-f089-408c-a054-08d61aab3cdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:33:04.5394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

[ Upstream commit f7b3182232c82bb9769e2d5471d702bae2972d2b ]

When registering clocks, we just skip any that fail to register
(leaving a NULL hole in the clock table). However, our of_xlate
function still tries to dereference each entry while looking for
the clock with the requested id, causing a crash if any clocks
failed to register. Add a check to of_xlate to skip any NULL
clocks.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/tegra/clk-bpmp.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/tegra/clk-bpmp.c b/drivers/clk/tegra/clk-bpmp.c
index 638ace64033b..6c933b0e29a3 100644
--- a/drivers/clk/tegra/clk-bpmp.c
+++ b/drivers/clk/tegra/clk-bpmp.c
@@ -581,9 +581,15 @@ static struct clk_hw *tegra_bpmp_clk_of_xlate(struct o=
f_phandle_args *clkspec,
 	unsigned int id =3D clkspec->args[0], i;
 	struct tegra_bpmp *bpmp =3D data;
=20
-	for (i =3D 0; i < bpmp->num_clocks; i++)
-		if (bpmp->clocks[i]->id =3D=3D id)
-			return &bpmp->clocks[i]->hw;
+	for (i =3D 0; i < bpmp->num_clocks; i++) {
+		struct tegra_bpmp_clk *clk =3D bpmp->clocks[i];
+
+		if (!clk)
+			continue;
+
+		if (clk->id =3D=3D id)
+			return &clk->hw;
+	}
=20
 	return NULL;
 }
--=20
2.17.1

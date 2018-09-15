Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8859BECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD8321476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="o+kCfgm2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DD8321476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbeIOGtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:49:14 -0400
Received: from mail-dm3nam03on0093.outbound.protection.outlook.com ([104.47.41.93]:53619
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728320AbeIOGtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgDk4uS8qUqKJCBXhXkRDxSgaWB7siYnPbOMih4enpU=;
 b=o+kCfgm2optAez4UxjJpV6qQeZZ1xJ/Kazw5XN4MBrlCnT1akMcjDrnFINnXV5TF/a/cAqjf0Ezp4X+yl0n1MKhAjlX9TAmeKfOhQcm91U9OuRHC+tWPDCUkZa0Ijy/lHTS3TdeliD9C1q8YFhYZCbYVX9QdEC55ZkNMc9XckNo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0117.namprd21.prod.outlook.com (10.173.189.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Sat, 15 Sep 2018 01:32:13 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:32:13 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mikko Perttunen <mperttunen@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 92/92] clk: tegra: bpmp: Don't crash when a clock
 fails to register
Thread-Topic: [PATCH AUTOSEL 4.18 92/92] clk: tegra: bpmp: Don't crash when a
 clock fails to register
Thread-Index: AQHUTJPCBny7RXr4uEuboSWhdkLAFw==
Date:   Sat, 15 Sep 2018 01:31:00 +0000
Message-ID: <20180915012944.179481-91-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0117;6:uryzReuzXHGpKwZ/TeTmI1E8KhlUT4IYnVNhocLZT1akDgIQ19tdZfYHbuchwBdG9NusUFeGcJktiDl5odVmM0eMRc2UEJ/VbXVHVkUMY+Wp/8WtbsfME6C+8ao5mS5NU56wH+JPk68+6X/rptoW+5I/0Ukl4KPJ98GIixs/LIkjD511EaQ2kyMVxqF2EZnZ34scqG1auGeCicqWk1VQpWzH3OpVsX3q0JoBQ0hYeBaB89n74F7kQwoA/ty79/TC2P/SdnYzSyHs9FApEHIeKUGIvDg6c8DznpU+chDIbRI0yjviZsMRTNzfVfTbhb0cR1agwPmjpZSFTsWrQKDEmZDgLIYDd+O4ldfT30xNhsLbnjwOyCBCDHmkelaMwUb31eqNcHxSpTA/BVtZitaoTOIe49nOrVcg89Wb/0WZzLnqJzSNH19BJrhxjrLH9upUeP+XfDk7HHGIZciVmB8Yhg==;5:u7/KMfaN4nkWEBg/BPOR2u88v++xQq3DW7DjcCQcEQOyTsAL1hWmVFcMqQzAdl0+Nz6ceO1T5yDlP+HnLzlBL7QfNmzbu2vqKMVd0PI6is81R1mU4LEXBWzfw9kMfPcpR/whWpRCeRP6/l1WiVKyCaOjwWVQMpDQFNIrQsdmnvs=;7:GSlYX2W8AeNqp+uDYJ9DAUqHmE1cVbpZrpVz8vIfCdNxfzxb7AvMjK8pKY48ATaX7P/eOXc0NiDNx/0j7xswftFPHcIRuGRcbNKf7hMZRfMhzatSAqrxmcgQaqmt4bEXsHaXuMRS5WZYyzzvOY/uWTN4OMvUlPVdkIQ0YRDctGCSq2OBVk/eh4P/VzbOOc8KYg0FyDEYp8f/TlKzSiqkHFdklPdYq/f9G/Ml3T5QDcr36UFMgb6LuIptD2+g+RaT
x-ms-office365-filtering-correlation-id: fc665a02-e4c3-4621-3a7a-08d61aab1042
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0117;
x-ms-traffictypediagnostic: CY4PR21MB0117:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB011765DD689FEA57B02E9341FB180@CY4PR21MB0117.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(18589796830644);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0117;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0117;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(199004)(189003)(36756003)(316002)(2900100001)(110136005)(54906003)(8676002)(478600001)(5250100002)(2501003)(66066001)(72206003)(10090500001)(446003)(86612001)(476003)(2616005)(8936002)(102836004)(11346002)(486006)(86362001)(256004)(186003)(6506007)(22452003)(68736007)(26005)(217873002)(305945005)(6666003)(2906002)(6116002)(3846002)(1076002)(106356001)(7736002)(5660300001)(105586002)(53936002)(14454004)(6436002)(81156014)(81166006)(6486002)(10290500003)(6512007)(99286004)(107886003)(76176011)(97736004)(4326008)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0117;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: slAPrQY8JquYFT4rxB0Z9Vi3NDB1gfX1FIgAy3qGoeOn0KPFXesIkqz4DeYzdPUgJEAxSJ/P49kJm9F8ZTbpvdV6o7ZmKk+9doZw6k0hKWI9OItBwwzgRqw0TRaQRf5ODnF+gbKz1lwwtTu0ZEJ1NAJsdai9SY3LpUkgmYQ86Efj7w9KDiaOopkxmwvR6uktwswRKPxfhoYX0sl+Kz3IIXS8AP2mD9PZse6zYKcEYPO44HLT1uJUTlxAhEchVlevceKJxwAkxgXkm4bgZWK3cyK1zyoUQNb7xRKdIZjpXCXVXC+bq3v/OFMf0ssDpM60lfVPWYc/ViIrEA6d+r6Xe9Zen6uUIivUg086N/gfaw8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc665a02-e4c3-4621-3a7a-08d61aab1042
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:31:00.3541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0117
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
index a896692b74ec..01dada561c10 100644
--- a/drivers/clk/tegra/clk-bpmp.c
+++ b/drivers/clk/tegra/clk-bpmp.c
@@ -586,9 +586,15 @@ static struct clk_hw *tegra_bpmp_clk_of_xlate(struct o=
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

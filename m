Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28A6C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C3D20841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nhu6yizZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C3D20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbeIBRUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:20:42 -0400
Received: from mail-eopbgr680109.outbound.protection.outlook.com ([40.107.68.109]:62112
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728001AbeIBRUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wphOC7OYj7eEYUFMTbV6oGDyKHNrEMlZaOwHpiBsdlE=;
 b=nhu6yizZzURvwLj7N9THwk+nKzep0GMBXg0/37CFw8vZHiurvcKSGcq2CusjX3xSrZLwRKXS09hYFLNyL4V/nqVYBDL6N1Arvbc/C8rw4QXylKvzRzGgEyOq9bPASHtl2eTX09+w0R+4GfZBg8nyQD07yqiPpkTmzWyTYeP3RYs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:54 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:54 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 075/131] regulator: tps65217: Fix NULL pointer
 dereference on probe
Thread-Topic: [PATCH AUTOSEL 4.18 075/131] regulator: tps65217: Fix NULL
 pointer dereference on probe
Thread-Index: AQHUQr2Bs+3VPWSqD0i75bJgHkdq3g==
Date:   Sun, 2 Sep 2018 13:04:39 +0000
Message-ID: <20180902064601.183036-75-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:A/qBqaEjrn++H1qHspYqxGy7qKv1rAB9U2rsCMzUZDjWgWwgKubyucSk6yxqtUg1cKpYZq677O0y1gP/5eLfuPgNwp+ZCmtMtdHD6TyxAIm26J2cVW4qAcUMtzfL3n3kPfrDBamxT8Na38mf9GFJVFY+ja8whpx5BVVjfDtd/GMNxtHBAsXP1OnXL9mVedFIjEHk4mzzkEkKDZGgzy0QpT6trzYGUc3tPCyFnl0PTJnT9OfNJyjgxC7g+bro5bsnKE1kGE6kCaHRizY3Zg3Wf6eiAY3AIhtLmho2qjyJj7ZwHMqD5YfgEa+XJHVrC1ldLwTFCVZBzwrKMMubgQXg1u7Lq5S6uBDmK34VnPvFWOQgeKV6PWAwkpyVgsQF8wVgEHleqFdlP6FHcrcNffoCsm+6qza+xlgX8vmWC+h8IOupfZ7XQ8SR+wtUC14YlljJ3K/OKwuP3/Kfwx5iiX3gJw==;5:Jvfr6O9cBYsz72O/9RaAcIGtclVWSi5S1moPG+Hcn7ioomKGyJGfNy85HtDSnxPbor59bA1dGofvu8kJVk05iqDta/5LHMArQXgxYxBud4q1dnO7OsIWcSanf74ivJa0ZNeLeyoK0ZEwgI6utAw50ohke5iaVHgTgm2y57K0CGU=;7:wU/zdWDJhb96Br6OFRXBJ2dDhSwf25hUTSrBrL2lDTjTaKMmZvMiXclcHtPUHWX10aKncMN5Hf2GDCRfnoajOjBSpfuzu7Uhq5TdpY7Qsl+pRBJj3YUjc/Zgt3ttZkQ/8n5yaYk0CxpDddGbB/bTMBOaGiaNLT+GxpDdVji3HpDIaIP1Ex0lfs66yVAd+3NvE+/lg1ky9OsU/uFlAo6fhgfnmOSdcdKlwK3DlahqM1Ri2wVYuQcoMtCHPacE2G8A
x-ms-office365-filtering-correlation-id: 3dae98fe-083b-4436-f936-08d610d4ad59
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB074171F325111EF9E38CB04BFB0D0@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(97736004)(2906002)(186003)(26005)(256004)(4477795004)(14444005)(102836004)(11346002)(25786009)(476003)(486006)(2616005)(446003)(305945005)(66066001)(5250100002)(2501003)(7736002)(6506007)(8676002)(68736007)(76176011)(6666003)(99286004)(6486002)(105586002)(81156014)(81166006)(53936002)(5660300001)(22452003)(478600001)(6436002)(86362001)(14454004)(54906003)(36756003)(106356001)(110136005)(6512007)(4326008)(107886003)(217873002)(3846002)(2900100001)(316002)(8936002)(1076002)(10090500001)(6116002)(72206003)(86612001)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1CnyxEtXqvzSbFjYZCVIwqqfOGq6c03kauZ1DrIfTeA07zORQDxOsgIKOdAvIFDKzP4a08wVbk+ZdiAHzeO2dOa7ubkN7NiEQscqkhJeMVvuvlWuaDEf6s04NQCV+Gq1v1slqqOzNd+Shur/idlTbEdhS5Bp7GeU360eq2W3t4T4a8G1D4Oh0nmhXX2I9DCnxbrDJqF0p24PBoQ77PUqQEmCIlzVpXLyzSrn3e8q42Mo84+F23TQSlWf+neI2KT6iITz08DupF/H71k75ZTknDg9lpKZ7C3v3JaukUL0c+YB+w+Yj4m69mhPKAYK9YUhfS1XNX/tqyprXnPOu9yrNP55jBiSgUW6IVN1ONXCt5w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dae98fe-083b-4436-f936-08d610d4ad59
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:39.3372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Vasilyev <vasilyev@ispras.ru>

[ Upstream commit 4f919ca2bf6da826ba1a4316e1b8e9c94e5dbeb2 ]

There is no check that tps->strobes is allocated successfully in
tps65217_regulator_probe().
The patch adds corresponding check.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/regulator/tps65217-regulator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/tps65217-regulator.c b/drivers/regulator/tps=
65217-regulator.c
index fc12badf3805..d84fab616abf 100644
--- a/drivers/regulator/tps65217-regulator.c
+++ b/drivers/regulator/tps65217-regulator.c
@@ -232,6 +232,8 @@ static int tps65217_regulator_probe(struct platform_dev=
ice *pdev)
 	tps->strobes =3D devm_kcalloc(&pdev->dev,
 				    TPS65217_NUM_REGULATOR, sizeof(u8),
 				    GFP_KERNEL);
+	if (!tps->strobes)
+		return -ENOMEM;
=20
 	platform_set_drvdata(pdev, tps);
=20
--=20
2.17.1

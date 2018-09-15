Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1381AECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B636921476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cTzayvwJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B636921476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbeIOGtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:49:47 -0400
Received: from mail-co1nam03on0116.outbound.protection.outlook.com ([104.47.40.116]:27616
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728614AbeIOGtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ij05clVcs4ySqDt9V0Fr7MbT7jUFMzRvYx6EcgsUL2Q=;
 b=cTzayvwJajfGKDkfouXPplB3DHg49v3spMUNNuFul5re5FD6LY+kCNlcCjNizSnwQ1/zq0qFyikvfQu7QA+i0m750FfKTSV8KoddKtq70M2ePoJBkMxutrGcVgY4MVeu4ZGGa4+3VWzsg7uUj68YlxZgcmeE+82F5cPusSaanX8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:32:41 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:32:41 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 19/57] ARM: hisi: handle of_iomap and fix missing
 of_node_put
Thread-Topic: [PATCH AUTOSEL 4.14 19/57] ARM: hisi: handle of_iomap and fix
 missing of_node_put
Thread-Index: AQHUTJP+JZ8vBoWH70ecqdJaID3EFw==
Date:   Sat, 15 Sep 2018 01:32:41 +0000
Message-ID: <20180915013223.179909-19-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:eStUusSF5pxr7Joc3zLc0DS7eGyTi8Rl8tsxrHhq90wZgjrhqlX5lOtAObmqe7KMTQlyJCMLHOs03B3TL4T3BCKLlyiFbeFFk3DvWc6bFaFwOk2asrNgjQ/iGF+lrtPoqmLS67UNF1ykn9h6/HFsu9gi5mAdqjNcTvn5wUBAaNyKzwT67GXPy9a3eMYwosMY7epE8Fc1ARvIdK1/yGLYVqNwZoepQhvzOK9QbSWID0KThQoJkbTMee5mBSVainw9dLxDQ3KNe/TCRWxsUq7JwNeXYJfQObW3l6M0wqDwViAIBsarwCODgJ7Ia4gxCSs7TS3yMHfhnskhOBtkqxtdGkZPOSSiHrASbo5QkfKVo+Bdncl+69A8mx0UItT09Ds6XXhebskVDxTjqyPmUltCTgqKhaZsZl9EAbdMPEhUVjCVM1WndS2SrpXCGhUFwRNIJu3QTdrmMyk7VzdQFGxEYQ==;5:pUlyNuv59zwRrLGXIu8swo9o0H99R/cvLhSmDrAT4P0AEfbw0zYJvqywTmV5FQYjwhUeeeiFG+D62ac4rBwwISDQuf6QlhHI0nh12Nzkv8kYLRwfTVmO1gPAZPUvPL4Fx+Rgf4gLvXHjyQfObBSQlOIV5ylSD18pA3xXzGB+dFw=;7:F/3WQxrIcOqKWh16FW3d4iIo0rjwNqLghwuwUelCRRahYSvXRVT1SVvzoC1sDJQDSSUHCe/WFa/WlKViA7+sUbuZqjaB+g1QDOmREoAIe/csEcitIlEAsBuDOOgdB4wvXPUlB6K9nR01/1qcJRg0GDrwNZNz3RK555tM0IyFGd3JZSp8RPpsXzzij4B2QyGKlKdAFWv+C4oxCNF4rqNS8YZUPEl2jJXrfFUVRH9qDINIl1RHFi5Z26keVcFvQPhY
x-ms-office365-filtering-correlation-id: b2f7f236-31e4-407f-b7ae-08d61aab212b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08225AA5332F6E17F5D5E375FB180@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(1076002)(72206003)(6506007)(102836004)(478600001)(8936002)(10290500003)(2906002)(81166006)(81156014)(5660300001)(22452003)(2900100001)(8676002)(110136005)(54906003)(107886003)(99286004)(25786009)(4326008)(316002)(10090500001)(97736004)(305945005)(7736002)(6116002)(3846002)(256004)(66066001)(76176011)(217873002)(6436002)(14454004)(36756003)(476003)(86612001)(6512007)(26005)(5250100002)(53936002)(486006)(106356001)(11346002)(2616005)(6486002)(86362001)(446003)(186003)(105586002)(2501003)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7LIuBfCDSaRUwFVZERbvhjM8po9veq+7Lo/S7gEHnCF7OAXF5WrPObXNZH1fx+EFVS9maAM/SZGxbggOatrm/1PHmBfLKO1phHG/C53lFkL2C1X1y4VyxzKLzX0WYgMw/QpRJSMmFsMJdvERiR36YBzdK2o5WOGVo49u/OwfMvVYCUcMyYRJzssP5N5KrOB6NYyRxU6BDRIqH4bBWy/KwUuxUkgQbfXBLb6dmTmb9c6OI2iuQMPyEYOlljqhpmBjSQli4MSqfigM86jBInit7twNDSsKJR8tyb/s/v542QcoJ4gDQ5eJj+gIib4jBWf7TKbbTc5l8BGNtccII9j431s3ENr49wiG2c9vx27rDMk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f7f236-31e4-407f-b7ae-08d61aab212b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:41.6809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit d396cb185c0337aae5664b250cdd9a73f6eb1503 ]

Relying on an unchecked of_iomap() which can return NULL is problematic
here, an explicit check seems mandatory. Also the call to
of_find_compatible_node() returns a device node with refcount incremented
therefor an explicit of_node_put() is needed here.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit 22bae4290457 ("ARM: hi3xxx: add hotplug support")
Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/mach-hisi/hotplug.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-hisi/hotplug.c b/arch/arm/mach-hisi/hotplug.c
index a129aae72602..3f28c9141b48 100644
--- a/arch/arm/mach-hisi/hotplug.c
+++ b/arch/arm/mach-hisi/hotplug.c
@@ -148,13 +148,20 @@ static int hi3xxx_hotplug_init(void)
 	struct device_node *node;
=20
 	node =3D of_find_compatible_node(NULL, NULL, "hisilicon,sysctrl");
-	if (node) {
-		ctrl_base =3D of_iomap(node, 0);
-		id =3D HI3620_CTRL;
-		return 0;
+	if (!node) {
+		id =3D ERROR_CTRL;
+		return -ENOENT;
 	}
-	id =3D ERROR_CTRL;
-	return -ENOENT;
+
+	ctrl_base =3D of_iomap(node, 0);
+	of_node_put(node);
+	if (!ctrl_base) {
+		id =3D ERROR_CTRL;
+		return -ENOMEM;
+	}
+
+	id =3D HI3620_CTRL;
+	return 0;
 }
=20
 void hi3xxx_set_cpu(int cpu, bool enable)
--=20
2.17.1

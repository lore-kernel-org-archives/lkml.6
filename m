Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F2FECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE5E208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NvYOa2lP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE5E208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbeIOGwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:52:25 -0400
Received: from mail-dm3nam03on0128.outbound.protection.outlook.com ([104.47.41.128]:36672
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729846AbeIOGwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ij05clVcs4ySqDt9V0Fr7MbT7jUFMzRvYx6EcgsUL2Q=;
 b=NvYOa2lPS0Hya/ri6pCS9uB8B9a/fK3+wkxTWX5CDiCVsk1iM1oV2NCxZzix9aL2LQcAMd4d/erShGI8J8TnTnEld5HkcE3PGEXPcNsy3i6cFw3e4Cls0U31BqwJwwc5oGzGiMqph+sb/XGqA8KgGc5R/J+XNZG8v8voTXP0zz4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:35:19 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:35:19 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 06/20] ARM: hisi: handle of_iomap and fix missing
 of_node_put
Thread-Topic: [PATCH AUTOSEL 4.4 06/20] ARM: hisi: handle of_iomap and fix
 missing of_node_put
Thread-Index: AQHUTJRWmLnUhCPIaUaIoxUW9jT2cg==
Date:   Sat, 15 Sep 2018 01:35:09 +0000
Message-ID: <20180915013502.180110-6-alexander.levin@microsoft.com>
References: <20180915013502.180110-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013502.180110-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:iea9mcIlwMMPlqEtDVsegybPXgX+6mZBZdio7nO93a9oalrT66Se4VXvP91oQuzQvB2hvltK5zpQK2EmM4SGElXIHK1wt+X/LS6/svq9mfPU5sxJu4PP0y23utnftATAT9CqnsqFqN1Z/eIBthw5+N1BjsKri0v891RHgPTSjda5wwbnbU3eYBxIFrC8OMBNlIjPWZYn1b2WuSQqEjhRC+Wdr39ImR2WhKM8KH/qdzGYiZiRyC1hQVcj1O5bOObkn7hirLPu5/VcqHsHwP5fBIY2RdZUAhjZ2fCZTw5SXpJylgEqQC6cG0saX4FQXZDcgtV5saU7wwmci8W9Pav9Q05v9SoxGi1RqcH/ajkTMec1qJKChRf0HaUKlrlgqpLKidKkwJjA5XF4Vm/nHgL8tesIeukzCaD4PL0uGIO5eQ3zTdtZefQ3tJw50xAeqMavI6piBb/4OkfzCYDRGf1zrw==;5:xlxYHZ44clDoyVT9Qw+JIthVBMqZ5rKRcwnpUAWELd0C+bISE5JgCCsTLEhzeWNdGN8WP9BBZIyKmVsA99RY9rp6uHGu8Ah376I8RcI1fImTLkGdFfnkUJHOtzG1ed0uxD6Q7sxWuqD12T5B9v+E2CMeb5i22TPRRokSe9TkWhM=;7:cTdHy/RSHhx7uf9/KvhUDUSPvN/v4vNs1hf9q4gQYPaiJSGkXxWIFVu5vR/NxnJwtt4GyircQfEdxoLNZFjwY9W1P/D7bEN8i2HadsH16z+2ulomC+0R5qro319yUPZgT8xtd8TUJ+GKwe2cGAPcMlSBrUGKokdoo+FGwf47JCHwlSMrd/Xi2122gdNqvheMCHOa5pSZKc7q/Knqugq8VtF9mVhEQjujUVr2PjL40K4xFN5hjnVQQp+Y8yVkDylM
x-ms-office365-filtering-correlation-id: 4c1c10db-57de-477f-d48d-08d61aab7efa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
x-microsoft-antispam-prvs: <CY4PR21MB0181E313BAAFA199DC6FB7B5FB180@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(136003)(376002)(396003)(189003)(199004)(66066001)(68736007)(6346003)(186003)(3846002)(26005)(1076002)(6116002)(25786009)(97736004)(110136005)(54906003)(6666003)(2906002)(72206003)(316002)(10290500003)(217873002)(476003)(102836004)(478600001)(22452003)(2900100001)(36756003)(256004)(10090500001)(4326008)(2616005)(76176011)(14454004)(81166006)(11346002)(2501003)(81156014)(305945005)(5250100002)(6506007)(446003)(106356001)(105586002)(5660300001)(486006)(99286004)(7736002)(8936002)(6486002)(86612001)(6436002)(6512007)(53936002)(107886003)(8676002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Efs90IrxYDGXFWfNp8VuRYIVyDOyn0Be/u2k1DHD9yMSp/gnnfSUItdVmCpgK0byIVeZapUb/6f/2z35cECBNZIvsuFhwgVJpVZpK/yrV/XO6/E5wjkjOAqpTB/IZWvfJcM8/dmp8xbKCY9Y9mpyJokuAtH8rMNgI9rKILP1f+CadwWxZdCBNmghrutrkYTRN3V24+z8aCGDAuWKb9evERNztgjGHjWNzXo9plQxLOEULpFd4v1qpBobrtz1bDD91wu/MohcSUPn2O3rcAeqY8WJbC9GWi92R1UoRLBcL5IzxxDiSJYo/1wU9foYJfGBGR9zHy0crHcZoOyBNn9DNWW4YUXDCJMj59Z7AeeeXnw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1c10db-57de-477f-d48d-08d61aab7efa
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:35:09.1760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
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

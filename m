Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D714ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE6F208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FrKADG4r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE6F208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbeIOGvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:51:41 -0400
Received: from mail-sn1nam01on0117.outbound.protection.outlook.com ([104.47.32.117]:5202
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729639AbeIOGvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4vC5/pTSEEJm/dHn+sIOfMu10/pnO3PLab+1BsY1V0=;
 b=FrKADG4rUmoJ2TIPZTPxH0/0LbZI6dE98fm+HkCTMIe5oMOLMSzvfPjQkoCaSP3MsSLNUHOETuqOj/Rj3Y4iBX52y6SIA4317gxrKgkZmBHuIrRUUjZ8pfHW9jcZwdzWVWfUDCkjQD3MCA43u3n11ZgzqyICJrNH4R4ZYNFBpyg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Sat, 15 Sep 2018 01:34:32 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:34:32 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 11/34] ARM: hisi: fix error handling and missing
 of_node_put
Thread-Topic: [PATCH AUTOSEL 4.9 11/34] ARM: hisi: fix error handling and
 missing of_node_put
Thread-Index: AQHUTJRAqcc8HnH7qU2AHStFnptt2A==
Date:   Sat, 15 Sep 2018 01:34:32 +0000
Message-ID: <20180915013422.180023-11-alexander.levin@microsoft.com>
References: <20180915013422.180023-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013422.180023-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:o5kEepRTDnsy3lwm59pzFa2LV5vJL3r15eD2ILHF9Ll34ydIOyvxZ4GNs8vPU1nwl05/wL6wq+IlpDRFCZA5HOtkSgHYwjCGTe1t+75t9s3HxXN3TqQ8GVrFzBNmQkallBykgFOeT4azykfNGtLmGmx0KvEmlG9aMvpYfBrT3OsUWVwXwoZlISh0TEcHnmTGJzr2B2s1sRbEESPDZWv3CgQ7DxXNlOmrG+P+TORlYHQVILzcBFhrXBwjqpc2Vg4iUh81eDcYTLfetR/DG09f+rMoIwY7b6NslhtbqGUGyT7lzKtbQwOkNHTSS5FUA6RM2Do/mDqUH5cblRjzcN/JjCFApBjgYi8ep7ZP+zs/uWCfYzbcTE3yKhgY6kjHSPmt9oueIPxHyTrTbZgD3L+M8cf8MPdPPJBqh9vAoAFrlxuQEWbfFYOEox2HQ0beKZH5HhitGFxjMvd7jGDKIElCPw==;5:FkviOkLCotyStaBly+duWTRXyIuMl+hAZGrlVwg5xcpj2L1efZ01Q0GAbOfjg5QWrDFn2/uQq+IqBiaVhnlfIOahEcyVyDOfsE7tcAlc/KFKq/pXt2FvkjukIzNmck4fMmqc/++FvVyNYTHXiMHX1jOfU59P+b1u3gcFPIpwTiw=;7:pbSQkH4CV0YtvVFYaaBAAnllKdm1jNZCZn3LVbvxJ8ItVKKfGnPunDfjXF34FzDgdW1Rt2nc6z6gX5HJXpq3kJozAIMXBx5ykIzJJxUGuk3w+MisvEbDOTxHKI4SviZ4iG7hysAgHRTsyoMt0pcDJORQOrk7dwmrfgWCaFnBVI4RypJfQOG5oPItPmyAU6bywFtEequJkHd4hI6Dd9X2iUHvxV5O7cNT/iRT7EImxhwV7UWNMlJWsEFoVaLXp0Vl
x-ms-office365-filtering-correlation-id: 25b4f161-c47f-4a03-d830-08d61aab632b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB0855B2250DBEFF1D250C3F5DFB180@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39860400002)(366004)(396003)(189003)(199004)(102836004)(6506007)(305945005)(7736002)(10090500001)(86612001)(86362001)(106356001)(97736004)(107886003)(186003)(26005)(6346003)(5660300001)(256004)(5250100002)(6486002)(105586002)(6512007)(2501003)(2900100001)(22452003)(6436002)(99286004)(316002)(8676002)(76176011)(53936002)(54906003)(36756003)(110136005)(10290500003)(72206003)(478600001)(68736007)(66066001)(81166006)(81156014)(8936002)(486006)(1076002)(3846002)(446003)(14454004)(6116002)(476003)(11346002)(2616005)(217873002)(4326008)(2906002)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: BEoT0pCwqaCaTe8i/9h/vydbLFA3/Iq+ZhP7tLV0R3BqDxRgWXbpsspwQTBPH0R183bBFP8hH0kyG/pwEY44ymML77v+pvFAO+wr59UFItifw7nVDO98EEaQsive6DAu4J9YDZODiNfYarT38Xc3+XcGxvpiFaOP003zokHskWkujYZ6lDhrv9UIzVYFO1qLYM5vyvC6wptC2vouK1vUF8Bwp/dMSRMFArgUpzmDrkC+y9EPsTd7FZJEeHvBQhj/Yp7EMkpPUWHk6XqTYaLAaTByEYtCOnRXrKhUIcwl4lfEKzL1rdeBN1JwXHFA/iEVpGF8qAhf/9F3PRZUKH6Bg2lDGgYou6nIBpmr9vM8/Rk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b4f161-c47f-4a03-d830-08d61aab632b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:34:32.3801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit 9f30b5ae0585ca5234fe979294b8f897299dec99 ]

of_iomap() can return NULL which seems critical here and thus should be
explicitly flagged so that the cause of system halting can be understood.
As of_find_compatible_node() is returning a device node with refcount
incremented it must be explicitly decremented here.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit 7fda91e73155 ("ARM: hisi: enable smp for HiP01")
Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/mach-hisi/hotplug.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-hisi/hotplug.c b/arch/arm/mach-hisi/hotplug.c
index 3f28c9141b48..32870560b280 100644
--- a/arch/arm/mach-hisi/hotplug.c
+++ b/arch/arm/mach-hisi/hotplug.c
@@ -226,10 +226,10 @@ void hip01_set_cpu(int cpu, bool enable)
=20
 	if (!ctrl_base) {
 		np =3D of_find_compatible_node(NULL, NULL, "hisilicon,hip01-sysctrl");
-		if (np)
-			ctrl_base =3D of_iomap(np, 0);
-		else
-			BUG();
+		BUG_ON(!np);
+		ctrl_base =3D of_iomap(np, 0);
+		of_node_put(np);
+		BUG_ON(!ctrl_base);
 	}
=20
 	if (enable) {
--=20
2.17.1

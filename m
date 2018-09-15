Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A045FECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1A4208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hGHHU8Jc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D1A4208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbeIOGrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:47:31 -0400
Received: from mail-by2nam01on0094.outbound.protection.outlook.com ([104.47.34.94]:11650
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728330AbeIOGr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GT/TDmfOutQMkEgTrGNTbv6HG68fFM8GTOBNpTM5fYk=;
 b=hGHHU8Jc44+iwCCAwmKlYD4lFhTg6lVD60BqqoZQl6AyuKoF6KrEi89csgK0BzMELgB8B3tNfvUtcoLzlxGVUdpbyyHk7qMb8hPIDb+Amt4T0aszgZIwVwb/Hbn9qdXRWRb6B9UDtbeOzdOm9tsdjbILowh0ghKDfCmrU/hgtnw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:30:11 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:11 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 30/92] ARM: hisi: check of_iomap and fix missing
 of_node_put
Thread-Topic: [PATCH AUTOSEL 4.18 30/92] ARM: hisi: check of_iomap and fix
 missing of_node_put
Thread-Index: AQHUTJOlo0KEYTHo8UOOoCPNxmZFLg==
Date:   Sat, 15 Sep 2018 01:30:11 +0000
Message-ID: <20180915012944.179481-30-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:0hTHMF3ypZpOI80YhyYbe5/UvWQzeexTAwU/NYu0ej2kFsbmaPKDV9Gd9AijV14ST+CQQYRw4X/jXjVDl6WskLezyUiPqn4zEZUdkmGaUSOEWRSm1HNnrL6kdkN+hgPuh7mTHJb3No04DncToESXrmBnotMF4g0l/wFt/vDbgsmWjuMwt1L2QeLnoz60RQD20wkCG82T4ecICYZcoWkeK13QZHXx5on3CaZhWpkXRDUMTOONkTI1Fq/APtNOuh33b5AQNNzVfAaXQq5JdpgdlqrFS5XBhToZtpzv2L8IRa5ghDNR4/LeqDgdhH4w3g5+CQsvHIsHgVJcsgcfJT/Uaqdpa3rJDmBYxFVIlfO++s/OFy6sJeMHLG3rv/L2oxQL8IYWHs4EbZx2Ais3vjiSjMnOHNjhrve+KgJETon2oTKHq8cf0CDYsRf/7/IYmN6846hR/ylVeSMskMiUpmh3Fw==;5:jeo16y+r3gFLyTH24eMMqwpbaqr0kfxl16wYqoFOLHh0RUnB7+6S8cv1wXEYWbqDeReE9SIhCcH3qatVK4OgFzPY9lNpWbZ8wiN2J3d4/WMRpE5qB5NEvRzb1LLlPMTMhmRPTGI08d+Ak0BRc5IZCV3xnJiUXHvPva7Awe/Gnts=;7:jIjMlJlY28pRu7zci2xklQx0V0HwOAHK/O2ufWrwmoP7FKUajSymrZFPUnusa1bCiRyc+HnQhcT5AJH1QfkXR492mSkUPXCcFz1eQTjYmfn339DphJDPwNQ8Ar0Ry9Y14Rfww/cMbPIeHOpWrfnxyovUgQQwe5OpMkGUALp/KPku0fTDp/3cC7o83w457AsWal8gS/Oqm09eN4bcf/1hN63VBWb2MFDkyNRXAJFe8X73aJnUx5OLLXTP1NptHfjc
x-ms-office365-filtering-correlation-id: b94f147b-5a0a-40e0-1908-08d61aaac794
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
x-microsoft-antispam-prvs: <CY4PR21MB0741498ADEFB0D4D95EFE8AEFB180@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(376002)(396003)(346002)(189003)(199004)(186003)(106356001)(25786009)(6346003)(6486002)(6436002)(476003)(102836004)(11346002)(5660300001)(2616005)(26005)(217873002)(105586002)(486006)(446003)(4326008)(53936002)(5250100002)(14454004)(10090500001)(2900100001)(256004)(2501003)(10290500003)(6512007)(22452003)(72206003)(8676002)(478600001)(110136005)(97736004)(68736007)(66066001)(81156014)(81166006)(2906002)(99286004)(86362001)(86612001)(575784001)(6506007)(76176011)(8936002)(6116002)(3846002)(1076002)(54906003)(305945005)(36756003)(7736002)(316002)(107886003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: CU2aoHxJLMmhCocYw3U5fE3VZo4ZmV+DZvs5k5lJe0QqccanhJdc0RI14IMp/1j+KRy73qRaGd216dzQfJJI1+UQJYP239QQL4wXswL9+ULNwtYoK01TjfSTa/29dBpL7m1iXFSUtHOiEcvcc04r+L0hfT6KUBILosRbMyQkKlXLnWR1EjZWToFSJBdhh/ZuY2uPhXFr6XnsW+xhnsf08beIvXF7PXmruv5IAVZgrrQxQSC0eyY7fx5QIg3DU8okzUsDkSDo0qIXiMRMoUhL8E1XO1wdVZxTIxOER8R/3Yk3b+3QCaAv0mJt9DqXeBoZpLo4jEuyonRsnVRtzEQCrU8MXhQkfqi/xp9vGLsFqBU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b94f147b-5a0a-40e0-1908-08d61aaac794
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:11.3544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit 81646a3d39ef14749301374a3a0b8311384cd412 ]

of_find_compatible_node() returns a device node with refcount incremented
and thus needs an explicit of_node_put(). Further relying on an unchecked
of_iomap() which can return NULL is problematic here, after all ctrl_base
is critical enough for hix5hd2_set_cpu() to call BUG() if not available
so a check seems mandated here.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
0002 Fixes: commit 06cc5c1d4d73 ("ARM: hisi: enable hix5hd2 SoC")
Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/mach-hisi/hotplug.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-hisi/hotplug.c b/arch/arm/mach-hisi/hotplug.c
index 32870560b280..909bb2493781 100644
--- a/arch/arm/mach-hisi/hotplug.c
+++ b/arch/arm/mach-hisi/hotplug.c
@@ -180,11 +180,15 @@ static bool hix5hd2_hotplug_init(void)
 	struct device_node *np;
=20
 	np =3D of_find_compatible_node(NULL, NULL, "hisilicon,cpuctrl");
-	if (np) {
-		ctrl_base =3D of_iomap(np, 0);
-		return true;
-	}
-	return false;
+	if (!np)
+		return false;
+
+	ctrl_base =3D of_iomap(np, 0);
+	of_node_put(np);
+	if (!ctrl_base)
+		return false;
+
+	return true;
 }
=20
 void hix5hd2_set_cpu(int cpu, bool enable)
--=20
2.17.1

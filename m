Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15600ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4BA1206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nYhdhqhR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4BA1206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbeIOGw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:52:57 -0400
Received: from mail-sn1nam01on0126.outbound.protection.outlook.com ([104.47.32.126]:8380
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729020AbeIOGwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNYAnWR8dBrKLhrRpzJY4Uqxom8k5sxtN1PQkPS6OxY=;
 b=nYhdhqhRVlcrhB0ezevAAhmadi4fQiNJyns3C8yxCWGeLHJpPqtzy7mjDD/OAvU6sohuOA+vJYPs+stvdFGaQwRayp0ToQi05zlAC5CR3S/vvkb/tAXYx7K9svVLPD0F2/P8pzFhQwJk+mgBjiWDOWd7ccBvMhC4cIS5ZFPJyvY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0280.namprd21.prod.outlook.com (10.173.193.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Sat, 15 Sep 2018 01:35:28 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:35:28 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 06/11] ARM: hisi: check of_iomap and fix missing
 of_node_put
Thread-Topic: [PATCH AUTOSEL 3.18 06/11] ARM: hisi: check of_iomap and fix
 missing of_node_put
Thread-Index: AQHUTJRhMX1q0wo+ekan9p3TLcjf5A==
Date:   Sat, 15 Sep 2018 01:35:28 +0000
Message-ID: <20180915013521.180178-6-alexander.levin@microsoft.com>
References: <20180915013521.180178-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013521.180178-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0280;6:VF6j6nLlSGT4oXqKGASxX7vkDClhy8/aIylBZ1OPL4mJLpJjxxPPeaKAF8M6GOmrKxGqgHkwNG9GzWPYQZGLKKZcZ/8VCjkpGYoiq/8xSRjt1z3fVDw/oZydS64DwOBdK3or923wuAEFSBDnYjUujhLys9KPUBtAdCRyzBE5XFIe4HEfrbaYPpD/gxDemCz2daVY33CAMANRoaug97kQgvbLDNFtKGEw1i+17s9oQneOObEf1RrUwodsZbl1myGQl4+CQdQGjSxTtd30KE90ZXssOP3x1R597VEU/S6xAZub08zsWsBaKSGnzBlNaEoBNe66kQwte1RuPXQnRbdeq3B5R9P9oq+BzC0Rplm7ei3oY+1Zt7EqpKyDEFf2S0WIkB/z+unDNY7BZORLUkdFjefQJ8/gtd3X0e7+Pl5Z2tE6kYcPqckvQidMqh80nJSVBK9Exhuhd341a/VSZLQH3Q==;5:xcOZSOyCjSVJ5edAtvY0e4fi2RU/R5nm3l79k+AJY3WdPDsWleH0ogL8DBKXhMvIgO2jzzYmkakNuagPgye5imZ9xjbT9WQFCitdMamU6bAZHS4ydhWnQk8KMtobcCISIs+1sRUl3Z/z5lQNtqGiHeqnLSp4eJeU7ihyowvvyGQ=;7:mj8NIhSsa1OWahkhiHFFKW6myAyaK2/Vxlzn2bPEYSGI84jWmkzTO4EJnqasVO6cG655RdkmBK/QgEVBKJIGLKXOP9uXlprqbJ3MJFiKWBRSmV5niRM6oAnBwqc9BnDOc4L8rImyLpY3V89DtZPjInBksGnHIX7cObooOy8JcQb0+1kwI87UWE1mgzyVHwMxRz3xuMNGWso9OO0hjMMsBoXZtFTxrP2pFet6EMHWTSS1Fwep7bo9phBHCA7jwHTk
x-ms-office365-filtering-correlation-id: 4e8674ac-64f6-44ad-769c-08d61aab8479
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0280;
x-ms-traffictypediagnostic: CY4PR21MB0280:
x-microsoft-antispam-prvs: <CY4PR21MB028069015C1BC60B5688F2C2FB180@CY4PR21MB0280.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0280;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0280;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(366004)(39860400002)(396003)(199004)(189003)(25786009)(14454004)(10290500003)(2906002)(4326008)(6436002)(107886003)(72206003)(256004)(217873002)(478600001)(5660300001)(6512007)(5250100002)(2501003)(97736004)(53936002)(6116002)(3846002)(8676002)(7736002)(305945005)(1076002)(6486002)(36756003)(105586002)(10090500001)(106356001)(22452003)(11346002)(2616005)(476003)(2900100001)(486006)(446003)(66066001)(76176011)(99286004)(316002)(54906003)(110136005)(6346003)(68736007)(26005)(186003)(86612001)(6506007)(102836004)(575784001)(86362001)(8936002)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0280;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: YsozMYCraW1bv+5zy/lC7MMMd/u9vrHC3cXy445lZCVnkh1laSnC3Biw0U4hJNy369enWJSbz42aiFIQcOxf37fAOfdCCo5Dw06nq517uLZmimJB1mr9H9aVw8/fY1Dds1KrLtWAAE0fJ11zdzY1+0dlBp8ujongb5oH57IXhnQCSIw3Od6DqqEJyjpY3DIwcf2b6+WiwlJDldDxxuB5lRr0HTRkrco4zb43hJfAjW7ryR/HB/6ZtjNW9+zEDHfv8hjHh6u8OllndyWvUPTALAzy5UduTjxuUGo23AYJA5xxpVOMV4d+rW9vmbM9NuZPFiIEWKVSkhNIPGK4nsjLvwGRKiwCpR8YPSAG+3A+Trk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8674ac-64f6-44ad-769c-08d61aab8479
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:35:28.2380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0280
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
index 6385abcd321e..f31b4d99b5fb 100644
--- a/arch/arm/mach-hisi/hotplug.c
+++ b/arch/arm/mach-hisi/hotplug.c
@@ -177,11 +177,15 @@ static bool hix5hd2_hotplug_init(void)
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

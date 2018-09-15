Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6142DECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E34B208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bLULIKrW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E34B208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbeIOGvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:51:40 -0400
Received: from mail-sn1nam01on0129.outbound.protection.outlook.com ([104.47.32.129]:50720
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729612AbeIOGvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GT/TDmfOutQMkEgTrGNTbv6HG68fFM8GTOBNpTM5fYk=;
 b=bLULIKrWEvWDxG+EDK3aNz+3FDAUz7W2sWkcgGfyh5WIO+kQEAJTkLhBk1P62nGrZijS8AtM1GOtxdWvFA4v+VSij5TzLktMn5CDLvmH/Jkkg7mA7X/lzkgbHfiMInXbwz81TIo9OJKZGYzsOwwwz9ghwKIqV0GX9vbbvlkcpn0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Sat, 15 Sep 2018 01:34:33 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:34:33 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 12/34] ARM: hisi: check of_iomap and fix missing
 of_node_put
Thread-Topic: [PATCH AUTOSEL 4.9 12/34] ARM: hisi: check of_iomap and fix
 missing of_node_put
Thread-Index: AQHUTJRBf8GG6kQnDkazAdggkDqqFw==
Date:   Sat, 15 Sep 2018 01:34:33 +0000
Message-ID: <20180915013422.180023-12-alexander.levin@microsoft.com>
References: <20180915013422.180023-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013422.180023-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:sPZLsSyQdU9gGiuz9eyx2rZdInDr7RCNmQg8ew+xFOB/OMf4nCh5rSE7PqUvWBKgK0te4DGEocJu43RfUeYaeStjEp1OR9f39ioln28wPefuncEaxmlasWPG+zAWyJ96Cg6FcUArNxxZaCvoO29JFthO19fGRM4FZPJtBhPoHgBnLcTxyLsmiLYL5pGz+SwMBfNntPgGCdENfFo4svdH92uJL6/Plx6TuI6nPJuMiGPNEov55CVar8hvZbN45gusgDioGjSk3MD2TaK4FDNtcNYr8aBfi44VNjxNytKBucTNvkIjp04A4pHBv1B8y3FoPgPWNmlzZRy6k6x9ZyuXn8uKOq4akldcRvaVztTCg920aT4OBjCmxEXJdEns9kYO3LMz0LgLVHK+MgLGN+shUXeHtMnWDVqxXn7Qz5jgMTEOo6JAFq/ri2vj2/f66wSWcPtGiPViWhhoGBjKvD4B9w==;5:SZIaY7DQqDppNyQu5lpothI1mQSGdRCEFFHBmurCUNwC1lLkUEIeInYaZkNcsyHPtxzlJMbuZKeJsIXhuIPzfcir3uRlx7kPfzgcBnBxD5xotbRENlrt5ZfiTRknNH3ipY4pzOnxLp9HPqQlMtePKwCq0JuwCHZYXZ1PvqWvfjE=;7:SugCdnbElMo+BMmY2Js29izuJu+AYG4URVm439jeLuyHO60ZlsvpaOuu5TmXvIYa/wTQSCUmKFjtHDo5M71ImvAw1v/cFZLjY5jD4JhQG6H864PGL7Kq824XXGN0vXcysdsTqNL3S8OprFHuEzAv5nSDv4h3tqvKqmg6i+G4ajySFyvB5YkCYYj+lwwMH9rb+px9nq+hO3epm9gwydOIZEZ8dfye7wbtg9XMK7fL7MfmU7Psby58QMGjXeHU0qq3
x-ms-office365-filtering-correlation-id: 0e61ebe1-dbee-4a0e-97ce-08d61aab638d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB08551A0216BF0F4519B11DE2FB180@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39860400002)(366004)(396003)(189003)(199004)(102836004)(6506007)(305945005)(7736002)(10090500001)(575784001)(86612001)(86362001)(106356001)(97736004)(107886003)(186003)(26005)(6346003)(5660300001)(256004)(5250100002)(6486002)(105586002)(6512007)(2501003)(2900100001)(22452003)(6436002)(99286004)(316002)(8676002)(76176011)(53936002)(54906003)(36756003)(110136005)(10290500003)(72206003)(478600001)(68736007)(66066001)(81166006)(81156014)(8936002)(486006)(1076002)(3846002)(446003)(14454004)(6116002)(476003)(11346002)(2616005)(217873002)(4326008)(2906002)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: E5LE57/x1wpEec65fNc39TxQfK8BFrE5qYAxzznvXWe3O9bYK4imx6lOS9HsT2KM/MfqDHmwHUY7x4QE2RYKOBLDZe6c9ZOMz5e14fB2y6QgXP1v+NjGkLDbKVAlat+SR8uIHdS0rGFt+MAgSagBvo18f1TeqyemJyEYq+JPDcGHrYCtFXT1rnsu822X9GW7nsRomBSSdQSCmBItdlYrpsXnlF/lfBar1cSN2Zo9ndusW0a+hBoWO0uQJuhCP89n6Ijs58eNTt6kAt09NYJuMtWheCcFrYNo+n6m4djJObvmLwB46opYK8hYc8GjOThkupluUNQz0oZ8Uzia6Vt0BwoscCqoElGIG52s2QjMolw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e61ebe1-dbee-4a0e-97ce-08d61aab638d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:34:33.0676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
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

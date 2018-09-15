Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CC1ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88F521476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PLBS32Bv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E88F521476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbeIOGw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:52:27 -0400
Received: from mail-dm3nam03on0128.outbound.protection.outlook.com ([104.47.41.128]:36672
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729020AbeIOGwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GT/TDmfOutQMkEgTrGNTbv6HG68fFM8GTOBNpTM5fYk=;
 b=PLBS32BvjiWIv1Qke3aK8dv18vEC7wSWC1PSJaEqlmw9LEg7BhslIAcjZjQv6H9Qdw9WhIKvQvmNtlzVm8ptea6GFkB5EnFUl/cmRyLoy4pvJA/mVqoNxN2AqoGWGqK4ojga3JsdGRb+zryGWZ1WQnl42+iCcKDoQ8xqjs96rjk=
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
Subject: [PATCH AUTOSEL 4.4 08/20] ARM: hisi: check of_iomap and fix missing
 of_node_put
Thread-Topic: [PATCH AUTOSEL 4.4 08/20] ARM: hisi: check of_iomap and fix
 missing of_node_put
Thread-Index: AQHUTJRXLMsZxATt9kCQbZIzRi7F1A==
Date:   Sat, 15 Sep 2018 01:35:10 +0000
Message-ID: <20180915013502.180110-8-alexander.levin@microsoft.com>
References: <20180915013502.180110-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013502.180110-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:MFIq/qTqbtjCVFiWeO3iQe6mQjO20yNZ5U1siZOjTDBDLydX47G8GYHrxze6YVelUjVXKtoHAzQFeHj0+MSaNKYy+o/0feN/uthiVl/bO38orM8PS2RBL134S5pjYNSM+w0mwC3qRPEkHg/f4Ml9jdJ5WxIVrvs+Rti4Lvq4+dOTWz2dXxOMzAXZntFYD0jKs7NzVP8FOIKlHyOogEyk4gNMzJ9uvcqeVgYIEDwN90p2314EDxMc3JZsM3PaBEFhPicMF12jLV06qehvIdS24bqBhmus203LXrv6I4sq2HV2N3jAYks4LNgDCOU9lITP9SSAc1Ljw5MsMNZyFyAgye8+4EGuJ44JjCJYOS/YnXsnS6ffHP98AYKNWEK16s/EN9p4ykf7an4aoywEwi3c4ByaK2wnDh8GL0j4qvTsmJnccdqitWAgq78VGCnlo+JK1QfwZDlqTwKAE3NDnuGMVw==;5:HJeviQ8RvOQIRJFWoK7cFUCjq8UhEhw1EpnkGoUw523K18kBtMRDIM7uyopQdMHHEh10JRmz5A9fkM+lfjjBTUn2Fsku9H6demaLD3F4aTZhOjNwhWaHMT9RaVDWddp7jwOVng+qqzyUMSUdvB6WquH8PzelFLfVMmxvC/wYUQk=;7:PEPMrAg24V8lsS5FSDfrQp2dvuuyQ4YyIEJ++9Ek8/GS6gcjS9yjzbTdArXnjfSxZhHrXbHsRIaVLOw6iUVMQ0aRj5a1Db67zhpRGK5kbnJwP7OJQkH3vM0eEWSGoS6LTVpBZbh/Vw/kX7WxltPfbZUETOREU1QANZkqGl2fVCJwJ9IPrEy4uIHaTJ0m8fwFVfYmOu5uV/fcEvJjr5NCAOrNVr46+Zg4pfoFsxjxzJvtnbSXxeU9BEotRoNTbAA6
x-ms-office365-filtering-correlation-id: 8db6ad74-00e6-4623-095e-08d61aab7f72
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
x-microsoft-antispam-prvs: <CY4PR21MB018187CD5D466511B32105DAFB180@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(136003)(376002)(396003)(189003)(199004)(66066001)(68736007)(6346003)(186003)(3846002)(26005)(1076002)(6116002)(25786009)(97736004)(110136005)(54906003)(6666003)(2906002)(72206003)(316002)(10290500003)(217873002)(476003)(102836004)(478600001)(22452003)(2900100001)(36756003)(256004)(10090500001)(4326008)(2616005)(76176011)(14454004)(81166006)(11346002)(2501003)(81156014)(305945005)(5250100002)(6506007)(446003)(106356001)(105586002)(5660300001)(486006)(99286004)(7736002)(8936002)(6486002)(86612001)(6436002)(6512007)(53936002)(107886003)(8676002)(575784001)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: cGCvX6R1XwKkovnGa8/JsMNnQEjnCk63avqf4BS1XD6DtnbX9DGbpEmTwVwcYl82unCaqNUcLhSFufrclQB3YSN5zRipPFC559KT92hlVGsnc+HdaIBcRrgw+WAPx5d0KfJUCiVZc0qj43Rkv3HG1cNo9i24/teRx4lp5yTOUb0hpjr7xghz+w1oIZV5DVS2DosSaJcBioXssy589Tw2sPYzyokQKJ0F5OM+bZ6PIISjbIYdn3CWLTDExJqMhDBs2RNw3ntaT2P6LgeW17ISPqbx56z96lImg1tj+P6jL/1kYP3WPqTIapEn5jMdhtxN0BI124WbzgCzbKW+JKqgRrNLaK/DjSjo60qaD1SWDX8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db6ad74-00e6-4623-095e-08d61aab7f72
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:35:10.2541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
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

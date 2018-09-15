Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484F1ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E031E208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EFqPABVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E031E208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbeIOGts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:49:48 -0400
Received: from mail-co1nam03on0116.outbound.protection.outlook.com ([104.47.40.116]:27616
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729202AbeIOGtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4vC5/pTSEEJm/dHn+sIOfMu10/pnO3PLab+1BsY1V0=;
 b=EFqPABVl64cLVrGFwRtoOMP1zea19HW1hWySodRwSEtV5h9czT9rf0bTvac44ofiDTaAh2treR68KV6bks5r01r2xUF6TEW3kw1HaHWJi1y+PEJQaeSBJ+0u0U4GqTbHV+07Wo2Um4suk5uy839r/Yzi4UObE3ID3Pc7uhJWXaw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:32:42 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:32:42 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 20/57] ARM: hisi: fix error handling and missing
 of_node_put
Thread-Topic: [PATCH AUTOSEL 4.14 20/57] ARM: hisi: fix error handling and
 missing of_node_put
Thread-Index: AQHUTJP+x2E41rkyhUy6FfhbTBuaqA==
Date:   Sat, 15 Sep 2018 01:32:42 +0000
Message-ID: <20180915013223.179909-20-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:37C0Wpl16ydsLsdAZDE29O5vjU1PGDStPL7hEMUCXbmpd8WNE4Yu0hbGOEG5ovVE7nwACOwO68eIADkiPZX11OBGbMuZLYVT2pzBQtWZloLDqrxjtii8Q8xpdIWjN+ZMVKfPbbJo5XtwRhCqimZFdVirG0qAgqyFPL0Eyym72OGYMtYgfL3O8QrOuR6NVz3fPbOZqPGVKt2MEPAkQPVtxur2ooKv3OxPijmUNFGqS5aeau6mWVhTHQsg0xMkGkOPANpGvji42/OmAMY+Y/XUvJy5ZIBh55/w1GXtbpTkXi3M1oujy4HRVkBx/Hn01tBXLjjWToXXhHXmuiloSCNI8HBUOKBXQwUf0ihFnMWCpneGXcpsljLAkoBjPX39u8uQagfZBegxQRzvEWQXnD2ipu1i+YK59C6We9alW/CjJZhzu62gk6bhoWQB8F5t2HegVPHAAh0hDiLlftjgDhP1Og==;5:19JZXu64GHY2guR2Cb3ugA/ePJfzUi20BhI+EiJo8hYk8RYavBLxeiWpV78JPz3YW2bYc7uHr7JH21ohfTSfCOYu9a1ru55zQP695v3L7spJJNOd33u+AYp/AjmUcn7zpT/YCr39l61djUaUNpsQwMCJv1ysYbab42WzXSJ+ctQ=;7:/sLYgxrqXbbmpt2rrjzqR/OMf6iVb1QOCYCcmj2KrbZmbwrBeYh+OA5IBnqyQKNSCfDMq0NT1mcQFdXmf3024iA/mo9kUbOANOCC5kCtTfP7RTem7K/Saw7kQmggOSGcmJycr6gS/sf4lCTOgVyfrF7WAsdwQ9LNGMZajdxDEk14hQCHbmehOG+72n2g3z0SftG/NFLpWW/yC4oJch1q6SKib2RQFhmxjJ0JEwkwfau7m021XJVIAFD/RWBnrhbi
x-ms-office365-filtering-correlation-id: 2a2e7428-c6bf-4390-8b73-08d61aab2181
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08223DCF0F0DF0C78394C4F5FB180@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(1076002)(72206003)(6506007)(102836004)(478600001)(8936002)(10290500003)(2906002)(81166006)(81156014)(5660300001)(22452003)(2900100001)(8676002)(110136005)(54906003)(107886003)(99286004)(25786009)(4326008)(316002)(10090500001)(97736004)(305945005)(7736002)(6116002)(3846002)(256004)(66066001)(76176011)(217873002)(6436002)(14454004)(36756003)(476003)(86612001)(6512007)(26005)(5250100002)(53936002)(486006)(106356001)(11346002)(2616005)(6486002)(86362001)(446003)(186003)(105586002)(2501003)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Z6en6PbA/9MZhU54s/3SBulsrRMVV2YlU4zoH8kQKrVUYf5jmKSRp+iJyd/eepDsxqmHNWswC4qYjknmAljA6s2Q5TH9hrqIg6rNWpbywbi9nEbWCu+dDiu4aAgzNhSU6mkiw6Bnx/gLWUFBVr4W9bvLKO8eewdyKQ7tL64Uc8mXUk0SHmydmK/yjswoMn29cGW+TYWJ0pivQd/q+3aEuj8btnJ8HQCdChgkFetmX5wUYtAcWiLyTUOFndbJjnYHLEOsaYgYZSxgi6cnrA+e+Lef5sS9zXANjKqBn7pi1oOXauztnmw5gV+NkocuP6Wgt0BriA57DoxixxZSN+x3/5oyb4gfbTZKj1oJB7wgCXs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2e7428-c6bf-4390-8b73-08d61aab2181
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:42.2434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
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

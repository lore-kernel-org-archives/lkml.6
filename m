Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9991ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A3D208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YtAUncgI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A3D208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbeIQJDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 05:03:05 -0400
Received: from mail-by2nam03on0114.outbound.protection.outlook.com ([104.47.42.114]:33973
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728348AbeIQIZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAISTbhvsYKJqkEDupBCZV3PVE9ObqTF2FL7hOKgOIM=;
 b=YtAUncgIqF0iP1kkA3VJGDAgQJI4CeXzKOXQTfgm3lUzq0C2TrE614Yn6jNTV/0oWSJkyVNWKfdT/NHH2VsXSF3uo26aHkktG/rQtRjzG/QkfFCYkLLEn7Lx4p9LnFO72jEJNhLmtiHqZWIjZj2IO/hukp0FHgX5R/1ilauXtPs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0277.namprd21.prod.outlook.com (10.173.193.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:00:22 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:00:22 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wei Yang <richard.weiyang@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 011/136] x86/numa_emulation: Fix
 emulated-to-physical node mapping
Thread-Topic: [PATCH AUTOSEL 4.18 011/136] x86/numa_emulation: Fix
 emulated-to-physical node mapping
Thread-Index: AQHUTjKQRvC3qg0eI0GsgvZE9MW3vQ==
Date:   Mon, 17 Sep 2018 03:00:18 +0000
Message-ID: <20180917030006.245495-11-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0277;6:Q0pJ/KPuft0+tLPmTkSv4niKq1RCiWxCnS+XPiYhpmI21yChsjMDZVnIfdcjm9gySsVnC+scEQTGtpiUx7rQdeJUkopIQmw1kqiT/mjXPABSjy/NM+TY2ToBXLRCSHcESZwmJu7hXsw3H5BI9PFsfcobNTeGZqy4XoRfV79L/PcIX/ZCBvIhvdWLIj5H0aTb1mjasJzGcM/GdA2t9DYONVw8mDInkQ9brOGYXpH7giaE/GnITjyhaQPEQFyiJA+iLSNJ43wmKaN7e0tU99LgjhiRuDjq1HhMrOnrOHcvNYDO/7Rqx5+bCi7ToS4i4oA7WRL/Y8B8zji5f3tu2Y+UplRkHex3vhONhqnz6xsgOg7NxqL/Ei9+i0xZ632GgD7ZhGw5Kau7Nl43NG9OKHrvUnDUVVrBaGzpb9gwFqzFgaeW+l1sAz+2KHP4zUKnIUz0WabOOcpDy1i5qQR5wSmU3g==;5:5FbFXKGumo/boDPa8gj1zwdmh7f0G0aVI9AyLiZ1Ov8GQvkwzSQ157RhBPP6uMiOtDihp0JpD6bJfM3vVFR5Nvi+zQH3uTODiJ+OaD3z0qxYby0m70i1SySNIxPPjBpkIb0DElxDt5EmWmbvcjDDUwcfuKsGqQsIrEggtjUebSI=;7:XHinUUzYaBFH+O4aoJjxAG9gS0Ru0XS/An764AcxSYW+fwPiKq7VgsgGwPYMfuoRAw6Mf7wVKn/LBCZpdy4fUxxZsjVItPVO7vWIQ/P6vCuU7+0yE3Wv/KWk1kRCRn/uVMBJd7zxZOvKxKQywxvDCkeJ9B6eKNAtZgoJdDF7q06//txXH8NxGJ5/mYt7Vi7YMbwRPRRYTzl3wroejvqu+YXlo0IEaoP33CKfsFATC5dQV9RKzsz9zwHGbYSkEuwS
x-ms-office365-filtering-correlation-id: 283f8d74-b8dd-4635-e349-08d61c49b5a3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0277;
x-ms-traffictypediagnostic: CY4PR21MB0277:
x-microsoft-antispam-prvs: <CY4PR21MB02777311B7EF7CB491DDBF25FB1E0@CY4PR21MB0277.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(228905959029699)(211936372134217)(153496737603132)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0277;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0277;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(199004)(189003)(446003)(4326008)(2616005)(53936002)(107886003)(11346002)(22452003)(39060400002)(68736007)(486006)(316002)(14454004)(106356001)(476003)(217873002)(7416002)(25786009)(105586002)(10290500003)(14444005)(97736004)(66066001)(6486002)(6436002)(5660300001)(256004)(5250100002)(6306002)(6512007)(6666003)(2906002)(2501003)(6346003)(99286004)(72206003)(2900100001)(26005)(6116002)(186003)(1076002)(36756003)(81166006)(6506007)(10090500001)(81156014)(86612001)(102836004)(966005)(86362001)(8676002)(54906003)(8936002)(110136005)(305945005)(76176011)(478600001)(7736002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0277;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: cNh5aqrfzJfBxI7CXlqsJVIqKPcZQxoWTDM9y+u45+hr4RSQZravjT2Yhqi8luveowMC54Q7yxKbJv8lagukbMb4i5G0SRPSVQ607Ngvyc7hcGOzIkN/V3hVn1sm1Y3CXrInA5LQxIynXUerk3KeHGr+gRrDYMEOKPMtyoCJJjx2yslOxjfIf2pOjGStbzlQfX5I1gSgChGPyZY6Smd0KI9ak0/DeQ1OFgFVRa+GN7W9VoEr65SoT8xPnbTZ450mUEhYGAWyR5LF/+FOieY7l5vI2FSjp2cr71PBXqjbmfuYpXqXG//98rzizLZ22AgyMzgkafCWTrcNXNEuUPrvYm7wdSmP2F/FykRLYbwbIZk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 283f8d74-b8dd-4635-e349-08d61c49b5a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:18.1205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0277
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

[ Upstream commit 3b6c62f363a19ce82bf378187ab97c9dc01e3927 ]

Without this change the distance table calculation for emulated nodes
may use the wrong numa node and report an incorrect distance.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/153089328103.27680.14778434392225818887.stgi=
t@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/mm/numa_emulation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/numa_emulation.c b/arch/x86/mm/numa_emulation.c
index 34a2a3bfde9c..22cbad56acab 100644
--- a/arch/x86/mm/numa_emulation.c
+++ b/arch/x86/mm/numa_emulation.c
@@ -61,7 +61,7 @@ static int __init emu_setup_memblk(struct numa_meminfo *e=
i,
 	eb->nid =3D nid;
=20
 	if (emu_nid_to_phys[nid] =3D=3D NUMA_NO_NODE)
-		emu_nid_to_phys[nid] =3D nid;
+		emu_nid_to_phys[nid] =3D pb->nid;
=20
 	pb->start +=3D size;
 	if (pb->start >=3D pb->end) {
--=20
2.17.1

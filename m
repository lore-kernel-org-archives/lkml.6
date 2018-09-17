Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844FEECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E4E214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WtbYFcfn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E4E214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbeIQIaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:30:55 -0400
Received: from mail-eopbgr690131.outbound.protection.outlook.com ([40.107.69.131]:27472
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729403AbeIQIax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6EFB+hxxf/uX9T9lsQKkr7PTWDd6uMzxiXGp3m/DjA=;
 b=WtbYFcfnbSIM0AxZaixeuWDAgUBp8He6P43vFd9KOcKts7h/gjF82/IUu6JqK9Z7AM2OuqhujRsyr0TM+BAgUN9XcGFOJA3vAgHZ/Gp+ZGLsZMvDG0NJkizbDU0/AT5qu+Y0sEWP1emxzp2dKfRKM+4WGlxd0LRPAsJzjqNSjuM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:05:36 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:36 +0000
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
Subject: [PATCH AUTOSEL 4.9 04/57] x86/numa_emulation: Fix
 emulated-to-physical node mapping
Thread-Topic: [PATCH AUTOSEL 4.9 04/57] x86/numa_emulation: Fix
 emulated-to-physical node mapping
Thread-Index: AQHUTjMMGfqWOa3mOUOx1VC6sY7vgQ==
Date:   Mon, 17 Sep 2018 03:03:46 +0000
Message-ID: <20180917030340.378-4-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:pWXBnYWLLsIKceKSB1QA5AfINxBExUEH4y9vH90MgeqPeCjuwGUqWlb12W/0HeXZtJq9Y73GuJPsb6aeE90PnGwCU1AMxcfsJrSCte6W7h+TXZCwe/e7wQdyJqXzdFSwFXMpchASlY668rlAgwOSHO75Qr1jbP4xUrQTh8/1LaNEffIupMBPNAFkIXVly1Z01qXf25u8lBm3UDce3Ah04ALD5hvyGMxYKmbBPQi+DWF0BK8S6yjBIKS6ESeMIPUcgOdG+ekS8smmoT5prrkvos/86UCuYo6d469Adq1AEzgu4TeTml7CztqztR2dd+QkIECKEhFtMtL2pq2k+yfad5UOWBQHNkDGu2OziRYqFGGxeYphlZTeJs6/SbRkehoL4HBRJ6JhVCLzT3EVleJyjbzOgWRoHXX4jU9xlVBsKRFo6IZrpZMDMU2cOQ8At3fR9eQV9ogQ9AhK2GN5yhFpYA==;5:tEMzfmhr6SbWkTGZ/xwhir+d55rhnATNSD7g2kaBzQhL6rQeUt5vjaj/7E18v88BHgkaTmCHt1XCJPlxwffFsRvF4UOpPzvsQDjbp059Of57MM/kIdI6C+RwWpI4bz3M9QfFXKlfQXxn1aW2I0hFMLEB/XCRz6nbsfne8zT7dfg=;7:njzzWVE6FhFzvJF++s1l0YY8auSKTGvNV2QgObAPdQnTqBT3aOYnJFlChTO4javnOscI1bD1KFrCWMBxRG6tm+n6qZbgFz0rzgXdlE5buSinIAOvTqhvyXJRlQ9IRtfSUXW+6LEP8ZQFSp9N3BXg15Rf5cxqi8mBBpgF5j3GSDxynq9giV2qrViCXziT/7Ek90judxfK89YLHHfKWPUWAxRg6bpApNkAj1M/36gcnRPgT6yTYuKNcUQXyzqCxuar
x-ms-office365-filtering-correlation-id: fc99dec9-ea05-4b6b-6794-08d61c4a70e1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-microsoft-antispam-prvs: <CY4PR21MB0120B1776B1DE951C74BDA28FB1E0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(228905959029699)(211936372134217)(153496737603132)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(54906003)(26005)(110136005)(446003)(2906002)(6346003)(99286004)(316002)(86362001)(25786009)(102836004)(10090500001)(2616005)(2900100001)(76176011)(97736004)(36756003)(11346002)(72206003)(966005)(478600001)(10290500003)(3846002)(6116002)(1076002)(22452003)(107886003)(39060400002)(5250100002)(2501003)(86612001)(4326008)(217873002)(105586002)(106356001)(6486002)(14444005)(14454004)(256004)(6436002)(6306002)(8676002)(305945005)(8936002)(7416002)(6506007)(81156014)(81166006)(7736002)(476003)(486006)(68736007)(186003)(66066001)(6512007)(53936002)(5660300001)(6666003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: dNqd4LW4OVBfSmTLMXfz5nPM2rllEWVQdX7sglCjfgjd9NIixuRGvahYSLWXCwgUsTcOe5QRP8JkTMqnMsxxedgUWPwCuwym9eD0/KsdBPIky2ogRuvvFLNgozVVu6Q2X0LSzlPvSCh3NUuuH5UJAnP1hj4EmYE+dB/3j+gG5aR8yyNY3xREYKPoq6cBII5ozhTS3zdcs97euBe+FH6m6ocYFObwwM6nbnnRlLxgEQFRnGLeAbTYqwoRe4eEq1vn2U7qc+EodNp9FFsKdM6wzmiOfiuCGrNyMzAIRdDzeSo98WCn/DYpKy492wbvKSTAG0GkjMOFB8G1+OyWzMfU4TIa2YYdYDyl27vK3fP0MhA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc99dec9-ea05-4b6b-6794-08d61c4a70e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:46.4930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
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
index a8f90ce3dedf..dc6d99017f3f 100644
--- a/arch/x86/mm/numa_emulation.c
+++ b/arch/x86/mm/numa_emulation.c
@@ -60,7 +60,7 @@ static int __init emu_setup_memblk(struct numa_meminfo *e=
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

Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A4FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492762083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="m71Sud7k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 492762083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbeIGFRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:17:18 -0400
Received: from mail-eopbgr710126.outbound.protection.outlook.com ([40.107.71.126]:45789
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730327AbeIGFRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkJPn+fotjk74b5NoSPl72AywsOEp+TKWI9TEbUQ0po=;
 b=m71Sud7kQdL1lOVdjeYmtk35jDFWC1UGzh61PcYWygQULH3XozV4QhpvjQQOZNnazF21aYG8QA4x32ta41i5SK5KisackKT5ueZU2C8gkGeOmhr9IxA4f+zrzzjBINnI7AO3bOGtLaUQzB1SCXbHKo2biGs43SsQTuCx+GKPiUo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:39:04 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:39:04 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 50/67] arm64: fix possible spectre-v1 write in
 ptrace_hbp_set_event()
Thread-Topic: [PATCH AUTOSEL 4.14 50/67] arm64: fix possible spectre-v1 write
 in ptrace_hbp_set_event()
Thread-Index: AQHURkMGBNn/uGXqH0qN5ilV0K49hQ==
Date:   Fri, 7 Sep 2018 00:37:58 +0000
Message-ID: <20180907003716.57737-50-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:BAiGOxtrPIkUtOzCYJiUztWZb2Qt8zdI4Z9dMBXSac4c5VUVax3xuAiHFSfkSuctnNvt9jd0P/vJGf6LRxI7FHOSk7w7Vd/B9nzYEfGjw3AW+sKMBwbaTQ3A+B5p/xU9lpz4H9/vsj8FuAErjLiCZZyWWceWPjEDLYMCAgkgetHKJwOpZMER5E72QYN4hQX3S5bmqozZS+hFWhiA7w8QYN4QmmcibowQji6HfJbZ/ebiEDyLDMnuaPmqrMQnV9pL5uNmJ1Hakk0v7C3tiDORXW3nimSGs1OqUI6oHuz9CkgHBwFFjALL6IG2/LQyMq9ZUL8kMWtxvOX7LwW+v2uTNkpQOZ1J39eGQJGlE9olmBIXQJ6MBfFnJ3AZMEs283QYNQ9PBbTk5xnDL0JG8/6itm2eOgtjEnxs0OqbHS/TSYoymbOtSoMGZDib78NgSr5M9cWXeyWWFQVQJBKqj7g3pw==;5:t0+XR4NKFowmJn+idWZHrdYqlN7L4TeTPAdZYRmMVlCrSuKRZ2Sxu/vcmG9AoZ1LR0KYqGyt2ALNlix8bRH0WnM/qm7nFqbAkHQyvEKWZy4/885b6lchg+gXXChQLmhFAF3JAxlYE2bnWAdcnnvgmFgVX3dQBy7/jx5S2dT6VjE=;7:wZhy+HrKKPe3KH6Sc7bWKBus0ycA3FIPa4lS96sFwnU3EGo/QWJyBSCalEuRDhK7JB1ZTseQsI2+iozUGNlsrx+mYMaMarKlu3R3HGighHFgH5TZZrjQ5ek//I+V8twwBCVIjMPWwmbq/JNQPmV+11lHBEwPhy+WuPTowvIPI4dv6w8wCwWGPX4xZOGFmeZbf1idByKcaRAuStdXJbfl6XHu64F8h1nGUtlECE0irFkaqV1UGuRu6G+GKQk5cQFQ
x-ms-office365-filtering-correlation-id: 80ff2207-ce80-4dda-0e87-08d6145a500a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB0839DA785BEC3A4793C1B4F3FB000@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(136003)(346002)(39860400002)(189003)(199004)(10290500003)(99286004)(10090500001)(105586002)(106356001)(102836004)(76176011)(97736004)(6512007)(53936002)(2900100001)(6346003)(316002)(54906003)(110136005)(256004)(26005)(6436002)(107886003)(2906002)(86362001)(186003)(478600001)(5660300001)(6486002)(446003)(476003)(68736007)(7736002)(86612001)(11346002)(8936002)(1076002)(22452003)(25786009)(2501003)(36756003)(2616005)(486006)(81166006)(81156014)(66066001)(6666003)(217873002)(4326008)(6506007)(5250100002)(6116002)(3846002)(305945005)(8676002)(72206003)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: oh3us/5ZsK4pKXql9pX6Pj8VP2AhAUnGiFzueseKZjnqv3TD01p5CWpCFSly89pMwPFksIpGQ7T9F5/3OwruiBIu7uYUX8I68GYVq1wwmaYviytNzQIjVY8pDdSl7gJKJg1AwKdRrQoZxZsSZ/i78AvtYulF4XtXJbsH5VgGmWdrmhXsfOlEiQ8GWTW8mUah+E1ys5a1Qp1TlniALzytTyn40e1oG4MpDvzonVC+4MEiBDL6dqNZA146acmCkYcqwQ/fsbqmcyZnJrJ8suABTnVBqh2sUy5vANjGcfkyGXFsTMzOtWGyjmG5KE4k7qo/l386D0PxAkC35YGFRIhwjhOISvjMKBrxGx3iClSKUp0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ff2207-ce80-4dda-0e87-08d6145a500a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:58.3172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit 14d6e289a89780377f8bb09de8926d3c62d763cd ]

It's possible for userspace to control idx. Sanitize idx when using it
as an array index, to inhibit the potential spectre-v1 write gadget.

Found by smatch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/kernel/ptrace.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index edaf346d13d5..34d915b6974b 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -274,19 +274,22 @@ static int ptrace_hbp_set_event(unsigned int note_typ=
e,
=20
 	switch (note_type) {
 	case NT_ARM_HW_BREAK:
-		if (idx < ARM_MAX_BRP) {
-			tsk->thread.debug.hbp_break[idx] =3D bp;
-			err =3D 0;
-		}
+		if (idx >=3D ARM_MAX_BRP)
+			goto out;
+		idx =3D array_index_nospec(idx, ARM_MAX_BRP);
+		tsk->thread.debug.hbp_break[idx] =3D bp;
+		err =3D 0;
 		break;
 	case NT_ARM_HW_WATCH:
-		if (idx < ARM_MAX_WRP) {
-			tsk->thread.debug.hbp_watch[idx] =3D bp;
-			err =3D 0;
-		}
+		if (idx >=3D ARM_MAX_WRP)
+			goto out;
+		idx =3D array_index_nospec(idx, ARM_MAX_WRP);
+		tsk->thread.debug.hbp_watch[idx] =3D bp;
+		err =3D 0;
 		break;
 	}
=20
+out:
 	return err;
 }
=20
--=20
2.17.1

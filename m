Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779F9ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28495214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Qyp/nWWO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28495214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731524AbeIQIdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:33:11 -0400
Received: from mail-eopbgr720091.outbound.protection.outlook.com ([40.107.72.91]:17664
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731476AbeIQIdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MC56tfRnkWn0BXlI6tNvN7mX6LvrEXawQyYuw4ZIeqA=;
 b=Qyp/nWWOP9l+qRobkwdOH75hDyQKtlkvUwwj4gjsPCQDt1KA+yD0SyLg7SV9Sv/Q2ZmsUS0jjrMvyPEhxwmDzxv1gZnkn2HU/0O5OpkbuRhSsuoQtjBvcfWx45Sv+f6WrVEZV6miWAmhX9EP0fwX8DaK3Odh5Op3Zz+jThkEOuo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0150.namprd21.prod.outlook.com (10.173.189.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:07:52 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:52 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Vasily Gorbik <gor@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 13/29] s390/extmem: fix gcc 8 stringop-overflow
 warning
Thread-Topic: [PATCH AUTOSEL 3.18 13/29] s390/extmem: fix gcc 8
 stringop-overflow warning
Thread-Index: AQHUTjNTorVvmDoQ7EmK324akVYREA==
Date:   Mon, 17 Sep 2018 03:05:45 +0000
Message-ID: <20180917030533.592-13-alexander.levin@microsoft.com>
References: <20180917030533.592-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030533.592-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0150;6:ZO0sF6kuhjnogoxKzXeFCS5FsFI9uAlPS8w+obZY9iPs61eKowIdzkNcBvIKeqT0pZEPpl3v2TjoKFST1qHAYX17vL0vGVYSH1bFkyS7jrdnt4Xo2uoUhI/pc7JNtkz31z/ci6nDq6T2cSaDFopMveVWG2CDcBjzi2sNRMPo6h8GWuyPblRbNVyYbLDnVu7T5MVBi6nDPp5b05zQi2YxP1B7+I4FjnCU+4X6ttfZXVjLmcPgfeABynn0H0RMEWD8lV+u1Ani1Xx2AS9lX/LJ6bnjLWIGsxFQDtPla1sea7MCIEZiHQonlkcxj2xHfZq3/+snba5GIokTXOQ8t8H8Esm88bo0Llyb1SfCQaDicgLZwKB4qheoA8P65gxDmMKZoEi4T2QdcVuXrhUmutHHee8eJrijD7mBY+CQFA4oywdgobXbVULOC99vr3+8mQl503PT6nV2DUw5fxAs8RoAIw==;5:HZ0ytp330L6mIhUrksZv8ChI+EBMZ2BZIxZ2T+7PRfIservUEwum9jG0rF03ZiOX/hE+chHC36u8+IgVDksHuD9O2h9Tpew4L6Dm5FzmnmQj+H0+cpljWyA1RJd6K2l+s4uE/ed3Sj3CtwNcOO3q7JDsgGevDHwJPmjKqMtvh9c=;7:150n4PiV/Rbmkh2eRTXqjx1Z7e06nyDAJWoJmSNW7Retuy4Z9Zdb2yKuhv0/r795kBWlz5Hv5YvBXGJ+fY5oyzvCOgK2YxsixmPC3X5E87xvMiXDfL10bpWPFPewoiqKTVyWXH9XcOLU5NFVfH7bcKKyekQHRIgNZXIOmzjY0Csap85RB7iA35MSIdomZixiohxbsfJEudtZBeyti63REcBa2eeJrOhZiES+2gMWJSxNtRHTcv+4KMsCXJo93Dlf
x-ms-office365-filtering-correlation-id: d8ade73a-c93b-4f19-9347-08d61c4ac1d5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0150;
x-ms-traffictypediagnostic: CY4PR21MB0150:
x-microsoft-antispam-prvs: <CY4PR21MB0150C58148EC5D250C530499FB1E0@CY4PR21MB0150.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(104084551191319)(190383065149520)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0150;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0150;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(136003)(346002)(366004)(39860400002)(199004)(189003)(478600001)(2900100001)(2501003)(6666003)(11346002)(107886003)(5250100002)(14454004)(26005)(10290500003)(36756003)(217873002)(7736002)(99286004)(305945005)(102836004)(72206003)(2616005)(86612001)(476003)(6346003)(186003)(14444005)(486006)(54906003)(110136005)(446003)(6436002)(5660300001)(4326008)(256004)(86362001)(10090500001)(2906002)(6486002)(316002)(6512007)(53936002)(22452003)(66066001)(97736004)(76176011)(81156014)(81166006)(8676002)(3846002)(6116002)(8936002)(25786009)(6506007)(68736007)(105586002)(106356001)(1076002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0150;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Y7iVS4Zuh6UBDrlOtZJlxIWrUCmieiGICX5CtzBrOSjPdvljyVdWSsVT64F99/5rLLfXzR5bKBF2XRar+OV/O6X9ZzVd85m1vciuXtNr4/JMcWOIhPXefWfzj43I8cbfFahNL7935q7AeJCIPCSFsBQuYQdLY0Nv6B5C79fguG6i3DDuYvaQeelkh0t/GQiNrCJvFqMyUCBdv+SrF8xirLA0ru49Gwku2i9EmzHpZaneCyN0wOtR+QpF/WCeoUba59nwNf55EwIj+vmTaeqD91xzzlQQlr0nrl3mairA++PMOwI97vrkVMftV14k6l0aOL/xd8zkxRgiCV7oa0Z5RfMbw6joKnRrntWwoE8yqhI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ade73a-c93b-4f19-9347-08d61c4ac1d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:45.4046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit 6b2ddf33baec23dace85bd647e3fc4ac070963e8 ]

arch/s390/mm/extmem.c: In function '__segment_load':
arch/s390/mm/extmem.c:436:2: warning: 'strncat' specified bound 7 equals
source length [-Wstringop-overflow=3D]
  strncat(seg->res_name, " (DCSS)", 7);

What gcc complains about here is the misuse of strncat function, which
in this case does not limit a number of bytes taken from "src", so it is
in the end the same as strcat(seg->res_name, " (DCSS)");

Keeping in mind that a res_name is 15 bytes, strncat in this case
would overflow the buffer and write 0 into alignment byte between the
fields in the struct. To avoid that increasing res_name size to 16,
and reusing strlcat.

Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/s390/mm/extmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/mm/extmem.c b/arch/s390/mm/extmem.c
index 519bba716cc3..783aadec4e40 100644
--- a/arch/s390/mm/extmem.c
+++ b/arch/s390/mm/extmem.c
@@ -80,7 +80,7 @@ struct qin64 {
 struct dcss_segment {
 	struct list_head list;
 	char dcss_name[8];
-	char res_name[15];
+	char res_name[16];
 	unsigned long start_addr;
 	unsigned long end;
 	atomic_t ref_count;
@@ -445,7 +445,7 @@ __segment_load (char *name, int do_nonshared, unsigned =
long *addr, unsigned long
 	memcpy(&seg->res_name, seg->dcss_name, 8);
 	EBCASC(seg->res_name, 8);
 	seg->res_name[8] =3D '\0';
-	strncat(seg->res_name, " (DCSS)", 7);
+	strlcat(seg->res_name, " (DCSS)", sizeof(seg->res_name));
 	seg->res->name =3D seg->res_name;
 	rc =3D seg->vm_segtype;
 	if (rc =3D=3D SEG_TYPE_SC ||
--=20
2.17.1

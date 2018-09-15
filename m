Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47296ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24F2208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AreWn6cI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24F2208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbeIOGwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:52:44 -0400
Received: from mail-sn1nam01on0126.outbound.protection.outlook.com ([104.47.32.126]:8380
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729020AbeIOGwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tq0GD18X+yiCOmpBb0GaVk4QMueAIuXxllETWOouJUs=;
 b=AreWn6cIAF5CqbQpr/hnKn67qWlFa2nNwxk1UlgYEKxyNtrJYjWIoCAFxdCQoRr800VYzE1BWMlsvKxL61Vsv3JilyrHN3TpGO6tNd4P6blhH9DAy/XlRR5z5LtTZe0oKmXLvCIoJlK123kSfmp579zULwrEDdlxNdI57sxHRwg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0280.namprd21.prod.outlook.com (10.173.193.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Sat, 15 Sep 2018 01:35:26 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:35:26 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jann Horn <jannh@google.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 03/11] mtdchar: fix overflows in adjustment of
 `count`
Thread-Topic: [PATCH AUTOSEL 3.18 03/11] mtdchar: fix overflows in adjustment
 of `count`
Thread-Index: AQHUTJRgy9SMGWZtvU+qDC/oIhFW1A==
Date:   Sat, 15 Sep 2018 01:35:26 +0000
Message-ID: <20180915013521.180178-3-alexander.levin@microsoft.com>
References: <20180915013521.180178-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013521.180178-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0280;6:rpIrQoEjxR92klAZE1OOs8phxf1AzdqKOD16g8lo9/asEJxqHjcKyjo7Q/myTqP6l5kPtXkVQtC5B+XerRXlN1BGME4CfNAD3jlZ2hEJKa9KUK7mg3ddYxqSzzs3yszBjmMd4n7Oj7o4vz37QAVTE+we/v4V4YzUuR9zJ9EYt3NQxTIVJhtBUk8pDYjKgW36VRmbZQOAJyz5OEehKxmidU1S3zZaNEo+dIxR5WbEICRLFzKVV1aeu7YCz+IROtyAJ1IWGYtoKsb6LMuk+DBOLONDcQrzZlrGnvKuGqqujA8nplLbeBpQHQjvKpLBHyvZ73SSyup9n2rl69e0m7kt4SSNC5bUqd83EziWxI/Myl7HazdxjxaFnOfVY1x+D2SnwPLQ9WUD+kRaLsv+GBIOOkeSO0mgXVczoRBT9qcD/REPZXv6yKnwAElYdLuyvCTGJe3aAJ6AJBgtfg7Espp9Iw==;5:xRYDzhYh7IS5FyMDoNdVv6UTZx+8kT8XCSl21S2xF03cjI/cZY6eH75c/3XcTNdaO0RPf2GdDAuBg7IWh1W1kHSedezhCx7KNUJrqIFoFlhxx1VK5CkALiY+7sEwkdHqImOLNOkQVPdGp9zOXTLGpeXxhFuAEi9S7xxilVefDjY=;7:epOpraRydzsIrCLuF0gXVtpwjQoYCQfYem8M2r8Y5N/STBWO6//2D6D9UOpb90bpVD4PK0OvXiiHacy4w6sfgq1f4tsHV0YTNTAYDNYrfAbnoQDdIcg3b5n5d5PyA/l41Hpy/zkq0HKIptCib5kwQv6tuC5NoWUwlW/NUtmGKyRVaAO4JgaY8iVJ/NQ4cQfPSje36ssaX09ah+Wbger1CfRgEFVSZ2gXRZ/eXM0iGN9DD8Bk6m265o2jGiMjowCE
x-ms-office365-filtering-correlation-id: c2975e1d-2543-41ac-e94f-08d61aab8345
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0280;
x-ms-traffictypediagnostic: CY4PR21MB0280:
x-microsoft-antispam-prvs: <CY4PR21MB02801FF9C0E34BB63DC925EFFB180@CY4PR21MB0280.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0280;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0280;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(366004)(39860400002)(396003)(199004)(189003)(25786009)(14454004)(10290500003)(2906002)(4326008)(6436002)(107886003)(72206003)(14444005)(256004)(217873002)(478600001)(5660300001)(6512007)(5250100002)(2501003)(97736004)(53936002)(6116002)(3846002)(8676002)(7736002)(305945005)(1076002)(6486002)(36756003)(105586002)(10090500001)(106356001)(22452003)(11346002)(2616005)(476003)(2900100001)(486006)(446003)(66066001)(76176011)(99286004)(316002)(54906003)(110136005)(6346003)(68736007)(26005)(186003)(86612001)(6506007)(102836004)(86362001)(8936002)(81156014)(81166006)(81973001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0280;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: BWV9Cyu9fv0iedUvO9QExkyo5VN2Vh8XNlulO5mhXcg0OUpcOAVq8ab/mOdpFkDLq/zfNB1jvCE0EFy9teF7DFvS6eHs2Ps+GUSOoB4yZDGqP2FEW/2TNLDf5D4it2IAZx86FvPZKSXHv991WiyDjdlvAVRg8RyT1xEPTeQP9Zovf9BarphfZMtjJucOQVbPhRwtEnIRzryH/kEM7q7FYl5X7zcaF6KufBRkwA5yrKtfUhfQW5S8Uz7vMLyHY1AVsajrOxjmrlhbQcbaUJPn0IP61x8tEbznQlR3mANxTfE37/yBsGyVJk/t+22WxpPTvnCgSOSio5y6wSkXCI/B2RqAca4cwpOmOhfFnvBjRmM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2975e1d-2543-41ac-e94f-08d61aab8345
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:35:26.2693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0280
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

[ Upstream commit 6c6bc9ea84d0008024606bf5ba10519e20d851bf ]

The first checks in mtdchar_read() and mtdchar_write() attempt to limit
`count` such that `*ppos + count <=3D mtd->size`. However, they ignore the
possibility of `*ppos > mtd->size`, allowing the calculation of `count` to
wrap around. `mtdchar_lseek()` prevents seeking beyond mtd->size, but the
pread/pwrite syscalls bypass this.

I haven't found any codepath on which this actually causes dangerous
behavior, but it seems like a sensible change anyway.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mtd/mtdchar.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index 53563955931b..77f8f598344b 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -190,8 +190,12 @@ static ssize_t mtdchar_read(struct file *file, char __=
user *buf, size_t count,
=20
 	pr_debug("MTD_read\n");
=20
-	if (*ppos + count > mtd->size)
-		count =3D mtd->size - *ppos;
+	if (*ppos + count > mtd->size) {
+		if (*ppos < mtd->size)
+			count =3D mtd->size - *ppos;
+		else
+			count =3D 0;
+	}
=20
 	if (!count)
 		return 0;
@@ -276,7 +280,7 @@ static ssize_t mtdchar_write(struct file *file, const c=
har __user *buf, size_t c
=20
 	pr_debug("MTD_write\n");
=20
-	if (*ppos =3D=3D mtd->size)
+	if (*ppos >=3D mtd->size)
 		return -ENOSPC;
=20
 	if (*ppos + count > mtd->size)
--=20
2.17.1

Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5577AECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25B4208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="kyaZZdvR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25B4208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbeIOGz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:55:28 -0400
Received: from mail-eopbgr730091.outbound.protection.outlook.com ([40.107.73.91]:18669
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728947AbeIOGwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3g7b9yXRydc/MQgz3DaD7EtATqb5L1HVgepTZqlxbsM=;
 b=kyaZZdvRUsORdYiC1RqbGys11axrRXpLcULPFCRPQNgMQfsDqQTLUDrRmFtBobyh9u0pC+ivmUFgddlthbEyvoDXlfdnDlt0KwDihCC3D34L9XRNCj1R3c6MSbT4XJkUR2vgke2JLUh7U6lbPWdFybk3lpI3Yk2CuklIOoC25AI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:35:17 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:35:17 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jann Horn <jannh@google.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 03/20] mtdchar: fix overflows in adjustment of
 `count`
Thread-Topic: [PATCH AUTOSEL 4.4 03/20] mtdchar: fix overflows in adjustment
 of `count`
Thread-Index: AQHUTJRVu1WklE8IE0yUahZghDwCCw==
Date:   Sat, 15 Sep 2018 01:35:07 +0000
Message-ID: <20180915013502.180110-3-alexander.levin@microsoft.com>
References: <20180915013502.180110-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013502.180110-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:CFxjgRLWulZ+VQ6D0+NWTuIjula+5LMEtV+N4CpvA9EAuhxgkNKIY28D1aIO/YBS2uYDtINIHwnRPnmz9SwNmKXClMUY9uxHmNsc5ehH/Ta2+jfFOIWc35EN6iJkbwxh1XD1L4PRIP0JaQSCi6Arn0cQjJB6DPGT9nzVDpwxoPK9+iMguAZaihMZC/gGLlKjGR+P/YJikcUu7ykLZMZBHwmZeK+Swz7Xckuu7/3iYyZP09uQe48DmcMoVyhoGqlo1RUyp9N3Q7lHk+G3DfuMsBylyvRSZb1v2CMszCOqyThJI9ZhuDFArwCpS68C0xlFAv48FBNjJOgM9GBk80NFZrbhcxT8aBwRg/iOLdD6gy513NQHG9Q0qAwmbtIgjY7dkCGIT15zvNlsDumjeCKxmJQ7YS+NUbEugro7YBVKf/HofhrR8vJAOl+U0SQa97vTsXpMf5vHKl33u8bkftt0Kw==;5:2CyNAnEUQDMQ/XsVm5nIA0gQJYQ9FCRspoETqn+tTsnYSr9MwI0p3jlALQ7ZLYJKYv7IECg5l6ba7bRa9Qckf/0dRf4gKv03gbc94mYUT/625g44bw/SBe9/8CTSELQ3uyaXC+l0wCkUWc0rZbHTRejGH6gyOpAY56qVndIGAfE=;7:uUc48W1IZU/X7bjsRxAp0xm/Jnfkfr17PxMnlOYhNzsBxf+/xRnD9gjQmSTyoDJrxQsNuA2+KWO9g4MiMpbqlL1Q+S08Q4neBtPgj3ZvCsS3vmnEmk6kG2N5c5vcE+hHRe5NCGHLUF5yJweCk+De0WXroiu114OLcKOhS8xsH2iGHr9eSqBg8UR6zXg4nNMs1VnZhdG9SwDPY+1F6ArSga1GLEVvV9SIvtmH1fnoKwjzlKdkhe/A2rdqkcuortGs
x-ms-office365-filtering-correlation-id: 8f3b43cd-bfdf-4a2e-54ff-08d61aab7e37
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
x-microsoft-antispam-prvs: <CY4PR21MB01818191B2E737A0896BEC09FB180@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(136003)(376002)(396003)(189003)(199004)(66066001)(68736007)(6346003)(186003)(3846002)(26005)(1076002)(6116002)(25786009)(97736004)(110136005)(54906003)(6666003)(2906002)(72206003)(316002)(10290500003)(217873002)(476003)(102836004)(478600001)(22452003)(2900100001)(36756003)(256004)(14444005)(10090500001)(4326008)(2616005)(76176011)(14454004)(81166006)(11346002)(2501003)(81156014)(305945005)(5250100002)(6506007)(446003)(106356001)(105586002)(5660300001)(486006)(99286004)(7736002)(8936002)(6486002)(86612001)(6436002)(6512007)(53936002)(107886003)(8676002)(86362001)(81973001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: z91qUdvqn9rZZ1WNILz0uDp3uoXk5hYC+Xf6cRlr7Iiu00K25aIOovtP7glcpO8fmL5QdIDmsmV5F/qdIGOWP4CLEQWorCQ609AtRox5cuwAkJpgCFXmTMtB7MTTt0pEkDenKGrC9SFp02m9oMFIQUh6Jh0QagWU/p2a2oaYyeXTZLVHkMmAS0kMMwOKl9CUEmBkMvOgjH0SgYfVHiUzLFqEe7yO6niMZAwyZdjgHFWqh5qJfcKgrWy7ArPnjXwSGwlDUUpdAQA400dUMYm/E93hHtzhi6LykVf4ag5mOpOP3ZuXBjpty7TOKBS0R/suJNQXHYWDmn6/wDusp8lhIA1ErMgINPy+CVKDVRTPWik=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3b43cd-bfdf-4a2e-54ff-08d61aab7e37
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:35:07.2698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
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
index 6d19835b80a9..0d244dac1ccb 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -160,8 +160,12 @@ static ssize_t mtdchar_read(struct file *file, char __=
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
@@ -246,7 +250,7 @@ static ssize_t mtdchar_write(struct file *file, const c=
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

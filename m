Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F84CECE563
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD55208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bhvlbBzl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD55208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbeIOGvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:51:31 -0400
Received: from mail-sn1nam01on0129.outbound.protection.outlook.com ([104.47.32.129]:50720
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728608AbeIOGv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zECzQEuUUol1LtjuDkBGO8ib74fV8dGgcmU++QAItME=;
 b=bhvlbBzlKtLw4Exv++MaUnS2tpKUB1zUVazrRAyauP+dMJuk8gN4opAkt10piT62ablEoVdRxIL4OU+YjYizZGA0Ky1tafxrhQciqZ0fA2IQBdQp+Chw0BXSy1EoKLsemmOwH0o564RZsgIarzFaOsj6ScOZAN23DnpWFeIgb9s=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Sat, 15 Sep 2018 01:34:27 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:34:27 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jann Horn <jannh@google.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 03/34] mtdchar: fix overflows in adjustment of
 `count`
Thread-Topic: [PATCH AUTOSEL 4.9 03/34] mtdchar: fix overflows in adjustment
 of `count`
Thread-Index: AQHUTJQ97G2Aif/J8EKoyFq7ogBy+Q==
Date:   Sat, 15 Sep 2018 01:34:27 +0000
Message-ID: <20180915013422.180023-3-alexander.levin@microsoft.com>
References: <20180915013422.180023-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013422.180023-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:cgHPMVKh1Fs94natgAm3/WKUli/6V5DuSq+6rN/uOey1ZetJD0LRXz80qzTZ8wpWHsrE79nm/o2AbNLJSlw3GqHGI990hSfrsJzZdzsbMyp+2Y2esol72SnVseozC4itCqGa6Vx0T9bERllMJSbGLjQUeVlhzlzR61NoeeaMt3h1f7cz5x/w55vNYrjpJIqOezz02I+TjNEAQNvQxnkGd5htgj/0GtjTLLEWi4iOnp9LS7ekmndrvH2f1TyS0dh8zDWbs/uTzQxTjnG6qwfRAM+nwv39VWPGWN1iswGPfJ/QZsu4VzcbyM0NRZDsiKv3OdaoGT2ZRo8WxOG+PRXUxnt9A7zpa9an2a2y/5YEp16OyupBjz6MLyNG+wtoTajh0W1QTV0GGfmj4HJAVQYaSBd98C7tsIPkf04FjEiO4xIeYZ1SYDeAiWU7viD3FXMbmNGbuJrGFhXfavSODtCsFQ==;5:41BP4KP/ecUajRnY/Yp3s6fbvsw2UTXHYnuCWQbdCrpjLf6QhkXJvwUo3U2bVLihHc80BpT0HogMLqLkOmtPpfX5HgFd35HE6YAOtaX3oH6LsTX96aaHQANe9AvAlnfX90nZr5jlsa7L1/nDPJWLAC8f32g+nJhkCmGabelVZpY=;7:04Y7HXenx+LjbciadRe7ymruVS0KZQkFBEvGTNBEWydtVwmdarQIQcg6fKEtG6FP60QdzT7lIfB/vfuD8sedLDF7ypBiX7mXIDK5PhAfvccgy18YfIo7QgmyHs/qBfWTeEVGXTAXnCuDvmKY0AoiVHjGpFYcmS6UnRnKepAJvMKi70lUtJxmlZl7K6tG5ANQ49Q7p0Qv58KpGEkkFAnd3b5itcLTXcCDy6Q4qvmDshLxK6k2fMI+23n5Jx/DUwzc
x-ms-office365-filtering-correlation-id: 10b14638-e071-4a44-db68-08d61aab601d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB0855C94EC42F82697D592679FB180@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231353)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39860400002)(366004)(396003)(189003)(199004)(102836004)(6506007)(305945005)(7736002)(10090500001)(86612001)(86362001)(106356001)(97736004)(107886003)(186003)(26005)(6346003)(14444005)(5660300001)(256004)(5250100002)(6486002)(105586002)(6512007)(2501003)(2900100001)(22452003)(6436002)(99286004)(316002)(8676002)(76176011)(53936002)(54906003)(36756003)(110136005)(10290500003)(72206003)(478600001)(68736007)(66066001)(81166006)(81156014)(8936002)(486006)(1076002)(3846002)(446003)(14454004)(6116002)(476003)(11346002)(2616005)(217873002)(4326008)(2906002)(25786009)(81973001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: IxmnI5BhWPhQYoQwsU8XdzHqZU5FbZ9/My9UdA/UBXxqzvmQIBTIJC45UNy8vRo0aFZIZ/6wpbf4yiZ3IcIDX21coH6TG+hELqauVN9RM/Goluwu7k5XyftZBLIGV1Xp/9HaWqJRGYn0j3muPEdE+o6JdNaCnhlpR3T5bNIoBLe373jbvQAQcaRR/X6/xvhDisN9EhHDfdJO048G85TuBGE8x0rtzKcM2LJUGPfKwX+AJ3kvlsO4W/LkpD0tFgmVyngu40m3+ypBl8oy/oKEKa/m/9RddYG0Sjy1m4CR3uC7m6oO+xhCGIWhvJfryCIvX1pwiz2KqYHee8U3uBQ1ih8VHfwZ4qHcCfxlXaTdDr8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b14638-e071-4a44-db68-08d61aab601d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:34:27.2865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
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
index b4092eab53ac..95b6a6640bca 100644
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

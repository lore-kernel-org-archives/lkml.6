Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1F2ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 868CC208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OA7OnhUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 868CC208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbeIOGqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:46:55 -0400
Received: from mail-eopbgr680131.outbound.protection.outlook.com ([40.107.68.131]:36298
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726439AbeIOGqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQVifjala7zl27n6Ap/cq4H+raCPPvnu+hKOwsURqZU=;
 b=OA7OnhUDI/hnBcJLQuKEaqF1Sc/QAC8tVTzXuYCzeNFzH8R3Zz/lwIS8WqXmbUWvcVtVlFc3J8sK0LUbSnlpvEkAN0j2G2A24CeJqZppnA2Qz9BA5lifINqGxlw9Datap+lr1aZgjCk0dD2eCLkUzBMqFiIAJF/wk6b8LHZUog8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0840.namprd21.prod.outlook.com (10.173.192.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:29:52 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:29:52 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jann Horn <jannh@google.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 05/92] mtdchar: fix overflows in adjustment of
 `count`
Thread-Topic: [PATCH AUTOSEL 4.18 05/92] mtdchar: fix overflows in adjustment
 of `count`
Thread-Index: AQHUTJOZQvfgWAFQ/Eis3qnjal5rRw==
Date:   Sat, 15 Sep 2018 01:29:52 +0000
Message-ID: <20180915012944.179481-5-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0840;6:XZzxftn93IGCSX2ShN39CNTkKq2wkhNQGvP15fjVAvdK2Ij7uALCrI59E0cL/ly9NcRoK/hVju+xoCwGTAlwfnlHefSUjCG15geNb3l8M0/1wov7FWGQ8VYBScYNaptJMv6n4n0CY9jij8/nJOJe71Zf2kMN++j0ESxZdaA6gPcpOVbetb3qct078FeTWnQccW9czGa1LQft2dhcQgryGbDMobXUN4xZTBgpKzodX2+NM1xaC3/G3b5SbCLQ79fT5G7bRRtzE4oH60KOSG97Fb82CyWzMvyDc7nb/OJkqDX8AgS5T5kR57gN+97K6Ns4vqNF/3Sfv1kkYXYoFjnMJAvLOtvqan4csvN7+cCSVPB/jT5FHus5WwtI3TBmMvXvMhHio5MwHC3uLcA6VsxI2ETkPMfHUGVvK686xJ7N0TX+ZSWXWyg2r6gwLQ03XLaX43lJz+6tZuQZ+UFccA2Tpw==;5:1A2SPI52VdcPr54EyS0peqsbszawbvkGIsgCvGcuYuSCmv4cUb55WFBoEZL9d2tbn0LxfYJ8j/qdn9TpAI+5sypy7b7Dd842OpuJm+LrvZcjMsTdPA6tymk4nvb6RWS/x0ZAN/l6Y7lb0R2kL8ZiFPy9W9kuU6Lm2oF7THS4I/I=;7:e1Osa7yJYB4EV192QpAg9Ons9M+AnLSVK/BfsKuVF9S/pwq3/XbKDHhb4vZNvJpE3yHex+6vM88fRutK+lWszFT6tzL95cY9buEj0Kbvq1cFr1Ak75kcVyph+a49PDhKezIsQXn39U14xrNrodExA/a1Nk6sfnul6gk3YjnpHLBWa1JLnqE1QRWNbKfBZVpQkKTIvktnCURucb+W//rEXR7Fa9OV9qmyPZLqizLxbNTq5PlBqhidxIyz3q/gyByu
x-ms-office365-filtering-correlation-id: 598111c6-f0f3-4bd6-a385-08d61aaabc32
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0840;
x-ms-traffictypediagnostic: CY4PR21MB0840:
x-microsoft-antispam-prvs: <CY4PR21MB0840DD935B7797203CE299F9FB180@CY4PR21MB0840.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0840;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0840;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(39860400002)(396003)(376002)(189003)(199004)(14444005)(6116002)(81166006)(2906002)(446003)(478600001)(3846002)(8676002)(106356001)(105586002)(10090500001)(22452003)(8936002)(486006)(2616005)(72206003)(36756003)(11346002)(81156014)(186003)(26005)(14454004)(6506007)(217873002)(4326008)(25786009)(256004)(107886003)(102836004)(6346003)(476003)(1076002)(10290500003)(86362001)(66066001)(6436002)(6486002)(86612001)(53936002)(54906003)(2900100001)(97736004)(7736002)(6512007)(305945005)(76176011)(99286004)(2501003)(5660300001)(316002)(110136005)(5250100002)(68736007)(81973001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0840;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: PgGzqm+Nw1ykyNMjgxzpOPKRo9XE6LcaBjuw0FY5Mz4QJTjFO157OyDtv/3neR5Xf7r1LixU+3JyLeANptFx7Q3Dyg1Hqa11FdLIutabo2ALFayNEOEhjIPglb05ZEZIgUJMP9q3sKfOHsZImHQhGFfWw/qYKw8cjWJ4YBsh/UkZ6RRDXKZnfKBGGB74iCzdF2xY4JnurGGfr84+J997UHA4TsXakxYsNL7UKIlX4aDh35HRbFrS3mmRZzDHGaW6FYFG56yEz4i7nH52+PRHumD6rqmHOOOr9vilr4KU9yAGVFi8qD3meIaU/TNGdWCshUmSZelNtdVS90vgKpMH3oKsyeEFr+3L5jEm6c2gUcc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 598111c6-f0f3-4bd6-a385-08d61aaabc32
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:29:52.2139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0840
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
index cd67c85cc87d..02389528f622 100644
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

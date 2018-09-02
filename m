Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67824C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1440E20835
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="kY6aiid/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1440E20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbeIBRur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:50:47 -0400
Received: from mail-dm3nam03on0090.outbound.protection.outlook.com ([104.47.41.90]:39552
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727861AbeIBRT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jx5fSMMvEiuBLak6HBZXti2IyInSUQSuB1hg9M+2Z6k=;
 b=kY6aiid/kKVQvOaHFQl8AfEUE09vRZLw3QUf2+i+q+2xpdsNkq/Rid8kDJiGUpoo/eOxyKrJm92KXf08Exn0zQAqBznmu5Nbii9Z0/5q9+FtMoH9pqy745fiJaFKqc+FPpVxsrfQQmN0NHO/XXmTlwyTYdZ4Zk0NPPDQ4JT/sVI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0135.namprd21.prod.outlook.com (10.173.189.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:11 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:11 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 042/131] f2fs: fix to detect looped node chain
 correctly
Thread-Topic: [PATCH AUTOSEL 4.18 042/131] f2fs: fix to detect looped node
 chain correctly
Thread-Index: AQHUQr1m1WtzTKN1TkejaT4IO2yAWw==
Date:   Sun, 2 Sep 2018 13:03:54 +0000
Message-ID: <20180902064601.183036-42-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0135;6:W5LUFC+13YqQfmns8U5BfwYO8uQ08vJY7196YIc4eSN08BGkPoEdWEh4AH1NtgrCamO2Z0fZtwr4mDdh5Mx1r3Pp1TnnRYiscIaKUHkYQwfQqLg2JKzbEAmLKAdITLEMcls1pYgOXMqpYeX4+jCPc8IW2EwQSW6lwLRvtMMgYRiIpBIPlo1LHf5PbclY1Bt+EK3uvuR3T8CTryeJHtXc4twCKE94M7W5xVNf+GZ7oFa9LgxJJnsPB1gyRGc6tiKuPu5ZhEslPVGZSpKdbDBdLw3MNMoG0NF0vjHsW7V/W3dALRkwHjxMPG+4I9Q9Z5LbTuAxMu9nWZG4vUhClc+IIiVCNkl09JKc6QStQn7bMlJIVt/d6f6dByuGdsQl7F63A/B8Y3TuCa9eySyguhXRRPEzfzEyiL7auiR8inSeCE88KXQxsIwpL/Z+SwKSc4m2A6xFSBguZooOWY7wwXbK/A==;5:DBnc4mNCfLN4NHcBE3RxJh0uVXCcjfyaZKJzOgzbkf6Qzg9YL0NC+sksKMKb9f4HYdbm2zmDPRXK/zjTKXXJsD2hbPfiomjt4XPGo5qVWcGEtUHYRCpOar9qLtrCC70fNTG3oxRQ3YjN1k4myaTBVxL7qbgBFK7ri6O9gVsAWrc=;7:lMBP24zu+tRdFkix1XB2HFK9W2u8IHLqIsm44qM7Q6pqH57rS80ogP98AXvaLd7c45yPVTn9azoRDBrABLM8hiLAcgD3Rex4ASNI/WtQpoeyY0HcHsdwUH3Zb4VO66HrME7Fct7QkDouY//IGJSBRkirlNbRnQiE7wHM5/rVrHAm7dLeCV5tg+wghVD8ObqwghodgtWmIi4GOFqFRAH7gg3mEzixjKCQSBmP/33s5ZJra/cDvGnnB5Kr89Qzw16i
x-ms-office365-filtering-correlation-id: 580a1eab-eb44-4d82-57c1-08d610d49376
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0135;
x-ms-traffictypediagnostic: CY4PR21MB0135:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0135DB0AADD6328A83AFA16AFB0D0@CY4PR21MB0135.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0135;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0135;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(376002)(346002)(189003)(199004)(478600001)(76176011)(53936002)(2616005)(6512007)(476003)(446003)(11346002)(36756003)(486006)(106356001)(305945005)(6486002)(6436002)(97736004)(102836004)(6506007)(5250100002)(2906002)(14444005)(256004)(72206003)(2501003)(10290500003)(14454004)(86612001)(186003)(26005)(217873002)(99286004)(86362001)(2900100001)(575784001)(22452003)(81156014)(81166006)(10090500001)(316002)(107886003)(8676002)(105586002)(6116002)(8936002)(25786009)(4326008)(7736002)(5660300001)(6666003)(110136005)(54906003)(1076002)(68736007)(66066001)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0135;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xJuGCml0FCDFBCr8L9cSvl2KajphCKZfY0eZnmNWFwM4cENjFP2VHsec4x03j8jKjJb0GVFjOTRE9IKzsLwl37Wwuxl9TkZvNT3+17HEIWOL4rrlndfr1Z0jh/E/dfIBImKZ6JJ+4iGGoTxcYS/IJqDL2s9/8DoQiBQRT3+eJkWQkCraGadiW6/dDxjvXV9JQEZ1FQSxrYbTpSZe8GkguPMzmj+YbOEp18ASPRzPijfLiW7UlEuGA3+7B5mzKPMMkKypj/0I+RAZpGSANXwiTwg8n202SOyPTIGY6fdpSN7lRvDfcoZ225kv0cK/c0IT6/0wVtvDECZa3+z340HMCzrWJgH4Vje6S6rxGlZuBT8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 580a1eab-eb44-4d82-57c1-08d610d49376
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:54.2231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 82902c06bd17dbf6e8184299842ca5c68880970f ]

Below dmesg was printed when testing generic/388 of fstest:

F2FS-fs (zram1): find_fsync_dnodes: detect looped node chain, blkaddr:52661=
5, next:526616
F2FS-fs (zram1): Cannot recover all fsync data errno=3D-22
F2FS-fs (zram1): Mounted with checkpoint version =3D 22300d0e
F2FS-fs (zram1): find_fsync_dnodes: detect looped node chain, blkaddr:52661=
5, next:526616
F2FS-fs (zram1): Cannot recover all fsync data errno=3D-22

The reason is that we initialize free_blocks with free blocks of
filesystem, so if filesystem is full, free_blocks can be zero,
below condition will be true, so that, it will fail recovery.

if (++loop_cnt >=3D free_blocks ||
	blkaddr =3D=3D next_blkaddr_of_node(page))

To fix this issue, initialize free_blocks with correct value which
includes over-privision blocks.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/f2fs/recovery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 38f25f0b193a..ad70e62c5da4 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -241,8 +241,8 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, =
struct list_head *head,
 	struct page *page =3D NULL;
 	block_t blkaddr;
 	unsigned int loop_cnt =3D 0;
-	unsigned int free_blocks =3D sbi->user_block_count -
-					valid_user_blocks(sbi);
+	unsigned int free_blocks =3D MAIN_SEGS(sbi) * sbi->blocks_per_seg -
+						valid_user_blocks(sbi);
 	int err =3D 0;
=20
 	/* get node pages in the current segment */
--=20
2.17.1

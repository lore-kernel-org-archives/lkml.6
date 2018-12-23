Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4288BC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F189321905
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MwG8cKUC";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="YvyFJfyo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbeLWJpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 04:45:18 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:37368 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725830AbeLWJpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 04:45:17 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBN9j2ux016024;
        Sun, 23 Dec 2018 01:45:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=HQYBYJCepIzdg1mesor826ixUbyfrRQs8iOTQ0h7N0Q=;
 b=MwG8cKUCD5GDYvCJmIrMTkWyiMF5B90va3/lUd2Lc6AE03TESr40u8vmRIX6Z2WLXCs8
 3m3oLOC1DAuuz2opfMFwiycuozNmGYM+/WDkG4B+bjRmyiqcdMaAiqVHuuZGIj7sGAB+
 J5awZVk9LF5lwlU8qApJ/VqLeHxVZZLEowA5BlFNDkssd8aEa9X3QiXU3uVt1K6Zu7Of
 KbjSgClHoDQM3n5d0IYF+S1Mkf2sS3bN5jW2XqrKdF+AiTMWnBaNA5Y0r0NcQGUXKLo2
 tQZmShB4cDNnz9B90QR1tNjCKmfOnBfuI/6AkCb+OjrG+lG2CAJHAkG4f2hH2HdpXEB6 MQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2phnnqbewa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 23 Dec 2018 01:45:05 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Sun, 23 Dec
 2018 01:45:04 -0800
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (104.47.50.55) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sun, 23 Dec 2018 01:45:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQYBYJCepIzdg1mesor826ixUbyfrRQs8iOTQ0h7N0Q=;
 b=YvyFJfyoNGHs2Y/P6V20C4+1Lg9zvA3nq8kBFXZ4nHVSf/zjDKvtRyQ1XOmUcy90M2n1KtQSatKmy4ji0yN22rWQAtqwJhbhlVbaRToNKLbv9GsfsROTgEaQB2p60tDEpAjmJkr7SMNZFhK0PYWVBE/HbrNJLHu2lECh490GbsU=
Received: from BYAPR18MB2888.namprd18.prod.outlook.com (20.179.58.203) by
 BYAPR18MB2904.namprd18.prod.outlook.com (20.179.58.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Sun, 23 Dec 2018 09:45:03 +0000
Received: from BYAPR18MB2888.namprd18.prod.outlook.com
 ([fe80::c1de:fdbc:577e:ac65]) by BYAPR18MB2888.namprd18.prod.outlook.com
 ([fe80::c1de:fdbc:577e:ac65%3]) with mapi id 15.20.1446.026; Sun, 23 Dec 2018
 09:45:03 +0000
From:   Yuri Norov <ynorov@marvell.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
CC:     Yuri Norov <ynorov@marvell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] test_bitmap: add testcases for bitmap_parselist
Thread-Topic: [PATCH 4/4] test_bitmap: add testcases for bitmap_parselist
Thread-Index: AQHUmqQt6Xc1p83q0UGkSXwFLRd0GA==
Date:   Sun, 23 Dec 2018 09:45:02 +0000
Message-ID: <20181223094422.4849-5-ynorov@marvell.com>
References: <20181223094422.4849-1-ynorov@marvell.com>
In-Reply-To: <20181223094422.4849-1-ynorov@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P189CA0028.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::41) To BYAPR18MB2888.namprd18.prod.outlook.com
 (2603:10b6:a03:10d::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [212.58.114.41]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR18MB2904;20:ahppkCHxrVhyQScV3ff84it2h0nDi1s1LX05UsbLPzk9orYLScAknOGK0nQjYfqkgm9cORs5UUbDKN2FDmUAPyWl0f6CL4AnxTyr3xk0wxhrb3F9FPNGjyBUigWOb1JmOJi3yuJOgcpJCo8N83kdZ7OA/sOeG/uBLKPe7T8IV9M=
x-ms-office365-filtering-correlation-id: b9228a5c-1298-4159-1a44-08d668bb4fdb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR18MB2904;
x-ms-traffictypediagnostic: BYAPR18MB2904:
x-microsoft-antispam-prvs: <BYAPR18MB29048AB6EFCF811F65E44695CBBA0@BYAPR18MB2904.namprd18.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(93006095)(93001095)(10201501046)(3231475)(944501520)(52105112)(3002001)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR18MB2904;BCL:0;PCL:0;RULEID:;SRVR:BYAPR18MB2904;
x-forefront-prvs: 0895DF8FFD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39850400004)(376002)(136003)(396003)(199004)(189003)(71200400001)(53936002)(99286004)(71190400001)(5660300001)(86362001)(478600001)(97736004)(476003)(2616005)(1076003)(316002)(68736007)(11346002)(2906002)(446003)(36756003)(256004)(14454004)(14444005)(66066001)(110136005)(305945005)(102836004)(8936002)(7736002)(386003)(6506007)(6486002)(186003)(105586002)(26005)(25786009)(6512007)(54906003)(8676002)(52116002)(106356001)(3846002)(6116002)(76176011)(81166006)(81156014)(486006)(6436002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR18MB2904;H:BYAPR18MB2888.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tJq6Qjb8AEqvlg2QebdNIwqy8KL8ObFAJ1tQTf/EnCdfiVdIPx1JvqQws11YEcQu/eNyfeYUdvYoh93J6drXH3S1sXAvqiTllGIgV5RwVe5EZ3bvHWARc9isdUqwJN6XMSbij2V1e6I+2PGR8qKyrg0UmyYyuHQL6KYp32ovVDnsPBNiqTMpwaC/qMFRVychEWv+bN8TBUI+6e6vrr0RLpLZF/Taqfft9JRkcA0KrkaX3eyWm2rrRul4jwiFW97LWQ8JjbEskLQgj1gqeiEHYhxaq3azi3rLvTo4u3faqcLHiapkBvlD2XAza6g0lo/W
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b9228a5c-1298-4159-1a44-08d668bb4fdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2018 09:45:02.9779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2904
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-23_07:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812230087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tests for non-number character, empty regions, integer overflow.

Signed-off-by: Yury Norov <ynorov@marvell.com>
---
 lib/test_bitmap.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 6cd7d0740005..7580dd6ac599 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -224,7 +224,8 @@ static const unsigned long exp[] __initconst =3D {
 	BITMAP_FROM_U64(0xffffffff),
 	BITMAP_FROM_U64(0xfffffffe),
 	BITMAP_FROM_U64(0x3333333311111111ULL),
-	BITMAP_FROM_U64(0xffffffff77777777ULL)
+	BITMAP_FROM_U64(0xffffffff77777777ULL),
+	BITMAP_FROM_U64(0),
 };
=20
 static const unsigned long exp2[] __initconst =3D {
@@ -247,19 +248,34 @@ static const struct test_bitmap_parselist parselist_t=
ests[] __initconst =3D {
 	{0, "1-31:4/4",			&exp[9 * step], 32, 0},
 	{0, "0-31:1/4,32-63:2/4",	&exp[10 * step], 64, 0},
 	{0, "0-31:3/4,32-63:4/4",	&exp[11 * step], 64, 0},
+	{0, "  ,,  0-31:3/4  ,, 32-63:4/4  ,,  ",	&exp[11 * step], 64, 0},
=20
 	{0, "0-31:1/4,32-63:2/4,64-95:3/4,96-127:4/4",	exp2, 128, 0},
=20
 	{0, "0-2047:128/256", NULL, 2048, PARSE_TIME},
=20
+	{0, "",				&exp[12], 8, 0},
+	{0, "\n",			&exp[12], 8, 0},
+	{0, ",,  ,,  , ,  ,",		&exp[12], 8, 0},
+	{0, " ,  ,,  , ,   ",		&exp[12], 8, 0},
+	{0, " ,  ,,  , ,   \n",		&exp[12], 8, 0},
+
 	{-EINVAL, "-1",	NULL, 8, 0},
 	{-EINVAL, "-0",	NULL, 8, 0},
 	{-EINVAL, "10-1", NULL, 8, 0},
 	{-EINVAL, "0-31:", NULL, 8, 0},
 	{-EINVAL, "0-31:0", NULL, 8, 0},
+	{-EINVAL, "0-31:0/", NULL, 8, 0},
 	{-EINVAL, "0-31:0/0", NULL, 8, 0},
 	{-EINVAL, "0-31:1/0", NULL, 8, 0},
 	{-EINVAL, "0-31:10/1", NULL, 8, 0},
+	{-EOVERFLOW, "0-98765432123456789:10/1", NULL, 8, 0},
+
+	{-EINVAL, "a-31", NULL, 8, 0},
+	{-EINVAL, "0-a1", NULL, 8, 0},
+	{-EINVAL, "a-31:10/1", NULL, 8, 0},
+	{-EINVAL, "0-31:a/1", NULL, 8, 0},
+	{-EINVAL, "0-\n", NULL, 8, 0},
 };
=20
 static void __init test_bitmap_parselist(void)
--=20
2.17.1


Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17F5ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8080620693
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="d079xHNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8080620693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731219AbeIQIcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:32:33 -0400
Received: from mail-by2nam01on0104.outbound.protection.outlook.com ([104.47.34.104]:36220
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728757AbeIQIcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4Kw24AZFzMUsbGg6ZUnYKiV3+HPOMnmKAn3ci90TyY=;
 b=d079xHNsuyTB1qavzFq0bDManvU2J6yeo58wZpIoRv1oVuVlKvbthup0Jnn38xuzwYhGjhFTRlzdLfIZavNp38vz4Q2meUkymdb+flPLBN+Fu+tILXNWIzDIXRZybxxatUZtSDMSZNXrKwppMCo7WgtMBD4pEeQuLsv6GxsrsC8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0759.namprd21.prod.outlook.com (10.173.192.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.5; Mon, 17 Sep 2018 03:07:10 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:10 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Vasily Gorbik <gor@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 23/43] s390/extmem: fix gcc 8 stringop-overflow
 warning
Thread-Topic: [PATCH AUTOSEL 4.4 23/43] s390/extmem: fix gcc 8
 stringop-overflow warning
Thread-Index: AQHUTjM6SHy6RDgNg0+sQWrbJoQZOg==
Date:   Mon, 17 Sep 2018 03:05:03 +0000
Message-ID: <20180917030445.484-23-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0759;6:vhHhRtO+LPNM/1wws4JXSYFKXvGnnToNhZ3YXb22kWWhZ9piIJGxhPxDx1oW1U9b6JEwOIaahHGrmeHPR2E5N/nzT58tarfSVBYp36ytIIHhN2tD6QDl30eMZufRpSz/AoOapleSQ2SIa45eSsUcPjgMtSTjg1nZrpUdgBpJTumL0hOW+qJnR5vqgPDs0cqJlPr/A3twHr5VTSwFnQC4dDJYGuRP9ds67sFnC4uWfe7xChXZs5z5M6dAUb7DhXUIb5E4+vCUGOFxZN6Fp2Wj+81TuZPF5e8snfdsKZDfOnqQBNwxzJvn4TagaVCbht4rdaxTLAoMqDg1wI11sNkDU2N4y4OHRuGVsc7m4lg1DmwpLRLh/F/DUlhNouquEvE6H3Rfi/U176D+2P4SC3lR20kpX2pKGxs9f8Lk17Qg5Lt34gvwD6/NbTApAd/RDNH34mvJwuLmAXz7JqBj3Pyo5w==;5:amppxpx83Sxbe9yNgBE4iV5r/hPHJ98RRh6T39MHvjtoH1smEua/cKTIdy+UR2F5fxF8QW5Vh2Pc0hf7ykD7x0Zv9NR8DcqxJHDk66ebXdaDfWuN0VYT5wjkkocjhzw30merfh/7mtgNqJHsLmsQ4d4ZraVOeoeYXAYydX1iOAE=;7:ECyRenZM1NPaXX0caH7ykmUJJIv508Y7md9LAf/M+I/VMj5sxiN6fdH6JdYogrUHkwxuA25EubO4TwuQXPvJODTN+gJY3wVEv7KJxY0pO7EFDF3+5ZyZRvorW8BHw4mbCjKH134oIv3ogJ7Crp2w1Wpgxpx1wsiN8yOJJDEVS0kl/82GvwplqKBvxF00Xwk53I5Mc3CaXTeTn4k9mCdT075fckjNOi/wg2Hy/seWJ/XW+EkU+g6DjQtkunzpeSAC
x-ms-office365-filtering-correlation-id: d1b3165e-1374-4e5e-3ae1-08d61c4aa89d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0759;
x-ms-traffictypediagnostic: CY4PR21MB0759:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0759BB73B30926ED9197AA20FB1E0@CY4PR21MB0759.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(104084551191319)(190383065149520)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0759;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0759;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39860400002)(366004)(189003)(199004)(2501003)(2900100001)(305945005)(7736002)(5250100002)(6436002)(5660300001)(53936002)(1076002)(86612001)(6512007)(2906002)(6116002)(3846002)(6666003)(6486002)(86362001)(97736004)(10090500001)(26005)(54906003)(256004)(14444005)(106356001)(102836004)(25786009)(99286004)(105586002)(6506007)(446003)(478600001)(10290500003)(72206003)(11346002)(217873002)(66066001)(68736007)(107886003)(4326008)(76176011)(36756003)(486006)(2616005)(476003)(316002)(14454004)(186003)(110136005)(22452003)(8936002)(8676002)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0759;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: n81mH3cbvy96zeG2GNRLVDMG2+kJfSXsZeCwZj3i8VixaM7JsP4DDSTShXbfk3TN4Oavg1VraJzPLgK1wv6yTORRCjy6P+m3IQsfL8rqwbzNsJtZ54ZkMje6KNz2WF94svaetWUoJGcZKlNaJIBoqc86Y/DTkb2or/FMyQYOS17ZoK7XCZ+5LJFwtzzZrik/TUPC+sCCO5vw/sAnQZtjDf6CSX5K+TqmVO/wT+e9ZP9ya04kPf79/Bej3Gc1MJ1sb3KdD1ySlkdlFW/Vy7WDOBhFdCjTrehHGkITrSB1vGexK6Z1Ai3QEgdK5AzMJ/MxafxJLfuTKDikW3ihaRhiX61cME9Kc8Wk1Vl4q7PCCnU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b3165e-1374-4e5e-3ae1-08d61c4aa89d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:03.3360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0759
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
index 18fccc303db7..bfd75be6d415 100644
--- a/arch/s390/mm/extmem.c
+++ b/arch/s390/mm/extmem.c
@@ -79,7 +79,7 @@ struct qin64 {
 struct dcss_segment {
 	struct list_head list;
 	char dcss_name[8];
-	char res_name[15];
+	char res_name[16];
 	unsigned long start_addr;
 	unsigned long end;
 	atomic_t ref_count;
@@ -434,7 +434,7 @@ __segment_load (char *name, int do_nonshared, unsigned =
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

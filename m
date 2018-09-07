Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9666C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1BE2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Rr7NchAN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A1BE2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbeIGFS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:18:57 -0400
Received: from mail-eopbgr700105.outbound.protection.outlook.com ([40.107.70.105]:7696
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730728AbeIGFS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPqH+gk8UeDcGDZireG9m0ANtoKlCRK+2JJsXrHrIqE=;
 b=Rr7NchANXFgIAn7NfC+VWnY1ywUuEOqhFvnSUbNHg8Yb5bGCJtvMKuq2LbplfLsRoh05ba4MI5wq/96Cg/WaUn7Pp8X8hoLVa88clkx7xIO4AKOmsxUrkDhYHEPbhhSkxdcqLMNIp0Vz9L5kX/gPlnipCIX2kKvQCNAYAoi8S6g=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.7; Fri, 7 Sep 2018 00:40:43 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:40:43 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 17/43] gfs2: Don't reject a supposedly full bitmap
 if we have blocks reserved
Thread-Topic: [PATCH AUTOSEL 4.9 17/43] gfs2: Don't reject a supposedly full
 bitmap if we have blocks reserved
Thread-Index: AQHURkMZ+dbzq7o/hEqWOW+C6Zfjjg==
Date:   Fri, 7 Sep 2018 00:38:31 +0000
Message-ID: <20180907003816.57852-17-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0149;6:aoE7VsZvMtvK+a96L911F7nDKYSiyNs8MgSEs0MJcplsZBg0OxAc1P+JWKlxbtt6lmpxUrYiMhyXb2HYN6ph96p9tWA59g34W5WspvOZ5XQDDGtvfdQHhhSTOhjtq3Y3xb79XrKgU1C0NfLAJ/pEVgX9k8CkIEFXU9XxeWrpcwRHuSqYsYRuI2yWqS7o6dHzgQkcdN7AAsy3xUT/WhN2Z1D1XLEhohtwIWiGSmZATKbVnEkMOZ2Z9Rj0YBD0c/2l9S8b1dQKl6lLBxB+my96VNW1br0CGPHFyHvIOacMBiXWwGiEaBqy6FKSGgMvP7wq041321gTx8jfpMLn79ogjqCmjZ1NZ5aoCzjhdUv37Oxpzxo328W9kPGFrmg8rg1oYJOENMu6XLn71CPZhVfcAmrVRJlxv5oZ3GpMsKOgYpJWWGalWerrvVgQHeqpxXMALQsgP1Y61EJDi9ooOus2HQ==;5:/9jBI90+vgCeWoSUluLWeSgYv62CUwisxvFPDyuc1jb3rAJepkVah/6Fc6SRjVa57cBqxi4mqei/TF8ITstUBTUFPSx8B9IjgVq5UxyfqCy66TkDW0dKzaGLmuB+pZIXrJUwpuT28XpHvd5BXFh4znFlAKZhw3a/tLkxv8EXSE4=;7:EzvLeHe69bpojH3lybGXp7OpZfeadAWWd9I7JTgqOHj40+QtCsN/ot8S3Axe9Mz6ja03GxWw8WBNnQrqE5lJTCn1E5lshLd03oGxXS9hKm3on26nkai3yW96ZjxBx9knjz5PXil4xLvFgEqd3kxFE0KW2fm7Al7MZ4zN8bo4cpcYef7ZoscEPZasCFmEi1W9HwgDtulZz5wxuW6IPgVatcB/ku+Fh4unGfmwmibd3iAnrp9Ow4LE/LuOCpmSEKzI
x-ms-office365-filtering-correlation-id: c1c4bdbd-6940-49ed-b2a6-08d6145a8b5d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
x-microsoft-antispam-prvs: <CY4PR21MB0149571C0424D0F208CCD9B0FB000@CY4PR21MB0149.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0149;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0149;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(346002)(376002)(39860400002)(396003)(136003)(189003)(199004)(476003)(2616005)(105586002)(76176011)(446003)(486006)(14444005)(6666003)(2900100001)(256004)(217873002)(66066001)(22452003)(1076002)(6346003)(316002)(575784001)(86362001)(25786009)(4326008)(26005)(110136005)(102836004)(54906003)(86612001)(107886003)(6116002)(11346002)(5660300001)(6506007)(2501003)(6486002)(5250100002)(14454004)(7736002)(8936002)(68736007)(3846002)(53936002)(97736004)(6436002)(10090500001)(6512007)(305945005)(478600001)(99286004)(106356001)(81156014)(2906002)(10290500003)(36756003)(81166006)(186003)(8676002)(72206003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: I8/zx/GTCZqkLZpZ/94ZGASIuAuWsDM6IISV2myFcQV8Z4ZuYGbpPS8Gb57digE6RVAK/MWSSJMWr5iRUiBNsLYGtEcnta978kdOjnaBZGx9p6UUx1z7Y7xyIYv5lJU0d8KgcPUjm62RHmikM+Oz1WlG9WCyuCE9TuhuXZaKi8thqjHl5VyJhDijAv4NFZ2QTpg38svYGhl7qbRQfrRo8jNEmgbD70UmjBeHgA04lknvXlisIgx3RWu3uSmF59MYqTZFuKudEE93nXSQzPxU9JTCyRm5ISWWciQ0MQ1hZgLpD8ZRTmliVZ8866PFanUCDGgq9GZ1YJNwEfm50miu5MswDUgE+VxhSnPYS+aHnfc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c4bdbd-6940-49ed-b2a6-08d6145a8b5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:31.0593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bob Peterson <rpeterso@redhat.com>

[ Upstream commit e79e0e1428188b24c3b57309ffa54a33c4ae40c4 ]

Before this patch, you could get into situations like this:

1. Process 1 searches for X free blocks, finds them, makes a reservation
2. Process 2 searches for free blocks in the same rgrp, but now the
   bitmap is full because process 1's reservation is skipped over.
   So it marks the bitmap as GBF_FULL.
3. Process 1 tries to allocate blocks from its own reservation, but
   since the GBF_FULL bit is set, it skips over the rgrp and searches
   elsewhere, thus not using its own reservation.

This patch adds an additional check to allow processes to use their
own reservations.

Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/gfs2/rgrp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index 86ccc0159393..832824994aae 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -1675,7 +1675,8 @@ static int gfs2_rbm_find(struct gfs2_rbm *rbm, u8 sta=
te, u32 *minext,
=20
 	while(1) {
 		bi =3D rbm_bi(rbm);
-		if (test_bit(GBF_FULL, &bi->bi_flags) &&
+		if ((ip =3D=3D NULL || !gfs2_rs_active(&ip->i_res)) &&
+		    test_bit(GBF_FULL, &bi->bi_flags) &&
 		    (state =3D=3D GFS2_BLKST_FREE))
 			goto next_bitmap;
=20
--=20
2.17.1

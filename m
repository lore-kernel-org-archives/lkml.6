Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFBBC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4027B20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JURR0Lol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4027B20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbeIGFXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:23:11 -0400
Received: from mail-sn1nam01on0102.outbound.protection.outlook.com ([104.47.32.102]:56221
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730094AbeIGFUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:20:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBQlk0qFAdftfIxN1CexNQHnaBJzQP7bdxblfeQuoT0=;
 b=JURR0Lolo/yRmWtfwC62P6bQLbZyxEK3Snep5vakVAFwVYQ2fLV4S+zepgrFcEKDtBk5hHmliswimJYyuy9otTjhTr9ng8QMRoqttNQw2NWyWR4eaAvB+Y/MJj0nfrWNK15eya2zgJbj1AQvaDGuRGL17kGZQ4nj3mGs3t7fYnU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:42:11 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:42:11 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 07/19] gfs2: Don't reject a supposedly full
 bitmap if we have blocks reserved
Thread-Topic: [PATCH AUTOSEL 3.18 07/19] gfs2: Don't reject a supposedly full
 bitmap if we have blocks reserved
Thread-Index: AQHURkM9gXpL7PnvrkSdArn8NF1+yQ==
Date:   Fri, 7 Sep 2018 00:39:31 +0000
Message-ID: <20180907003923.58019-7-alexander.levin@microsoft.com>
References: <20180907003923.58019-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003923.58019-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:GLPl/Cn/4E436Nl6653pJCwrPVwDS5+xAE+HgO0tCvBCQCs6PQI1Zkd++qn7Jo+GmyB8Q66BVo3c9riY08NfryiCaQAdzTuh/bSV3ry2DYgMox3ewZonga2BUvM3rwPSaaZrUtbUXeEVDVQ/zi8AiB6Olb4UWWMoZ1x26nt20EaMl24QBe22KYexI9mxC35IALqydzjTnpAaDiFFNLUnFxF7kU+EWU6brXYO25exX8DqnJGDnY52q6+Y80XKNL6CCvUVUEOz5MHiULAH/fvAblWdxxMF8uW7FbKOeRqVv8tDKTrMoIPMQqrQHNLJb0N0ygwAdg5/uf8L5Jnx8CkwSVIiOCFHuTmQQKTi6ovEzNg7DN3UrsIKZJ4mWAZppyhanlie+HEA6d9dp0PK2fU/6tbXf/nr3l1vjbKfB75+db6GjKd+WGshcjtGoU5MDHGfp6ad4M/VqlXi65BFogRJ7w==;5:gCsrbnMovdsUcflIoaamU0uRMSFDT4kbWF+CsMNP6jHByaby1OZHQgKucQw9tCfwosJcClfPmobJpiTdj6sMM7MNQUWWzWSRJm04RKxLc78Kyds85tA9/xGbxT6Tpfx/QeVKrTN7pyWmUQGZ4uZSpd/LIPhs+2INw9sbqID1kis=;7:hKhuE69kPynaoQrzA7LuSPmjHgswK9ukiyfJCrxe6f7B6l4tMSGwQSglGTJW0CvMzATOMJmYqsnqaUU7oM+WJX6hXH7CfoZxT/Ht44kAjt9CenxASMPoeVuf49JCjEr+XNHKji43nygsplMJfbLzMQno1s5paMxdjISlgdt+HX9I26gcAjh2y/BZjrDUeKhlzRZ0RfFH/KoMW8y1ht+DO7c7mRX7rZ/GFVIBmSPAt6LVAOgSLRzpkzaNGKO6jfFq
x-ms-office365-filtering-correlation-id: b3ef0d77-bc86-4692-2546-08d6145abfdf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB046905EEE4EF5333B5512B18FB000@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(25786009)(446003)(316002)(86612001)(54906003)(76176011)(86362001)(110136005)(256004)(6486002)(10090500001)(14444005)(26005)(2900100001)(476003)(2616005)(102836004)(5250100002)(22452003)(186003)(6506007)(11346002)(53936002)(217873002)(66066001)(4326008)(575784001)(486006)(6512007)(107886003)(2906002)(8676002)(105586002)(72206003)(99286004)(1076002)(6666003)(68736007)(2501003)(7736002)(10290500003)(106356001)(305945005)(14454004)(6116002)(3846002)(5660300001)(36756003)(478600001)(81166006)(6436002)(97736004)(81156014)(8936002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gbilivHsB2JxgH53iUy2xK+ReMyeqh3ltGFc6N43bw7q0HzRIRXUS5vyXuPahGYnOsQAR5hGzWjKTsl8frnc8QBAzaKStT8X7nzpWQ5OW//NWHRfWW2uvTGPnuiZJX0yACDkMuE1Uwj1OuxxFeCl70pDB83/V9+BWBVCEJIYy4buiD1mVtdJfV494Dq7QQlGTfKhtcUxrL0uQMraXOViCoq196pIlsQwQ+VD6KroyKr2svXaij43VJUZVMcG6SjMluTvir6p6u0rdgtovbQI1odS4w70yHKgK/Y0uAKfzV1HFT+78jKkMECDIGthhAUU8BVxRL9AiFne72QqBcHcQ3r7a1JdnuPK91sYQhJCvXA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ef0d77-bc86-4692-2546-08d6145abfdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:31.0685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
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
index 7474c413ffd1..54bc68acc10c 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -1643,7 +1643,8 @@ static int gfs2_rbm_find(struct gfs2_rbm *rbm, u8 sta=
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

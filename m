Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C27C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD5452083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="aktUOymb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD5452083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731108AbeIGFUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:20:09 -0400
Received: from mail-eopbgr700133.outbound.protection.outlook.com ([40.107.70.133]:49024
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729684AbeIGFUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JApZMX351l7u97SAhWEgIlQOznV1irIGiU2h0bLrGCM=;
 b=aktUOymbZi5A4NwsOW4ED/g4YQargnoiubo3Rrw42TkzbQNhqVYno+XCF1OHfGQSxIaT9LMIlW54/qqD3n0vJB1+Eyd35bHkda7piJQcsujC2QUnhgeA4g1iUlTowovre2DxcY+uamPQSFdE9MXZD8zMmQaRx0ORt2j/tcBjpdo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:42:00 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:42:00 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 13/30] gfs2: Don't reject a supposedly full bitmap
 if we have blocks reserved
Thread-Topic: [PATCH AUTOSEL 4.4 13/30] gfs2: Don't reject a supposedly full
 bitmap if we have blocks reserved
Thread-Index: AQHURkMuFFQ8Esw+XEinhE37uO+4XQ==
Date:   Fri, 7 Sep 2018 00:39:05 +0000
Message-ID: <20180907003853.57942-13-alexander.levin@microsoft.com>
References: <20180907003853.57942-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003853.57942-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0776;6:tgPV4YQFH0D3G6Kv5WoHqmzftdqoWh85hCOxvkOdSQgcnoMXs1M+cvvv9YHToIExY0gcsSXXG5wB8unKNNVSoSdRFuNWMRS9G9vHZzHgIboF0slL9JtqY2TZveRM+FegcC6xxWeJEICxpYqqNEuoY09Jqtoh1/NYT2VASKguNMJIpZ3Ft01robeFCbs/CFDs9jbjaY/lSy1/rf0ibQ4rEvaR1RzXykXX7/+a4OTF9skQgIXxejVbIlXEuq4VMlcklt3aeGK7xHZ71BXTlzLj0eCZBSLAdOjvklEYsthU7l1X+iYXh4Su70ku+9zPCrv+2KxneI84L/9xiDL3Pnb0H0vvwtfQ3hfjsaPH+Nxbn6DdK5BSZlh7z8xAvgZChc5xCR+7k/TG8LmO/g+q4ncjquG2jd5hxkiuEfWwlK/rs4fSdv4JrHkacZ9w+YodgjcWnUoNtVb1Ty2oNBx01x8iGg==;5:2A6Z7sEp1lJddeKy+M4wQ/Mlo+or4oPJ2ac78oQf2v5nSgEZDnHqEbpT93y9ckO3OuKiWs/f50HlZXpFMsb1UosAmYzZIU1UKHTHvK3U6GVOafheROBKi47GnQeTw4lQVJloGujfbXJqe8UkXTl24q8jGLpjUynxpoqveSvSJrs=;7:XW1Va9V80QpCxBaqK7BLrh7DvaBPB78LFaYqK17kBmTrT0ZRqGpnm0rnSw7lZfB0ejdAPyRMvdb35GoFNdqivirAz5Gr4d7B3JxHSPIZdalPWdNojS+L+Hdoi+PkBFnxeS9CrdNUE80BDwyY2V8Gq+GU/kNMtnNQSjt3EYbJ9+wTgv23mKvEPqC3xCFdXx902w/BUz7I3HezDh/v1KDpsFMzuE9Yp8Nr4Af1OShu38+HIwiYk9nZljt5fndyscAo
x-ms-office365-filtering-correlation-id: 174dc62e-f8b5-4e11-c00c-08d6145ab927
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0776;
x-ms-traffictypediagnostic: CY4PR21MB0776:
x-microsoft-antispam-prvs: <CY4PR21MB0776E50C397C8F62F8F09B39FB000@CY4PR21MB0776.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0776;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0776;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(376002)(346002)(136003)(199004)(189003)(6436002)(99286004)(2900100001)(76176011)(6486002)(105586002)(54906003)(110136005)(316002)(106356001)(81156014)(81166006)(8676002)(217873002)(256004)(14444005)(305945005)(7736002)(66066001)(2906002)(6506007)(3846002)(107886003)(14454004)(10090500001)(5250100002)(2501003)(6346003)(6116002)(102836004)(1076002)(186003)(26005)(478600001)(72206003)(4326008)(25786009)(10290500003)(36756003)(5660300001)(6512007)(22452003)(53936002)(97736004)(476003)(575784001)(446003)(486006)(8936002)(86362001)(68736007)(2616005)(11346002)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0776;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 7BBF8S0htYNicgSB0G54CRpMHs0OiGRZPosnFoUyQ9Ou1I1rN6TgVHo334bV7QqRhG7kQEwTf/uoSBflWcj8ejKnYcaHV6a3NoXfxiun64ZCq7bDejpb7+m3jFuQt8+nbCBgd71Bl7ZNW5MAjtms7gwe0f2pBpQjxcwJFr0MWDwIDMUUEsFdJIBtRBAKGXM5eEQ9hto8H5Y3oUABniCBXzX3x3Ls04sk5Aa8eOSbxczS7xKXJPTd48wFnjCytTfWedHBnN4V5hxC2QrFRzUMaPqHPcv33GMMUqm/G718SC7V8dlIGQaiB+eTsF3KKErpkgbY9UaT/kOsvq8A+82ipIFbL9zPjSlSI6uNk21OLuI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 174dc62e-f8b5-4e11-c00c-08d6145ab927
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:05.0859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0776
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
index c134c0462cee..220f9f767307 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -1691,7 +1691,8 @@ static int gfs2_rbm_find(struct gfs2_rbm *rbm, u8 sta=
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

Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831B0C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ACFF2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VLf0MDeZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ACFF2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbeIGFQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:16:53 -0400
Received: from mail-bl2nam02on0139.outbound.protection.outlook.com ([104.47.38.139]:49760
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728938AbeIGFQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1hZ/GfKzTdtGunODAdTADCr1c41CTL07D/m+uIMhzg=;
 b=VLf0MDeZTEhlDQw022HtdzQbiTde0R0dzfg/aFhgB4ZDWnKRm6HoDLFg9q6mpD9odD1tOA6qtFsIGW55xjrjvO7V3Z5eYAMX6Rithf8UAn552UJRqiiYWtJGd6izFHDmjUvaVHNPCTy7OhANiNpaym4l7XvfOoELXpGnL7oGE6s=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1143.1; Fri, 7 Sep 2018 00:38:22 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:22 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 26/67] gfs2: Don't reject a supposedly full
 bitmap if we have blocks reserved
Thread-Topic: [PATCH AUTOSEL 4.14 26/67] gfs2: Don't reject a supposedly full
 bitmap if we have blocks reserved
Thread-Index: AQHURkL6eBvA7uKBh0WgIoYTmt5sKg==
Date:   Fri, 7 Sep 2018 00:37:38 +0000
Message-ID: <20180907003716.57737-26-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:PxNBQf9AJDJ1XOXYc3YIepQn5vWc1VsZpa5IfOFTyX//X+Ulk58dCIIQFc0L7fwgCjv+MldWRAPxtMv5GLBGmbEE+lnCIHdT56sS4LdjJHaK2wp1wkfQZoQieKrQnl3qps2gT/hot4plOSXHFy9wtyALJy85IWbNKZJD1ID5gqTT8CpUiSlCnf9cIdvE6ZXyoTqYIvaH7LUlQnd4ICV2DWlCPg7RTQ7z23uOGqKeT0VVFdW4HrHJTT+Sy+PN/DjFl7tBvU3Nqbs4DbHiLJBIa+dFRt3CIU8Dj5Ss+OKCiXXuV+iN5/5wLQEUd9TVCFmdVMUToO/8GsuaDmzWelY+y67h3u910Y91W+E5yUARerK8swEq0Vs92STHToX1+HGAGkVG2bjN/WDCWI0Q4xJE6ePYlODB9P6lrVePlhJqXwbcgl3HaeiQMfKndKUYPzQtDB0zsX8nyIQ0otnEatWO3A==;5:tbYLgVM1wQGX5my0XXiz9OdmjSlIbT/YedWc8QXXhz4B3995o4JJBxX+gvkXPM+7BG7I7JH2kKFnhDGAR3knUvvlVzgjlHO2E0i97Xr4NiBo9xuox5er6wSDaLgvD4R0Iq/YptJN0PEAUi5R+ZsZ2C1wvpNKMoPRnf1MeUNhOyg=;7:DcyAf1ClkkwQn3UdlLErQB75qH8R4ihERXjaWm2vlOcs9/epGWeoBwa8+3gg/FdSzk+C87IruGFT1IjN9MY1Idy8c6/oxDaTVFXIZfWplk8X0qIT6LyzQo2C0nAhuXG6bgLSKMFJEnXW1PQwwzWU4bFmFaTJwrHXTwJmsbanrzDp5HG9BOd1Hm3eZggsIXXcdvwXWXWv/Dr0OjNbDGHG0wJTOBjpFJ3pG5CJwZRYAhaT2xn9zsV1bH1qtjWQfKES
x-ms-office365-filtering-correlation-id: b8115407-1e8a-494e-aa9a-08d6145a373a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB075761B08A521258A3B7E23CFB000@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(8936002)(3846002)(81166006)(86612001)(6666003)(5250100002)(81156014)(486006)(99286004)(6486002)(106356001)(10290500003)(107886003)(256004)(14444005)(26005)(11346002)(14454004)(446003)(76176011)(6346003)(5660300001)(10090500001)(110136005)(2616005)(66066001)(186003)(476003)(72206003)(2501003)(54906003)(575784001)(316002)(6436002)(86362001)(97736004)(53936002)(22452003)(6506007)(102836004)(8676002)(6512007)(2900100001)(68736007)(305945005)(7736002)(217873002)(6116002)(1076002)(25786009)(2906002)(36756003)(4326008)(105586002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: HnYq4VF4FHfwxjT6wSnv1cfTVfJbD/g4F4AjQm57wrprAmY3qedPqrx8cmhyrZa9lOzigkjukS/2xK/k5r/oLw6+NZS+deD14jnjbLPlkYAFX52sc2sLsM1HBFbKPKaExXzkvXJveWJvdUz1kT6+B3PubAZ1io+E2GJiQZsS5olVxKi/YQKNPSOebxmd1YhkvljRwc01HPZwgmIZ9li60lf312ccZ4q6DqXEScJtpynqbZV++ZjyiuEaATL2dFudwNm08HM2Wi5NaUmwky6nJpaZJAGEdRxqN2R6uMOD2NF+bcDYp7xqhtQtRYaAfF/Kru+znkxfepC54gkTGaK6yus60VufH9RfJflDh3WAAEw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8115407-1e8a-494e-aa9a-08d6145a373a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:38.0899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
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
index 95b2a57ded33..5fe033131f03 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -1665,7 +1665,8 @@ static int gfs2_rbm_find(struct gfs2_rbm *rbm, u8 sta=
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

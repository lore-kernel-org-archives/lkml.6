Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05F4C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97643204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gXqr63jX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97643204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbeIBRXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:23:46 -0400
Received: from mail-dm3nam03on0093.outbound.protection.outlook.com ([104.47.41.93]:1728
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727591AbeIBRXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTpY2e1W7365tED2qfVKoilCPrXghzYSRTeEpMg4MZ0=;
 b=gXqr63jXp12GF7fwPzEE5sMLQUfDFyvVSeg1GQUQgBcHvZz//x0l8o26axesb9rEntL79WSU/uKxDDpLUiAIfnDAqFhqb/Kxp6z3JcjytwZWRavh/Urz7QGCZHcHxK5o7eEvunvMipzef7B1QBLs7yv5/oimnGyuzv0ywiayLkE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:07:52 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:52 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mauricio Faria de Oliveira <mfo@canonical.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 69/89] partitions/aix: fix usage of uninitialized
 lv_info and lvname structures
Thread-Topic: [PATCH AUTOSEL 4.14 69/89] partitions/aix: fix usage of
 uninitialized lv_info and lvname structures
Thread-Index: AQHUQr3pZpBRrMcSzEyAmJnfiPOoCg==
Date:   Sun, 2 Sep 2018 13:07:34 +0000
Message-ID: <20180902064918.183387-69-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0149;6:OB3VDJlTsMi4uQvBdQUBPWMR4K+SS6hV5s1roxywuRRWMzkX07IQUBiD8QYWB8wd3+3/mfT9Q9Lmsn05M1dRjB6LYYxz/sIalbsKhJ/lpMFL+gTo0OgCacbtHLiP4JqH7x11M0OHEZFqyWJWP5NsgB7d0R3XSXllPkxcu0tg8Vt9PvRkxJ1rdZCbeiARJUCS+8UMxokbTMfkzlMw3syrk/PhWopHMmTpdIFoVp8aNe6Tc3X9htzxP5tFn2DGDxOKH7ntqW4kaa2vRAZgag3I/JTCdTw4bUIU9ew8GMgWNcKaync6VMpt7pRfM9kkKRkIAW4aEk7jCuFEGeURFpSDbDRJc9despdVXjDZf2mZR4Fch0Pt952cp5uDHelBVx2LGXMwx1AnjiTB/MjySmi8+/quqcJAO6WS9Lm95OBU49hqTCBro8pqsKnOXPYbPeFcQ/joQQAt/UbHqLyTwhPSsQ==;5:9fIoTOW6H3BLhw9Qnp5IRh0NXQyVQLzgR6eROfSaZOfgwAMNy0672neYNaUrnJa8m6hZTKZchFBiCeBjjZBMsHniFCY6EO6OfHMDvzYNPWDewqEhHYgi4uhKXp3qqBnV5I0cpggl568kil9ogo4C3A8Te4bZOzRlvk+qLTSMjHQ=;7:78IyAd9On+JeyKRYQitQqFbhmo/zWu+ye9BWZBU0rvRbZxfH9OGzCp+5F6NImy/w3oM4B4GxVsa/pjPCojakcUN3mRtVKnNpv6ne57JYbM+Q5zav2sPkgL7aukURtN2vQFCOI21lJokhHO5LM78RCmAVZXJHKQF0iXthsJaMCyX9iRlYcfJ849OTejOsxXpVYkkyVFtNwBXL7onxxeDCVMi/ksqtHlw90mTboIUYvybGauEnK0Kehj6Uuo0OvFe3
x-ms-office365-filtering-correlation-id: 56c61159-878e-4574-fc1a-08d610d5170b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01492C90029C77066EAE4B0FFB0D0@CY4PR21MB0149.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(198206253151910);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0149;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0149;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(199004)(189003)(76176011)(6116002)(446003)(11346002)(3846002)(5660300001)(110136005)(54906003)(102836004)(26005)(22452003)(316002)(99286004)(6506007)(186003)(6666003)(107886003)(25786009)(1076002)(4326008)(305945005)(2501003)(7736002)(66066001)(97736004)(10090500001)(68736007)(5250100002)(8676002)(81156014)(81166006)(6486002)(6512007)(6436002)(2906002)(53936002)(256004)(5024004)(217873002)(36756003)(86362001)(10290500003)(105586002)(106356001)(72206003)(14454004)(478600001)(2616005)(476003)(486006)(2900100001)(8936002)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6IeUQYxOqpo8LLJkg4fQn3QuZ1zWXM7fOh7GbI9qu+UrCqN+tFhN4LgP4WwiGwWz/4muCYSYz7vcDkFMVxijBzTqnTvnB/sF2UdFxXDFkIL1a6Ii9JR3zakki8d9eMEAKUaFZFYu4g8lkES37qYbjBEDBaNKqtI6j/q073YLyx3zeGNOaEwfiY5iZ/Oq84FKeJHKKjhm/KjP1G2myN4metvXjezvJD3qBPaOVuDIPl7bZJt+rODJhJZK8gbZh/tSW4qLzPCDF8/XhzpyUqzLDYCHphYb90EnEmfT4iKQwmWy3WD9T4l+CzSeIttkeu0g1ui9CZbYRaLew2GD9oQDwsAdAYLI3IAbU3CgVjueChI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c61159-878e-4574-fc1a-08d610d5170b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:34.0524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauricio Faria de Oliveira <mfo@canonical.com>

[ Upstream commit 14cb2c8a6c5dae57ee3e2da10fa3db2b9087e39e ]

The if-block that sets a successful return value in aix_partition()
uses 'lvip[].pps_per_lv' and 'n[].name' potentially uninitialized.

For example, if 'numlvs' is zero or alloc_lvn() fails, neither is
initialized, but are used anyway if alloc_pvd() succeeds after it.

So, make the alloc_pvd() call conditional on their initialization.

This has been hit when attaching an apparently corrupted/stressed
AIX LUN, misleading the kernel to pr_warn() invalid data and hang.

    [...] partition (null) (11 pp's found) is not contiguous
    [...] partition (null) (2 pp's found) is not contiguous
    [...] partition (null) (3 pp's found) is not contiguous
    [...] partition (null) (64 pp's found) is not contiguous

Fixes: 6ceea22bbbc8 ("partitions: add aix lvm partition support files")
Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 block/partitions/aix.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/partitions/aix.c b/block/partitions/aix.c
index 238aca56f552..903f3ed175d0 100644
--- a/block/partitions/aix.c
+++ b/block/partitions/aix.c
@@ -178,7 +178,7 @@ int aix_partition(struct parsed_partitions *state)
 	u32 vgda_sector =3D 0;
 	u32 vgda_len =3D 0;
 	int numlvs =3D 0;
-	struct pvd *pvd;
+	struct pvd *pvd =3D NULL;
 	struct lv_info {
 		unsigned short pps_per_lv;
 		unsigned short pps_found;
@@ -232,10 +232,11 @@ int aix_partition(struct parsed_partitions *state)
 				if (lvip[i].pps_per_lv)
 					foundlvs +=3D 1;
 			}
+			/* pvd loops depend on n[].name and lvip[].pps_per_lv */
+			pvd =3D alloc_pvd(state, vgda_sector + 17);
 		}
 		put_dev_sector(sect);
 	}
-	pvd =3D alloc_pvd(state, vgda_sector + 17);
 	if (pvd) {
 		int numpps =3D be16_to_cpu(pvd->pp_count);
 		int psn_part1 =3D be32_to_cpu(pvd->psn_part1);
--=20
2.17.1

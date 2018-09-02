Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C5CC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49262204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Lt8oSwec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49262204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbeIBRVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:21:24 -0400
Received: from mail-eopbgr710112.outbound.protection.outlook.com ([40.107.71.112]:8317
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728553AbeIBRVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTpY2e1W7365tED2qfVKoilCPrXghzYSRTeEpMg4MZ0=;
 b=Lt8oSwecL6bYb8TcbZn1IbbatUxoYErqeXk97UUa6/bN0MmNOgCCc9eq/LHWJwMotkgJJkSBkLR3pWoDDdlDn78Z4I7pC19Jf34BIqzK6gnnHjNx2hvCyyQ94Cm6CnL8FzChORZ3gW2T+8c70473/ZVHoojrYOhLD/sb5bqhWtw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:05:34 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:05:34 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mauricio Faria de Oliveira <mfo@canonical.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 098/131] partitions/aix: fix usage of
 uninitialized lv_info and lvname structures
Thread-Topic: [PATCH AUTOSEL 4.18 098/131] partitions/aix: fix usage of
 uninitialized lv_info and lvname structures
Thread-Index: AQHUQr2Sx+OhuIyeNE2Muvy8FzuLKA==
Date:   Sun, 2 Sep 2018 13:05:06 +0000
Message-ID: <20180902064601.183036-98-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:UigXau9MHYTrx1lHNu03Vc+ydJyaVaip6W60z6C2C888mqZqXXvcSfHZpjVKCgTl/3sCLw3Gw5LaU0nfyD0WvhA4rq+sn8IPQNYBRGbX2zK/AbGFgFK2MwUz9QNmp1p8jhEthoK0ZhgmX6i8GFjdNdT0cwaD9IyfOvFkkAmSZaL3oLgRhaob/R6bghQhHJkl82fMmaaMjIc63UOzfhQuwVwVZxtcRguCVfm0vGmaN00OAlk2Wt1AmwYHdz/zACaI2SjUw0Z/lwQB3OS5mGpaQq7qFvSfv2lc6skoGOxbtU1hhG6+LD6tFPIcRCmjknRs4THu8x2gKQttGHAWPnaq5E2gedZjdFmn52B7U85r2XrH85dEO/E5qTdaiT9kwRa5v8aT/LiMSzlhIX9CeLgXH2WyeZgwjJEytbGhEVhzeHC1ajNukiB4LhaJyHh6lkV20EylCzXQ8ukOLeulZfdmSQ==;5:C/GFzSEoN5aZmiQzEM5gedeMLfJQ4gv36S7CSk6yUkrNhLPs5DcvzHL2BLaelUmiKwKF3XcuNlt0+KFwcyBbJAHi/NA2LsU4jYgMfSRmn8D6i0ak4s6fyAoEhMAZhH5iRJ37WsiHwvm/aCV1s/BVdwSv6bDFFgg3fvo9vK8pqqU=;7:wvM8CmbIxUVLg6KbpYDLLFxikzEZHB18t8L/+H8UIKcK5uOmRruHpVpiCdR6xXYD3nwYWaRBivRvpKiBYTKWDA+Vt59R7OG62uSQmjO8Wp7uTfurfzWC/P6/1/WK3Ew8zHw1tHifPrSQ+CnBEGh29toVwVC4/3WozOPkWxPvxcg3psQpieb+llWnPavBVReKIrbXSSjQSV+GROMaXRkToVoVSKwb0KSYwweeN6r3PzkxCSdvOlPeRccg7u0PGCTh
x-ms-office365-filtering-correlation-id: 5dceed06-c62f-4c4c-e4a6-08d610d4c4e0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0184897F1F81414BD028EE8EFB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(198206253151910);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(6512007)(53936002)(6436002)(97736004)(105586002)(22452003)(25786009)(106356001)(107886003)(4326008)(6486002)(110136005)(54906003)(316002)(10090500001)(5024004)(5250100002)(256004)(66066001)(36756003)(6116002)(2501003)(26005)(6506007)(5660300001)(3846002)(81156014)(76176011)(99286004)(102836004)(1076002)(8676002)(81166006)(10290500003)(2616005)(68736007)(476003)(2906002)(8936002)(11346002)(72206003)(186003)(305945005)(7736002)(486006)(6666003)(217873002)(86362001)(2900100001)(86612001)(446003)(14454004)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Z6TliZP6hMfZlesgNcGjKyRBf2+QQJmJ6TkzxWQCNyo0+eql+rGTyRnNwZr3i5uvw1w9BnzcqCEdtqbsfMADOQyLI4tu3WYtaP9GtTyUkQHBK2pp4VlS4q8GCeld2erfhE2POk3h2kUkjVbYpWQ7FBW2GMxk7bbw6QBorf0LE21WNC9WzYOPDWH+KGmhtpa2INpmt+XWPikWCOIQng5GfuPcw/Xn4sRJfObJ3igSp5i5X9WgOyox9kRc+94zBBDwtxY8Albv5ES89ImLaO1/4OvHUN4CjGjS0FBapHPDjrBfc+9YSvQM/91Angw2LqD48cv3wxIb4GQNLzX6JSVAbzHLHONvPQaDIf9kxdLM1EA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dceed06-c62f-4c4c-e4a6-08d610d4c4e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:06.8991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
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

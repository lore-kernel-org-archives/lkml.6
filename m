Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037E1C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9622083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="j0h2VZph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9622083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730714AbeIGFSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:18:54 -0400
Received: from mail-bn3nam01on0093.outbound.protection.outlook.com ([104.47.33.93]:60384
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730670AbeIGFSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4qTCG/xVAKh7EOCfv7OoTBO9J8HMBozYrZ9PTMKhHg=;
 b=j0h2VZphCn+YsXzh2hlfQKwx5SBMLSUeTtLWrApFLEyOi1P1chaJt6T6uBEqVmWymgv7Cf40HekFfwovOZrZqTM5NAA5B1ZqIqi9K9C9EiXbKNjQ/gTWOSqVZp28UGhITxSZUSlyAVwKfWCZA99R71vRo2/PKNi3JiRqyBxCwME=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:40:38 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:40:38 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 06/43] gfs2: Special-case rindex for gfs2_grow
Thread-Topic: [PATCH AUTOSEL 4.9 06/43] gfs2: Special-case rindex for
 gfs2_grow
Thread-Index: AQHURkMVbg0V5rFYfkSlUhq3hq1tZQ==
Date:   Fri, 7 Sep 2018 00:38:23 +0000
Message-ID: <20180907003816.57852-6-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:kXSZW7AWN0Cpe5uurEJoTwj3m4O+NuZvFAwFmCVQiFTL1v3M4Do+QVC/ehBXpc2zusRhXnSDrwclFHiT2MD3opPoPd38V3oM7fVpc6UYKgyq3/Mg5K+LL2V9dNUWw4PRdLCBwrgDKlaRqoNQxZzWTqywuEMBFlXUeGmYEFMs4c+UAuiVCUFlDYY0/Wuljhc2/mAP58hf6IGSmJcqR1q9Eiy3znZrKuJBa8A65cwfNotF2yjaWXr/RG6dEZbAjzPw8omt8zxrbHAx4e61HbyGvHPpZbnibjWiFngVsBws+Az/TBpIWtOloTdGgrwv9mEMFTi4T32KCle7uFtZ1qNbP3B2oKU7fcCXjPIRPMweQQ1xv7lb0dUivtB+DEUunkuvzhwLgD+FEybYDN+tMJ8IV2IvrEZCiyt0pdTFouvQQtz5OhRMkkehAu+s0/3SaXCE/pB1+tLV7fwgXH+XwlRceA==;5:3pF/xOviaSJfCOa0x8VBl9tg3DNmNjxywyLjKiLhzJPoT8pf7VTHx4XCRqNSKUy6I7zN5PP0RXdnuqZcVrwL4X53XTdlXDo7z5vdXOlBm0/wHyeMwKKKFagQBuDJvU1MoGfazzdyXMhGC+z2e9nr5qIMUlsd4Z5vfzrtjOOIz9M=;7:Q5Anvt4HWhoEZUBSIXmsibLHfnL51DEsWcrM5hJfCJZwebfpBorV1IvEG4qFSFcHmfaP09fn6xfgEEIBq70ybgtbcT18IVl+ReqIZGXMpYyrZ6140jcco9EWhgy9IVPPMThM+EpM8CgbqDuECYiEcThvGAy96Yt0Rdb+NkTGp3Ct0bMnTNNnfliY64X6p/S+CFicd6X2ACA/m3GYMsfJp0uAavCOVoAWmxV4uzGE8BpeA2aXV8nilIeXE2SUR3ad
x-ms-office365-filtering-correlation-id: f76ee8c9-74c6-40d0-b245-08d6145a887e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08551AB661D8FD35F0FF8F95FB000@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(366004)(376002)(39860400002)(189003)(199004)(53936002)(316002)(97736004)(2900100001)(86612001)(25786009)(86362001)(2906002)(6512007)(54906003)(107886003)(68736007)(110136005)(4326008)(81156014)(10290500003)(14454004)(8936002)(66066001)(81166006)(8676002)(3846002)(6116002)(478600001)(72206003)(7736002)(305945005)(1076002)(106356001)(105586002)(6506007)(76176011)(10090500001)(6486002)(99286004)(256004)(36756003)(2501003)(26005)(186003)(6666003)(5250100002)(14444005)(6436002)(5660300001)(102836004)(217873002)(476003)(2616005)(486006)(22452003)(11346002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gQlbvhT7tgb6dXTBEAwzOo38TFx8BMykmWNl9Fm0cNR96C0weR5wqiYukiXZrTe6/rxUweqy2D+ZpYVKqUh2ZeZI9kSSdBJidsIN7IHyy1KNp1zwRB0ULGlZJi6PBvgekGed/j4zydrekmqs+MwA7GxbA8ESzMeblA4hhdwanasC8TprhtGKSkU6UXGmB6rETYBzcYreZpXePBnndpdp/LZxhyEWdpk4DRLz/1x3DN+3LYl6eNtchTLyj/Ndjm1EhoXEUkzFCVWkW2a8O7sNcJA0hKDvuzCTbXz9htDd0dSDbAcLPKfDzjCaNVaaolH/iOFYh81znT+p/NUNXobz6qRXbPLDRoTTqL3C9hKOOQQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f76ee8c9-74c6-40d0-b245-08d6145a887e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:23.1402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit 776125785a87ff05d49938bd5b9f336f2a05bff6 ]

To speed up the common case of appending to a file,
gfs2_write_alloc_required presumes that writing beyond the end of a file
will always require additional blocks to be allocated.  This assumption
is incorrect for preallocates files, but there are no negative
consequences as long as *some* space is still left on the filesystem.

One special file that always has some space preallocated beyond the end
of the file is the rindex: when growing a filesystem, gfs2_grow adds one
or more new resource groups and appends records describing those
resource groups to the rindex; the preallocated space ensures that this
is always possible.

However, when a filesystem is completely full, gfs2_write_alloc_required
will indicate that an additional allocation is required, and appending
the next record to the rindex will fail even though space for that
record has already been preallocated.  To fix that, skip the incorrect
optimization in gfs2_write_alloc_required, but for the rindex only.
Other writes to preallocated space beyond the end of the file are still
allowed to fail on completely full filesystems.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Reviewed-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/gfs2/bmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index fc5da4cbe88c..39af17b407f0 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1472,7 +1472,7 @@ int gfs2_write_alloc_required(struct gfs2_inode *ip, =
u64 offset,
 	end_of_file =3D (i_size_read(&ip->i_inode) + sdp->sd_sb.sb_bsize - 1) >> =
shift;
 	lblock =3D offset >> shift;
 	lblock_stop =3D (offset + len + sdp->sd_sb.sb_bsize - 1) >> shift;
-	if (lblock_stop > end_of_file)
+	if (lblock_stop > end_of_file && ip !=3D GFS2_I(sdp->sd_rindex))
 		return 1;
=20
 	size =3D (lblock_stop - lblock) << shift;
--=20
2.17.1

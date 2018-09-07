Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E9DC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A563E2075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hImeQ5XF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A563E2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbeIGFOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:14:25 -0400
Received: from mail-eopbgr690126.outbound.protection.outlook.com ([40.107.69.126]:51988
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728769AbeIGFOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stcyc0cYihXNN69VREvFwFrcv22OQjsw39bwJx/b94M=;
 b=hImeQ5XFxAOMNv5dTIY9ntVdzw5Pxk3NLAivSRV3IKjDoT76yWdKzciWf2GWmNn2419BuiWwnzI8TvF2U7NXAaaz00+F+obc/bOlPqs58iguVSnRIFQXFClWK4zC+nYz4K/mmHazM2dNVr0mG4kMctsqkb0fCMN4cUtTKTBnIbE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:36:03 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:03 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 15/88] gfs2: Special-case rindex for gfs2_grow
Thread-Topic: [PATCH AUTOSEL 4.18 15/88] gfs2: Special-case rindex for
 gfs2_grow
Thread-Index: AQHURkLBwPRND96pxE+qoEwxynW/OQ==
Date:   Fri, 7 Sep 2018 00:36:03 +0000
Message-ID: <20180907003547.57567-15-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:GWORSHg8eKe9jigWmAG5rh0z6ZbQ/QbKC2v2lbOfq3gnm7GrnAGU/omrVdVIAiq8QaTotKneSyjXt5l5yE7PdeCH6goUVBba3coYBmDNnZ26ReSpdQP2NQui3YPCXnBaBJUOwhZj0/IZ9a6NnIRnInYkvj/Db9zH9CrWJAaERJrrwx0dFhVrmbSQCizpPhI1ZwLOZRqjZk4rETxVg/HHNEpEw+jQRwW1T5oP8AILzMsX1lFy0PO3RP7TrFqMoeRBQ9iVa/oEH5xsnYRxZAAKIRlTon/tW5PbhwE4HiPqCVm7Yab3DWNI+jXTSAaZd1msWcsYYSETXgc1jRTsMcEaw1kHIjHGDdnShuH7NN2/DyFmnMIhGbBaWCvtbsGWpzJVY2jHAmcYz1lMTvRF7qZU15rUnBzdFDKljfLaukh9zDcRvwrsJUBYyHxXjfu0O9p18RZK23edvC2Ehdls2Jm26g==;5:+nNouL4/qtSf101UJoiZd7PjlitHmdijjQM6nTTgb+jbpFWEy1hUKDNrXBndpmlsiWL1QPyOIYR/Ygo96kohozy5wfAVOe4KZ4U/EE0P4nDX19p8yWEkCDHc71I+MJCCMYSy7FFF6F8sw5afGKTc+2cxYzkPX/4oZHUftz/6fdU=;7:Ds73ddByK4AUZ6DLC0KdkIPG+8MKI4VZo2XFW20KUmNbfAj6vY3x5T9sgp0XXN+vhIXyb7AUAdSgoaZH/j4r5mejMopPFBb1piGxLnEDoIL8AvTT6sYa8Vh1EVO06DCHhEndj6ed40yvPiFzh7uZP6YAcrxi9+IOA7JEgIcP5uPwvnwffQ/z3vhfGP2ZxPXjXBpdBIBrMWyNosYF4Kx1sAbsUAc0juHX+sjFecGoCzOG5RsenpjXqmXOmATFmwfq
x-ms-office365-filtering-correlation-id: 3930af27-085b-475b-2d97-08d61459e47c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0773F0B05F0502AA61F246C1FB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(2616005)(476003)(4326008)(11346002)(5250100002)(107886003)(2501003)(86612001)(97736004)(6512007)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(14454004)(1076002)(66066001)(26005)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(14444005)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Mc8Y9ZxdAZk8c7iui/BalGXyG3sHGfSwIWoQTIx9ExVF21nbkfItznUhkwf6WHH8tcz3sPMJQcoG6EoYiTSaLnyC37TDo6aXscGowVStucY2P3RTKzB1TeHjLA6lu2AuSaWVUaP4gG4alptzzsl2iF4Ou3Gv8acvVAGI6jTHUBUrqvatm+RQsYR0IoiOjqzwVbYw6l7CP2mQRisEz9Kh2dAw5IrRWNrWkotJC/bVcpaDaYYxbCe8Sveu0B0ji1qaHmcrIenEbMvNP8QVV1fZQgJCOG/9tndcExPgiAQj4Y9O9ApixHBZyazEaSAdq3PLlfm0ILEW7XIsps9R8m1KythH1qibsUGoaCCdt1U0/z4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3930af27-085b-475b-2d97-08d61459e47c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:03.5450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
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
index ed6699705c13..fd5bea55fd60 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -2060,7 +2060,7 @@ int gfs2_write_alloc_required(struct gfs2_inode *ip, =
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

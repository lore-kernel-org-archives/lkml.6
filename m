Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF5BC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4DEA2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OmwguVg0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4DEA2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbeIGFY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:24:28 -0400
Received: from mail-cys01nam02on0134.outbound.protection.outlook.com ([104.47.37.134]:29449
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731007AbeIGFTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtmGMQPXI/Nn+ff5VCsfmurKPmLnwLb4vF0pynf4n2U=;
 b=OmwguVg0SLpHKl5HlqHw7pgcU+hqd4og415oO6uybWdjKhLZqrSh9pF3Ydp5s8n7S5c4U/vC61k4CB3nNCob/VKeXKQXClyaerApUB0d7pv1kThv9nTp4EhdNIY/hVo6W0Ma2Li5aiAT6VeN40ntX4Sb+WLXDKvhnFEvONEAjFQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0853.namprd21.prod.outlook.com (10.173.192.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:41:27 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:41:27 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 06/30] gfs2: Special-case rindex for gfs2_grow
Thread-Topic: [PATCH AUTOSEL 4.4 06/30] gfs2: Special-case rindex for
 gfs2_grow
Thread-Index: AQHURkMrBJXmyV29u0qE9qv/vMUIMw==
Date:   Fri, 7 Sep 2018 00:39:00 +0000
Message-ID: <20180907003853.57942-6-alexander.levin@microsoft.com>
References: <20180907003853.57942-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003853.57942-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0853;6:U6N+z58jcS/zXBIK+/OXYAqJI83XW8k1oZFkpxBdNo2GCIbiF2gjXEgKieIuSIV6+rQFmf4zMMO2wCSAvA+7bDCrcxGyTv6mA4g1LB7LzZfwLo1WQ/8d3FN1pKUB/tTIhO2q7zuB2ZbLrU0SLRuI3cpLuf07NfMdow+X4UZY+RaQXy529gCzLPkwmlIS9q/eqqlZDso043zAJOnxM08taO9v+ajwGhxVv3PV2SmNwU/OF7DuUlISgHP2xHXdWmTw0JwRzgBRRffPnZonn5TTnWQ99Bkklf3ZgBl7oNeaQ/Sq3yzuul5nVRf7fpqtGE25oQ1IT452C+350gNmVqS7OBJRMRyL+6zNm04ufiwARhHmEz4f5vrlvz3uD4hXTE8QXFtOYHEWU2UBBLukAI6S32M5ihF/uf4gzWuOEqkTUNllGs7JaTeYT8K69Nvfquel72AD1MhzjOLCpQnlLg4GLQ==;5:+RHPZ3879tyZC2qyQw4C/gjEwS16asDAvDXqZIj9EJJ6GlaARp3YnSLrpFGRVUfih5MqJP9wq4AzwG+qGoaxXkChCTjCuBMQwff9q/VqBStzktNHan1VIBukWN9XL7ICCGw/UN19mYDRbObjszSlYkw5a7DiU64kgAw8UU3K/J0=;7:ksCvRPoArMPcJRqQzUBxl2JnQDQexvT4eJCtbAQyDR+29kpjq9DZfBjiYL4/HsyA1DtSeWMKmv+QDR/I93RrmPb90pXQ7DN0QBm2jHAsERLcNiTxr8a0/iHnyFCOHzUOmgrXxydnqD6dGzRUV8w4fzDwDdHwaJdoEiSmHGku9CgGJIYAvnMCDZD2YRwpMU27NuR3hrCFct5smd8LI4ip7mLUYBzDvP4B5I5k5sRj9Aqb80eWaPYY7nO9IHvj9fzZ
x-ms-office365-filtering-correlation-id: 05be32e9-f478-4a31-49ff-08d6145aa551
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0853;
x-ms-traffictypediagnostic: CY4PR21MB0853:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0853795425900D7A8B10B8D1FB000@CY4PR21MB0853.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0853;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0853;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39860400002)(136003)(199004)(189003)(217873002)(105586002)(106356001)(14444005)(256004)(1076002)(66066001)(3846002)(6116002)(4326008)(25786009)(107886003)(486006)(6436002)(6512007)(6666003)(53936002)(5660300001)(68736007)(102836004)(10290500003)(186003)(2906002)(2616005)(11346002)(476003)(2501003)(5250100002)(6506007)(446003)(110136005)(8936002)(36756003)(54906003)(76176011)(99286004)(26005)(2900100001)(81166006)(7736002)(81156014)(8676002)(14454004)(305945005)(6486002)(97736004)(72206003)(478600001)(86362001)(10090500001)(316002)(22452003)(575784001)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0853;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SrMZAuD74BcIh60JOcQejpXOhPhZBZWf3Hc9I93LhUMuK3e939Yq3yVOQ78Hm3pPSL9sPFGvc+wvUt1tt2v7RxpZSfspnqnBI034tClOr7BtFL4O1b6gpu9Xqh5y6JrxqNN4UuJmLKVhroRBX+zX2mxoIYSmzJWEY9flhR6QQLiPfKxVwmyxGH02yZCQUmbIxpeEbPIOGkd+61C8Z9fUTufhD270klgh/5cmQUZub4AmIUZwLjCwJoQjcGFdcnh3Ii9AHpQghrMXwFbcpSM8RaLY8ehic6SHmQLpENeN5AQYEojabR7rtEuViuger5XW0Ad8oNRigfWCvdPk5IZ0TZOHp5OcVworFs+1/jMP5iQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05be32e9-f478-4a31-49ff-08d6145aa551
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:00.3111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0853
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
index 61296ecbd0e2..09476bb8f6cd 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1476,7 +1476,7 @@ int gfs2_write_alloc_required(struct gfs2_inode *ip, =
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

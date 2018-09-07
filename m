Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF3AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930B62083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GEQesekm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 930B62083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731342AbeIGFUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:20:32 -0400
Received: from mail-by2nam01on0120.outbound.protection.outlook.com ([104.47.34.120]:44004
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731250AbeIGFUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:20:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yj/DanAPqSVKQNZ7DPbXpgkj3r+M/sBuhjn4qLKjn3M=;
 b=GEQesekmjf0kkDgpW6USGvjR3wVCayZQ3WsSvw3yBsTDYpIFcNQtsigs7qfoH2+bASLWfnMKRJRFw/+/fHuYPLpWBTyD6GlJz2uGo+xtbOFdB4wZnhrQ1+QUCv9rgfuUB5r/gZuVQpA9hGjI1PM11S3UyHMIGcdZYTCgYKlQi+Q=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:42:10 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:42:10 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 04/19] gfs2: Special-case rindex for gfs2_grow
Thread-Topic: [PATCH AUTOSEL 3.18 04/19] gfs2: Special-case rindex for
 gfs2_grow
Thread-Index: AQHURkM89sCC19O5HESpl2ar9onDfQ==
Date:   Fri, 7 Sep 2018 00:39:28 +0000
Message-ID: <20180907003923.58019-4-alexander.levin@microsoft.com>
References: <20180907003923.58019-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003923.58019-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:dNSz1dtaHCgBb10v4+QFdAn0rSvErdGxhu6qACfQ0TeiCvZgCbFfgHrynArJsvrnHyaDnfeAoW6ogrsJJ02/doSLxWxg1xXh8sk4jUSt6h/qMuUSHdHao67uMrsv3edHNPH7uLdKXtI6n9IKdewE0ZTHdYW+UIXCjA/x0j83hvKeVN3ZbV05fn2jxZdhcHcUIL3Xi/aGuYLA8ynznm9GcMIM2015hf7I1jg40z7d3EE/BnfnlT33klwXYCwH0VfoKjCwJemtZvmqyitBHatGQKDY+xmTrF+8NOqEuAXiogs7HTu5nepl+IwvtFr+5XLZIXqBc9JsiR4Q4xSXdi+zOdDzQXXsp2+1DgodSh90qZeHrlkvPuiGpErjBJpi7r1afiob3W8MuuPcYBFVNDnWmaoK676cmvtbZfT5d6YnVzDz3PS9emKoZ648doFNqscahXW+Ptlit+Lk2N9PU6KbhA==;5:u8GIGrpAtDTAmizY5ZYSp3EUB64LElDl5XfgMFLbTWXg23xAlz13ySeb/4FS8uAyEcpJQYacvigxwKfNhfjem1pW5dFrSp5SFryBQhhIoZqABxz/34lRDtlU7lmL4VFMj+2gQ+emd+S7WE1HKxNAQ9ApItczAK9hCpAphVv+WdU=;7:z6cai+enh3+j/n5TeRRLJAqz0SLMkzBBDqtnAuyI7+3+1XaN16Qy16vf+Eu2xf5TxnY6JFF6617MZ7RJDQaYr7rg4LD5XgeH2X5HHbg5IpwDo2o1+mT3bpuLzwZj6zfAbrabV04avN6eptIC5cM9rNqvtMPbV2po10HZhJaeov5YDJ0UznsGvGgFZa6n4IQ4j8fcAtCB8qrjsA/nYwk6lX2pGZv/c1TtvQQQwdZl3YihRFZNQ3eOBxtD/1NzbDKM
x-ms-office365-filtering-correlation-id: 87ca34f9-9696-49fc-a844-08d6145abf1d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0822E7A3DB113F9DD8D271E2FB000@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(6506007)(10290500003)(478600001)(102836004)(81166006)(14454004)(22452003)(6486002)(26005)(53936002)(186003)(6436002)(72206003)(2501003)(5250100002)(110136005)(6666003)(54906003)(3846002)(316002)(6512007)(36756003)(1076002)(97736004)(8676002)(81156014)(6116002)(5660300001)(10090500001)(76176011)(14444005)(2906002)(256004)(8936002)(2900100001)(99286004)(66066001)(305945005)(7736002)(486006)(217873002)(68736007)(4326008)(25786009)(476003)(106356001)(11346002)(107886003)(575784001)(446003)(105586002)(86362001)(86612001)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ga0Af0e5SYBFIPFJCo9/vkyJCZG6mJlF+jNB+3nHHAbSkR4ObkxGXWKTwsA3cymcQXQ474tI/v7oB3HwWhZljfbcJHW26ozmGHjnAHe/rcwHUqMskIb0n7HNFyOaSeqrKVVsLt4Xm3TFBCh/w66FAbNecTdx58HcON8OGTUjd3nqwer9JRCcEooWBWTxMiicbclM6TVktKJcLh2Nv2qrElrXFtoyeNgISFgTGiLe/Ey/aysvfWQNOrI2Y2R2IqLFsrGDvSOESAJeqht30AEpGKbMXKC66I4E0vO3opmSAVYoes+itent+sPhrXuGHFn7qwMxTkP3dfgtpfoUzSq/Lgsf2k/oA0PZL48veNHixxI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ca34f9-9696-49fc-a844-08d6145abf1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:28.9928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
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
index f0b945ab853e..2f29c2a81448 100644
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

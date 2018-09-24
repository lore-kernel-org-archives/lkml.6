Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3D8ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C19F214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="eZ9vK0XC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C19F214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387628AbeIXUwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:52:10 -0400
Received: from mail-co1nam03on0115.outbound.protection.outlook.com ([104.47.40.115]:2846
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730027AbeIXUwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ob4M0rBGJYfilIHlmiUcY6Cd34XXmw9MJDvDdlnr94=;
 b=eZ9vK0XCm+0LiIS/mVgwkAd2XqE6E18uUvT/zfgsCLLK8wSyzMo3pQQBQm1anBsaaiW9JEwW8j/oKDl+3Ho65UUO4phV2g7LTtxBUj0Ee2pH3cjX3B6Rs6oekSXRA8hKDLI8CHjo2KxYbrrFYQnnUrCs8XGL9kJawf+dwhj9/lg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:49:34 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:49:34 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 64/76] fsnotify: fix ignore mask logic in
 fsnotify()
Thread-Topic: [PATCH AUTOSEL 4.18 64/76] fsnotify: fix ignore mask logic in
 fsnotify()
Thread-Index: AQHUVBWuB2ywwH3u4U+J2nrSWgTtxQ==
Date:   Mon, 24 Sep 2018 14:48:39 +0000
Message-ID: <20180924144751.164410-63-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0471;6:ZQPoXaJFT4iu1YvI7/Ij83FTiQL/tX0QWRAOSnFd/QC9VxNbH2giutKXsE0owUGv1r9Q/wxiicCLD2rW3WgGKPts5/XgGIqJkC33SHpULup5koInHky3jFjwflCipUb9kjybo9wsywgRzDwG+BbNqGcifXe6HXgsXR/ckiHUkk53UfUluKqiLIpsKcX7kOUbtLA60wSBRJzCJkTcJLxM95g2Usi3GIzeo+8lsGnDcqU7K9xwwsfMOPzAstFZrfXzgky479OGTVCKoFXxolQ1czOhKwaBs7WHVQ8UtliJ+lJ6YtjFlwJs9LwpQr42FF7jdEilGFvVaMI/BOJD7+VrL2wYJ85zRYK8Gv0vKWTwKViXkd8r1OJpk320eESHhfE0nGELp1+qUltSz8azoryb21nwPAp+SZ0vZkdlfKkeBJtEINcxhCIgyy1R+ZMr0eVhG3z8b7sLwJ/55wlHrblV1g==;5:/gy0yimEtjm+ijKVywdwVuvbi+pHGsK4/q0s34UwW7+n60B9RMAl9R6kpZ0eKdbjkBw14SLoCd42rUSENk3IxoIDS7tqPAYlbzMn2yNpT8wr9o3lW1MWJhiUsR4829MbQXFo//7of4bDUCi4W/8Lr+Po+uJ1Yl7qZt4CIZMCsgs=;7:SHl3KbyCQ9Jl4B1kRub/cUFCenvzKgNTdMIe8JiceqPe2inFrfZrVTde/SZB6Sw2hEV+q2H8aGu6eeryClNto5PXGsPYcVMB06MHf8d9bi+ge7tqTMZVIVaVzmuiNfIo9PKRPfIyf2dX9oMRgA5hIaySm2FNtpxFDHNx/muzleEmqq0bCOk/cHhR/hKs3nK7ktTHCvH0yQBZoEfPXIEVT8oTSQdpCZFbDkY3LWSFMKn26vwNl4WZBkvAvj+fPvTj
x-ms-office365-filtering-correlation-id: 67a6e0c7-57e8-4438-4647-08d6222cf178
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0471;
x-ms-traffictypediagnostic: CY4PR21MB0471:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB04712144776A1422CFD58168FB170@CY4PR21MB0471.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0471;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(366004)(39860400002)(346002)(199004)(189003)(6512007)(105586002)(256004)(53936002)(14444005)(106356001)(10090500001)(6486002)(217873002)(1076002)(6436002)(71190400001)(97736004)(71200400001)(446003)(476003)(11346002)(54906003)(316002)(2616005)(86362001)(2906002)(86612001)(39060400002)(8676002)(5250100002)(26005)(81166006)(81156014)(36756003)(10290500003)(4326008)(478600001)(2501003)(7736002)(110136005)(2900100001)(186003)(22452003)(102836004)(25786009)(305945005)(68736007)(107886003)(76176011)(486006)(6116002)(6506007)(72206003)(3846002)(99286004)(66066001)(8936002)(5660300001)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8MuFuhUNvtHaTZi642YInAjQ/zREX+2psAv0RzDuho6IBl3dPiXtUMUaZxzEQ2sKsofOIXhQDfpWsTyHdgKS2Gez9DsbunAJ81c8fGYuMqlXR7kWUFw+BoSb/nAeFXXekjurV278E9Az1xEj+EnMZAAWZxURFktoPxlSDGlmyZmfH/bcVbmN61JCxTlAQ6CajT8icAW3+zbDAITSACIkLXI3dw9/+mxAt6J+vldQdLV/rWITfl0QmVOC9aeH++fAvClib2u+2N4Bcit6nE6t3GeDFsANLzCQ7eVO8wx4af8kKdZ+HIOWKGh16ZhECXT308QIRhScUENHhvs/NLveZm3iYpGEtSrVndlVTtxa/mk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a6e0c7-57e8-4438-4647-08d6222cf178
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:39.7449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit 9bdda4e9cf2dcecb60a0683b10ffb8cd7e5f2f45 ]

Commit 92183a42898d ("fsnotify: fix ignore mask logic in
send_to_group()") acknoledges the use case of ignoring an event on
an inode mark, because of an ignore mask on a mount mark of the same
group (i.e. I want to get all events on this file, except for the events
that came from that mount).

This change depends on correctly merging the inode marks and mount marks
group lists, so that the mount mark ignore mask would be tested in
send_to_group(). Alas, the merging of the lists did not take into
account the case where event in question is not in the mask of any of
the mount marks.

To fix this, completely remove the tests for inode and mount event masks
from the lists merging code.

Fixes: 92183a42898d ("fsnotify: fix ignore mask logic in send_to_group")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/notify/fsnotify.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index f174397b63a0..ababdbfab537 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -351,16 +351,9 @@ int fsnotify(struct inode *to_tell, __u32 mask, const =
void *data, int data_is,
=20
 	iter_info.srcu_idx =3D srcu_read_lock(&fsnotify_mark_srcu);
=20
-	if ((mask & FS_MODIFY) ||
-	    (test_mask & to_tell->i_fsnotify_mask)) {
-		iter_info.marks[FSNOTIFY_OBJ_TYPE_INODE] =3D
-			fsnotify_first_mark(&to_tell->i_fsnotify_marks);
-	}
-
-	if (mnt && ((mask & FS_MODIFY) ||
-		    (test_mask & mnt->mnt_fsnotify_mask))) {
-		iter_info.marks[FSNOTIFY_OBJ_TYPE_INODE] =3D
-			fsnotify_first_mark(&to_tell->i_fsnotify_marks);
+	iter_info.marks[FSNOTIFY_OBJ_TYPE_INODE] =3D
+		fsnotify_first_mark(&to_tell->i_fsnotify_marks);
+	if (mnt) {
 		iter_info.marks[FSNOTIFY_OBJ_TYPE_VFSMOUNT] =3D
 			fsnotify_first_mark(&mnt->mnt_fsnotify_marks);
 	}
--=20
2.17.1

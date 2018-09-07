Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E643C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D124E20869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ESxhoT9L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D124E20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbeIGFQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:16:30 -0400
Received: from mail-eopbgr710122.outbound.protection.outlook.com ([40.107.71.122]:40960
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729840AbeIGFQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3P1tx9NI9vnC6tyzl1mtJzTiEDsDr3pT6OYX+9NkWA=;
 b=ESxhoT9LCtLuqKV7sROUBhryX5m5/NqjOPk1KuMtcfKM2SZxnVHPzYPvSOvS9AqsI7+nIg9JQDTVeLstosWSf1MJ9IAmwBgBfPlip55QNcJKpwYKXeLRsOeVJscr9u/zju4M7j8Z8KeXuD869EPA4Fli7RQQF9lD0iUt2b5mYmk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:38:16 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:16 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 11/67] gfs2: Special-case rindex for gfs2_grow
Thread-Topic: [PATCH AUTOSEL 4.14 11/67] gfs2: Special-case rindex for
 gfs2_grow
Thread-Index: AQHURkL0AhjHen+ShEOLKd+RhR7hxA==
Date:   Fri, 7 Sep 2018 00:37:27 +0000
Message-ID: <20180907003716.57737-11-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:MvZ5UfxMbVhNVXt7LEkfipN8bva+5daGazLdn27Ib4+sFJ1VQqosX+FoGxu7MN7roOEOSwJ2WcOwRVcN9XZJ25yaZe16gRHRAAMfIgEtftm3wqOQWpoj2DL2O2nsgniiISegrWs5xvkHOBMFbif1BJ6CSJL6Kxb6ipT5/c4354tIYY2i7DmSPHiSkruC26tBfXAzGo+g+tk1wrqFltIF3cIJyQzVFQmALrPWUSShKKrA39jI+GNztpwfS9ixhwZMMk26gzl/tOsiCNebTyrKKcIIGDtt0sD1QCBVO0eNPwy0XIR8v/kbtjqf/GP4KQj3mh7oJiIQcwAEntkURKpOw9V5jiFWsVoWpCDwtazRxflAMiKiEdLcDFlyJurRTaE932oPRaFvmteXy7XvVpmr3l/WiPGN4++zV4Y+InVv11Gp/LsKXZdXxPW+wrDnm3wdGBAK+Y1y7rPNOJHKqfk/GQ==;5:1iqR+EncD247O1jo1KGunSM/hFomzZeSUzPtnIop7LkILFjU4Y/JeE8ojqvi108WPZVDye1rgNMvqkkQ/L2tLMtL4WSweTEvgv1s3UVS7WiCrp78iKFIonwdOQsQDhmZHOzcOBAQc2wpziJqjNmGXWL/QQSXzWI73ZunxFNAz/o=;7:/Qb4SUjlvajWxTHaNnaRbBGGZeT9N2T4c01IYiT3TGIY8yBXrJi9E5RiAT0MZFjifvMyxVeyPzXKX7Dv7UR22xyOJ3579ij79YqqwnhOv5naJkC2nhh+PXU3cuKmLH21gohMYgtj2wLliMCzdag+20dR7eqAQ4tNGV4Tk6izHGGNnhj4HvLvylEZwAMhsqNNERWjrZFPD5RywcbBNM46msNcY3H41Bk1UpjyJOEpplDDDoiXWztJw+7tqZ1M5/b6
x-ms-office365-filtering-correlation-id: a9f9bdf4-bd3a-40e7-b41f-08d6145a3396
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB0839AFC5D4B6431E6FA229B7FB000@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(136003)(346002)(39860400002)(189003)(199004)(10290500003)(99286004)(10090500001)(105586002)(106356001)(102836004)(76176011)(97736004)(6512007)(53936002)(2900100001)(6346003)(316002)(54906003)(110136005)(256004)(14444005)(26005)(6436002)(107886003)(2906002)(86362001)(575784001)(186003)(478600001)(5660300001)(6486002)(446003)(476003)(68736007)(7736002)(86612001)(11346002)(8936002)(1076002)(22452003)(25786009)(2501003)(36756003)(2616005)(486006)(81166006)(81156014)(66066001)(6666003)(217873002)(4326008)(6506007)(5250100002)(6116002)(3846002)(305945005)(8676002)(72206003)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: exKI80r2Mq4DhIp6Nfndgo8eg+ihOWpwf3a17dqRxuD0p7X0W9po1vGa/z49i+PCTlWn/0FjbFVuIfxAXZEk6710rg2F6EABrypm9pFhPnH5KVoJ9J3QBEk7holI9kKX/LhwFuCzNwaj2dmrfwugczIE+2/TVURvBiYB733aEJ8iA7k71qm+aJz4Z8L2dqhxaFsh9nntFiLZ+HOtX9/L2/u7lTqJr9J5jc/2HkUfM0AhLWMjrS2o2ggp3vKJDEJt5me47pRlMvD83+CElHLEzzIpJ9AtoBdGZFdf/CzyehTiy0otN4yLSRAj7jg0WeUWjUWB8b5ek0aIJONqGVOOsAJ+GDsl1M9up3bCGhm1O6g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f9bdf4-bd3a-40e7-b41f-08d6145a3396
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:27.8553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
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
index 3dd0cceefa43..bc8787718feb 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1680,7 +1680,7 @@ int gfs2_write_alloc_required(struct gfs2_inode *ip, =
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

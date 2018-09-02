Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB373C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D0C20855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Z4vnZkGW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D0C20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbeIBRXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:23:38 -0400
Received: from mail-sn1nam02on0134.outbound.protection.outlook.com ([104.47.36.134]:59648
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729364AbeIBRXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBDOLzjnHYC7e8rO61103id4tGaz5Af4Bpjz7u5MxJA=;
 b=Z4vnZkGWXy+AeCOGV+0g/2M6d/u1CrVJ5qjnnqd/gPmabAC3zmwXNgaq0RWVobsYmDSses61oBbnHxH5YELIDginth9DWFiKbSnfWmcK6xHDywB/AVBqFQWGjxrw3WtC+tnne5viRwG8sQBfjxOu3M6f5OqgqIarZJI7FgaNKkQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0503.namprd21.prod.outlook.com (10.172.122.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:07:46 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:46 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Chao Yu <yuchao0@huawei.com>, Yunlei He <heyunlei@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 54/89] f2fs: try grabbing node page lock
 aggressively in sync scenario
Thread-Topic: [PATCH AUTOSEL 4.14 54/89] f2fs: try grabbing node page lock
 aggressively in sync scenario
Thread-Index: AQHUQr3fFWy2l45vtkOFqmkmX7TZKw==
Date:   Sun, 2 Sep 2018 13:07:16 +0000
Message-ID: <20180902064918.183387-54-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0503;6:BH2kMhIR4rIF9b5fDkPRN1L0hg2FpeQib5HsFNPSXop2WAlLITS8jfYigzzrXs/XKar2hRYA1gsEEt4ECwPcPrVagRu7HFJcIXg37pmFEsZ+xWltiUNHd9NWxd763Yu2Su6tmxVXZ9fND+gz1UULh6khW6QvL7nA1wmnqefFGxssfIVhpX0Mxbfwi/7x3Jd1umKy7TuhZTjC1sb8z1enebAyZzXY9xmHVNqEmzFmZZS3rVYwE9ETuRZn0rJIuD4TNiEwWY5H7OHr1Wi1sjJsa0PvBLp6YbGtSy/7DgXRpp03Y6Xe4uOLqKTSm+egAfXs+ldFL1wdUGTaxlcmAyPbx9HXyH0hhKGioED8kavxMEpaiuFwSs4OoOWV31ipZ9Sh4mlmXq4JS1rL+bkk4kpKZgsm5Pf5lTKo8kcxEfjmTHY8l9Z/c86aVO/E4Qekkp3JBkJQIKdajMeJg4Ep7DrWCQ==;5:JV+ss11SAjTiBQNrc5iIzyFthGaNjDUNedrxEDzNkVD5tPFB0xd+qAEI1K7pz6QI3xWrNxsrAR2jz9KMrbSVf9lY2py/eeJSf/3pgOIBllDSHJgfqpGpr2fJqyUpD632HO/l9mcLPeET43nkren6oDyBS0Jdys9EfChstAz6/q8=;7:InV5uk2KqgkgikYTvIvzfsPtqiUuu2rqCww1U5kC5ctl5CDkekCif6xfjtKTa6b//w+zSRAI7SFAEHUaTwAhRCXo9xtokL/3n7ZGFVeeT9OfPCnnv6q1npBWmk06qcbTi0qq782sSoS3tCzHugsXwR7BD2ihAHNzZDcZun918eiZvrw2jG2uFg+fqH6En2gKiwXH8UP3KYEuVLlG1c0BDG1c5GUcss64lg53fCg06BDY+1qY2Nv+ROLmSUnHkdmP
x-ms-office365-filtering-correlation-id: 71a3f9e3-db6b-4f4d-ae9e-08d610d51398
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0503;
x-ms-traffictypediagnostic: CY4PR21MB0503:
x-microsoft-antispam-prvs: <CY4PR21MB0503D2FD2DAD068D4188BB35FB0D0@CY4PR21MB0503.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0503;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0503;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(376002)(346002)(366004)(189003)(199004)(105586002)(8936002)(102836004)(6346003)(68736007)(2900100001)(6116002)(217873002)(186003)(36756003)(81156014)(81166006)(1076002)(99286004)(26005)(5660300001)(66066001)(6666003)(8676002)(54906003)(256004)(316002)(305945005)(22452003)(3846002)(10090500001)(7736002)(110136005)(14444005)(106356001)(2906002)(6506007)(10290500003)(2501003)(478600001)(2616005)(72206003)(6512007)(53936002)(575784001)(86362001)(86612001)(107886003)(6436002)(14454004)(76176011)(486006)(25786009)(476003)(97736004)(446003)(11346002)(6486002)(4326008)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0503;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: QPEDWqN0S21mYfO/D6VPCBlw9FMPWvm7klrF9HxAJZIoKsn7zIzrPU7myeVRYEu0nMGg3Af7yXOXCDN72iMPA9u9y7IoP14bJGvmaJBtY49QMmiQ2eLqEFwUJ17OvA++rZ57NJpGbzuQUTQDDPrEpg5SqQNqaQMMTlzc+hqIc4TzMF5iW9LJ5RyZ1GKSpbCEYK00ebIncG5D+vp5w+8qDy4YNZ2h1/KHW6qtxb0w7V1eO9tlEY9VuXT/6+83T9G8xxy2AOwIA9b19Hs8id02hN53j7NUyTQroU4c5WyugnqKavqkhe0OS9dxIUDQPmIVDWvnYUv2fwPmhMuDrq7Is2Hdw0x+fMcbnzPwGYych1w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a3f9e3-db6b-4f4d-ae9e-08d610d51398
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:16.6029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0503
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 4b270a8cc5047682f0a3f3f9af3b498408dbd2bc ]

In synchronous scenario, like in checkpoint(), we are going to flush
dirty node pages to device synchronously, we can easily failed
writebacking node page due to trylock_page() failure, especially in
condition of intensive lock competition, which can cause long latency
of checkpoint(). So let's use lock_page() in synchronous scenario to
avoid this issue.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/f2fs/node.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index f623da26159f..712505ec5de4 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1610,7 +1610,9 @@ int sync_node_pages(struct f2fs_sb_info *sbi, struct =
writeback_control *wbc,
 						!is_cold_node(page)))
 				continue;
 lock_node:
-			if (!trylock_page(page))
+			if (wbc->sync_mode =3D=3D WB_SYNC_ALL)
+				lock_page(page);
+			else if (!trylock_page(page))
 				continue;
=20
 			if (unlikely(page->mapping !=3D NODE_MAPPING(sbi))) {
--=20
2.17.1

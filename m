Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94003C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4408820855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hpWMFvqe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4408820855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbeIBRW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:22:58 -0400
Received: from mail-eopbgr700118.outbound.protection.outlook.com ([40.107.70.118]:63159
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727712AbeIBRW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwAsPOyQpt9XSylSKoZvqsLHNBHH5iKvNJZIOo8rLrM=;
 b=hpWMFvqeKLdfjucD2MFp/6NsT+YNupDpOhfTTvusjruGxWj5X9oK3MT3bDyBu9X9ULAz7zutXvT0vMJDH/1dSekDBWoUk4SiX4FUrnvBvW2uCrPkHvk1tsOrHx+UDQjpTqyNlbh5jt1X0Q960Yx+J4fWWsB9Y6uOHCURtr9YP5w=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Sun, 2 Sep 2018 13:07:05 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:05 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 25/89] f2fs: fix to active page in lru list for
 read path
Thread-Topic: [PATCH AUTOSEL 4.14 25/89] f2fs: fix to active page in lru list
 for read path
Thread-Index: AQHUQr3IHmmAsawxI0KMYphqzXXtVw==
Date:   Sun, 2 Sep 2018 13:06:38 +0000
Message-ID: <20180902064918.183387-25-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:SQJys78SOhEFUgzBxH3iyJek0hSrhABbgr/khE4SDT329gNbW/PYAAGUB3BYTlEc2BpRTcdh4udmbScGP6misz4PsX5gPcrWlwSVMSP6a8UFkRFa2a5XDuqBqf3BglNQU74ZrnEP1kvTyJcYIW8FtLOw4Ht8V5/K1z9ll+7OhbVzPW0xUNT/wMlC/wn75+I3GhhyIcYcwL2Xz5yAfse4ZJ1vx2hm7FumfNPKMWWad4GpylGEfhpWWt10BNmOv7G9WLU5wrKFhiBoIwtmaVB/oW538CzAr2b6SV2hJwE0AOgd0mrQMwN7ErI5qblrfeSImGp5t40nqHZLxax8Nm9oS1db0uOA0Qb38SVx9IQIcX8I1colb6p0uqqJn2RoBXFdtBkCqYWLA+GQllIDQ6iWTZkgi4cZH6TEmKFdIOopDdef35+EMcz1XchO0ibR4iqubckvlwc6jdSxwE3UaY7eSg==;5:wr9CaG+RPmNGnLuo+cn8BNkvhi1AC+dtkl8zBk+Kh63JkmN0EhTBLxq7pUnI0SdOVB5cMQaEduy5Qzh1sXawTc0mhySnzuG//cl8Iqzt/izkN7tJdpgqlUkXAVPnUfgDOzCjUMOcYaWuJBQugzDp/RcpC2QKLKy0SV56oEc5uzI=;7:pyEF6MoxBz6ypYnao3opmoduGQh3UERamKEGrfxVsih0T3tPSbzABc4VTbbRUZiP2MdA6qU4O+GkvWSEuGgH+wLQ8/+K8yGOUGaK3c2jI1gKHFIZa/693m2ZuwM+z8H37FsmsvBOM8RQzrJk0My+8vQLLvrBlVs+z2m6GfeV3xDrvUnHFvb/vciCvI9pI+Y0jsfH4dSHgz+tG1mx54Wl7TB+0cWrGLKJTSQK/P87kRBLcNe01bPSBIfnleZhp6aH
x-ms-office365-filtering-correlation-id: 551052e8-8968-4103-08b6-08d610d4fb13
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08565970AB7CF583474F567EFB0D0@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(39860400002)(366004)(189003)(199004)(53936002)(81166006)(11346002)(81156014)(446003)(476003)(4326008)(5660300001)(25786009)(86612001)(8936002)(26005)(6506007)(6486002)(102836004)(2616005)(86362001)(8676002)(6512007)(14444005)(6436002)(107886003)(66066001)(256004)(10090500001)(217873002)(14454004)(3846002)(478600001)(1076002)(72206003)(6116002)(99286004)(305945005)(7736002)(22452003)(36756003)(76176011)(105586002)(486006)(106356001)(2900100001)(186003)(97736004)(68736007)(6666003)(316002)(10290500003)(2501003)(110136005)(54906003)(2906002)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3JO5BoQJNDR6/QEZ9tSe15W6iBg65ej6mg6QhnKDdX+Kdh4Va9DuKEvpShYMM/a9uz+m1NxQpi9D1ILm37dzv2/srNweP8iGS5C0NSwLUKDLUX8omP6YRCxrTmposQJN1nsCkf9xyHMnVpFL6kbCp4+5+T9LkH06p7JkBTWeM7JseOT++bpO9QTqK/kH/X4vsn6BDneeAm3BiVjVf+tmcJzJqSBd9f1377vclsIxkxR3VC8+NOndQJWNCd9wkP2Z8wXaY5xdBEDVZokr8zqYG9+YP1b/OXsBlI2SOXUEVzzaDK7WMGSUy6Fc1EcRzEMdnj/QDzmX+lomyz4nCtmeLyArF6KKSHur48c3rKg2uCA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 551052e8-8968-4103-08b6-08d610d4fb13
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:38.2700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 82cf4f132e6d16dca6fc3bd955019246141bc645 ]

If config CONFIG_F2FS_FAULT_INJECTION is on, for both read or write path
we will call find_lock_page() to get the page, but for read path, it
missed to passing FGP_ACCESSED to allocator to active the page in LRU
list, result in being reclaimed in advance incorrectly, fix it.

Reported-by: Xianrong Zhou <zhouxianrong@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/f2fs/f2fs.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3b34004a71c1..54f8520ad7a2 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1766,8 +1766,13 @@ static inline struct page *f2fs_grab_cache_page(stru=
ct address_space *mapping,
 						pgoff_t index, bool for_write)
 {
 #ifdef CONFIG_F2FS_FAULT_INJECTION
-	struct page *page =3D find_lock_page(mapping, index);
+	struct page *page;
=20
+	if (!for_write)
+		page =3D find_get_page_flags(mapping, index,
+						FGP_LOCK | FGP_ACCESSED);
+	else
+		page =3D find_lock_page(mapping, index);
 	if (page)
 		return page;
=20
--=20
2.17.1

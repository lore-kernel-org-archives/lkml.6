Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C82C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D7C20857
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JzIs5vQd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D7C20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbeIBRT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:19:56 -0400
Received: from mail-sn1nam02on0123.outbound.protection.outlook.com ([104.47.36.123]:20160
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727356AbeIBRTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCehQTBBGnA1x9tKvqKqRcxa0WzJK+zZkGVQqFLGcpw=;
 b=JzIs5vQddGWHdnggrQVz4UxbAuODW4IEVBEaRcGMpzlOgrRlFT96H08iAMK3SCcaimlmfdxwOYgne2OCJ5IopfnycCClXckTN0GqDGAgfU1DQE6F1XY8Va7xtGYxrkDFOza+w244kcFjzDCYqAf1tZN7LQlYkRr4gvJ+bkh8/00=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0135.namprd21.prod.outlook.com (10.173.189.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:08 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:08 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 036/131] f2fs: fix to active page in lru list for
 read path
Thread-Topic: [PATCH AUTOSEL 4.18 036/131] f2fs: fix to active page in lru
 list for read path
Thread-Index: AQHUQr1f8rvM06RFP0G4fNGzKIho0Q==
Date:   Sun, 2 Sep 2018 13:03:42 +0000
Message-ID: <20180902064601.183036-36-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0135;6:WOG/HL/ug/ZBOfqlRJfhRGoklnaDHIY+/D9hEEP6ntCHiqVL1pv2nEFr008sGgnhyIuN2KwMRub4MDvi20ehlUYRMh7rnsfCXsucpRUkmf7sEnbq2obe/RDWhcgJOrwHaOAVBbT02K4YOH5KjCWzWbeSusFmXBUO4lJ+yuJbTHJiHFum5lK4dC40ga87XEWQVwrpx+VxRrV+LXyyno3Mk+A6FT7FIUNFQHnKjFbASJWoXSN8KcQvvEhzkGSsYRLsFC02jzhZINqfnhK1MJ2ac6eTQniC3Htr7tbtppPNXSBa8bouXtx8PSd+3oDO+9KqKHlX6P1qayykGzBcIzDuwskPcOH70Q9xAdt6yfipe51wuxd/cBEaZd3aYFrIqr0HO+dGQzIkkFgIVpxZ18pxr2CawQNy9F5AaEM1V3P+FXheMVnG0zCeINnCY0h3BOrDWfxlZ421nhxRh+LDahX9EA==;5:ntmGYoppgqjX60KJfwspMbkI6uWT+zN70+O24npztxMVZXaFWbMD33JCkEnkT5ScBGiNvC6Hhv6jRmXmfTZVra7LcoZVjhFSaei3SVM+4CxJmo6zeRXqlEnEOKM+958zc3IevuWxXQAl6VeK5VsMBBOLciLEPnrY31csU0lsY9M=;7:jg6exyQPFcfaxIFbXTFq55Wd+uK6zp5GuASc5Umxfhi3YfryjK57wTTbYHfADljCxAFhu/uz3fOI47mJn7FrDPRVenXNaHGLA1Alg4gdHADsEii+3SLy60hcVrJcHKmm28Ga+YLGvDzJIkzQDEiuFzbl90zX6hhuxTbDspIK2+JY4ajOz2A9tN5+r2OLVkJRxUiImulHP7eWrt0xWsmG2woCuX+ylhMl81SsmOJXkfyp5YSdvNp/it9ZiEVUi2PW
x-ms-office365-filtering-correlation-id: 4d5d035d-8a00-416c-d5e3-08d610d4921b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0135;
x-ms-traffictypediagnostic: CY4PR21MB0135:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB013510B31821EE5543CB4B56FB0D0@CY4PR21MB0135.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0135;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0135;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(376002)(346002)(189003)(199004)(478600001)(76176011)(53936002)(2616005)(6512007)(476003)(446003)(11346002)(36756003)(486006)(106356001)(305945005)(6486002)(6436002)(97736004)(102836004)(6506007)(5250100002)(2906002)(14444005)(256004)(72206003)(2501003)(10290500003)(14454004)(86612001)(186003)(26005)(217873002)(99286004)(86362001)(2900100001)(22452003)(81156014)(81166006)(10090500001)(316002)(107886003)(8676002)(105586002)(6116002)(8936002)(25786009)(4326008)(7736002)(5660300001)(6666003)(110136005)(54906003)(1076002)(68736007)(66066001)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0135;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GTz0e1r7slA8CelK//u26IhbWTYrER5axojgN98/fnY3OlIM3NBm/tEFwf1M8BFjOtct9NvW3Nv9qIT32u76FI0ZEVV/AUSfdqyjLYxFJxXawXDjfJTXPuzRgAe8wF0MqM/hdegwnEjhhwqYdsOWz81/gGiJ5Esb0kmtzPt6VxaPbGPyhGh8it2YBTkTCKrIboO29oBgVqmex4WcL7LHZyVp8HMfP5YStWd7bxBHtB0I3VI3ourGKZcsY9fNtaZrNsLOQajCk5GuAjrB6BP7sm5uE0KY2+onBcVgrit5OT3js6fkERjHByE8YuRqR5bW6IUBzh05iSrWgAmqnl+6SO+jxYCtH3EuiNVogChG3C0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5d035d-8a00-416c-d5e3-08d610d4921b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:42.7086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0135
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
index 4d8b1de83143..34af21f46f2c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1954,8 +1954,13 @@ static inline struct page *f2fs_grab_cache_page(stru=
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

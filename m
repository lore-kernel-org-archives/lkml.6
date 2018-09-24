Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08493C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7E8214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QP0WZ5E1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD7E8214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389080AbeIXUyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:54:20 -0400
Received: from mail-eopbgr680104.outbound.protection.outlook.com ([40.107.68.104]:38589
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732020AbeIXUyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CA31oncrAU/LPnHfLxpamLXOwfPp+Im5W/lnnM9nKU=;
 b=QP0WZ5E1UUHIKk9MF4/dAS3XiD6bqOSXI4e3nGC6efOUqt6aVuL/mluVnwbhsTtjJpVquGnkCifwTJFE479t1v/FG6padE6ZdVk9sMppMwG8AFVb0Y2hn8Qhx9vK/E8TUNJxrJfcPK5blFVeJ6c+JtBVNL+xePOr1Q/nRIWuMqY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0631.namprd21.prod.outlook.com (10.175.115.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.2; Mon, 24 Sep 2018 14:51:46 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:46 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 17/18] tools/vm/slabinfo.c: fix sign-compare
 warning
Thread-Topic: [PATCH AUTOSEL 4.4 17/18] tools/vm/slabinfo.c: fix sign-compare
 warning
Thread-Index: AQHUVBXabke0dws4MEmsKL85PUulMA==
Date:   Mon, 24 Sep 2018 14:49:54 +0000
Message-ID: <20180924144942.164688-17-alexander.levin@microsoft.com>
References: <20180924144942.164688-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144942.164688-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0631;6:iIz9NEwM/pnF1tQ4jvyO0OX0c93dh6Pm530HPELIJWxQIk8LXLiNWRPiaMs16vUhfEasERs3TfjIfhZ+Xc+hb5JxRJHu5FBblUg0VpPAUu83Ps9vFGa0AyBl609taOFkFULozDH9xUdnUFwUZkOeFonIuPFEhBLuUKb10HXwKQOjrDijGxaS0GXtCbsl7lua08ZJObfI6ln4YPuEeF5+jF8Jfp6DgqGSqzlF/g9mQFUK/siCv9Ndh5rnJpU066zsW3DFCH85zN2LnNZDvfpdsbmA7jDAdVvb3v2oHEpnsk/CpbxKEAZV3HBegqaVKK53iibCC/tcWrSM/bFTpI1UTztU5yOtRoa/nXML+vf7RX3/69eZFq11u+fylPmArgkityeBhSoVA6Lp/6hz3p0gbyIDJR/HNL7r25RxXVB2Dquplw6CGXn0hDpRivJH1CGIHw1vMAn7lgvX4bXfcB5yAA==;5:imA3FcOQNLNhc4hPmyP9blAZObgW3SWIUgPSW7bkWfkxJwrdEst5f1D0wQ8n1Yb0T+moKoAfjTvkFQ2GFWtpOi4ctui29GqlQw4UtJ6oR4EFJ3KHM6VDdG8FtqhEENK1gdz0CIJfnNnDHFU9sQgpOED903aK6KmGSI/uPRJsD9U=;7:NBRSLBaOdH9Emro7Zbqg4pERV2W2QgNMDteUdgfkqRyPgObUAMtd/xsNY9THCzoWStUJY8g0NYLQfNR/rpIPHwlJOVJkJJQRltUyM/LF9ooWJEh2xR6JMJGjhUgjaq3+7RVtYiI3hpsCaxwpU6Druk36GePL8qv0foVJJ3G/WxooI3u6FN9321pou+XOYxpsCGE1BoB8bEhhhobtQyoy+zynsSUOlMMf7cO+Y2ee0E/ajEARZUb1+M0YCDXqLPzy
x-ms-office365-filtering-correlation-id: 79b95ac9-d0b2-45d0-261f-08d6222d4059
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0631;
x-ms-traffictypediagnostic: CY4PR21MB0631:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0631DD68E93015FB3010AABFFB170@CY4PR21MB0631.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0631;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0631;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(396003)(346002)(366004)(376002)(199004)(189003)(10290500003)(316002)(8936002)(66066001)(4326008)(107886003)(6666003)(6306002)(22452003)(6512007)(25786009)(110136005)(54906003)(305945005)(68736007)(53936002)(7736002)(99286004)(5660300001)(2900100001)(6486002)(186003)(97736004)(26005)(6436002)(217873002)(71190400001)(10090500001)(1076002)(71200400001)(2616005)(11346002)(446003)(476003)(5250100002)(3846002)(486006)(2501003)(14444005)(256004)(86612001)(105586002)(966005)(14454004)(86362001)(81156014)(81166006)(106356001)(76176011)(72206003)(2906002)(478600001)(36756003)(102836004)(8676002)(6506007)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0631;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ii9zz9oINE5Os/bYhxPLXJNjBEVJkrAVG6YYQ26LTtWAclome6+R6tLgslYz0W6BYrElrH7RL3A5UfLs84IgA1TuOIWN0X6CXuEGfasdLgkccvyEoumUtxOwvjFQAyHkJiEVzOJPlsmclI+iom0e1XOH42GFE4AmpogcJUrpRUlL49QmIjieOFXNlOoS06bo21fFxy/Gq21/uhZ2zJFYECPzOgUZRkin0gDLHEOTr8ip1mKyg5Ef+dYvs9vrAtBNisbqz+szGyYM7rZH+0uyhMFxg87PD2OhtcdqZ3LI3RcP5NkenebBGH2PHBNH5Q/bcOUod7B1RFoooddPh3T0oUFpetNNjw09KniyB7PETzQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b95ac9-d0b2-45d0-261f-08d6222d4059
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:54.0762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0631
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

[ Upstream commit 904506562e0856f2535d876407d087c9459d345b ]

Currently we get the following compiler warning:

    slabinfo.c:854:22: warning: comparison between signed and unsigned inte=
ger expressions [-Wsign-compare]
       if (s->object_size < min_objsize)
                          ^

due to the mismatch of signed/unsigned comparison.  ->object_size and
->slab_size are never expected to be negative, so let's define them as
unsigned int.

[n-horiguchi@ah.jp.nec.com: convert everything - none of these can be negat=
ive]
  Link: http://lkml.kernel.org/r/20180826234947.GA9787@hori1.linux.bs1.fc.n=
ec.co.jp
Link: http://lkml.kernel.org/r/1535103134-20239-1-git-send-email-n-horiguch=
i@ah.jp.nec.com
Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/vm/slabinfo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/vm/slabinfo.c b/tools/vm/slabinfo.c
index 499b8819d4c6..5173a191cd03 100644
--- a/tools/vm/slabinfo.c
+++ b/tools/vm/slabinfo.c
@@ -29,8 +29,8 @@ struct slabinfo {
 	int alias;
 	int refs;
 	int aliases, align, cache_dma, cpu_slabs, destroy_by_rcu;
-	int hwcache_align, object_size, objs_per_slab;
-	int sanity_checks, slab_size, store_user, trace;
+	unsigned int hwcache_align, object_size, objs_per_slab;
+	unsigned int sanity_checks, slab_size, store_user, trace;
 	int order, poison, reclaim_account, red_zone;
 	unsigned long partial, objects, slabs, objects_partial, objects_total;
 	unsigned long alloc_fastpath, alloc_slowpath;
--=20
2.17.1

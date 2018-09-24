Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA6AECE568
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA7D20C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="kdaaaupt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA7D20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388892AbeIXUxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:53:39 -0400
Received: from mail-eopbgr720135.outbound.protection.outlook.com ([40.107.72.135]:34196
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388327AbeIXUxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0q/+ki20QtB9BYLrTrKrfEtz5zIcE5241f4ziImtKU=;
 b=kdaaauptScHyaocDNQsJxyWJ6+KhPpDbXOZ0DDGQL8KlXFFLBJRyOpL3Snz8AT6vZP/3Et59+UFLWoEbIXNKstZbxHTVUXKcaB/pZbWLMMTae2r3iIN11Cnvcw8XAiSzVvfKiH5cLx13arRjituCRb/USGq1ExKjMYSSyUQvwfw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:51:03 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:03 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 22/23] tools/vm/slabinfo.c: fix sign-compare
 warning
Thread-Topic: [PATCH AUTOSEL 4.9 22/23] tools/vm/slabinfo.c: fix sign-compare
 warning
Thread-Index: AQHUVBXQL5CExTAZ9ECWeNtHV7bLIg==
Date:   Mon, 24 Sep 2018 14:49:36 +0000
Message-ID: <20180924144919.164617-22-alexander.levin@microsoft.com>
References: <20180924144919.164617-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144919.164617-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:c/4kFIp0XeJ1aBzYEVku0d3w42Lu+YI4F+QTYnunk3RLfqrbGBCsmflLOcxvX5ymGHnp8ysU4eMBA1IspbcbKlcQ97JaTRMGrHnfElUKK0yBO6WiuL5W4t068K5S0Xh42R4201S6wISgXlAaJO7Xr5RLoa89UWDdnJ3qhPlgh+qc4CXJzr5b2wIWszrkzFYdrx98fYCo6OvcnOox+6/WM02ZXlhYl+7AHqESi1Wu04UJTMobpi2ZDDtH+7v0SjPuxc2EqZNbxQE4TyIiXoud5DiRknDArrE7/01H7Fbc5oHNWdhzaxMlH6GBjRSu8FLPqz43orVg0v+zvrAsnj2ruvklU1Fx5thJPopYpIU7gy39//jJye4cLDdvC3bnzm5TctY7Y0mOYaS9XA5d8QV8fxCaVyp8UoJHZtQePeKDi5zhGPai7n23TzicEzJ3ZNhUMiYHMJeVGYO4lgMT4PhCQA==;5:BXJEjaTSGQ7/sosDFzhgl/hnwl9UWLKIqXJrWqjrL9ZMHkUsZQc4g34tiIlP44UWITs0tU8YFKnsPvp+bmvq8o1aB+Hzur2TUz/dKO8B01tXwGMe+GHtZwyxGwpI9Rz9tPAsNOIvDVDChutg0sB9wfNISeRVrIqG5OEBdo2w28I=;7:NLyW/s8hGmVVIv8DeTMKHuysqbkSUWp0K9P4GCPOLb/iz8A6BJPmQYxu18oTpYjN+Ffrz8WQm2TR2s8RPJwB/FworpUE48c37BnupqVm1vV5fQa6FHtKDki6QYWjO0wUMuAKb+ZZXUhfnwukTE55sVvNV94lFX3mnyxE0B2k4iolE+qVskFvLAyj6Bpz+faIbZpAZriMfp5mw7EDHYxAI0Z08jflJ1/wGHL2waRuqilbgXYK8GxY6kWzW23Ao1Uq
x-ms-office365-filtering-correlation-id: 86891c4b-6e9d-4167-f3dd-08d6222d26c2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB08213F5C2CC44DC92B4D8A97FB170@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(136003)(396003)(366004)(199004)(189003)(102836004)(5660300001)(53936002)(6512007)(6436002)(6306002)(256004)(14444005)(217873002)(6666003)(6486002)(2501003)(10090500001)(2906002)(68736007)(5250100002)(97736004)(107886003)(66066001)(36756003)(4326008)(25786009)(1076002)(3846002)(6116002)(2900100001)(8936002)(81166006)(81156014)(8676002)(86612001)(86362001)(7736002)(305945005)(72206003)(186003)(26005)(10290500003)(6506007)(6346003)(478600001)(966005)(14454004)(110136005)(2616005)(446003)(11346002)(476003)(76176011)(486006)(54906003)(99286004)(105586002)(106356001)(71190400001)(71200400001)(22452003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ZVPeWTo+IBvZzcZMa7CrZjWz6nyxH1zn/NaoDycFLm0ArDphXlMp6dx3Bu5sxFsSx7TnBN/ZABQcb21K2IeL9OEv880jqU2AGYfFbDeAxnoe5wwLStOKKT4G/wWLDG+Z0tCnRMIBRsqhcwAn70r+pynDpvurI0tr/QgOVLijDMc61Ec8Jgljzu2Wflb74aEpe0YzgvWs9LG2FAAylHp0y0Q3cklVNvpztboiVQ9ObPzeRzJrbD8idgEcr3wmcWlWIR701A5r2eH3jc8YaQ0/DgH3zwiG8i7KPEXDncKjlu2IyIsqzmaW1tJ5Ol6ec7DIRErBKY9Qz5E/GRas4PoCdElzfGVN0+KP7sCNDDNUNEQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86891c4b-6e9d-4167-f3dd-08d6222d26c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:36.3536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
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
index b9d34b37c017..6975ec43913b 100644
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

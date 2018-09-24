Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799E7ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2264120676
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FEfZE9aU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2264120676
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbeIXVCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:02:43 -0400
Received: from mail-co1nam03on0115.outbound.protection.outlook.com ([104.47.40.115]:2846
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730462AbeIXUwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNN9AzYpX9bS7dfvVltISJkE4B3nYc4joRbUMZ2XU5s=;
 b=FEfZE9aUNa9beT5psJsUnDtqAcNoopjNXxYO3UTZ4BIYpWhpqn8jesHs5u2FfVOrpguK+3H4E2TFWeCgnQnFgAi5Y32/71YCs4vV+JqwDDsV2kYkMlvGsre9+IBiv2eeEdx1XQlxYlVR3D1ofTu7Lt3mXVDs2rtj6DFAQljDs3Q=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:49:37 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:49:37 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 71/76] tools/vm/slabinfo.c: fix sign-compare
 warning
Thread-Topic: [PATCH AUTOSEL 4.18 71/76] tools/vm/slabinfo.c: fix sign-compare
 warning
Thread-Index: AQHUVBWwcN3hsTNy/UqwxiqPcZ07GQ==
Date:   Mon, 24 Sep 2018 14:48:43 +0000
Message-ID: <20180924144751.164410-70-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0471;6:mB4Aswu9NptJtlRw6vi6U5fX4NCjUlpO1s433KvrPHs859eh0cW/GocUg+8Fq3mfQxmSK7oR1M9BBpLm1PM1LGGq1EoSjGFf8GGFitmb08A4QTioN4Jykbg/0RRc3ct4hKnq7JkLdzDcG9/MaBcmtNcjAqKgGuPUzF567MlDawPCHeLjnI5E2VS9wB7yk0DTjyVRrEO2M5DA7jAbBzTe3t8rJsvKMwZfKa6pkf3VHfk3LjZVY0+B7eMbLlA1XBJAd3hT/XY24bKTMv4CtxbqQwxVPb5GaudN7pxmZdEHWDlzp1fMPpbbMUpFXJAEt9Kdaw/gwkW9vNPETHncw+Kpd1WGcf0kQJGpvsQgFa944jgYwgKMqirVVoPCzfU41M1pBEpvFTC5pvbEUsgZHE4vQKXgopf+pvz8r4fWDRxX1XAIX07a0gEOw0h/zdeMejFwCDh+Lt5UcMau4U/hpiEpYg==;5:QrMRW5ia/48+N6luIkR7WLl9BiR7hnczLGfTG5cNd1RpBR+tt7XZ7PHTd5ENi4E8Z1ef/KjNT9feTHf6fEJF5vCMEti+qGGWWzTuy8UUGhV+JqEAPuy4wsWZvkCgnsacl406l/boHq1HZwSnsPPvwH6/Ldy/q9wyJ6l95ky63ME=;7:UPeHATkRuTERMY7qkAW+TW/R4i5vzwV4nrONww/x61JWXDkhtosJnovqMeSZWIerUHYEe4g5oaewfriSVcOYcIgfPmZqAnU2G6rZ5OEaRQqja8/nrHo8nK56i8NuAN/qno2GrTtxzsZrmbR1MQhGSMtWCt7kjpG/vHWcgSkYSgWGfd7D/M6MOjFkWC34LVt+eYw4BaUpsYnZnBcb5OQeaL4doukINBEmdmcGjVrOD4YfOSsD9JK7viIOb5O4gvVQ
x-ms-office365-filtering-correlation-id: 13177acf-9c0e-4751-42d3-08d6222cf304
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0471;
x-ms-traffictypediagnostic: CY4PR21MB0471:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0471BB25088C144930F79353FB170@CY4PR21MB0471.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0471;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(366004)(39860400002)(346002)(199004)(189003)(6512007)(105586002)(256004)(53936002)(14444005)(106356001)(10090500001)(6486002)(217873002)(1076002)(6436002)(71190400001)(97736004)(71200400001)(446003)(476003)(11346002)(54906003)(316002)(2616005)(86362001)(575784001)(2906002)(86612001)(8676002)(5250100002)(26005)(81166006)(81156014)(36756003)(10290500003)(4326008)(478600001)(2501003)(7736002)(110136005)(966005)(2900100001)(186003)(6666003)(22452003)(102836004)(25786009)(305945005)(68736007)(107886003)(76176011)(486006)(6116002)(6506007)(72206003)(3846002)(99286004)(6306002)(66066001)(8936002)(5660300001)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XO2SE9xintVJ/P8KvYgsEgVummtFLzDsCokVU7hNjotWhkPy0N11RTvbKUmY7a54c2+F5YxGtCi53ZF1bWZe+nhL8eUKLNoa6jtgV5u5oV/7rdSfmjkDt0W628Thccua8gWGv2jwiy1QOuoNcELp9gQX5rniKVIEhcjjUFnzcuQNOy7lXlbSfKRogbbsesa1E8D9Ar2/zwAGOtZD8nVCQrmRJEpt/bhH66aWgVyE9QtXMucd2snbFS0i9XeEoC4jiz8tbKxLYXDT0yXeVBtmJzrRzoGZOB64kOJFIkh+0eFH5W8ZhJG4c48LfBqdojlDGeehbLhx3dQFq6WEmwYLzMHIZckMuGqCE3i5c1venxE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13177acf-9c0e-4751-42d3-08d6222cf304
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:43.3189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
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
index f82c2eaa859d..334b16db0ebb 100644
--- a/tools/vm/slabinfo.c
+++ b/tools/vm/slabinfo.c
@@ -30,8 +30,8 @@ struct slabinfo {
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

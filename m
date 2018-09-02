Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C58C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E5320841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KBYQ/V9u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E5320841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbeIBRTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:19:25 -0400
Received: from mail-cys01nam02on0094.outbound.protection.outlook.com ([104.47.37.94]:40784
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726020AbeIBRTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjcfTT5Kx3hZvXNa0Q0/SGC+s7nTREgnaKOzJGOPwNo=;
 b=KBYQ/V9u7urJu72Hx5ZY41RhDzRhewoDCvyrwg3GEjDhNpu/gp0DZLsCkyrTSSJGHn/RMoONluHWnDKolAQMNU/n4lYeu81w3aUzvSo4g363ChtWr17bAbwAWoUvn0b32s9c+7gBQxPj6t52PF/Tlf7bDMWnQMybU+9Zeakg+2k=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0150.namprd21.prod.outlook.com (10.173.189.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.4; Sun, 2 Sep 2018 13:03:24 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:03:24 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ming Lei <ming.lei@redhat.com>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Omar Sandoval <osandov@fb.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 020/131] blk-mq: fix updating tags depth
Thread-Topic: [PATCH AUTOSEL 4.18 020/131] blk-mq: fix updating tags depth
Thread-Index: AQHUQr1UdehFVTuiiUOn3sGeNUmOWw==
Date:   Sun, 2 Sep 2018 13:03:23 +0000
Message-ID: <20180902064601.183036-20-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0150;6:rZMXXmEEhUP8MwZLnoWMcitpu0tyVzXYIUeQ0qtXGW0z4SIFdL02zZszbYsRDYZktL9kZwo4uUCnDEUlaY5bBv/7iQb2r8Rtav93Z66aJkVZVjVI44G6ySCb89IbEc9NwkdoKbjHdvuZanXsPBeZO+IA/EOb2H+nr6VLVQJl6k1nNMAh0evoExj0yn9ymv/XWANEIcQwKAD1UCDsCQ971pfRpQFZa7JQaIbo+ck3zciA+uOcmZwPaWiJn8jWAtAZwdHSBwK8TCT5kiorz0lVb8geOgmCpN/MZ6PVH70LntqVY4xhxL3+BsnyA8dpL9XFFPKJQHNatS7OMryBxwJ8hJdObwnqGqoI4AZgWIIilaHS8can6CVvQpvJg3FXrTLN8vRIX1tYg+Ttwc6Fe2oZzXif//g6U4aeXZEGYdNTIdqL2mQeqyCk0OEeDaKGBmvY45h7xmXUfDx0zPOOXkT/1A==;5:11GPRomEFKI9F/W+KoKJ6v4GhfE5AJouhq6GZtlT/PvPOIiyNyCZHfPUqCwRafKJCKGDZ0OolGbcBahzk2Ti6UhbLpuouttqJG7C/CC9RLodF+jGs6Hn84uNYfqev+Md6xJJ7INiaHDWZCES9o0P92cYLXL4MrEqqu6ufXH8cjo=;7:/BI6N0hOB2r/aHrpfMtU0XOz87MMFuz+1VLEHQd71OWX5FhhPIUv1WRkEgVlJAcFNZ+9uhq93BbzhgHYg7L580G/BhOks4qehkHI2s17MChSQ8Bq8ph56KXNjrz2GgH90ljfkzQ9OfXKrHx7srAoeDXKMr58JxgTWe7nN1sV8q19rpKbtSEA/mrdZCCd4CNTpPYhgSQ52SZzMThgun1bCVg8SjsADu7+I6NTxhIygSayZcEXi7GxGfWlc8g0fkv3
x-ms-office365-filtering-correlation-id: e409d6f3-1797-4c90-e9a8-08d610d47767
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0150;
x-ms-traffictypediagnostic: CY4PR21MB0150:
x-microsoft-antispam-prvs: <CY4PR21MB0150409E7A035A6E105FFDA2FB0D0@CY4PR21MB0150.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484)(42932892334569)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0150;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0150;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(256004)(22452003)(2906002)(217873002)(3846002)(68736007)(10090500001)(6506007)(6116002)(1076002)(6436002)(102836004)(486006)(53936002)(76176011)(106356001)(105586002)(14444005)(7736002)(305945005)(8676002)(316002)(5660300001)(6512007)(99286004)(36756003)(4326008)(97736004)(5250100002)(2616005)(476003)(2900100001)(11346002)(186003)(2501003)(81166006)(26005)(8936002)(81156014)(110136005)(54906003)(107886003)(66066001)(478600001)(86612001)(14454004)(6346003)(6486002)(10290500003)(86362001)(72206003)(25786009)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0150;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: RB+FIN85+8gwzjpl0B1n8rn73slOLRkZc+chqV/B6WsvrbQ2cCaxKxwugMScEAyn2I0pT0ZcqpcFSyaybRGfEkp9hm2hHALoksa6IvGhU+P80/l0U1f+2KBaGiRR80bqtyPVVxrzWhxBKnZ/M4meIHR5xH9Csen0uDG5nJRE8wAHpwimmrU2f6kdVYHlVwTu/lXU7kuC6VSJZRdmq2m2Z9ZRmmOKs9m0FR6dfr+iFxkT+F0TCn2Ml+IbZLvhog+TSzvxPTWzMJdnQph/6lXsSXfhG8VWwQlhWLJ6A96moB1C/JM5SFjJ6mI13eOCAothRdmLGlA/K1n7P66tkqRxxLspxpOEYJcAed+0rYjwFeI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e409d6f3-1797-4c90-e9a8-08d610d47767
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:24.0112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 75d6e175fc511e95ae3eb8f708680133bc211ed3 ]

The passed 'nr' from userspace represents the total depth, meantime
inside 'struct blk_mq_tags', 'nr_tags' stores the total tag depth,
and 'nr_reserved_tags' stores the reserved part.

There are two issues in blk_mq_tag_update_depth() now:

1) for growing tags, we should have used the passed 'nr', and keep the
number of reserved tags not changed.

2) the passed 'nr' should have been used for checking against
'tags->nr_tags', instead of number of the normal part.

This patch fixes the above two cases, and avoids kernel crash caused
by wrong resizing sbitmap queue.

Cc: "Ewan D. Milne" <emilne@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Omar Sandoval <osandov@fb.com>
Tested by: Marco Patalano <mpatalan@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 block/blk-mq-tag.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 3de0836163c2..33c49118caa2 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -399,8 +399,6 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 	if (tdepth <=3D tags->nr_reserved_tags)
 		return -EINVAL;
=20
-	tdepth -=3D tags->nr_reserved_tags;
-
 	/*
 	 * If we are allowed to grow beyond the original size, allocate
 	 * a new set of tags before freeing the old one.
@@ -420,7 +418,8 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 		if (tdepth > 16 * BLKDEV_MAX_RQ)
 			return -EINVAL;
=20
-		new =3D blk_mq_alloc_rq_map(set, hctx->queue_num, tdepth, 0);
+		new =3D blk_mq_alloc_rq_map(set, hctx->queue_num, tdepth,
+				tags->nr_reserved_tags);
 		if (!new)
 			return -ENOMEM;
 		ret =3D blk_mq_alloc_rqs(set, new, hctx->queue_num, tdepth);
@@ -437,7 +436,8 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 		 * Don't need (or can't) update reserved tags here, they
 		 * remain static and should never need resizing.
 		 */
-		sbitmap_queue_resize(&tags->bitmap_tags, tdepth);
+		sbitmap_queue_resize(&tags->bitmap_tags,
+				tdepth - tags->nr_reserved_tags);
 	}
=20
 	return 0;
--=20
2.17.1

Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0752C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50181204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nKk9Cofs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50181204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbeIBRWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:22:39 -0400
Received: from mail-eopbgr720121.outbound.protection.outlook.com ([40.107.72.121]:51200
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728956AbeIBRWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11ox8HDdEKIVMhXmocNJ47fK0DwhqTwUjLBaN1hEXkk=;
 b=nKk9CofsXFAH5fYe08ZKI54P52c8JIIdmZPnhU3QWfOc7RvZq9kE1f/foI74tmrtmGNyVt8ffp0cp5T7u/4d9GAp1pvWlBNuuxRQYRqpS8V8vd5n/XaMJ5FgD3DhzjHlFk6KPFKNM3Rs/fhM6wqRVuW5T9Brg1Sc3BDozqnGeW4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:06:25 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:06:25 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ming Lei <ming.lei@redhat.com>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Omar Sandoval <osandov@fb.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 13/89] blk-mq: fix updating tags depth
Thread-Topic: [PATCH AUTOSEL 4.14 13/89] blk-mq: fix updating tags depth
Thread-Index: AQHUQr3AHBq2iUv3YE27CwSaRx8OLw==
Date:   Sun, 2 Sep 2018 13:06:25 +0000
Message-ID: <20180902064918.183387-13-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:qPP27PoqO98trcNkpuB6DmPBUe9qCOJzY5glLXzCf6WVipGM4stf2vIB8Xbjz1pDZkapmM0OoYKjaHb5GTsyscR7UzIDFC+G57UVpCV6/syfmg0/hIVaRjaObErHmgS2ygkq0mcSRdrAt0vyaOBXbiObtqJm7kEu8iEABHukvfevo270562R6LN1C7Oz6vrmsWYQKtMYAkSKwwdrug9xuhNgau8pMWwLnSy30A1SKLTwwaeeapsA46ZlNEceJkieHjVMadOpTjIpvRStkKBxuyujhZPGQxWYCxOOSb/cXe9DkWhYqV/P4di2uBpcYKzGm43HisAT8WGEPSQBrgBk6pXDlbDhTNhnTrGfWqxkQERLRNe+sQBXRAabT9BTtjsLRoj1Aoan+MYbTnSm/a6CvsT+2rJwRFWNmRt4GNyS4YTrMUqS0QjIP1dVTz3cYPziQdO0RkyJ5mcqp95hz6bPfA==;5:HZY8c4ZyhCqFZ+CHC+zbefGK4FjzJDiIlO0B9M1We+K593xk1YTdNI7b0G1vJ9jp6S+6o4iF9KzCa+L91JZm8jhiXwrP0awFhNSOTiQV2TxwE08UVWv7G78HsFdx2oeZ+h/1sNCPLf6fnF1ggnQsZN7gjhusxtERw2Jq35vvoxk=;7:jyaABo3Ec2YVQGBHcDElH6W/nxfXqDeNQvG7nQXbtUZhSXB/7ERWLzqby5d1f2DQ0HHuslHRWFaL8C0C999eAWo3WMzv0PqWXrjdyfehHV4ecH/mA53lOvRv0JnrG/o5piQivRegIASm+EkG588NcMY99NQHaq8pNNsAOB0cotbJSBKB8PVLJudJWgvIf4vJWsNvN9pD6kCVqbPnlpKr61qgn5nK1B+dliKf2uWwkJozQVX74LCio+t3TurKYOSe
x-ms-office365-filtering-correlation-id: 67f62144-d9e5-4b36-752c-08d610d4e353
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB0822C0B0B99008783C24092EFB0D0@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484)(42932892334569)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(366004)(39860400002)(189003)(199004)(256004)(14444005)(6512007)(486006)(86612001)(97736004)(68736007)(478600001)(446003)(11346002)(25786009)(8676002)(10090500001)(8936002)(2906002)(110136005)(86362001)(107886003)(4326008)(186003)(26005)(6346003)(76176011)(6486002)(53936002)(2616005)(476003)(72206003)(10290500003)(6506007)(81166006)(81156014)(66066001)(22452003)(99286004)(102836004)(5660300001)(217873002)(106356001)(2900100001)(1076002)(7736002)(2501003)(14454004)(5250100002)(305945005)(3846002)(54906003)(36756003)(6436002)(105586002)(316002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: als5fXZ5O08reYhPcIQS2VvosfGhxIUm6t62KVhRkmSoSo1Rw4CQZciRs7WGhXtRXXKFVMuKw5/15NpAO25vUonrkps2JNbNOnptLYBzzwDCKfRviAioS8dli8x+3CsBYDYMGehYalOS4FUlRa6NAL1iOgfCApJkIHSNHg3aP+gwOhwkgGBtXKpRVkBPf1cDxZKYpzANxu1YF8poWM+NA1Bx9s418lvfr3wF1RJ0sBYWY526C0YMBpESV79OVqxWngd0jbUxd8vAOQ5VqX0w/UM6/2bPhl8NUZHuC3sv/euDdntRRxpIeJYfyV4OWsAzVU5ED56i2RANkLpK5+2OCOO4oxUWqkYjQFBDnS2gchk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f62144-d9e5-4b36-752c-08d610d4e353
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:25.0360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
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
index 6714507aa6c7..3d2ab65d2dd1 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -416,8 +416,6 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 	if (tdepth <=3D tags->nr_reserved_tags)
 		return -EINVAL;
=20
-	tdepth -=3D tags->nr_reserved_tags;
-
 	/*
 	 * If we are allowed to grow beyond the original size, allocate
 	 * a new set of tags before freeing the old one.
@@ -437,7 +435,8 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 		if (tdepth > 16 * BLKDEV_MAX_RQ)
 			return -EINVAL;
=20
-		new =3D blk_mq_alloc_rq_map(set, hctx->queue_num, tdepth, 0);
+		new =3D blk_mq_alloc_rq_map(set, hctx->queue_num, tdepth,
+				tags->nr_reserved_tags);
 		if (!new)
 			return -ENOMEM;
 		ret =3D blk_mq_alloc_rqs(set, new, hctx->queue_num, tdepth);
@@ -454,7 +453,8 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
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

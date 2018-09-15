Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FF6ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18538208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Lwp+kjCh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18538208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbeIOGso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:48:44 -0400
Received: from mail-cys01nam02on0113.outbound.protection.outlook.com ([104.47.37.113]:35712
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728812AbeIOGso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7cgyzsWP6CD9Tkdxys1b1IPWG4IJz2V4j8uv8PvBu4=;
 b=Lwp+kjChEJAiulyeVgDcCaEcrKWuqAoGhlz4erFtMgLc9snQ9bouIZrMw6300+c5pP/VkHJnHYP08w3UP+4V2q3DC7HjfHH2PFQqX7fZBU+EQKs5ue6PBDoEnfJHRLzN1qPk9VdkWTht06nPhMWXpuqETTV5bSjvdh68786+6Es=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0117.namprd21.prod.outlook.com (10.173.189.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Sat, 15 Sep 2018 01:31:41 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:31:41 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ming Lei <ming.lei@redhat.com>,
        Laurence Oberman <loberman@redhat.com>,
        Omar Sandoval <osandov@fb.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 87/92] blk-mq: only attempt to merge bio if there
 is rq in sw queue
Thread-Topic: [PATCH AUTOSEL 4.18 87/92] blk-mq: only attempt to merge bio if
 there is rq in sw queue
Thread-Index: AQHUTJO+xsTBxEvFrkS+tytoy+ySqQ==
Date:   Sat, 15 Sep 2018 01:30:53 +0000
Message-ID: <20180915012944.179481-86-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0117;6:tXiZ4qPy458iOHifaz9ELPrnzGGnr62TuL9vzbfqGntv/Vcs3OYJkwg6j3z6G+iM5lztKBdOuh0b1HG6/uhQDw6TYsEzzAQh4jcELNOEs+Mlwjt7D1OZbbhqENx6LhGBeAa6FXCHCYLOUzGelact+3UbHfpGTkKjfdTDLLVFkM0Nu5HfgtxxWFYNHbI0r1D2AwKcfgb0YDalYPfSdMdwW64MpfxPFqrfsbi1q3vWqRmViyRRgH3ozRTUCQtqXN/Ziy8vVo1edzff6vpnj4vB+zWF1UB8fCPW4DsyyzmSy/PVzz3xK+dcYFdYdtHni2L3uT+ZGtBMyg7hFMzXVcBWrjaOHumaC+dJnzCECpecwDd8j3fCf8MNXQ3D1wL1xgcvlRE3SrckEII9SgDhI376rlkwW+zuxZD0l2Y55jA+BP1tx47W0vbj6ncprCFkRzuDPUfJfDN2L61HtEvpK15j/A==;5:ZEsQAlowYxUT6pY5lpeWFK3JobS/bdHM2oJ+mCO1N4mPtlfG+xxYEIu2xs6pyvf5tWExscwrSqcynQUpd4MoZzKH3Cyg+8MRej/L8cR2ZWi9cebC3YoL0lY5+A6WTaD95GlhY7dl1+8Kt1A0t/9XpTyUi5qu7SjxS7f/uOEPd84=;7:zpai0W7Y/Hxz48I+UJrqyg1MJR6/YsaIjAuYbDZENeRNj6l/6DyWqisAMppNVmwcJ43Es/aHDTxMUeaqIX1WIuxOjBZJnWBmbsTGF7wt+davh0XBK3yzEBpy0RjdoOjJDzTnTCKVLDLZ97yg3i4UPmdcuHdbAa02RFCLqyCjmSAKzYTYkWH5BKBU8EVrBULfypMf0tXvUhR/k44IreKomFU+BHvGDBwqJ8XgzRaBJ7uf3YTxNAsrZR2PI9h/Rdjf
x-ms-office365-filtering-correlation-id: bdc23c81-863f-4423-9158-08d61aaafd4e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0117;
x-ms-traffictypediagnostic: CY4PR21MB0117:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0117FF65D09D7EBFD027191DFB180@CY4PR21MB0117.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(208715162771679)(28532068793085)(89211679590171)(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0117;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0117;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(199004)(189003)(36756003)(316002)(2900100001)(110136005)(54906003)(8676002)(478600001)(5250100002)(2501003)(66066001)(72206003)(10090500001)(446003)(86612001)(476003)(2616005)(8936002)(102836004)(11346002)(486006)(14444005)(86362001)(256004)(186003)(6506007)(22452003)(68736007)(26005)(217873002)(305945005)(6666003)(2906002)(6116002)(3846002)(1076002)(106356001)(7736002)(5660300001)(105586002)(53936002)(14454004)(6436002)(81156014)(81166006)(6486002)(10290500003)(6512007)(99286004)(107886003)(76176011)(97736004)(4326008)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0117;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tjh39B/RqUEVSIFNeoGVqVeXuJ83OCF83kYAVwo1hmX0DSRlEcXyTs2iLIbEsm3ORltXgQVYxRfHXZuE4Knqgzw4vpsPNqeEBXmCkrnNsyONfskcc8cKm316qVsj8SrV/3gY0+kWmgM29sWns2YJwctMBy1j123KYLrl4tV6xvF4I3yJyFeU2KMa3ygQXxEkddnJSgE3afTbYiIiaotOs/8JtAcTNO1eeCrnTRskCTxNuRIHrtSKooNZcQw4vAOrS4c9mjCcntll4bUAvv1atM6mvH+5LcK80WUKhp1ebCvbxnJeLwPRLCtQKZ0rwpLg9RIqoE6m4NGgpow5S6W8IrYFuzbLjh+w2WSgIYtpfg8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc23c81-863f-4423-9158-08d61aaafd4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:53.8229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit b04f50ab8a74129b3041a2836c33c916be3c6667 ]

Only attempt to merge bio iff the ctx->rq_list isn't empty, because:

1) for high-performance SSD, most of times dispatch may succeed, then
there may be nothing left in ctx->rq_list, so don't try to merge over
sw queue if it is empty, then we can save one acquiring of ctx->lock

2) we can't expect good merge performance on per-cpu sw queue, and missing
one merge on sw queue won't be a big deal since tasks can be scheduled from
one CPU to another.

Cc: Laurence Oberman <loberman@redhat.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Tested-by: Kashyap Desai <kashyap.desai@broadcom.com>
Reported-by: Kashyap Desai <kashyap.desai@broadcom.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 block/blk-mq-sched.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 56c493c6cd90..f5745acc2d98 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -339,7 +339,8 @@ bool __blk_mq_sched_bio_merge(struct request_queue *q, =
struct bio *bio)
 		return e->type->ops.mq.bio_merge(hctx, bio);
 	}
=20
-	if (hctx->flags & BLK_MQ_F_SHOULD_MERGE) {
+	if ((hctx->flags & BLK_MQ_F_SHOULD_MERGE) &&
+			!list_empty_careful(&ctx->rq_list)) {
 		/* default per sw-queue merge */
 		spin_lock(&ctx->lock);
 		ret =3D blk_mq_attempt_merge(q, ctx, bio);
--=20
2.17.1

Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E7CECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5370820866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="olXFrEIn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5370820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbeIOG7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:59:11 -0400
Received: from mail-sn1nam01on0128.outbound.protection.outlook.com ([104.47.32.128]:46048
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728396AbeIOGu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQ7KlYC1R+yQEiYSZ6qyNP+OTfXc061OaeVhzznRYhE=;
 b=olXFrEInMigtgLnFtXooCRuIorsmb0WpQB5CrgpK6S8iBUovFWBMpzzCD6DYAM8iYRnfV6HB2TUQb5hk6ub/Fb0HPEozttqj+FC2v8t6q2C8NOA8B3vkzSF54yvnqOIVENCNspV/az2HgchYW32WdujxD830DrDDRh8RhaRDRyk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Sat, 15 Sep 2018 01:33:26 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:33:26 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ming Lei <ming.lei@redhat.com>,
        Laurence Oberman <loberman@redhat.com>,
        Omar Sandoval <osandov@fb.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 52/57] blk-mq: only attempt to merge bio if there
 is rq in sw queue
Thread-Topic: [PATCH AUTOSEL 4.14 52/57] blk-mq: only attempt to merge bio if
 there is rq in sw queue
Thread-Index: AQHUTJQKqKcljvtPeE23oFjpx+JlKQ==
Date:   Sat, 15 Sep 2018 01:33:01 +0000
Message-ID: <20180915013223.179909-52-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:enRRfaG9qiGJWtnztqHHilxWkceHA/vunFAtR1YXnqkJeF+xVRoVX0FS5WmQ2LX5XCt00z9SdRyj2QOoZcMu6yIMbeUVI/mT8AQ+V6nlpqsGiPP740v7tKxytUPmkBTbJA7dXL8oovKUbpizI0HqmW2g8jVduw8EMfXrdPH00Kg485pMMSC3VI8gCABCeGc6TLlobZWHvrdqEPf0G0XQRMDBmqlestmtbfyt8LVqJJ5fPGrRMXw+sSJMEkhpp2K1fDAaxHo2/ewgHfAARFSCgKgGE/3Z3/Zx+7i/P3L9WPDOLdKrTy+tBLlVfmBZd81i4G/Yzkvc//dKFDdrPnjO/lfUHqB3P7sBr2D0ir8L3vuley7GoYK2kBHoNrNKIvoVyntx0vCBQZ43pqvVJghJ80lAB+onJNJ7nAKLGiQ3QK9/DyeLAlMiQ/tlxqeMUvC1zrqZ2idIjXZa+d2Ocq/lNQ==;5:hzZo/cmHfbkjG4udJ6lpWwBaG5W52ek8awDOt0JWJrtkWcxz59Hx/O+JJRWFeVTFSvD8udVOa9ScEKEmpND/vTZGNM+vYqGTYUuDDgCog7wYnbvmrP/cR3jd+myTusy4AdBPnrgkV4jhEVA/dUCJB9+clUKId6R1yHg8U+JbTVY=;7:GuVRLfDIbmAuiGWp2mkLxMpmuC+hsDZG1OX5klVm33xQSfgc7LNTu1M0zei2ZzfQ9YKi6rG1HIh4fJqXwx9LZ8k9YriFt6jXYxCUwWnGt0hD4O97jXkHg5J3OIOVB81tUEIxBuaTbhbfbm4tgCj75xppHWlvPA7iIP7/Yo7ialNyBSUG2Xhg00dCDqFMH22xOoW74PZHOb0HdbKLWSR7PH8Syp3J6oQUhMPwvEqz4eW6GiW015qlayk/wX1zEL6E
x-ms-office365-filtering-correlation-id: 0fdb1cfa-c14f-4daf-394c-08d61aab3bce
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB0855ABBE51996C41A6887C9CFB180@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(208715162771679)(28532068793085)(89211679590171)(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231353)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(346002)(136003)(39860400002)(366004)(396003)(189003)(199004)(102836004)(6506007)(305945005)(7736002)(10090500001)(575784001)(86612001)(86362001)(106356001)(97736004)(107886003)(186003)(6666003)(26005)(6346003)(14444005)(5660300001)(256004)(5250100002)(6486002)(105586002)(6512007)(2501003)(2900100001)(22452003)(6436002)(99286004)(316002)(8676002)(76176011)(53936002)(54906003)(36756003)(110136005)(10290500003)(72206003)(478600001)(68736007)(66066001)(81166006)(81156014)(8936002)(486006)(1076002)(3846002)(446003)(14454004)(6116002)(476003)(11346002)(2616005)(217873002)(4326008)(2906002)(25786009)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 150s5Z7C8At50JhIza8+ZsD0bfRX0HcOmAqd1fkWzFJh5PRtxreIm9Pcej2RTnw9HiU9uqJeZvovnfkdMdlya/PVCzyI4AeGqqAtuAwiVD4FRepYujqzgj6eYVmdAmROGELMVbYwDTENc7Yf8MVQtovPonmgUqLvBnfhylYzQASuNjFinaCDxJ9b3wPmR5Vxqk6bpyB2toBiY6V1y3r0h0SCvUh5xgVs9M7fIMWc04993+lU3j9O1gvHpwUn1hi8UF9L6YZJIy6ALr1fYrTE4jOV+uPM+PAvh0dJxCp8JG7+RN0I80pr4Fy/CtWpVH//JyJvsF/FtnR3arpgwg8AJWS78NefmL18B9CpIyjc0wg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fdb1cfa-c14f-4daf-394c-08d61aab3bce
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:33:01.7739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
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
index eca011fdfa0e..ae5d8f10a27c 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -236,7 +236,8 @@ bool __blk_mq_sched_bio_merge(struct request_queue *q, =
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

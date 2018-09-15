Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A86ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B6DE20866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LNKMLibC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B6DE20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbeIOHDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:03:44 -0400
Received: from mail-cys01nam02on0113.outbound.protection.outlook.com ([104.47.37.113]:35712
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728847AbeIOGsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDVb8uCRmi8r+npUZ72Y/z7zUxNE5TszRiiIAg4Wdug=;
 b=LNKMLibChvIZe21gIi2+oZLJzhZSu0vQWiKasnjVTlACmI07bJU3I+yBJn5C4wi+bg7Cfs91Vci74qxUSHyu1CpH+XcIhLTGJDWCNAvUw3ChDdJ9RnNv2+tJr03RBfXXYvknCQc6jFU7QqMBWooTpJ9oCSA+A+vaxwrXjMPSY/Q=
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
CC:     Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 88/92] blk-mq: avoid to synchronize rcu inside
 blk_cleanup_queue()
Thread-Topic: [PATCH AUTOSEL 4.18 88/92] blk-mq: avoid to synchronize rcu
 inside blk_cleanup_queue()
Thread-Index: AQHUTJO/WIbVVL61y0KzqPJQbW7ZxQ==
Date:   Sat, 15 Sep 2018 01:30:55 +0000
Message-ID: <20180915012944.179481-87-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0117;6:WL0QiOnXKJyxmhbZiQVsG4I4xYOMklqY3MgnzdaSPHWGOIpoAAAtftEp+eyU7EMOoocpUAGIINgMr8Tp7pvFx1EEnepYi7R2ZoJqHmx9e/5OwXl/n91qZ24Dn9I6NPrpXnXhhKv/NaK9dNOuGXi390XQXknZT2kGGTpkg31d905Sqei/o8m1PkJOJzuweFGeAA03I6LCzZgGc437lMKCngx7Pnf7adqkb3lFTpnFTeiGTRtz1va/CCnEx+qa9Ex79oJfWDxmcDP7h4VUiIGfI9QQlGU/0z+oy3us5WGXVe4Z9XGEd0qeCh93LggID7hXGxw6kLbGxFtukhCZr2/ZnrWtl+Ifz/116V8ezAV/kWhv28mFoBor7oBSpmtswNUse/1CFHUY1Yhb3MwL3kQya4JxTgkCh8N23czG/x1QmMhVWf6hLsX09QW+a74wz9d5A3RvQAcQB6NrhZ49xEijqw==;5:/j2xmmfzUx1+F6erWPqYhyIGzkpZv/TKKjhTuqcFg1c/WsPQF2k5vVqZmCsxgqGtRIfqE88zvkyOa5Hiwd2UCn2OU9TAXD0LX4FFwz6zw/UTGcR4yh3/k+s6zV6LBXa4Iz+850RKkJ2oooCYgOykInH4sMJzmYKBri+hYsdLvKA=;7:zQDvFIkflB/h6ecVRdjrjIV14mF40Ufyv1cgxkrDIHNaSUramlf3wt6HFg9b64eErMJ8qPGXbOz6pDmN348DHdo8N7hG71Zs8L5YlvL1ebkUrBscf9hJZM5253W4gJCum8Kg3ShdeSxeVoulJqCSSur/gyaiJNnZs7YvrK776bb+jmF3UsQuQEV88PdXBzgH69Zl1gtSVESmUt4rpiyRIEdc8bL2ufn8cJgpw+WBaANNYdgeLbcXvI+FAiXxLKNM
x-ms-office365-filtering-correlation-id: ca0015f4-20bc-4a0c-a2ac-08d61aaafd80
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0117;
x-ms-traffictypediagnostic: CY4PR21MB0117:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0117545CBD53DA15D3B0C21BFB180@CY4PR21MB0117.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(67672495146484)(146099531331640)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0117;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0117;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(199004)(189003)(36756003)(316002)(2900100001)(110136005)(54906003)(8676002)(478600001)(5250100002)(2501003)(66066001)(72206003)(10090500001)(446003)(86612001)(476003)(2616005)(8936002)(102836004)(11346002)(486006)(14444005)(86362001)(256004)(186003)(6506007)(22452003)(68736007)(26005)(217873002)(305945005)(6666003)(2906002)(6116002)(3846002)(1076002)(106356001)(7736002)(5660300001)(105586002)(53936002)(14454004)(6436002)(81156014)(81166006)(6486002)(10290500003)(6512007)(99286004)(107886003)(76176011)(97736004)(4326008)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0117;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: r+Zx3QivOfag1rJgQXG9AqEHQk2PuudgJyr2r15q1+rSdgJjIL6RxFEUco70fHD22fLBh6C9sAve2jyI17PX4l1wemUHZzGyhSkAmtwD0ebZCWzmoU7et0FnI8M091PRNBcMSAf9pKL9DTn69YicVTsn6SuaxEGnsXwOof/Ci7I0TaSomqfMtK3JmTZ9dzJDtkcz3h97UpxsWtHZ9DHPODbYRudGyK1wm3jZNPZjkztUBiXjT9N/Et9Vn545Fm/Nq7oFAnZs/RpAboXKnXCkGmWY4sWJZjTlkRDEDhvod2LeGXELGIbt8Xji7b34r+k4nsP+e5Vy87Q719RMihuDZcOGIm6ZEn1t7xlUFnlG2aA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca0015f4-20bc-4a0c-a2ac-08d61aaafd80
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:55.2291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 1311326cf4755c7ffefd20f576144ecf46d9906b ]

SCSI probing may synchronously create and destroy a lot of request_queues
for non-existent devices. Any synchronize_rcu() in queue creation or
destroy path may introduce long latency during booting, see detailed
description in comment of blk_register_queue().

This patch removes one synchronize_rcu() inside blk_cleanup_queue()
for this case, commit c2856ae2f315d75(blk-mq: quiesce queue before freeing =
queue)
needs synchronize_rcu() for implementing blk_mq_quiesce_queue(), but
when queue isn't initialized, it isn't necessary to do that since
only pass-through requests are involved, no original issue in
scsi_execute() at all.

Without this patch and previous one, it may take more 20+ seconds for
virtio-scsi to complete disk probe. With the two patches, the time becomes
less than 100ms.

Fixes: c2856ae2f315d75 ("blk-mq: quiesce queue before freeing queue")
Reported-by: Andrew Jones <drjones@redhat.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-scsi@vger.kernel.org
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Tested-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 block/blk-core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 1646ea85dade..0f5b314fc810 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -791,9 +791,13 @@ void blk_cleanup_queue(struct request_queue *q)
 	 * make sure all in-progress dispatch are completed because
 	 * blk_freeze_queue() can only complete all requests, and
 	 * dispatch may still be in-progress since we dispatch requests
-	 * from more than one contexts
+	 * from more than one contexts.
+	 *
+	 * No need to quiesce queue if it isn't initialized yet since
+	 * blk_freeze_queue() should be enough for cases of passthrough
+	 * request.
 	 */
-	if (q->mq_ops)
+	if (q->mq_ops && blk_queue_init_done(q))
 		blk_mq_quiesce_queue(q);
=20
 	/* for synchronous bio-based driver finish in-flight integrity i/o */
--=20
2.17.1

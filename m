Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE6BECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C049208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ikZ0CK+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C049208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbeIOGvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:51:11 -0400
Received: from mail-sn1nam01on0128.outbound.protection.outlook.com ([104.47.32.128]:46048
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729435AbeIOGvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xELKqlFYcPD9Lbot0BzacVmTY9nrCAwJQyjyKmtsk50=;
 b=ikZ0CK+MseNw680FWR0nrM7OtwaYiPunt5UAcKfl/kHKospVpu9SJl+PywcyrM5vj4LrteBlLondMlbhad6KszYCxtoIJ1rhTszqOG7rj4ePv4SFO1r8DSv1pOXM/97qkrhin04XQ0fNUO9FO+9o3fEqvdY6TXXi5uu6P1q1fQs=
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
CC:     Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 53/57] blk-mq: avoid to synchronize rcu inside
 blk_cleanup_queue()
Thread-Topic: [PATCH AUTOSEL 4.14 53/57] blk-mq: avoid to synchronize rcu
 inside blk_cleanup_queue()
Thread-Index: AQHUTJQLcnYpfMuY8Uqb8FNpU3rhMA==
Date:   Sat, 15 Sep 2018 01:33:02 +0000
Message-ID: <20180915013223.179909-53-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:xij3Jbn6WQ93Z4Tj4eMIifOTZeuhNFRBTDcmzybHKI/RJ2Kh9h9jhciIzf8QNcagVFy7LiT+ubarD8pIP7usvY18g6eHZgnCevdybylY5eDwa1X2EOh+/rLcRh+Irkblao8ZShHGPbPZz4+jIReyaRISCxe8Awhu5n0qLeFcmLSGKly96q2aNdJg0xunUPCMvufcHW6mXy6kzW6oRq7l1M656kp66g/JZXLcfWpqUddhGA56rdqzwFa2uijlVcR7tpPXXaCH6VaY9rnj/PHrQPwbyrFknGNFJNBrwnpmZFbEsenGCIc6oE4/eEmOVx5z8zWDXIkGy3OmNZvrrsnm0j9nL3hMIUuV+JPTYvK1g43UYZvLkY8gVzy37xEbHG/qtU2WBjvuIGwzUzayVl3aWk7aJBDKqsfV5ytr9heURFgoPp6ANFbvzoILESLwBGlresGUhXtlMmdYcXyXKWGlXQ==;5:dOZMef9aBzkg9oV6GeyLntSg69CE2LJLEJyev5pbPs7AMk3TnL32TOHAEvyrK4pwZNNSXrRgbTIaE6uGnSS0duVhlr4WV1gGZ16FoB6Js83tbRX2Cl2SuGYZ3Zz7SGnY8+IpBJAmKARz8tgbWbIiUVOJnri0Fqn/06BZ+mqcX4Q=;7:gEktwYbJx2Zbb/kfHMb/miqzx1ngZ7skprZoaA7mWP70SNsqjUejcvRU6o0JOUTNN+xoPNwSLvl/3X3aQvBTl7iBU4fbIovrnmNGUi4rk5ZEq97NmLw2uPl5JF4OXCXtPGl0tNJTMVD0Dy772sW+vX+aah78Ivpzoo8YjBol79zhScKI4PRCmJmP5ucUSQG+O1Rh+yDV9TS3pGVzoxfaKMNY9cJFZyJ3vRkI2bHH2NEjJXP1OXD1DCihT/hIJAz0
x-ms-office365-filtering-correlation-id: a2ffb7d5-1c99-4b73-0ece-08d61aab3c05
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB0855B75BF79DEF402EFA7516FB180@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(67672495146484)(146099531331640)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231353)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39860400002)(366004)(396003)(189003)(199004)(102836004)(6506007)(305945005)(7736002)(10090500001)(86612001)(86362001)(106356001)(97736004)(107886003)(186003)(6666003)(26005)(6346003)(14444005)(5660300001)(256004)(5250100002)(6486002)(105586002)(6512007)(2501003)(2900100001)(22452003)(6436002)(99286004)(316002)(8676002)(76176011)(53936002)(54906003)(36756003)(110136005)(10290500003)(72206003)(478600001)(68736007)(66066001)(81166006)(81156014)(8936002)(486006)(1076002)(3846002)(446003)(14454004)(6116002)(476003)(11346002)(2616005)(217873002)(4326008)(2906002)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: DuLWlj3ZxGUon4qrTH5HfhL2Fi7bC36u1xhB6aGsN4jEYhxejEVK+0fdT9EuzK4Uv05nRzfITHP4vqT/XEmgKEWD3AODcUcMxlKces8dybLil7Vs9yMIUlhkMPRezSvKfCd7H+aoMlK5XaANALy3cVWGoLGzdZQaF5xDpgRDYCGSHJP4udo3w7gVzDWRsufI5Ay0blXyo5dcVPfn4i+H60SmprqlL6wtCJxUR5yFybDY+keVyARIXBebGhtMSpJ38gPS60Pm9k/ESVX7WVKyQgmVKD/MtGqdGI/ZbTNUF9LURMMX24/QiJkSi0nefUXMAyn0h5O4JAfDpLufLHxjJ8xleG2XcouvqiRdbAVp15Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ffb7d5-1c99-4b73-0ece-08d61aab3c05
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:33:02.4926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
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
index 1d27e2a152e0..6aa2bc4e9652 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -669,9 +669,13 @@ void blk_cleanup_queue(struct request_queue *q)
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

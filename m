Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3B6ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E912147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ZOZO8/tQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89E912147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbeIQI0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:26:40 -0400
Received: from mail-eopbgr710095.outbound.protection.outlook.com ([40.107.71.95]:52685
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728957AbeIQI0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kW3AQtT7IVYxwM/juRMezb1fxRBE3RNe/6kmioWwsA=;
 b=ZOZO8/tQTS9+oMpDRmcY+O7EzAdHHzsbCPrW8QqjAYSaqj6x563XpalNUgl7SSMU9WaIwPeVEagrQaB6LrlVgVtRhSE22RHWMXFZbkibm0Ys9cRFatxP9QHLQfCQgIXHKlZ8zDNRWpDi5J+DtPliyC83Z735SmeszdXgKwWF+Po=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:01:12 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:12 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bart Van Assche <bart.vanassche@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 049/136] scsi: klist: Make it safe to use klists
 in atomic context
Thread-Topic: [PATCH AUTOSEL 4.18 049/136] scsi: klist: Make it safe to use
 klists in atomic context
Thread-Index: AQHUTjKfbeyV06AseUCwvVP+x3OvbA==
Date:   Mon, 17 Sep 2018 03:00:43 +0000
Message-ID: <20180917030006.245495-49-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:vxat6uY7sahDLwSk8w9veEWMFhv0U93TgfCZCMAL4gyHUVtwbq9ugPt73Ju6FRJZNv/k4OISxk2rV6dk+beecoc2HQul+rjQQBbyo12bvE0j1GgVlwFcjDfn6rNvosSJ2r1kq7hs5vQOH7GIO8IgHQeyxVycY4Bmt+nkrjEcMUy8CK2c1pNXSbNaAjpFCLM4CwTqCvjAW9QfM7nKeSAm9eiDNAoeYWZtpGo+rCzyBZDs6qoF8m6nKNC9nUl2ifozo/4xIhMZSUa25ef4l/7St4mSE+xKyJxfSJcEQTbr3sBl74g+gXX4UmgKqJF87XjDd8vygVSy3QFnBSI2TWt2Ew3Jc3QgqyF6I6cZqryuiyiqZLVt09L5XhqCS0uPTftlZhN8tw2MlsNKDc/Jp0mNtroM8jU/8DNi4RwJ5raHQGsNOMej/YiRgOtrkMLoAjUGhcfCsvWg9E9GI02fjJmegA==;5:IdZEGY7DzlCxoOb4PySTjVRq/ZPz2VE+mCIDQRyG0AUXNB1p9q4wYliUD0yYmajn3f56dQSY9fK8UlXI0t1SN8G/7MziJHlOjoEjNFK/qDQHILZURKJU7d2AkAEqiG+531GzDCvbDz962xj/bHyrlfLR9DTKH5/kTNA2iQDVV6s=;7:Od+adG679f9QSu70K9sN1h5q0IDDidrkbDzJGn5UuRHEFgRlGEcN1r2UAwO64uEVGd2hkG0y950wMoQx9RMgMafIBpN709JkE3WgzQ03hEYduAsPsmy0XXalXvGz4wSUEaJ/uKReZDBbOzV4INUoL3NpGc2cLi0BAfv2587IEx8bOG2jhSSCtx+nElXuk9e9oz/bE1bayLt0uTn7ZsqfMnqUYgvJrMYo8ad34w10v5lEO8KfjHf8cVNFo9KizirW
x-ms-office365-filtering-correlation-id: 35f716d8-ecba-48bc-1fb6-08d61c49d33f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB01677451E7A9968DF4942DB6FB1E0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20558992708506)(146099531331640)(104084551191319)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(346002)(136003)(39860400002)(199004)(189003)(51234002)(6116002)(1076002)(86612001)(4326008)(97736004)(53936002)(2900100001)(7736002)(107886003)(106356001)(10290500003)(81166006)(105586002)(68736007)(3846002)(99286004)(305945005)(36756003)(8936002)(2906002)(217873002)(54906003)(86362001)(110136005)(25786009)(316002)(5660300001)(102836004)(66066001)(76176011)(478600001)(446003)(11346002)(2616005)(8676002)(486006)(476003)(6346003)(186003)(26005)(6666003)(6506007)(6512007)(5250100002)(6436002)(10090500001)(6486002)(72206003)(14454004)(256004)(2501003)(22452003)(81156014)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: gVLpaQvMTnf88mkqY/KD9YbALniDTdGEvVOzcOnt4Lt+zuB+Iowg4NTv47ZnPfJUmNpDT7MVtlOYQPpVn86xlJVwuqdvVFxnhph75u/ruhdYKB06I8k2xLjlAJpHJweh0elLlvR70l4aT2gt7oFyGErremSaQy2rNT2kgXVbyxTKPzz8Ka9plf1EprkF2RsT05g2HgZ29iNk+DNliBn08IMyrhf4hwL90dbY47eXd3Uf6D1bkX8nznHmnGfTQxPODSjW/OOmFM7CuaNmWZ3tH9A1aGAXMtHP6LNz39N72AMMVkHfkCW3lvSyP+YXU8t4AbuGa8yeh/gx1RPOdDfU489cTp3obFwiCT5jBafr0lE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f716d8-ecba-48bc-1fb6-08d61c49d33f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:43.1358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bart.vanassche@wdc.com>

[ Upstream commit 624fa7790f80575a4ec28fbdb2034097dc18d051 ]

In the scsi_transport_srp implementation it cannot be avoided to
iterate over a klist from atomic context when using the legacy block
layer instead of blk-mq. Hence this patch that makes it safe to use
klists in atomic context. This patch avoids that lockdep reports the
following:

WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&(&k->k_lock)->rlock);
                               local_irq_disable();
                               lock(&(&q->__queue_lock)->rlock);
                               lock(&(&k->k_lock)->rlock);
  <Interrupt>
    lock(&(&q->__queue_lock)->rlock);

stack backtrace:
Workqueue: kblockd blk_timeout_work
Call Trace:
 dump_stack+0xa4/0xf5
 check_usage+0x6e6/0x700
 __lock_acquire+0x185d/0x1b50
 lock_acquire+0xd2/0x260
 _raw_spin_lock+0x32/0x50
 klist_next+0x47/0x190
 device_for_each_child+0x8e/0x100
 srp_timed_out+0xaf/0x1d0 [scsi_transport_srp]
 scsi_times_out+0xd4/0x410 [scsi_mod]
 blk_rq_timed_out+0x36/0x70
 blk_timeout_work+0x1b5/0x220
 process_one_work+0x4fe/0xad0
 worker_thread+0x63/0x5a0
 kthread+0x1c1/0x1e0
 ret_from_fork+0x24/0x30

See also commit c9ddf73476ff ("scsi: scsi_transport_srp: Fix shost to
rport translation").

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: James Bottomley <jejb@linux.vnet.ibm.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 lib/klist.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/klist.c b/lib/klist.c
index 0507fa5d84c5..f6b547812fe3 100644
--- a/lib/klist.c
+++ b/lib/klist.c
@@ -336,8 +336,9 @@ struct klist_node *klist_prev(struct klist_iter *i)
 	void (*put)(struct klist_node *) =3D i->i_klist->put;
 	struct klist_node *last =3D i->i_cur;
 	struct klist_node *prev;
+	unsigned long flags;
=20
-	spin_lock(&i->i_klist->k_lock);
+	spin_lock_irqsave(&i->i_klist->k_lock, flags);
=20
 	if (last) {
 		prev =3D to_klist_node(last->n_node.prev);
@@ -356,7 +357,7 @@ struct klist_node *klist_prev(struct klist_iter *i)
 		prev =3D to_klist_node(prev->n_node.prev);
 	}
=20
-	spin_unlock(&i->i_klist->k_lock);
+	spin_unlock_irqrestore(&i->i_klist->k_lock, flags);
=20
 	if (put && last)
 		put(last);
@@ -377,8 +378,9 @@ struct klist_node *klist_next(struct klist_iter *i)
 	void (*put)(struct klist_node *) =3D i->i_klist->put;
 	struct klist_node *last =3D i->i_cur;
 	struct klist_node *next;
+	unsigned long flags;
=20
-	spin_lock(&i->i_klist->k_lock);
+	spin_lock_irqsave(&i->i_klist->k_lock, flags);
=20
 	if (last) {
 		next =3D to_klist_node(last->n_node.next);
@@ -397,7 +399,7 @@ struct klist_node *klist_next(struct klist_iter *i)
 		next =3D to_klist_node(next->n_node.next);
 	}
=20
-	spin_unlock(&i->i_klist->k_lock);
+	spin_unlock_irqrestore(&i->i_klist->k_lock, flags);
=20
 	if (put && last)
 		put(last);
--=20
2.17.1

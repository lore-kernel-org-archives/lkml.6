Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42553ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E449F214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dWbVrb5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E449F214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730850AbeIQIbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:31:19 -0400
Received: from mail-by2nam01on0134.outbound.protection.outlook.com ([104.47.34.134]:47018
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730105AbeIQIbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kW3AQtT7IVYxwM/juRMezb1fxRBE3RNe/6kmioWwsA=;
 b=dWbVrb5NkWkJ/YuNgZEIreMIEh/yz0/tixIxOFq62OalalWp9z9ok7o/MoKlemblKLYZffxXqjguW7ff9/oPus3oFmXVp2k69eIqX0JMqYjAreS/u1N3dSIZZcAZzWhdccn50rLlifjaySV4kMenwHrUPzlC4gQehugvG5a+D4I=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.6; Mon, 17 Sep 2018 03:05:44 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:44 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bart Van Assche <bart.vanassche@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 25/57] scsi: klist: Make it safe to use klists in
 atomic context
Thread-Topic: [PATCH AUTOSEL 4.9 25/57] scsi: klist: Make it safe to use
 klists in atomic context
Thread-Index: AQHUTjMUzmr4z8shJ0qiLO8mEN7TMQ==
Date:   Mon, 17 Sep 2018 03:03:58 +0000
Message-ID: <20180917030340.378-25-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:W/YQA+nGwrAXpWp5f0zjdKkZmdkxVAt82fIr26MKPgr1UEBzOXH70VaAHOLzgKMdZtU+nStWLliYpJa5TtV/UP+B+1N0oO9tlgWL3DS8vbj0rni5aBu5QEYoZ/lh7iasCJcYmOpuvrH7ybzIbzkKdmTCwpsXooK8dRZEywYrmYuTjlU6MvQqlgB4pWLLf8ZvyOfERAnCd4bwt2Ih8thXQpfPYsYrhnxlp8SbLp5Xcsvony5q6vUU9TQAcgxvym1I7OV8DswRHYULtpHrZMldSFS30WfbRqshp6KXZLlBD9UjYiCS6NTt7OmfwMVrh7oyITH1RD+vOIR47KvOwkZ922dTMSA1w4EC3s2fbTTUEy+5S2Y9jH/VK/4vn6iTRVVeG1wQj0ygCEZPj1U/tDC6VViQaMm5HtOxeDDExMPPYRw22nE1RQm1z6mABeQ/zVm3zbCGJIgrD2SeIcF/UVEmhw==;5:kmGNzVEz0jeObkzuMzP/oyxMYgGe/7b7kV5aOz2UPUeoJkzQ20Fji2CG88tW082FASL/aN2AD+Sn6RU9Eog4o4/BfJnMP5YERZ9iEWQJ84gE26a5LZqF+3oA8gi4roNMQbjC4cMwCkqip7q3wVvO1bvyTEX7cSWNfJAEG/XPok0=;7:9TBklowl/KzCajw+RJmY9sUZfHL4kX9u720sIsBlV7s9G4OeaHLwvHCE75XXHUCVKyc1EkcUJCo7onzJY6VsYB9Gy/ivUt3GsX4A8s5DR6/WEP8aFAT+Uex7Cw3pj7hJdjYoHsqbSrPXXGvYUNDiZaY9iC5jKcAVvSAHgai4IcDJz6d0PxFgJisvDL/wL0R1dmFD/R0tx0kVkzrj/bobfG7Qcyf5Ftta9zLmhENkPx5FT91ymwu1mzkl0d4kv7cP
x-ms-office365-filtering-correlation-id: aaf3754b-2e15-48b8-192c-08d61c4a7588
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB0757F44C6EC4A19EF8F4EAF7FB1E0@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20558992708506)(146099531331640)(104084551191319)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(346002)(376002)(396003)(51234002)(189003)(199004)(8936002)(68736007)(476003)(10290500003)(446003)(53936002)(11346002)(6512007)(486006)(86612001)(6436002)(1076002)(256004)(6486002)(2616005)(14444005)(81156014)(81166006)(7736002)(8676002)(217873002)(478600001)(305945005)(3846002)(6116002)(86362001)(4326008)(106356001)(66066001)(186003)(36756003)(99286004)(76176011)(102836004)(107886003)(26005)(2906002)(5660300001)(110136005)(54906003)(10090500001)(22452003)(72206003)(2900100001)(316002)(14454004)(97736004)(105586002)(6506007)(25786009)(6346003)(6666003)(5250100002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: OPpNuMJzI/5YjSDTUXdhPxu0n7rTO851MwwJkW1ZR9Z54vggEtuYhrfZDf22kVtNwsLoe3Hvn0qaSUOGmtmHcflXOTrA1SiV1VhVO6xO/geDdZNa4PJCSdAPEr5WChA3dViWUG2jtQ+Is+h+FffmOhRa7TNufem2M+SZawKQ02n9P1j82SLb7cAV1n3HuJzq17N8GOuPPIJXS0WkJYwvYqZhkOvE7e47CtaRwEmu0tMdGb2WjtuqQwtfpCFZBPAxeN2IGhy9drLfC6P9OxAqunhWeUiIrlWA0nGPZxy8Igu0pqZEZ10dR5GF+sL0Wv62ZstK3p1UpTbAmXifGxJybTfFjp2yYAtURDM7e35NZHg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf3754b-2e15-48b8-192c-08d61c4a7588
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:58.9616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
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

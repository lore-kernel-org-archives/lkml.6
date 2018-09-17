Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AF3ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95F4214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="M5LFWZWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B95F4214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731390AbeIQIcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:32:45 -0400
Received: from mail-sn1nam02on0110.outbound.protection.outlook.com ([104.47.36.110]:23375
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731353AbeIQIco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kW3AQtT7IVYxwM/juRMezb1fxRBE3RNe/6kmioWwsA=;
 b=M5LFWZWhuVGgaYE5uZmnkdLtpRgNeNwfVcUAudxqj1zZhi/Zu5dXCWC4PSkSX2ruvmWZUdKkiicCY5fZE6r2Jv3JJovn8UFXkvamCddOSVyqdESW1ZQbQKeICICZXcwDOqJNprAN6UKEz7PCin71fOOEQZ7Mw/LestCvd2dKuxw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0742.namprd21.prod.outlook.com (10.173.189.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Mon, 17 Sep 2018 03:07:08 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:07 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bart Van Assche <bart.vanassche@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 18/43] scsi: klist: Make it safe to use klists in
 atomic context
Thread-Topic: [PATCH AUTOSEL 4.4 18/43] scsi: klist: Make it safe to use
 klists in atomic context
Thread-Index: AQHUTjM4hpANISbhZkewbje/D+8sng==
Date:   Mon, 17 Sep 2018 03:05:00 +0000
Message-ID: <20180917030445.484-18-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0742;6:Vgy904W3RgthXpwYrJ7Bhnzb+tczsJoMqkJxLznrApqcyDxXuuo5XLqzwDpgjecZJ55m28PZEb+0F8Yns4oThxno+Ossy4eyJiZgOmtzMEp+Jfda8RoeHzoNxNK/QdMBAIrT0z1bPNltzxT5WKC1kbLVzO868H9eZ/aJOO2S2WSzAHreForznB8dPkF2XHO7xrHAa/u9TC2Wf2yj7cyqLKi7LlJWTtCzBX9evmW3iIHX4PL0APDsDpvR7JxdiJ3i2TBPyP8fJQUXqcNhDeq5wVILOEkRC/sUpavjlXJ6dgnDffHYE6d7KnT2sxlq/2x5i40kaFfalePLSiI0v9X/1NI+5IF8KmgdSyrWKoBc8xANc1T6wsQiCQ/ZoXbr9/0WSUIMqZCY5V93Q/BFvXXq8pfztx3K2jnCnmmTTZPWaWb5ureumvY9AWOuh3f3a/Z/KcANiU/lDmWmGA79A+xxaA==;5:n6Hkf78S3xdew7t47RcSw3eF4VYeXOv/5unz9tnJAqeOODGwLva3lf9UOJSSn9jCLXiX+nt8+zeoJO5FsUEmRYT3m1bMGoSsDx644Vf2jbVPr94+VstZw9kg+AsfBgAEQEjNAj5fgRM+yP2LK70KLjCgca66WKl8RSUTuqFt1II=;7:OSs+dwIK7TuG+feV7bDsWjhUlryPdkqAULT4pNJNJOP76eFicovKkTc2wR+GbRuYErFcIDC4xdT7Wz7154jAPQaYKRYDzHSi8sM6ifRYxCk8wfwxlzHMRK8A+Asr+csPwMZcoGeL5we0/2ogGVKiWP/72Y60vHC27mEK1PKxun28SZSqd4uwM8DU5+QtdxpdTqqgE65aOHjPIrImQPAqywzNuBJPFmEDF7fXuINt0EhBpeKbB8wCYmWFU1Mx/GFa
x-ms-office365-filtering-correlation-id: 8afcae77-4c33-4084-5f38-08d61c4aa73c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0742;
x-ms-traffictypediagnostic: CY4PR21MB0742:
x-microsoft-antispam-prvs: <CY4PR21MB0742334642A671605CACD37DFB1E0@CY4PR21MB0742.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20558992708506)(146099531331640)(104084551191319)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0742;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0742;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(366004)(396003)(376002)(199004)(189003)(51234002)(6486002)(6436002)(6512007)(53936002)(4326008)(3846002)(217873002)(25786009)(2616005)(1076002)(14444005)(6506007)(186003)(6346003)(11346002)(446003)(26005)(2900100001)(6116002)(486006)(102836004)(256004)(107886003)(476003)(86612001)(86362001)(2501003)(14454004)(97736004)(66066001)(76176011)(6666003)(316002)(54906003)(110136005)(99286004)(68736007)(10090500001)(22452003)(81156014)(2906002)(36756003)(8676002)(8936002)(81166006)(7736002)(305945005)(105586002)(5660300001)(106356001)(10290500003)(478600001)(72206003)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0742;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: vdHF9JOrTUUpSeyDm3YKyniIHI6anM9nAgjf1XlMwPk0M+ag6BlKTcylJhpu1gQjRQGI3F7qVX4PFPhI3rXIYh0lf8YKFBdLv/BdKbvxiK3IDKl1UOC6rTRhLD/a9AU3FgeNwUN/gZeE/+VKVwMzq9k8zxTZpuXsOb6aJ9oI/pH5qoYEPVJ1CDtxkSCD6ZrF2/+s4EV4lhqtlfbiHmUea/XSjZM3dQaRi9aobsCx46uWk6587meo+1hz25VOK5PegPU0NUOoYrjTdfcc6uhs5RpVjDNhlTF0uWaypZL5evCwI3fqeoRohNa5ctTnUrmPjIG78kCBpNFqQ+FWVD7YK7n8t0W43V48hpXgTzGebac=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8afcae77-4c33-4084-5f38-08d61c4aa73c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:00.1017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0742
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

Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0337CC64E93
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2687206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="MAdpHnnr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2687206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbeI2DaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 23:30:10 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:53756 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727264AbeI2DaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 23:30:09 -0400
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8SKuAAN031249;
        Fri, 28 Sep 2018 16:03:54 -0500
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp0119.outbound.protection.outlook.com [207.46.163.119])
        by mx0a-00010702.pphosted.com with ESMTP id 2mqyx8bbvy-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 28 Sep 2018 16:03:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHH/X+hd13ZWoBNnUaDRcCKEXbshgawyGmSLncAxCIs=;
 b=MAdpHnnr7U8kMX312gVr1Z737Sx0LizMFyLu6FDEcXcsfNieJuF2T5ji1Hrfo9DVlwYS041mBndsQzMUKkf+AEJ55cwngCl1rP/YjUwwuPlYfL9kERy+cfmDaOhR7YzzVtk/SLWere20zBfxw1TaZc11kzluGzlkesgFryUoXRI=
Received: from BN6PR04MB0963.namprd04.prod.outlook.com (10.174.233.163) by
 BN6PR04MB1237.namprd04.prod.outlook.com (10.174.94.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.25; Fri, 28 Sep 2018 21:03:52 +0000
Received: from BN6PR04MB0963.namprd04.prod.outlook.com
 ([fe80::351f:554:dbf4:f988]) by BN6PR04MB0963.namprd04.prod.outlook.com
 ([fe80::351f:554:dbf4:f988%2]) with mapi id 15.20.1185.022; Fri, 28 Sep 2018
 21:03:52 +0000
From:   Julia Cartwright <julia@ni.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Tim Sander <tim@krieglstein.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 1/2] kthread: convert worker lock to raw spinlock
Thread-Topic: [PATCH 1/2] kthread: convert worker lock to raw spinlock
Thread-Index: AQHUV27CTZOVnLi4AEOYaQh4rBRaZA==
Date:   Fri, 28 Sep 2018 21:03:51 +0000
Message-ID: <da33d7d7aa32d08f9cbf5016fb04426f90645cb0.1538089180.git.julia@ni.com>
References: <cover.1538089179.git.julia@ni.com>
In-Reply-To: <cover.1538089179.git.julia@ni.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR21CA0019.namprd21.prod.outlook.com
 (2603:10b6:404:8e::29) To BN6PR04MB0963.namprd04.prod.outlook.com
 (2603:10b6:405:43::35)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [130.164.62.116]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR04MB1237;6:mrH4QLOXLiRrjfxGlhqXnIuuoIVdzo7Ga9GCr5HV+HsU43x4+VspgQRKbYsLcQlw48CEQDBi0wwogzpGTN5Pj7JLzNAd6S3NrScF3kOtnWyYASQDZI0WRXTPHrDiNbYcjhEOjfUKWF6ndt6ZLdy6UVn+787e631mBgnXhHDmb97Xywc0W9EcfCqcjgDZjpKeO/a8M5QppPGuIqVRLhQnshbOweUT29NH4PNu/69+jUDTgTK2kBNIFu2Ulz5m+wlS+epjSOizzP2qrdUPh9ZT52K/iyYZ9kDz0sJuGzbwYFi6Xhm3790VdDWF8uK0PGgx5hRVWyY9aNFDoSz93L5kj4o0Se3hSG+r6OyCs/z/+jdD9/Q35rTqzu0LzwfmXeIxKcReMnD9apiYsXIglfn1Z3R5QRisvh4MozWvFtwtI3nQQNpPFQ5OUXYa5VgWqBWfFrF3NC9xyqEGIvY4DXbELA==;5:Ho94fZ5Anjh0hyNhL83JbbvDye5zQW4pOb90YzBR1bW5vfdQmIQApgGDXRIAcflwY8qPnujRRyJkelkYQa92qANsJ5yFAFCTMymVFCaZLRxgHyjmK2KcafE8ZgXKEfdTYKWU6qQpB1b4VI71kMQgQp5nNCK1oWsytexRznhrF9I=;7:FiVsbL5Shi+zXBbdM53b54mWFjX27fW/0dR2ZX/G8u/4lNYj+uuhklrVjr9+2PDDb1fOwG/epgl0SwtOKLvfx41hVmZifbAYlN8i0+sBtSFZ5IlnryoizVSjr14JqffLb5TsKIPJM4WzV1rgeaX5+gC5cp5MHYdlmPTdSgYfGN9dtUOxWa/V/RHKuNjPbstdr6+RPRCs8X1JyKSok0Z7nYP7apUzGDUGVZ5vcvJY1vHVUU2PPK14O94H+DkZoZdQ
x-ms-office365-filtering-correlation-id: 17b809c0-e50a-4b08-ad44-08d62585e485
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR04MB1237;
x-ms-traffictypediagnostic: BN6PR04MB1237:
x-microsoft-antispam-prvs: <BN6PR04MB1237CD68AD8E009EECB1B920F4EC0@BN6PR04MB1237.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(145744241990776);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(149066)(150057)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:BN6PR04MB1237;BCL:0;PCL:0;RULEID:;SRVR:BN6PR04MB1237;
x-forefront-prvs: 0809C12563
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(396003)(376002)(346002)(55674003)(189003)(199004)(51234002)(186003)(102836004)(26005)(486006)(66066001)(476003)(11346002)(2616005)(105586002)(118296001)(256004)(14444005)(106356001)(81166006)(71190400001)(71200400001)(446003)(76176011)(5660300001)(99286004)(68736007)(6486002)(8936002)(81156014)(8676002)(6436002)(316002)(52116002)(305945005)(7736002)(54906003)(25786009)(110136005)(4326008)(5250100002)(97736004)(2900100001)(14454004)(6116002)(386003)(2906002)(3846002)(53936002)(6506007)(478600001)(6512007)(36756003)(34290500001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR04MB1237;H:BN6PR04MB0963.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NpcnJrGjPxXboq1yF3imhihrG/4M/1Wxi9V6PGTgODSTUHsdLDqNABkYHv3Z9ixDnqiQ9vuQ+wfbwbcab3JdqzGj15Knb8vfYa3YosIUn2sUbzRXYOHA+tLlvunpmAzKBwLaMX+puHSPbjFwDqR2o3cIfHf7yi+4WXFJ84Ni0dSYfefQj9ljx4cRHy5ZPsIWXQ1vmzpNbye0UQrndNEHTVzCYK09An3UGGXgQMbNQmqi8R5Z5E87tXagqGaIuw6Wbh9CtnNGiIBy60X75poPtYpw09IUHtSg6EGX6CQ1WwKAMAbwaFxPESR2IGL8xy6HHaaOmGij+KhP92vgEJMxyD5HTkZQ5cAbVFhw1ZEgR80=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b809c0-e50a-4b08-ad44-08d62585e485
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2018 21:03:51.9921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB1237
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-28_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809280206
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to enable the queuing of kthread work items from hardirq
context even when PREEMPT_RT_FULL is enabled, convert the worker
spin_lock to a raw_spin_lock.

This is only acceptable to do because the work performed under the lock
is well-bounded and minimal.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Guenter Roeck <linux@roeck-us.net>
Reported-and-tested-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Reported-by: Tim Sander <tim@krieglstein.org>
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 include/linux/kthread.h |  2 +-
 kernel/kthread.c        | 42 ++++++++++++++++++++---------------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index c1961761311d..ad292898f7f2 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -85,7 +85,7 @@ enum {
=20
 struct kthread_worker {
 	unsigned int		flags;
-	spinlock_t		lock;
+	raw_spinlock_t		lock;
 	struct list_head	work_list;
 	struct list_head	delayed_work_list;
 	struct task_struct	*task;
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 486dedbd9af5..c1d9ee6671c6 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -597,7 +597,7 @@ void __kthread_init_worker(struct kthread_worker *worke=
r,
 				struct lock_class_key *key)
 {
 	memset(worker, 0, sizeof(struct kthread_worker));
-	spin_lock_init(&worker->lock);
+	raw_spin_lock_init(&worker->lock);
 	lockdep_set_class_and_name(&worker->lock, key, name);
 	INIT_LIST_HEAD(&worker->work_list);
 	INIT_LIST_HEAD(&worker->delayed_work_list);
@@ -639,21 +639,21 @@ int kthread_worker_fn(void *worker_ptr)
=20
 	if (kthread_should_stop()) {
 		__set_current_state(TASK_RUNNING);
-		spin_lock_irq(&worker->lock);
+		raw_spin_lock_irq(&worker->lock);
 		worker->task =3D NULL;
-		spin_unlock_irq(&worker->lock);
+		raw_spin_unlock_irq(&worker->lock);
 		return 0;
 	}
=20
 	work =3D NULL;
-	spin_lock_irq(&worker->lock);
+	raw_spin_lock_irq(&worker->lock);
 	if (!list_empty(&worker->work_list)) {
 		work =3D list_first_entry(&worker->work_list,
 					struct kthread_work, node);
 		list_del_init(&work->node);
 	}
 	worker->current_work =3D work;
-	spin_unlock_irq(&worker->lock);
+	raw_spin_unlock_irq(&worker->lock);
=20
 	if (work) {
 		__set_current_state(TASK_RUNNING);
@@ -810,12 +810,12 @@ bool kthread_queue_work(struct kthread_worker *worker=
,
 	bool ret =3D false;
 	unsigned long flags;
=20
-	spin_lock_irqsave(&worker->lock, flags);
+	raw_spin_lock_irqsave(&worker->lock, flags);
 	if (!queuing_blocked(worker, work)) {
 		kthread_insert_work(worker, work, &worker->work_list);
 		ret =3D true;
 	}
-	spin_unlock_irqrestore(&worker->lock, flags);
+	raw_spin_unlock_irqrestore(&worker->lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kthread_queue_work);
@@ -841,7 +841,7 @@ void kthread_delayed_work_timer_fn(struct timer_list *t=
)
 	if (WARN_ON_ONCE(!worker))
 		return;
=20
-	spin_lock(&worker->lock);
+	raw_spin_lock(&worker->lock);
 	/* Work must not be used with >1 worker, see kthread_queue_work(). */
 	WARN_ON_ONCE(work->worker !=3D worker);
=20
@@ -850,7 +850,7 @@ void kthread_delayed_work_timer_fn(struct timer_list *t=
)
 	list_del_init(&work->node);
 	kthread_insert_work(worker, work, &worker->work_list);
=20
-	spin_unlock(&worker->lock);
+	raw_spin_unlock(&worker->lock);
 }
 EXPORT_SYMBOL(kthread_delayed_work_timer_fn);
=20
@@ -906,14 +906,14 @@ bool kthread_queue_delayed_work(struct kthread_worker=
 *worker,
 	unsigned long flags;
 	bool ret =3D false;
=20
-	spin_lock_irqsave(&worker->lock, flags);
+	raw_spin_lock_irqsave(&worker->lock, flags);
=20
 	if (!queuing_blocked(worker, work)) {
 		__kthread_queue_delayed_work(worker, dwork, delay);
 		ret =3D true;
 	}
=20
-	spin_unlock_irqrestore(&worker->lock, flags);
+	raw_spin_unlock_irqrestore(&worker->lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kthread_queue_delayed_work);
@@ -949,7 +949,7 @@ void kthread_flush_work(struct kthread_work *work)
 	if (!worker)
 		return;
=20
-	spin_lock_irq(&worker->lock);
+	raw_spin_lock_irq(&worker->lock);
 	/* Work must not be used with >1 worker, see kthread_queue_work(). */
 	WARN_ON_ONCE(work->worker !=3D worker);
=20
@@ -961,7 +961,7 @@ void kthread_flush_work(struct kthread_work *work)
 	else
 		noop =3D true;
=20
-	spin_unlock_irq(&worker->lock);
+	raw_spin_unlock_irq(&worker->lock);
=20
 	if (!noop)
 		wait_for_completion(&fwork.done);
@@ -994,9 +994,9 @@ static bool __kthread_cancel_work(struct kthread_work *=
work, bool is_dwork,
 		 * any queuing is blocked by setting the canceling counter.
 		 */
 		work->canceling++;
-		spin_unlock_irqrestore(&worker->lock, *flags);
+		raw_spin_unlock_irqrestore(&worker->lock, *flags);
 		del_timer_sync(&dwork->timer);
-		spin_lock_irqsave(&worker->lock, *flags);
+		raw_spin_lock_irqsave(&worker->lock, *flags);
 		work->canceling--;
 	}
=20
@@ -1043,7 +1043,7 @@ bool kthread_mod_delayed_work(struct kthread_worker *=
worker,
 	unsigned long flags;
 	int ret =3D false;
=20
-	spin_lock_irqsave(&worker->lock, flags);
+	raw_spin_lock_irqsave(&worker->lock, flags);
=20
 	/* Do not bother with canceling when never queued. */
 	if (!work->worker)
@@ -1060,7 +1060,7 @@ bool kthread_mod_delayed_work(struct kthread_worker *=
worker,
 fast_queue:
 	__kthread_queue_delayed_work(worker, dwork, delay);
 out:
-	spin_unlock_irqrestore(&worker->lock, flags);
+	raw_spin_unlock_irqrestore(&worker->lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kthread_mod_delayed_work);
@@ -1074,7 +1074,7 @@ static bool __kthread_cancel_work_sync(struct kthread=
_work *work, bool is_dwork)
 	if (!worker)
 		goto out;
=20
-	spin_lock_irqsave(&worker->lock, flags);
+	raw_spin_lock_irqsave(&worker->lock, flags);
 	/* Work must not be used with >1 worker, see kthread_queue_work(). */
 	WARN_ON_ONCE(work->worker !=3D worker);
=20
@@ -1088,13 +1088,13 @@ static bool __kthread_cancel_work_sync(struct kthre=
ad_work *work, bool is_dwork)
 	 * In the meantime, block any queuing by setting the canceling counter.
 	 */
 	work->canceling++;
-	spin_unlock_irqrestore(&worker->lock, flags);
+	raw_spin_unlock_irqrestore(&worker->lock, flags);
 	kthread_flush_work(work);
-	spin_lock_irqsave(&worker->lock, flags);
+	raw_spin_lock_irqsave(&worker->lock, flags);
 	work->canceling--;
=20
 out_fast:
-	spin_unlock_irqrestore(&worker->lock, flags);
+	raw_spin_unlock_irqrestore(&worker->lock, flags);
 out:
 	return ret;
 }
--=20
2.18.0


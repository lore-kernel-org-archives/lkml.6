Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA68ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F31214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JjGw0JgS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F31214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbeIQI0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:26:25 -0400
Received: from mail-bl2nam02on0125.outbound.protection.outlook.com ([104.47.38.125]:3776
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728803AbeIQI0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPC+/gexh7WoRQqFAa2ds7XdQhPW29FMCI2YkFUWLhU=;
 b=JjGw0JgSy3vLAohmmMAbueVOW8Y0L+250xGcY/gmaUkX1pvu+EM5XN6/p8XMVwgSA6ZWqSy81m6009se6tnVIKtQ+IIW4tC5tsMxjgujfbdV0d4504+6Nlw0W8+zSgz8mWPuIGiXh1i9MN3E2rsZCH+NaQ/S/CADXVfG/3VpkLo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.13; Mon, 17 Sep 2018 03:01:04 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:04 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 038/136] vhost_net: Avoid tx vring kicks during
 busyloop
Thread-Topic: [PATCH AUTOSEL 4.18 038/136] vhost_net: Avoid tx vring kicks
 during busyloop
Thread-Index: AQHUTjKbJtKGuIS0cUO7JtvxaMHDoQ==
Date:   Mon, 17 Sep 2018 03:00:35 +0000
Message-ID: <20180917030006.245495-38-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:iPH9X1M6witnbzUZvMDtNrwI0NlC6qzzdpAPsEi7IP5mRMyF+Uo1jdesoscGbiskNhURGRUX24+QF94bIGyqPOuJ2b4EEW0K7zBQbAgu5xT7M08eqm/KlEZvt/S3NMPkwkzmTdRoTKt6LNRjqIbWoUphYiEjI5zIOqTfV+E4/oQVrw6yn03fNHDosqVm/meCIIfdt8bfwKqa/YBeUq9tVetpnVPy04l54SZOlh373+uW6GcMXa8Amqn3qHOFfskkpTtEMfiOrB1zcK+Gw/pHt25F3ft7DB+0YPTvoPo5MfIryFhBmZsaKW1xVz0yc0UsnSWIXiPXZxnce2cGbv7mH/1cPm2Mr4HX+TsWzpUjElZi/0CrpkGgJBac1hH/TH35+FirnI22cv0ZZ3Igwp68bynMI0nFvAMowhFdc58TF6WLV+RqGkP2zbxbh6xazV46BYSoHbY4hAzD7SoRZUY/Lg==;5:Adrv9AxXRFQggym/u1VAvhJKx3L9Uh3HwUoEoB4FtIhpTmMasGSX+3LByfpdjVZAkRclPca03lQchlpD+20mV8Osw+fJZBt+V7KgNryzOF0Eh6r+JeO2CLuTuoY2ufv8QtNEC4OIM7IhZ/BUkGtHKjDgofxDNLWa/EAHuF/2Wk0=;7:PkN0Q1BRLMRREEAS4RFo5/xEYsiQ7gc9RnFdqbI02YZahRfyHcTaMbYoohkNnjdpQeAdB85cju/PjktkJRYLfh7DMu5sWW6rrhiwPk7I9HWbfMW8Y/M+QO3czq2u9TJ2TKHQadh0r1Hvg5bbKMeUMnesXgKgOMy79FtnqdYxAAAvl0OWYbmomeFrqyJiAi9Ca3k/F6KRpDve1MK48Y601AGwqsljrmaaPco5+sD/BtAl4yWbQSDNFPHkOTwZeeKT
x-ms-office365-filtering-correlation-id: 6a68d5ae-b24d-4ca6-0a0a-08d61c49ceb6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB06292D117A8EC2CC08B95EECFB1E0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(376002)(396003)(136003)(189003)(199004)(76176011)(1076002)(86612001)(105586002)(22452003)(5250100002)(6666003)(7736002)(68736007)(4326008)(86362001)(2501003)(99286004)(6116002)(3846002)(36756003)(107886003)(72206003)(25786009)(106356001)(14454004)(6436002)(5660300001)(10290500003)(486006)(2616005)(446003)(6506007)(11346002)(97736004)(256004)(476003)(478600001)(305945005)(14444005)(217873002)(81166006)(102836004)(6512007)(8676002)(6486002)(2906002)(66066001)(2900100001)(186003)(26005)(54906003)(316002)(53936002)(8936002)(10090500001)(81156014)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: A2himOY8QsKRfaAt2rna8f37MRbHizMJdPiNgOvufSahA2VCuiSnlGx2NWafGdOcFoRZcv+Bvyz6wSsxj0tP9Gc41D+hm1Quf6BajFky+O8pdEMdjbgvdcFU3cVm8JDCf4bCtEBez9ehDGfhrNE2tX1+Dir784IDGGj6XHKqxVMiNMS+PRRQhT85un1tm3BafbNa3b59mpTfG5kdJ6yWLg84ztZ9yDSNKGfHof/02huJZ0fSLDj6miLR20cggBdCxwDkui2mPMyTdeboqxQdZ9UZQ2xEqDUOVITvcYoglobOs1zTIUfzmoNscsKftgicX5C85Heoeam1MhhYblzIdb6uqeXVp4uKp3UuLDzCGWk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a68d5ae-b24d-4ca6-0a0a-08d61c49ceb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:36.0109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>

[ Upstream commit 027b17603b030f1334ade079b7a3e986569c956b ]

Under heavy load vhost busypoll may run without suppressing
notification. For example tx zerocopy callback can push tx work while
handle_tx() is running, then busyloop exits due to vhost_has_work()
condition and enables notification but immediately reenters handle_tx()
because the pushed work was tx. In this case handle_tx() tries to
disable notification again, but when using event_idx it by design
cannot. Then busyloop will run without suppressing notification.
Another example is the case where handle_tx() tries to enable
notification but avail idx is advanced so disables it again. This case
also leads to the same situation with event_idx.

The problem is that once we enter this situation busyloop does not work
under heavy load for considerable amount of time, because notification
is likely to happen during busyloop and handle_tx() immediately enables
notification after notification happens. Specifically busyloop detects
notification by vhost_has_work() and then handle_tx() calls
vhost_enable_notify(). Because the detected work was the tx work, it
enters handle_tx(), and enters busyloop without suppression again.
This is likely to be repeated, so with event_idx we are almost not able
to suppress notification in this case.

To fix this, poll the work instead of enabling notification when
busypoll is interrupted by something. IMHO vhost_has_work() is kind of
interruption rather than a signal to completely cancel the busypoll, so
let's run busypoll after the necessary work is done.

Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/vhost/net.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 29756d88799b..6b86ca8772fb 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -396,13 +396,10 @@ static inline unsigned long busy_clock(void)
 	return local_clock() >> 10;
 }
=20
-static bool vhost_can_busy_poll(struct vhost_dev *dev,
-				unsigned long endtime)
+static bool vhost_can_busy_poll(unsigned long endtime)
 {
-	return likely(!need_resched()) &&
-	       likely(!time_after(busy_clock(), endtime)) &&
-	       likely(!signal_pending(current)) &&
-	       !vhost_has_work(dev);
+	return likely(!need_resched() && !time_after(busy_clock(), endtime) &&
+		      !signal_pending(current));
 }
=20
 static void vhost_net_disable_vq(struct vhost_net *n,
@@ -434,7 +431,8 @@ static int vhost_net_enable_vq(struct vhost_net *n,
 static int vhost_net_tx_get_vq_desc(struct vhost_net *net,
 				    struct vhost_virtqueue *vq,
 				    struct iovec iov[], unsigned int iov_size,
-				    unsigned int *out_num, unsigned int *in_num)
+				    unsigned int *out_num, unsigned int *in_num,
+				    bool *busyloop_intr)
 {
 	unsigned long uninitialized_var(endtime);
 	int r =3D vhost_get_vq_desc(vq, vq->iov, ARRAY_SIZE(vq->iov),
@@ -443,9 +441,15 @@ static int vhost_net_tx_get_vq_desc(struct vhost_net *=
net,
 	if (r =3D=3D vq->num && vq->busyloop_timeout) {
 		preempt_disable();
 		endtime =3D busy_clock() + vq->busyloop_timeout;
-		while (vhost_can_busy_poll(vq->dev, endtime) &&
-		       vhost_vq_avail_empty(vq->dev, vq))
+		while (vhost_can_busy_poll(endtime)) {
+			if (vhost_has_work(vq->dev)) {
+				*busyloop_intr =3D true;
+				break;
+			}
+			if (!vhost_vq_avail_empty(vq->dev, vq))
+				break;
 			cpu_relax();
+		}
 		preempt_enable();
 		r =3D vhost_get_vq_desc(vq, vq->iov, ARRAY_SIZE(vq->iov),
 				      out_num, in_num, NULL, NULL);
@@ -501,20 +505,24 @@ static void handle_tx(struct vhost_net *net)
 	zcopy =3D nvq->ubufs;
=20
 	for (;;) {
+		bool busyloop_intr;
+
 		/* Release DMAs done buffers first */
 		if (zcopy)
 			vhost_zerocopy_signal_used(net, vq);
=20
-
+		busyloop_intr =3D false;
 		head =3D vhost_net_tx_get_vq_desc(net, vq, vq->iov,
 						ARRAY_SIZE(vq->iov),
-						&out, &in);
+						&out, &in, &busyloop_intr);
 		/* On error, stop handling until the next kick. */
 		if (unlikely(head < 0))
 			break;
 		/* Nothing new?  Wait for eventfd to tell us they refilled. */
 		if (head =3D=3D vq->num) {
-			if (unlikely(vhost_enable_notify(&net->dev, vq))) {
+			if (unlikely(busyloop_intr)) {
+				vhost_poll_queue(&vq->poll);
+			} else if (unlikely(vhost_enable_notify(&net->dev, vq))) {
 				vhost_disable_notify(&net->dev, vq);
 				continue;
 			}
@@ -663,7 +671,8 @@ static int vhost_net_rx_peek_head_len(struct vhost_net =
*net, struct sock *sk)
 		preempt_disable();
 		endtime =3D busy_clock() + vq->busyloop_timeout;
=20
-		while (vhost_can_busy_poll(&net->dev, endtime) &&
+		while (vhost_can_busy_poll(endtime) &&
+		       !vhost_has_work(&net->dev) &&
 		       !sk_has_rx_data(sk) &&
 		       vhost_vq_avail_empty(&net->dev, vq))
 			cpu_relax();
--=20
2.17.1

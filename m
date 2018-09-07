Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBB4C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B646C20857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KAbTbJp6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B646C20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbeIGFTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:19:05 -0400
Received: from mail-bn3nam01on0105.outbound.protection.outlook.com ([104.47.33.105]:26432
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729693AbeIGFTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzCDsAIrTnHJjWi4MYysHxE3hJvWWIMStW4FiSeGEjw=;
 b=KAbTbJp6ER9GlSuDk7MakcpARYTp8YIwO3FlGKI5EDKKgF4os6ep6h6FG0/XZjEjwciKV4nFmolZvg0vbdSVuDn2ZLF6vE66hLXpoRVty+BUQwrSqnFxKQs6S3ricoFObrnjJcOU0qzPmg6Y1/wGdd2XwbPEys9avR6lCeyVwFY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:40:00 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:40:00 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 01/43] usb: usbtest: use irqsave() in USB's
 complete callback
Thread-Topic: [PATCH AUTOSEL 4.9 01/43] usb: usbtest: use irqsave() in USB's
 complete callback
Thread-Index: AQHURkMTZt+yAsz54kubH98QNyIDIw==
Date:   Fri, 7 Sep 2018 00:38:19 +0000
Message-ID: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:xNTgixSXHyluV8lAcXkhT1Kv6gIQFHq4VvfizoJhot4/LPCxUMlevQiplKoyDsRgPsghj3zQ0ekGf8vvMKFsmXixYEabQbMN7W2taGJ1II7Cj/93t7FzyKkruM5ycgm1OcQI2oMnVdpjwFSdZkLW7jrv2/UMEXjiUzhNvjC4jyQv9i29WFIO7z+LiXbH/Icd86Xpilich24e5bMDO7zEWuz/c+cMrJ2IOTL75edW6nytCfWJ3Nrbt7AU9xFMt/Tn02GfsmvfPqvJlVWIhcMD4bw0aIUHwv5VPclutX90eIYg7WfDjENYSr/SblqtXQdZ06b3qOzAekdNiGDrwR0GCMqmgtLapEVaEFj1RdX+hykGv5igYpGXCxGb6tZLtPtKPhK/AVtdeCL0tqdyVyE0x4PgmGAaHcQtGXzc+G7TObNqlwjbB9oQ8fvTLdfV01s+dk1cw1GSVUbeZtzwQtA2Fw==;5:yEjF2ZdV1vgXraFfx2BycTvpwema2cITubGKS3jyfF0k2nPmF9AD8B87bH+l3IyZXnUJ8EzsCrHh+xzd8yMRqWO9/PdnxKs0/tTAv84YzYhFIfGqEvJTOV0uBQHnL52C8QSUYnjNPKY0MlZWjlJZdpJa0Z3e0JFoJhf4xN9rMdc=;7:IsQ1gZtebhSQfSAf1qF7SbHrp6NOrx7sTDbkg8sqgbbNWjBj3ZqGgiZHzoZaTrXcaSwRyCaeG3RTnUFyD22axsZ1rnx5B3OZsdnZ46GDyjkBKqq55byhie5u4avEJIBg9ej1k4VPzOVdZsGKCaCdfuJ6MnwQxfbQkvxR7VKVHGGLkP6NSzD2wvOHR2lJr76Fp4EvxXhJ1v5x65DhgHB5i//Sk3jlwmcHBbebLxztpd6okCXt8MUJ0tX37+3z4RCH
x-ms-office365-filtering-correlation-id: b8055eb1-4e07-4ba1-258f-08d6145a71d2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB085537E3463D09932C375D4FFB000@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(35762410373642);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(366004)(376002)(39860400002)(189003)(199004)(53936002)(316002)(97736004)(2900100001)(86612001)(25786009)(86362001)(2906002)(6512007)(54906003)(107886003)(68736007)(110136005)(4326008)(81156014)(10290500003)(14454004)(8936002)(66066001)(81166006)(8676002)(3846002)(6116002)(478600001)(72206003)(7736002)(305945005)(1076002)(106356001)(105586002)(6506007)(10090500001)(6486002)(99286004)(256004)(36756003)(2501003)(26005)(186003)(6666003)(5250100002)(14444005)(6436002)(5660300001)(102836004)(217873002)(476003)(2616005)(486006)(22452003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wjkliAMPpeGAEqxp6RcC265/UyuYFk+KEvQKKukfb5AvP5GVbOjTEJjsIgjNUtmIaiYc1MCoSQdlGABIHzc+PYTs+agiqRAjYXeZFHedr8cbM6pyKN0y/Rf7/unUJX+GW4/kAHez9g+chmXomY753XZ/ZP5O/jHQafVGknj2E25etcq5JSSxv7vEKbv6H+0Wj6PEozPPJiHheTne8qQzu2xGaAxOjZ0fN/vHoA0TZzKl/LY3bTnm0k697pZV8M17FBgE4siwpi/Z+IxK71hj3Ggee2CDnoTRAMp0gt/FkpBlCiXHu7OvtcewzNYXCJfrqLRloeerpXxVUeVWy5+XNuGXJfh84vZ2UGxEVPaJgvk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8055eb1-4e07-4ba1-258f-08d6145a71d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:19.8876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 6f3fde684d0232e66ada3410f016a58e09a87689 ]

The USB completion callback does not disable interrupts while acquiring
the lock. We want to remove the local_irq_disable() invocation from
__usb_hcd_giveback_urb() and therefore it is required for the callback
handler to disable the interrupts while acquiring the lock.
The callback may be invoked either in IRQ or BH context depending on the
USB host controller.
Use the _irqsave() variant of the locking primitives.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/usb/misc/usbtest.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/misc/usbtest.c b/drivers/usb/misc/usbtest.c
index e31f72b3a22c..cc1dad83ec1d 100644
--- a/drivers/usb/misc/usbtest.c
+++ b/drivers/usb/misc/usbtest.c
@@ -1080,11 +1080,12 @@ static void ctrl_complete(struct urb *urb)
 	struct usb_ctrlrequest	*reqp;
 	struct subcase		*subcase;
 	int			status =3D urb->status;
+	unsigned long		flags;
=20
 	reqp =3D (struct usb_ctrlrequest *)urb->setup_packet;
 	subcase =3D container_of(reqp, struct subcase, setup);
=20
-	spin_lock(&ctx->lock);
+	spin_lock_irqsave(&ctx->lock, flags);
 	ctx->count--;
 	ctx->pending--;
=20
@@ -1183,7 +1184,7 @@ static void ctrl_complete(struct urb *urb)
 	/* signal completion when nothing's queued */
 	if (ctx->pending =3D=3D 0)
 		complete(&ctx->complete);
-	spin_unlock(&ctx->lock);
+	spin_unlock_irqrestore(&ctx->lock, flags);
 }
=20
 static int
@@ -1859,8 +1860,9 @@ struct transfer_context {
 static void complicated_callback(struct urb *urb)
 {
 	struct transfer_context	*ctx =3D urb->context;
+	unsigned long flags;
=20
-	spin_lock(&ctx->lock);
+	spin_lock_irqsave(&ctx->lock, flags);
 	ctx->count--;
=20
 	ctx->packet_count +=3D urb->number_of_packets;
@@ -1900,7 +1902,7 @@ static void complicated_callback(struct urb *urb)
 		complete(&ctx->done);
 	}
 done:
-	spin_unlock(&ctx->lock);
+	spin_unlock_irqrestore(&ctx->lock, flags);
 }
=20
 static struct urb *iso_alloc_urb(
--=20
2.17.1

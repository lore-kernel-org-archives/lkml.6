Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88DAC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABAA2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Z3N4WW2s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ABAA2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731046AbeIGFTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:19:41 -0400
Received: from mail-dm3nam03on0102.outbound.protection.outlook.com ([104.47.41.102]:49926
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730969AbeIGFTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nl5hXXh5IdspCBygjSyFheVCZgM47PVKbY/F26ni0GA=;
 b=Z3N4WW2siiJPejp8MFfalJmRFammXzLlUthFOPKbX0yStMhBMufu0wFnPpiuzXLXpUr/mW+60/MhjFpmpc+zx+Qr+m8kmNUepI86YeMcGwxpioSRLZ2EzntgV6gUvuYQKfK3vsyKlRSDJ6eEG6K/KVN0d84Pp0/5ngawcqlrOhA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0694.namprd21.prod.outlook.com (10.175.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:41:25 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:41:25 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 01/30] usb: usbtest: use irqsave() in USB's
 complete callback
Thread-Topic: [PATCH AUTOSEL 4.4 01/30] usb: usbtest: use irqsave() in USB's
 complete callback
Thread-Index: AQHURkMp3NKaNwolVEmwjQb+yB85WQ==
Date:   Fri, 7 Sep 2018 00:38:56 +0000
Message-ID: <20180907003853.57942-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0694;6:aRHA+np5sWc2scOG423ePBcg/w3STCX2AUtifQmg4nMQI6EKZQCGaSV/lNaB12rn0AZIPpa46LlPDFpdYywqRv2aUQp0AKZe4Wxxw1uV3TlsqMkX4N73JhL2/0O4MuV6gmeiHL9f86ziWs7SLPitcbhR/z80tR0Hq+KjT8o94x7UNdunwOaS1wwqz79UdfYPZCKaYuRz0I62P4LZ8FPBWQXsTOPl/TOOsEmdcaU1MyYrIx7lQ4fJHediQTSV/L9gBnAipq0lZfRXmnO3gRR8K/5eNCgig6GxVQlcpn6/oU9ntW0Vu8kbJEkiij1aqD/1Fs41zkXHOYPEn2A/SV/YqpILBld13yRH7Nt6I51gDy0t++DH/RaSlqaDqD+bqhIBcVRcuyafhzaVywtOGn6R9XVGBEOamt/oulqBD2MGm+nWBBMuTd4Vj2DNnxw0MlNr1uk/7s2VMeTBt1lo3QTJ2Q==;5:LQG9XoPjuV219NUd+2CGyO/jOglmI2GJBWaWDnB6vE8um6r5r3lcpwdm1WE2ZgM6wNQUzHn36QSXWnpKfm88yXVkktLG7gLDtQRwyCoeeHwcOm0KcAHL6LcMomTjj6Fg8p5gWY1IVrWy3TBh5UF/vegodsGUI2UxcSS/G+VRLc0=;7:ehd4+NwW45dshr3IYg+na0O8dPdCjdGQtNdNaRcAnTkG6h7o/y7H1Oi15hq5CTryZdtVUUoJ19cZvWXwPQTnws+9y6XAuPAh2thNjAmHL3yTweh4KtpR1SZQ6uTuwan9ZqApe1jAickK0i/qyGzQpX0OKJCe2xkqhvQzHQJUAEZQlQ3gYs6GuIpAHIS3takxvMLujHAGFsTHnNa9Ro77ED0kh0WyLXw+GuRdLQUKD7PwjK/zbR3wW/tL5dPNmIju
x-ms-office365-filtering-correlation-id: 6c932ac8-7e2a-48b8-5c79-08d6145aa425
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0694;
x-ms-traffictypediagnostic: CY4PR21MB0694:
x-microsoft-antispam-prvs: <CY4PR21MB069451D6400C21E7E8D1B38DFB000@CY4PR21MB0694.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(35762410373642);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0694;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0694;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(366004)(136003)(346002)(189003)(199004)(2906002)(186003)(86362001)(6666003)(110136005)(107886003)(54906003)(36756003)(25786009)(4326008)(256004)(14444005)(2616005)(6506007)(6486002)(6346003)(6436002)(6512007)(476003)(486006)(86612001)(2900100001)(5660300001)(102836004)(26005)(66066001)(53936002)(68736007)(7736002)(81166006)(81156014)(8676002)(10090500001)(8936002)(6116002)(3846002)(99286004)(105586002)(106356001)(5250100002)(22452003)(14454004)(316002)(1076002)(2501003)(305945005)(217873002)(97736004)(10290500003)(72206003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0694;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: h75pXeDTFnbiXdMQpdMqYnKci0unpm1SlZ4W5HJYVcz7296WTns9nGVBhuxwhAGvF0cBuptCzb08twDEfxNSvC+SAcKqtg3qNhBP5SxT2lhUJMaKy3CTObeCg5VNVilOyMQJISUcPHn25Wgt43Fka607G3O7NaGFyufrOKd1lQGpK0AgSU+sYaFgQ8nfNJ/8EVFQ0t/DobOwMum0baOGYm1A1vR37lyax3hsY2jklGfZDmqipcP6KxsUg0usilYUByBE55ZTfOXk/QDav7JKZD7eB21gAATK5OmTtKkwnArIcYS+FM8qifIgUBTMnZd7RWPv1QVENOGGOyJbXaXAu5H9hVULGBH6v8nZVKKrz6s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c932ac8-7e2a-48b8-5c79-08d6145aa425
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:56.9305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0694
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
index bc92a498ec03..4632a29d5403 100644
--- a/drivers/usb/misc/usbtest.c
+++ b/drivers/usb/misc/usbtest.c
@@ -1053,11 +1053,12 @@ static void ctrl_complete(struct urb *urb)
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
@@ -1156,7 +1157,7 @@ static void ctrl_complete(struct urb *urb)
 	/* signal completion when nothing's queued */
 	if (ctx->pending =3D=3D 0)
 		complete(&ctx->complete);
-	spin_unlock(&ctx->lock);
+	spin_unlock_irqrestore(&ctx->lock, flags);
 }
=20
 static int
@@ -1832,8 +1833,9 @@ struct transfer_context {
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
@@ -1873,7 +1875,7 @@ static void complicated_callback(struct urb *urb)
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

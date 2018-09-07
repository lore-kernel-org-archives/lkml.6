Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D58CC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB6820861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="D7Jn3Q1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB6820861
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbeIGFPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:15:52 -0400
Received: from mail-eopbgr690092.outbound.protection.outlook.com ([40.107.69.92]:60896
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729521AbeIGFPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NH2sqmIwX146DZHGxriWZR0cE/l7a6NI+p6L9chPsR8=;
 b=D7Jn3Q1pxWEDayrjVNaghHuYOj0+GX/W7gGpOovP45AXBt8vlFmFpmVMyBKV3U+kq9Yll9bsDEo/GhD6PnVsUyH5XL4wCoAUw3YmmUE/i02vTakjuGsD1y94iVrgzvOi89jgb/90F9k8QaU0hqdga57/dGQOcHnP/Q9NIxlcy3Q=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0503.namprd21.prod.outlook.com (10.172.122.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:37:43 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:37:42 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 02/67] usb: usbtest: use irqsave() in USB's
 complete callback
Thread-Topic: [PATCH AUTOSEL 4.14 02/67] usb: usbtest: use irqsave() in USB's
 complete callback
Thread-Index: AQHURkLwBGEqVjBxaE6zSqGfaYwA5g==
Date:   Fri, 7 Sep 2018 00:37:22 +0000
Message-ID: <20180907003716.57737-2-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0503;6:wiv8+ocSDti1lrcEtW6yJ7SqMl9JRm4NHR64BTEgGN0+Qu/3w2UCRJjwy0PrnzmaANwhf4YZ9zYRlUXBlmCcx4q7tQHJTG9BDPMUUzVNzk1hR7hA7ReavYWVz+xZVVW7ob5FOY80xC5Rzik504lexCYUJhjK9j6306hgm1sgVy61Nl6qaJXPZ76wjdWoYjLYf+7wgwGODdtjdIiuxqczR5ZgFB03kh6H2I4oXi3BBPFyfAJ4dcGk/zTujvADks/CO/tK5K1HriGPx2Zf7gww2LvgsHcEdOa9MEZhASyQbJewiqC2GlhKOYWWfDb8/fZcgEX6UR5ocdy5aJoUET6TxawbsdGekat6LA3c5D8H7Lfg1AGbP0/VO+bQvyFR2TuF9wORxnuWk8eKhDG/qCOaCnWFabYYt6mkWBmtdR+voQiQnjq5L/KyaEu9EszcCkpKjmcgkJG5XTBDmcu7z0XqHw==;5:d71MFj9NKhI6aw5+zGlZinzg6J8QPZm8hMA0OPAQ3zkAKErKKjc/pN+rCd5LyeXQ644qUkzqr9NsV+aBiOQPeB/joLFFu1gwzk24pyZZpmPfSO3oXp0jD33Jfj8P97KtReC7PdMxiFtFuq9XSeWI85XkGy01KyWKDMTQNNFYpBE=;7:Y35zZYL7dpcgiEbhjsD5972dYnjGhwZqAmW2EVlz5zG7ZpKRVYECubsGnkgbLkXk9X2G/2D+8qwE9FlPlMVXDVlDkEdnGS/U63+SsCy5I+SUAUhxNqQWpoQeUn4mH2MkKmRwmc6WMHMlgrWHcdMlaBlztVS70YufHsp1c7hettLgf0R4pHI8f3S5TZQ3jO2O4tInI0QOxH4/9m04njFvT1C+UehR8ri03Qzvsj0aXmKMDQLXzZXm4xr5rgxFQjqd
x-ms-office365-filtering-correlation-id: 7191dc86-b095-4e6e-b055-08d6145a1fa1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0503;
x-ms-traffictypediagnostic: CY4PR21MB0503:
x-microsoft-antispam-prvs: <CY4PR21MB05039E3F56139D89FDBB2BF9FB000@CY4PR21MB0503.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(35762410373642);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(8121501046)(5005006)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0503;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0503;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(136003)(39860400002)(396003)(189003)(199004)(76176011)(2906002)(217873002)(107886003)(256004)(5250100002)(6512007)(22452003)(14454004)(86612001)(316002)(6436002)(486006)(110136005)(2501003)(6486002)(54906003)(81156014)(81166006)(14444005)(8676002)(86362001)(10290500003)(2616005)(25786009)(476003)(8936002)(97736004)(5660300001)(102836004)(106356001)(11346002)(68736007)(6666003)(4326008)(6116002)(3846002)(446003)(305945005)(7736002)(66066001)(1076002)(6506007)(478600001)(53936002)(2900100001)(99286004)(10090500001)(105586002)(186003)(72206003)(36756003)(6346003)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0503;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: gytTZ/wqbm32bVGG7GRiTidJG9R/7+ubHb2oUDCO9tBzKK0b4KLpIWrjZG33jSTKHcVmO23XMgKIe7VY6L0qIvvnsESs2t7x2QT5PinuBlOTPrJAC4xkaePc2j0eKdCchVycWhuutpIC3nYtT9x90BcoEf6z9e4+2B/Nct9pvoqPjDN+yIyNgoDbgjJ/Qwpb83EDaIFWq5UcI3GW2lsCRdyZk35WaRUs/ZRwOcS2RwOHs+2NmOIuNea44wgNuxQ/Y+C3hqzNggYn/Ns5w8E6fbxpMX7xPUolC9b746uK5Dq5aNdsKKuIxTOaz780M3YkmXrQP9wFNZykGyfaMXJiPNrocgnj5zI7H277IJc/aFM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7191dc86-b095-4e6e-b055-08d6145a1fa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:22.2802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0503
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
index b3fc602b2e24..fcfc562eea4c 100644
--- a/drivers/usb/misc/usbtest.c
+++ b/drivers/usb/misc/usbtest.c
@@ -1073,11 +1073,12 @@ static void ctrl_complete(struct urb *urb)
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
@@ -1176,7 +1177,7 @@ static void ctrl_complete(struct urb *urb)
 	/* signal completion when nothing's queued */
 	if (ctx->pending =3D=3D 0)
 		complete(&ctx->complete);
-	spin_unlock(&ctx->lock);
+	spin_unlock_irqrestore(&ctx->lock, flags);
 }
=20
 static int
@@ -1852,8 +1853,9 @@ struct transfer_context {
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
@@ -1893,7 +1895,7 @@ static void complicated_callback(struct urb *urb)
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

Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4E4C43143
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42FC52083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hy3rqtUj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42FC52083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbeIGFOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:14:01 -0400
Received: from mail-eopbgr690100.outbound.protection.outlook.com ([40.107.69.100]:6633
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727776AbeIGFOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLPTi014TdTPHf9/M6Izahs/0HxxWO6j0rNMGS+U8yI=;
 b=hy3rqtUjf0kcFIwI5bH/hBzh3ktNPCEAhzIGeTWzPvRgPCtu7+focEUI/70kJSuZe6MsPdMngc5+da+M9UMocdDZdjR5QyZGbUkItoB5mPW8cI38gOpqB/g9u0ZY7FUoQJGBhs40YeCsk1/CbbOnJYMssTayoLehKQ/L7PgJXtA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:35:52 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:35:52 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 02/88] usb: usbtest: use irqsave() in USB's
 complete callback
Thread-Topic: [PATCH AUTOSEL 4.18 02/88] usb: usbtest: use irqsave() in USB's
 complete callback
Thread-Index: AQHURkK71BKA49IDeUKhAeCyP8Rc3Q==
Date:   Fri, 7 Sep 2018 00:35:52 +0000
Message-ID: <20180907003547.57567-2-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:qEQz3a6Kojt9zV4b7iNNZiWh/O/5g/VwEzZz2rS0+sSGi5DR3U1KI3elVgJzLFfIYPuQYpPfkSokLqhbCFRG0/3KbxfEZ7XiKmH2W8eS/T5CLC79fhdLFPe/RlSrA4l7ai9dThRnhhkzlhlqI1bddm71rm2ytwOmBBizPy27fapzd+mmTjnjGz5ty4T7X8YWrXl4pQz86v4zvvnridVRhQgwHik2CltSTfrqotaCYRBGN67cXjoNPbRWkpXcmUCbzRV5xSDYTH923YNAxLN5ixsbYlGhUp2BmI5KVdYB1B8DXnMyXJUf4Yz46wEuhmgT1QRbtW6dXid0mo1AvngT4mb833jaYqb12CQzZTwX/y6Cmz/rvVSmbisSfuWJskPMu5gBPmsGXpLwZhJXH/+lUMr57AV7uS8BXDbZxbRA5VGtLCHpjRj6agrpVgCYGYFu/BGU85a4NUWUp/ar/aX3mA==;5:SKOSu6ZNps/oFo2SUZjqyGrCD3hyRgCD13qmOm7e+kCFCZfwAjMmyEaHCVnPwvmtXesILybDFEOPEnxneIAYoDkDYJq4fkU4GFnu3xUWd3lDFE2DZAhEsY0U9eVzxVBs0qBPCmBEMr2glMMlc2Km4gxTCT3zi1kzC1N9FdJTt4E=;7:nCV3InoRjl2vOPy1vOe9WAa+gPVD+lDQeqceoZnsx1cC81IefZ3EI3qthOT6lXXOfzS35ccW3cFCz9kvZaZLvfCYjaZyfU+9GozFgKgkSFo92PWOWN68/tvOIzatMvNswJy+aOonEF/ruVgjrNS1yC8sOOhU+QLWFzsZxRoNss41NPJDurykj+2j0hNnGgH2Q+XW48OcRRoVBRFQZ+h8nUVQ5M5v21ugA/UcHfoQyjr6Wapifh7NnGBPSaW23FTU
x-ms-office365-filtering-correlation-id: 51a3e01a-d920-4438-f62c-08d61459ddf1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0773E25443B579D80FB1B25AFB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(35762410373642);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(2616005)(476003)(4326008)(11346002)(5250100002)(107886003)(2501003)(86612001)(97736004)(6512007)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(14454004)(1076002)(66066001)(26005)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(14444005)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: L1GtH7dEBtTRUiMBMJsZpMxJ7W331pM947662Qc+S03PyzAjPbpb/lG+AAC4A5AiaqKvOHofR6ZPhznsNTaBqnwTSLgNh8YhC8Lz37tz3mWhL5H4gbaqcB9Sfa4bEwlj9lAJN7OanPrfpHs7hipykAAvv1NkolsNYJi+N+p79n1dKkuL4ud5va0VWeGvXNu7N9i0MQOOxcb7oY5cPZquB+aSEERP6VIXaqAQRODLenOSsOA7x1vFbTHCkgLTTIIdQl+6QgPBrvQ1eSR9+wlTmUgAWOcWHw1ajEirSzRtexmLilvfvpZpQ4WNUnoXdCTJmxsUz/n+nK9zd6+HLr7SMGbeRKrcPE2t25fDvyhs9dc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a3e01a-d920-4438-f62c-08d61459ddf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:35:52.6179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
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
index 9e1142b8b91b..c7f82310e73e 100644
--- a/drivers/usb/misc/usbtest.c
+++ b/drivers/usb/misc/usbtest.c
@@ -1082,11 +1082,12 @@ static void ctrl_complete(struct urb *urb)
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
@@ -1185,7 +1186,7 @@ static void ctrl_complete(struct urb *urb)
 	/* signal completion when nothing's queued */
 	if (ctx->pending =3D=3D 0)
 		complete(&ctx->complete);
-	spin_unlock(&ctx->lock);
+	spin_unlock_irqrestore(&ctx->lock, flags);
 }
=20
 static int
@@ -1917,8 +1918,9 @@ struct transfer_context {
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
@@ -1958,7 +1960,7 @@ static void complicated_callback(struct urb *urb)
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

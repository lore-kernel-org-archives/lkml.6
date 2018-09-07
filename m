Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6714FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB072083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SHdtaBVt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB072083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbeIGFPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:15:11 -0400
Received: from mail-eopbgr690126.outbound.protection.outlook.com ([40.107.69.126]:51988
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728163AbeIGFPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guGP8tF2dn7jn4MXqXAIyYD3uFFBCFtt7XIXZpZJ3xs=;
 b=SHdtaBVtR4s4Ezt89aJmCWZAkLoJ0/KeKAIGcyN6BgCgxM4cgyD0iXruKdpshJ6rpPMaW1C+x1830QyFpiKZhGjrLBuIeU5j37xBDX8cH5F4KPgIlMth++rnUDIxV/oQC2+P3KVhPpAA85Ulx7irDWArPWf0AHIsAPE7yWHhtpg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:36:06 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:06 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 19/88] Input: pxrc - fix freeing URB on device
 teardown
Thread-Topic: [PATCH AUTOSEL 4.18 19/88] Input: pxrc - fix freeing URB on
 device teardown
Thread-Index: AQHURkLDGU7Esoq/F0uh1fzlYemwFA==
Date:   Fri, 7 Sep 2018 00:36:06 +0000
Message-ID: <20180907003547.57567-19-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:KsOhXXFWtSKrCAzpsnLUromAQrIHvXZxayTLD0oHwBPLmxYV0XHkG3CL56DTsgO3AWuKDweVIEv7IJpBIaeMi6wvgQ8NrmkJn3Hrh0bnbyvztnhxfhm9FNiVYuNp4iHmaKxCLgXCM96MzExYHklF97XLdpTya68+acVZLOeuzGrODcXb2tTyUmQIlnQ2kqRbRpCKKLA1fMV7ObR/7fgJUqVPNDWvYLefTKfgOt0W0xZeuJEJwg2oFXRIcymiQXwFRtfwidnVHs1VCykkAjWa42lQ5PK9Ic8h8qccp1KqQbfiq5dLlRRQGuJpP4JPQV8Om6GaaLA8EBnJmlVjmQqst5HudcMVjcLJddRIruDF1NfnVRCBsrTAtGGNyYr/FSM04s168x3c8XUK/HBuhVpp/wkkloDp6zb+CWc4GLA8lShuO+mH1uvkU8pFDa4crhFKorc/PxhrFlnqXK3d265BiA==;5:P7z6fR3fVCHXsQYNxXvLLUALAiHblHyCu63a5VNgxx1zPa2bRlilAFgsrFFolMXjlTEWy7aBui4Hv00d8ne/IR5gbD5l5MbHQ90LsCFXDV0q7AL4bOLMiPhrlXHdn11t/hnswLZs9WqkfsvHz8G9TAo+mIqrXruBSx1uTgUuWMo=;7:mTX+UM80PEm0lEby8z6OPF9t0iOIwloyXSC8Hs0TuOJNoBGbi0ioNBi1eW2tNfGUHSvtLC+jIp5V0JYC36ELxfadSbIwjABS2SmEStYtvbUbzSkA6HnqKuPIM7ZBJdh+1qcAWhBjYEg9+IfdmXC7qvpOQuXwvBwViyqN/pHZYTHErjdz96fWORAPas0s8KA2YWxn1hXwESwGEgPdznHaAxTx9NgdUIsBu7C0MfnM1Bon9Q+7C6Z0EZ+g67xQ9ZnV
x-ms-office365-filtering-correlation-id: 190fd503-25c6-4d53-6c42-08d61459e5fa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0773BEEC3D105AFB22685903FB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(2616005)(476003)(4326008)(11346002)(5250100002)(107886003)(2501003)(39060400002)(86612001)(97736004)(6512007)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(14454004)(1076002)(66066001)(26005)(575784001)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(14444005)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rrYRV3jto0BlifD0MtMN9lwUrWbiBxuM35twmukJ+BvIpryrgq74iRseaaGCSGeDt/zzRmOCGrjBbKKaUpSItfXzhDhWA82ym/0z7Upg+0U+JOcb41+lK0jHK1lguzsCi17dzO0tQXQKQDgXhmrIlV46pSen3H6uKGAVxeJeT3pJrFfyiw8CjpXBMZQ9q+S7jOUeScGE0jC8r5MtUjnUl1Bdn4habrehul1MAuGaGyrvV+P/iLeSF7nznp/X9K4RuHILTuAjBy+RlQ8aATGorw1eLwhqdMXX5ByRJ0PlZ6DO0Ds8FTIWELqN+1vBrg6k9oqcbZ0EZ781/5vQP7bp6VenlV5NUE9D3CZ1/o0iRyQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 190fd503-25c6-4d53-6c42-08d61459e5fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:06.0671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit 34dad2cf1104869ce2db2bddb34f8e6780c2ddaa ]

URB is the only resource that is not managed, and thus is destroyed too ear=
ly,
before we unregister input device and stop URB in pxrc_close(). To fix it l=
et's
install custom devm handler to free the URB at the right time in devm unwin=
d
sequence.

Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Tested-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/input/joystick/pxrc.c | 66 ++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 36 deletions(-)

diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxrc.c
index 07a0dbd3ced2..cfb410cf0789 100644
--- a/drivers/input/joystick/pxrc.c
+++ b/drivers/input/joystick/pxrc.c
@@ -120,48 +120,51 @@ static void pxrc_close(struct input_dev *input)
 	mutex_unlock(&pxrc->pm_mutex);
 }
=20
+static void pxrc_free_urb(void *_pxrc)
+{
+	struct pxrc *pxrc =3D _pxrc;
+
+	usb_free_urb(pxrc->urb);
+}
+
 static int pxrc_usb_init(struct pxrc *pxrc)
 {
 	struct usb_endpoint_descriptor *epirq;
 	unsigned int pipe;
-	int retval;
+	int error;
=20
 	/* Set up the endpoint information */
 	/* This device only has an interrupt endpoint */
-	retval =3D usb_find_common_endpoints(pxrc->intf->cur_altsetting,
-			NULL, NULL, &epirq, NULL);
-	if (retval) {
-		dev_err(&pxrc->intf->dev,
-			"Could not find endpoint\n");
-		goto error;
+	error =3D usb_find_common_endpoints(pxrc->intf->cur_altsetting,
+					  NULL, NULL, &epirq, NULL);
+	if (error) {
+		dev_err(&pxrc->intf->dev, "Could not find endpoint\n");
+		return error;
 	}
=20
 	pxrc->bsize =3D usb_endpoint_maxp(epirq);
 	pxrc->epaddr =3D epirq->bEndpointAddress;
 	pxrc->data =3D devm_kmalloc(&pxrc->intf->dev, pxrc->bsize, GFP_KERNEL);
-	if (!pxrc->data) {
-		retval =3D -ENOMEM;
-		goto error;
-	}
+	if (!pxrc->data)
+		return -ENOMEM;
=20
 	usb_set_intfdata(pxrc->intf, pxrc);
 	usb_make_path(pxrc->udev, pxrc->phys, sizeof(pxrc->phys));
 	strlcat(pxrc->phys, "/input0", sizeof(pxrc->phys));
=20
 	pxrc->urb =3D usb_alloc_urb(0, GFP_KERNEL);
-	if (!pxrc->urb) {
-		retval =3D -ENOMEM;
-		goto error;
-	}
+	if (!pxrc->urb)
+		return -ENOMEM;
+
+	error =3D devm_add_action_or_reset(&pxrc->intf->dev, pxrc_free_urb, pxrc)=
;
+	if (error)
+		return error;
=20
 	pipe =3D usb_rcvintpipe(pxrc->udev, pxrc->epaddr),
 	usb_fill_int_urb(pxrc->urb, pxrc->udev, pipe, pxrc->data, pxrc->bsize,
 						pxrc_usb_irq, pxrc, 1);
=20
-error:
-	return retval;
-
-
+	return 0;
 }
=20
 static int pxrc_input_init(struct pxrc *pxrc)
@@ -197,7 +200,7 @@ static int pxrc_probe(struct usb_interface *intf,
 		      const struct usb_device_id *id)
 {
 	struct pxrc *pxrc;
-	int retval;
+	int error;
=20
 	pxrc =3D devm_kzalloc(&intf->dev, sizeof(*pxrc), GFP_KERNEL);
 	if (!pxrc)
@@ -207,29 +210,20 @@ static int pxrc_probe(struct usb_interface *intf,
 	pxrc->udev =3D usb_get_dev(interface_to_usbdev(intf));
 	pxrc->intf =3D intf;
=20
-	retval =3D pxrc_usb_init(pxrc);
-	if (retval)
-		goto error;
+	error =3D pxrc_usb_init(pxrc);
+	if (error)
+		return error;
=20
-	retval =3D pxrc_input_init(pxrc);
-	if (retval)
-		goto err_free_urb;
+	error =3D pxrc_input_init(pxrc);
+	if (error)
+		return error;
=20
 	return 0;
-
-err_free_urb:
-	usb_free_urb(pxrc->urb);
-
-error:
-	return retval;
 }
=20
 static void pxrc_disconnect(struct usb_interface *intf)
 {
-	struct pxrc *pxrc =3D usb_get_intfdata(intf);
-
-	usb_free_urb(pxrc->urb);
-	usb_set_intfdata(intf, NULL);
+	/* All driver resources are devm-managed. */
 }
=20
 static int pxrc_suspend(struct usb_interface *intf, pm_message_t message)
--=20
2.17.1

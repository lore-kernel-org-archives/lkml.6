Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A2FC46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 17:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572842085B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 17:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="RooClJdb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 572842085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbeJ1CUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 22:20:09 -0400
Received: from mail-by2nam03on0056.outbound.protection.outlook.com ([104.47.42.56]:7296
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729031AbeJ1CUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 22:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6D/6bhMDJFIm52PO2LKH0MFnoBCEx6iwaV3S92F4nw=;
 b=RooClJdbDqFJ2y8xd9C/xOxu0C1easfaB+YpIgZBjCH4LLPMULGEE4SenQS3uHDwybVd+9QvsgfZvEh69b7jwhohRurBVSuYLXMvfSV+NpRZLtCUkE/9kCPlOeyfXspAL7aMp2tUGg8CCNOC88YhtmHwclDX+jNVOPMSbz6pyoo=
Received: from BYAPR07MB4920.namprd07.prod.outlook.com (52.135.237.93) by
 BYAPR07MB4805.namprd07.prod.outlook.com (20.176.248.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Sat, 27 Oct 2018 17:38:22 +0000
Received: from BYAPR07MB4920.namprd07.prod.outlook.com
 ([fe80::69f7:b92b:5107:d9e5]) by BYAPR07MB4920.namprd07.prod.outlook.com
 ([fe80::69f7:b92b:5107:d9e5%4]) with mapi id 15.20.1273.025; Sat, 27 Oct 2018
 17:38:22 +0000
From:   "Cherian, George" <George.Cherian@cavium.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "Cherian, George" <George.Cherian@cavium.com>
Subject: [PATCH] xhci: Add quirk to workaround the errata seen on Cavium
 Thunder-X2 Soc
Thread-Topic: [PATCH] xhci: Add quirk to workaround the errata seen on Cavium
 Thunder-X2 Soc
Thread-Index: AQHUbhvbI9VLVrMJM0yFLaM3hV0WVQ==
Date:   Sat, 27 Oct 2018 17:38:22 +0000
Message-ID: <1540661892-189850-1-git-send-email-george.cherian@cavium.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::31) To BYAPR07MB4920.namprd07.prod.outlook.com
 (2603:10b6:a03:55::29)
x-originating-ip: [50.233.148.155]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4805;6:F7/4Xa+2bRjhQyVKNfOrF/qRVpgH4hMSp4oVfk1Qijny4dMnC96oAbzaK4xk9JxRTSDJhdRj2/GnguUXYEQlaMl+zvqpX6SrpzTMW3DoBYMvv3kesINel1R6mH24mIshzaEu2o+TiIq8cq6CD/fBIkSOdbVDg9vUkUlvTTNvc5cPkcqDViDGJk6RMynfqGcJcIRaD40HUhXKlatu9lcuDekdrupixv+77cf+YEW2AfULEN9TQ8A/9PL+9E1Fg2sYVupvlMn/ZBs5teVAjyAr69Ep9va27AhkrwkE0DhXoM6vHBj4OgL6xi37XNxJ6FHFzCaOD+pTLMG8EcgxHa6T0btNOszB61A0xWwxWDPkE1XC7sG/b4bdEW3JzFxGRjog4ZrjdlE/lIgYMcUG6P/etjcRCS1cHU1DLLpU7UAvcf+12H7/2ojFVWA9RVmrysghfgdrSIaHBHyv7+8W6I6qxQ==;5:IJGKdRXotsGIBW/f+GgOVQvqPDT1xuJh3jpee4gpUzpOis0smFrl2Kolh41gGr9eFqWJORMZSRMizI2v5GBHVeJJXGnE1Qp8E9FM+7A/QMcgK2OWOYxlV53xO6vGeM094tgljszHv2vqM2hr3IM7vp6wtgut7kCSHoOElZKloNs=;7:4NgygIvt0xoc8UDBS4LVuMtIqvdKGwp5j48qEdgpwAhNi4yCyIyAR/j1AfZ2APml9QNxXFgtPozWegU49nad3rV+JJJJxp1jefnxHtUrzQYz67IwuAyZYRkciiq+96oAqZ6CGIqIwikyPB+z4pHttpDjuEa3Hb70bITl0PMG2FhBDfTxmtCgfNzJMOqgLTW7qGu+ZfLGBStgfFg3d+bZVd/LUzBS7Xv+5Y2gewruP1MpZPkf1iIOACXCaOIB/WX5
x-ms-office365-filtering-correlation-id: d26115d7-9ab1-4bc1-c2df-08d63c32fd33
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4805;
x-ms-traffictypediagnostic: BYAPR07MB4805:
x-microsoft-antispam-prvs: <BYAPR07MB4805E01BA1B9CC345305D9B9F9F10@BYAPR07MB4805.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB4805;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4805;
x-forefront-prvs: 08381C729B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(366004)(346002)(39860400002)(199004)(189003)(486006)(6436002)(2616005)(25786009)(8676002)(4326008)(6512007)(86362001)(575784001)(14454004)(107886003)(476003)(6486002)(186003)(53936002)(1857600001)(5660300001)(26005)(66066001)(478600001)(72206003)(3846002)(6116002)(2906002)(36756003)(5250100002)(2501003)(2900100001)(71190400001)(71200400001)(99286004)(7736002)(305945005)(52116002)(8936002)(102836004)(81166006)(81156014)(386003)(6506007)(68736007)(256004)(14444005)(110136005)(97736004)(54906003)(105586002)(316002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4805;H:BYAPR07MB4920.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WE9v3ntG7Xj3p3nP7n74h3EnSUZeBk0G5X/FulNdX++dwTYbNinrJe8FYxByqNL/+Sl+dYxcnQlyF+Ax6bki6L7Iau6KOxEX1YC0HgGxDFXDMEx70k68kGVPB3RMGeu66L9J7KatXezxb6a7q5+zp+D5MaORvuFAftibkMd/Rj6EAl3+yX0zuvJeCChohlH7bze2BsdV03gOdt/wH1Bbq9YGiSGB+6mZ6GU03h6ZSqBnf/Ud9YU+e1lyI/80sGxU/fLcrb5RmFfDHOZTLRmqPW6zqMlfyRGJUE+2CwDRFJ020d+wdp6+RAaaEEPqNW169Hgt2XDtHT4wLuwbwOPZ9bCZMoUMnHQhQlHBgWsSyYI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d26115d7-9ab1-4bc1-c2df-08d63c32fd33
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2018 17:38:22.2313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4805
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement workaround for ThunderX2 Errata-129 (documented in
CN99XX Known Issues" available at Cavium support site).
As per ThunderX2errata-129, USB-2.0 device may come up as USB-1.0
If a connection to a USB-1.0 device is followed by another connection
to a USB-2.0 device, the link will come up as USB-1.0 for the USB-2.0
device.

Resolution: Reset the PHY after the USB1.0 device is disconnected.
The PHY reset sequence is done using private registers in XHCI register
space. After the PHY is reset we check for the PLL lock status and retry
the operation if it fails. From our tests, retrying 4 times is sufficient.

Add a new quirk flag XHCI_RESET_PLL_ON_DISCONNECT to invoke the workaround
in handle_xhci_port_status().

Signed-off-by: George Cherian <george.cherian@cavium.com>
---
 drivers/usb/host/xhci-pci.c  |  5 +++++
 drivers/usb/host/xhci-ring.c | 35 ++++++++++++++++++++++++++++++++++-
 drivers/usb/host/xhci.h      |  1 +
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 51dd8e0..334c009 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -231,6 +231,11 @@ static void xhci_pci_quirks(struct device *dev, struct=
 xhci_hcd *xhci)
 	if (pdev->vendor =3D=3D PCI_VENDOR_ID_TI && pdev->device =3D=3D 0x8241)
 		xhci->quirks |=3D XHCI_LIMIT_ENDPOINT_INTERVAL_7;
=20
+	if ((pdev->vendor =3D=3D PCI_VENDOR_ID_BROADCOM ||
+	     pdev->vendor =3D=3D PCI_VENDOR_ID_CAVIUM) &&
+	     pdev->device =3D=3D 0x9026)
+		xhci->quirks |=3D XHCI_RESET_PLL_ON_DISCONNECT;
+
 	if (xhci->quirks & XHCI_RESET_ON_RESUME)
 		xhci_dbg_trace(xhci, trace_xhci_dbg_quirks,
 				"QUIRK: Resetting on resume");
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index f0a99aa..f342cbd 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1517,6 +1517,35 @@ static void handle_device_notification(struct xhci_h=
cd *xhci,
 		usb_wakeup_notification(udev->parent, udev->portnum);
 }
=20
+/*
+ * Quirk hanlder for errata seen on Cavium ThunderX2 processor XHCI
+ * Controller.
+ * As per ThunderX2errata-129 USB2.0 device may come up as USB1.0
+ * If a connection to a USB1.0 device is followed by another connection
+ * to a USB2.0 device.
+ *
+ * Reset the PHY after the USB device is disconnected if device speed
+ * is less than HCD_USB3.
+ * Retry the reset sequence max of 4 times checking the PLL lock status.
+ *
+ */
+static void xhci_handle_tx2_wrapper_reset(struct xhci_hcd *xhci)
+{
+	struct usb_hcd *hcd =3D xhci_to_hcd(xhci);
+	u32 pll_lock_check;
+	u32 retry_count =3D 4;
+
+	do {
+		/* Assert PHY reset */
+		writel(0x6F, hcd->regs + 0x1048);
+		udelay(10);
+		/* De-assert the PHY reset */
+		writel(0x7F, hcd->regs + 0x1048);
+		udelay(200);
+		pll_lock_check =3D readl(hcd->regs + 0x1070);
+	} while (!(pll_lock_check & 0x1) && --retry_count);
+}
+
 static void handle_port_status(struct xhci_hcd *xhci,
 		union xhci_trb *event)
 {
@@ -1642,8 +1671,12 @@ static void handle_port_status(struct xhci_hcd *xhci=
,
 		goto cleanup;
 	}
=20
-	if (hcd->speed < HCD_USB3)
+	if (hcd->speed < HCD_USB3) {
 		xhci_test_and_clear_bit(xhci, port, PORT_PLC);
+		if ((portsc & PORT_CSC) && !(portsc & 0x1) &&
+		    (xhci->quirks & XHCI_RESET_PLL_ON_DISCONNECT))
+			xhci_handle_tx2_wrapper_reset(xhci);
+	}
=20
 cleanup:
 	/* Update event ring dequeue pointer before dropping the lock */
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 6230a57..004b832 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1846,6 +1846,7 @@ struct xhci_hcd {
 #define XHCI_SUSPEND_DELAY	BIT_ULL(30)
 #define XHCI_INTEL_USB_ROLE_SW	BIT_ULL(31)
 #define XHCI_ZERO_64B_REGS	BIT_ULL(32)
+#define XHCI_RESET_PLL_ON_DISCONNECT BIT_ULL(33)
=20
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
--=20
1.8.3.1


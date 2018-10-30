Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A03C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D515420823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="LqHUBBa1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D515420823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbeJ3Tlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 15:41:40 -0400
Received: from mail-by2nam03on0086.outbound.protection.outlook.com ([104.47.42.86]:37044
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727239AbeJ3Tlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 15:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zr7ocejrAFheClVqY2yL3cwEkthKdNDjFW1zcHwmPn4=;
 b=LqHUBBa1onz0CTi+aRfBGgaDBuClNjD0BhyggKaQUSCzgvzhpexN2xHefeTPssynbFtUpqcpRxogADK/cdzKfBxlLw0jzKtrGGMdrQeVZAKhEAtAWsXyylCHPr7mGEpZrjdn+fItiFhRRzxZwO6jb/EVTSZ2vpSOH6Qdx90MXGc=
Received: from BYAPR07MB4920.namprd07.prod.outlook.com (52.135.237.93) by
 BYAPR07MB5509.namprd07.prod.outlook.com (20.177.231.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.27; Tue, 30 Oct 2018 10:48:38 +0000
Received: from BYAPR07MB4920.namprd07.prod.outlook.com
 ([fe80::69f7:b92b:5107:d9e5]) by BYAPR07MB4920.namprd07.prod.outlook.com
 ([fe80::69f7:b92b:5107:d9e5%4]) with mapi id 15.20.1273.027; Tue, 30 Oct 2018
 10:48:38 +0000
From:   "Cherian, George" <George.Cherian@cavium.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "Cherian, George" <George.Cherian@cavium.com>
Subject: [PATCH v3] xhci: Add quirk to workaround the errata seen on Cavium
 Thunder-X2 Soc
Thread-Topic: [PATCH v3] xhci: Add quirk to workaround the errata seen on
 Cavium Thunder-X2 Soc
Thread-Index: AQHUcD4detu6/VwpiUybz2IrVAWqaQ==
Date:   Tue, 30 Oct 2018 10:48:38 +0000
Message-ID: <1540896507-23876-1-git-send-email-george.cherian@cavium.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0060.namprd07.prod.outlook.com
 (2603:10b6:a03:60::37) To BYAPR07MB4920.namprd07.prod.outlook.com
 (2603:10b6:a03:55::29)
x-originating-ip: [50.233.148.155]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5509;6:fXL8j2doFquQ7oQnqAajZx79CCJ8zpEhDbr8umlKd7rKApytVA50nXhuB/JysLPu1rcbo/hAe6Et73rxp6zus5yLMYkG7m+R52UDJag7iLGiua1E0VKwHXWm6NabSuTi/1ZbzDf3flfWT+Co5PKyPji0LccagAbajeY/6R32aMYaSwSAI2wEVWJgUtUM6XEzy5gB3fV94gNFI4uCuyx5I99ZoqW3U46u5wnC5Ll5wYzN77SiLJiu5cGcpSpoLmGI4LPUgSV/JdXKTXtSHDvH8pGcVhJZK/36Yl1b0NRGBlBYRMcI9PkdNewCZkkI07Jxe9PQUWmx1qovQx9PX1LkgnH60Cx3iJbRsICtGk4rXNqeqJX4v17ZYXF+i4iaL/Y1Ve3XVrr4iExcpgUJb0jkPhEMXbrSi2buwVK/oIN3feqlc6CBv/GBslsgAskw05G/O4hzk+mvsBxZr1j5mxkaBA==;5:jR0hOEerWDQB8wWj6knW07pihGCOYTpKZd9R6LpYtB8nXpnKRNs90Vml2qW2g6rNC3ATi0fN4CPCOJPfrNXwgdAwvKepQHhRKOh9smpoSX4MuOeOVPfBwHqzsLNmPw40LBzSGBKtWDKx74s5n7nt83CskxQmU865X90S8Cfk7bo=;7:kFsY3RXxw5pYVVrZRpjGbuQeZCnBZJ1cJinFa2i3+tw2atpRweILSREJ7agy7WCNT65pRoOmExgIomUDIg5tzeb0PVb7boGii2JifkxDn+sYmCLtRnCqzckfoiCFYvf5BqAUPi91yCTyKI4NR6B8Wg==
x-ms-office365-filtering-correlation-id: 63f3dee0-1d4b-4c74-dc22-08d63e553f80
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5509;
x-ms-traffictypediagnostic: BYAPR07MB5509:
x-microsoft-antispam-prvs: <BYAPR07MB5509957C7ED52995968FFAB6F9CC0@BYAPR07MB5509.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB5509;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5509;
x-forefront-prvs: 08417837C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(366004)(189003)(199004)(5250100002)(305945005)(256004)(54906003)(6436002)(110136005)(5660300001)(7736002)(53936002)(316002)(107886003)(6486002)(6512007)(86362001)(575784001)(66066001)(25786009)(4326008)(105586002)(36756003)(106356001)(2900100001)(8936002)(478600001)(8676002)(68736007)(81156014)(81166006)(486006)(71200400001)(71190400001)(2616005)(476003)(6506007)(99286004)(6116002)(26005)(52116002)(2906002)(14454004)(14444005)(386003)(72206003)(2501003)(186003)(102836004)(3846002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5509;H:BYAPR07MB4920.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: c7v2IfpNrj8vys0A0i3qxpFUvos2F6yRe7zJjy7ogH3hHkjkKW9pzAPUQoYviZLqA1DWLZB2BSqfauz4OC8PtAQLTnC1O0EjTlTi8A+oVkZ8OrCATEmXvlnuvV9Sk9Hd72q8XTmaM/5pekaXvo3Gk6iMF0IicTb3NNIKz3vam/iuMnOLPg1qKhX6EER25FSCRfRhFujWnTxJeQFRZKhYBJePEfWWwcguamZ8Twq/SLKwnUi937wH9HgWOBwJwr3bjffNHmOelg4HiBcpEp1aQuJoFEAXvPFGojWtNCWsPEaJIaxBkWEag+ck3VsBh+bls82MFMFoEHa2VnUc6nfczKTKebKMrQC1HB7AUo52Nxw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f3dee0-1d4b-4c74-dc22-08d63e553f80
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2018 10:48:38.1336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5509
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement workaround for ThunderX2 Errata-129 (documented in
CN99XX Known Issues" available at Cavium support site).
As per ThunderX2errata-129, USB 2 device may come up as USB 1
if a connection to a USB 1 device is followed by another connection to
a USB 2 device, the link will come up as USB 1 for the USB 2 device.

Resolution: Reset the PHY after the USB 1 device is disconnected.
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
index f0a99aa..b434869 100644
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
+ * As per ThunderX2errata-129 USB 2 device may come up as USB 1
+ * If a connection to a USB 1 device is followed by another connection
+ * to a USB 2 device.
+ *
+ * Reset the PHY after the USB device is disconnected if device speed
+ * is less than HCD_USB3.
+ * Retry the reset sequence max of 4 times checking the PLL lock status.
+ *
+ */
+static void xhci_cavium_reset_phy_quirk(struct xhci_hcd *xhci)
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
+		if ((xhci->quirks & XHCI_RESET_PLL_ON_DISCONNECT) &&
+		    (portsc & PORT_CSC) && !(portsc & PORT_CONNECT))
+			xhci_cavium_reset_phy_quirk(xhci);
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


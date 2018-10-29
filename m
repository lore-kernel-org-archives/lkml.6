Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F23BC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2380D2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="h0QAjUei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2380D2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeJ3BoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:44:04 -0400
Received: from mail-dm3nam03on0080.outbound.protection.outlook.com ([104.47.41.80]:22704
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726613AbeJ3BoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvlQTdrb2B0ZrHy7UCupdQHfuSz1VDJzwr3prwB4VoM=;
 b=h0QAjUeiJaP6g7YoQuEy4ERJLTtmSshhScjMIy5eSrZd136zq7T2YJFMHC1YlcIqOR2EfrRkH0Ng6pvto1hIlXbPQOsKDuXFHwFzxxVawxE9Y0Nudytr4Hes0QZGAmyXsBGNwNqC/rUwottom9wIbsgcONwq5xwcXaLPwKED8cg=
Received: from BYAPR07MB4920.namprd07.prod.outlook.com (52.135.237.93) by
 BYAPR07MB5269.namprd07.prod.outlook.com (20.177.124.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.25; Mon, 29 Oct 2018 16:54:34 +0000
Received: from BYAPR07MB4920.namprd07.prod.outlook.com
 ([fe80::69f7:b92b:5107:d9e5]) by BYAPR07MB4920.namprd07.prod.outlook.com
 ([fe80::69f7:b92b:5107:d9e5%4]) with mapi id 15.20.1273.027; Mon, 29 Oct 2018
 16:54:34 +0000
From:   "Cherian, George" <George.Cherian@cavium.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "Cherian, George" <George.Cherian@cavium.com>
Subject: [PATCH v2] xhci: Add quirk to workaround the errata seen on Cavium
 Thunder-X2 Soc
Thread-Topic: [PATCH v2] xhci: Add quirk to workaround the errata seen on
 Cavium Thunder-X2 Soc
Thread-Index: AQHUb6gROG15BNorrku1gifnx4EBww==
Date:   Mon, 29 Oct 2018 16:54:34 +0000
Message-ID: <1540832062-22224-1-git-send-email-george.cherian@cavium.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0020.namprd08.prod.outlook.com
 (2603:10b6:a03:100::33) To BYAPR07MB4920.namprd07.prod.outlook.com
 (2603:10b6:a03:55::29)
x-originating-ip: [50.233.148.155]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5269;6:ArvITeMqyjvB9HO3hPVbsPONHGokjLS2dMbo7CvoPk0vcKWNvLI1s5WcVHNLYUusydr5R+/rPIKe3uWVfBROQH6+4Epu61qBPZJqXRfJmh2PFpupW0o+IL/m3nr2ibvIlpTObYVklxcPf6MzlCaDxecTSa0aY4jwaBpYuJ1diu0heNnOgpcdBm3KXxssEjMKkkMYyYHbxLhQKIN/IwCNTObcmirS4xHreLsrxbDiSpoLITMbp4Y690AOxBJXQuJeN8fVX5MMq1zEwmkFvZ2Rl5nDZGgMl7HOHniSHpjHvP++mNSs8Hq3BCyb9eksK0Yqp5kznqP+swsOtoJlRWXR8XKbqS8q1eP4Dk6LUmov3TfPTxF6A6tLaUAsFEkIufL1nIvQCryuN6IkBfZ1HbE7TPGciVs0dqErV8KdhPAv9zjIWYagU6nXNvJz9uP6Nd4LVOIuHcGeYCNySnyBIzLVgA==;5:q8aKaicaunWEQScF7WGneenKJVx7ME4/DthkFqUcK9QkwDs8VEFewgboXZRjCeRpi71PmQUbqotqS6QMn60MQoV/dhjerT0KpdOkDlgGdEONsNfhw0L39Qf5AhzHlPa9cOMiQN4j0kIR4RKq7MqoH7ZT4cp2vExgruk+gePXqYI=;7:cBuFqtolYe6tLNjdh1uRyiFNqtkq95GoDs5xZaxfOyr5qj5bpkquCvDG93Kn6gDa5lLajVDyXF52QsPX3ioVIPJjIeGWQYWy8pTF77GlfcEZNQ0NZ7YoMWadG0zArzsQBY4gBskLpF3L88JiK6mkdg==
x-ms-office365-filtering-correlation-id: 3d8d0022-43d8-4ce8-aab5-08d63dbf33f1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5269;
x-ms-traffictypediagnostic: BYAPR07MB5269:
x-microsoft-antispam-prvs: <BYAPR07MB5269F2BAE97ED26E40783268F9F30@BYAPR07MB5269.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB5269;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5269;
x-forefront-prvs: 084080FC15
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(39860400002)(376002)(136003)(189003)(199004)(386003)(99286004)(8676002)(6506007)(52116002)(102836004)(478600001)(186003)(81156014)(575784001)(8936002)(81166006)(107886003)(305945005)(86362001)(26005)(3846002)(6486002)(5250100002)(14444005)(316002)(256004)(6436002)(6512007)(4326008)(54906003)(53936002)(97736004)(66066001)(110136005)(6116002)(71200400001)(71190400001)(2906002)(105586002)(36756003)(25786009)(5660300001)(72206003)(2616005)(14454004)(476003)(106356001)(68736007)(2501003)(486006)(2900100001)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5269;H:BYAPR07MB4920.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vBUdZaWp+jfcTQQQRGbkEb+nkAIOzBJ1WfzBIpuVV5jfYV3IiGvCkwDbQQ4OTsW+MGeML+LQgn74/OmiN6IwEre/iMQdKKG0Oa5wKLp2NfP0eDoXjHlaxVMpanFP0QDi9JeBS1okvjzb5Y8vE/CQgCfaof9s3042EyPo4gi6LKqWIrhcfaLbe5U2AyLMBz9uyHq1RyPGtRu3JJk+7B1pYthzXd4/u48iU6gEAeEo/kttIT85Pznou3RFOZtDjWIoX0hU7z9b7oBEdGk7JWe457hVWJObFrRmT24j8SaMd7fquQAfqg0vkCD3P4rQ66BeHPrARAg7EWebLO0A46HlfR3kxhCt1HnSf8qYq4ymwdg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8d0022-43d8-4ce8-aab5-08d63dbf33f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2018 16:54:34.2152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5269
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
index f0a99aa..342dd5ac 100644
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


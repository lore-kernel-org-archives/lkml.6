Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC78C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 04:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C761F20820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 04:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C761F20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389289AbeKVPAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 10:00:38 -0500
Received: from mail-eopbgr690045.outbound.protection.outlook.com ([40.107.69.45]:63552
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729080AbeKVPAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 10:00:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42wj3Bs5Hoxbj1tI852KkSvhwOKPvZG2dNc92uOwPcA=;
 b=v2U7D2m6dlw3xwKkCK2h0qHVmetFWTpR4OB+lGZMKJ87fnAI3XbyjhphlInrtN18WgfE4UXrcHh0tk/GBTOiMnw+iJUMG8itUy6oQLrl6U+B4MXS7/doXhf/IGmONkWyRH2tesAXTuVOdD2oeI3+WLZb8oNvJy2pwen1HzuxRYg=
Received: from BN6PR12MB1649.namprd12.prod.outlook.com (10.172.19.12) by
 BN6PR12MB1667.namprd12.prod.outlook.com (10.172.19.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Thu, 22 Nov 2018 04:23:02 +0000
Received: from BN6PR12MB1649.namprd12.prod.outlook.com
 ([fe80::d0c7:6cbd:851b:d487]) by BN6PR12MB1649.namprd12.prod.outlook.com
 ([fe80::d0c7:6cbd:851b:d487%3]) with mapi id 15.20.1339.029; Thu, 22 Nov 2018
 04:23:02 +0000
From:   "Singh, Sandeep" <Sandeep.Singh@amd.com>
To:     "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Singh, Sandeep" <Sandeep.Singh@amd.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Singh, Sandeep" <Sandeep.Singh@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
Subject: [PATCH v2] xhci: workaround CSS timeout on AMD SNPS 3.0 xHC
Thread-Topic: [PATCH v2] xhci: workaround CSS timeout on AMD SNPS 3.0 xHC
Thread-Index: AQHUghsO3ddM6jhDFUGc6Lr8yr9U0Q==
Date:   Thu, 22 Nov 2018 04:23:02 +0000
Message-ID: <1542860548-3109-1-git-send-email-Sandeep.Singh@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::17) To BN6PR12MB1649.namprd12.prod.outlook.com
 (2603:10b6:405:6::12)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1667;20:u940XmmQO3sax7b5L/iRxt5YX4dwO1OPbUAc5ljSNVUDlntBDIjGpDOVNAqchBZKSMdFiR9PL0v23GnaJIfNJzG50eS0VuUrkha1DIR8cCzgFqESTAa3evSZk2YSCw0NS/gzI4D1zDOv8GCVoBSix+byehJn1eUCZ7ZbHC0byJrDTrV39qVUtQEeOlPRi/IjxBakHv9TSjkRcdfJ9x/5tLsKRf7/j11qyvMckT54NKklEDIkUgNtCosiiVfibKrJ
x-ms-office365-filtering-correlation-id: 1c6575fe-a9c9-45ab-659d-08d65032307b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1667;
x-ms-traffictypediagnostic: BN6PR12MB1667:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sandeep.Singh@amd.com; 
x-microsoft-antispam-prvs: <BN6PR12MB1667F6F05D70AA7C4FB3A554E0DB0@BN6PR12MB1667.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231442)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BN6PR12MB1667;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1667;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(396003)(376002)(39860400002)(189003)(199004)(5660300001)(14444005)(106356001)(256004)(217873002)(4326008)(105586002)(26005)(53936002)(2906002)(305945005)(6506007)(386003)(2616005)(476003)(66066001)(486006)(7736002)(99286004)(6486002)(2201001)(575784001)(86362001)(52116002)(2900100001)(8676002)(14454004)(8936002)(6116002)(3846002)(81156014)(81166006)(102836004)(316002)(110136005)(54906003)(6436002)(72206003)(2501003)(97736004)(71190400001)(71200400001)(36756003)(68736007)(186003)(478600001)(25786009)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1667;H:BN6PR12MB1649.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OvR09XTRWEY7o85uP3NWksKk9HzMi+tDUNjMbSREGHGrbF86WLIgUYv5jQDG4cXTaXKoA8sI60DEmdBUaolzf58DhD9QWR09Jp50wgsXRQHiyhBtllngDWz2l9JVP8sW8XD9GVdKLt1wM4fJCDzPq1Ny+WwoDz1EBXGBshXqrYi6GLX+CFnx3cIJcxdxKcgheKXi4Co0fSriDnlt38pnof456f1Ue5UOKkGiHR5EbfRwSIlzr9jlcrnvul9g3oIRRqYolhDNIjoBWN25r7Hswa6pB+6PGjNcLUgX0xFagaenb/h9EQPXLDB+WOsQr/dZP1NYdeoWZWy80tPOrQaJ73TtJSHF+H9vsHtOQj48spA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6575fe-a9c9-45ab-659d-08d65032307b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 04:23:02.1832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1667
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandeep Singh <sandeep.singh@amd.com>

Occasionally AMD SNPS 3.0 xHC does not respond to
CSS when set, also it does not flag anything on SRE and HCE
to point the internal xHC errors on USBSTS register. This stalls
the entire system wide suspend and there is no point in stalling
just because of xHC CSS is not responding.

To work around this problem, if the xHC does not flag
anything on SRE and HCE, we can skip the CSS
timeout and allow the system to continue the suspend. Once the
system resume happens we can internally reset the controller
using XHCI_RESET_ON_RESUME quirk

Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Signed-off-by: Sandeep Singh <Sandeep.Singh@amd.com>
cc: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
---
Changes since v1:

-> New Variable based decision making when SNPS issue happens hence=20
   quirk interdependency removed.
-> Removed STS conditional check in suspend function.

 drivers/usb/host/xhci-pci.c |  4 ++++
 drivers/usb/host/xhci.c     | 26 ++++++++++++++++++++++----
 drivers/usb/host/xhci.h     |  3 +++
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 01c5705..72493c4 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -139,6 +139,10 @@ static void xhci_pci_quirks(struct device *dev, struct=
 xhci_hcd *xhci)
 		 pdev->device =3D=3D 0x43bb))
 		xhci->quirks |=3D XHCI_SUSPEND_DELAY;
=20
+	if (pdev->vendor =3D=3D PCI_VENDOR_ID_AMD &&
+	    (pdev->device =3D=3D 0x15e0 || pdev->device =3D=3D 0x15e1))
+		xhci->quirks |=3D XHCI_SNPS_BROKEN_SUSPEND;
+
 	if (pdev->vendor =3D=3D PCI_VENDOR_ID_AMD)
 		xhci->quirks |=3D XHCI_TRUST_TX_LENGTH;
=20
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 0420eef..808677d 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -970,6 +970,7 @@ int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup)
 	unsigned int		delay =3D XHCI_MAX_HALT_USEC;
 	struct usb_hcd		*hcd =3D xhci_to_hcd(xhci);
 	u32			command;
+	u32			res;
=20
 	if (!hcd->state)
 		return 0;
@@ -1023,11 +1024,28 @@ int xhci_suspend(struct xhci_hcd *xhci, bool do_wak=
eup)
 	command =3D readl(&xhci->op_regs->command);
 	command |=3D CMD_CSS;
 	writel(command, &xhci->op_regs->command);
+	xhci->broken_suspend =3D 0;
 	if (xhci_handshake(&xhci->op_regs->status,
 				STS_SAVE, 0, 10 * 1000)) {
-		xhci_warn(xhci, "WARN: xHC save state timeout\n");
-		spin_unlock_irq(&xhci->lock);
-		return -ETIMEDOUT;
+	/*
+	 * AMD SNPS xHC 3.0 occasionally does not clear the
+	 * SSS bit of USBSTS and when driver tries to poll
+	 * to see if the xHC clears BIT(8) which never happens
+	 * and driver assumes that controller is not responding
+	 * and times out. To workaround this, its good to check
+	 * if SRE and HCE bits are not set (as per xhci
+	 * Section 5.4.2) and bypass the timeout.
+	 */
+		res =3D readl(&xhci->op_regs->status);
+		if ((xhci->quirks & XHCI_SNPS_BROKEN_SUSPEND) &&
+		    (((res & STS_SRE) =3D=3D 0) &&
+				((res & STS_HCE) =3D=3D 0))) {
+			xhci->broken_suspend =3D 1;
+		} else {
+			xhci_warn(xhci, "WARN: xHC save state timeout\n");
+			spin_unlock_irq(&xhci->lock);
+			return -ETIMEDOUT;
+		}
 	}
 	spin_unlock_irq(&xhci->lock);
=20
@@ -1080,7 +1098,7 @@ int xhci_resume(struct xhci_hcd *xhci, bool hibernate=
d)
 	set_bit(HCD_FLAG_HW_ACCESSIBLE, &xhci->shared_hcd->flags);
=20
 	spin_lock_irq(&xhci->lock);
-	if (xhci->quirks & XHCI_RESET_ON_RESUME)
+	if ((xhci->quirks & XHCI_RESET_ON_RESUME) || xhci->broken_suspend)
 		hibernated =3D true;
=20
 	if (!hibernated) {
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index bf0b369..d5d19b2 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1849,6 +1849,7 @@ struct xhci_hcd {
 #define XHCI_INTEL_USB_ROLE_SW	BIT_ULL(31)
 #define XHCI_ZERO_64B_REGS	BIT_ULL(32)
 #define XHCI_DEFAULT_PM_RUNTIME_ALLOW	BIT_ULL(33)
+#define XHCI_SNPS_BROKEN_SUSPEND    BIT_ULL(34)
=20
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
@@ -1878,6 +1879,8 @@ struct xhci_hcd {
 	void			*dbc;
 	/* platform-specific data -- must come last */
 	unsigned long		priv[0] __aligned(sizeof(s64));
+	/* Broken Suspend flag for SNPS Suspend resume issue */
+	u8			broken_suspend;
 };
=20
 /* Platform specific overrides to generic XHCI hc_driver ops */
--=20
2.7.4


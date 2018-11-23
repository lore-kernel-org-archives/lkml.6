Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB0BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF5A20824
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="C8xInlZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF5A20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504822AbeKXDI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 22:08:59 -0500
Received: from mail-eopbgr710047.outbound.protection.outlook.com ([40.107.71.47]:24832
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387726AbeKXDI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 22:08:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFy5n2KubtmuDRKM8Wm3Ep4rDOXgAa5duvB/uLpHvUQ=;
 b=C8xInlZQFrcI04sGXNVs29ng9BUIARzff8c+ccLwAig0IX+x3sxgsFuzUpwtmHitxUAy9l4Ko4/2Z7vevG62UKsAgFlFnA0I6sOwly6oTsgYn7UhrNa2FfrnWunnx+YyBs78j0zhDlTlmgQuNmTG0QzvtM8JdfzuCVbBmqNu0+I=
Received: from BN6PR12MB1649.namprd12.prod.outlook.com (10.172.19.12) by
 BN6PR12MB1441.namprd12.prod.outlook.com (10.172.24.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.16; Fri, 23 Nov 2018 16:24:02 +0000
Received: from BN6PR12MB1649.namprd12.prod.outlook.com
 ([fe80::d9ac:970b:bfa4:198c]) by BN6PR12MB1649.namprd12.prod.outlook.com
 ([fe80::d9ac:970b:bfa4:198c%8]) with mapi id 15.20.1361.018; Fri, 23 Nov 2018
 16:24:02 +0000
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
Subject: [PATCH v3] xhci: workaround CSS timeout on AMD SNPS 3.0 xHC
Thread-Topic: [PATCH v3] xhci: workaround CSS timeout on AMD SNPS 3.0 xHC
Thread-Index: AQHUg0jxA72p3dlY80KgoZFXRNjAJg==
Date:   Fri, 23 Nov 2018 16:24:01 +0000
Message-ID: <1542990218-30495-1-git-send-email-Sandeep.Singh@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::32) To BN6PR12MB1649.namprd12.prod.outlook.com
 (2603:10b6:405:6::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sandeep.Singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1441;20:2OJFIHSi7r03Yvjlr/8ZjtVwJ/czpCLByGWIq65RnM4CPvFRZU0DmC09gRDDQOxm0gjCO/XCvk6JnDIzrjw1unXBjsrrwozsiRfrlP8bzUS8b1OSrUCt0M0PRBXHpU2sVk3QP/UflNNHH45/2pSlxmGqZVDOWncVaL0K7W69dCleP05MSIEmITEUFUKTMfOxLs4ci/RpIY3v0v3iGbA0fjoOU1PvjiIXMKF1mx1tp6/tkeFu8lLw5A9uxACU9XU6
x-ms-office365-filtering-correlation-id: 9a98f075-3106-4c8e-7812-08d651601413
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1441;
x-ms-traffictypediagnostic: BN6PR12MB1441:
x-microsoft-antispam-prvs: <BN6PR12MB144172DDE64D2F26C1229AF0E0D40@BN6PR12MB1441.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN6PR12MB1441;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1441;
x-forefront-prvs: 086597191B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(136003)(346002)(396003)(376002)(366004)(189003)(199004)(25786009)(478600001)(66066001)(72206003)(6116002)(99286004)(3846002)(2906002)(2501003)(97736004)(105586002)(106356001)(4326008)(8936002)(14454004)(53936002)(6512007)(8676002)(81156014)(81166006)(2616005)(102836004)(217873002)(6506007)(386003)(7736002)(86362001)(71190400001)(71200400001)(6486002)(186003)(2201001)(2900100001)(26005)(305945005)(6436002)(68736007)(5660300001)(256004)(36756003)(52116002)(476003)(486006)(110136005)(14444005)(54906003)(316002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1441;H:BN6PR12MB1649.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: t9V308JlMIy/WC5+LoUnVEqd9ch+qVmFbVuX7Y/R/z8VdXd6+cs4zglJFOPYsSxdt440Yx2sSU3P2a3aGZaoGKGfwGPf/k915x2Kc5GtGnDJomQQXAbjTaHgJG7sZYjdtX8b8MlxBFexCicKyAG9bN3V1I8eCZZJFwRLy4Hz98COZ90hc1UmosDz2xpFk1IroKlrm4J+05xjloO3nNq8JTKBiPzytm90f78PrjIRQpfTuzjfV3ydtNfBJHZ6RPvBn0Q0Oz6deCnFj6Kbf0VA/TgUH/3jNW2ep9KCANrO7S/TuMQv1RL5CMyNhvmK1apd1Wx2lebsDdUpehyEIaNpEKRFZf2tfmMLEdDWd0S3gPI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a98f075-3106-4c8e-7812-08d651601413
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2018 16:24:02.0503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1441
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
-> quirk interdependency removed.
-> Removed STS conditional check in suspend function.

Changes since v2:
-> Updated quirk bit as per Kai-heng comment.

 drivers/usb/host/xhci-pci.c |  4 ++++
 drivers/usb/host/xhci.c     | 26 ++++++++++++++++++++++----
 drivers/usb/host/xhci.h     |  3 +++
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index a951526..a9ec705 100644
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
index c928dbb..c20b85e 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -968,6 +968,7 @@ int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup)
 	unsigned int		delay =3D XHCI_MAX_HALT_USEC;
 	struct usb_hcd		*hcd =3D xhci_to_hcd(xhci);
 	u32			command;
+	u32			res;
=20
 	if (!hcd->state)
 		return 0;
@@ -1021,11 +1022,28 @@ int xhci_suspend(struct xhci_hcd *xhci, bool do_wak=
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
@@ -1078,7 +1096,7 @@ int xhci_resume(struct xhci_hcd *xhci, bool hibernate=
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
index 260b259..c3515ba 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1850,6 +1850,7 @@ struct xhci_hcd {
 #define XHCI_ZERO_64B_REGS	BIT_ULL(32)
 #define XHCI_DEFAULT_PM_RUNTIME_ALLOW	BIT_ULL(33)
 #define XHCI_RESET_PLL_ON_DISCONNECT	BIT_ULL(34)
+#define XHCI_SNPS_BROKEN_SUSPEND    BIT_ULL(35)
=20
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
@@ -1879,6 +1880,8 @@ struct xhci_hcd {
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


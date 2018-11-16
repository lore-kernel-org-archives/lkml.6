Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5618EC04EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 08:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EECC1208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 08:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jxClqfQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EECC1208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389389AbeKPSc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:32:27 -0500
Received: from mail-eopbgr770052.outbound.protection.outlook.com ([40.107.77.52]:8062
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727405AbeKPSc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 13:32:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdnjEBT7OQB/gPRYAmydPnUywgwcXwqAjkMQTX+rAyY=;
 b=jxClqfQ/e3FdaUnelNhvl6B33AsjSkuq8/KYCjeERpdE2eH3SEPkhaQ+j0SGDnRLvTTp/YKpcWV4omvcA2wqGX43eETwsqFMBW6kDHmTeX7NHNPILvkFg2psxiReYqQg+NNevnN5gTB7yyaQWWOIogWB09t6XiZ19fEtIWIOo3k=
Received: from BN6PR12MB1649.namprd12.prod.outlook.com (10.172.19.12) by
 BN6PR12MB1554.namprd12.prod.outlook.com (10.172.18.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Fri, 16 Nov 2018 08:21:04 +0000
Received: from BN6PR12MB1649.namprd12.prod.outlook.com
 ([fe80::d0c7:6cbd:851b:d487]) by BN6PR12MB1649.namprd12.prod.outlook.com
 ([fe80::d0c7:6cbd:851b:d487%3]) with mapi id 15.20.1294.045; Fri, 16 Nov 2018
 08:21:04 +0000
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
Subject: [PATCH] xhci: workaround CSS timeout on AMD SNPS 3.0 xHC.
Thread-Topic: [PATCH] xhci: workaround CSS timeout on AMD SNPS 3.0 xHC.
Thread-Index: AQHUfYVQ++sWkxf0UEmA/CV672PX9Q==
Date:   Fri, 16 Nov 2018 08:21:04 +0000
Message-ID: <1542356426-10299-1-git-send-email-Sandeep.Singh@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:3:18::26) To BN6PR12MB1649.namprd12.prod.outlook.com
 (2603:10b6:405:6::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sandeep.Singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1554;20:S3fR2Zr8UD/rEGXyPCWrisgI/V6tYC/qi8pLmDESGFUC4x2LqWd6DDraAr2p8DpHY8TCoa0C0JFZdQ8B5GXltqFGLyOZG6/UCBFw/UPJw4g2Nb5zRD+zWjKcEc68+YZqBAs3x/FBMYAEYXr/ipgHH87GaeT09/P+a4AViLvRf4QkKVFqHOFvYwQJIarHl7dmNd+X2jARt7KVnoqcvDuP/PLfD7aHwUHBm9mjhY/8G1orwn73ftjgK5wnAnlWwTZF
x-ms-office365-filtering-correlation-id: 4fae106b-3314-4f18-fb5d-08d64b9c72e3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1554;
x-ms-traffictypediagnostic: BN6PR12MB1554:
x-microsoft-antispam-prvs: <BN6PR12MB15547E2B88D7819893D3E653E0DD0@BN6PR12MB1554.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231415)(944501410)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BN6PR12MB1554;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1554;
x-forefront-prvs: 0858FF8026
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(366004)(136003)(39860400002)(189003)(199004)(71200400001)(105586002)(5660300001)(8676002)(71190400001)(8936002)(54906003)(6486002)(575784001)(81166006)(110136005)(4326008)(316002)(81156014)(86362001)(14454004)(68736007)(106356001)(36756003)(6512007)(2900100001)(72206003)(53936002)(2501003)(6436002)(25786009)(97736004)(6506007)(256004)(217873002)(14444005)(386003)(26005)(102836004)(1857600001)(2616005)(2906002)(52116002)(476003)(486006)(6116002)(2201001)(3846002)(7736002)(99286004)(305945005)(478600001)(66066001)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1554;H:BN6PR12MB1649.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SgyJbhGZonuNlUhhlCEfLd7ja/qe5riBZYi+0S6YXViJZYSbBf5j+aKK153Pn8HdcihgD/cpoJNyci2S3lwRXpdVSk0tAahkPKxOmdaTSuZtZTbnevUYAxP6O/Q7xiHRqv29jobXdG3VDCD70mC9ZHMwcXD6yN0CVKvi3jewgzgFBo/y7hLuhlJKVe0qK+KhO1gBVTlsAK1lK82sJJbf3+wdsiuFzaI+uC61eQ8cjj6mun+G7yJuBJ+YosV9k07NKPpQ2AEiVf51cqAvAJ91QMDMKEwtNtJMzIhHMnbygPwaxs1n0hVOKsj6n5a2q6bdqJJrVnVBcvGeYer8dgueETZe78iXBat5d8MwzdLYUMs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fae106b-3314-4f18-fb5d-08d64b9c72e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2018 08:21:04.4497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1554
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
using XHCI_RESET_ON_RESUME quirk.

Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Signed-off-by: Sandeep Singh <Sandeep.Singh@amd.com>
cc: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
---
 drivers/usb/host/xhci-pci.c |  4 ++++
 drivers/usb/host/xhci.c     | 25 +++++++++++++++++++++++++
 drivers/usb/host/xhci.h     |  1 +
 3 files changed, 30 insertions(+)

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
index 0420eef..965b503 100644
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
@@ -1025,10 +1026,32 @@ int xhci_suspend(struct xhci_hcd *xhci, bool do_wak=
eup)
 	writel(command, &xhci->op_regs->command);
 	if (xhci_handshake(&xhci->op_regs->status,
 				STS_SAVE, 0, 10 * 1000)) {
+		if (xhci->quirks & XHCI_SNPS_BROKEN_SUSPEND) {
+		       /*
+			* AMD SNPS xHC 3.0 occasionally does not clear the
+			* SSS bit of USBSTS and when driver tries to poll
+			* to see if the xHC clears BIT(8) which never happens
+			* and driver assumes that controller is not responding
+			* and times out. To workaround this, its good to check
+			* if SRE and HCE bits are not set (as per xhci
+			* Section 5.4.2) and bypass the timeout.
+			*/
+
+			res =3D readl(&xhci->op_regs->status);
+			if (res & STS_SAVE) {
+				if (((res & STS_SRE) =3D=3D 0) &&
+				    ((res & STS_HCE) =3D=3D 0)) {
+					xhci->quirks |=3D XHCI_RESET_ON_RESUME;
+					goto complete_suspend;
+				}
+			}
+		}
+
 		xhci_warn(xhci, "WARN: xHC save state timeout\n");
 		spin_unlock_irq(&xhci->lock);
 		return -ETIMEDOUT;
 	}
+ complete_suspend:
 	spin_unlock_irq(&xhci->lock);
=20
 	/*
@@ -1213,6 +1236,8 @@ int xhci_resume(struct xhci_hcd *xhci, bool hibernate=
d)
 	usb_hcd_poll_rh_status(xhci->shared_hcd);
 	set_bit(HCD_FLAG_POLL_RH, &hcd->flags);
 	usb_hcd_poll_rh_status(hcd);
+	if (xhci->quirks & XHCI_SNPS_BROKEN_SUSPEND)
+		xhci->quirks &=3D ~XHCI_RESET_ON_RESUME;
=20
 	return retval;
 }
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index bf0b369..eb99782 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1849,6 +1849,7 @@ struct xhci_hcd {
 #define XHCI_INTEL_USB_ROLE_SW	BIT_ULL(31)
 #define XHCI_ZERO_64B_REGS	BIT_ULL(32)
 #define XHCI_DEFAULT_PM_RUNTIME_ALLOW	BIT_ULL(33)
+#define XHCI_SNPS_BROKEN_SUSPEND	BIT_ULL(34)
=20
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
--=20
2.7.4


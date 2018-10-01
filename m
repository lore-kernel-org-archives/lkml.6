Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A26BC64EB0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 042482083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JG4fBxkg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 042482083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbeJAH13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:27:29 -0400
Received: from mail-dm3nam03on0101.outbound.protection.outlook.com ([104.47.41.101]:12851
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728879AbeJAHNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/DZZ1+k40ztsjKWP90IvVlnruMXcXovMVWsb4czMuc=;
 b=JG4fBxkgyvD44NAPTSHLQYCfRviUcC1GSYvoaREriu+E+KBPcjwvZXdWf6+cS8Up6ksbwHMolzRO0iMJZ50iCnvCFkguuOnI7/9nn7ROaRlN/QoUnu59Ap5z0d2VX3hhSaePg7FFnEvXf9xZuP+cI1pbuEsa1cofaqcVULq4GK8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0472.namprd21.prod.outlook.com (10.172.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:38:17 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:17 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 23/65] usb: host: xhci-plat: Iterate over parent
 nodes for finding quirks
Thread-Topic: [PATCH AUTOSEL 4.18 23/65] usb: host: xhci-plat: Iterate over
 parent nodes for finding quirks
Thread-Index: AQHUWR8LVKzMEHt2yEOWO/mwbLbJkg==
Date:   Mon, 1 Oct 2018 00:38:17 +0000
Message-ID: <20181001003754.146961-23-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0472;6:zmJkqj1OmHtq7TaAmR94E1pNvvVvpeVkjL1dMY4WVuK/6+PNRHxjR4C7cE65D1MsCf6HZcFoo6wvgCj79H4RMY2seeDbiNz2ESjt8SfCeZtql94wITwJkYQGNZRtMxhQ+QSPUJHMNSMBj+vGNgqVLFjQ5qkkbLkop4KgI4no+2r4TR+fDOfxDBOSC1bO03mNv4eA1k2hBbDEyAUVsIC8FYYwloD9rF2YN4QJSwlE3fGPVYQ3ZBMArUS+8Htsvt4ClFfiiG6DuPcnHBDCzIwBa9ANvdX9OnPaRwctCG3DbrsTkSBof22xduq+R2sDcCUfSJzJxt1RA85sll9x4J4b6Y7gs+YJt/+lSJ9IdnA66Wn82MJXo1sWf9J6CyAreuMfO+GU2wHXYAidv/qIIhoP7dHcARgZoD3yozzM1rfBXCFGugfSpYCtmNbGobn7F2aAjSPgJrHtDzMRn2CqzyhhPQ==;5:4caeqxCRgYNOS28PF9RwN09176YvIvT5Cti13oj23gl8vbZvuKlYENhTL5rqkxfbrRWLc4bLAKeWdS+Ckfw3D5L7zP7Ft6LRcipPeqChZDbmalYThrnRO6ClW9ahFPC87BNSrN/KABMkXRW7zPI3+KpZGLlaajK1fZ7jadq0S4A=;7:l5N9qhDJv+NdehfcZBxk7UMDcLcm8RD8peGaqTbAYpE9h43iTedDwOyf980AyWneHzWvXT22j1C4niAiYDMKGhaqj1xKvDeD7iIfRMQn9TlV+K/QkDoW646DnnSNYKGy+FFGHlR+DY68GPDMPWEyoDoANarRBIa7gxpJgnKNNntxQIAXOQ8gwZMpeMbTKp3Th0bP+UHJJpQEAKeIco6DWJTwqz4KrkvrckbBz6ihdpqq2qn8z5TQexke9U2rodXJ
x-ms-office365-filtering-correlation-id: d7da00c3-343e-4c68-40ba-08d627362df8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0472;
x-ms-traffictypediagnostic: CY4PR21MB0472:
x-microsoft-antispam-prvs: <CY4PR21MB047214E506525CED7A17F04AFBEF0@CY4PR21MB0472.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192813158149592)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0472;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0472;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(376002)(39860400002)(346002)(199004)(189003)(5660300001)(6486002)(8936002)(68736007)(486006)(6436002)(2616005)(6506007)(6346003)(8676002)(6512007)(81166006)(81156014)(5250100002)(6116002)(2906002)(3846002)(107886003)(2501003)(1076002)(22452003)(478600001)(102836004)(25786009)(4326008)(97736004)(10090500001)(11346002)(256004)(106356001)(105586002)(99286004)(86362001)(53936002)(316002)(71200400001)(71190400001)(305945005)(2900100001)(217873002)(7736002)(10290500003)(14454004)(34290500001)(446003)(66066001)(72206003)(110136005)(54906003)(186003)(86612001)(476003)(76176011)(26005)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0472;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: +B14rERFLSyzgs/hH8xd0WNnvACf+2jZIE6+sW7xM98RE483c8cDAQDYIq96Cmr09Hg3DF6yobalKaIJICxiWwpFptYBMVVtsjk0wt+VHxuRYCfCayJv17AQ1tiF2uVVnCYk/8BhjCKD+oOsfhf8lE3UZVNtrwEtLAuDwOgL8jHWmy8P5mp53MpP7DgBL6cjZIeBjqim9S/xicPoDQDKR4zI76PxtyVrd5EKWRJOsVEUpZRKvPuqNsep8CFlr7XznduOBbmKCV7PsDXbhvZ5LZKVbKgiEHRPPcm6uC0NO5VQfg3B1HlQevGdUf71I9D3l9FAvwJxsZsQ3unqLE6LT6cr+qp25/iiEZhI6Gc+Qv4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7da00c3-343e-4c68-40ba-08d627362df8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:17.1144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0472
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>

[ Upstream commit 222471f7640d9771a993218d825d84825adc805d ]

In xhci_plat_probe() both sysdev and pdev->dev are being used
for finding quirks. There are some drivers(like dwc3 host.c)
which adds quirks(like usb3-lpm-capable) into pdev and the logic
present in xhci_plat_probe() checks for quirks in either sysdev
or pdev for finding the quirks. Because of this logic, some of
the quirks are getting missed(usb3-lpm-capable quirk added by dwc3
host.c driver is getting missed).This patch fixes this by iterating
over all the available parents for finding the quirks. In this way
all the quirks which are present in child or parent are correctly
updated.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/usb/host/xhci-plat.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index c1b22fc64e38..b5a14caa9297 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -152,7 +152,7 @@ static int xhci_plat_probe(struct platform_device *pdev=
)
 {
 	const struct xhci_plat_priv *priv_match;
 	const struct hc_driver	*driver;
-	struct device		*sysdev;
+	struct device		*sysdev, *tmpdev;
 	struct xhci_hcd		*xhci;
 	struct resource         *res;
 	struct usb_hcd		*hcd;
@@ -272,19 +272,24 @@ static int xhci_plat_probe(struct platform_device *pd=
ev)
 		goto disable_clk;
 	}
=20
-	if (device_property_read_bool(sysdev, "usb2-lpm-disable"))
-		xhci->quirks |=3D XHCI_HW_LPM_DISABLE;
+	/* imod_interval is the interrupt moderation value in nanoseconds. */
+	xhci->imod_interval =3D 40000;
=20
-	if (device_property_read_bool(sysdev, "usb3-lpm-capable"))
-		xhci->quirks |=3D XHCI_LPM_SUPPORT;
+	/* Iterate over all parent nodes for finding quirks */
+	for (tmpdev =3D &pdev->dev; tmpdev; tmpdev =3D tmpdev->parent) {
=20
-	if (device_property_read_bool(&pdev->dev, "quirk-broken-port-ped"))
-		xhci->quirks |=3D XHCI_BROKEN_PORT_PED;
+		if (device_property_read_bool(tmpdev, "usb2-lpm-disable"))
+			xhci->quirks |=3D XHCI_HW_LPM_DISABLE;
=20
-	/* imod_interval is the interrupt moderation value in nanoseconds. */
-	xhci->imod_interval =3D 40000;
-	device_property_read_u32(sysdev, "imod-interval-ns",
-				 &xhci->imod_interval);
+		if (device_property_read_bool(tmpdev, "usb3-lpm-capable"))
+			xhci->quirks |=3D XHCI_LPM_SUPPORT;
+
+		if (device_property_read_bool(tmpdev, "quirk-broken-port-ped"))
+			xhci->quirks |=3D XHCI_BROKEN_PORT_PED;
+
+		device_property_read_u32(tmpdev, "imod-interval-ns",
+					 &xhci->imod_interval);
+	}
=20
 	hcd->usb_phy =3D devm_usb_get_phy_by_phandle(sysdev, "usb-phy", 0);
 	if (IS_ERR(hcd->usb_phy)) {
--=20
2.17.1

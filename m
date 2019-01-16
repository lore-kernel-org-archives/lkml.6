Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300DAC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF94420859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jdZYwS2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388151AbfAPGsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 01:48:17 -0500
Received: from mail-eopbgr10086.outbound.protection.outlook.com ([40.107.1.86]:46048
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728367AbfAPGsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 01:48:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cX+kK5GdLq7GvxWkkLSXF8AZKbQROjISI9E+V2lw6Co=;
 b=jdZYwS2iRcA3t9e8K/bo4afGk5iSzOdgpnyNrY9zUwSdBs7fyn91XcCgSXqeiWpEkzNhTqWgxMGBIHpEjsumuRyOpyB1FQm23OUYOKbs453Hs/pYu4L9jG5UuVfXT3PcDY8i6t+EWorXMUmsj2RLFB/Uin8f5ocIlmd15F3zntY=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) by
 AM5PR0402MB2785.eurprd04.prod.outlook.com (10.175.41.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Wed, 16 Jan 2019 06:48:10 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626%2]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 06:48:09 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH 2/2] usb: dwc3: Add workaround for host mode VBUS glitch when
 boot
Thread-Topic: [PATCH 2/2] usb: dwc3: Add workaround for host mode VBUS glitch
 when boot
Thread-Index: AQHUrWdx3CIJLXThzk+kTWUVQ+nAhw==
Date:   Wed, 16 Jan 2019 06:48:09 +0000
Message-ID: <20190116064820.20007-3-ran.wang_1@nxp.com>
References: <20190116064820.20007-1-ran.wang_1@nxp.com>
In-Reply-To: <20190116064820.20007-1-ran.wang_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0077.apcprd03.prod.outlook.com
 (2603:1096:203:72::17) To AM5PR0402MB2865.eurprd04.prod.outlook.com
 (2603:10a6:203:99::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0402MB2785;6:0iABeXupRRQxDEqSnEDDaDf3/YljM3KlgoqY51I5dB2HesQoLf0gdyulFfqvYUsjpvsenKGRM7LG9jfPCzz0kR+ClaFM3NSc3MfRcOZIcRVKNJKfc6FLSw9A8zC9VFav9a0qLhjJ44G3EhuKULzstr8me6sooXnenb8P9ZYof6E2gcmap9eFB42UQ3pELk+4/ZLlbrFMzcS/VwuZxytKfTdBjvIE/BoKaURMEEDFizGnlnXdoaWVcnCF50mrKStAJJk2qNZMDgQnrrSHlMsJT+MVSMdb7AC/74C7qgsD9OxXI5zB6MYIA4PK4HQ9oYqYLgMb54SNrQqJn5ppfRPrCZx5z+2/HH+9K+PbmKkSx1uRU9DpmknoUpSWZZAZV4CFmhy3N1oVUsGvf2F8aI0wjnSMgfxWOl6KOs4EJuMel9GkGFv74XRLte7/mUQfQYjGLw5wfl+4KKKiJsUAt9FV+Q==;5:xRRHUam6txv03TKq21ZK1sLuiTFPigi3rF6av5Q3t6lCUKUGji05Y412cPfugMYUADaoxBykNdGQIr7agEuNWQXp+OVAOQ3Fak74IdJIhpTaQzalQrj9FcIYiIjGYQjh39JXXi0ctNSUoR7Ik1pid0cVKYzIz2r3Tct4N79xeN6fvsHUhkO4XsDnr1yzOlebJeqS/BqtfVgTVP6HbwDB6w==;7:Nn/FAiS645cIhzmEbSVwoiYrF1dosE+pmxykkoGVDDxPwavCScbyVClSDcZ/+SZRevmhEX60or8a4MR1EIsRIeXXEeSD0gCU28lqLqgGnfvj955P1XgUWWozx/Ad4QFJM8/iKG1jc3jrPXr3GulDrA==
x-ms-office365-filtering-correlation-id: 8a1d47b0-47bc-4fd7-ea00-08d67b7e93db
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0402MB2785;
x-ms-traffictypediagnostic: AM5PR0402MB2785:
x-microsoft-antispam-prvs: <AM5PR0402MB2785269CCFDAFDE7B14722C6F1820@AM5PR0402MB2785.eurprd04.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(366004)(189003)(199004)(106356001)(105586002)(5660300001)(99286004)(6436002)(6486002)(6512007)(52116002)(76176011)(316002)(54906003)(110136005)(486006)(446003)(11346002)(2616005)(476003)(36756003)(186003)(1076003)(71200400001)(71190400001)(25786009)(4326008)(256004)(386003)(102836004)(26005)(6506007)(66066001)(53936002)(97736004)(86362001)(68736007)(478600001)(14454004)(50226002)(7736002)(2906002)(305945005)(6116002)(3846002)(8936002)(81166006)(8676002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2785;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2cTTEWPH/whbBNBeeCvqb/pcDxkd3b6QMmBhYRrFrYaqGGbpkzu8zC/iPRfCx7Ojm4eaYtWHnbbgKKla+pXrkwqSR7AsuAEVp3LpwQMtIJlffJxTOTUoAwzvcuEHkPdUXaqIiqJtB2QHO29Sp2e2dIQ5fiAbhYAoYled9zNU/ovSMa7n+Qtx+k2qdbaT6nS2lvvxadFvOqEhdxIZEjpIU+yUSsTPALh+Fmm4I9KCQmuKWw3Mv0RM23zfqO0wt00X2dppQ8IcgAGnqFYHxKYd4Bz/xp1JH70U540rE8V8hRRpRrDMUh+b7+YTd/k0/RygED+fKHRNthIZY8fYEGp76tAreceyRdgAfyweM6PCXnKPFPueh30Qk/uw6h+2zeQ/DHlnbMBcZmhpcu1msDKKHFIRD0mX+Nqd2s5vzGXmlQs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1d47b0-47bc-4fd7-ea00-08d67b7e93db
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 06:48:06.8059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2785
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When DWC3 is set to host mode by programming register DWC3_GCTL, VUBS
(or its control signal) will be turned on immediately on related Root Hub
ports. Then, the VUBS is turned off for a little while(15us) when do xhci
reset (conducted by xhci driver) and back to normal finally, we can
observed a negative glitch of related signal from scope.

This VBUS glitch might cause some USB devices enumeration fail if kernel
boot with them connected. Such as LS1012AFWRY/LS1043ARDB/LX2160AQDS
/LS1088ARDB with Kingston 16GB USB2.0/Kingston USB3.0/JetFlash Transcend
4GB USB2.0 drives. The fail cases include enumerated as full-speed device
or report wrong device descriptor, etc.

One SW workaround which can fix this is to program all xhci PORTSC[PP]
to 0 to turn off VBUS immediately after setting host mode in DWC3 driver
(per signal measurement result, it will be too late to do it in
xhci-plat.c or xhci.c). Then, after xhci reset complete in xhci driver,
PORTSC[PP]s' value will back to 1 automatically and VBUS on at that time,
no glitch happen and normal enumeration process has no impact.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
 drivers/usb/dwc3/core.c |   47 +++++++++++++++++++++++++++++++++++++++++++=
++++
 drivers/usb/dwc3/core.h |   10 +++++++++-
 2 files changed, 56 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index a1b126f..1508397 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -100,6 +100,41 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
 	return 0;
 }
=20
+/*
+ * dwc3_power_of_all_roothub_ports - Power off all Root hub ports
+ * @dwc3: Pointer to our controller context structure
+ */
+static void dwc3_power_off_all_roothub_ports(struct dwc3 *dwc)
+{
+	int i, port_num;
+	u32 reg, op_regs_base, offset;
+	void __iomem		*xhci_regs;
+
+	/* xhci regs is not mapped yet, do it temperary here */
+	if (dwc->xhci_resources[0].start) {
+		xhci_regs =3D ioremap(dwc->xhci_resources[0].start,
+				DWC3_XHCI_REGS_END);
+		if (IS_ERR(xhci_regs)) {
+			dev_err(dwc->dev, "Failed to ioremap xhci_regs\n");
+			return;
+		}
+
+		op_regs_base =3D HC_LENGTH(readl(xhci_regs));
+		reg =3D readl(xhci_regs + XHCI_HCSPARAMS1);
+		port_num =3D HCS_MAX_PORTS(reg);
+
+		for (i =3D 1; i <=3D port_num; i++) {
+			offset =3D op_regs_base + XHCI_PORTSC_BASE + 0x10*(i-1);
+			reg =3D readl(xhci_regs + offset);
+			reg &=3D ~PORT_POWER;
+			writel(reg, xhci_regs + offset);
+		}
+
+		iounmap(xhci_regs);
+	} else
+		dev_err(dwc->dev, "xhci base reg invalid\n");
+}
+
 void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
 {
 	u32 reg;
@@ -109,6 +144,15 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
 	reg |=3D DWC3_GCTL_PRTCAPDIR(mode);
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
=20
+	/*
+	 * We have to power off all Root hub ports immediately after DWC3 set
+	 * to host mode to avoid VBUS glitch happen when xhci get reset later.
+	 */
+	if (dwc->avoid_vbus_glitch_when_set_host) {
+		if (mode =3D=3D DWC3_GCTL_PRTCAP_HOST)
+			dwc3_power_off_all_roothub_ports(dwc);
+	}
+
 	dwc->current_dr_role =3D mode;
 }
=20
@@ -1306,6 +1350,9 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	dwc->dis_metastability_quirk =3D device_property_read_bool(dev,
 				"snps,dis_metastability_quirk");
=20
+	dwc->avoid_vbus_glitch_when_set_host =3D device_property_read_bool(dev,
+				"snps,avoid-vbus-glitch-when-set-host");
+
 	dwc->lpm_nyet_threshold =3D lpm_nyet_threshold;
 	dwc->tx_de_emphasis =3D tx_de_emphasis;
=20
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index df87641..691093b 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -606,6 +606,14 @@
 #define DWC3_OSTS_VBUSVLD		BIT(1)
 #define DWC3_OSTS_CONIDSTS		BIT(0)
=20
+/* Partial XHCI Register and Bit fields for quirk */
+#define XHCI_HCSPARAMS1		0x4
+#define XHCI_PORTSC_BASE	0x400
+#define PORT_POWER			(1 << 9)
+#define HCS_MAX_PORTS(p)	(((p) >> 24) & 0x7f)
+#define XHCI_HC_LENGTH(p)	(((p)>>00)&0x00ff)
+#define HC_LENGTH(p)		XHCI_HC_LENGTH(p)
+
 /* Structures */
=20
 struct dwc3_trb;
@@ -1209,6 +1217,7 @@ struct dwc3 {
 	unsigned		tx_de_emphasis:2;
=20
 	unsigned		dis_metastability_quirk:1;
+	unsigned		avoid_vbus_glitch_when_set_host:1;
=20
 	u16			imod_interval;
 };
@@ -1217,7 +1226,6 @@ struct dwc3 {
 #define INCRX_UNDEF_LENGTH_BURST_MODE 1
=20
 #define work_to_dwc(w)		(container_of((w), struct dwc3, drd_work))
-
 /* -----------------------------------------------------------------------=
--- */
=20
 struct dwc3_event_type {
--=20
1.7.1


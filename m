Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1B3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0711D217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nN2zBytr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfBZG7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:59:31 -0500
Received: from mail-eopbgr150075.outbound.protection.outlook.com ([40.107.15.75]:30279
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725901AbfBZG7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 01:59:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgatY6+ele6liTiC6HYrjOF2RxfbtJYBdcv0TgWetQ0=;
 b=nN2zBytriSckXJ1l1J9B7AiXa4Tb10SSxcrtqITQu/VAIp41zJPxOYJAZGR6GwSulzl1Yw9aTiG7hWSz1SOnF4aqQa4T7KaxvZGDFuuQKP0EbZN0pDUK3kJJkpm4ovjDR444dATS5ReUdbSyijzRHiz0VIfBgmwNja7zCaO02r8=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) by
 AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Tue, 26 Feb 2019 06:59:25 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::54f5:3bc4:9018:f123]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::54f5:3bc4:9018:f123%6]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 06:59:25 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>, Yang Li <pku.leo@gmail.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH v3 2/2] usb: dwc3: Add workaround for host mode VBUS glitch
 when boot
Thread-Topic: [PATCH v3 2/2] usb: dwc3: Add workaround for host mode VBUS
 glitch when boot
Thread-Index: AQHUzaDPFcJ4hglFSU2evLYpi8IQfw==
Date:   Tue, 26 Feb 2019 06:59:25 +0000
Message-ID: <20190226070016.27372-2-ran.wang_1@nxp.com>
References: <20190226070016.27372-1-ran.wang_1@nxp.com>
In-Reply-To: <20190226070016.27372-1-ran.wang_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR01CA0065.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::29) To AM5PR0402MB2865.eurprd04.prod.outlook.com
 (2603:10a6:203:99::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 171a8fd2-ab6c-4202-5af3-08d69bb7f166
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0402MB2865;
x-ms-traffictypediagnostic: AM5PR0402MB2865:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM5PR0402MB2865;23:0uVMABUq7Y5e8woi/Da+OzmPtsrasIcepsLxm?=
 =?iso-8859-1?Q?DNsoGV8BHyzHzAixhv2J2kHmYjBWZ+H3ZGkLA+C2Dcqio8C5Ouj+wPvLkn?=
 =?iso-8859-1?Q?5WNnGt5uDrdQx1lhUSV/emMahRIB4EHv35phhIHS+vX7Vge/vtptub8ZnR?=
 =?iso-8859-1?Q?BOn9g5XBXlaIRdtg/PmQDUbjme2L+eUVHy8XA1x1XcRFkC9mQaWA63K7Tl?=
 =?iso-8859-1?Q?OGg6X8RLr/0OLXxiuTzWUZR4UKix0Zky2FSXFZE/mtlIbrr1b5TguHMGVg?=
 =?iso-8859-1?Q?FZgPJEySpXwtmdTQ/EqY1I1ddixjTCcQR9o9akND11llcWJkMpfhzilX+y?=
 =?iso-8859-1?Q?NXEyIAEFO/Tq71rnZw1oOh3XbVYdt7wXAmMu1iEz+Ygvr/d8YocGfSWRCO?=
 =?iso-8859-1?Q?DF5+3NA1KmjaPrVmQ6PuUTBaclTC10B6IFCRi8YRxVjvRHF3opyfWZl4iP?=
 =?iso-8859-1?Q?YvNmKcSDVpDtHAH8I3N0Waae5mnVuCUxMXrZxQZzVGV/00WVrrzWz3PaPP?=
 =?iso-8859-1?Q?rhWbPMsJNyRuNNC00koOh5RaslA2G0wlCyLJmsqGXnfIeiTN4gt2CTqp0T?=
 =?iso-8859-1?Q?m5JAlARCcr3mFwDCCTyrSQjj7q7DUHKdihW5tpev8LSnedTnV2Xd/AMOch?=
 =?iso-8859-1?Q?JyoPEZfJvE4ZByVLmIqAZN+mpQv+fifA+vfGtVbPxKU9VK8vNrel/GFSfU?=
 =?iso-8859-1?Q?AE5ZD5fAk3+s9ng+QIeEdrDpNUpOFRHvosHb1XIkr9n57VM4IqXR9NJ7DR?=
 =?iso-8859-1?Q?4fjL0caq3YC3WKmnrtNtjf/PC0ArZxstomdh3X1AAby4+fXde380oJNDel?=
 =?iso-8859-1?Q?9w6V39Basmfg59S6Itc5x9GWiQZIdG+v+1RoMozuw5ULLNIiNn6ghz31IG?=
 =?iso-8859-1?Q?4EqnLnSS+PGAIhn697N+782t0rbb/vaAiR2MR+ztysDwF3T1Wl5DI1OzP9?=
 =?iso-8859-1?Q?Tz5IfdtYhC5qUeWqHpXzPu8jPQ/hLfsD87DsTGU7Iaqio/IzZ7sqKi8HCQ?=
 =?iso-8859-1?Q?UjGv5FEf0vD2M0HiKuYsgW4uhx2GkoWwcR96TbH1ruaB5J2A5vuxI+DR/5?=
 =?iso-8859-1?Q?/BOxgxwrcV1968ZKoqWk1Dat0zRAC+Hl5eGRBIbCbHGyU/ILRrXe2bK+hb?=
 =?iso-8859-1?Q?ZaF1rzQgku15paeNnW4IZyLP5bOTIrm1Cj/EBbSZe9byCPLJIrHGMNlll+?=
 =?iso-8859-1?Q?Rq6UaSDabIvEe+tg+v/0dcXnhK9jzRqWY5limMcoqgJ9duXzCjd6d7TtuK?=
 =?iso-8859-1?Q?jxL4zAyGC5ODsgY7mdE?=
x-microsoft-antispam-prvs: <AM5PR0402MB28650DC9A159A1E84BB7C101F17B0@AM5PR0402MB2865.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(136003)(376002)(346002)(189003)(199004)(86362001)(25786009)(478600001)(316002)(14454004)(8676002)(66066001)(305945005)(6436002)(4326008)(8936002)(7736002)(50226002)(71190400001)(3846002)(6116002)(5660300002)(71200400001)(81166006)(81156014)(1076003)(486006)(68736007)(105586002)(2616005)(476003)(11346002)(106356001)(76176011)(110136005)(99286004)(6512007)(53936002)(256004)(97736004)(186003)(6486002)(36756003)(26005)(102836004)(446003)(54906003)(2906002)(6506007)(386003)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2865;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 08S+nFlHR+bFLdgjup/Tu+/srbWol6SOgpJQvbckHoa5LgDedPHYAJxCqexoZ5tNiBAbi6iJLuIj4K4BRezndk0pJX0WDiMYBc18fNKFeP2DfI3F72xCfacnCEIZgUlOC1MTD6TSe9DAAAJ1k3zHhL1wx7ihTDljlJ6afnJHvObz26qh0n9Udikhvip9b7DY3kffvGEynz4DFBBXk6m/xqZM+yvZeLys3zK3JcOItT1VkSRW7Jjz7M351gGNGxw0gC9KFw8xQ1LRE8Kr+fAWLmtXyYdHROYnTI/n32cGT5GB+w0IHqO3oNsQbc1e4L7g1nim5qIEuZPI9812+JSulwkzefqDJPQqNTy8qN6rMJhKmYeEJ5hPVKg5InuWmFLm6kpdk6J0HTEA46BbEKUkWTHXk8eaw/+Xgr6fE7fncxg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 171a8fd2-ab6c-4202-5af3-08d69bb7f166
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 06:59:21.9535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2865
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When DWC3 is set to host mode by programming register DWC3_GCTL, VBUS
(or its control signal) will be turned on immediately on related Root Hub
ports. Then, the VBUS is turned off for a little while(15us) when do xhci
reset (conducted by xhci driver) and back to normal finally, we can
observe a negative glitch of related signal happen.

This VBUS glitch might cause some USB devices enumeration fail if kernel
boot with them connected. Such as LS1012AFWRY/LS1043ARDB/LX2160AQDS
/LS1088ARDB with Kingston 16GB USB2.0/Kingston USB3.0/JetFlash Transcend
4GB USB2.0 drives. The fail cases include enumerated as full-speed device
or report wrong device descriptor, etc.

One SW workaround which can fix this is by programing all xhci PORTSC[PP]
to 0 to turn off VBUS immediately after setting host mode in DWC3 driver
(per signal measurement result, it will be too late to do it in
xhci-plat.c or xhci.c). Then, after xhci reset complete in xhci driver,
PORTSC[PP]s' value will back to 1 automatically and VBUS on at that time,
no glitch happen and normal enumeration process has no impact.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
Changes in v3:
  - Add macro PORT_REGS_SIZE to replace 0x10
  - Change initial value of i to 0 for the for loop
  - Cosmetic changes

Changes in v2:
  - Rename related property to 'snps,host-vbus-glitches'
  - Rename related dwc member to 'host_vbus_glitches'
  - Add member 'host_vbus_glitches' description in 'dwc3'

 drivers/usb/dwc3/core.c |   48 +++++++++++++++++++++++++++++++++++++++++++=
++++
 drivers/usb/dwc3/core.h |   12 +++++++++++
 2 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index a1b126f..dd80e3d 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -100,6 +100,42 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
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
+		for (i =3D 0; i < port_num; i++) {
+			offset =3D op_regs_base + XHCI_PORTSC_BASE +
+				PORT_REGS_SIZE * i;
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
@@ -109,6 +145,15 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
 	reg |=3D DWC3_GCTL_PRTCAPDIR(mode);
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
=20
+	/*
+	 * We have to power off all Root hub ports immediately after DWC3 set
+	 * to host mode to avoid VBUS glitch happen when xhci get reset later.
+	 */
+	if (dwc->host_vbus_glitches) {
+		if (mode =3D=3D DWC3_GCTL_PRTCAP_HOST)
+			dwc3_power_off_all_roothub_ports(dwc);
+	}
+
 	dwc->current_dr_role =3D mode;
 }
=20
@@ -1306,6 +1351,9 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	dwc->dis_metastability_quirk =3D device_property_read_bool(dev,
 				"snps,dis_metastability_quirk");
=20
+	dwc->host_vbus_glitches =3D device_property_read_bool(dev,
+				"snps,host-vbus-glitches");
+
 	dwc->lpm_nyet_threshold =3D lpm_nyet_threshold;
 	dwc->tx_de_emphasis =3D tx_de_emphasis;
=20
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index df87641..c2dee0b 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -606,6 +606,15 @@
 #define DWC3_OSTS_VBUSVLD		BIT(1)
 #define DWC3_OSTS_CONIDSTS		BIT(0)
=20
+/* Partial XHCI Register and Bit fields for quirk */
+#define XHCI_HCSPARAMS1		0x4
+#define XHCI_PORTSC_BASE	0x400
+#define PORT_REGS_SIZE		0x10
+#define PORT_POWER			(1 << 9)
+#define HCS_MAX_PORTS(p)	(((p) >> 24) & 0x7f)
+#define XHCI_HC_LENGTH(p)	(((p)>>00)&0x00ff)
+#define HC_LENGTH(p)		XHCI_HC_LENGTH(p)
+
 /* Structures */
=20
 struct dwc3_trb;
@@ -1024,6 +1033,8 @@ struct dwc3_scratchpad_array {
  * 	2	- No de-emphasis
  * 	3	- Reserved
  * @dis_metastability_quirk: set to disable metastability quirk.
+ * @host-vbus-glitches: set to avoid vbus glitch during
+ *                      xhci reset.
  * @imod_interval: set the interrupt moderation interval in 250ns
  *                 increments or 0 to disable.
  */
@@ -1209,6 +1220,7 @@ struct dwc3 {
 	unsigned		tx_de_emphasis:2;
=20
 	unsigned		dis_metastability_quirk:1;
+	unsigned		host_vbus_glitches:1;
=20
 	u16			imod_interval;
 };
--=20
1.7.1


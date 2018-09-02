Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0031FC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C1C204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VU/IrmfB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C1C204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbeIBRYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:24:52 -0400
Received: from mail-bn3nam01on0091.outbound.protection.outlook.com ([104.47.33.91]:56192
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728996AbeIBRYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7f/LsuWyslZ86bg/NPyHp+jD5ZBDXcDZiFxX+4exkFc=;
 b=VU/IrmfBg5z7menFlwaSUeNmlR1ijLxmmilGIxoI0QxNmMEQKMpR0CGOozxmb54FFUE/obhROGPE9NViiDl8hiS2a5Gl7wg/9bsb/mCn7RG6MI7Zy8MmbJ3Tu79ymULi/fq301CsPyroTM40snS6Auye8Q3rjGDdMXK9jR28hyY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:08:54 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:08:54 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Arun Parameswaran <arun.parameswaran@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 05/62] net: phy: Fix the register offsets in
 Broadcom iProc mdio mux driver
Thread-Topic: [PATCH AUTOSEL 4.9 05/62] net: phy: Fix the register offsets in
 Broadcom iProc mdio mux driver
Thread-Index: AQHUQr4Q9avYxdTXjk+xmVPag4dqVw==
Date:   Sun, 2 Sep 2018 13:08:38 +0000
Message-ID: <20180902065131.183542-5-alexander.levin@microsoft.com>
References: <20180902065131.183542-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902065131.183542-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:F5v6S7gce4+qi9aTd5Eps19CNe6PrLmma+d2AUBq1JEhBgCeDJDSDUjn3xoD+q+RjiJqAZHDiks376Cez160oGp0sSrHxgdtgw7xiBJk6dEOvWlqvgxTShQyBY/0ZrX2SEmX+fyRZmgqCKKZbTMoWplDGzGII93NBWWmcOZu5nR/wcWLjXrCv2oalOZObpO41sxUZWSBuWlCJMw5Im41b/bNMofdvYBCW5s0wTYGaAoS8dIdFOHKjleZLNDmsjFAVtpTOCfh3Q6rcpJDsdzkiebxCgFBaahQKNVG0LXRbVuW/WJhVUhFgE4unUmIHf1A7F675hGK2YiaXwhn98x8+oJIGDlxuJZdEHAZhywJ/Nc3knxU+Lbxm+1t9OI90ngK6buyH8PgBBdrapGYFD4AgzftDhj3DEH9aShEvyvJRBl1HguJCnomLGMUR85xDyP0+aQbq7KL++fgGdRIte8j7A==;5:E5asrq+vgPkYerzqbTUe6ho3amUSKElL6q6ycHcma3aRAdybQuELCEvMb/0KzjmZ+YmBa2OA7qhe3D6SATQYltEypwg3nnZdmWMdRYSbRq8sYrcPNz4F4dvheK4wl8HeKXS97+d5eyd+zNPHtWuSqkFyT/1/WRi9+ciNw38yeE0=;7:L1iXqOIonXulQ3bsQ7k/QAMxe94It84ewPRZhRseSTvSNU1YMIpSIm6ivYOwRKjcXKN1ky8fsY69yi5M22Ppfs9BATMNO6S8d4pxb1MRc+MBgeNviC4EP2uWy2EA3PCSDSfswWk0rnJr5nPHDvrz2NMvLNwDHS/Q5eOvoU+eGPKPPRQekKkktrEHf+6UrRGXdeoZX6UX+wAnoyWgI96oizaSlK/inI3SiLKqEg6JmentbMVFsKrrb32KmrpGNUnO
x-ms-office365-filtering-correlation-id: 2965b79e-b860-4f6b-34cc-08d610d53c7c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB04694FB40B94B574C8285BCCFB0D0@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(208715162771679)(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(136003)(366004)(346002)(199004)(189003)(110136005)(68736007)(36756003)(316002)(72206003)(54906003)(2501003)(81166006)(81156014)(8936002)(14454004)(97736004)(10090500001)(25786009)(106356001)(7736002)(2900100001)(4326008)(2906002)(8676002)(105586002)(305945005)(5660300001)(53936002)(1076002)(6116002)(478600001)(5250100002)(6666003)(3846002)(107886003)(10290500003)(76176011)(11346002)(99286004)(6486002)(6512007)(6436002)(2616005)(66066001)(6506007)(22452003)(446003)(26005)(186003)(86362001)(575784001)(217873002)(476003)(486006)(256004)(102836004)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +wQFshlNpgTnNmZxR8Isl2afJbbtmlDiWfz7w/bQn2sC/mzFy7vO3q33I+eUeNMVdxokHdwjCdyla7z02x9IWfS+21b9Dai3tNV6w4RAmnAa5e5dDEVL8E6WRUbJnnXvLWdgI/nHHAKhPQnTTOHctMi5AWp4NBM75swGjbqxweHN+NLVNM/U8Rzb0/a7YZ3fiQ12m79/0+tuNQDIFXRLQruh5NZ9/K39pPWQg4yuWd+a5bDEUn+69qaQNSoQ7iCM4WrhmpS7GqCYBiXjWueu+lrSvta1fxx6MroetpuZxBGKLK8cHiqGBuEedylVAf9hkXNePICO+FMaXnTpjQ7MSaQovtuhNlJQUyPDlMXD3U4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2965b79e-b860-4f6b-34cc-08d610d53c7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:08:38.3893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arun Parameswaran <arun.parameswaran@broadcom.com>

[ Upstream commit 77fefa93bfebe4df44f154f2aa5938e32630d0bf ]

Modify the register offsets in the Broadcom iProc mdio mux to start
from the top of the register address space.

Earlier, the base address pointed to the end of the block's register
space. The base address will now point to the start of the mdio's
address space. The offsets have been fixed to match this.

Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/phy/mdio-mux-bcm-iproc.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/mdio-mux-bcm-iproc.c b/drivers/net/phy/mdio-mu=
x-bcm-iproc.c
index 487bf5b8f545..bd9f9b9853c1 100644
--- a/drivers/net/phy/mdio-mux-bcm-iproc.c
+++ b/drivers/net/phy/mdio-mux-bcm-iproc.c
@@ -22,7 +22,7 @@
 #include <linux/mdio-mux.h>
 #include <linux/delay.h>
=20
-#define MDIO_PARAM_OFFSET		0x00
+#define MDIO_PARAM_OFFSET		0x23c
 #define MDIO_PARAM_MIIM_CYCLE		29
 #define MDIO_PARAM_INTERNAL_SEL		25
 #define MDIO_PARAM_BUS_ID		22
@@ -30,20 +30,22 @@
 #define MDIO_PARAM_PHY_ID		16
 #define MDIO_PARAM_PHY_DATA		0
=20
-#define MDIO_READ_OFFSET		0x04
+#define MDIO_READ_OFFSET		0x240
 #define MDIO_READ_DATA_MASK		0xffff
-#define MDIO_ADDR_OFFSET		0x08
+#define MDIO_ADDR_OFFSET		0x244
=20
-#define MDIO_CTRL_OFFSET		0x0C
+#define MDIO_CTRL_OFFSET		0x248
 #define MDIO_CTRL_WRITE_OP		0x1
 #define MDIO_CTRL_READ_OP		0x2
=20
-#define MDIO_STAT_OFFSET		0x10
+#define MDIO_STAT_OFFSET		0x24c
 #define MDIO_STAT_DONE			1
=20
 #define BUS_MAX_ADDR			32
 #define EXT_BUS_START_ADDR		16
=20
+#define MDIO_REG_ADDR_SPACE_SIZE	0x250
+
 struct iproc_mdiomux_desc {
 	void *mux_handle;
 	void __iomem *base;
@@ -169,6 +171,14 @@ static int mdio_mux_iproc_probe(struct platform_device=
 *pdev)
 	md->dev =3D &pdev->dev;
=20
 	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res->start & 0xfff) {
+		/* For backward compatibility in case the
+		 * base address is specified with an offset.
+		 */
+		dev_info(&pdev->dev, "fix base address in dt-blob\n");
+		res->start &=3D ~0xfff;
+		res->end =3D res->start + MDIO_REG_ADDR_SPACE_SIZE - 1;
+	}
 	md->base =3D devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(md->base)) {
 		dev_err(&pdev->dev, "failed to ioremap register\n");
--=20
2.17.1

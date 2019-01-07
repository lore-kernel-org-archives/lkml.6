Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514CEC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B89204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="A9qz7CTf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfAGHsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 02:48:21 -0500
Received: from mail-eopbgr50060.outbound.protection.outlook.com ([40.107.5.60]:27839
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726441AbfAGHrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 02:47:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0x/VH31+hQfAjZgfZ1nvSyj5Nb+x9LVc0bWxvhcXxM=;
 b=A9qz7CTf80a6xJIpBGSK9hW2Dt+O5sgTLHxp64+v6lnkriK9AlFwk3HM+nsd+yAIbmVJrwi1IEXWeOo2mews/mcI+NeNHFmIxDEMALe/CA2w44WjfpvlutvCNE8NbShlS4mla33iSswDITwcEommBbQE6Ia2vBU5UJrpV/eHzfM=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB5831.eurprd04.prod.outlook.com (20.179.2.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Mon, 7 Jan 2019 07:47:41 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::7c57:c2f3:1681:3fc4]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::7c57:c2f3:1681:3fc4%6]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 07:47:41 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH 4/8] spi: lpspi: Fix wrong transmission when don't use CONT
Thread-Topic: [PATCH 4/8] spi: lpspi: Fix wrong transmission when don't use
 CONT
Thread-Index: AQHUpl1EySmwrvSbQ0yaJf9q9nP+ww==
Date:   Mon, 7 Jan 2019 07:47:41 +0000
Message-ID: <20190107074639.6336-5-xiaoning.wang@nxp.com>
References: <20190107074639.6336-1-xiaoning.wang@nxp.com>
In-Reply-To: <20190107074639.6336-1-xiaoning.wang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR02CA0087.apcprd02.prod.outlook.com
 (2603:1096:4:90::27) To AM6PR04MB5016.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaoning.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5831;6:b7URvv06lpFLH5kpI7p2xFGrF22V8zzCAUZjIDGeIfUTA1qIDDh6BzcH+qRwoc5mmua5GXtabXIQAR5vSIKNmqS/WUNM31W/2grbnZTg+D7LKD6r8t8bMuj/Jqmdy1aRbCau/9QJRHhXasLWl+KfbNASmIe/VBxkKnN3TNfIDVIQonNu6tAB0TtOXG6FcyoHxsEQHw+6CM67SqxO4hWShgdzW3O6es1TRt5GJXXXWrucXPB+LoWU7QFl5Lv3yCsl1Z6CgiedTFlpMZwQx7fJChpqdD4jK9k6vjN//MFC6fOOQE2fgakff4iIA2CPa+JAIXZO+IIFzBcVUwDnkIFCcEgICaL+4M5yJ0LsNhj15BOEcM/JMRbJtPYpTA1IiPqvuuwoWeUn8cjbyK7j5ERgH6/4yY5ROeytljfEpuRakVCMXLodo9PUQfLE0wqsTI0AAOduMm37j0hiiVe1LjAj4g==;5:bLWi8am8j3mPGK2N6LfRVkyl1f0nrOC2JfVjG7raJqcODK0Sejbdi0puBeClR+a1P8b4y+PIBOvukNdeNIqVXSaY16IKJUP0yY7PYlADr4orvByyq/WpoCwbopLaegG83eccl/Ie4a6HIq5TLGGXCMWrST1LN/ZMXjfdnMnr4wD8RRqVrWtWcD5ldHsJbiVEwzJXMNpUiBEDtsIQvUEwSg==;7:7MgApl1kyk5oNfOkhBkOdtmTJEO1ErmLcm4XD2L3w9XBcm2sx3OZ1OEEFgEI5SDgEF0NxsW1WkJbHTmBGi0OiIQVwO43N+ZKdKDyfVzwc4oBFzoRWB7LK7BGWZ/KoWQYY6OYAngfgxOm+XH1CgiWzQ==
x-ms-office365-filtering-correlation-id: 9ae17b09-92cd-4105-bf68-08d6747466d6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5831;
x-ms-traffictypediagnostic: AM6PR04MB5831:
x-microsoft-antispam-prvs: <AM6PR04MB5831D7410AA807B70E34ACD4F3890@AM6PR04MB5831.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5831;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5831;
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(396003)(366004)(346002)(199004)(189003)(256004)(8676002)(6436002)(97736004)(5640700003)(54906003)(6486002)(68736007)(316002)(6916009)(575784001)(86362001)(2351001)(105586002)(99286004)(66066001)(186003)(26005)(81166006)(2501003)(476003)(8936002)(446003)(36756003)(11346002)(50226002)(2616005)(7736002)(81156014)(106356001)(1730700003)(52116002)(305945005)(76176011)(6116002)(3846002)(102836004)(2906002)(386003)(6506007)(4326008)(1076003)(25786009)(71190400001)(71200400001)(14454004)(486006)(6512007)(478600001)(5660300001)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5831;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vXChwUDWH9P+wYmgFYoa14Pwj4EgujvlWCt5MBUwj0gCF9Ztsk0Lnh/s88qweAz5r/c01jKE8Tm63PJWF2/X8mTDJM+wCtIXsp6vICE6LPsCt3Li2KRt3irNDA6cWyzJQpye1qhYmtxdENPC8j0wwpMS59RzYqOYhEts/fCR8oWwkfupvxYZozIuEz/Gg9ecKr/EhjqX+RIxw8XP2oQbOll1yBVP5Qr9529/509o2x/+A40w3TMJaIW24uo5hAyZjoFtYx79SImQNbbzr3lRGY/186gLewjplgY+WYPWwjgxE7TBkPaRjHiRAl4C1lFD
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae17b09-92cd-4105-bf68-08d6747466d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 07:47:39.3730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5831
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add judgment on SR_MBF and FSR_RXCOUNT.

In PIO mode, if don't use CONT to keep cs selected in one transfer, the
transfer will go wrong. FCIE will be set after one frame transfer
finish. If use CONT, the frame refer to the whole data in one transfer.
If don't use CONT, the frame refer to one byte of whole data. This will
cause the transfer ending early.

This patch add a register reading in isr function, it might lead to a
slight decrease in the max transmission speed in PIO mode.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index f32a2e0d7ae1..51c85cf0bd9f 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -52,6 +52,7 @@
 #define CR_RTF		BIT(8)
 #define CR_RST		BIT(1)
 #define CR_MEN		BIT(0)
+#define SR_MBF		BIT(24)
 #define SR_TCF		BIT(10)
 #define SR_FCF		BIT(9)
 #define SR_RDF		BIT(1)
@@ -65,6 +66,7 @@
 #define CFGR1_PCSPOL	BIT(8)
 #define CFGR1_NOSTALL	BIT(3)
 #define CFGR1_MASTER	BIT(0)
+#define FSR_RXCOUNT	(BIT(16)|BIT(17)|BIT(18))
 #define RSR_RXEMPTY	BIT(1)
 #define TCR_CPOL	BIT(31)
 #define TCR_CPHA	BIT(30)
@@ -446,6 +448,13 @@ static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id=
)
 		return IRQ_HANDLED;
 	}
=20
+	if (temp_SR & SR_MBF ||
+	    readl(fsl_lpspi->base + IMX7ULP_FSR) & FSR_RXCOUNT) {
+		writel(SR_FCF, fsl_lpspi->base + IMX7ULP_SR);
+		fsl_lpspi_intctrl(fsl_lpspi, IER_FCIE);
+		return IRQ_HANDLED;
+	}
+
 	if (temp_SR & SR_FCF && (temp_IER & IER_FCIE)) {
 		writel(SR_FCF, fsl_lpspi->base + IMX7ULP_SR);
 			complete(&fsl_lpspi->xfer_done);
--=20
2.17.1


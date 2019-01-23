Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352EFC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC7EE20856
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="a9AIJvjx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfAWQdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 11:33:55 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:7872 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfAWQdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 11:33:54 -0500
X-IronPort-AV: E=Sophos;i="5.56,512,1539673200"; 
   d="scan'208";a="25394528"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 23 Jan 2019 09:33:53 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 23 Jan 2019 09:33:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlwoTm+1v5D3Rx5+uuygoMbh/Jc4Yxw58Onyt3ecojY=;
 b=a9AIJvjxikwzVYX9q62uJwkmqZbxH43d6+SCD+IBjk9LjVHS8igvRHwKP0YZD0aM11IZLhJKcYDpD0vAhvKb4G1L4NjTQqcrT15KBAuIjh1CHJXaekm9bmNyi93Lbo8RBEn7oCXYstoPtxechlrCJ4uUtGry8+vjFAqK/ARHjL8=
Received: from CY4PR11MB1256.namprd11.prod.outlook.com (10.173.16.10) by
 CY4PR11MB1607.namprd11.prod.outlook.com (10.172.71.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.31; Wed, 23 Jan 2019 16:33:48 +0000
Received: from CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::2cb0:2ec7:14d7:c503]) by CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::2cb0:2ec7:14d7:c503%10]) with mapi id 15.20.1537.031; Wed, 23 Jan
 2019 16:33:47 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <Ludovic.Desroches@microchip.com>, <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Codrin.Ciubotariu@microchip.com>
Subject: [PATCH v2] dmaengine: at_xdmac: Fix wrongfull report of a channel as
 in use
Thread-Topic: [PATCH v2] dmaengine: at_xdmac: Fix wrongfull report of a
 channel as in use
Thread-Index: AQHUszlq09QahfETH0Of1PoFTE5waA==
Date:   Wed, 23 Jan 2019 16:33:47 +0000
Message-ID: <20190123163339.17506-1-codrin.ciubotariu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP265CA0178.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:4d::22) To CY4PR11MB1256.namprd11.prod.outlook.com
 (2603:10b6:903:2d::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Codrin.Ciubotariu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR11MB1607;6:VdTYCwLA7kU3ZCbs3IzGYQoEk0R+fjrkjBzw0mZDT0t4jL3rlr15fwGsoQGyDjAOdNqr1/7rkCBQFqy9O98XgvGPJvXAtTVpSg0307thY/9jJpckwfiL2+582Q5ibLeMKKFI6nNbHH+rG3MFswwx2ooa9r/5lMWzyNlCUrh7x7KBKzr6mj0sc0nfBr9CgLrxkqGCv1Q6dh3Y7w7r5vprUTkwArRQViF90OPsrGqwIgIS8WGUQ6C4Zr9r5tbNZL+CDm5L+44+8mMWCqOBJvwWlLEPEH+HLoUr+qG3D0N9CGHpM9X3ckGR9YYU8IbCdVT+UBtngSWr7bEBCTQEc+WM84YghjbXlsQInLUsYE1k5gBEWBbm/9RHT4WLaydifMMXyTOqB+5Q+5UTAfv46U+q1GKNLbeHnlo72j5fWOCqFBU1TfHBFYGdD3BFpP76Zd6Lfjgai+8COKRnAVy26eJcBQ==;5:KDRI+Yfp7vndmgzKq1QwLR3HWMw6HEvxDhdngDSeQ3pdWM3ahks8S6OHv958iDpNJYGF6YfgOIUMO5H4UveeUFzJqR6AdSVHneMSTtz0eoj0yO9Ybud6/nDGkg7lL9mGyg+vZr3Nml435vnITY0sKEjOMLf4zSaZrefmIeiwGj592vz85OslffHFQu7xQ7Vq3u69yT+lKoAI7TYc2bhvWg==;7:PXQfUx1pyC5JY4QONugJ/8I6HrKnFVBO2hB7b82qHQ0/cpdMPWa0g70fH3mVKPHm+xHUh4HAHA+ZFCOdaKAWIonhp8TDJrYoU4Aeh2LimzjBX0Ol/jb2SOV6kYd+zp9e2dbptpXQtmOmETnQ/kHv9g==
x-ms-office365-filtering-correlation-id: 5be8c0b8-40f8-4088-63c4-08d681508c65
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR11MB1607;
x-ms-traffictypediagnostic: CY4PR11MB1607:
x-microsoft-antispam-prvs: <CY4PR11MB160706269636AD778985B19FE7990@CY4PR11MB1607.namprd11.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(136003)(366004)(199004)(189003)(36756003)(14454004)(6486002)(81166006)(81156014)(2501003)(97736004)(8676002)(53936002)(107886003)(6506007)(2906002)(71190400001)(71200400001)(1076003)(3846002)(4326008)(68736007)(86362001)(72206003)(6116002)(8936002)(386003)(25786009)(478600001)(50226002)(316002)(486006)(6436002)(186003)(110136005)(54906003)(52116002)(105586002)(7736002)(14444005)(2616005)(102836004)(99286004)(6512007)(66066001)(476003)(26005)(106356001)(256004)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR11MB1607;H:CY4PR11MB1256.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HxXjbcxt1QejLlju7bf3+XuEcpXRLnFQJumYdmyNzDRPxydc9//0eyVq44jov5HaIEYZ3NhBQ6J3Aeb8YRPSp+JbuiyaHzPhK67pz9nXJaRQ+ApMUnIiTeuCfPnNcCNGNgYoG/aeXYL6RbXtrl2+z2MfA/wPFXMj7pg1ZSn9eO7Z9v1PBPAQJVC+e5KIC1fl9ol0wtUQcdTez0YOsptA21FXrCnR4YrNBofVdX4Lw4t8r4lvcG7S/b4PzEZCi0FFGWbG4YhSqEPZrwUquJ+ZewgJXHbo6gH5ZNuYWB7RX27AU1ylvrsnt7hEqQfoZmqihfmwTjhJBzkJnzDEi20esJgg6Clws/1uCQw7+lTc6/HRlqU6EdodLcSU89UZcrfjD9rvKPx5zUtn75XRviaVzfbfpcJlNOsAePh9P/gKO44=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be8c0b8-40f8-4088-63c4-08d681508c65
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 16:33:45.2008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1607
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

atchan->status variable is used to store two different information:
 - pass channel interrupts status from interrupt handler to tasklet;
 - channel information like whether it is cyclic or paused;

This causes a bug when device_terminate_all() is called,
(AT_XDMAC_CHAN_IS_CYCLIC cleared on atchan->status) and then a late End
of Block interrupt arrives (AT_XDMAC_CIS_BIS), which sets bit 0 of
atchan->status. Bit 0 is also used for AT_XDMAC_CHAN_IS_CYCLIC, so when
a new descriptor for a cyclic transfer is created, the driver reports
the channel as in use:

if (test_and_set_bit(AT_XDMAC_CHAN_IS_CYCLIC, &atchan->status)) {
	dev_err(chan2dev(chan), "channel currently used\n");
	return NULL;
}

This patch fixes the bug by adding a different struct member to keep
the interrupts status separated from the channel status bits.

Fixes: e1f7c9eee707 ("dmaengine: at_xdmac: creation of the atmel eXtended D=
MA Controller driver")
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 drivers/dma/at_xdmac.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 4e557684f792..fe69dccfa0c0 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -203,6 +203,7 @@ struct at_xdmac_chan {
 	u32				save_cim;
 	u32				save_cnda;
 	u32				save_cndc;
+	u32				irq_status;
 	unsigned long			status;
 	struct tasklet_struct		tasklet;
 	struct dma_slave_config		sconfig;
@@ -1580,8 +1581,8 @@ static void at_xdmac_tasklet(unsigned long data)
 	struct at_xdmac_desc	*desc;
 	u32			error_mask;
=20
-	dev_dbg(chan2dev(&atchan->chan), "%s: status=3D0x%08lx\n",
-		 __func__, atchan->status);
+	dev_dbg(chan2dev(&atchan->chan), "%s: status=3D0x%08x\n",
+		__func__, atchan->irq_status);
=20
 	error_mask =3D AT_XDMAC_CIS_RBEIS
 		     | AT_XDMAC_CIS_WBEIS
@@ -1589,15 +1590,15 @@ static void at_xdmac_tasklet(unsigned long data)
=20
 	if (at_xdmac_chan_is_cyclic(atchan)) {
 		at_xdmac_handle_cyclic(atchan);
-	} else if ((atchan->status & AT_XDMAC_CIS_LIS)
-		   || (atchan->status & error_mask)) {
+	} else if ((atchan->irq_status & AT_XDMAC_CIS_LIS)
+		   || (atchan->irq_status & error_mask)) {
 		struct dma_async_tx_descriptor  *txd;
=20
-		if (atchan->status & AT_XDMAC_CIS_RBEIS)
+		if (atchan->irq_status & AT_XDMAC_CIS_RBEIS)
 			dev_err(chan2dev(&atchan->chan), "read bus error!!!");
-		if (atchan->status & AT_XDMAC_CIS_WBEIS)
+		if (atchan->irq_status & AT_XDMAC_CIS_WBEIS)
 			dev_err(chan2dev(&atchan->chan), "write bus error!!!");
-		if (atchan->status & AT_XDMAC_CIS_ROIS)
+		if (atchan->irq_status & AT_XDMAC_CIS_ROIS)
 			dev_err(chan2dev(&atchan->chan), "request overflow error!!!");
=20
 		spin_lock(&atchan->lock);
@@ -1652,7 +1653,7 @@ static irqreturn_t at_xdmac_interrupt(int irq, void *=
dev_id)
 			atchan =3D &atxdmac->chan[i];
 			chan_imr =3D at_xdmac_chan_read(atchan, AT_XDMAC_CIM);
 			chan_status =3D at_xdmac_chan_read(atchan, AT_XDMAC_CIS);
-			atchan->status =3D chan_status & chan_imr;
+			atchan->irq_status =3D chan_status & chan_imr;
 			dev_vdbg(atxdmac->dma.dev,
 				 "%s: chan%d: imr=3D0x%x, status=3D0x%x\n",
 				 __func__, i, chan_imr, chan_status);
@@ -1666,7 +1667,7 @@ static irqreturn_t at_xdmac_interrupt(int irq, void *=
dev_id)
 				 at_xdmac_chan_read(atchan, AT_XDMAC_CDA),
 				 at_xdmac_chan_read(atchan, AT_XDMAC_CUBC));
=20
-			if (atchan->status & (AT_XDMAC_CIS_RBEIS | AT_XDMAC_CIS_WBEIS))
+			if (atchan->irq_status & (AT_XDMAC_CIS_RBEIS | AT_XDMAC_CIS_WBEIS))
 				at_xdmac_write(atxdmac, AT_XDMAC_GD, atchan->mask);
=20
 			tasklet_schedule(&atchan->tasklet);
--=20
2.17.1


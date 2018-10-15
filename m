Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5C9C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DFB22064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="CREmGrZg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DFB22064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbeJOQpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 12:45:19 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:8399 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeJOQpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 12:45:19 -0400
X-IronPort-AV: E=Sophos;i="5.54,384,1534834800"; 
   d="scan'208";a="21542309"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 15 Oct 2018 02:00:58 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 15 Oct 2018 02:00:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sb8uiQZWI9jLu14kj09fjpuWjYrhURYQaU7hp+S2CE0=;
 b=CREmGrZgHd7MQ0KbcLhZVBtACHTC8JhntKrzluFL9/Ynlfn3vkB3ndlTTVxegZHvE1fj2xP6sItcZy6sDF7e4A1FlUEnqjnRZ5OMjMEUS4HkJtxN5K7sGNoYuzoShip6I0ogzCIS+PntUfHnYx9m7iKyGz9sNX2+8ZrV7FIsFaI=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1332.namprd11.prod.outlook.com (10.173.32.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.21; Mon, 15 Oct 2018 09:00:55 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::c157:ea7:fc3d:f9a4]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::c157:ea7:fc3d:f9a4%10]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 09:00:55 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <stern@rowland.harvard.edu>, <gregkh@linuxfoundation.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Cristian.Birsan@microchip.com>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2] usb: host: ohci-at91: fix request of irq for optional gpio
Thread-Topic: [PATCH v2] usb: host: ohci-at91: fix request of irq for optional
 gpio
Thread-Index: AQHUZGWUHyQspvTY9E2F8as35fJ9jA==
Date:   Mon, 15 Oct 2018 09:00:54 +0000
Message-ID: <20181015090001.5195-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0801CA0078.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::22) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1332;6:g6Hyn/PfS8w6djq7dV3aOXyp9LncAqXfUD8R96MpBG4mRtBW1MpHsKSm3qHCxmCh/U4R3Erke+ZHqECb8pp9cvzcKr5jAxnB0R1+202Qa5W9l0/twUNAgF3oL8vsSNFsed+gpa3ANoRGFXNYw6/XffewBOx1Sdl4XmFxffSce7qBTK82v6Ow3xjJMRcavGpIrOJAabQP3+TJ56tY8MAMJ3Fgtl5j1NMPzBMsK64XdqIY10kdmWf1sG3m+6D3/kPz9TNvQLBwZgA7RtqwOtvLG/Cutw9teVQInu4eu7HO4VAP5MJitUi+j0rLb30UlM/+DorbQDOmbB4AB2W1BSiH2Bh3hew6xn6qBh96M3ntjJM1kaFnK1GVYGRvvARqbs7Sk+iLePLCIeFT6GYkyrQQDHIIAfS7ZtDZh8J0NrVF1q3iSZYcbZv54blUMB3r4WtXR5y27ovJmw3t0GDApp1qDw==;5:pce7l/fbFFiGo3v0zJGAGrABIbPRQDiuwkbQyiLMTEniM2iAvOzbsYjeWWCK4MFcNOoQiqt4S1j3GwgDsNrj0NCnfwqT7fVWeYg0EG1J4c7Ayz+3EgcZyx6LcjbfNg5oopbbNeqYoiidn2jVQVDCMPbSPMTw3Mf+B6la/sTjMr0=;7:2e2Gl+LNXMTfkF0oBIFeFBueoXxWO4gb5vLAqAfjIOaZLOVd6p/Atmh5sOplQNqmEPrDKkfGWkld3Mq69vShoE1VUdeAn2FwEPtacfg6S6hAjmf979hUDTLsOqcrAi0uey/CF1OB/+jdUr19RCeQemCqv2Yl0a4AL/qOrm/ST9yruTy0zLDjBq12X7dBY9twdeFLW4r1IDkQKeMGWuuc3uf9xk0JkdRqKLU3N0j9p4bETC4LGoKknDB1KTfd8iB4
x-ms-office365-filtering-correlation-id: a1773d18-2c6a-4270-5ea1-08d6327cb6d3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1332;
x-ms-traffictypediagnostic: BN6PR11MB1332:
x-microsoft-antispam-prvs: <BN6PR11MB1332D588E2ED6A9421B91FA1F0FD0@BN6PR11MB1332.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:BN6PR11MB1332;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1332;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(346002)(136003)(376002)(189003)(199004)(5250100002)(36756003)(5660300001)(6486002)(66066001)(6436002)(2501003)(6506007)(8676002)(2900100001)(478600001)(256004)(68736007)(386003)(14444005)(107886003)(3846002)(316002)(52116002)(6116002)(2616005)(71190400001)(71200400001)(476003)(7736002)(14454004)(305945005)(486006)(2171002)(97736004)(6512007)(2906002)(4326008)(6306002)(102836004)(186003)(72206003)(1076002)(25786009)(105586002)(99286004)(966005)(81166006)(81156014)(86362001)(26005)(8936002)(2201001)(110136005)(106356001)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1332;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: aSp372WGPF+DirFXnGrA9Oc2Z9k/67P8Z3tbgNUr8Idl9t80JXEOc4W8kZ+OMl+ZkrQKOEtL4HTzW+ZPzuZa7XDkplBihvTZ03pq1FOSJIDaM6Z0WE1oq2z4A9b1th7/5waoHY5pbGdI4eEXMqJiNxj2VjXMogf1KG2cz6QyjG4N7kuzi9oDSg9C5RUOsdJgSAJcWQ0zlOSPkmbNy7uZza0CGZMR45+vjXWlKZylEqKlgzRlzLckNTeje37KOB8jlkjS6QpbAaAV+qz1G1MnRCGVCAmi1ObsyNgFjh+oaaiDkuQdctBnfR9BiYsfxn2ss4asj4F6Yo/bsfh38Grakqnwd/BpRdr1PI1eDwQDTcw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a1773d18-2c6a-4270-5ea1-08d6327cb6d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 09:00:54.9097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1332
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

atmel,oc-gpio is optional. Request its irq only when atmel,oc is set
in device tree.

devm_gpiod_get_index_optional returns NULL if -ENOENT. Check its
return value for NULL before error, because it is more probable that
atmel,oc is not set.

This fixes the following errors on boards where atmel,oc is not set in
device tree:
[    0.960000] at91_ohci 500000.ohci: failed to request gpio "overcurrent" =
IRQ
[    0.960000] at91_ohci 500000.ohci: failed to request gpio "overcurrent" =
IRQ
[    0.970000] at91_ohci 500000.ohci: failed to request gpio "overcurrent" =
IRQ

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
v2: fix typos in commit message s/it's/its, s/probably/probable

Based on https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git,
usb-next branch.

 drivers/usb/host/ohci-at91.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index e98673954020..ec6739ef3129 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -551,6 +551,8 @@ static int ohci_hcd_at91_drv_probe(struct platform_devi=
ce *pdev)
 		pdata->overcurrent_pin[i] =3D
 			devm_gpiod_get_index_optional(&pdev->dev, "atmel,oc",
 						      i, GPIOD_IN);
+		if (!pdata->overcurrent_pin[i])
+			continue;
 		if (IS_ERR(pdata->overcurrent_pin[i])) {
 			err =3D PTR_ERR(pdata->overcurrent_pin[i]);
 			dev_err(&pdev->dev, "unable to claim gpio \"overcurrent\": %d\n", err);
--=20
2.9.4


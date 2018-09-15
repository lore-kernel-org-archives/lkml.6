Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E705AECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC3F21476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GJz9P8+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC3F21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeIOGrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:47:01 -0400
Received: from mail-eopbgr680131.outbound.protection.outlook.com ([40.107.68.131]:36298
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727083AbeIOGq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peJpvmYBkTUJCaAGBUqQ70O7KfUEHzsM5NdUUr1cQMs=;
 b=GJz9P8+mlc9AvX7IBeN4+QsfZtuDSbolFyLK6CFGHytKFAfE5mFnvuowpUc/fupKQps3h9ThvT9llnywQSd0wxiIGGTz+qT0F5SafZ0qlyFp1S95CDjXMTFjgCruLMC27MtMqTRpW+lbyqw05VFuZWkoNcO334trLOjxHO5izDk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0840.namprd21.prod.outlook.com (10.173.192.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:29:54 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:29:54 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 08/92] spi: dw: fix possible race condition
Thread-Topic: [PATCH AUTOSEL 4.18 08/92] spi: dw: fix possible race condition
Thread-Index: AQHUTJOaJGMP7z7j8UavKjCWdYzv+w==
Date:   Sat, 15 Sep 2018 01:29:54 +0000
Message-ID: <20180915012944.179481-8-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0840;6:5l/9av2sFAruEOLA1vr93WwgnQKk/5hmYJiXVGwHYYgGwQ6FkLfuSCRuDC0Vxrf9z0APHWlwQV0H5qp3n1NMvER38SjBGSyPl1GGkjgFtmKyrPKLWBj1U7cPNmE20WHuZApgJzcFc+e+SkoMy5AVt3n/Hys8Xb7F5sthwFDzJnl4g/gHbFn0oKNMJOnLUZUiLnzrQyC++cxPu8T/1wj2l55uWX3a5TgiM0WKwJS+K4l24umgkir3VgMOj5RppP/9rwNwq615E3znUjvsXvRVdmhRNwVPrFR1x8LqkyciH2WN0C0R63HobwqaeUvDJIUO/0RxGT9KW7t/Al3K7+42dZhygtI/VdaYGHDK7/WllIn3tZqTpLQnKYv0WENw4kRANdITF4rQ26iV9oXrxfRSSWI7jNZKjCyfsrbxb0cpbQkCcMSBIE9VvNLFa6ad2VKPGdvMwkBheMj9RtWO5l7Yxg==;5:4TD3eyBPdxv74CNZ8SP87kVCRqLuvUja063WPcm9f+KjjWfwgGHCPMhpTKl7CiQScZuAf110lI4+fJ0JCuQT727F+YfpkbQJ0qJlUKJoxtPWLaRjKxfymkiN9uEc/Cj/p2c/mZ0uy8gGrTDKIN0xog3fTMEE7vbbT18qK9tic0o=;7:8N2c1DMLs24jEoK2BHWPYrxxsO47/wt3hrrqsz2hdjRzTrUedX5OkC3xsyFCUw/NZRH9Z2WG0Ptb35PqYTXWW2KwOnDuGT5ZtwHdpjJcvbz5oy9N6xDHeUzKp8wh+e0YZCyshB/CWcn+PwSRmBBWSlgE4sa4zBviNC2UvNdWFUX3UBgpxNoCOF0s6eeq+mrjPBXOUqYYBuzf0+NNtKy4ZSQHJXhtLx8s04uY24MF8d2Hgyabk+fg/LwQPXNk9neW
x-ms-office365-filtering-correlation-id: 43689485-e96a-4d5d-a776-08d61aaabd7b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0840;
x-ms-traffictypediagnostic: CY4PR21MB0840:
x-microsoft-antispam-prvs: <CY4PR21MB08401F6628301D9632DB415BFB180@CY4PR21MB0840.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0840;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0840;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(39860400002)(396003)(376002)(189003)(199004)(14444005)(6116002)(81166006)(2906002)(446003)(478600001)(3846002)(8676002)(106356001)(105586002)(10090500001)(22452003)(8936002)(486006)(2616005)(72206003)(36756003)(11346002)(81156014)(186003)(26005)(14454004)(6506007)(217873002)(4326008)(25786009)(256004)(107886003)(102836004)(6346003)(476003)(1076002)(10290500003)(86362001)(66066001)(6436002)(6486002)(86612001)(53936002)(54906003)(2900100001)(97736004)(7736002)(6512007)(305945005)(76176011)(99286004)(2501003)(5660300001)(316002)(110136005)(5250100002)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0840;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 7CnURVi62RevZzQPndsB4Tc1cCDPwJ3ublh6V9E8Y7wCym8JfrsHf/bjnpGcm/efbMhuTi/f3c+aTL3UZX5vDgF00dW3Y+vjFgvJy9bw494KC2AbJdjKatNkdu0FngshJtWfSZJLeZidUK0lds1Dl7iq4i9BfwfAb97CWhk56najHTnIGT3iS/dpfkfElUCDPkX/Elsv1mctc9Ct2JxkcjiUU4yuaS5USecoQ1/MNwibiJMNI1iNyeON+xN/FPObH6WNW1sazEKNV2vB+sroeZAm4vd3reWm06pX6YVZcczyRceZLmaLliqvbw9mWPcAGOYQBqXWoSkLZnO5s8WcJBLQHF4PoqZeGUcZlNrLvkY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43689485-e96a-4d5d-a776-08d61aaabd7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:29:54.4326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0840
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

[ Upstream commit 66b19d762378785d1568b5650935205edfeb0503 ]

It is possible to get an interrupt as soon as it is requested.  dw_spi_irq
does spi_controller_get_devdata(master) and expects it to be different than
NULL. However, spi_controller_set_devdata() is called after request_irq(),
resulting in the following crash:

CPU 0 Unable to handle kernel paging request at virtual address 00000030, e=
pc =3D=3D 8058e09c, ra =3D=3D 8018ff90
[...]
Call Trace:
[<8058e09c>] dw_spi_irq+0x8/0x64
[<8018ff90>] __handle_irq_event_percpu+0x70/0x1d4
[<80190128>] handle_irq_event_percpu+0x34/0x8c
[<801901c4>] handle_irq_event+0x44/0x80
[<801951a8>] handle_level_irq+0xdc/0x194
[<8018f580>] generic_handle_irq+0x38/0x50
[<804c6924>] ocelot_irq_handler+0x104/0x1c0

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/spi/spi-dw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index f693bfe95ab9..a087464efdd7 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -485,6 +485,8 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *=
dws)
 	dws->dma_inited =3D 0;
 	dws->dma_addr =3D (dma_addr_t)(dws->paddr + DW_SPI_DR);
=20
+	spi_controller_set_devdata(master, dws);
+
 	ret =3D request_irq(dws->irq, dw_spi_irq, IRQF_SHARED, dev_name(dev),
 			  master);
 	if (ret < 0) {
@@ -518,7 +520,6 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *=
dws)
 		}
 	}
=20
-	spi_controller_set_devdata(master, dws);
 	ret =3D devm_spi_register_controller(dev, master);
 	if (ret) {
 		dev_err(&master->dev, "problem registering spi master\n");
--=20
2.17.1

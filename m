Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606AEECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC50208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KekYEQYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC50208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbeIOGsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:48:03 -0400
Received: from mail-cys01nam02on0090.outbound.protection.outlook.com ([104.47.37.90]:32953
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728642AbeIOGsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:48:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqLcoPVOBZdX3u6XKe+ec92A5oO41HoxUC3DS3pXm/8=;
 b=KekYEQYubdUsRC09HfIzKOuhxX46nvZNyvo0tJNQt0uOPCRzFhpUjTwtLY9Il2krcUp7yjasieSOEGskJv5lVR8+am8wFch+odu5ihcjjZgEz/9OP5twQ1pZ+aUs73crYYgcdzdYrz57045BBsT+EYbfROSPH+Zh/rKI0zrU8C4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:30:59 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:59 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 60/92] net: mvpp2: make sure we use single queue
 mode on PPv2.1
Thread-Topic: [PATCH AUTOSEL 4.18 60/92] net: mvpp2: make sure we use single
 queue mode on PPv2.1
Thread-Index: AQHUTJOxDcfVMGrPvEeuY9BA0FojXA==
Date:   Sat, 15 Sep 2018 01:30:31 +0000
Message-ID: <20180915012944.179481-59-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:8NFkDmsJiXggqL4FCtsBXOJv14XAm/8YC+/3gU4fw2wYqTXkKwgai30+NcujiFT9+VoJxR2aG6GjqSe4VXJq/Q5Ua9qD5XyzqvcHWAwFaxNwWtBgBK/vjlUko1MqJh1Z7CTWBe3vRMNnGUcJTe8yNbvS4Cqphch28kcl3by6+FuP8vgO6HHSA1Z4SgOrL0xzVA/5d+9b1p8kI+Zq151QipiLFyHKraVMWcmyhp1kwOtzN9w+rd7HQ1H1rQ7qYbia5YwxqZGSBjKbM58HbIAZoG46GZk4xVr4gu7NjRgGpRkp0kLk5yuYMZdDzwu6KsdyzvQhaGSU2n3I0QrV3EnyZomAHUOe+XUT6XecMbmXMVqCdSQxE/gAj5Nuk6UiMhMUxnNSQxLBwRl1ka7xvt0kDmemUl7R3XFA1ZPAhsyvSb34MrsLdaF9CaR9GegNHnG/YhIURZE4lqZFykanprSgdw==;5:VafN38jlIw56cPKvsy0vLU/3ydUjhmG17t1x9ZIjHEolGhbjI0cNNqHl7VJ0X5B95gK9fC2TPetxl2GE7QRsBXwMuHGFh+sfAw44NrcH/eJiHztgTHnjxwN3pz5JVwo3zFMTql3EMvkQGHCw+nPspTXs+U4a70EOEmjhdlJJETM=;7:VZHWPNrLvyWE/5l4do/kgo6zNxQ/kTBj6B/WKdmgu6Dqtn3S3dkO7nj4UpSsPCi+YTsvJg3pdCUkN0RLWEbduMeNKUe8jUjviD4XRkqgAA7t5BGvXvx7vRaU7Qa6Aycaa0TNotOKYp6Vn/9N5XcE2jy2hdFzhQqvrlGmgw+s323319ROdTinAbKQzFKbwkJxZZkZNGTd4oViaFf8oRDzTkCHxEqnMU0AxyYNNQqK1LEtqA8lKwoclsQbiAT4WPgq
x-ms-office365-filtering-correlation-id: 3086c210-ba33-495b-978a-08d61aaae400
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
x-microsoft-antispam-prvs: <CY4PR21MB074146E7FE352A4913278A33FB180@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39860400002)(136003)(366004)(376002)(396003)(346002)(189003)(199004)(186003)(106356001)(25786009)(6346003)(6486002)(6436002)(476003)(102836004)(11346002)(5660300001)(2616005)(26005)(217873002)(105586002)(486006)(446003)(4326008)(53936002)(5250100002)(14454004)(10090500001)(2900100001)(256004)(6666003)(2501003)(10290500003)(6512007)(22452003)(72206003)(8676002)(478600001)(110136005)(97736004)(68736007)(66066001)(81156014)(81166006)(2906002)(99286004)(86362001)(86612001)(6506007)(76176011)(8936002)(6116002)(3846002)(1076002)(54906003)(305945005)(36756003)(7736002)(316002)(107886003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: dLSo5s4WZZD4Dm8GWiXPFiK2xe3FFnOvYBeLhaTopJRrKJXUuaxIsN8mdG9Gf+iTMcaOs7O9QyVbJzqcrlvPEADGFbMuKRubcfiRhY9l8oo/dvbucPK4DPyG0kqYPBOoYjglDYeg1cfFYMfkq3RAWnqbaZwcHfDickIxsY30SJQUTLMtCK9DMp+lQ0cJrxcyzTbBFzDhgew3+wcYxGkgeotSS/8WT+fLtXTVth2XWm9ezfiExfs7FBQqpkk00e+PV7LG1bnvLJpOX5Eusuzu9JpztTgcq2W4KkVilte/O3xa3eVfK7cMl5K9Gqw10GPri8NtDBEMvReeujjTOm3XCWS2B0a3zhOMQ6wY4FXvHxc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3086c210-ba33-495b-978a-08d61aaae400
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:31.6043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>

[ Upstream commit 1e27a628e3f444f53ab8099dfb31c5156e38d112 ]

The PPv2 driver defines 2 "queue_modes" :
 - QDIST_SINGLE_MODE, where each port share one rx queue vector
   between all CPUs
 - QDIST_MULTI_MODE, where each port has one rx queue vector per CPU.

Multi queue mode isn't available on PPv2.1, make sure we fallback to
single mode when running on this revision.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/=
ethernet/marvell/mvpp2/mvpp2_main.c
index 0319ed9ef8b8..f7f08e3fa761 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -5011,6 +5011,12 @@ static int mvpp2_probe(struct platform_device *pdev)
 			(unsigned long)of_device_get_match_data(&pdev->dev);
 	}
=20
+	/* multi queue mode isn't supported on PPV2.1, fallback to single
+	 * mode
+	 */
+	if (priv->hw_version =3D=3D MVPP21)
+		queue_mode =3D MVPP2_QDIST_SINGLE_MODE;
+
 	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base =3D devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(base))
--=20
2.17.1

Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87B1ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60050208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ds9RzEdC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60050208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbeIQJCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 05:02:55 -0400
Received: from mail-by2nam03on0137.outbound.protection.outlook.com ([104.47.42.137]:35861
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728518AbeIQIZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5Tqv1P7nKLvBInV1vgqUZN1h7qV4mGYTfmGLmcaDwQ=;
 b=ds9RzEdCrQOGrbirrGG9SlNgUdmyHzZdUPOoV1BZIN9zyu903mEpPSuYe+xQy0FOlaq6cCWs8stm7776bSQ+zrMWBt5bEV5n7jkTz9nlvUDNLfv2EuXNLLGhdl7gEyoDd4+wsmFFybd+uH9ILHmF0ibgPpoAth72wZE4vaQoeVs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0277.namprd21.prod.outlook.com (10.173.193.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:00:23 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:00:23 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 014/136] misc: sram: enable clock before
 registering regions
Thread-Topic: [PATCH AUTOSEL 4.18 014/136] misc: sram: enable clock before
 registering regions
Thread-Index: AQHUTjKRl4mQtsgkAUympiiOkyk/HA==
Date:   Mon, 17 Sep 2018 03:00:19 +0000
Message-ID: <20180917030006.245495-14-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0277;6:Z58wI3c++sP+9V5ZL4xHHYHW3+U+tMcPGGt5n6REIpmFUG2XQOJR0IgvgufgN+Pah+9e6AwVQalzpzDWV7I0NNDn0TDrc1TLiw4KkAV753pUJHo6zx2LVavtld7KGH46hVDt/19BPswEbGAGYBOtL1xdSgSXgQkGtSWGPvD5LYIN7UqW/QtE8fbg8IQ7K4d8CTJKJXrEQ+UEKHCC8ViB5NOgOeQ4BgRxK9QP39B+8vtKX5aPr5gNtqzo028NeilXgJ5KlEpmrapDMa+RCKl14+E//PJey6yol+QS5Z6EtGZVTBsShIuarid1NmHb2rgFsX3ysnDX60RACoa62JpIA9OGqfw3jlLkkGNpvuS0A3JgewpOwlX8dPwAGtIWsF1zTpE087eK/fO9gJmOg40zYPbc+xI+iXPS6QTYzs1fLaI+4sjlVQfuviUzF0LyJnKOsyVW/nBd2B3gw+ZJvTE6Gw==;5:ZL5eTL+Q9d6ITuBiTnig3TFAcOSmbfgvYtGII75ltbvsLbDAEMWsURYJsb1hC/xbp2UuBPoAV4gdi7qqiTnCdeskad7j+ndmCqNZw4BXiSwNlqYOyiovwgo1cimcjUxjfpnf67AuLYtl5WcZgTGunYokUgBPb83reo9Cw5kRz9E=;7:WH+CQMGKZbRTjD1GHBeMSRixZ0wjxHqjpfUKSNzihKCMWVLjhnegKOuT9XDsDh2bHGo8PKyU7l9KQzqPI642nk6ELhqRVy+pCMr0sEDNh+4h0Gfy85Q062q7E1yXdxyzR0vHQ1RkSOla3GgcCRbYKHoNb9oQLdv/5siIZAqvT1Cd1eGg2VfP+AEKcj5Gnm02lMqMEf0TKb4ATa7i1NrVFKEmEYFSmIFxaE/komlkjtwafIWbX4VCYh7ipbVOuy30
x-ms-office365-filtering-correlation-id: 57aea9bf-39cc-410c-ee66-08d61c49b651
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0277;
x-ms-traffictypediagnostic: CY4PR21MB0277:
x-microsoft-antispam-prvs: <CY4PR21MB0277A0662EB543FF97FA2B69FB1E0@CY4PR21MB0277.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0277;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0277;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(199004)(189003)(446003)(4326008)(2616005)(53936002)(107886003)(11346002)(22452003)(68736007)(486006)(316002)(14454004)(106356001)(476003)(217873002)(25786009)(105586002)(10290500003)(97736004)(66066001)(6486002)(6436002)(5660300001)(256004)(5250100002)(6512007)(6666003)(2906002)(2501003)(6346003)(99286004)(72206003)(2900100001)(26005)(6116002)(186003)(1076002)(36756003)(81166006)(6506007)(10090500001)(81156014)(86612001)(102836004)(86362001)(8676002)(54906003)(8936002)(110136005)(305945005)(76176011)(478600001)(7736002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0277;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: sC92naXyNRoDW4M6MjaldMeqzW/QhDxttAi2iCWkj2k7IYWA3heeQ1qLLbW83PJ8+c6CMh3Dzu9a9OukTsiTIVNqhqwmJlzZWxICUgyPHHGYgRWZ6x4sEggD9PJOqoaLudse7tLZghkRLjs0+VkJDZ1jEMJ+D4tkWkomlOPs5ibi1Y+2fqCxY05b5RgjItH+vSyPneH3zs9oAIxuh9wwHJSKGip0ntQ/kIsSVSJ2a9CzyfpydhcuHil9Ba06JUJHH+86gESFW5Rs5CHJCoSrNovtTDYUMLwyBO7MO3/TcMHQHoqMc3p/FHvmovG/QYwg/icHrcn+vLO0HEzvK+LiJoNZLRiys9B73GZzr5V30Ew=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57aea9bf-39cc-410c-ee66-08d61c49b651
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:19.9486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0277
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

[ Upstream commit d5b9653dd2bb7a2b1c8cc783c5d3b607bbb6b271 ]

Make sure to enable the clock before registering regions and exporting
partitions to user space at which point we must be prepared for I/O.

Fixes: ee895ccdf776 ("misc: sram: fix enabled clock leak on error path")
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/misc/sram.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index 679647713e36..74b183baf044 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -391,23 +391,23 @@ static int sram_probe(struct platform_device *pdev)
 	if (IS_ERR(sram->pool))
 		return PTR_ERR(sram->pool);
=20
-	ret =3D sram_reserve_regions(sram, res);
-	if (ret)
-		return ret;
-
 	sram->clk =3D devm_clk_get(sram->dev, NULL);
 	if (IS_ERR(sram->clk))
 		sram->clk =3D NULL;
 	else
 		clk_prepare_enable(sram->clk);
=20
+	ret =3D sram_reserve_regions(sram, res);
+	if (ret)
+		goto err_disable_clk;
+
 	platform_set_drvdata(pdev, sram);
=20
 	init_func =3D of_device_get_match_data(&pdev->dev);
 	if (init_func) {
 		ret =3D init_func();
 		if (ret)
-			goto err_disable_clk;
+			goto err_free_partitions;
 	}
=20
 	dev_dbg(sram->dev, "SRAM pool: %zu KiB @ 0x%p\n",
@@ -415,10 +415,11 @@ static int sram_probe(struct platform_device *pdev)
=20
 	return 0;
=20
+err_free_partitions:
+	sram_free_partitions(sram);
 err_disable_clk:
 	if (sram->clk)
 		clk_disable_unprepare(sram->clk);
-	sram_free_partitions(sram);
=20
 	return ret;
 }
--=20
2.17.1

Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72955ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B22C208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="B3lzeQjo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B22C208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbeIQIwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:52:11 -0400
Received: from mail-by2nam03on0130.outbound.protection.outlook.com ([104.47.42.130]:60384
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728710AbeIQI2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5a/eTus+p4ZX7PFSeik5aTBg1PLY/noCo3XIdNp4tU=;
 b=B3lzeQjoZlvoCFOmdbmK+plrplGUZl49ky33OidipPaZVRjdTPmnOLh2GSB0doemRG6FvtczaY6SpExU7jEjwpAe7Oy+Le11mGRRaW96fLD/K7GIgCIxsGNu3eRkd7q1+Rh5F2UfSjRf1905xB/Itl5pFIweueNERwChxOQWMww=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:03:32 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:32 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 08/87] misc: sram: enable clock before
 registering regions
Thread-Topic: [PATCH AUTOSEL 4.14 08/87] misc: sram: enable clock before
 registering regions
Thread-Index: AQHUTjLeQqX2YxDNwkW5NPWz/Iw0Bw==
Date:   Mon, 17 Sep 2018 03:02:29 +0000
Message-ID: <20180917030220.245686-8-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:YnU9GXb4b2QVumUcjXIKRb2Wi8c2TA91qrtZdG2Zin2ktjt9raxfF/z4E0JB0mwI8FyGg1zc5oE4t/xYEtFSGi5J1RxFPZRPOGklm8k26CJ6wf8JhDhKCogsOZ1wd+GINzqBrnGv7ZpLFe6N+PpvLWfVXcuBhRct3XBFpAHebbUqlsyUBPLCYC4drfEWCvEvS6Br+D924qWp9Es8SKUtnb/P//ZW9YNv5a3Z1KvoeApO58JF9C0sqonxrBsBgfHeMZu+bkAd4U4Mjx4Ds2sqbEJZOVCsmD5lcWlBqRzovyQ/ojjsU69V3vSlheb3e7QS3g5mvJ4FRU1q9nAVJ4L40XNhzVcM7N/39o0yeXblr+tDVUGa/SjBh3NmouaoJwwf2KveAgG0itAAjjcxPe57lhckInJSYr8b9re7qCLuOTC8LGzWUQRttnyItJk3imCD3iluJrgVqa/LK2rmj3/mMQ==;5://3iTMWRSp8wr8JtJNBYMyiJh0gBaYcnBVm79pqapmmKDwLrW4VJdKRCid0ug/IxoKqVWusbpQD0ghBGxMAHm+Ou+3Fq6eDa8RPhyNf0Bnw8tmsTqZPFnWe85G0owQC9K253xYWXUsgw9NAQMEBPYsb05bVYfJdVsyneX1cdZ4g=;7:SVosgCXfxFT3GEpCPs3wsqC8kycmjA36YSjIlez3FFkle+o1ZmXXmqnXq5IBbobKJD3DdZVk59w+TdS61g9ICEZrBjnWKW5u61ZfDLBrb+gIJsTT4zEvTER6aqR/1UIsd+3mUipKFuDtCU6MM3um7bqH/ouhayBHN2+1mPhzqC4DIBgvYR+ftg16NGRW35R/vW9pviunN9D0sjz8Gjj6UuiRU1fXiv7YnK45zVYhr45o1G1OeFuE09G3obN3QjDg
x-ms-office365-filtering-correlation-id: c656dc41-f607-453d-198d-08d61c4a269e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB0855FE2CA218F5FDD86138EDFB1E0@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(6436002)(99286004)(7736002)(110136005)(54906003)(97736004)(5660300001)(66066001)(446003)(72206003)(76176011)(86362001)(86612001)(81166006)(81156014)(2906002)(478600001)(305945005)(68736007)(105586002)(2616005)(106356001)(476003)(11346002)(22452003)(575784001)(6486002)(10090500001)(10290500003)(8676002)(36756003)(6346003)(6116002)(6506007)(3846002)(102836004)(107886003)(6666003)(6512007)(1076002)(25786009)(217873002)(4326008)(14454004)(26005)(256004)(486006)(186003)(316002)(2900100001)(8936002)(53936002)(5250100002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: hkvWsEDHUPADb56weVhh2l2vgkDA/qfEAMAGSS9+XTYFiO/9WH23OYPJ9ljTJDJECSoEPyU50oIFBnIIOeDMEDq/7ccKmHva7hUeAh1jpGmUlgxC70bAcom6PlbM8NKKe3HS4rHsLh0UUA7z1J4iPwmmYnx2X7g6iHYoFiyIqdGndAd84sljjoWtlG6TYUdvzowG1+F/N4SiEvbIeActu43N4I8Ru7TIDMxJFKDH8W7SvcLRg6n2NuL0sHvh2zxe0DMoLGKf+jOlkXjAHnWB771TaEKb1E91rCn7yo9epy2fnzrESBVL4krd1KM74ccN/OR1sKg+l0Z9l5jNf1qGHJer9Nkxa5biP6zGY2tBr5M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c656dc41-f607-453d-198d-08d61c4a269e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:29.5564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
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
index 4dd0d868ff88..8daefb81ba29 100644
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

Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E018BECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914AB214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OqM43K7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 914AB214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbeIQI2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:28:41 -0400
Received: from mail-cys01nam02on0138.outbound.protection.outlook.com ([104.47.37.138]:10368
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728040AbeIQI2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLKRQheYQN51raW28/8HW6LX+YdlykiHe9r0f+zVDjQ=;
 b=OqM43K7whqt7VCQQPkgs5hNaKeVupzaWsE1eGda2A1Qrd7RTrFfzoTP9IDqdsjpc3Pm7JmXVc44xfV1EdNFpj/OpiLK/fmVeaEpx85Aka9Hr1+uQPVq06j2M6IYSIeilO5Q956Kes65SwiCLpzDztDyystuQQbl1sUKYAZ+xMIY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0118.namprd21.prod.outlook.com (10.173.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:03:19 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:19 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-edac <linux-edac@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 123/136] EDAC, altera: Fix an error handling path
 in altr_s10_sdram_probe()
Thread-Topic: [PATCH AUTOSEL 4.18 123/136] EDAC, altera: Fix an error handling
 path in altr_s10_sdram_probe()
Thread-Index: AQHUTjK6vWgpjZw8s0yMTd5W5CMXKA==
Date:   Mon, 17 Sep 2018 03:01:29 +0000
Message-ID: <20180917030006.245495-123-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0118;6:Vr2GksjYl12bDi3YdndIGasgMIkdvSarlOsHDj0FpJrnQDgnfzfeYt0S0QlZCsHHxG+qcxAdD6RyVIWtitQnR6Z8mFUQoj/dOiCuAbgcldMX46VedyPqWTm5kBsdaDjsJGZMgwsoMh9IeW5eE/yY9oU3I41CjKdE55Y/Nf9T7pw8Ch+JBXmoHOE8wuJEEPX7X/lowuvVXNXMhC22SzZP2ze8XGlcaiRqSn2iEwYYnTNiFKWRRQhSDRyPR5kiqhJC2TZ7IeVe0ppmRoFzMFvBPfccGhR8K0OklahEeTCk+yEV1/ojRvm5IqPTLQxi9sCawj4c6HEgYJDz5+z68ERcxW22t5XJWSPRmmwFOUtSAUeyVJxJlwPUcSTHawFi4h+BGBWjcK/OFJ5n4PM8zNFZNPsShVtp4IXTQs/EFDdoQ3LJT3j9VODwBosadZo5x297IEbBx5v9ELMZpMUdum0Q+Q==;5:gBeHbCGKojarRCpW45I+bOW3K8/yDw8tK5XCLYqCXK2qQZNNuSlMhGXA2Q9xlXtQ/XOy25tsYvXW/OMk+oezBJSjNdxBt7hqIJj0CxCOXzSl/aRowYLBaPhAg0OZKAkVJrSVyfzrhjapql0aUVJV6AsXPhB74FJZUNSbBINnYs4=;7:QQPsPE9GAgamY/QWy1W1Ii93iAZ4dMzB+H0Ct9NEuRma2KR9K/kSOLHqQgMriyW5hYtHXTCgWDEbPlpixIw1/mZxKJe8P1EcJt8mhafEVNp+8F8TK+0HFsR7af3dWtmTXr8BHabMe64DWWwoCu/wJOXii+b62rHWZViVzI74KcS6cTbiiXwXfWEV7vt6zIDcKFORT766d7xtqMnl/f1Z3wLf8PnwV5bm/aDsCvGoVUzHb9FaAQ/X14udROSKBs8f
x-ms-office365-filtering-correlation-id: f0fa3cd9-3527-47e5-12af-08d61c4a1f58
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0118;
x-ms-traffictypediagnostic: CY4PR21MB0118:
x-microsoft-antispam-prvs: <CY4PR21MB01186963DB77795E13037541FB1E0@CY4PR21MB0118.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(155761271638844)(228905959029699)(9452136761055)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0118;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0118;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39860400002)(376002)(366004)(199004)(189003)(2616005)(186003)(8936002)(10290500003)(66066001)(97736004)(102836004)(36756003)(5250100002)(256004)(3846002)(6116002)(2900100001)(476003)(2501003)(14454004)(54906003)(446003)(217873002)(110136005)(486006)(11346002)(6346003)(966005)(8676002)(575784001)(86362001)(26005)(72206003)(81166006)(81156014)(86612001)(14444005)(478600001)(25786009)(105586002)(2906002)(15760500003)(99286004)(68736007)(6666003)(6486002)(305945005)(7736002)(76176011)(6506007)(6512007)(6306002)(53936002)(22452003)(1076002)(4326008)(6436002)(316002)(107886003)(10090500001)(106356001)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0118;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: zqx863A3DNoPx1CmwgwQ1N5p8d9340L/0DY5im/YlgNAf3ER0WCTPM7ZYL/sFfLijWYXV8Xpv0XWrfadEE4z8Ljk5g2w9gw3cFqU1FgyCkgv7aBknK2afEhvtpI6MKeBYn+3ouyM//uKbHjW2NpcKJC3dOEvHRYey0/Ld+zyR/xMQDe1RrU3n99TrG7WlTD7U9vnT7nQhgxknVZltZngloB17DRaYBD0/SGlDDF0Hwo9XNQiiHJprF9Y+Z7FbGgewnqUu6ORbKrpEZt0hgnqjzYdKOLTS4mROBaifREG5tTrSvYFUszLTuUAFXK7ODRzL25Xuu0W/wptxokRmTHH0+85Yhl2I3+O08D+yLQr2MU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0fa3cd9-3527-47e5-12af-08d61c4a1f58
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:29.0259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 9d72fe1ce81bc757ecb6d57b58e5fd95b9ad1b26 ]

If regmap_write() fails, we should release some resources as done in all
the other error handling paths of the function.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Thor Thayer <thor.thayer@linux.intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/20180610174532.22071-1-christophe.jaillet@wa=
nadoo.fr
Fixes: e9918d7fafae ("EDAC, altera: Handle SDRAM Uncorrectable Errors on St=
ratix10")
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/edac/altera_edac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index d0d5c4dbe097..5762c3c383f2 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -730,7 +730,8 @@ static int altr_s10_sdram_probe(struct platform_device =
*pdev)
 			 S10_DDR0_IRQ_MASK)) {
 		edac_printk(KERN_ERR, EDAC_MC,
 			    "Error clearing SDRAM ECC count\n");
-		return -ENODEV;
+		ret =3D -ENODEV;
+		goto err2;
 	}
=20
 	if (regmap_update_bits(drvdata->mc_vbase, priv->ecc_irq_en_offset,
--=20
2.17.1

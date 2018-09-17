Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2B2ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA9B208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YpoPMZXV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA9B208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731266AbeIQIka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:40:30 -0400
Received: from mail-sn1nam02on0129.outbound.protection.outlook.com ([104.47.36.129]:32192
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728849AbeIQIbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WFgY29U5T5TzZTjf4E4QP33Vaz0HUfqncEWS3IeBG8=;
 b=YpoPMZXVZK27URU2EQ5LIFYCihv26wadG4P/hzLPAYB+g2/Zs0Z09Zr/FkzqRRy3Da6oIcqHmUOvxbCoPrWQcGgjQYJFgzYxljroGo14a9uj1mdpk8K8CQ5bptC3QGZDiz0Jka1vBIxkgLF2o3W0q1mnPou1zhBgNExwgHyw+Qo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0166.namprd21.prod.outlook.com (10.173.192.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:06:29 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:06:29 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Matt Ranostay <matt.ranostay@konsulko.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 02/43] tsl2550: fix lux1_input error in low light
Thread-Topic: [PATCH AUTOSEL 4.4 02/43] tsl2550: fix lux1_input error in low
 light
Thread-Index: AQHUTjMySsQAgMBauU2yK8RI02gNBQ==
Date:   Mon, 17 Sep 2018 03:04:49 +0000
Message-ID: <20180917030445.484-2-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0166;6:vkzoTJy+NZuecqmYV7cpm0qjfQGVNoZ9lGOxYFI0ekIxgkQ5vGbRS5hc4ZyvKVxElgCoAkiRp7Elt0II0xnK0kst8aPcZNHFxQMn+ZKCmRJsevtFp82ezqxH55uEB/3HAfXOlfwMdvVGVs1wL5Ev8pX2tk8pQKyPgSVjczlZ8yVafcIHSnSTj3VwzKcosB4ku6fT9dvJSytzzB+Y9fRJ90g8xBeNm50dCRg5pFR/Nzp8m22PSerA7JEa/ljIYxZlX/LAcnCiDMF7mXrh3Et8AfyMTIBFo4CwJ0kCoZT+s1DEKzVNqMwE4a3j4qBnHJNN2ZOyj57ngQtkHe+hrxGkNzodYaZHChdAxYSS866RkDWs6zdgLbEFikEmKkwwMhIPp46SCpmzJG83MGNJXgRBmj++X9qssqwYX4RYNK+cfiUppMzjT06FF2yyZ6UCeKzW+xNnnuLPdDcP5cKizY03Ng==;5:pDeHUhhTYFBB72wkKQYZT86eAG2qCm64o4V77dmkOEbZqb+jYk/tWCEe6yxd5nHzaN5skn0/prArKuPAClE2O7yIrgQmZu/AY/4U7HMI49Ki59OmbpvctbHsLZEqEOfznJbxB0HIxTjzMUuaKf66sDyf8YPfOtYepWu/gMmWY7s=;7:8n8kLDAEgdCNL2QoH/2C/Mz9CpnALP+NlI0WEzSpLp2SfP+5+yQ/n6zbxLtzPy8LQpFjsOmzLrKhs0R6M02FUPInaG4sGaRFFEmuYWDjrz7iW5gVMmNX/kcddOVnssHhoUVOOz/b5FdV6MHdeP9QjzEuWmTLM+aDoOZm6wEu29vOTg4dS21F9DaTlPeIXdJT34857bClHvWPGHusTqd7x5Dgrf5ofP/9tW484cMW/tDjZtHDY1i1PcdHO87PNTVO
x-ms-office365-filtering-correlation-id: 4673a25a-0bb7-4876-62d8-08d61c4a9085
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0166;
x-ms-traffictypediagnostic: CY4PR21MB0166:
x-microsoft-antispam-prvs: <CY4PR21MB01667CDBFF0522D61D22D934FB1E0@CY4PR21MB0166.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0166;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0166;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(366004)(39860400002)(396003)(189003)(199004)(305945005)(256004)(14444005)(217873002)(486006)(186003)(86612001)(66066001)(7736002)(6486002)(102836004)(6512007)(2900100001)(25786009)(14454004)(6666003)(2616005)(476003)(1076002)(97736004)(86362001)(6436002)(5660300001)(6346003)(316002)(2501003)(6116002)(76176011)(6506007)(105586002)(8676002)(478600001)(3846002)(106356001)(53936002)(68736007)(72206003)(446003)(22452003)(5250100002)(81156014)(8936002)(36756003)(10090500001)(107886003)(4326008)(110136005)(11346002)(99286004)(81166006)(2906002)(26005)(54906003)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0166;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: vnydIjCGHaD6d7BG4G0rq8SEcLn9nO7v8SnnALrASZcoRMSimyYJ1waXk++Vv1iCs16dDEzDnt3JtGseNiPyWFPbjtUHcCmJVKBfrJJp+4z1Jmnu3+4y37KWVIsW2vEshwo2eNXxjkT+Ykcj/nPSmM8KNwBzV3XNGuxGAUF7AlpXIeL13G2t9cXh5xH2Ftj6r8i/FAmXUdye2eE6G9OLfHMdAu1xBO7/uGGjuH+eIOLWE0NEF3+qa9RurEE4i4HnsKuoMmIViHCti1Jc4Qu96QJpBnHC64D+QMoI5vXu6e42GBVyvZUkFg6D4HILbu/xXU3bKdeeSQGCzn3th1cchsn+XXc6ln5kpGk3X8KBT7Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4673a25a-0bb7-4876-62d8-08d61c4a9085
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:49.9924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Ranostay <matt.ranostay@konsulko.com>

[ Upstream commit ce054546cc2c26891cefa2f284d90d93b52205de ]

ADC channel 0 photodiode detects both infrared + visible light,
but ADC channel 1 just detects infrared. However, the latter is a bit
more sensitive in that range so complete darkness or low light causes
a error condition in which the chan0 - chan1 is negative that
results in a -EAGAIN.

This patch changes the resulting lux1_input sysfs attribute message from
"Resource temporarily unavailable" to a user-grokable lux value of 0.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/misc/tsl2550.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/tsl2550.c b/drivers/misc/tsl2550.c
index 87a13374fdc0..eb5761067310 100644
--- a/drivers/misc/tsl2550.c
+++ b/drivers/misc/tsl2550.c
@@ -177,7 +177,7 @@ static int tsl2550_calculate_lux(u8 ch0, u8 ch1)
 		} else
 			lux =3D 0;
 	else
-		return -EAGAIN;
+		return 0;
=20
 	/* LUX range check */
 	return lux > TSL2550_MAX_LUX ? TSL2550_MAX_LUX : lux;
--=20
2.17.1

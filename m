Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F101EECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E852147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nIDLmPDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E852147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbeIQI0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:26:36 -0400
Received: from mail-eopbgr710095.outbound.protection.outlook.com ([40.107.71.95]:52685
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728945AbeIQI0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:26:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFdqzTTUVax/jK9wffUa+9Z4T+2uBOkXo3jZA6tVFLI=;
 b=nIDLmPDzu1n313LTJ0mS3ecGAght3AYrgRRqlzqb36lZCIpFPQ/g+5obnXl0FUmq7s9u7g5Sczfn1Lk+bANof/DHFPi3M5GbCnj70EIp+MFgw5rKOlU94dz3z2d2/fX8ioFOdJp8F6wcvvc0kt98ljPjLx7Oh+zUbkK5qDGHwOc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:01:11 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:11 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jean-Christophe Dubois <jcd@tribudubois.net>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 048/136] thermal: i.MX: Allow thermal probe to
 fail gracefully in case of bad calibration.
Thread-Topic: [PATCH AUTOSEL 4.18 048/136] thermal: i.MX: Allow thermal probe
 to fail gracefully in case of bad calibration.
Thread-Index: AQHUTjKfktX/+8Aezk2yQ4CJ8fTROA==
Date:   Mon, 17 Sep 2018 03:00:42 +0000
Message-ID: <20180917030006.245495-48-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:J4eXuZoKa457VcuA0Jsl4gM++Loy7k/geqzKdFLpIEJLzy/wAJKcPwxXnhAju0th/feI5yKbj3eC+DTTq1N3QF6LZzjOyBsqTVNihoWxJ/QFVd1rWl3KUcOlXBjBGAlm6JW4BIdrvvZxno6zztnzBJW2jkzrzzHWJHp9nJIAuR0kPlM1trEHw9lIwdHZUscaH4eHaKGRda0oPCZhff5+ubNGj615w99l6K9m1neCfgpR3pHwcnpWGseJz30kRVpZic9hEyhPrKDfudJtH1KoByPj62iXrNcLGGMWza24GF6rC/+hiGd4by+Cl5Cw3xuCfjVzanh4/Fkvz6RGJLaN0IbEdJOMyrFQCWeYYrYO79i104PpMZ2bhTtUcCmHyUtYjmqrOb/UDRUwO47a3fO4sinSvticoYNJJQ3nN6N/0E6NoBepCac010XhI+Oq8ZfphfWvpfbMJ5Si3SN5VZwUSw==;5:TO10iVEEuYgoqNVrZMea5isnBH/x+d083ZjoaHogpZfRRLQg//EBrU+Gqy5t4RRg0kTwb6xt1oTMMEH2NR0X9qkpcRkFghwPCZtiEg4FtE1grdC9SkW9ui5f8he94av3PALfMZOoTWInOhKefA5Rmk4GsGFfVAU/ctwwtka3NK8=;7:/jBhr8sVJQScDQEI3mRUw1/xBC19oVnZdWT2h6Y72S/xAgiBvuUngM2WqILP0f7zJCHfWvxMAah6a1cpc3ujAXB5j71j/z7GhMaJibCTzC7y2uFB1px+FqU7zNJA6faaugcfRC9wmsFn/ng+nA9jAc26Yu83ZyWEfNSaCeHs3uFp97lMecOagMvrrd1n4aJGEW/jg3KuBhRI3LGIy7uTuptMMeFWzMI/rQMXGNyxVc2nvn88oHD5WcYPxTFKttHG
x-ms-office365-filtering-correlation-id: 2639c4be-649a-42f8-995e-08d61c49d2f7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB0167B32C2844F95E6823D4C8FB1E0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(346002)(136003)(39860400002)(199004)(189003)(6116002)(1076002)(86612001)(4326008)(97736004)(53936002)(2900100001)(7736002)(107886003)(106356001)(10290500003)(81166006)(105586002)(68736007)(3846002)(39060400002)(99286004)(305945005)(36756003)(8936002)(2906002)(217873002)(54906003)(86362001)(110136005)(25786009)(316002)(5660300001)(102836004)(66066001)(76176011)(478600001)(446003)(11346002)(2616005)(8676002)(486006)(476003)(6346003)(186003)(26005)(6666003)(6506007)(6512007)(5250100002)(6436002)(10090500001)(6486002)(72206003)(14454004)(256004)(2501003)(22452003)(81156014)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: mJfSP5fK8YeaccIlb6ocOMM8z42lvZKl1T84OQJi4TjGBu39NT0zqKAo5sWIaHZifhJd48VNvADdwutVobUjGB9n0VjVm6IdQ5PQbxDm7HyN747bi2u3R+ht7lTxwDA3lm718Z/7LmNe4LvCravGIl2Vex2mJC8hneSy0QqzbzCmcf9ggmzMX22zP0XDuoQMaXehWbcUKlzvAWbPmW1H5QiDC720yVbKBOvdtlg/O02ko228UuL5Q73jNo9N71tbhnCdO0AKtNuKtoj6ukWKX799l3bsR8B2aPdAwRluydbc8a0RPxdR1R1+OD2zeTZGi7LFETcCcYKWl8FMGuR3zrBJdSPlcojF08/9VXkcRY0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2639c4be-649a-42f8-995e-08d61c49d2f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:42.5264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jean-Christophe Dubois <jcd@tribudubois.net>

[ Upstream commit be926ceeb4efc3bf44cb9b56f5c71aac9b1f8bbe ]

Without this fix, the thermal probe on i.MX6 might trigger a division
by zero exception later in the probe if the calibration does fail.

Note: This linux behavior (Division by zero in kernel) has been triggered
on a Qemu i.MX6 emulation where parameters in nvmem were not set. With this
fix the division by zero is not triggeed anymore as the thermal probe does
fail early.

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/thermal/imx_thermal.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 334d98be03b9..b1f82d64253e 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -604,7 +604,10 @@ static int imx_init_from_nvmem_cells(struct platform_d=
evice *pdev)
 	ret =3D nvmem_cell_read_u32(&pdev->dev, "calib", &val);
 	if (ret)
 		return ret;
-	imx_init_calib(pdev, val);
+
+	ret =3D imx_init_calib(pdev, val);
+	if (ret)
+		return ret;
=20
 	ret =3D nvmem_cell_read_u32(&pdev->dev, "temp_grade", &val);
 	if (ret)
--=20
2.17.1

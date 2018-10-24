Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A222C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 06:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA862054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 06:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="B50CbS61"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA862054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeJXPGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 11:06:39 -0400
Received: from mail-eopbgr80072.outbound.protection.outlook.com ([40.107.8.72]:10798
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726338AbeJXPGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 11:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iOH2xYFSDci1dD5Z/weJC4BmWvwFY2o00is33qxqjE=;
 b=B50CbS61PkltOy+OCoIwJVTZfVZIP/gISUU0Xe0MrzfipbqUQsLqd4xE0qtFu+C0hYOCUk7JOitXM/DWhPqkeWinpQy4WikSJbwdgAn2NfPawd6sumA84j1UVitwDhNMwR4zAi30066xECK0r87VtyFtILEf1p4nyQ9utFNhS54=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3644.eurprd04.prod.outlook.com (52.134.70.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Wed, 24 Oct 2018 06:39:54 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::ddfd:3571:1813:2ee4]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::ddfd:3571:1813:2ee4%5]) with mapi id 15.20.1273.019; Wed, 24 Oct 2018
 06:39:53 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] thermal: imx: fix for dependency on cpu-freq
Thread-Topic: [PATCH] thermal: imx: fix for dependency on cpu-freq
Thread-Index: AQHUa2Ref+fMFTxEzkOrPUZd06/1Xg==
Date:   Wed, 24 Oct 2018 06:39:53 +0000
Message-ID: <1540362909-32481-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::26) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3644;6:S7DA33ppyDexCK+Uu4HIss6R8XAoN3WwL5tRN+Y/zU1Ss9VztyrObF1DfzExK3uOR1QOT11nTvwf7E4v4tzm3nfIOZaXlOCWYifggDyzFJVP6Bq030etNp6M0FYzFN/Zjhz1UWyh8tXqpcUpWTff3888zjuOTXC/+k3x6782h0bzCVO2UWNpu04ZQ/Z3xl3lpC91OJW+IvODB496mOnvuSu+fh/n7K9E37e0EddGPORlGaPZXMa6KaiQv8aXv0CyT8enC8HSr4Ts3KgDjxumKc+MQ+yvbBx1x0miw0VLW/ktSrg7IwnRiuU/PN9ltjC6UTT8coSKxM+KdrRLgQUXe+CKig0X0El1u7INPbBeRPqFUyxyORygxMqGGmgrBy8ymSUMceVE34R2RmB4Dds5eDxm3QAm8YYgiWYoqNNE+Zjhj1fnPfpfEWRYU4JXPGR/rdY3Rny3p75KKo/vCbDGrA==;5:wKTPN/Edy5aCiCjtQBcOKzw73bO/wx4d34n5NrXK6HdYhTa7Djz0uonbHqrYmbnrb5KSV7TZvmbfsJAWwHD5YWKSrWwdtBzE6hhVuQ/fiBZlvZRLxnlnrZR4OPWm8Sm/3pSV3lCVxwyllEskBz62lDnqOmYb6VOle5ab7hNClFA=;7:0GDDwen98QSBKZpCbP7enncEtiyl7I1S75NaGCIGrOdR0Gy6fNkPFlhMaYJRBs69iJj603Se8P9h7g2VenID7fkbmzZh2rei83WnKryptJvjrVrouBjDbg0y962QOot6je3+OGZfCktJpRLMDyzFjJHjJ7xT6A2vqGYTHcVM7zaM0HOU4VITpQ1qiKCGKpRchoanvQDaNwedvtnghk3w9GKICyW43/R9zpXduw5TZr0hv7ebjtLOI2Ltho9kmsqt
x-ms-office365-filtering-correlation-id: 763c68a8-5b4f-407e-0c00-08d6397b8136
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3644;
x-ms-traffictypediagnostic: DB3PR0402MB3644:
x-microsoft-antispam-prvs: <DB3PR0402MB364496EE63BF843E0BFE84B5F5F60@DB3PR0402MB3644.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3644;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3644;
x-forefront-prvs: 083526BF8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(366004)(39860400002)(396003)(189003)(199004)(36756003)(39060400002)(97736004)(66066001)(2201001)(14454004)(2501003)(68736007)(478600001)(6512007)(86362001)(53936002)(476003)(2616005)(256004)(25786009)(14444005)(50226002)(71190400001)(8936002)(71200400001)(4326008)(486006)(7736002)(1857600001)(5660300001)(110136005)(186003)(102836004)(99286004)(81166006)(81156014)(316002)(6486002)(6346003)(6116002)(6506007)(386003)(6436002)(305945005)(3846002)(2900100001)(106356001)(26005)(2906002)(5250100002)(8676002)(105586002)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3644;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-microsoft-antispam-message-info: wgrnVvL90+19gb2GZkoUww1T4vH9HJYwz1/54mRiw5He7b6OMwIOCjFQKfqFNGytVPWzP/ProJ9B95rU4gRi5DMQwYSQ3GoUp2nJLZVW7/ZFW6dMs3kbbU7jqB5pkN2MGxJhczGtK7fXlon78E5pFvXQvs/8UiJP4e4BdV17yfZ2SSFSU8TUFJqotpH45Sbc8jUbc0mhqbgxBpE1QbZQEagBKaU/teEaz4VOJEP26V7DMLhNSarViRewRvu1MMAUUo4cB+FJh3BPU0Y3KEO+YWncrQinuUIUGIdSVsBZRoVP4TXFPH/vDdPPkEB0jRRJUVxXCiHEsIGMSAdJuwoLuQDCJaNbiBSkCEBAx3L+nho=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 763c68a8-5b4f-407e-0c00-08d6397b8136
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2018 06:39:53.7782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3644
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal driver is a standalone driver for monitoring SoC temperature
by enabling thermal sensor, so it can be enabled even when CONFIG_CPU_FREQ
is NOT set. So remove the dependency with CPU_THERMAL.

Add CONFIG_CPU_FREQ check for cpu-freq related operation in thermal
driver to make thermal driver probe successfully when CONFIG_CPU_FREQ
is NOT set.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/thermal/Kconfig       | 2 +-
 drivers/thermal/imx_thermal.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 1775d44..c8a6352 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -212,7 +212,7 @@ config HISI_THERMAL
=20
 config IMX_THERMAL
 	tristate "Temperature sensor driver for Freescale i.MX SoCs"
-	depends on (ARCH_MXC && CPU_THERMAL) || COMPILE_TEST
+	depends on ARCH_MXC || COMPILE_TEST
 	depends on NVMEM || !NVMEM
 	depends on MFD_SYSCON
 	depends on OF
diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 1566154..87386d1 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -648,6 +648,7 @@ static const struct of_device_id of_imx_thermal_match[]=
 =3D {
 };
 MODULE_DEVICE_TABLE(of, of_imx_thermal_match);
=20
+#ifdef CONFIG_CPU_FREQ
 /*
  * Create cooling device in case no #cooling-cells property is available i=
n
  * CPU node
@@ -668,6 +669,7 @@ static int imx_thermal_register_legacy_cooling(struct i=
mx_thermal_data *data)
=20
 	return 0;
 }
+#endif
=20
 static int imx_thermal_probe(struct platform_device *pdev)
 {
@@ -743,6 +745,7 @@ static int imx_thermal_probe(struct platform_device *pd=
ev)
 	regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
 		     data->socdata->power_down_mask);
=20
+#ifdef CONFIG_CPU_FREQ
 	data->policy =3D cpufreq_cpu_get(0);
 	if (!data->policy) {
 		pr_debug("%s: CPUFreq policy not found\n", __func__);
@@ -755,6 +758,7 @@ static int imx_thermal_probe(struct platform_device *pd=
ev)
 			"failed to register cpufreq cooling device: %d\n", ret);
 		return ret;
 	}
+#endif
=20
 	data->thermal_clk =3D devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(data->thermal_clk)) {
--=20
2.7.4


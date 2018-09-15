Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E37BECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0733721479
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IayfGcOL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0733721479
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbeIOHHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:07:21 -0400
Received: from mail-cys01nam02on0095.outbound.protection.outlook.com ([104.47.37.95]:24416
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728409AbeIOGrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqlxyZw1arMqUXY3ZayJtA/gxVmQeEovj6+XSE3gFFY=;
 b=IayfGcOLj352WuQyGdJly3TEX1N3td5LtoxF4PwMgbOG5T4wXMpCx8nBam9lZAYxfW06j7xouKhxMGRClvNozOTaffTAQ7+0AM5hAo99mfT4Ls3aUv3wcBynQaLLLkd+g592XhE2jUWQr9CiynMWdchX8aw8GytmM7nudatT+Dc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.6; Sat, 15 Sep 2018 01:30:46 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:46 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stefan Agner <stefan@agner.ch>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 40/92] mmc: sdhci: do not try to use 3.3V
 signaling if not supported
Thread-Topic: [PATCH AUTOSEL 4.18 40/92] mmc: sdhci: do not try to use 3.3V
 signaling if not supported
Thread-Index: AQHUTJOoI2C1yh4eYUa7el03TeDqFQ==
Date:   Sat, 15 Sep 2018 01:30:17 +0000
Message-ID: <20180915012944.179481-40-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:kLwU5PYH1roROb9XPqvoq238eCJ9pAf4UU+t7afhPiYhkvETKP60PPByJ4l3wPDgIUSUGmjcyz2rBupkUlFfha+GFjYpKCnItm5ILSwVSO7VMIkksvETffyaKVQU1wj0AWU6v8xGqVDZv6Ng3f7XMkicE7gleJW4HOsqzzmQW+HEPZEnswi2puKcb4xtQgpqOlUucit+d3UdH4c65bMqhEhZ6i1CgWJfsTelQx3J3FMB27UwKZbu249xKdbGCGMxt9T8Y90hTo+R7C1OwX8ftxaxNoWSEY0dpQ/6p+RkdkpgjgCLAPt3wUbtS66jnPnb2TQ02prk9xIYfIiBBTW9TGlzeOT9NYHTouAMW0NoALEdBHpRuS2GntvJNTy8elZlTi6bzoLQow13nzRFEP/1P3eeFXegikleJAeyxtwTtP2xVP1IL4oT3X+c6xZVLgSxER5pPy0OXnasvMNsYcniEA==;5:xFerzojIl1wI/+4z1rWmaHeRsydLMAs5/gbDPEd3GiId5sM0633URZl3JBT7Ps1urKzVo2BQCbHEkx3wYLcrOZU695ZFwBwMORKWpKD+lMYmxbVVeaGxM920UuOfrtHEJKnzuKB26VNUnKiBQvZFzdKnwAgSaJojrmp13U3Tk6E=;7:TisiUUQ3eqZ+BLp6Dn0CDIDPcU4OWFDeZ+PqKzXbI5Q1ythAdnGQouvf6OlBwuub0A1YBjvtNC32Tksx18GvsAMuwY8407keIiCiYfEGqaAYSc6Zz5ub9g9Db2S8RESiM8MdDTswGr1IWErMjvPHKDHliw4ZgqBoyfQeTJwNGpI28e5k4os1tqSwrZzpKykG9JY8lPrQCuDGrutGWH4gXA3FEXg1zyDUfnf4s9+E/R8xhzZEYpZepF2bAHRAxM8r
x-ms-office365-filtering-correlation-id: 4e88b0e3-4524-4933-7ab2-08d61aaadca7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
x-microsoft-antispam-prvs: <CY4PR21MB085635FA9452E0AD8DA11838FB180@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(346002)(376002)(199004)(189003)(36756003)(6116002)(486006)(316002)(3846002)(8936002)(22452003)(446003)(11346002)(2906002)(476003)(2616005)(6512007)(107886003)(53936002)(54906003)(1076002)(110136005)(25786009)(102836004)(66066001)(4326008)(217873002)(99286004)(14444005)(76176011)(68736007)(575784001)(6666003)(86362001)(5660300001)(6346003)(8676002)(86612001)(256004)(186003)(81156014)(81166006)(6506007)(26005)(2900100001)(10290500003)(478600001)(7736002)(72206003)(305945005)(97736004)(10090500001)(14454004)(106356001)(105586002)(5250100002)(2501003)(6436002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: w0p/Bn5DW4gCq7jTR/GCORq6qchCtOtQhjeTRhMTT+aohXxIk3RT2EC7/E+38OsN/cTRpPtuSGbz5IYH/E1yb+qdDlX0ATPmJiAY7xxF6JzBRYYwg/ta4DddYnPGtTSdI25THvOkCFH9+Aw6Bw838AsKafQQ7VRH0+JpYfSmQCBrwSxwjcZfjM5EpVYhwGj6O/EBqO558z3MnqzIxYO5FBJsxRw9WcnY3euDWNEjBhilaKx6VSn7vUnCxkKjtlPNkrrnIQFsxkhWoNTbc5mBz66ymKkZr92ZdSJt7YltfKjPqpUgpPPRszulreX9qK9s5LEiteCANMtecIZ2K+DxtrSr0zOFgTxTX9HTqjy3800=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e88b0e3-4524-4933-7ab2-08d61aaadca7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:17.4637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan@agner.ch>

[ Upstream commit 1b5190c2e74c47ebe4bcecf7a072358ad9f1feaa ]

For eMMC devices it is valid to only support 1.8V signaling. When
vqmmc is set to a fixed 1.8V regulator the stack tries to set 3.3V
initially and prints the following warning:
   mmc1: Switching to 3.3V signalling voltage failed

Clear the MMC_SIGNAL_VOLTAGE_330 flag in case 3.3V is signaling is
not available. This prevents the stack from even trying to use
3.3V signaling and avoids the above warning.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mmc/host/sdhci.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1c828e0e9905..a7b5602ef6f7 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3734,14 +3734,21 @@ int sdhci_setup_host(struct sdhci_host *host)
 	    mmc_gpio_get_cd(host->mmc) < 0)
 		mmc->caps |=3D MMC_CAP_NEEDS_POLL;
=20
-	/* If vqmmc regulator and no 1.8V signalling, then there's no UHS */
 	if (!IS_ERR(mmc->supply.vqmmc)) {
 		ret =3D regulator_enable(mmc->supply.vqmmc);
+
+		/* If vqmmc provides no 1.8V signalling, then there's no UHS */
 		if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 1700000,
 						    1950000))
 			host->caps1 &=3D ~(SDHCI_SUPPORT_SDR104 |
 					 SDHCI_SUPPORT_SDR50 |
 					 SDHCI_SUPPORT_DDR50);
+
+		/* In eMMC case vqmmc might be a fixed 1.8V regulator */
+		if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 2700000,
+						    3600000))
+			host->flags &=3D ~SDHCI_SIGNALING_330;
+
 		if (ret) {
 			pr_warn("%s: Failed to enable vqmmc regulator: %d\n",
 				mmc_hostname(mmc), ret);
--=20
2.17.1

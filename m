Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3E4ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A1920866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VtfVaW2W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A1920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbeIOG5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:57:33 -0400
Received: from mail-by2nam01on0130.outbound.protection.outlook.com ([104.47.34.130]:13056
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729619AbeIOGvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kZBkl+NaoRDbObpHK+m9dL8AfNJrZtDhhskdK6m9s8=;
 b=VtfVaW2W+iBkpLsXpECg88h57tk+Wz7Gm7UnKJ7XglU1UQ1rOU9bt2hiVoMeLZSIHEJBDgnZSP7dWpNYVGpCxtlXQH6YrFbr3zFuRN/dRg8G4d/iN+P3AXEq1xkAsIWp9vXOcChPLVpRhU+bYyXzncw21FK7WGeTwmjl+K/yvDU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0823.namprd21.prod.outlook.com (10.173.192.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:34:35 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:34:35 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stefan Agner <stefan@agner.ch>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 15/34] mmc: sdhci: do not try to use 3.3V
 signaling if not supported
Thread-Topic: [PATCH AUTOSEL 4.9 15/34] mmc: sdhci: do not try to use 3.3V
 signaling if not supported
Thread-Index: AQHUTJRCckhgolvEdkiXwEm8SZbwPg==
Date:   Sat, 15 Sep 2018 01:34:34 +0000
Message-ID: <20180915013422.180023-15-alexander.levin@microsoft.com>
References: <20180915013422.180023-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013422.180023-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0823;6:QG3ufE4J0Ln/GwwYwdA4uMnJEfI4CxAVoUa+9AFkMvNxYFxuONGYjXH8w5O3P+kzXhl+twx43jUFIgFAnWjejKaCe++9FCmLKrvNvA34M1ooloT8Po5fDPoemaq2nJA9D3EJrTmRboR4kRtPq+4jZOZUvgjiW67BE9E7V19BU6f/nIoBnxlkyQhOGQLFHXrZhYd8OJOHrzDilSnEsuqTABHH4tOclNpqSaRkL7MVxjRQouT2vWu5PpWk7tDTWKjQwZ7A+iOSZEJ6uR2H/lNFTvk6A20i7Mw63pprQDnAYIR1va6+QSsapvcJUMnk4uOvzO4ZBOi2JOVJ43as4wh9pVktAAjftCeXB68C7UAS5uZiw0j63xfXEG+HBcdQ/kTe2OwBBUuTScSiljpFxIDXb2+zcQXav0EV1wsgtzfiForChceBeslIH2iQGZzwBqXuthxoBTYEK2OuUaxWk6B16w==;5:BuOp2/a36qGB6y3Jb7YsFSAvXmi2rymiZb98zbqpPIIdJneud8ZUuUdR88pouuGDB15l7CU4K5tKDzqm3ZSKKxvoBykBJnd1I8fZwzxlbHR7a0h6bLf9ub9ChHkqRJGu0pU+uaMZWuU1WdlljBvY26Uzd/ugOJNqzRGb+/PFrtM=;7:RfXsceLe9oK6AeUujuLFhylTr87cfvN81uQt2RoOUSFFeVLrHv8cHyZV6gPQ1COdyUSGR0EQMkuh3ZY3sm1hjvmFqsKXes7QLlzPNuPDBXpSe1lGQ9ph9AOJNcCQjh3YxtV4Kg43j8j01196yCm7/zkn6e0kcTN1+9vKrQS7p0g5Hj6KdyzuNw6tFGFh9jeJU3LooPpjrUYyJ+WiyMvAKNraCOVBi2/LInVFENxKWraSOxibTtIkQwsrNOC1XScF
x-ms-office365-filtering-correlation-id: e1c24148-fbf1-43fa-af99-08d61aab64ab
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0823;
x-ms-traffictypediagnostic: CY4PR21MB0823:
x-microsoft-antispam-prvs: <CY4PR21MB08234479A669F2E44767FE4AFB180@CY4PR21MB0823.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0823;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0823;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(39860400002)(366004)(189003)(199004)(53936002)(14454004)(2900100001)(3846002)(6116002)(14444005)(256004)(10290500003)(81166006)(81156014)(217873002)(76176011)(72206003)(478600001)(8936002)(25786009)(8676002)(86362001)(66066001)(6512007)(86612001)(7736002)(305945005)(97736004)(11346002)(5660300001)(5250100002)(102836004)(54906003)(2616005)(446003)(6436002)(6506007)(476003)(186003)(110136005)(2501003)(2906002)(105586002)(22452003)(10090500001)(36756003)(4326008)(68736007)(26005)(107886003)(6486002)(486006)(106356001)(1076002)(6346003)(316002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0823;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: /d7bTQU8F91836CKs4dYf6S6V0xdIeA/Cij+ae+WYL21Y1QRVSHQuyAUEWVZpEqxKVBCgQpu8+jgoReRFknDqQQ7dhJHjy797aXFKbQMaKedFbG+8NYJg0UuuD5qsd0amZTus0ZIxY2Ez9iYlPAWb+hRxECJ3dqarJxx08L1BSJps3tBt6HjkCA7JM4knoals84J1WBw1gBAeMutPJ+W8v97Hta2yGKO4jyDJJ+pv3Imlwl4JvXmK+JvA1bj8PJ3PVgn+isc9a3WgvOaABZr+0Vo4yZq+QV7AbmShW4m0ri2LbepeTV0+2iZjh3r9vqOCQYQYI4WL4hLwpVOyLEacqRDpy8hKDCk2SHi0k4i68I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c24148-fbf1-43fa-af99-08d61aab64ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:34:34.8956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0823
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
index 44ea9d88651f..6bf58d27b6fc 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3328,14 +3328,21 @@ int sdhci_setup_host(struct sdhci_host *host)
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

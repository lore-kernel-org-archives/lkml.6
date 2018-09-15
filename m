Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05834ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74EE208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Ctis1hSY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A74EE208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbeIOGtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:49:53 -0400
Received: from mail-sn1nam02on0127.outbound.protection.outlook.com ([104.47.36.127]:18752
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729300AbeIOGtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:49:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdrMLB7yWvMlF3oYXsMLGcmDgVvfeYq6o0Rc1yt+0ss=;
 b=Ctis1hSYWn2IURSVBkqtvIvMCzj1dze0+oR4LIwQLB8r4WAOSFQyNqsZC0JYlu4BjLKyVsi7OX2c7jdJEygRkHAOXkg26f+Xdpd7wxc5wbHuS4O4Lm2Nbb9dMWOeYK3Hk5gBGQgx6yeFuZ9gh5xIcxGQIxfuT4PrL+0OZtHl5ZQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:32:47 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:32:47 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stefan Agner <stefan@agner.ch>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 28/57] mmc: sdhci: do not try to use 3.3V
 signaling if not supported
Thread-Topic: [PATCH AUTOSEL 4.14 28/57] mmc: sdhci: do not try to use 3.3V
 signaling if not supported
Thread-Index: AQHUTJQB7yWFPrAnY0+rVmmWBdnjYw==
Date:   Sat, 15 Sep 2018 01:32:47 +0000
Message-ID: <20180915013223.179909-28-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:ABT1vSgENebgj0qhsWHH57slAHUi6eZFQFtf3zC/OLZ990lcjxFRDs5IdIZeZgo7gbdmZCvs81PzaILZpWY2VtyZCGY0MWIpzTM3x5Cz7TSsszo4hm6nTjRfUoZmJZHdmlQMeEWeDQfr1PnkeSHIv6Nb1+yXYyfUvSNXNVW+xJ6SIFGYy9fpgaMNmOmJu8/6kOvToikqDsZeIE7jWPmsE8nJS0oclOg6dYny5koafApmuVBjiHUSoiQaFGj/1dDm/ZNhLIQixKKqGZtQyqsD017AfMxeg+wAnACcdycbEz+5Y5iosryCdFRcbQzGxqD9qKp85P1f4iHXzlGvMckpgbfLqpVNng5+tioP+ZsXMc6NR/gVKmFvRnDGFV6sOMYnuZG6E6HVKr+7B8YcWKEITyrPaYfSsrwlwF9kgp4I19PRXq1lnt9a+5b021DTfQY6+en7pW6RAzaS+gQKPCIMDA==;5:jstOzwlNMhkS/ROgtjS7Hg8r5WTBJr8dA4LtSgWy9hAtj0Jfww8P5Ernn5bcHssJGW+cQWQsXLDqDdxL7a1RO53J7560TPzS7CQbwgNXkN1t1CEK4/LBvUkEXmYMaUYUgK5jE0NnFfq1JfuQoatAYVrw1vP+qz32yHr9NqpM2O4=;7:3/FmFG6b1zGqFeqzwaT9pTfhYKbEyf9wBwF7+tK+LVFtoi41UCfMRWTOOuJ6M0qR/Yz6BOlMfvT88ZN3o7hJKvVI3JhiDITivvl6SUJU14hnbHcsAp5veG7Bx7snKcsZfC6glvDX5+gZs0DN5ieuV/9fpsYzXMvytF/yHkt9g76LRt61583MvYNqK/yKsOWqpCc0MUNLcpn7i881gG9nQpyeSH0M/0WY8DH8+8tVgtwGuGRVSjy/xV6Uwbj2wJXk
x-ms-office365-filtering-correlation-id: de8a567c-036b-4a56-eb08-08d61aab2472
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0822590D6EE5D856C9D9F631FB180@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(1076002)(72206003)(6506007)(102836004)(478600001)(8936002)(10290500003)(2906002)(81166006)(81156014)(5660300001)(22452003)(2900100001)(8676002)(110136005)(54906003)(107886003)(99286004)(25786009)(4326008)(316002)(10090500001)(97736004)(305945005)(7736002)(6116002)(3846002)(256004)(14444005)(66066001)(76176011)(217873002)(6436002)(14454004)(36756003)(476003)(86612001)(6512007)(26005)(5250100002)(53936002)(486006)(106356001)(11346002)(2616005)(6486002)(86362001)(446003)(186003)(105586002)(2501003)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HAIDsVJw3DF8TSBrkPwBNLXKj13hSoHPVnZ94ej0VWKzBV020Z12btWeIJNN3QC6DXhMZYbnSxIF0GFilnrGDOrTOCUBEqAosLcWRhJWQPrP0qp196bbaGySMhIRGKeHKQNWxzYojzqaO2UnguF2jAFHXAWV2u7B6kTrESycqcdX2ycFZWImV43eJaDp1Z//JcvH8EpUE9K4mG4gzjeCZ0UIEtvGWY4yg0llvWJGQjGd9O/O00p0WxTcUIzZEaT59FtuwWlKwNbCrjlO/PsAtGtqmzdlFx9hH3uiYRm8TAp4r2ZcVptgE2UWBwS8wMMwouhKEIt93IlDVts4KJ9zlj47K7uHmKi2xzWI2aVUaPI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de8a567c-036b-4a56-eb08-08d61aab2472
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:47.1963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
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
index d35deb79965d..f063fe569339 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3631,14 +3631,21 @@ int sdhci_setup_host(struct sdhci_host *host)
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

Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348BEC004D5
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 08:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8DEA2064E
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 08:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="NcFkfQ25"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8DEA2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbeI2Or3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 10:47:29 -0400
Received: from mail-by2nam01on0074.outbound.protection.outlook.com ([104.47.34.74]:13984
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727540AbeI2Or2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 10:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/4/x1Ni0x3sVxH3a8b+moksKb2WS9r22ci8JrDCBn0=;
 b=NcFkfQ25ND305UjjvnuyGD2LzD4CIQwgWQzFxscJPICf38ybJwSRFfG/WGx4dbSMUlJOSBBiZAupLR2HhRKcJKwVMsfA2Ge1pdQjArF2wH6zvbkRL2a8gJ33jEm0khZFFSoPmpNYyx2UhnI2C/MLYst3eCAwnu0ChCXS/+P8rxI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jampala.Srikanth@cavium.com; 
Received: from hyd1621.caveonetworks.com (115.113.156.2) by
 BN7PR07MB4610.namprd07.prod.outlook.com (2603:10b6:406:f2::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Sat, 29 Sep 2018 08:19:52 +0000
From:   Srikanth Jampala <Jampala.Srikanth@cavium.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        sgadam@cavium.com, Jampala.Srikanth@cavium.com
Subject: [PATCH cryptodev-2.6 2/4] crypto: cavium/nitrox - use pcie_flr instead of duplicating it
Date:   Sat, 29 Sep 2018 13:49:08 +0530
Message-Id: <20180929081910.17652-2-Jampala.Srikanth@cavium.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180929081910.17652-1-Jampala.Srikanth@cavium.com>
References: <20180929081910.17652-1-Jampala.Srikanth@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [115.113.156.2]
X-ClientProxiedBy: PN1PR0101CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::34) To BN7PR07MB4610.namprd07.prod.outlook.com
 (2603:10b6:406:f2::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fc51bfb-87d2-4ec5-0162-08d625e455e3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR07MB4610;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4610;3:+/HjCNI3QjSa/KvZTgx3mDl51+ocsctmH6XCoMHZ9nFxzzQ4L/V6cgFV/gi5+kMcDUjeIaO/MxUmSTht4N30G8nH3gpmLCpua9fpKO8sK0j5zP9W4M+eDHeZov0p1ISa1qHIncG6tCk4S603iJW7Y0WdaDXPp/dU0Pf1+xvfTx5hBVk2OcbavxjdPZ7svZ0J347pP8/VNs1QDrMGkC5YktHdwPeu9SA4Lkcfx/I4FyRaRDfBGBR3R28YRFRJK5u0;25:GgdDy6ODXp5jJD9rY4xC6GTIrDP6NiTrkZNIfYgY6Ml16EmowbESW3LoyiJo6nQdIofwXi/gea9OCMusZgLwIR5dyRPS2O+HrjTVFTepSzq8CcBMO9O3ou7UvD++kNf9iz8KO5GBA8yLWz5Mjtuuk43HnpFJSSm5+FFTayok2xkjy0rHLl9TG2fnvxDs1w2WFFBrnTqmDgYXMvg0GtnjQvDIgEex794NlRSEBfgbD4U4YcPmekxD2rPHnP56OebOwcUa/h5/9B2hXXgfvEpWCYLGZsuHfZ9Nf2KsAWBGRJ2QA7vOxE6ZROIG9wVXOo52BdT27blcxVO/DHkpvbaYbA==;31:OLOgjxCHRT16/99LQLNRmYJr+Qn1/Loc/eTq+O/kAebo+BKtC2ar/xBat1CFEopO74GEc9MlAYXWTIiZVIKnaG/4qqwQUlX37xFWTmur/dkXSSlmACARhs7iY7qAoVWkK4xnmZx/8pqFdmaX6pwOn1wsgRTqJRNHzldAofrJCILNXXpBVBgofsZ3YDCydBOGFvlD6mr41YkUF/2SrlV/hZiPwaVBr12xiZyS2Iymtqg=
X-MS-TrafficTypeDiagnostic: BN7PR07MB4610:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4610;20:e3P3ppdqonpdl66oCWAgN+Ef56B/zTfNniVH31chtL3G5GTRcaR/M7YZ+DN/KhshbvTNOjarT2MKjMMgsPa/eQfhFZYFittyCDb8MlMGLRNHCbX94zb7Xck0p6oBJxN17XaWrYVI9Y7JvmMMqc5oqO0pjfkvObokELertwOLCGZ4up5+ZogyjdP1bnMymr0dEtTLwJyTrV5aWvr+WKXy8lqwh3DvJeoHZ+HoG8p2J8kH/t+Se0DaO5lVeG59uurpOEgQGm7FtsNqXDwvDsZGGHHinFDXLeUniWyuZCHo7VGl1k/6rFofOJ4HPSH37s4IG1ExnbCz1obopYIWZ54TXYQxNEZ+vJRgQOaU63Sz2qUk9UdapWERdHHj9mY0j5R8Up7Lc/Js+bCpNV23pBe7A5x+oL0sIZGKaS72nZrKaPOel7ikZuRoZdJ4QI5iM9Mm2xLSRi8wcsSlhEIXZ8rjAljyJhbRvWCShRnhy+1a6i3W5yB9qV7EV2FExshS9Eo5;4:2Rd2ggggMGks1To9KL5AO5d72rV1HpOaEFbkjCOZid8gJSJCG/AirqeUt1JBALcm3XvizDZgF7wgB1HZPzxcrgkx1SnUvADli4LGxxwahf3J9eb1GUYRbKw7We01to9cknxeeYEL0gxLoXi/CXROlIx6xPMrO3f8YZ160+j9onjxW4W8lzg3QGy2epxrLdxDiTWu9MqasEJ5zbLEqcczIetKWqQy0Q+OsDIfZ2OX/mqo91gzxi/yDYVGreZG/UHgi7u9t/dXza6SdiASyoClbA==
X-Microsoft-Antispam-PRVS: <BN7PR07MB461035D72C8E6D6A9BD7CD6DF4ED0@BN7PR07MB4610.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051);SRVR:BN7PR07MB4610;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4610;
X-Forefront-PRVS: 0810818DA0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(346002)(376002)(396003)(199004)(189003)(7736002)(11346002)(69596002)(34290500001)(956004)(386003)(53936002)(50466002)(81166006)(105586002)(81156014)(2616005)(68736007)(52116002)(186003)(6506007)(6512007)(50226002)(106356001)(8936002)(16526019)(26005)(53416004)(86362001)(76176011)(5660300001)(16586007)(48376002)(316002)(6486002)(25786009)(51416003)(478600001)(72206003)(3846002)(8676002)(66066001)(551934003)(6116002)(6666003)(47776003)(446003)(2906002)(476003)(1076002)(107886003)(36756003)(97736004)(305945005)(486006)(4326008)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4610;H:hyd1621.caveonetworks.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR07MB4610;23:7SzFW0QvT8LsclB5dtufZu8nlcugYpCQIABqd46iS?=
 =?us-ascii?Q?gBNxux6qOwJxsdmYgv5SaRNr4/XGofR0uIwXSSGieHIDG3cRiubMVEnnhQlr?=
 =?us-ascii?Q?Lc4KdWPiBRX7yhem4NtvP38Iw9kLylYiWVil0bXNGPTLsZp+z+q0PE/OLHBn?=
 =?us-ascii?Q?EIOmm753+WyObzlJdrp88N9Hb2KGbGrYtnlVDHqJeqb9ERhgLjg27qup5mQY?=
 =?us-ascii?Q?7aHF/P1QIZINs41EwWXJgUuGTA1AZweO0HQWEQQrWdV0zDGWaQKQCaRS1JQF?=
 =?us-ascii?Q?kN6c46UMxgo622hg2YaSp5fwWtTH78kkpHSQ9Wee7AYVmf+PTPsYHUNCUI8y?=
 =?us-ascii?Q?CWWAdvgYoKJB8CpqdGuWYe2OMTP6nsiGh+eL91DgedFw5XBC8ducR7xKq2Ro?=
 =?us-ascii?Q?rd5Fu43WyeTMMvX1KdYWOFbvZOBgcN+mCsx0OUGNXaChk6PwZuKT9MCwoO+y?=
 =?us-ascii?Q?j5NsTNUisPiGFnwaMKVVCdZoMElUA80JFRRA1K/v94mrZ0rcCGNC5weIBrn5?=
 =?us-ascii?Q?utHNv2d1d13lTLJQyoK6MiBMSy7BC//10K7rd1QAwR4m6R3mLZYSgQBrF9Gb?=
 =?us-ascii?Q?/7yY7WL4yWfCzHu1mFL1JoDeo3xTKPz0gW8BipMBOsdo8uYjVLUWYPnGYqmL?=
 =?us-ascii?Q?ELYitW9tRR4UeXUVZ4EWIPl/iiAyNiyQddFdDjTSX+cDE9f27gz22zgYQ5D/?=
 =?us-ascii?Q?YIqHWi03dN05uNb9zShfZWd2cGm7QGE0IfILR7X3fEiZKKJaI+HlhrEStZ2C?=
 =?us-ascii?Q?zW2froLiqlL8hV+nd/PK6XqKfK3AxKQKmvM+2QWiJ/Cyib2shPCjS1ZvMo9Y?=
 =?us-ascii?Q?5Vt9eAU7kkjBK4fjNwvA5AYdL63Xya5KgsenTu4+8fz3y1G3UgSR0SEdkZIq?=
 =?us-ascii?Q?UvXnAtxRqzSpyZsl1cgKF0XCIlC/f05iV5lEEwdMJk01HU5Stc1+AakqqYxK?=
 =?us-ascii?Q?9PbZRPM6h23sjXzkgGdEuSWhNmPNUI508QV7BwuXCX22P9lNK4mkT1FfIaQS?=
 =?us-ascii?Q?V2z8Oc45d9DiGDU1QxIS+CH0VPB1fnzlj+yvxR9ONAg7CmGy9jTV7isfUoHQ?=
 =?us-ascii?Q?qnTQRefziZwWftFzXruB3f7Y/bDcENDI/pLMULJjyjHAFjdkNXHbp/74Cr04?=
 =?us-ascii?Q?RTaKXJ7NZJtOgZk1h16DbiR9vC9KObh0muMzdBqKnfKQTGANuAywsvKHWWB0?=
 =?us-ascii?Q?psUh4VTZ9bHtRGT11aK6NsBjrDaFjgjjmi00RT3FsiMvppMpi7VMEsWXEA87?=
 =?us-ascii?Q?gIBOZbEle6e4ypkcjDVu2QUHdYDShxVrziy1z3M3IG55zogLEzPoFDtuH9Xs?=
 =?us-ascii?Q?BRS8Ur+wryEfLaphUIcg2w=3D?=
X-Microsoft-Antispam-Message-Info: gLWzEVEUkFbsJyp9xN676LYUS2CHKk3PApWMWjnCSIbHFR45kWQOLb/UcpcoRPrC1kXp4x6STEJvwmVZ5EF22jAut0kM2USdYns2IrrMwb+V0Aov2L3Sz8SCUfvmLEa0hH02lzD5ugJYqE1B1ZiDQHl/IpZqGtabqDWbhsrOJV178be4UAfAfsGP/ohiAyazCmnizR0FNJRQOl8GyqpJCvtTRTedl4RQyYb8PPsjU4L4WtGL7JM92bH8SLnhCQ7bDlH5jZmOmofFesi9NzjNarqsenjGVavGlWkCXQ+C4spSEZygFtNoBt2MVZWXkJgNqSvDRghhsYmQFpyRNUJiYMAFJsesMsuTb+U/NTnXI/k=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4610;6:4H4AHeRlBceNwL2VFNViWXzoRyjb7sOWk2QqofExE9zsKoYqxU+roQlDDHvNS81OTku1O16+w6RZW0Lgycp5mEJeC2B2Dp9F6hpUN7TDEIpoKIcKc4CXt1Wu3i6ukMCozePkyuFMasuGuITMF+F4WSKj1mPGoZVO9y5CRPaol8D7xwRo/qt89dM/WIre4bTMCdEN8fGghpdrTJ7ZAshTNtLGzlWDKYWvPIHiT7C1GfhD8THF+xTUc/V4oQ16oJc/l054BNBuFwZ2rp6NZEAkuoFhSjCGSbmNOyKy+gFiep87yWO3HsMKe6K/it6pmoWEAZ9yGiOfdGUlZJLwjEP+NPdJBwzjTCFKB2zRCAGXn6wTDqER+ZKqdjtxaxFxU1P7yY5YPPpnODGopCLMA6gMl6qRYNUgS21g0WjK4EV/5iLonYNOTGTEhskhApwpp7ZEAt1PsFQp+FXp9Hm9DG1oCQ==;5:qd80wGP+SoN8/Xea9Hf7FSKG9sD+qbrg+zMbjWPK1tP0OJ9KyKPR06eY0PY5QOVlVuXtP7vxeYQ4wVQLVy75zWuKhfRRhVtylWgCijZ8WCOjrZrn+fVFzJS14DHQnxkwC1BppcoRAyCGQ5rFIKmUfguIvFbM0hkJNRsDCsb3By8=;7:noh5zKSkEQwDol3Zypzn/p9Gzcu2bN+vRB8jWBVQPj9nzOA3KrHkDF1IqnpuY5MAx+7dSwgNq+Mz9CnSzQi9wKmOGuGSaR4DAXPLo+YmKOxPWUIMPKms+34q2hzcz9LmuGcpwsFr0vBXnnV+r6v4IJPia/65BxmmOvnOudOCxksHBcLftWz/EJkZ88H+HA5KbOqr9gRCQhcHGv5IgjHpCR8JPi/aRJ22EKodUbfJSxqVtMDvJ2r+EF91NuPH02k3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2018 08:19:52.5883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc51bfb-87d2-4ec5-0162-08d625e455e3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4610
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check the flr capability using pcie_has_flr() and do the flr.

Signed-off-by: Srikanth Jampala <Jampala.Srikanth@cavium.com>
Reviewed-by: Gadam Sreerama <sgadam@cavium.com>
---
 drivers/crypto/cavium/nitrox/nitrox_main.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_main.c b/drivers/crypto/cavium/nitrox/nitrox_main.c
index 5bd97cff1405..13436ca98cb5 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_main.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_main.c
@@ -217,7 +217,7 @@ void nitrox_put_device(struct nitrox_device *ndev)
 	smp_mb__after_atomic();
 }
 
-static int nitrox_reset_device(struct pci_dev *pdev)
+static int nitrox_device_flr(struct pci_dev *pdev)
 {
 	int pos = 0;
 
@@ -227,15 +227,10 @@ static int nitrox_reset_device(struct pci_dev *pdev)
 		return -ENOMEM;
 	}
 
-	pos = pci_pcie_cap(pdev);
-	if (!pos)
-		return -ENOTTY;
+	/* check flr support */
+	if (pcie_has_flr(pdev))
+		pcie_flr(pdev);
 
-	if (!pci_wait_for_pending_transaction(pdev))
-		dev_err(&pdev->dev, "waiting for pending transaction\n");
-
-	pcie_capability_set_word(pdev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_BCR_FLR);
-	msleep(100);
 	pci_restore_state(pdev);
 
 	return 0;
@@ -345,7 +340,7 @@ static int nitrox_probe(struct pci_dev *pdev,
 		return err;
 
 	/* do FLR */
-	err = nitrox_reset_device(pdev);
+	err = nitrox_device_flr(pdev);
 	if (err) {
 		dev_err(&pdev->dev, "FLR failed\n");
 		pci_disable_device(pdev);
-- 
2.17.1


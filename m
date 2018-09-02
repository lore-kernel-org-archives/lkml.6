Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D79C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73F420837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QYIhnxLV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A73F420837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbeIBRV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:21:27 -0400
Received: from mail-co1nam03on0121.outbound.protection.outlook.com ([104.47.40.121]:64374
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728580AbeIBRV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIcAO+MNytyVGmnYF/Z2WZ1hQNmXw02dYYDMNNkF4EA=;
 b=QYIhnxLVrXx+ABX0I+lmtbZibkEw6ysKaQsHvCWR8zDeTRCod8ZX30FkmuCIkQT5PCNPwncgJ/zSl6RcT4YhqLx9hAUbZKWf75EMGRswI1j70MfZLlAcJe+o0yMN1Es+JvfOvquHI4N10M30fY5I9ydVlOse/YUSCa32QnLCEYE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:05:36 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:05:35 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 103/131] iommu/arm-smmu-v3: Abort all
 transactions if SMMU is enabled in kdump kernel
Thread-Topic: [PATCH AUTOSEL 4.18 103/131] iommu/arm-smmu-v3: Abort all
 transactions if SMMU is enabled in kdump kernel
Thread-Index: AQHUQr2VqdBlQttbL0y2JM9EMV+lIA==
Date:   Sun, 2 Sep 2018 13:05:13 +0000
Message-ID: <20180902064601.183036-103-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:j7NOWUaXyfh9yuKYnCsQEJoDt1HLzIW5/w6xtRezwWZDA5s3c0mEiph54NIB1XMBXqD7UjnPKYlt7YrRzCJ8R9iRRNxasWoF1VO8O+8NghDoCRPaXxtKWqj3N13vTMVvEgozjNoHAJ7f1IMG/sKzGYILv6vGJkwPeqR+wdfR7V+xrt/hPBqjEJuRnSfz9C5vu3ltucXwxOoj/1uPro9wJERjPR3uJjtDagjbZme5Cy+GoGnQsuCdtrPSVI2gI9BJv5PhjKgEVtbmaekoFdtEIlHUCxlMf/Wvq2h2PVmtU98nCqo65yOH84HnX/Pe/wDxs7tZDXpMVEQQBmik15bKHdXJogcezMRkFxaLea5FDy+VdAUrSFYXClSAU9la0aFw5xvfNfIsk8a5ipWD6bkX1/JOra/wFcurP8iW1IUmAXmjp9zIU9pRKxzJs9sfmLbnHHUtHcDH8fptbRmfkuxcPQ==;5:y4nQrPN7qlPe95l6m8Nd2loKbshu9I11CBg7EBsrBtpB8UzCm0EnN+GjTUsEnHavlRZoZe6ge2L9vw+fQ3NW5lZ+IpE5cXmGqd6VeaqAWokOgvMJYmjOCh3iHBKBqysiAggKjRTpSzCajG8ex3bGRmSNZnt3+adQqSrpkiBIHIY=;7:zr1SkIBfZwzc616ARin3IIAtXUuIHunyKPyY/CiLO5geyO5j7NjhtIVApnu5kya2v4w0Zv87UzMh25SoMYorswj+B0R1lUGt8ENt9eaepbk4kiMQlkzG9kiNNqMqp215X1TTwSAHilRPIeYhrsGoXS3i7rkbCnS7TVHBN3nDaJ75urvpViyGYcswFwhAksu1v1XuTZp1o0zyQTuDmVKQJi7hl+UWlN1MYQXuAS3Uy+eZdqUOrWSsFjIzqG3pAA/q
x-ms-office365-filtering-correlation-id: 763bd9e1-6ac3-428f-8747-08d610d4c5f6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB018427441FBCFFD10342133AFB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(6512007)(53936002)(6436002)(97736004)(105586002)(22452003)(25786009)(106356001)(107886003)(4326008)(6486002)(110136005)(54906003)(316002)(10090500001)(14444005)(5250100002)(256004)(66066001)(36756003)(6116002)(2501003)(26005)(6506007)(5660300001)(3846002)(81156014)(76176011)(99286004)(102836004)(1076002)(8676002)(81166006)(10290500003)(2616005)(68736007)(476003)(2906002)(8936002)(11346002)(72206003)(186003)(305945005)(7736002)(486006)(6666003)(217873002)(86362001)(2900100001)(86612001)(446003)(575784001)(14454004)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uhOqNe7BtjN+SEJhUTBAlkdeCXU4XggphCtYRG5dwgz3UPk3eZ5zN7podvW6R57WSobDgvOdeEsalvV8oxa/hjOle1tCsx3LcemUX1oVnntIg+mPNkhR1Y5WnzrNZl0+sENcAW+RqsNQ9C9wfdvvoY38sV0hTL/fRfE16yQMUkE4hyljAu8yyi51i8poTR1mcXBh43v/vs2XW4XCceZs6ImIb2SPVu9WvyTuWbSt8162dXvTN6zj5T1Da4LEi/0C7hfrD43IZFu4dUMjEYPyqCb4VkChaNYdC82zYGJsoZE0OPX/fU/5X/Tuz/FROoddSMM/YdhvyCh3Fs2OOtkJNeh/csgMVJ2thV4rwZQ9jxI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 763bd9e1-6ac3-428f-8747-08d610d4c5f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:13.1383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will.deacon@arm.com>

[ Upstream commit b63b3439b85609338e4faabd5d2588dbda137e5c ]

If we find that the SMMU is enabled during probe, we reset it by
re-initialising its registers and either enabling translation or placing
it into bypass based on the disable_bypass commandline option.

In the case of a kdump kernel, the SMMU won't have been shutdown cleanly
by the previous kernel and there may be concurrent DMA through the SMMU.
Rather than reset the SMMU to bypass, which would likely lead to rampant
data corruption, we can instead configure the SMMU to abort all incoming
transactions when we find that it is enabled from within a kdump kernel.

Reported-by: Sameer Goel <sgoel@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iommu/arm-smmu-v3.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 1d647104bccc..b73c6a7bf7f2 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -24,6 +24,7 @@
 #include <linux/acpi_iort.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/crash_dump.h>
 #include <linux/delay.h>
 #include <linux/dma-iommu.h>
 #include <linux/err.h>
@@ -2211,8 +2212,12 @@ static int arm_smmu_update_gbpa(struct arm_smmu_devi=
ce *smmu, u32 set, u32 clr)
 	reg &=3D ~clr;
 	reg |=3D set;
 	writel_relaxed(reg | GBPA_UPDATE, gbpa);
-	return readl_relaxed_poll_timeout(gbpa, reg, !(reg & GBPA_UPDATE),
-					  1, ARM_SMMU_POLL_TIMEOUT_US);
+	ret =3D readl_relaxed_poll_timeout(gbpa, reg, !(reg & GBPA_UPDATE),
+					 1, ARM_SMMU_POLL_TIMEOUT_US);
+
+	if (ret)
+		dev_err(smmu->dev, "GBPA not responding to update\n");
+	return ret;
 }
=20
 static void arm_smmu_free_msis(void *data)
@@ -2392,8 +2397,15 @@ static int arm_smmu_device_reset(struct arm_smmu_dev=
ice *smmu, bool bypass)
=20
 	/* Clear CR0 and sync (disables SMMU and queue processing) */
 	reg =3D readl_relaxed(smmu->base + ARM_SMMU_CR0);
-	if (reg & CR0_SMMUEN)
+	if (reg & CR0_SMMUEN) {
+		if (is_kdump_kernel()) {
+			arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
+			arm_smmu_device_disable(smmu);
+			return -EBUSY;
+		}
+
 		dev_warn(smmu->dev, "SMMU currently enabled! Resetting...\n");
+	}
=20
 	ret =3D arm_smmu_device_disable(smmu);
 	if (ret)
@@ -2491,10 +2503,8 @@ static int arm_smmu_device_reset(struct arm_smmu_dev=
ice *smmu, bool bypass)
 		enables |=3D CR0_SMMUEN;
 	} else {
 		ret =3D arm_smmu_update_gbpa(smmu, 0, GBPA_ABORT);
-		if (ret) {
-			dev_err(smmu->dev, "GBPA not responding to update\n");
+		if (ret)
 			return ret;
-		}
 	}
 	ret =3D arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
 				      ARM_SMMU_CR0ACK);
--=20
2.17.1

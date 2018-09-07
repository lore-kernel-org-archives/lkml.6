Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF69C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628CA2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="goh8jthJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628CA2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbeIGFPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:15:43 -0400
Received: from mail-sn1nam02on0135.outbound.protection.outlook.com ([104.47.36.135]:30237
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729344AbeIGFPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXROCwI6Q01Rse4xYgLDeAbxyY1pNCqd/81qEo9U+dw=;
 b=goh8jthJzC8egt6UERwMqlJfcnueSNlaRKgDmfOlEdApWKbrxMpCZlP1XdUgt9ZtthFunHZZcWWrIIpPcpdPDYCqhF1rUsuwzQjNZ37+mH1zd5LpBHSLLnJ8xv9sM7V4H1aHYJX/llexmJl2WcLLo1m3ZZz6yO3s1JFyzL4vCsU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0118.namprd21.prod.outlook.com (10.173.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:37:32 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:37:32 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 66/88] efi/arm: preserve early mapping of UEFI
 memory map longer for BGRT
Thread-Topic: [PATCH AUTOSEL 4.18 66/88] efi/arm: preserve early mapping of
 UEFI memory map longer for BGRT
Thread-Index: AQHURkLX2hPwEEab/Eyzp7WPRQcVNg==
Date:   Fri, 7 Sep 2018 00:36:39 +0000
Message-ID: <20180907003547.57567-66-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0118;6:CNLqzq9Da+HuuVKC8ds/inBZ69pUEtoMxhSXg8QU9E91RHkrtjZLqspQl3B+l7RrGVrgvGztyToPzjVs1k2o+PgE3G70BqW3lyzYVdBIIEdUCR4RaLB1LpO+19XE/sjFCmNgXSIJL8d4nbP7n/rb4wk4J6kcGFu2BIq4vDQHf9m5hJLl/F9AdNWlnip6QdElRBfn1yOru7ZJGloXSYPn1FEpmXio81qdhZ42zHOkgByohrP5sdcVBbJyU4A83B5i/Y7mYgujW5FDKw3XaJfu7zUpg8eML38+UGjNzYEqqMDPZ24+XTz0vGePJKcTA0NS79Wo9I8QiATF7AVwrX0PjsOYO7AYoceqvOJN3Ev2MIlxlq3iR9A8B4zAfeHRmCUz1upJlgP86CokhpMafHShcPSl2j0LNeOhbTyD55eyKQmq2iLeMLu6KSh+ixtye2/Nas1+5kYl2ZmnxeGbGWN3og==;5:QGB3xmWhAHUHwDIX0HhixEP9/O3CtroGMdZDXZL8Sb99lJ8NNkeKOtslLHRhyX5SCuIjCNtcV+sd1rLRiBiGi/900WItB+5vNA0no6YQfQOzTAZx1jh8E7m9XfvYU/gfKUAdqGFNOI65pubWRTdcgZcYJIcaV8cDDf4NjcjEq/A=;7:QqfY1pEnBT48axFpXNI3t+rRI/dZPNR7C1ALtsP8OXU/KpDS8Xb39cYVC2Ci3AOyfAtq1xE091hnFatrXYGjVIqimcDS/X3o9it/uoHpvlnNGw34KHUYr3bUPOE2Pq0cTJMZxkfOCF42j1FcDKEUcDchMVHrlWEWy55Lc2eQhDtet/n2XeS2IKOx+Wc5YeSl+TNtIbb8Bl+QFQd2MQjyqkr5JCbdGvN5aejypWNxuor1ax4n25noeT7rECEyJsjs
x-ms-office365-filtering-correlation-id: 5a167454-58d2-49b4-cd1a-08d6145a1965
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0118;
x-ms-traffictypediagnostic: CY4PR21MB0118:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01183167D9D808B1BBCAC880FB000@CY4PR21MB0118.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0118;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0118;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(136003)(366004)(189003)(199004)(97736004)(2900100001)(53936002)(316002)(86612001)(25786009)(86362001)(575784001)(2906002)(6512007)(68736007)(110136005)(54906003)(107886003)(4326008)(10290500003)(14454004)(81156014)(81166006)(66066001)(8936002)(8676002)(478600001)(6116002)(3846002)(72206003)(305945005)(7736002)(1076002)(106356001)(105586002)(36756003)(99286004)(186003)(26005)(5250100002)(14444005)(446003)(256004)(217873002)(10090500001)(76176011)(5660300001)(6436002)(11346002)(6486002)(6506007)(102836004)(2501003)(22452003)(476003)(486006)(2616005)(148743002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0118;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CaY9TPmquVRfcF85tsj8C6QJMOVEvTfOC+XBdEB/zefogpvbuRw1t1KuNamurJQ1aMP6HvB7ia0xmF3YgVA/Hz7WlS0Mmoxc9oxA9gKKac9pyIFogcR9ghLV4KXWEEUwwr/8cMimyPPZRjydA3dXzknaoKnIdHm+7cBnY+09Irlyxi3yFvgmzVvd3LjZEi51vs+jVcrxCv73qiKL6+8Bir61QeKICcqMvnMSB6YBiuiZmccNVKQgzuVRVOJCIu9oRjHYoyS4+6jp7QgWVPt/pJgytgP5/2uTzTEWOfaFRxEk89oUoh05EkGgQiytaq5xrvRNhvjkfUppdSV7u7hwc47PmjCNiA5wjxV+dJSAUwo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a167454-58d2-49b4-cd1a-08d6145a1965
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:39.4768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

[ Upstream commit 3ea86495aef2f6de26b7cb1599ba350dd6a0c521 ]

The BGRT code validates the contents of the table against the UEFI
memory map, and so it expects it to be mapped when the code runs.

On ARM, this is currently not the case, since we tear down the early
mapping after efi_init() completes, and only create the permanent
mapping in arm_enable_runtime_services(), which executes as an early
initcall, but still leaves a window where the UEFI memory map is not
mapped.

So move the call to efi_memmap_unmap() from efi_init() to
arm_enable_runtime_services().

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
[will: fold in EFI_MEMMAP attribute check from Ard]
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/firmware/efi/arm-init.c    | 1 -
 drivers/firmware/efi/arm-runtime.c | 4 +++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-ini=
t.c
index b5214c143fee..388a929baf95 100644
--- a/drivers/firmware/efi/arm-init.c
+++ b/drivers/firmware/efi/arm-init.c
@@ -259,7 +259,6 @@ void __init efi_init(void)
=20
 	reserve_regions();
 	efi_esrt_init();
-	efi_memmap_unmap();
=20
 	memblock_reserve(params.mmap & PAGE_MASK,
 			 PAGE_ALIGN(params.mmap_size +
diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-=
runtime.c
index 5889cbea60b8..4712445c3213 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -110,11 +110,13 @@ static int __init arm_enable_runtime_services(void)
 {
 	u64 mapsize;
=20
-	if (!efi_enabled(EFI_BOOT)) {
+	if (!efi_enabled(EFI_BOOT) || !efi_enabled(EFI_MEMMAP)) {
 		pr_info("EFI services will not be available.\n");
 		return 0;
 	}
=20
+	efi_memmap_unmap();
+
 	if (efi_runtime_disabled()) {
 		pr_info("EFI runtime services will be disabled.\n");
 		return 0;
--=20
2.17.1

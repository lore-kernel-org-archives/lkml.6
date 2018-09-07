Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45403C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA26220857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hB/ghqrA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA26220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbeIGFTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:19:31 -0400
Received: from mail-dm3nam03on0102.outbound.protection.outlook.com ([104.47.41.102]:49926
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728144AbeIGFTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P69kFFQq/QiNNn8sf4Ht+a8gURiMEf5RyrEWo90J0u8=;
 b=hB/ghqrArbVzIEoNUSHI/Ow2oLNnBwRZv/rkalTsGAUZqzjYkLUbCnaENjpCosavxDmM12Tf6Corq8lQNb95jm/bRg3jMpTG4Lc9YIaE5vQClDbNY7n78ATyIKiBCzNIx80hmlJfLMpOu/rLiBQQ0uhjt1AduMYkiakFInBxxB0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0694.namprd21.prod.outlook.com (10.175.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:41:19 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:41:19 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 32/43] efi/arm: preserve early mapping of UEFI
 memory map longer for BGRT
Thread-Topic: [PATCH AUTOSEL 4.9 32/43] efi/arm: preserve early mapping of
 UEFI memory map longer for BGRT
Thread-Index: AQHURkMg0nD61/r6J0mw/aIv7f95vQ==
Date:   Fri, 7 Sep 2018 00:38:41 +0000
Message-ID: <20180907003816.57852-32-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0694;6:IgjGm4YJtbWsWNK7B2STf6w6LhpZ6Gny415t27BdeHbw/J73sUMuEayweJtC6pu0A89n2Duu1bsMkBJaMa6Ry1HH12XzYcFWb6x6FcEP3q1UDjsuTT9fL96Ezxxc/CYDL7TNUFBKfjvVDp6H5NxDKb9IsVwjdcEOww5kc6SrykYYacOvJn63+kY56gPgAnhmlYjq5bugzMvgj6juVvq1JuO74jGl5yVPQu2e4wJ2PS10F3QWQ0bzVP0b44EC6I/+xPHDaD0exP/UUbjMPwYq3XEdj/CXVp8CEJ5PWF5LBrOmw5rsUuG5Nl4P4FxMQSsadSJuUQ5SwUS0GhQMmtZjtY7K7q9Doo/W/HAXy3Q0Oox1xFYPOaoUuurtVR2DLdPidPVwJ9jfGpaA7VE2jzbO1eMs0g/ul5z53Rk2o+6SHExdRPfkzw6ZkoX1juriPtQnBIukuKa1q9CXHk/MwCPLVw==;5:7VETLBE1c9WQliLhkW6bbE9ESATGwU5MwDg9b35E1FV8ClMs+66FwtTr52Fndnm3RpneKHaIrUgGLZtkMRWH+EcNSazoXbngfHiB1hWfcITdC/5nnttctWgQXvRn5xBRXyTYT7PmjN8oXV8Z9zxiFM1Gj0vugUQfi1+SFu3qoqQ=;7:fxZESSOcqjDythzrxb7sjOklDnwDgf+VYxU46wxi+0J72bpaVe+QEWR/uV4EvgbsN+EfD5URRQ2Krlz5qxdDL4OEmolI+BtnelrUXcmw2mmpOW4bSTN+zorAj1SCGYKqUY8K8cHtVaDy0KOhZKgoPun80+y7veiRxBje2xz2uVWZKt9azGeVarULWUKaxuwikymWpYmvfHHQd9lzi6cayJ3vocvhXsh9MbI5OwRHStJ/aMLeM9MC1wMPsfuqEv34
x-ms-office365-filtering-correlation-id: 9070a8bf-d5c2-4246-161e-08d6145aa0cf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0694;
x-ms-traffictypediagnostic: CY4PR21MB0694:
x-microsoft-antispam-prvs: <CY4PR21MB06949B123EDFF90A008CAA7FFB000@CY4PR21MB0694.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0694;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0694;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(366004)(136003)(346002)(189003)(199004)(2906002)(575784001)(186003)(86362001)(6666003)(110136005)(107886003)(54906003)(36756003)(25786009)(4326008)(256004)(14444005)(2616005)(6506007)(6486002)(6346003)(6436002)(6512007)(446003)(476003)(11346002)(486006)(86612001)(2900100001)(5660300001)(102836004)(26005)(66066001)(53936002)(68736007)(7736002)(81166006)(81156014)(8676002)(10090500001)(8936002)(6116002)(3846002)(99286004)(105586002)(76176011)(106356001)(5250100002)(22452003)(14454004)(316002)(1076002)(2501003)(305945005)(217873002)(97736004)(10290500003)(72206003)(478600001)(148743002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0694;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 3EYWKxjrh17V1il5oVHiF3gLp9Fw1pfGIQK64WME3V/RafyOcZM+nLi3FU9gKgDfOMtdwjj0YYaebORtpRPq7tKp3rgam6zr0QhxhCMdN4k6Cd6SU3srQfKl6mHEcMiGT7dA8uom4jYrDhUSCwUMfW2uLaRD2wzV2OFLiaYtmF1n+8RuVt5+3ZiPEbwcPaZlu+I2JPHOJGbwW99B/1hz7CyD68rXK5FzGwPhB0S0P+LvtTF8A3eJ436JYZqwEst4gSNQgD2UKHRo2gF5FXcu1VJUb7FcWe7eplYMgId8qajIxv/Zrp6GLqC9gtkHjcKR4fyOJKVK029uHMPfvVswI8xD4do/9nftFM6ZsmrxrHE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9070a8bf-d5c2-4246-161e-08d6145aa0cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:41.4764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0694
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
index 8efe13075c92..1d1c9693ebfb 100644
--- a/drivers/firmware/efi/arm-init.c
+++ b/drivers/firmware/efi/arm-init.c
@@ -250,7 +250,6 @@ void __init efi_init(void)
 	reserve_regions();
 	efi_memattr_init();
 	efi_esrt_init();
-	efi_memmap_unmap();
=20
 	memblock_reserve(params.mmap & PAGE_MASK,
 			 PAGE_ALIGN(params.mmap_size +
diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-=
runtime.c
index 6bdf39e1e385..4d788e0debfe 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -118,11 +118,13 @@ static int __init arm_enable_runtime_services(void)
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

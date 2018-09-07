Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91837C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42345204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="mB0x2NC6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42345204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbeIGF2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:28:49 -0400
Received: from mail-bl2nam02on0129.outbound.protection.outlook.com ([104.47.38.129]:33184
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729959AbeIGFRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXlLoEeqLlZqjA3AabXDAZHQpf2KDLKMv5Y0hS0hhps=;
 b=mB0x2NC69k6BgOJ+9HyzpvZi6qKUjhw2xEh6GDdU0q/q6vF82XcIySQIZZObcqbnQoNL2+qhBRnR+gs/pA6c7751uyA7qDTDNaPci1G7ha8lPI2dE2LF/0mllgW02iD/2G1ucgP6mFM09e60WKVrS8LV6pFnXvle9UGHgKSDz+s=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1143.1; Fri, 7 Sep 2018 00:39:05 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:39:05 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 52/67] efi/arm: preserve early mapping of UEFI
 memory map longer for BGRT
Thread-Topic: [PATCH AUTOSEL 4.14 52/67] efi/arm: preserve early mapping of
 UEFI memory map longer for BGRT
Thread-Index: AQHURkMGzI3SxLQvgUijbgpdq8/0Sg==
Date:   Fri, 7 Sep 2018 00:37:59 +0000
Message-ID: <20180907003716.57737-52-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:o6etH05+VktKpPshx2s6GJ7bqmwoLZLF0UOL2/vnFLjx5VCQbUCHk0gcjrN71EtNdTGiaVmWocBVtZtz5aRKbrGT5srpW8+TmbyKncXbmz46DUsmhC8NuT+ZtFoO2jc8r/s2mB3aAuboUo6ALfQIL+B2DkZQ0kWJMBXS9K4TFPz5usRX5gkFOrOsJXy5+F3k6H/F6xzDdKS9+iiAR5r0MUoWcJuZj8rWfZWu4MNvsj/W8Hva6pyKqxFeP5xoNfD3sIH2pA1e9hI6nL0WmLysVaLEd7deSrFVb/fafkCzhXFSUPS2xFWhrNM2j6CIaRwjFavctN+uD/QCdAuvScF3r8GLZBhypB2is+ylV96ulO4p1/yXhB/trFOSB2FOV682KSp1wVHZjrZQR3+8A6mfmskki4Vk+VPv6VneSa9aGHAcA+paM+CqTJ5wD9wsC5BWaWaVD33vq9FbnxB32kWKJw==;5:IxrtGFqIFB0J3HGGykasS4F31RBSJ5Xg3WOxstHUVh/zRvstgNe6CFpGVLOd7XzApwpQ6Nevh4+mTGXT+IoKd+cyyFbSDZsUo7nFjCohKd7E3+CTKcvXKTN3pEpDN2/PnmomXJ/29m5oE2llsk0K68hVzVfWXAf/O9UZ8e/S8sY=;7:ML7dUGZcNDWCEvpp59uvZXAGt4NGYEEu6YxMWZ7RdjO74tVT8DJkg4tXmaBkeTh1WACbC9VToxk8TQObzWPkwE2tpuKvN1T9xjue+mgKWM92NvEztOpP9mA3/GXgrgb5CWm75gERTvl2+Z0+mlLO0bW6G9jFT2HRK/DXY9KmPzg7HrBV0p2hnsKhTo/H7aEwcHHYUufPvFoiICr1pc3gAPWcfwyqY+EPLEkSk5VTkWZNrUHMd+S2IYR6szAmCsXm
x-ms-office365-filtering-correlation-id: 203496e2-66bb-44cd-d7ed-08d6145a508d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB0757F5137262EBE8C9EE3C74FB000@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(8936002)(3846002)(81166006)(86612001)(6666003)(5250100002)(81156014)(486006)(99286004)(6486002)(106356001)(10290500003)(107886003)(256004)(14444005)(26005)(11346002)(14454004)(446003)(76176011)(6346003)(5660300001)(10090500001)(110136005)(2616005)(66066001)(186003)(476003)(72206003)(2501003)(54906003)(575784001)(316002)(6436002)(86362001)(97736004)(53936002)(22452003)(6506007)(102836004)(8676002)(6512007)(2900100001)(68736007)(305945005)(7736002)(217873002)(6116002)(1076002)(25786009)(2906002)(36756003)(4326008)(105586002)(478600001)(148743002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: x7alyjSR8P0uYMTr8my2Fx95QWKPic/ZOsxprV3NU9LvVeayB+Iry9yibkz0ZE47EzQUMQnyzP+vvs384WCes6nK0eVTCcFNc6cqluq7IEAR2FPhLcEIXNtQTsU06sRGN38OTxH8DTKF5FiZvoWHwSoGKA2ZCQlZ1BPDw7BGcLDIwm7+4bEvnhNUydLfrAP9d2DarC6tUzqleE3Q5KTPD7CxS6U7McWhNW7w4vfjKPyCCE6R016g/LILpjvKRzfx/QAMWsPg4yg7efKOeKcEAc+438HHmXVB4YqVkeSgvKE6M5OYV0TKgPrecbQtwkFC5u3WnxJSKLzK58Bfs6koJsKuQJLHOLRs0TXPa5ezG9I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 203496e2-66bb-44cd-d7ed-08d6145a508d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:59.5051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
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
index 80d1a885def5..a7c522eac640 100644
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
index 86a1ad17a32e..8995a48bd067 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -122,11 +122,13 @@ static int __init arm_enable_runtime_services(void)
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

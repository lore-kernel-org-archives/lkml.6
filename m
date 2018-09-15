Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924F3ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B13D20866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="H4QTkUhu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B13D20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbeIOGtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:49:46 -0400
Received: from mail-sn1nam02on0127.outbound.protection.outlook.com ([104.47.36.127]:18752
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729115AbeIOGtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26GleA9ZzYa5wHyRGmOEnIsZ/gVwSb+bqRrT2JWk8ZE=;
 b=H4QTkUhuodh0BrpM4VoFnI6ZdABIDgdpjmyh9Fucgl1FQBZt0aNTHGrJlOWfCqYxROESaAjZ4jWrif5L99q6mcL3ALnGqEq2l4h1Si3r/n4jW0vVorb1/b+dh13zLbPjuHIMcLIMN8dLKB2d6JlOpYF/ImIejlVeDYG7ENedjhI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:32:41 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:32:41 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Jones <pjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 18/57] efi/esrt: Only call efi_mem_reserve() for
 boot services memory
Thread-Topic: [PATCH AUTOSEL 4.14 18/57] efi/esrt: Only call efi_mem_reserve()
 for boot services memory
Thread-Index: AQHUTJP+R/2bVXoT30qKFWNbw6VWkg==
Date:   Sat, 15 Sep 2018 01:32:41 +0000
Message-ID: <20180915013223.179909-18-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:4BVLezzoIOeIoL+cazF2cMy9SbRKHYXfJtEZgvfGmpcGRYhilYT8GVYFP2mijSN7G4ciuY0PeOPo9ZsscQGUFaglWk1r+H6/1Z6h24QufEt9FMxQ9wHpYCeoW8moF9LsfTVO4D6jxodCXNzJmUdyTOnK0RwY1bL+g5nTkjTlhWeEXWKFWAZX8pNcof9YpEg54OvQra8EfNvKE9VFdBW5dok5sU9G1yzgqFbLiXh2v+ctU/I6Wa2OIwq3wqBXwrxttva9Z1BfsquWwpBz8vAZYwK6ycXmETOtbui9cs3MzXfNfhkIW1K0I/GOlMPBeiVrcH0C2lgyLTYNwMBuCLz+0IhxEiqb+Mpj9PLJObuzD5hgioAJGl2BVeZrqyylTIxxu63P7iGkhzHB+DbmU/zRBQjSB6FXLRATqfq4WoxHAwPMdVM96LRcVXOba8tVdVE+Y4FJB0qtvu4MIYyZI8AYXw==;5:23JRr+f7B/B7cSWAZFrFt5ZJ+5ZfoHjjPW5zkDGOE8Kri6vFz9zxQ4idnJ24Y1GPof6RFE7qAeyXDo3TYLnDFgYljB+sUCWoUw4qolDORGOgflzgqheH5o9VwZksCRx1OaBmdiwRXSBJtJjGvwuLPL2dkmAZu6hIV2k6jnLjojQ=;7:7Cd33tBQ4HpyFmfwu+mdL/LD6BisW80bnHV8yihj2vGiqz+ra6dAigaPhsiW8luvXxkrHshtnTpAr4E4Sp+yTIilOEIgipZ9MNfX3XoBz/wOw+/jDqSHBG8NNfVi30ifeie+d9sPQJXtba2nQB9dgSi+xzMhOf8JEcGWCj/AFL8v/OsMKnn8q+BQ57geRBaJFWEpmC7UnGD0JVhzRWJaWK05r4NdufJk9sRudWbwlLu4eY5KbCYrH24ixN62PKYR
x-ms-office365-filtering-correlation-id: 6e07f99d-be2f-4533-e3d8-08d61aab20d5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08223558D6F65BC63581FF28FB180@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(1076002)(72206003)(6506007)(102836004)(478600001)(8936002)(10290500003)(2906002)(81166006)(81156014)(5660300001)(22452003)(2900100001)(8676002)(110136005)(54906003)(107886003)(99286004)(25786009)(4326008)(316002)(10090500001)(97736004)(305945005)(7736002)(6116002)(3846002)(256004)(14444005)(66066001)(76176011)(217873002)(6436002)(14454004)(36756003)(476003)(86612001)(6512007)(26005)(5250100002)(53936002)(486006)(106356001)(11346002)(2616005)(6486002)(575784001)(86362001)(446003)(186003)(105586002)(2501003)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CW8p0g4XNv8IEs5HwZ23TIugKvJzEEwH3Tfz1qQSoqSjCd7vBWtEa5JdiEtDLPNpARxin0mCQx+r6qWMjwzsNSLG7H2+1pwnVKcNh85pTlrVoN6cHdBMJV8faVm9kvD242gLLQVIAB0rk+U9a1Q5rAv07LKueoAo6MTyIL9EbeYgdJS5p2km+o0HZHzkRETeyrCKoYDPCq4z44Ajt9+UJR2M2QG/P73GPbAlLvEiJjZ/DAWb2n8xg8HWVltbmuoDkAghfN4O8fFG8Lk3HXxEgPnT2p/6Sdcds33iXWpF7Gfs0vr7Q0MAb3yYcldzcEzwd+zQQOVF8OtdX5fFT4zGOUJqdSOXuCKcKMhhayLo7SA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e07f99d-be2f-4533-e3d8-08d61aab20d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:41.1028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

[ Upstream commit 61f0d55569463a1af897117ff47d202b0ccb2e24 ]

The following commit:

  7e1550b8f208 ("efi: Drop type and attribute checks in efi_mem_desc_lookup=
()")

refactored the implementation of efi_mem_desc_lookup() so that the type
check is moved to the callers, one of which is the x86 version of
efi_arch_mem_reserve(), where we added a modified check that only takes
EFI_BOOT_SERVICES_DATA regions into account.

This is reasonable, since it is the only memory type that requires this,
but doing so uncovered some unexpected behavior in the ESRT code, which
permits the ESRT table to reside in other types of memory than what the
UEFI spec mandates (i.e., EFI_BOOT_SERVICES_DATA), and unconditionally
calls efi_mem_reserve() on the region in question. This may result in
errors such as

  esrt: Reserving ESRT space from 0x000000009c810318 to 0x000000009c810350.
  efi: Failed to lookup EFI memory descriptor for 0x000000009c810318

when the ESRT table is not in EFI_BOOT_SERVICES_DATA memory, but we try
to reserve it nonetheless.

So make the call to efi_mem_reserve() conditional on the memory type.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Jones <pjones@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/firmware/efi/esrt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
index c47e0c6ec00f..f3c28777b8c6 100644
--- a/drivers/firmware/efi/esrt.c
+++ b/drivers/firmware/efi/esrt.c
@@ -333,7 +333,8 @@ void __init efi_esrt_init(void)
=20
 	end =3D esrt_data + size;
 	pr_info("Reserving ESRT space from %pa to %pa.\n", &esrt_data, &end);
-	efi_mem_reserve(esrt_data, esrt_data_size);
+	if (md.type =3D=3D EFI_BOOT_SERVICES_DATA)
+		efi_mem_reserve(esrt_data, esrt_data_size);
=20
 	pr_debug("esrt-init: loaded.\n");
 err_memunmap:
--=20
2.17.1

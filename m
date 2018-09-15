Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DDFECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E642421476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="f8FizqvA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E642421476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbeIOGvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:51:37 -0400
Received: from mail-sn1nam01on0129.outbound.protection.outlook.com ([104.47.32.129]:50720
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729612AbeIOGvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ISBmt0QIhnGFsGXxQeud/LzWEy/e/6sGBP0hVqPzw4=;
 b=f8FizqvAEtD5Dg7hZQdtVF89/zEcWDvpbT+Q/3Vem4xOeNjENfxZslsW5atauZLU3LrJtwYaoVLMgY3WR5RMJz8DBrLx+Z8ys2p78cUYZeejJgx2OY1QFNBpEQ1dGMd/2GvacJRjqjuusq/XUulQoxH662XbGr4+Icj6HK7Sg7c=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Sat, 15 Sep 2018 01:34:31 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:34:31 +0000
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
Subject: [PATCH AUTOSEL 4.9 09/34] efi/esrt: Only call efi_mem_reserve() for
 boot services memory
Thread-Topic: [PATCH AUTOSEL 4.9 09/34] efi/esrt: Only call efi_mem_reserve()
 for boot services memory
Thread-Index: AQHUTJQ/5J7EC+5AKk+x/YFpNy5LWQ==
Date:   Sat, 15 Sep 2018 01:34:31 +0000
Message-ID: <20180915013422.180023-9-alexander.levin@microsoft.com>
References: <20180915013422.180023-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013422.180023-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:yptUHSbnNAFIHkN491SAUSBAs2RPKEndZqMuXmFLK7toqyB/NYsKbpix93XkFlWqfRqTVHqsXE/z5/5USscRL5BAJqurtl2MRdMJS0uP2yNREYr3IK/mScAHeqPNBzvdC+no9LjBiVlnIsesMfRVDiTZmbybzLAWLwPTG75ZIEgOglfVNRdnXdwAEpbl+4nbnRH8CRlKZadNbafwv3smvavVsMD3iEmwLoUVLgBA6TC+Tqo7+wW+pFMt+aImdsfdDgPHAEXgjInjksgihUM+gzy5m1B7ZHQNNBa1sqh+JlYBp4Ugd1mQYg2Dso2H/IogcnTPErdirfSHERpV6OaFQJ2nPWXR0EPvnFFcERvt08oHXnOUYiS3ixRSmUFNNQP/V19phc5N6W2eAcnYbEiFKq8RK1sI35ibks88xi5ofKVziFqwbwY9F6w2QdkzpJjKjJxafy11ubW8S2kMFKirbw==;5:9SfxU//3jljTd8iFs2jP97lgq6DCZWcMJiGjpiZ0/MbBb6NodgiAvfltU94Uz2pmLAi+KVnl0sNH5Lr7wQfsXF6UmZj8eMmfiHs91+RDvJd2xx0gPqg0eccDXn7UTjpEAOdZxsWHlLaGmbP007a4vM+ScbE/usZwbJthr7FEQUM=;7:ZVXtg4zsVAZmQhWn3fu/nr35oDJsHI0knTS6bkhXe+83lMG09Oh7ZFf7rbqgleA/QByBPIktkUWf/WArK+3N4G7l4NwekrY64JF99xLhdQ8tZejTQgQGqpBpxG334r8mEQQWUbGxImWwtXWY3KQmQeJEjcrTHMl9oQP03/FVYyoM1wzCxE6w1nYFf/dx97pIM7ITZQ05FBf9RxZc6BusGNWTL7Z211FRpncTb3r2uL+r6sDg/W/bX4nzsJAsVcHF
x-ms-office365-filtering-correlation-id: 8ffac57f-449d-4cb4-2e9d-08d61aab629f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB08557859D816CBC74070C837FB180@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(346002)(136003)(39860400002)(366004)(396003)(189003)(199004)(102836004)(6506007)(305945005)(7736002)(10090500001)(575784001)(86612001)(86362001)(106356001)(97736004)(107886003)(186003)(26005)(6346003)(14444005)(5660300001)(256004)(5250100002)(6486002)(105586002)(6512007)(2501003)(2900100001)(22452003)(6436002)(99286004)(316002)(8676002)(76176011)(53936002)(54906003)(36756003)(110136005)(10290500003)(72206003)(478600001)(68736007)(66066001)(81166006)(81156014)(8936002)(486006)(1076002)(3846002)(446003)(14454004)(6116002)(476003)(11346002)(2616005)(217873002)(4326008)(2906002)(25786009)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 4RrctPoeAtRz1S1fC164Rrem6DJs6QEyeCm3xJ8vvpXyNIntGygLynsMm+6FaVPQ3DqV6ejdHgC8TKpwyTdwfkhvkKtidQtMqJGbxyr/eojt8OJ+0u1XTUQSJ253xraEEyX0nc565+REv8IBS2a1hwTzbk+sTI4LLYx4VphOm6FE1ODG58ZTQb/r6W3RS4gNCplg8SkYQMCWQo5rmJQkzhUukDREDhft8O/n/RB8q3vfz4Rel9rjESKeDeQOTKaHE0uKk7lM0L4YJcU7qMGxdf3dkPB1VU1hPQ4nmiFzj0PR745ykOnXree/EY8vM6Jzov32MsH3H2OCNL3xL49Y2Qx+hWY7qGS2d4I1rX1a2IM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffac57f-449d-4cb4-2e9d-08d61aab629f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:34:31.3176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
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
index 311c9d0e8cbb..241dd7c63d2c 100644
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

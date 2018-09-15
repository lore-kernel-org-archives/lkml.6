Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A216DECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455D221477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IrBYGEwP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455D221477
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbeIOHHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:07:43 -0400
Received: from mail-sn1nam01on0101.outbound.protection.outlook.com ([104.47.32.101]:52800
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728292AbeIOGrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWLHZwI8mNtdL6JdH1FqfkJHlEaL+4lAaHy9X2Y1roU=;
 b=IrBYGEwPvl5B92d0MmK287Y71Odt7rJAMFEdQw+eZve9wHB7cK/8DkfM0uIRNCmidbBRb88shmganw3irW0qEAc7gHcbeKU3ZggigKQzAQNskCaA59nFx9NfF72nUPCY+PxKeT+ekkhKQE7WN6exFDbasqxpWpdCiO4JKePqdGY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0824.namprd21.prod.outlook.com (10.173.192.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:30:06 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:06 +0000
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
Subject: [PATCH AUTOSEL 4.18 24/92] efi/esrt: Only call efi_mem_reserve() for
 boot services memory
Thread-Topic: [PATCH AUTOSEL 4.18 24/92] efi/esrt: Only call efi_mem_reserve()
 for boot services memory
Thread-Index: AQHUTJOiPlKufay25UawfgkDazbCyA==
Date:   Sat, 15 Sep 2018 01:30:06 +0000
Message-ID: <20180915012944.179481-24-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0824;6:4/6SWXZLAOU7AITcTm0XX2Yh6OEYJ20WspfnUUXh6z2xfVkQpBNb7mmNoqFyh7KWnQ0KVUqR7Gp/01cqus46BtDHY4S9fPTZxxeivZKS0cAPmLZSAWsXBJE1E84WcOmWLLwFkddnuvixJgJAt4QN62pDL6WQpo5/Yezbfs243ZpXypKQnTZlBHLx/+6jt+/LsYiubKZecFRYnASyLG45O+vHMX9SiakqDjMAhh6R54dmCGnOxU6+ya2d/NMdVfxKoPMJCngUmYeryVO6BDNUgYMRfvkj1aAuyxhvGPempJuiEIitsPhPqEzPCwmTGIh2fJVTWKCylJEyvO0Gp4ZXYpioq+mGr/hh0CaFIbNYpX1wGj1XIYwmp4p11eYbv/TPR68fkw9+ORpkV5FPI3p2gl+v0sR069zkbTtE1PROg7SmKqYt/PPLKE7jHC+k6RC5rUQXhENt/tGTi+XfmqF33g==;5:HWIaufXssC8jr90B3yJWeFx2Y9P/L960W9o5V/JWj1ymfp0lmqDa3OCSU5DpCht/9bvFGXghT4HUPPSba2Mw583Kmmopt3Iez9zsAFC7SNOT1pMtKRP8puSS4tmhtMNFeTUG38mQPowDgc0uJcjknO476AbSAym/t3pvYuJke1k=;7:GYQNQhUtj/dQiZEvUAOBzcPDDQsG16sV35icNpgulHMrEJaT8NzHiCmjp0QzX5X2sKaOlZp0qyo8OGep2MUBzwLSNbUHvdR4sp/SdZPVK3weU9hEU2NLIynApXVFnyBlAnakKzRZE6YBDkcnrGGLaelBsl8/YhuZeGFjXNeUFX5rNdz9iE6GgM0DDKkA9D+gtBgVsPeMJAVXjJ3yZySJUvXayITtUm2bwKtvqgp5wLsI/dkTuHdQ3PFnvQzLu3p5
x-ms-office365-filtering-correlation-id: 57a0ee48-266e-4ffe-4db1-08d61aaac4de
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0824;
x-ms-traffictypediagnostic: CY4PR21MB0824:
x-microsoft-antispam-prvs: <CY4PR21MB0824655BD20080F4B23029E9FB180@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0824;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0824;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(376002)(346002)(366004)(396003)(189003)(199004)(6506007)(1076002)(66066001)(22452003)(99286004)(102836004)(76176011)(2501003)(5250100002)(97736004)(54906003)(6116002)(186003)(3846002)(107886003)(25786009)(11346002)(6346003)(446003)(486006)(476003)(26005)(2616005)(5660300001)(10090500001)(86612001)(86362001)(36756003)(4326008)(575784001)(217873002)(316002)(68736007)(110136005)(8936002)(81156014)(8676002)(2906002)(6436002)(14444005)(256004)(72206003)(7736002)(53936002)(2900100001)(478600001)(6512007)(81166006)(10290500003)(105586002)(305945005)(106356001)(6486002)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: l1drnOuHrl9CPAOXp5LqVOpVzkX1IbYgHFGGYJHdW8S2Kj6CT4RQw1EOrPdCuo5OtSXXKhkgSLMn6PpgXfeaLd69O7vL8LFGzJeMaUVbk5TlM6/UO/pAixPh4vkvyktp//ncNdy7wqVjax9SbFhyzh4cDwo2ZC70Hhq+Y0qpOznJ4czVDT+5C1+sYqhyPoTxC0xkCoPsnE5sU4PoXEaiT1EKpwvk/o41YLvhSy0/4iLN2MLdNd401kzEF6ZJx+IcAHQM4BLAKgawean1Bm6bcULV0I39Iq3qMYLZbvcoOR4kcDIU7a0naiqL4q1ID97BrqzGPEU0o6rv9uPNnHi9KyU8maYFyJOM0kTru2xe0IA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a0ee48-266e-4ffe-4db1-08d61aaac4de
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:06.7763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
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
index 1ab80e06e7c5..e5d80ebd72b6 100644
--- a/drivers/firmware/efi/esrt.c
+++ b/drivers/firmware/efi/esrt.c
@@ -326,7 +326,8 @@ void __init efi_esrt_init(void)
=20
 	end =3D esrt_data + size;
 	pr_info("Reserving ESRT space from %pa to %pa.\n", &esrt_data, &end);
-	efi_mem_reserve(esrt_data, esrt_data_size);
+	if (md.type =3D=3D EFI_BOOT_SERVICES_DATA)
+		efi_mem_reserve(esrt_data, esrt_data_size);
=20
 	pr_debug("esrt-init: loaded.\n");
 }
--=20
2.17.1

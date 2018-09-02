Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CF6C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D745B2077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="L8BQJa0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D745B2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbeIBRUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:20:46 -0400
Received: from mail-eopbgr700098.outbound.protection.outlook.com ([40.107.70.98]:16799
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727467AbeIBRUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZvZRH0wjT3VZnaQhTxOBCKg1c7rFSmXT6CDnH5762M=;
 b=L8BQJa0DdSQEmvFIlSPWuvq4SY1zbtsmDvznmsXpZd0l3ky+AgWwVPoBylSB13xQU4vqMxmuawquDQbkg5ffyleR6OR1bI4J7Kp22dWn70MV3HO7DCdiVzf7MXuA0WmlIw62V1QeT9ELIQv9APAjrFKQzWVafqW5+ctXGddBJow=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:18 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:18 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 060/131] MIPS: Fix ISA virt/bus conversion for
 non-zero PHYS_OFFSET
Thread-Topic: [PATCH AUTOSEL 4.18 060/131] MIPS: Fix ISA virt/bus conversion
 for non-zero PHYS_OFFSET
Thread-Index: AQHUQr10bGgMXvbeHkSnSQHh+h9OFw==
Date:   Sun, 2 Sep 2018 13:04:17 +0000
Message-ID: <20180902064601.183036-60-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:ZFRwMYK9GYKJJrJRCgIcFWlJ+K2VBSnR1L1QhIcdoQk/yTM43nPdjtrIe2ak083/JPoYFdC9u6gyWZHv/SI5FG4QEFrxq6ne67wmqfvFvaMVwvkke0wQQnJpX6K5reahTMlijCTucY/sFEZFUS5hWAB2uJTwNatEZyDL1H40NL4S29ZbJi2dBsZp/+CFRNA+95ODYj0cw1PzDzP7nv4wa7aeDqqxRf+Kwv/O+I2Xq/CKgjf992jJEN6Kh+JK2eMJrwNUlIj7L/fY0Mxlb+scEhDP/b8vgCKAlY2fmPq1mjBkEJJKODQhlWy0CMrRmqJhg36OxTN1fOm/svdKYJMm6NCsy2InUz+PamhgImmxsC9b8GwDAJ2F8cEFz8v2Hb+a9kp6GCLX2WNL5nnYNejnOO/dz1RBpLKBfKv3taqYcwFTUoiFRKKzHhXfgei3k8pE7u7VrZCUpPLe1lCQCWYPeA==;5:JKrX1OBxeqNn+uoJx18YooNLMw7+Bcc3v+eaAx/xEGJ+fjwyFNH5gcncdZwm0Din66OP1ewWOh6Drc0K+BHtVtQcuvVh0TAQ1apMLc4jnR8ae+1OROdcY81EniUs49FpseMRV0ta12ksCBRuzcFKRCEENaQwXI2Sq4bycMW7veU=;7:fp3+dayNf/Eg7cNWgYi293aAm0LAUiYlXUA34FMYF4ojO7HasczOUtgkKWYusWtZOrakK0257b1N1ob7eRabY9qjGTigP+VEC6UXCf/LxlZxbcLPzaiPjbvHiEccWqpa6PHQ+n2mTFN9fzHVc3HenXjlpUfejmws0ACNUb9JuA4SzXLPTIABAL0n9/QItIzG2JTxn8ee1agHplWq789tuOr7s8j0B5cFgZbGEP1FHgfc/gFKezOZ4QwBpvT15xOe
x-ms-office365-filtering-correlation-id: 0fb44b66-aa5f-4578-7907-08d610d497cf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0120C560DEC02C9725845F30FB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(366004)(346002)(39860400002)(199004)(189003)(110136005)(5660300001)(107886003)(26005)(6506007)(2900100001)(8936002)(68736007)(66066001)(99286004)(76176011)(217873002)(2906002)(1076002)(316002)(3846002)(6116002)(86612001)(54906003)(6436002)(305945005)(7736002)(256004)(86362001)(6486002)(25786009)(10290500003)(478600001)(14454004)(476003)(22452003)(5250100002)(97736004)(106356001)(72206003)(966005)(53936002)(2501003)(2616005)(446003)(11346002)(6306002)(6512007)(10090500001)(4326008)(36756003)(105586002)(102836004)(8676002)(81156014)(81166006)(186003)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 24St5qVQvtdh2I5aXydOJczXr4/Kx0kYKokKnco/swLNK8uuY2b2ZIRTAjBzAW6otKTXlv3gih9VQI7/wrvoQcTifW1BUN8ThWInyUBH680yZoNgfB/0v7uyah3AV94duqe+owSJf16gO8FV90+IuHbzraABDT1qpw9mIifv3NDZalTENqTIVwemAmO8QdCrYAw+vu+0rnzNGmqvpcezXH4DcfphgBzkCUpBRuCuxKjOfd41/EREbrhjUME+xDJu+pVV0ioF22r7b92EsM/Nk/Fg1NK7db1E63VAIv7+mOSClwCiqJPHQksaXOUIs+jhIiO+dN7r8KZrX9Zb2aL85AC6/SWRJy6Nf6b/EQJMIB8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb44b66-aa5f-4578-7907-08d610d497cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:17.8806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Burton <paul.burton@mips.com>

[ Upstream commit 0494d7ffdcebc6935410ea0719b24ab626675351 ]

isa_virt_to_bus() & isa_bus_to_virt() claim to treat ISA bus addresses
as being identical to physical addresses, but they fail to do so in the
presence of a non-zero PHYS_OFFSET.

Correct this by having them use virt_to_phys() & phys_to_virt(), which
consolidates the calculations to one place & ensures that ISA bus
addresses do indeed match physical addresses.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/20047/
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/include/asm/io.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index cea8ad864b3f..57b34257be2b 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -141,14 +141,14 @@ static inline void * phys_to_virt(unsigned long addre=
ss)
 /*
  * ISA I/O bus memory addresses are 1:1 with the physical address.
  */
-static inline unsigned long isa_virt_to_bus(volatile void * address)
+static inline unsigned long isa_virt_to_bus(volatile void *address)
 {
-	return (unsigned long)address - PAGE_OFFSET;
+	return virt_to_phys(address);
 }
=20
-static inline void * isa_bus_to_virt(unsigned long address)
+static inline void *isa_bus_to_virt(unsigned long address)
 {
-	return (void *)(address + PAGE_OFFSET);
+	return phys_to_virt(address);
 }
=20
 #define isa_page_to_bus page_to_phys
--=20
2.17.1

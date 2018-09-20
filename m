Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06026C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A296821522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hzGfN0Jt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A296821522
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388406AbeITIaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:30:35 -0400
Received: from mail-bl2nam02on0106.outbound.protection.outlook.com ([104.47.38.106]:44649
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388360AbeITIad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7aHw5z32XVsYXsTY8TwMxbrwviD8ZfkDolSYysKi3bw=;
 b=hzGfN0Jt32ktyqaPIWN0Bj+Q+4iUbMWxRoNB75OWzwHhoRavRMAOHDJxYDMDGGz69VBwPxhraRwQ8bpOHa24RQRJX7apo3SBDCKEXRcgXh4qPsq4AdoPEhpbF37Ra7tbUI0Dmtz4D+cd8k3ORnUWMWvpIesPS+o8SnSAuSVRRjM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0744.namprd21.prod.outlook.com (10.173.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:49:20 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:49:20 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 25/25] x86/pti: Fix section mismatch
 warning/error
Thread-Topic: [PATCH AUTOSEL 4.14 25/25] x86/pti: Fix section mismatch
 warning/error
Thread-Index: AQHUUIxrSgSxSEVGqkeebcKxBdIuVQ==
Date:   Thu, 20 Sep 2018 02:48:33 +0000
Message-ID: <20180920024810.58594-25-alexander.levin@microsoft.com>
References: <20180920024810.58594-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024810.58594-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0744;6:ebEYGexGrKGxUZ+NdRPhemInmn/abJTAA+rNDsHkHN071HPc3ef0f6XwIGj/IRkr65kn7wrQaPl6unda13W+Jj6FwPlpoFKgJMrbzSzLw/IPYljq/GqvjDT4M/q/c6QWnKK7Dz4I6A5nUxLrjfcCPRX59EusnmwNRMCw9DI4ZkWVomy9ilzN+jQL3oO3KCweLoD2sul2QhoRVDJtpAuMTdJAp6xB9PeLQUcaT6GBjAZhexcT3FtVlkDSjcYvGcXwh4K5OQL3WXJtzbIfF1SVQx3mcTVl/qhz/olUwNnOE7PKviolJBgCNa7GkjNmSIYwIrUxmWfQke8Nmd0mKbKMCiHKRnDp22PSi2HQQn+4z7dy2S8I2dcqVHT/aS/o2Q4Ly4ouUjmwDLLrvY3HRwN3bihQveBCwQYtTSmOTL/AKG0RKR7qvyhss7OtRx5hg0y/lFvWKaM2vggOybaEzDABcA==;5:1W3UWuDTdPGkPLBNg39w5Lsgr124McrrzjeHaXVcm6zKpF1R/MOfIIGJmv0dkBEdcIdRMBuXNeIHuMHBjzVqhqlR6WcYEp4pxL4YzERXeNC+DLezceoUm03qYC1rhPhjV7XZ84/cwlafw7eGUk2E41Z3qwrs56gfIx6/kMkjRxE=;7:XB5TCe8Q9RaXyXlel03JUc/gPhkaE4zLu5ZnhfXlqhe+shAYAbfI+Sya9GkiB51E/cPb8V+4O9CAdM3qkqNhNvco8jv2hkaRxSky8AAl0w6WT2YUPC2ikjCNa/shkRwsIdaCcgFelTSut+Et9zw3pU7Oo36Hy3CeERuV2yFIaYH/vNHk29MH7CUeBi0gALO0ngHKtztAe3FAEaiLW/Iqugwq6vTIuNZImwaTwGnGIlpRhp0fRX8ZArbOriYBqJ1Z
x-ms-office365-filtering-correlation-id: 741af7a3-31d7-4ca0-3ee6-08d61ea3aa4b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0744;
x-ms-traffictypediagnostic: CY4PR21MB0744:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0744D180593BFD3577D8ACA0FB130@CY4PR21MB0744.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0744;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0744;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(8936002)(6436002)(10090500001)(110136005)(217873002)(54906003)(6512007)(6306002)(53936002)(68736007)(5660300001)(14444005)(256004)(6666003)(71190400001)(6486002)(316002)(446003)(11346002)(105586002)(476003)(106356001)(478600001)(2616005)(2906002)(186003)(25786009)(10290500003)(486006)(71200400001)(72206003)(66066001)(4326008)(966005)(14454004)(22452003)(36756003)(102836004)(86612001)(97736004)(8676002)(305945005)(7736002)(1076002)(86362001)(81156014)(26005)(76176011)(6506007)(5250100002)(107886003)(2900100001)(99286004)(3846002)(2501003)(81166006)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0744;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: F0uKuBAUcT+GGTCdOCpTDX2heQ3rKRjYyDrnzxoTjrAoG+vs8vc7AaztNpyEXII5O4ZYkHXzXc6B2r0ivtqPxnTp+4amN29LaEZZhJDUEDd/7xx2/0HwQJjebyuz8r1QGzCzkC0VEOmzTdJxyIE8Va7kNAkApcgWT6RthEhiYwh68P5uwLqFyy2HVMhjMcNqGKEOA+als+P3ixcssux/j+gQjM4RYZBuVYzkVbDRo/EzFaIQUsYRpTRLnWBXjc00Od8vDlAggHaVYBhVmpOsQfNJPk4lxDIeD3dHJu5wszTSvG0Ic+9GYf9msF5j/wJQwA4YrMEC+Nbz+TExs7tOwD3EkF7fpml5iF58utui9o4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 741af7a3-31d7-4ca0-3ee6-08d61ea3aa4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:33.3663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit ff924c5a1ec7548825cc2d07980b03be4224ffac ]

Fix the section mismatch warning in arch/x86/mm/pti.c:

WARNING: vmlinux.o(.text+0x6972a): Section mismatch in reference from the f=
unction pti_clone_pgtable() to the function .init.text:pti_user_pagetable_w=
alk_pte()
The function pti_clone_pgtable() references
the function __init pti_user_pagetable_walk_pte().
This is often because pti_clone_pgtable lacks a __init
annotation or the annotation of pti_user_pagetable_walk_pte is wrong.
FATAL: modpost: Section mismatches detected.

Fixes: 85900ea51577 ("x86/pti: Map the vsyscall page if needed")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/43a6d6a3-d69d-5eda-da09-0b1c88215a2a@infrad=
ead.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/mm/pti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index d6f11accd37a..3fa048a4eb6f 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -220,7 +220,7 @@ static __init pmd_t *pti_user_pagetable_walk_pmd(unsign=
ed long address)
  *
  * Returns a pointer to a PTE on success, or NULL on failure.
  */
-static __init pte_t *pti_user_pagetable_walk_pte(unsigned long address)
+static pte_t *pti_user_pagetable_walk_pte(unsigned long address)
 {
 	gfp_t gfp =3D (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
 	pmd_t *pmd =3D pti_user_pagetable_walk_pmd(address);
--=20
2.17.1

Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B240C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86C62083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Bo/oD0h3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C86C62083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbeIGFSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:18:12 -0400
Received: from mail-bn3nam01on0105.outbound.protection.outlook.com ([104.47.33.105]:26432
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730574AbeIGFSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhAdk7vBKkTIrcvG+jQMn72tY48M/dJi1AXXLvwy0Ps=;
 b=Bo/oD0h3aPlXV9BT9QMeerOF28Ux+dmD2ik3EcVBC/zzfp7gFKMC1SIjIC+tkOtmr7+Cr7zDVnPt3saFAeY+SFG6C8HpM2hVQv5GrE58eLUYkQMZUN9BN1n+50ysBNHpZ+2Tnwg/JILVwUQVj6enXf+FNiNHt68lYRk4AbhtY8g=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:40:00 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:40:00 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jiang Biao <jiang.biao2@zte.com.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "albcamus@gmail.com" <albcamus@gmail.com>,
        "zhong.weidong@zte.com.cn" <zhong.weidong@zte.com.cn>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 66/67] x86/pti: Check the return value of
 pti_user_pagetable_walk_pmd()
Thread-Topic: [PATCH AUTOSEL 4.14 66/67] x86/pti: Check the return value of
 pti_user_pagetable_walk_pmd()
Thread-Index: AQHURkMMpnyBu2xNLUm7wHte0qE2vQ==
Date:   Fri, 7 Sep 2018 00:38:08 +0000
Message-ID: <20180907003716.57737-66-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:uMCwNl8OfEKKwlKw8ebuVKOpBYXCC8Kh9jf8gyH+GimmRBpcZMjte/jDl5H//0/TiMtEGP32Ppi4weY17aN38JMupKcLdMxCVShwu7cnvcLr7xqhmq5U1gAskxYHkl3iyWtNMii5EzxyRmi4o1XbxKxxcZyWfYqgbxOPVs28/8m0vrJAxXDZYUIAS+e6EMMCjmvKnwliHzxquA+ehl+nBk34ik4emH9K+0VQ6ucIPELq000zGf+1mrHH+BD+HL/Pp8oZm3uLykPNNHAHzlRZiO0JqHcPw7uDazvF/Zn0zVTXKm0E3lAuORMKC1kCDdPO99rQDj2N3iDgwhU/XZ2TbqcMbuax/zORoPJrspKRNkuySnecm4hMOXurDqAj5preg7zEV5wHqy8ymSnxnH0EuNmQX1sg6AI0G93Ll5khAh9+eq0OZnwdPaasgJ0O/D000IKmRe9wtJrQ04Va9gJVSw==;5:inW4rrYVMiGGQWG/YAbRzJlcRUbAC1/AYPoUmuNrMbW6aUr94guwLTb1WhYRg//5FCcO3rtOTIZiujLRR4IrVIdKtqKu/ye0IbKqYzyIiS2EEDIH+mpnOAqlgjRh5rwWpg4PKoEhYyUolX/mA7+Bisl859VtHDCjsfXiAR0aiAI=;7:P8qHOliTkAhHShpD4iqSi/bpMzhdsDZf4oD49rhyAstuSKx3Iw9k4erZCgTnoJ3WkVDabo7quUcb4ViJ7/FjV9NPKz1NdLn6yjfvqkSEZrbNDXpocL1CmUnMkY7PpeAg+5XhgTJ766XdVAPwE/TIuaSEj4E4X+6TrIs+yuE6x0oiyv2KMBjtBInSuYJTCwHIR33qgeYleE+WIX8HUPWR/VL+7YqM9nqe3dEXyKWMd74iUiLIMCvbNA4EyJm+yanx
x-ms-office365-filtering-correlation-id: a790d3e0-3a72-4a1c-e26a-08d6145a714f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08555917A28489627076DBCBFB000@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(42068640409301)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(366004)(376002)(39860400002)(189003)(199004)(53936002)(316002)(97736004)(2900100001)(86612001)(25786009)(86362001)(2906002)(6306002)(6512007)(54906003)(39060400002)(107886003)(68736007)(110136005)(4326008)(81156014)(10290500003)(14454004)(8936002)(66066001)(81166006)(8676002)(3846002)(966005)(6116002)(478600001)(72206003)(7736002)(305945005)(1076002)(106356001)(105586002)(6506007)(76176011)(10090500001)(6486002)(99286004)(256004)(36756003)(2501003)(26005)(186003)(5250100002)(14444005)(6436002)(5660300001)(102836004)(217873002)(476003)(2616005)(486006)(22452003)(11346002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8XNMCHXfn7gSVWl4eMlgKjHT83C0pLo/2tdyR7RjLWhG84LWWlFtnmMNjzIIQqDxWHQh8UIfPjenV9mudr6L5ClqTqg2ly3TNjBVp0Ss5QIyK2tUCJaEGWFDnVof7/posIfgkClpD0o5t0rVZzjr8CkrHwzo/fveQvG0oPP9RaiGaGyFMBjw+S8E4t3k/0V/O7mL6I4Ko74LD6Y1YzlIb5OvPN1EmYOmJaG2eC8zJCKCM17Ixv3X+1kILJBcYlOJAF2hu8KTvc8p4K2dpWEsiNwr4FFaPQek389zi8uJ7EmR4+qlHUP08k+H1wF5hw9zSRMYwUUAu10PLqnSSYUEeEW6vJKypzAYAiPogPeZBPk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a790d3e0-3a72-4a1c-e26a-08d6145a714f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:08.5620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiang Biao <jiang.biao2@zte.com.cn>

[ Upstream commit 8c934e01a7ce685d98e970880f5941d79272c654 ]

pti_user_pagetable_walk_pmd() can return NULL, so the return value should
be checked to prevent a NULL pointer dereference.

Add the check and a warning when the PMD allocation fails.

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: dave.hansen@linux.intel.com
Cc: luto@kernel.org
Cc: hpa@zytor.com
Cc: albcamus@gmail.com
Cc: zhong.weidong@zte.com.cn
Link: https://lkml.kernel.org/r/1532045192-49622-2-git-send-email-jiang.bia=
o2@zte.com.cn
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/mm/pti.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 63afd15b32a5..7786ab306225 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -191,7 +191,7 @@ static __init pmd_t *pti_user_pagetable_walk_pmd(unsign=
ed long address)
 	BUILD_BUG_ON(p4d_large(*p4d) !=3D 0);
 	if (p4d_none(*p4d)) {
 		unsigned long new_pud_page =3D __get_free_page(gfp);
-		if (!new_pud_page)
+		if (WARN_ON_ONCE(!new_pud_page))
 			return NULL;
=20
 		set_p4d(p4d, __p4d(_KERNPG_TABLE | __pa(new_pud_page)));
@@ -205,7 +205,7 @@ static __init pmd_t *pti_user_pagetable_walk_pmd(unsign=
ed long address)
 	}
 	if (pud_none(*pud)) {
 		unsigned long new_pmd_page =3D __get_free_page(gfp);
-		if (!new_pmd_page)
+		if (WARN_ON_ONCE(!new_pmd_page))
 			return NULL;
=20
 		set_pud(pud, __pud(_KERNPG_TABLE | __pa(new_pmd_page)));
@@ -227,9 +227,13 @@ static __init pmd_t *pti_user_pagetable_walk_pmd(unsig=
ned long address)
 static __init pte_t *pti_user_pagetable_walk_pte(unsigned long address)
 {
 	gfp_t gfp =3D (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
-	pmd_t *pmd =3D pti_user_pagetable_walk_pmd(address);
+	pmd_t *pmd;
 	pte_t *pte;
=20
+	pmd =3D pti_user_pagetable_walk_pmd(address);
+	if (!pmd)
+		return NULL;
+
 	/* We can't do anything sensible if we hit a large mapping. */
 	if (pmd_large(*pmd)) {
 		WARN_ON(1);
--=20
2.17.1

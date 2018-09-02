Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841AFC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32CBE20841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GiCH+Q6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CBE20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbeIBRUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:20:41 -0400
Received: from mail-eopbgr680109.outbound.protection.outlook.com ([40.107.68.109]:62112
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726426AbeIBRUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogrfTfn/L85Lnrr1xFrzhJFqIngIGT8LPwZIxWLjrcI=;
 b=GiCH+Q6rKKBHV1Yb5nxeYnTK8u4DwT1jBlyF4EOMt16etO4jSgzuPBWiSOHwGSr+lZ2MNSdEkTjRAKhbx2WSlHpTgXjtYxM4jPqVeQp3weXJdO9gORON8D7cjuktEv0zxmhOt7p+FS15MvamH8Pso2+EjRGkLLsYF4K/By8nPJk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:54 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:54 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Vladimir Murzin <vladimir.murzin@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 074/131] ARM: 8783/1: NOMMU: Extend check for
 VBAR support
Thread-Topic: [PATCH AUTOSEL 4.18 074/131] ARM: 8783/1: NOMMU: Extend check
 for VBAR support
Thread-Index: AQHUQr2BlsCTyKVVF0iLSAo9msnYpA==
Date:   Sun, 2 Sep 2018 13:04:38 +0000
Message-ID: <20180902064601.183036-74-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:iokgmtBwsDJ6Od8r+szgjp/po0eXT+ue6Ko5rgwfUtPnBDfMN4towowK+oPwNJSxaOtk+jgf4j4pkEemVq4lGHJQyqW2vJy2FnivvPL4URPuWur3OW/Hv0DxbUBC8QY18wMZEgSulTcgVTIVQQ/NzmzONRSKFdB8osGhtxuUceetBVHRfKJp3xioi01nMDD6zLhq8sF2VTgHn+jkmewcAmkIB/I9VhWj4LJ6+qwtAZnLbyDb2QKoZY0ekQps+q9ZSvicrs9OHWUIIknGaXLF9Bkn1pUHOoAW4ZrKnQTkLmGPbBKDjF1i5aoYFxfkxcKN2J2HYtz4Spke8NPEmQvHSNKxJgcGH9+2KlxRDuAgfjjCl+HgWzdvaIt1xx6M4omt1vAbIAnufHfEBv7OWFkgi702bZaYKjNQUr2xX0FC5GVRwqCM/Te7y50atXJXEc8ZDP44oeTzWEMlIcZLPOP8Kg==;5:xR7MpPuDZENg0FbbDKISgzLxuQvWxaAeeXKJZimtClnOJi4glmWcTvsZqlkVlm1FUoyO53+IIBtpTEo6kNdv5oORUM+fatAvId29183CuBZ0YLyFY1sizDbqAZFb+g3oA8CFRsgrRdrQJhZq2heIdGs5D+mco53zr6sgaWmX+N0=;7:xvZ8m8HQGPI4GIZ+PeXxrEZV4Y0iJqBHROfuLkRJhYbQdKf9OfYc2D7YdUSfFkilRowuTpOhK58N83Jast0GlcNMk35en7wH+CvFZSN6JOM2gbD6GYlQ+q5GTI53pFzFe8Z84lnw5tUC8rUBvF53E4bvD192xG9uMwSgmA13lMG4m+Er1MRcOw37wvWyYg2S6h9Hp2CA1VsyYblS+e5fzjJWnlCX6XAsbj/irTz8NfU5O+9t9icV3955tIxr1MkE
x-ms-office365-filtering-correlation-id: f7229f9a-2566-4cc1-bae9-08d610d4ad27
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07412274402C2A6EA3F88971FB0D0@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(192374486261705);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(97736004)(2906002)(186003)(26005)(256004)(14444005)(102836004)(11346002)(25786009)(476003)(486006)(2616005)(446003)(305945005)(66066001)(5250100002)(2501003)(7736002)(6506007)(8676002)(68736007)(76176011)(6666003)(99286004)(6486002)(105586002)(81156014)(81166006)(53936002)(5660300001)(22452003)(478600001)(6436002)(86362001)(575784001)(14454004)(54906003)(36756003)(106356001)(110136005)(6512007)(4326008)(107886003)(217873002)(3846002)(2900100001)(316002)(8936002)(1076002)(10090500001)(6116002)(72206003)(86612001)(10290500003)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QDeRTt/UzvoOnaaHsvaphrbcMRt1+9bblyBd7+7DF+zn+FSER2QG9Nx857Oj6EvbPE4aJHJfPYynRIZXB3OA6H1YA4g+pkV+TejDOBT3UKFFDfN0iq1LJ9gKzEc7ClkPNpljHYVqgNadIjCifJjehTrVd8f/gHz8shEK5yIW3Nmj3ZY7W9XjeJb9d3RLyk7pXeFSAW1Ve7NIYxysuyHmwiZJw70fu4tATVz0DFCD8JG0gp5QY7flmXl3l3wG+oL6ClnFM/VYQSo5j8qqCC72qDf4P8EW1oK8KOUBI4c1cCZ3GMN3H19uC4WDWSYYl/1eV0UG0J6h+R7eIxSCO0JF4lcCOQNorh8iBZ26ZomVqis=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7229f9a-2566-4cc1-bae9-08d610d4ad27
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:38.3344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Murzin <vladimir.murzin@arm.com>

[ Upstream commit c803ce3f18bd93b3b4a15d1da0c5b5ebc60e0b85 ]

ARMv8R adds support for VBAR and updates ID_PFR1 with the new filed
Sec_frac (bits [23:20]):

Security fractional field. When the Security field is 0000, determines
the support for features from the ARMv7 Security Extensions. Permitted
values are:

0000 No features from the ARMv7 Security Extensions are implemented.
     This value is not supported in ARMv8 if ID_PFR1 bits [7:4] are zero.

0001 The implementation includes the VBAR, and the TCR.PD0 and TCR.PD1
     bits.

0010 As for 0001, plus the ability to access Secure or Non-secure
     physical memory is supported.

All other values are reserved.

This field is only valid when ID_PFR1[7:4] =3D=3D 0, otherwise it holds
the value 0000.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/mm/nommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 5dd6c58d653b..7d67c70bbded 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -53,7 +53,8 @@ static inline bool security_extensions_enabled(void)
 {
 	/* Check CPUID Identification Scheme before ID_PFR1 read */
 	if ((read_cpuid_id() & 0x000f0000) =3D=3D 0x000f0000)
-		return !!cpuid_feature_extract(CPUID_EXT_PFR1, 4);
+		return cpuid_feature_extract(CPUID_EXT_PFR1, 4) ||
+			cpuid_feature_extract(CPUID_EXT_PFR1, 20);
 	return 0;
 }
=20
--=20
2.17.1

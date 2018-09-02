Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271ECC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB233204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OFTvbz1o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB233204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbeIBRXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:23:18 -0400
Received: from mail-sn1nam02on0115.outbound.protection.outlook.com ([104.47.36.115]:45032
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728494AbeIBRXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkHnFNmWY2qAnnjhUpxWC2V7L8bGkVaa4UZPxus7CRc=;
 b=OFTvbz1oKhMNMshUxDRUA9jmvIqIQHZeHdWuER8bHRUWP9DXcgtzBBGMVV+D677bccS+L2jlotqSVO4PcZpDv+Oig5Gq3cv1rGF32ygnxw1OgrN4RR+2WblSyMU/TULqvHmYI+AM+khy8L3g96/m8+nwYKy+T1n/8S7fL1F1+Yc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0503.namprd21.prod.outlook.com (10.172.122.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:07:14 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:14 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Vladimir Murzin <vladimir.murzin@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 49/89] ARM: 8783/1: NOMMU: Extend check for VBAR
 support
Thread-Topic: [PATCH AUTOSEL 4.14 49/89] ARM: 8783/1: NOMMU: Extend check for
 VBAR support
Thread-Index: AQHUQr3c+8f45WjXpUKg+K5Z8FLtkQ==
Date:   Sun, 2 Sep 2018 13:07:11 +0000
Message-ID: <20180902064918.183387-49-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0503;6:/phF9aTFUrG81hI3YdKHhO9qbSeoC9OWZyqC2qQPd69PX+Fu/vLS+XnuhNjqrIkDJjX3mXzyZ0neoxiKk4E/hytSzUEVYA4wydIOSpMAnPmoRRQ6K27U/bvm56obOWA/J+n/fTBSHtnAhwOhsBknQK/DMBK4eyNocgEF0jyUWdoTAUdldbfxBLI++1hpCEbdhBwWQmN5mRqFGTDbxhXh9+5HMZgPyo4ai3gCvQfY1p9XfxoHDPRxN5AECmFfJtNw2FH8jkt/Yw6sbOKw1M3EdGIhiGvnqPZAcb0NH4NpP3GGMaW9K504AveyDaQZU80jsl8MdH9kQj2KsGXIiCDmV2WtnT0+Xpsj/OUgV+uUY7pB+2WK+ofTadVwNrG1lI9IajTu1a1D9FuEqlKOsDY/HPonkXATDXaVg7KD6+36Ig35yuRzu4J/Dqqsf4HNCFtJ2t91u2dy9CMaogIft1JdpQ==;5:oa2HX4WFEygn9bfuRFSh3UrS7PhNRzqLkM0XU1jnm/+wJan6HhCMrzZsJXHU5KhnXV0rCamHq6D1qUmuexxEI2ObpayO2dehfx5xDAm9unklSW7ZZapGLcEVrMvlK2i2IuXM75WsRGL5rkSyr0A/oTbOqu9X4OiHoBwShgx9tcg=;7:yWumc8uc3nIuZ3Zqds4zqvbxPf1MyvSaoHcAFfjnroG1tdDgM61IELdIOBbmgkQVIBo/m0nu0W/03K2FcWQpDUve+rY5pTL+CeuvbGwcB4AEuJbvROJROaRFwiQI8FicbIDntBZCOa42J00pvgdcvJIQ8Cc6BIDtTsMhi6z0kVYOGBpES1LpsSIPdSDdGrGt64XgE5g26AXDeuiqC2e1PanshMSsIPcs+3jISglG+JEBdYWzbYXCB7ammwvTZSVj
x-ms-office365-filtering-correlation-id: 9ad37875-df8a-484e-c027-08d610d500a8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0503;
x-ms-traffictypediagnostic: CY4PR21MB0503:
x-microsoft-antispam-prvs: <CY4PR21MB0503F249F005A982EAB2895FFB0D0@CY4PR21MB0503.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(192374486261705);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0503;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0503;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(376002)(346002)(366004)(189003)(199004)(105586002)(8936002)(102836004)(6346003)(68736007)(2900100001)(6116002)(217873002)(186003)(36756003)(81156014)(81166006)(1076002)(99286004)(26005)(5660300001)(66066001)(6666003)(8676002)(54906003)(256004)(316002)(305945005)(22452003)(3846002)(10090500001)(7736002)(110136005)(14444005)(106356001)(2906002)(6506007)(10290500003)(2501003)(478600001)(2616005)(72206003)(6512007)(53936002)(575784001)(86362001)(86612001)(107886003)(6436002)(14454004)(76176011)(486006)(25786009)(476003)(97736004)(446003)(11346002)(6486002)(4326008)(5250100002)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0503;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 9csgXsA9PoutfxcgtTlGsDQTB1Qi/73TkENQlyDVQCxRF1nzBLKvtcKKGybSF7V2599f6paOYnmIyrg/kTns8e7rQfzdiMGhCKWngOpmOVMsgzN40vmyhFQ11SRVfKTprr1QM53BVkX878XJF+pcRCg9KjwgbwsVia5gfz4O1dgma+dONAHSfmt+j2IBp00RTA7GEJXGF5eViFBj4ZKtfAE/2uJsEPY0G5cqYutxI4/QnuqHYHhVOGYXAJovBmIuHjm2D+BsuL1BxYbEOiRhQLAjHSgvog65fCNoZZ+jeBphvBwPfHVCHLJCkxTD/ge0TZMq7+sBbxSSaGfbNIeMOlLKM99BBP7Axiz3c9wVs+k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad37875-df8a-484e-c027-08d610d500a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:11.1924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0503
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
index 91537d90f5f5..08794bb0cada 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -305,7 +305,8 @@ static inline bool security_extensions_enabled(void)
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

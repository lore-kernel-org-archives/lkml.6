Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21E1C43143
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518C72083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="e0oV3X3z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518C72083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731171AbeIGFUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:20:17 -0400
Received: from mail-by2nam01on0091.outbound.protection.outlook.com ([104.47.34.91]:29984
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729678AbeIGFUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Txy5MCiCAS2trnF06c4nWyU/T0dqb/G6wCycjG6rHcg=;
 b=e0oV3X3zlnObFy4ajwaZCzoKop6rZ1FD5TvXbYNRy+2JW/9rEVZM1NquDqtgT8VajTKY8qjQ5bd+ku2hA9ardoCy4ZunJ36XvIRcaZKgQdTwNrmlpYJsen23k2t91DR70bxrNlwAd/7TPArfH8r/KIz+Jdikay08UNnd6R9sm9s=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:42:03 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:42:03 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 20/30] ARM: exynos: Clear global variable on init
 error path
Thread-Topic: [PATCH AUTOSEL 4.4 20/30] ARM: exynos: Clear global variable on
 init error path
Thread-Index: AQHURkMyL+/Yl3V0wE+wBtOpRhqRYA==
Date:   Fri, 7 Sep 2018 00:39:12 +0000
Message-ID: <20180907003853.57942-20-alexander.levin@microsoft.com>
References: <20180907003853.57942-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003853.57942-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:nxDMFaqMkg7ehWPG5hTYFex5vr7R5wDCBl9qPFjq/m80u2zAKboQ+i2Jvd9t60V5eVC+O+7Z4orHyeSPnQT+oPWgZelvu+b4+gVYrO9o19Q0I69KHwPlprzQI11xTplDz4pEOWuU7fu9a+hEAAJ+kG9Be7vHLjeiDRmGuMiQ9bGEdx2KpuyVlnuIC0ikAaCRnBTUjXAsEfo7CnvgcHnaUIE3Rys6gU1DQ6KHtneRmoPDFDIQH1aEhhM/b61rPKZ6rTpqGR4uhDgfDGS4i3Lmm9tyPBedusAH9XKQ2cz0O3B4bwIzCwp9W+KCGwuBjrr5PXWbQdGZ/iTYHAnP4SMo8lkR/wt+X69dldECafJmm2uqmvgr3YxfJfBib6t9loiVnpCLFjvi82Nbva8Pl0h5Uq3E5mKqXqBX0f5OXWb685vuXKPlaTd9VqYkfjGbbJSuab3VucioznoPP81rMsreAQ==;5:mfYX/1/j/QifLPsQuHW013Qyi0iFxY3JQF2e2qFUHGFE6+QG880mJKu030TJTYGRrAhSxqTuAov2qcYU/yVxk2Io8IhSW5v13eVjpfojINwyroZdaa8w/AfhGiU/v6uLrbU/WstqxWWgnlP/wYIFj0ZIW0kPmDH7RljmKHn1jZ8=;7:Y5vOMu6uSlk2ALimy8w1k+wpybbV+LuFU0grWA/wpXuwI2LKWJrGZYaOd3PSy2X1Ieijq/UDVGpcdMkJA5spaXl8u9leebQyv1ClKec8fD8lCbJYBSEnobtW1n5XUwXaIBXI61ScxSPNeO+0Ustm/oFREv1qRyFtLM4FII9aUcEDeJtRDGRokkRx4IEjo9n26aR0B4d9AgG59ooc2S3t5Gl/HT8vsQeVffv4VBECe6xWdwJFr1feO8SmeEni/q0i
x-ms-office365-filtering-correlation-id: ed4dbedc-aea3-432a-1aca-08d6145abadf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0822D026F83FA7DDE87ED5FBFB000@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(6506007)(10290500003)(478600001)(102836004)(81166006)(14454004)(22452003)(6486002)(26005)(53936002)(186003)(6436002)(72206003)(2501003)(5250100002)(110136005)(6666003)(54906003)(3846002)(316002)(6512007)(36756003)(1076002)(97736004)(8676002)(81156014)(6116002)(5660300001)(10090500001)(76176011)(14444005)(2906002)(256004)(8936002)(2900100001)(99286004)(66066001)(305945005)(7736002)(486006)(217873002)(68736007)(4326008)(25786009)(476003)(106356001)(11346002)(107886003)(446003)(105586002)(86362001)(86612001)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EvgarRI3ibu0RRtj2+R2z+jmQVzuorh7WUp+WnnWSS8/laGkrQ/U2lGaCr16YWO8fBkofegktCeNuxSNycvJI5hH+svYfjrq34C1HS8jPKT/TkKUY/1XSTAG5OCaYJw2MkOjVEt0mnDMdudcPlgbOglnjIm47h1IpxgkqI8VJjJ2sGI8KdoGbggR6aKTtrdO7eZQXeS+7KMF6C8rti/cmRRhfHXFj2XB6of7axUN5kUk7xVSgkBlAKBr9MGPQ8BNVoNkvCeq7XIDrxZTpiuLsl9Bt2xU0Ge/PHyNZh/LaYO07KgELbaZdMF3HmpAEvOHOtGzEqX0k1e+ms7nPuI55U4YaXLJUeTRogDe2kbGe4M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4dbedc-aea3-432a-1aca-08d6145abadf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:12.0814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

[ Upstream commit cd4806911cee3901bc2b5eb95603cf1958720b57 ]

For most of Exynos SoCs, Power Management Unit (PMU) address space is
mapped into global variable 'pmu_base_addr' very early when initializing
PMU interrupt controller.  A lot of other machine code depends on it so
when doing iounmap() on this address, clear the global as well to avoid
usage of invalid value (pointing to unmapped memory region).

Properly mapped PMU address space is a requirement for all other machine
code so this fix is purely theoretical.  Boot will fail immediately in
many other places after following this error path.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/mach-exynos/suspend.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.=
c
index c169cc3049aa..e8adb428dddb 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -260,6 +260,7 @@ static int __init exynos_pmu_irq_init(struct device_nod=
e *node,
 					  NULL);
 	if (!domain) {
 		iounmap(pmu_base_addr);
+		pmu_base_addr =3D NULL;
 		return -ENOMEM;
 	}
=20
--=20
2.17.1

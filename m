Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C542AC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7113220857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dk8dYd/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7113220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbeIGFSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:18:55 -0400
Received: from mail-eopbgr710128.outbound.protection.outlook.com ([40.107.71.128]:33152
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726042AbeIGFSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5Q1vWBJwQMtLzP0WgIUYZ52JBXjweidVeY2zvTEixk=;
 b=dk8dYd/SNDDLAchXAubZJOnFr0M2j+S2qOnZAFEUkviMJOMDSkxrF5Qyj4OfeX6ofTh6MoZ6SRGWav3F5S5TxJcKJlO0DXU1jL8jiW1Fz6lFUbB72luSv4eRXMvkWMJOjtMaQP3WwqB6M6FkJvgKrFmOt8svYH43ihjkONK0VY0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:40:46 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:40:46 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 25/43] ARM: exynos: Clear global variable on init
 error path
Thread-Topic: [PATCH AUTOSEL 4.9 25/43] ARM: exynos: Clear global variable on
 init error path
Thread-Index: AQHURkMdHF+pyTkmlUKC9mpZh3+T0w==
Date:   Fri, 7 Sep 2018 00:38:36 +0000
Message-ID: <20180907003816.57852-25-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:OjRhIgHMv+lnQPnZTtsDn3kAzPzCONpvjKkeNaEk2MazeeV/coRyS27Uar0K7FbH7B5WaE4Rnuw6//E8n9RIxpfL/wHWtYo/D3AUvcKZCRolOjGL5IeyhkqBhc/g7GtvMW/Nv7CZFQWxjbLaqeKokOVKHuvS3qjx2fzpQmIxAcN5RRcrvOweAzOL0BvSUnpvDGOaOG4hq0vt/K/r6eAKu2COg1ieUYuV31/7P+9WqYP3AqEaSzg7I1gcWTBjjzAS2sd6YM/e7vHcPWCRfsBXagoaViua4MRh0SjVaz1GqR7FnNlqp4EAB/GtQ24SzHU5e630bFUpiCABkSkYxcamBwHN7hpcza3CZRScx20g0o8eekxGsYfX07+0WzjmoN3Jr/B7tB9AOeJNeZo4HG3cSzQ0tIGIKZdIVY/N/dVxOfGBn1Pwstpe14l84K/Y9hd55Rvzbq+1gk/h03RjM0lz/w==;5:xrRBCQgR8km7/X7H72a0LjZYHzxN9A36A1oS+brwqGSbGZoZtHVxEK/c1wwwH67N9wzKDbI0Nsmp3MCo6u8WULbUPa08BlZ/11VPIHmMxg0DooJu/TMZ1dh62d0P7Aiybv9ByX8eh3YxZAXWfxjkfPDUY5VCGnO3aQMSTG2Xn4I=;7:2sh4WT/KQj7VpGr4fHUWzTm41iBO3bQ20r4Nb40bW1/UROIsA2c7CMLa+ZWwXsklLSgzq5aOtleYSOrjdvi6SY9odt0okF7O4iduw0JOSGK3pNy0AUtGJc2c7SPZw+mrqa9S8tAWfRPbhi8ERrJ0PX29+NpAd7X2o2LsQX1QJmY33H5eRM/Tqn/Uwc50T9behZ629fSTFJvK6EFmbSgl498Fc3qZYrOMeb24Hev7UwGch0gkvCOi835KrO2Xn0NW
x-ms-office365-filtering-correlation-id: a4b8646c-4dff-4518-3f36-08d6145a8d2e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-microsoft-antispam-prvs: <CY4PR21MB0165C5DAE0F0D5218B1503BBFB000@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39860400002)(136003)(199004)(189003)(76176011)(10290500003)(305945005)(105586002)(102836004)(478600001)(106356001)(2900100001)(72206003)(7736002)(26005)(99286004)(66066001)(3846002)(14454004)(8936002)(110136005)(54906003)(256004)(316002)(81156014)(81166006)(6506007)(6666003)(22452003)(186003)(14444005)(1076002)(217873002)(5660300001)(6116002)(68736007)(8676002)(10090500001)(6512007)(86362001)(53936002)(97736004)(5250100002)(2501003)(2616005)(86612001)(476003)(4326008)(446003)(107886003)(11346002)(6486002)(6346003)(2906002)(36756003)(486006)(25786009)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: yYbJus4KcigJ9T1CVtjKJAPUr0TJ0oczT4lDkHBW+vpQrxHvxAOAwPCcgGAevYZ4mmihUeOAFPPqKe4FZHYifIxQGvZsqUJfrLEHhT0Vbv5P3P4kjkJrKak8m0xNnljmvyPXmUXmebTgo5Bry3AV9O7wMbrzl94pPV8dgvR3+rC/Me/o7/e0wdbvR1i75xxyZTadMjl6i7nYm8DNQmnA3kFbkvs7LKwu271kyR6y2IwzN81FbkjtYDRxJFHH1MgjF+8N8d7x7WaMquddPKzRv9jYxzSaAdxDMy2BhAzH5UqD2LGpUMWJXoxmbizHlxOCjbG/uzh3IsCIKvADQ4cNj3eUA3p3ReQsYN/b+/Su3eM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b8646c-4dff-4518-3f36-08d6145a8d2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:36.7397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
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
index 06332f626565..3e1430a886b2 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -252,6 +252,7 @@ static int __init exynos_pmu_irq_init(struct device_nod=
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

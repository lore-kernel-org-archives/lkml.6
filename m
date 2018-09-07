Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51EEC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52CD42083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="d8W3kdG0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52CD42083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbeIGFP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:15:57 -0400
Received: from mail-bl2nam02on0092.outbound.protection.outlook.com ([104.47.38.92]:43727
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729606AbeIGFP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8z2sCjfqJfYWNpGWHI8QENfjU86+lEERQkz8Qftr9Q=;
 b=d8W3kdG04fXm7T2Z2NrK4/9Q1dBGeHZbZK6Dd2wkQI8ey55rx1TS7HUapdzyVCdkkFBE8ks/8juguqRPPmDtA/5P0I2HijQ1ZVUN6dL2rsX33TezquLMbnRMp1BHLtf2xZ5FpB8kIgAbWWnrxkttJ+9PMosvyxP2L1pjW+RubQY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:36:56 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:56 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 54/88] KVM: arm/arm64: vgic: Fix possible
 spectre-v1 write in vgic_mmio_write_apr()
Thread-Topic: [PATCH AUTOSEL 4.18 54/88] KVM: arm/arm64: vgic: Fix possible
 spectre-v1 write in vgic_mmio_write_apr()
Thread-Index: AQHURkLSMexuQhYT40WZ1l25M3vYDA==
Date:   Fri, 7 Sep 2018 00:36:31 +0000
Message-ID: <20180907003547.57567-54-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:fYv5AnfFxPwlkamZvvJFFaRWOD/JZ9Q/EmvbKFFzPeYfm5T+xajdQ9hArZcJ+bAqB1zpU6kqLJ2q7VfzbBrKG4jnZtYsGix/mZwnsxD8xSlMj6PDm5WTepGReOiidWLNFCCoeIYnDZWN6diZIA8USKDMNjhXVpqPOArg+xcQ9I4DkaQGMeV27/gJLGEf76QvQ0S4K8TUAwpywLo8wTkDwEmWChvXu24co9KoFZnARCK7VXRoFHR+mV67ZTABoxVTvCnHo0ZnT8LEUDvs1b6d0gMErY53lyunGDbfEIhKwy1Zu591cA8VlomnljYmBpM8skcMLWzv0qCW5V69QA6HAcLzfGTwf5qLWBB11i9Ie/DJZzANOv9cdC8KIbsekvZlP1K/w5lpaYR0elhbn8Boqh+FFiDH6cpN6ahDpH1iVF7moEFbMpYqWdwFZvqwZ5Z3BkHuyuKoIno2UuFTfrxj8w==;5:T9nvpsdUGPGUTLREtgu51FW/7Wx6K2XWeni4ut5Wf2UMBZ58Pghaq/+7bw1xSjsFOuNBttesuPSFMcT2hHKblfTCEwcUDaYaEHv6wRqOGilFvk3VEgUs0V6jwTMpqgXz6UbxQvfHgVH8PRcRivI2YvOeAwWsPzvteeKp/NBFFq0=;7:k7uuGgDv9tU5VDznctN7mc1NyNC/ut1maQU0bZbV7S+VAgUHpbWrZ00MgW2WMneANI6dBazsJIdZqOaMDedqwFWsGGOPYDwMAqRWc4jlTYeqZHO7fALh8/POUaGMI3/qJkgRulL+ekd7BeWSn32xWeb3iaJCJOK6erTBF6ZaB9ZU7ti1zQZX4j58uOK1i8L9vFLhcOjEg5dmNxOBF8aT1Pi37kOIN7Kb4PhxV6xzRXNcEHeLVaScTdQZIK+s4s1h
x-ms-office365-filtering-correlation-id: 5eca1c4f-5112-406d-37c2-08d6145a042d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB077306D7F6B542BB9DD4D070FB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(85170053105377);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(2616005)(476003)(4326008)(6666003)(11346002)(5250100002)(107886003)(2501003)(86612001)(97736004)(6512007)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(14454004)(1076002)(66066001)(26005)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XLuVSg5VTlw78ZWd4QR6VGl+mSL8gKOYb/Zz8EXWzFQs2N5gZ+NYF6gaGgc0lf96GODPNBTEv+Ek/uHbNFG92B3HctGi3ZN8dv26bsh4fOPFt6jT+gJPxN8Shw/E+5z5t/Aq6k+rBKMd264k2H5n18MMuz8Xiv1nF7BK4Vw0q33Pa2vsViED012gv0kLLXlQDL9tDZtUrHTmv3P75ZgC3JB5Y9kpnXimlIi3g5xego7XKtcphST+5/1AXXCGI+ANiufgvmYA89eyeBLtCHUXMiKEwvV8wlZNkjYknxKyswKX4LvYGrw/ckhriX7o7XekWDeZ7PoUjVVuHmxdrb/ETbY8n1yA2hdPEd2wAGATWTk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eca1c4f-5112-406d-37c2-08d6145a042d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:31.9366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit 6b8b9a48545e08345b8ff77c9fd51b1aebdbefb3 ]

It's possible for userspace to control n. Sanitize n when using it as an
array index, to inhibit the potential spectre-v1 write gadget.

Note that while it appears that n must be bound to the interval [0,3]
due to the way it is extracted from addr, we cannot guarantee that
compiler transformations (and/or future refactoring) will ensure this is
the case, and given this is a slow path it's better to always perform
the masking.

Found by smatch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: kvmarm@lists.cs.columbia.edu
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 virt/kvm/arm/vgic/vgic-mmio-v2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic-mmio-v2.c b/virt/kvm/arm/vgic/vgic-mmio=
-v2.c
index ffc587bf4742..64e571cc02df 100644
--- a/virt/kvm/arm/vgic/vgic-mmio-v2.c
+++ b/virt/kvm/arm/vgic/vgic-mmio-v2.c
@@ -352,6 +352,9 @@ static void vgic_mmio_write_apr(struct kvm_vcpu *vcpu,
=20
 		if (n > vgic_v3_max_apr_idx(vcpu))
 			return;
+
+		n =3D array_index_nospec(n, 4);
+
 		/* GICv3 only uses ICH_AP1Rn for memory mapped (GICv2) guests */
 		vgicv3->vgic_ap1r[n] =3D val;
 	}
--=20
2.17.1

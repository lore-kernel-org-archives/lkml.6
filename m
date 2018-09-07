Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7D6C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD992083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="lD7CAZqS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD992083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbeIGF3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:29:38 -0400
Received: from mail-cys01nam02on0116.outbound.protection.outlook.com ([104.47.37.116]:29216
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730267AbeIGFRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKX167D/he6MfznbIHFagZ74tdJFTnwN4pBFgqfYpI0=;
 b=lD7CAZqSwEM4uzcc8PmqSH/pX2vpTlYDfRe2j1yEPG9BCfTbPI4c2FwTlVluJrvf6bLoJIitTGPKl92Ez0rKRxNucpPv5ngpNM9Hk5hG7gx7y6+lLdCvTgB8Ikx6nLMmguJgnn01qFCsFyaEUcEa8W2D/ApEC58zP06E58/mAvA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0840.namprd21.prod.outlook.com (10.173.192.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:38:59 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:59 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 41/67] KVM: arm/arm64: vgic: Fix possible
 spectre-v1 write in vgic_mmio_write_apr()
Thread-Topic: [PATCH AUTOSEL 4.14 41/67] KVM: arm/arm64: vgic: Fix possible
 spectre-v1 write in vgic_mmio_write_apr()
Thread-Index: AQHURkMC2Cvd849b+0uD/E1Gmxi0sQ==
Date:   Fri, 7 Sep 2018 00:37:52 +0000
Message-ID: <20180907003716.57737-41-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0840;6:cFbDW+867mW5AI4MqMkU83NpqOK7yyKpEG3/cEo9G2T58jwHM5hO4p6clEjV9RVr3U4a9X0gsjh58yOopSOBts2AOJbCyNZN4wCSjVQy9N0ucCqCrOTZYDo0Gi83MCjQsTyI2HxC6smPzMCbTRa7vp4NhilFFKR6ltlK+rRU5wdev5Zo59phwqaRHYSx79dO0nAK+fN6X8XzuNj8cKTrSWvb1Hcoe0ShxIAiSd3B6qgiH6C1Y9bi5ZPM8X5pdnOrCIo/M8cVHCOirQGYfvlNChOi7HlvPZr3Lmqitv5ERuqpx1RUToZNIWY+CZJOU53Ei1Xc8cmrF4P+FrtWKVcbwzWvMe4dZ16TQ5Jg9KpHvqAmu4rFB+HMeIlj7PRIJC7HNjeHSpqVAL2cxT7z7tQHouEGfm3PiUSbQ99TidjXqIG2cknCd2aMQCZXpCo8+I9eZXsvSTw0aBt9BWF1TOhf+g==;5:v5b3RU2aDK34dY6WCisp3ML+MyYXcNFwCHDmTTubnzhvvM1/MOsbO+RH2ltUKTTlWQCpvtKvxEj7I4eusmmh6AwSNihmh2oKRVzKPRTJWmnzLvCot2JkuJ/jd0uCcehBoK7ZRUyh6ny9Js+m/merWu6qf4LpvRRXizaF0TKntdk=;7:X0m3lik/JHV105ak3oPsRKCV5odAPV/x705UwVXCTfceNkA56bO8CfuCTgWxcUAzrgSN90ibL5WK1XIxjhECJWxxCvgat2BwvOLwy2w2MpAmkxyG5ZJBZ/2ZUPvnpZkKNvprGN1qr7yeBt+splLBibTIogN6pQ9PSvJBMNqO9pbEpwfexfOjm3bqI+nqoSzc5IqRhErGRaZy6wx06ibS8iriHkUpgyWy/t7DDOCngkBKKNdsFgOdGlbGyodfkbVT
x-ms-office365-filtering-correlation-id: 4dd9d884-6ede-400f-4f7d-08d6145a4d2a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0840;
x-ms-traffictypediagnostic: CY4PR21MB0840:
x-microsoft-antispam-prvs: <CY4PR21MB08404D8E9B8A283F0CD1110DFB000@CY4PR21MB0840.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(85170053105377);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0840;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0840;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(39860400002)(396003)(136003)(189003)(199004)(66066001)(186003)(99286004)(26005)(8936002)(76176011)(102836004)(81166006)(81156014)(5250100002)(54906003)(6506007)(110136005)(11346002)(446003)(316002)(476003)(2616005)(106356001)(6486002)(86362001)(6436002)(105586002)(86612001)(97736004)(486006)(6346003)(53936002)(6512007)(68736007)(10090500001)(2501003)(1076002)(22452003)(6116002)(3846002)(36756003)(4326008)(8676002)(10290500003)(2900100001)(25786009)(256004)(305945005)(72206003)(7736002)(478600001)(14454004)(217873002)(6666003)(5660300001)(107886003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0840;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: EPXjmaxT13OorEggYdTpZVYygv/LImHGoBMCoz8u3nWV3EvX0WRr31dJ7mgaN8QKWxs3PMzxGnl4geLuJ13VuKyA8RTra3Ibzxs1i6o9ZjcefzGhoLR9vvlah0NGqql68DXqpBxbrNl5tJt/cntaIFLb29awkDgWmjGlroE008VtkADJi/SbaNLQpNDuPBu9EENMiduQzWgwgE5jgb4WloceM4ULJa8ZDr1ylA0yB6yEcKH+/824JPNw9SHwNcQkTjYJWR7jRGXK+Lo9TkL8CTdXgPguafxHakPLP/P3yTyLWbos97H+ETIkqw/mfq1ssDqq7MQl7azDz4+yHuYt2DCt1HCpI44OPO1YJNCfhs8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd9d884-6ede-400f-4f7d-08d6145a4d2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:52.0624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0840
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
index af003268bf3e..7ea5928244fa 100644
--- a/virt/kvm/arm/vgic/vgic-mmio-v2.c
+++ b/virt/kvm/arm/vgic/vgic-mmio-v2.c
@@ -348,6 +348,9 @@ static void vgic_mmio_write_apr(struct kvm_vcpu *vcpu,
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

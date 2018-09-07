Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B14C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E776120861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SNpIWbO9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E776120861
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbeIGFPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:15:47 -0400
Received: from mail-sn1nam02on0135.outbound.protection.outlook.com ([104.47.36.135]:30237
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729381AbeIGFPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgFRIeu9ez/6iIRMK+zowpZvKnEJ8YvxOx2LM61Xfzo=;
 b=SNpIWbO9qM4z6+yx1LFfAi5WUfNyTL8SV+LBIWADvTXPhqKXINIYjDfld4J6WafP/cs44DscesGF787U+bSpQ5FuLHj9EC1untxZRuk6rtLuzc5UU/pahPY07G6aIomRZiQDn6W3mFC9m2r4PE9xk33IlMeOZQ3DhAEDBY+KMIY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0118.namprd21.prod.outlook.com (10.173.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:37:36 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:37:36 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 76/88] KVM: arm/arm64: Fix vgic init race
Thread-Topic: [PATCH AUTOSEL 4.18 76/88] KVM: arm/arm64: Fix vgic init race
Thread-Index: AQHURkLbdEhLBxy1RkO7mEMHc1wR9A==
Date:   Fri, 7 Sep 2018 00:36:45 +0000
Message-ID: <20180907003547.57567-76-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0118;6:Kl9qGWH9BPVNssp2/RKExTEJuLfICfIUqE5ox2YrrDow/FdGPGOMdm0ZPfdvTWNvk4UTqVSzuBqlqDEJd/UdHXVZnLATMKPTv7DYctcHMkDdH7yF4HGBaFD9vG7g7XC/IU/ktXDw+3wuko9Sm879rj7cg4vUqFbByI3q7mbtNq3WxSGrnIyzA5cIjFnK+gXkxb/Ga7jHYmq9Gp3/iSfxrRBZ/Rn62z7KI9JyIL1NllYAybmkm2lFtboftGmrMUsvY5/tR1k7xYZ9i7dvSk7IMdgn8jCpdMVYOOvLlL2/BSdL7/rjVd5usJb75fMPdRw9zYZbSaekPvEw9wPTI5lVyx56h8wsfun48gAeF4sQMsW/veoMVMYgKYzYvNCWHZzydVEOw0NVJdhjc8TCYZJ9zRL+6HTraE0C4vGHfg8Ho/GIO9iQTlcn862GdIsYYnqSBuFB4pG+3vuXpmQnqGwmyQ==;5:PamnuxLxhw0WpWO7/UCTQ6eD0aoAoIYH6GKPrIyUa16OuqVvmqdRpHdGaFXHL2ECJNugDDTkuq51bt6ARb8rPQ6NX9QI0HWlvezEOxdqLGOATGsqI6hYrKVB81Iz2sQI0gxSZDZvtmvQ2+clbRF0T+WaIfPMnrSMyx4aqTg+eZM=;7:NFw4WAqz3gmfyDFp91kxcsGbyx7Y/oGsrqrhbLMZVEligb7PWA+X5PkDepNJWXQKR0yg+N6lsjH3pYyLTQs9mqCnNERweTaRJyIARWwhckO3+s+Rzhb+h70MHQ6PCNGj3n4PolJH0MEZWMRnbAraQ89lURsnHp5vX021Tr7E1btTc9CeEdljA/fMMhhEocJtaKM1VjTdPmyNV5B6mHDgvGEW0yv+z9MYgxARQfEalsFscEgklthBGBSqW1oc26L5
x-ms-office365-filtering-correlation-id: 1b6a5a1e-04e2-4653-1622-08d6145a1bbc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0118;
x-ms-traffictypediagnostic: CY4PR21MB0118:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01189AF3E0047565F944DFC1FB000@CY4PR21MB0118.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(209352067349851);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0118;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0118;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(136003)(366004)(189003)(199004)(97736004)(2900100001)(53936002)(316002)(86612001)(25786009)(86362001)(2906002)(6512007)(68736007)(110136005)(54906003)(107886003)(4326008)(10290500003)(14454004)(81156014)(81166006)(66066001)(8936002)(8676002)(478600001)(6116002)(3846002)(72206003)(305945005)(7736002)(1076002)(106356001)(105586002)(36756003)(99286004)(186003)(26005)(5250100002)(14444005)(446003)(6666003)(256004)(217873002)(10090500001)(76176011)(5660300001)(6436002)(11346002)(6486002)(6506007)(102836004)(2501003)(22452003)(476003)(486006)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0118;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: eYfodAABf6dxbx5I4P2M/J0vxQZTyeZrVf0V/RUq+jHj7DySNG4NZtgxb2jUpLnyAWDQ0SPTMN+ZAIOQtdD3SEs0zEYwIYCbv5JYZK73qXOub5wMVghatCH1B0A6/WGH1uStsOG+jL6oDGQy7qgqqJKz/UQgFylTnDg7rOu/qJpJtwtwcaw/3As3/gUnsO0sJewq270weusa37yiq78JiXAg5lrBBOJEzZr0AioUCkMvaZ9PrxCNK+Vn09vxHQaly7cn6OLCObN/OQeCxuDKJMWgM8jbjlZ505K80PhAyI7tdVLDrFtaCl16G2hKC67d47NVF1GfJNumg2mt11U4VHMMZ0zqR/KIgIi13GqR0AY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6a5a1e-04e2-4653-1622-08d6145a1bbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:45.8601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoffer Dall <christoffer.dall@arm.com>

[ Upstream commit 1d47191de7e15900f8fbfe7cccd7c6e1c2d7c31a ]

The vgic_init function can race with kvm_arch_vcpu_create() which does
not hold kvm_lock() and we therefore have no synchronization primitives
to ensure we're doing the right thing.

As the user is trying to initialize or run the VM while at the same time
creating more VCPUs, we just have to refuse to initialize the VGIC in
this case rather than silently failing with a broken VCPU.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 virt/kvm/arm/vgic/vgic-init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
index 2673efce65f3..b71417913741 100644
--- a/virt/kvm/arm/vgic/vgic-init.c
+++ b/virt/kvm/arm/vgic/vgic-init.c
@@ -271,6 +271,10 @@ int vgic_init(struct kvm *kvm)
 	if (vgic_initialized(kvm))
 		return 0;
=20
+	/* Are we also in the middle of creating a VCPU? */
+	if (kvm->created_vcpus !=3D atomic_read(&kvm->online_vcpus))
+		return -EBUSY;
+
 	/* freeze the number of spis */
 	if (!dist->nr_spis)
 		dist->nr_spis =3D VGIC_NR_IRQS_LEGACY - VGIC_NR_PRIVATE_IRQS;
--=20
2.17.1

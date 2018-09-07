Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFABCC43143
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B7C62083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BD6A+I0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B7C62083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbeIGFVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:21:49 -0400
Received: from mail-cys01nam02on0134.outbound.protection.outlook.com ([104.47.37.134]:20941
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726237AbeIGFU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sPDGphwtrk8sbxDrlxh/fPW1K6rfhPV18PC8bMrxxk=;
 b=BD6A+I0taot9G/Sx88C2CFNO9juRXHWuXs/cLq40qzylSUCOjI5yBIL8jJd3HxFj+wci9N9GXaOXWrhUmTHHNVCD/h/gftggTnSsoIb2s/V2YHIPJc/Gv2OQaQHfu1DGkVKJdYyoPjIYu8twW62eMlVTmVgC43AKIRHJWN+htm4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0694.namprd21.prod.outlook.com (10.175.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:41:23 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:41:23 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 40/43] KVM: arm/arm64: Fix vgic init race
Thread-Topic: [PATCH AUTOSEL 4.9 40/43] KVM: arm/arm64: Fix vgic init race
Thread-Index: AQHURkMi78Iqz/XODEebBi8mANJ/5Q==
Date:   Fri, 7 Sep 2018 00:38:46 +0000
Message-ID: <20180907003816.57852-40-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0694;6:4xWw+IKwZlxJhha0/XrhmnD+SUdFgPCVfAwDjOvLlFOR35vQvRaq/pWY3LTuF+wUbtPF8ldNYesbtmPC/Leqf0azZb/9LQMLx1stDuGFQpR0+91Yq3/00KZru/WZv6MYUjmw1zkCGuzB+SuMbnCOxyFliFSCNOaAKFnvi4ivatfdZqnaiHneYsAnwW/Bgx6g84nf1MRPJHGSgfs6wwfDfltF3ylfMMMH5yy4J4SZMNArTOVeVJgRhXJzVcuLw+Zyc8h006IBkCke1yJ1Ov9Pa9ZzOovPSMpdSDyBtDSJ+Oh+Dl4wj3AMwT792iMtooRjxWbi6fGzFUvWh46vn3i+e2lTRktzJstK9qjfoNTitghpldhgVKOW6zo4yxs931Ji3ak3+SZYEfBiyORuBkyORIRIapPb+bfDttHoDqlPZsvLzWVMkREdWAtt0jSemVXSF+MGqxjNuPSsoNIR3T4a+Q==;5:jM43LTFPDH3JQ2FiAPlNQ5IaZ5XBlpTfILy3auDIg7ERoJzsLEMJc/5WSipQHBJr+G24hFnHN62n7b/QJb1H9XJHTqM3u4BnmfR64PBp0lKtv016ALuulYnDniAGBfsYa4RXqzREwgKyqleZGUenwNnoH2cjWSNwHnN527Lg4vo=;7:mMaTBin9XU6opFtCx0HLMRKt+5E2eAni/8ZzpLuXJ2YuM1MP/WyvNtDbCp2xPGyGH+kxmjPpQuFUxz56G3ypLqRByGHCDJUknGmz109L9lGbzI4XkQ9w7SIEvNWD+jL0Hl9JZ4P00Y6VsG0IB6yZq9dx93VzqEIl4A0ooP7PXuLvwCOyMMbmSO2fV3nR0GsUIQE7fz1tg+7KfFjepTkVTvmcaiAMUMfhqUjSWd3wtrbKuSPw9XoK49mSLxgubTKX
x-ms-office365-filtering-correlation-id: a1e5d4e2-27f8-4e57-8d05-08d6145aa2ca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0694;
x-ms-traffictypediagnostic: CY4PR21MB0694:
x-microsoft-antispam-prvs: <CY4PR21MB0694A2FC3412BFD33B3BDCE2FB000@CY4PR21MB0694.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(209352067349851);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0694;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0694;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(366004)(136003)(346002)(189003)(199004)(2906002)(186003)(86362001)(6666003)(110136005)(107886003)(54906003)(36756003)(25786009)(4326008)(256004)(14444005)(2616005)(6506007)(6486002)(6346003)(6436002)(6512007)(446003)(476003)(11346002)(486006)(86612001)(2900100001)(5660300001)(102836004)(26005)(66066001)(53936002)(68736007)(7736002)(81166006)(81156014)(8676002)(10090500001)(8936002)(6116002)(3846002)(99286004)(105586002)(76176011)(106356001)(5250100002)(22452003)(14454004)(316002)(1076002)(2501003)(305945005)(217873002)(97736004)(10290500003)(72206003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0694;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: CX1hSTZwYZKemG0O0SfJgQN1anl2/Ox53bctW/zN4vugxB4qwF072vKW8jHTp0YzOcGPphxs3pN4qiWdVpjNAGrbxnuqekBN9mKif7hsGi3HTvvOQ3ypOUS1oir5Z+hOk1f4yZg2xAHkxS39fEGWQlfOtJyo5Kwsd/pOdrQbDFW9O69mADJGYpo9dEXbsk2IJubbjhF7l7in4Caf/O3UgtN/lwFMuYLbRsJbQPtILK3Ruc1oYq6FBtY1BgDK2gLgvIaAOdF8LtYtkf8sbAmuWDIsDJL43n3Q3PMhT2YH7EgVnmNsjlc9jOyJ3t6IlF8gfFLempgvN8sr/O3TD+GmMawzSrqLLfXj2FKpWkCEIQ8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e5d4e2-27f8-4e57-8d05-08d6145aa2ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:46.4933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0694
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
index 539d3f5cb619..80d8888549ee 100644
--- a/virt/kvm/arm/vgic/vgic-init.c
+++ b/virt/kvm/arm/vgic/vgic-init.c
@@ -241,6 +241,10 @@ int vgic_init(struct kvm *kvm)
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

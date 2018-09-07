Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563F5C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E1A2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="kJbzBaO/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E1A2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbeIGFRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:17:50 -0400
Received: from mail-eopbgr680100.outbound.protection.outlook.com ([40.107.68.100]:43908
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726738AbeIGFRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XClU7TGl60oJKibJnLVJl1oDlBAzxFeEgPTDyaq2/CQ=;
 b=kJbzBaO/2AWFgQSooufvuvJ9hoxVxL4wvjZc9KkMQJgAD/zFyzLEuu1S21PcTXYbufk8uSioCAUfXmwFuRaWQc/3EMQ7Hxx/y+x3BNLdwmLm3HO7fScJb0ljp2mUO0Sh6igkkN4OwM165gBKhuVwEwODS5bkujXGuhSI13dxLRI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0695.namprd21.prod.outlook.com (10.175.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:39:09 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:39:09 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 60/67] KVM: arm/arm64: Fix vgic init race
Thread-Topic: [PATCH AUTOSEL 4.14 60/67] KVM: arm/arm64: Fix vgic init race
Thread-Index: AQHURkMJtbZVkQSxMUa5yF5hX48Jqw==
Date:   Fri, 7 Sep 2018 00:38:04 +0000
Message-ID: <20180907003716.57737-60-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0695;6:zsoccNMHB5MdPiTXLtVAb1k/Kw/9Mhkx1DiM5MaUFM8gRIAp4nRXj9cp0M440TTUMqyGxo9E9ZtwfzuG9wneLoxYa7+C6oIOF54z47UhKH4vuRVxYlf0an8bAZhuSbuYpMMG2DoCapiVsyogurtMS5jmdaSlboAqGNwwT34puQ6l4TL1i2IE911k69FjdApsLLxrd7bgUYRLsrsd3uICaySgxWJcrjI73cLk55aIrilB3unEX3xEQwa1I+Hj+jz1aYs92rT+qsIYhXNdWJ5c6JYbcCrakxSXs1kpqc2+6ARQzazn/krmAt3V2z4Ee4Vw7nIEmskYKFlRNhcXWqkqYoIPKpcSlfo3tX5+Gez6hLgUYKdhbFoJJcbV9xSXGIFIAIDCGC8Aoho5jfwN9MtlRoPuqXRq2kvmpLqs4+rDs6y9qsNpuPQ1lzhFNVrGchp+wzaj5MjtLIP3lgtquMQ1SA==;5:kUXJHQeS2w0nRuCmqpEr2geI1t7zxaBNc21j7pkW9uL+GoOxA9afiN3hRCJCZteE2HF+amonq3+xB/CIxkiMSr2/LH5eHkcbiTTUsSbio6I48e4m23/9ZMVYZ/tfxuAXDZVSdDkAIMmhVZ7nqhyIL/6JZTkSaLZ4u/C98eRRbUg=;7:5ui86LQj2W24KopbpzfepI+sYEyzKFfHwrFPKdIGeI0u6M7xMK4HfAmaszOgliQCZCd6+Ea1vjplTjxZT3BX87XWdmm6pmzX0bBlmi/+6X5+Z/48PBiy3aBHbwicdx0QSSj7muXybW2qxfuVnZg2soY0EdsAeBNi1schVyuEtnphET41OhYsjmn4tpZ17ZYrAjMFv2wdoYmSE+jaUS+aDBF1qRLBjh8GaPvtwkzuU6LXa+Vn4+zFreu+vhrb3GVX
x-ms-office365-filtering-correlation-id: b06cc598-7b5b-428c-c53d-08d6145a5355
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0695;
x-ms-traffictypediagnostic: CY4PR21MB0695:
x-microsoft-antispam-prvs: <CY4PR21MB069585BC8AB74C00AD1DDB0FFB000@CY4PR21MB0695.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(209352067349851);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0695;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0695;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39860400002)(136003)(199004)(189003)(14444005)(99286004)(6486002)(5250100002)(256004)(6436002)(8676002)(81156014)(81166006)(2906002)(10090500001)(97736004)(2900100001)(76176011)(305945005)(7736002)(25786009)(36756003)(86612001)(105586002)(22452003)(106356001)(4326008)(66066001)(476003)(2616005)(5660300001)(486006)(6666003)(446003)(11346002)(86362001)(316002)(8936002)(6506007)(6116002)(72206003)(3846002)(14454004)(217873002)(2501003)(6512007)(478600001)(1076002)(10290500003)(53936002)(68736007)(102836004)(110136005)(6346003)(54906003)(26005)(186003)(107886003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0695;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: mAk+2QqydaWuMtltsFvMDtCda+80r5oaHY7MeegnVds+j0q76Kdok0prbt3alULDvAI8+alDPgGD9ptduWEkpm+pYf29ypjRc98Fhdl/RioO6cmCw0BQZo9qNa8WqB5xPnJmvyOqt+Vae/2HM5xIDUFvBixoWXZGFcFmmpeUGg20ZPspiSDYjeBNol9APNECTEBUYv1CTZ3VvUClVBz00VEvHk2pnLdq/Gp+epgUDIwkavB50ZdXpCP6L1E/0BnFK4yGkvAtWFUjrnKfA03Y/0pfue6mgtt20nq3MtTkAOqs2dFguT4N4WqON6k/9YmU4ETGGyhnzJco6jRp9COTQVtRYMU1/lUkweCAbbMXrFE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b06cc598-7b5b-428c-c53d-08d6145a5355
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:04.5529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0695
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
index 5801261f3add..6f7f26ae72b4 100644
--- a/virt/kvm/arm/vgic/vgic-init.c
+++ b/virt/kvm/arm/vgic/vgic-init.c
@@ -277,6 +277,10 @@ int vgic_init(struct kvm *kvm)
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

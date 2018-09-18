Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB4FECE563
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C7B214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="J/K37APf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C7B214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbeIRIsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 04:48:52 -0400
Received: from mail-sg2apc01on0120.outbound.protection.outlook.com ([104.47.125.120]:24704
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726434AbeIRIsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 04:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BeI0r2RU14yEwo8VLsuoeXY3JA3CxXIBR28gVEn6eY=;
 b=J/K37APffIfaSJzrM9n0KEHcJ4Jnn3/QeNpzdTNf5NPZ3BU0ZIqm+3ex+5lO6Wwn/c7xjozjhLgaatmLed5vi3erxeZdadPWZbTfYM1BeRu1aDucrThDvtrY5Au4tjTV0i9iFiAN9fAJnPiGjthAN3J8iraR9yTPHc0bohLguSw=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0180.APCP153.PROD.OUTLOOK.COM (52.133.212.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Tue, 18 Sep 2018 03:18:17 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267%3]) with mapi id 15.20.1185.006; Tue, 18 Sep 2018
 03:18:17 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>
Subject: [PATCH V2 1/13] KVM: Add tlb_remote_flush_with_range callback in
 kvm_x86_ops
Thread-Topic: [PATCH V2 1/13] KVM: Add tlb_remote_flush_with_range callback in
 kvm_x86_ops
Thread-Index: AQHUTv4+wwpoTLXkbEm4tBNI57mR/A==
Date:   Tue, 18 Sep 2018 03:18:17 +0000
Message-ID: <20180918031754.113013-2-Tianyu.Lan@microsoft.com>
References: <20180918031754.113013-1-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180918031754.113013-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK0P153MB0180;6:LbssQ9ZP99rd1CSae4FYBTiFfBoopsqbGSCuk6gI1xhDurQ9zr9COonovsPqmLkC1mqmgPXWY4sdAjnkU+MSlk95YXVxjG0xCOqyjO+98UgF+ihOormvIn2/ufRWwIRGbFEoS2He6fREK6eHxql4PjMvmSknE/ejHAI9lyqM6iPW9PJIxoqOi0Eak21iJ8n8TqRdgxTwAspoZNaXy6LS5N9qZ+rsjT6I8Hst9L+IHjt7ZD6fVGhk67XEGQo+2TSjEod/1lchr3EFsI1gnfx2ZDrRbGuWxA06wDGz38pj0s3sl1e7BVVq95pIg5jeW3H/Utn+TfXD/hAAgHYcIsSslXPi8ZntzDzK2rP7rO3EeHyy8V8aSXNHalCMeHxYxchdZWsfQF9OeYEEeDHSADh+tRNKMhE7WRlgC8WUKk5GbIHIiZeDdFweWuTywGy/4jTqrFeUaAyDQZGXCRX8VMOY5A==;5:D3D9X/e0XAA4SGaGuj094zO+n8B5QDOfKo9KkTMEdepv8EJgSS0wfHaY1d1QxrWcmhlx4sMvTPKg1Juv3/pbtTz4BssN/eOytdJu8S9O3Z6UGPIg9cmeyfZsOk8LX8l8ruy4I+ckflbU45O3Zin091pYwk5c+A6tuFEQOPHbLlU=;7:O1H9JSeZPAbhBZJQAuAzk1k4NtrBt5iS9OXF/lSD6XGUJjUIDhsrJ4m0K6Lc7HtlzbhllKahVmJAbmliuHOyE6x+MDAPzHyw3KWHewp9/z3cOOrVrkjSeONL2iEmF5iUSbDp3/RChV/pdGrt53UHlXWxLmWuMGtEnpc9tkf/X+Fl0UPh9pQdC7ZIa5Ztv5zh/QxB9taTmKqWjvlOUvJkK9H4FvFwce7IVMCgGoiyYmXYH5DZtH5xRkySAhfrcktw
x-ms-office365-filtering-correlation-id: 58ad1c12-9598-43c4-451b-08d61d1560d4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0180;
x-ms-traffictypediagnostic: HK0P153MB0180:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB0180E817E016671928414116921D0@HK0P153MB0180.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:HK0P153MB0180;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0180;
x-forefront-prvs: 0799B1B2D7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(346002)(136003)(199004)(189003)(26005)(102836004)(2906002)(7736002)(6506007)(22452003)(59246006)(54906003)(316002)(14454004)(86362001)(86612001)(36756003)(6436002)(10090500001)(6486002)(6512007)(305945005)(7416002)(53936002)(2900100001)(5250100002)(256004)(97736004)(72206003)(478600001)(106356001)(8676002)(81156014)(81166006)(5660300001)(8936002)(6116002)(3846002)(99286004)(76176011)(10290500003)(1076002)(105586002)(476003)(2616005)(11346002)(446003)(66066001)(486006)(107886003)(25786009)(109986005)(68736007)(1671002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0180;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: auyaCipz6Cb9lAz5YviuBXtJtzQay4lUoLC9Y3d3+PphogzJHt0Mp6cdc4ZxqN875yUT0XsAOZ3J5zKDa1zU/Cl21MZHzW528y2fU6A5OA+1Ry9anIi/ouYYWCeKAC/xy9H7YmmzSp2Nj4uzrdl24yC+pVx8SRmJp+sb7Cyuaxys9PFa1EnJBTPa36V91vKINxWOatpdLZGlsWYNiCV4l5NJHPgG11RF5LYN7GJ4DgPEopGvmiyF4Wrf/4WS4slR4nqdH/W7OVf62NIYvtNzyu6zx0msjUvpL1PluJcGwDy31SGPsstLmccdSzDC3YoENM8LVxPajWftGXqh9HeFngl3JAuKC4gfp1hVUc7mNq0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ad1c12-9598-43c4-451b-08d61d1560d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2018 03:18:17.1153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0180
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add flush range call back in the kvm_x86_ops and platform can use it
to register its associated function. The parameter "kvm_tlb_range"
accepts a single range and flush list which contains a list of ranges.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since v1:
       Change "end_gfn" to "pages" to aviod confusion as to whether
"end_gfn" is inclusive or exlusive.
---
 arch/x86/include/asm/kvm_host.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_hos=
t.h
index 8e90488c3d56..a6b77978502e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -402,6 +402,12 @@ struct kvm_mmu {
 	u64 pdptrs[4]; /* pae */
 };
=20
+struct kvm_tlb_range {
+	u64 start_gfn;
+	u64 pages;
+	struct list_head *flush_list;
+};
+
 enum pmc_type {
 	KVM_PMC_GP =3D 0,
 	KVM_PMC_FIXED,
@@ -991,6 +997,8 @@ struct kvm_x86_ops {
=20
 	void (*tlb_flush)(struct kvm_vcpu *vcpu, bool invalidate_gpa);
 	int  (*tlb_remote_flush)(struct kvm *kvm);
+	int  (*tlb_remote_flush_with_range)(struct kvm *kvm,
+			struct kvm_tlb_range *range);
=20
 	/*
 	 * Flush any TLB entries associated with the given GVA.
--=20
2.14.4

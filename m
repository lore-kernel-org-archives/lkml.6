Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0ED1C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 397E3204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jHXadEkY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 397E3204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbeIJNbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:31:31 -0400
Received: from mail-sg2apc01on0124.outbound.protection.outlook.com ([104.47.125.124]:30676
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727488AbeIJNbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mpZFTc5OkRGv+VOnRcQOFfJKYZcekpaWgK/PIteMvk=;
 b=jHXadEkYQT/QySpEfmkP2x25bfjWHiquWVZYB4FtSZhCvRvqmcqFGMih56tgPQ+Q1YNncYTeIcmfMQvFQ3XeJDIeWkr+9moYgDms47MSMvTV64cq3L4UO3i0PKxt7INZmFfoPk8VkX1uFJsxGWHf9OfjSoyVSvt+6H+nWd/sUzE=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0097.APCP153.PROD.OUTLOOK.COM (52.133.156.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Mon, 10 Sep 2018 08:38:28 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::194c:c2f9:171:1890]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::194c:c2f9:171:1890%5]) with mapi id 15.20.1143.010; Mon, 10 Sep 2018
 08:38:28 +0000
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
Subject: [PATCH 1/13] KVM: Add tlb_remote_flush_with_range callback in
 kvm_x86_ops
Thread-Topic: [PATCH 1/13] KVM: Add tlb_remote_flush_with_range callback in
 kvm_x86_ops
Thread-Index: AQHUSOGlPYk0dzaap0aJJdx4SZcp6g==
Date:   Mon, 10 Sep 2018 08:38:27 +0000
Message-ID: <20180910083806.65177-2-Tianyu.Lan@microsoft.com>
References: <20180910083806.65177-1-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180910083806.65177-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK0P153MB0097;6:X9KBhJiFnMisVOdAXQfydKmSgXJ65Y9wXGBu8do1OKxxzQnFkQTbn4nq1rSxA9U6EnsBah8kCJzhqDOXhBnAa/CeDVHONfPgbq8FmJDfYDc3nCcNN6YwY1ZOh6o0ET5A9s4J2ARVUm1Sfv2XPgd7ecaAhI6NRSJOLGmSOrX5gMHDBH3lqSYHEhIMtS+EstotV978rYDnJFAflrgsTClH2A6tl7HRFHytHPoiTcE2yoLBw3uCbE4+n/F3SV8zX8b8nyDLY2WaFKcrVevFxk+YbXAAdaDvV4x6BfVPJEbOsaVwqVfTrL6BHuT2xXURLgRBUoGQm2eG8NNvpuPkFrpi7NJ5DELZRc6eWExvIqk4agDozajrge7ITjWJBQKAlCpggZiOHpbrtbLwzEmxxFeP9EfOrRdNlR0YQe3WSN626iGBdRpnQSV5h8aTPrCP706N65AUJFOg+1/FWszC0Nkwog==;5:JWS2+v0VUws/WIhR8Bz/VZPd+/gx36Y2El5evOv9O15M6xxp+IHsbpQk3DdpaVEF7fE9fTc3E43Tn8gEIS5GNEbopneoG+iC6sCw9TtBqvNrPcdT5NW8B2G0WxG70CmByLZ59e9q6uZ0qmd4gZMsuveSzQjsVhu40PDASOOnmrU=;7:2AHtSKOPEiDzBphzR3iS3bVqR8fTHgdtNKYb8Yc2XRBWezGx9OYv7IDowjpd2iryfhpsMlEmVUfEOWFZ4iCYIWXFr2uaR+BNWGTm0oi38LC8JgmGeoA/nKPErHr+RAOmeYp6PAeVA0whpTXHbm93hns1TlvP9U/xxkFI58y/8zr2YMJRMXVhwiGV0ZZNva/FxzeyT5uIITyDjTiMJ1CsoCM7IL53WSJ+zQsSzoWTtOXIA/zDnJWd7MY0HFZLSXAA
x-ms-office365-filtering-correlation-id: a9c0a983-73a1-4f59-61ec-08d616f8c80d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0097;
x-ms-traffictypediagnostic: HK0P153MB0097:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB00974FC291B3553CB252CB6592050@HK0P153MB0097.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:HK0P153MB0097;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0097;
x-forefront-prvs: 07915F544A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(39850400004)(136003)(199004)(189003)(4326008)(68736007)(107886003)(109986005)(25786009)(81166006)(8936002)(81156014)(8676002)(86612001)(86362001)(102836004)(22452003)(26005)(2906002)(6506007)(53936002)(1076002)(10090500001)(97736004)(5250100002)(6512007)(6436002)(256004)(6486002)(2900100001)(14454004)(10290500003)(99286004)(446003)(2616005)(11346002)(478600001)(76176011)(476003)(316002)(36756003)(54906003)(6116002)(486006)(106356001)(105586002)(3846002)(1671002)(305945005)(7416002)(7736002)(59246006)(72206003)(66066001)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0097;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6M2NBZDQN66Hn+2LRFaKpj8UbYvM6N8Cbi4c3LlnpNsJbtbxl495egETX/vrhe+OJL/9YMXsArEkj6gyq47ts31WMnXNdWyMKxdD4Dh9GZS1isIKoRtveUbiLN3sXRjMN0Tl8K0pQ7mSv45wqxDsVyG5HLtXQyeYFXzJHdx4N5hdnnz/MHSwl7XdRO+nzgZtVmF4CyXV81fiRMmPGnISS0CU7WCzHGfgGbgrFpjhLl+HztuVtJI3UkMulotkUxfEDiLapIcBXEzHTF3/qR5lAXo2oQSShugldMKgaC5LThnE75aQHIIT3Z1BO8gohNLSXcocKiUdwoMckaB7Uy/34udFHbqkyCfRr0CXr59E0QU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c0a983-73a1-4f59-61ec-08d616f8c80d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2018 08:38:27.9561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0097
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
 arch/x86/include/asm/kvm_host.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_hos=
t.h
index e12916e7c2fb..dcdf8cc16388 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -402,6 +402,12 @@ struct kvm_mmu {
 	u64 pdptrs[4]; /* pae */
 };
=20
+struct kvm_tlb_range {
+	u64 start_gfn;
+	u64 end_gfn;
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

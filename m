Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CA3C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 552B721533
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EAd74jMn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 552B721533
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbeI0KFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 06:05:34 -0400
Received: from mail-hk2apc01on0109.outbound.protection.outlook.com ([104.47.124.109]:28856
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726953AbeI0KFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 06:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BeI0r2RU14yEwo8VLsuoeXY3JA3CxXIBR28gVEn6eY=;
 b=EAd74jMnLVBbxoVdT65bUbq/jDZZnjhtiNClkpQu9WI4yKwLBaSOgOjmXBvQRi6QsWhxNFBvM3j1HcKEAQCmS9PIBQkktBChbHsRl9j/Rwup+MhhyaCju7pwFR4dxHrI9v2ahE1jCSSFIJE279pEY1rrJ+i0Iv8tk0nkpUE2yfY=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0130.APCP153.PROD.OUTLOOK.COM (52.133.156.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.2; Thu, 27 Sep 2018 03:48:51 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267%3]) with mapi id 15.20.1207.011; Thu, 27 Sep 2018
 03:48:51 +0000
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
Subject: [PATCH V3 1/13] KVM: Add tlb_remote_flush_with_range callback in
 kvm_x86_ops
Thread-Topic: [PATCH V3 1/13] KVM: Add tlb_remote_flush_with_range callback in
 kvm_x86_ops
Thread-Index: AQHUVhUAv0Q4r8KpOkWhsnpVLEa0CA==
Date:   Thu, 27 Sep 2018 03:48:51 +0000
Message-ID: <20180927034829.2230-2-Tianyu.Lan@microsoft.com>
References: <20180927034829.2230-1-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180927034829.2230-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK0P153MB0130;6:zdo/+AZwHRQwTyAsUtVhNTyhCyzqDnpT8lFHLsTcpEQ9m/oDtmCyizVUzPnTO5hdV3nCfmbIUfPJbnjzXyRJjfuXFacZCIgSEUzrS3oKNoUwNIC+JddCJasp3apECqy4ww3Tiv/beCp3F6rPEUi90SeC/wAFcmd9y1rLs0TKDMi4Qye00ce5bkyt3oD5sClqgNwESd0+ZiEcCRqHwJQPgmPjNxiHIMsV/3Sa0E5wv2TJVtKpPMZiIaaBwkDzdPU4ApW+m8pdlfBqfPtkIvRbHlR5A2ZuxTdSewphF4UXv+ei5M2wgDB4HQXFtFP36kdIKr6ipvuMo97l28UIlU5rsrgKGynEP7/Myugpoku1+K/ZCWweYm/2Nzb85PF9pXdVCjVX8/6LKFT43u6QdidB8itgw6O/iAHd6q31I5wVPcxHOd31EzyCJdgkJiGsnPDaEeMnc1gIPkSr6/tg0mDbaA==;5:g+nC5oEK8oG1juz0ryUDhIMWWw70dnJQzD8JwnoHPlkueBum5sF1GkDgjv+dqLZnJBwJFCHS0oY1c5tHG6hFg8VNqq7GYOl/POQX5VNUfhXRAJ4+F6xFe5UtreYV3j86JeZxKApSsG+NPGJSpQ//EZM5ZDSqYAdQAzlgD+ofTQ0=;7:O+XW/9UgiHdnV08KLszr/cfMwj9E27N0xNKdjJc5DAbI0EbN9dswd706uWk6EXLCNPm6vn2dP8qbRXFGu3BUKTUFepBU+MfwPpNlfJOUVqSmHFo5OEZOFfFyC59tKaKYfgEBGN3FsKl1JpoydZlN0Rjxndf9YG1jXpZoGV+2xrlpNd1x3lklswhUU9ZDXtWVrsEMfLidZ9AHekYBeuKU1kkaYbzFOHJWH0ao6j0Kxiyn09IymqRN9zQ1xY6XtBmm
x-ms-office365-filtering-correlation-id: 95a8b254-5867-412d-1651-08d6242c2399
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0130;
x-ms-traffictypediagnostic: HK0P153MB0130:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB0130B2CC7C9A1A17F77CEF9592140@HK0P153MB0130.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:HK0P153MB0130;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0130;
x-forefront-prvs: 0808323E97
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(39860400002)(376002)(346002)(199004)(189003)(102836004)(478600001)(6506007)(26005)(72206003)(10290500003)(8936002)(36756003)(54906003)(53936002)(22452003)(6486002)(8676002)(5660300001)(5250100002)(14454004)(107886003)(6512007)(7736002)(76176011)(34290500001)(1671002)(6436002)(256004)(86612001)(305945005)(86362001)(59246006)(97736004)(6116002)(66066001)(11346002)(486006)(68736007)(2906002)(7416002)(99286004)(106356001)(3846002)(105586002)(4326008)(2616005)(1076002)(71200400001)(109986005)(81166006)(81156014)(71190400001)(476003)(25786009)(2900100001)(10090500001)(316002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0130;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XCWzrJ5xFuS25lANNbO+hEBKXh+phNs5L/E7WgyWO54NOQoSBDjAWBZKjXsk6BGbjYoqWxQLJmIhcqbiEXMil/RulSnuUzUTH2f9RHH2rRlI7U4ZLcqwVuj9u2PP/zRPhAzkjHZlFqaR2e8Kk/eLasXQ0Ef8c+/Q4lZJ+X56JQ57RK5XFJ/JdtldSTfd8roRG4EO+Pduaq5m2Jmqaqa5HTxmJrmg98GfWsC6WaKa8GmQyRnKAGPfTT1Ta6wCSt8RrJsZyt9fUColdwlVallE3aCc94uzlPXCmgHFAcx33ApKOD/juNcEvqONaKfM2oyiBYK7ySXU7xRlCuOJ8u644w7METAr6KEU/GSI21KvV8I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a8b254-5867-412d-1651-08d6242c2399
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2018 03:48:51.0467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0130
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

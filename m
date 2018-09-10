Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689ABC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153B9204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Uu0onzDM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 153B9204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeIJNcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:32:12 -0400
Received: from mail-sg2apc01on0119.outbound.protection.outlook.com ([104.47.125.119]:30748
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727821AbeIJNcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTowkoA6CBZPOnhMkt8SDpBTrSy+Cv6ihGWozflDn74=;
 b=Uu0onzDMsnvk/42g5vKkkHlbIYNW+PYIldLH1kGsrl4PHyoiMQAjLYbG9tsCve5pdXSDxo3Sa2muws8EKlTPs8QmSgyg1VLeWv1JUhRBHumboDQ2xfuRTUcVp5WxXdE5HjC5bUimJog5muNizapfl4+OHd7CaLZZqcjcz8Mfwkw=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0097.APCP153.PROD.OUTLOOK.COM (52.133.156.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Mon, 10 Sep 2018 08:39:08 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::194c:c2f9:171:1890]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::194c:c2f9:171:1890%5]) with mapi id 15.20.1143.010; Mon, 10 Sep 2018
 08:39:08 +0000
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
Subject: [PATCH 7/13] KVM: Add flush_link and parent_pte in the struct
 kvm_mmu_page
Thread-Topic: [PATCH 7/13] KVM: Add flush_link and parent_pte in the struct
 kvm_mmu_page
Thread-Index: AQHUSOG9/C16lxLdl0ihkPT8V0GurQ==
Date:   Mon, 10 Sep 2018 08:39:07 +0000
Message-ID: <20180910083806.65177-8-Tianyu.Lan@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;HK0P153MB0097;6:0cW5bFPtMK1t2qQ8rjT/3ZqpNLTIIhdjoBgigC65bvLor10qZvkr2Z5IXOGLb3ppM0+ZctYg7gjYJkZ/pJ4BQwUzRRn61j3tUPosZMGwnTa/6pkQMdbcAUGXSqoTAvUD0ls8LuayaHWX1TssUfQi7SbNd1I6naoM2fOrbm7aDTKYREjb/UwqEbZ6g6sjQJBS+wchFP0J24T31dZGDY19pbUQQ4gKBl3mbxAD9hkoGBfbGPSOCvmBRPdQxVOpSKhLwZFNV4PmPLhlocgHnDmnQvCoG9H/pOw8G/CCtrKboMJBE3ee50ds7KkQGmVnv92YvZoM5TnCWm4260oCiFz02e73K4gkPib/erqlwhOyLHqO6apZosaQwh5+QBsMlma/0VSAhIoGiWkJz9d7FKnqmM/hOyR7+vOJQ7K6XUuP7T1sdtPIKMU7QnqTlroYS/ILKRmVgWk4yvDOsElaNaM7Iw==;5:sF5oYSZtifnLeyLnHrkHag5vEtJ0wiWoD/C09oqXa1gxrmPlKaSxYD2v+cajK1nHWMjq4ciezevKbd/2xTof0M0d+zHw/Lu++M5APzu6oDLkf8n3g6mJttfiX14r0kFMewPGdEZMwHcbIu1ou9Ss+cdviwuFHFXM4/AN1RxJ1Z4=;7:I84ZaHZnPksIyFqNOUSPcGe3EK0JAOPofXPkW809szMSo3VhSSEjuqURoEdjrnMZJZ3LNKjXY0jp6rxzguEJglZNegwIFpubuPRO9oZVcICg8vIAT0ieFnAjMJte4IkuF1SegPauS8FnGcHVTYzhIBAjX8fUG50T/H0rZ9LZSN8fsyei8xudcksouKjhuIeGymIv2ecd+VM5FqN+a1zii8CNN7j1WOTnodzedRjsSXSsKp/a1zovEEaHjRiGGr1h
x-ms-office365-filtering-correlation-id: b4bf7ea8-e8b1-4d1d-093d-08d616f8dfd7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0097;
x-ms-traffictypediagnostic: HK0P153MB0097:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB00979E40F68F9D0D933FCC8C92050@HK0P153MB0097.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:HK0P153MB0097;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0097;
x-forefront-prvs: 07915F544A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(396003)(376002)(136003)(199004)(189003)(4326008)(68736007)(107886003)(109986005)(25786009)(81166006)(8936002)(81156014)(8676002)(86612001)(86362001)(102836004)(22452003)(26005)(2906002)(6506007)(53936002)(1076002)(10090500001)(97736004)(5250100002)(6512007)(6436002)(256004)(6486002)(2900100001)(14454004)(10290500003)(99286004)(446003)(2616005)(11346002)(478600001)(76176011)(476003)(316002)(36756003)(54906003)(6116002)(486006)(106356001)(105586002)(3846002)(1671002)(305945005)(7416002)(7736002)(59246006)(72206003)(66066001)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0097;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: of8E4Xd1dQa/Hhn2p97qLQ+kA3WbwgJdqjLbqdA4nFNV12s0V12fabynFkvnAtfqpyknki7lEzcy5Tz+PgyJ7/ZlayGS5D0z87H+9/2Hk04dJF+a560no46np5OBJehhmRNCx/9Rc5DE3eT0cUsqxhY3leBFDeHIHmbh6uAsip9t+BimW38l+vsq5hYvpUVKcV34Cyuir0BJhzhjLmIf98U+MhyoYt9y1IjDPY/ttwroY2Swr0O7wF7SeOi6dzWhTELfXJYUD86UDFnDEB1B/C62oxRjCjNjbx5jfbZStoFSAtU7LUMFfT/NlAPCfYzjndcQGVV6blpEuKTcggACaNKAZVmBUygAqL7eKz8NrhQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4bf7ea8-e8b1-4d1d-093d-08d616f8dfd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2018 08:39:07.8763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0097
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PV EPT tlb flush function will accept a list of flush ranges and
use struct kvm_mmu_page as the list entry.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_hos=
t.h
index dcdf8cc16388..acdad302612a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -279,6 +279,7 @@ struct kvm_rmap_head {
=20
 struct kvm_mmu_page {
 	struct list_head link;
+	struct list_head flush_link;
 	struct hlist_node hash_link;
=20
 	/*
--=20
2.14.4

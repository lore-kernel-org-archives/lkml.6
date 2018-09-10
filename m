Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02979C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73B9204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WEH0V80d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A73B9204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbeIJNcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:32:05 -0400
Received: from mail-sg2apc01on0100.outbound.protection.outlook.com ([104.47.125.100]:18879
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727821AbeIJNcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlnKUTdqTOQyhn7t6f/ExFmyV10TB2uTwIxBrKkcIPQ=;
 b=WEH0V80dANbE8caTw+VUP61ahy3s6Uca6RKCMXb7RFV3c8vNWHO3vzfuhTw0XZ6cWllHQpfgp2qSM77ElHQzp1sKuARNY/TF2wuYzV7/OySDFPGuJNQ/f0S52dOOPAyz6veWXDdIDWRhj1jV8L0OlqHiwu7owxSrb1Y5cnKkHjM=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0097.APCP153.PROD.OUTLOOK.COM (52.133.156.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Mon, 10 Sep 2018 08:39:01 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::194c:c2f9:171:1890]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::194c:c2f9:171:1890%5]) with mapi id 15.20.1143.010; Mon, 10 Sep 2018
 08:39:01 +0000
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
Subject: [PATCH 6/13] KVM/MMU: Flush tlb directly in
 kvm_mmu_zap_collapsible_spte()
Thread-Topic: [PATCH 6/13] KVM/MMU: Flush tlb directly in
 kvm_mmu_zap_collapsible_spte()
Thread-Index: AQHUSOG5cxUUNcqgMUKEosej7L/WoQ==
Date:   Mon, 10 Sep 2018 08:39:01 +0000
Message-ID: <20180910083806.65177-7-Tianyu.Lan@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;HK0P153MB0097;6:ZRjkd9oVb6643KiZz/aLHjKy8Xg05UCydjGdbJzEBC+XLZBeGw6gnScaIRg6MsqdmDUfFJoH0cVliqOnHQfwfgKOMxPRlqOfKLBBoLuzFFA+J9UFhpkKgwGhwR/eLAD5FrBDU6GbrYjMGImaph9MDHPQL+zLO8O1wqkpsYG6hphZJHU5awz/DFOEwVobzMSsenQPUxdmeGUwMZN8atid9DD1KJSd3BUX3hL8CbpVOW/hat1csi6B5eI7PA+tr+TlmPNt+n3AyRMC/cDUD0WQXnJO/Prb6ropWl1V05Ofbd3v8wcjnv9gsBoAU0GMRl3IIyKb9y57co3r9YOA8OZbHqOHtolUr3rV/PLh6Ib5HROe3VBTcfnphz9uHIUbz5GrVdWQi2XGL/bR3NCpPNKxz2qFjChLPD3tMvk21TFlreBGyWqZDJEP4k7Oy/CyY3ttl5+MTZ3aMWRCE7PPRy7zHg==;5:EShaXpD3ehHx2F16fdmxlrAH/LI/BvfIdQmQ60ZDf6k+BtesVFe5e4JOD+s2nV6uPSKvhduP+iPynfIhV4YOa8jpnDcG1lGzYdn5YYF2QLc+6ErOeztbunNUCUo5gEHceTKEgg47pq7YYbqkX4YI2BdVn7ysgZJCAzObCVR705E=;7:JC5cQvrzJdJ4JA54rDyOHiumUtH1Kb9bx+JAWTSDzN8HX/9l2037H3/URZS6aJCZcfSymDVntsTcNJwfQ9BA+yZ81ExWIw4MqLM3BsU5kfPqihUpp6TjBG2THpo+5gg3kWVdKfNIUR8cz7MO8AI1AxCyEff/3DlGuH5h4QHkGzUk68LfU8fpxXuHMBUfe+zA1jE5QNtikIO/ABpva/Io96RGwKy8/SmHpJjSlQvI6fLyUtqM/btMHNI/Dmk+p7MV
x-ms-office365-filtering-correlation-id: 1e17a75b-8ec6-4f7c-0484-08d616f8dbf1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0097;
x-ms-traffictypediagnostic: HK0P153MB0097:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB0097558F0A2FA1BF3E3BDE4492050@HK0P153MB0097.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:HK0P153MB0097;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0097;
x-forefront-prvs: 07915F544A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(39860400002)(366004)(396003)(376002)(136003)(199004)(189003)(4326008)(68736007)(107886003)(109986005)(25786009)(81166006)(8936002)(81156014)(8676002)(86612001)(86362001)(102836004)(22452003)(26005)(2906002)(6506007)(53936002)(1076002)(10090500001)(97736004)(5250100002)(6512007)(6436002)(256004)(6486002)(2900100001)(14444005)(14454004)(10290500003)(99286004)(446003)(2616005)(11346002)(478600001)(76176011)(476003)(316002)(36756003)(54906003)(6116002)(486006)(106356001)(105586002)(3846002)(1671002)(305945005)(7416002)(7736002)(59246006)(72206003)(66066001)(5660300001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0097;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: z9Ia/bxQSeOmNGwhw3Qor2LTGaOVzt65JOT3sxBOFaOQKxLXPfMOKUscpalohXN5QTUQcHp/EVfL6xTg5sQICHCQvRy1zxhdMBBL/Bl4lMDRlzg8AS1T6fz+/lt7Qt4g/8CAxqW8r2yAzcsQkZUAwyRhs+hw5GCIoN7XXqzzC78c8qy98Y3bWF7JN4Pe6jZ8+7uAjJ3ECBfz2oBDXW6hOzbiMAdRB68mxqjpAy3OjqEJ7JDfFEA+jjWBFpoMnFhE4UKYeqPv0rxE1w3w1TeiPhJcrMgRrthtbFNFaVEzef0qHoec+oSt/pJb4II9ZbiES9FSfcMsuCq4LsG124Jbe6LvPBs+6yVwyRe5IasEpxQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e17a75b-8ec6-4f7c-0484-08d616f8dbf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2018 08:39:01.1926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0097
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvm_mmu_zap_collapsible_spte() returns flush request to the
slot_handle_leaf() and the latter does flush on demand. When
range flush is available, make kvm_mmu_zap_collapsible_spte()
to flush tlb with range directly to avoid returning range back
to slot_handle_leaf().

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 9ae5887c8d1c..167ecfbab9bd 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -5678,7 +5678,17 @@ static bool kvm_mmu_zap_collapsible_spte(struct kvm =
*kvm,
 			!kvm_is_reserved_pfn(pfn) &&
 			PageTransCompoundMap(pfn_to_page(pfn))) {
 			drop_spte(kvm, sptep);
-			need_tlb_flush =3D 1;
+
+			if (kvm_available_flush_tlb_with_range()) {
+				u64 gfn_end =3D sp->gfn +
+					KVM_PAGES_PER_HPAGE(sp->role.level) - 1;
+
+				kvm_flush_remote_tlbs_with_address(kvm, sp->gfn,
+						gfn_end);
+			} else {
+				need_tlb_flush =3D 1;
+			}
+
 			goto restart;
 		}
 	}
--=20
2.14.4

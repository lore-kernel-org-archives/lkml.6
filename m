Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517FCC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0580204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Gkdkjaa0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0580204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbeIJNbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:31:52 -0400
Received: from mail-sg2apc01on0123.outbound.protection.outlook.com ([104.47.125.123]:35280
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727858AbeIJNbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwAmMfQHedlfUrEyVgcwZaLAVENjgIfwRMIQ4Arg2Ks=;
 b=Gkdkjaa0y/JpHzuJcKWzGkHpwOnjnKfOMl7HXsF9fib36bMjH2p4bRhTjZbg+T0ymrPk5qX5Pj7yI4yrtfXkTyQfsp08Tzz/Fg69h5kzibXIsHxLHBtNjfds0oKklHdXQdWsanMCmscMWsd93JKpagJ5eOSzsoBx6Qf/hT1XmCo=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0097.APCP153.PROD.OUTLOOK.COM (52.133.156.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Mon, 10 Sep 2018 08:38:48 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::194c:c2f9:171:1890]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::194c:c2f9:171:1890%5]) with mapi id 15.20.1143.010; Mon, 10 Sep 2018
 08:38:48 +0000
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
Subject: [PATCH 4/13] KVM/MMU: Flush tlb directly in the
 kvm_handle_hva_range()
Thread-Topic: [PATCH 4/13] KVM/MMU: Flush tlb directly in the
 kvm_handle_hva_range()
Thread-Index: AQHUSOGxznm/bGk6IkifCLPi0HK40A==
Date:   Mon, 10 Sep 2018 08:38:47 +0000
Message-ID: <20180910083806.65177-5-Tianyu.Lan@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;HK0P153MB0097;6:CzXrSiVBSzG4B6D5QX4RLerBhzc/OMMnMPz3I4PhQfA11v81Nl49PMwh+OfddqNndPZANcfMou4sHVHr6spEAJPsRmsWCyS2bvg5LAIQGRSy++dQuxVGQlOPaZx7h4nuy12zgcf2mpgY76+yfQWesbjuLmyp4WgT1xOQEmG2Wr0P8/iPTbQBPhbN/2a6xNG7ONOFUdo9nqbx0RJMnVoIc61Gltd5kcamjfOJMl7cPVMODeVNRU3wv5upBKzKgN9+9MejxzF1okHyEkbG+9X9nZ9SjAW43VQMs8Lvh+JusEN7gCggceSB4gZtDF8+Aq14BBxmwLX64BV/KaziL2icLK+4VlhLv/ZI64HX/zJQ3J5UgG4cC8l/YKtpRf49pa/9ahnysKZEysq7sDFCnbLj/EP++O+R737k1NemCybCS+viIwP0VvIZ1YFNsrpi/4TO7MkGQte87JErqRTHFlxU6w==;5:wAM5zUlTWDc4odc65XYFbaD6C2sfH7V0Lm5Ro1X1hz9NOYrgTSz38X5At7UuTXLCXc5raY4BrDed+5x3tvxICF+1TMdp6vZwqxaAATibUbRyhyrYr43ufWnNGkQro+FcLmukCLLIQZ2LVh6Pfl7EHtM0fS3/zrKTaECuvH2zjEY=;7:r30l2ERScyHrS2JrpXW2MP0vsu/8Aq+kRbfaRXpxrrjfpM6Lro9noojbT6hB86lyBzmh1FeP9VrTUWuy94Bqkml/+ZokDh8m+ddt1KIlTDwoc8eUuaRbF6Qe0tthf/YGM/oY+054XPR1aqhhjWTSOE9CpJlFgsc8xcb7bKcYwXjMrZc5g3d/Ob2EANe0R4jgyEBHOWNzmf95faiGgdlB3oHRzPqjkdXHcXmEqk6W7k9sMzfNZJLll6y2sxef+otb
x-ms-office365-filtering-correlation-id: 386392c0-d4c5-4921-c60c-08d616f8d3ee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0097;
x-ms-traffictypediagnostic: HK0P153MB0097:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB00971307F24891F43ABEDB6192050@HK0P153MB0097.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:HK0P153MB0097;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0097;
x-forefront-prvs: 07915F544A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(396003)(376002)(136003)(199004)(189003)(4326008)(68736007)(107886003)(109986005)(25786009)(81166006)(8936002)(81156014)(8676002)(86612001)(86362001)(102836004)(22452003)(26005)(2906002)(6506007)(53936002)(1076002)(10090500001)(97736004)(575784001)(5250100002)(6512007)(6436002)(256004)(6486002)(2900100001)(14454004)(10290500003)(99286004)(446003)(2616005)(11346002)(478600001)(76176011)(476003)(316002)(36756003)(54906003)(6116002)(486006)(106356001)(105586002)(3846002)(1671002)(305945005)(7416002)(7736002)(59246006)(72206003)(66066001)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0097;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QvXo9xN36x62bde4CHIfKcrF9E49zRRXW70QJtafVRcN2aRUywt9YOyaC5fnmGGZuggpR4Gm0X3Wu8bLjsnXpstI0Mm89g1e/A6WiQufx7G3byjUld5zQwEdUIiv7MrwPg3tPyKzYguQ3+iC24EjBG+8oqwhMNDdK638Q2UTWb2gMBRfU0JTSco01fuc488VYqgdKTsKN/FRZ/mlNp3Ci+6FKkOCbLEc46zJArv9FRWh6g1cxY5qYBcdYXK5J9BuCOq4b0sxx5DFyh+7CGEHFga2mwjct9qQU/pohr4UOMZVdXdFz3KIC6X6gp6Js8WazBCh9tJeB/bMyVu8hTI9czmD3MVjaYoreY+WAmCg9Lk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 386392c0-d4c5-4921-c60c-08d616f8d3ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2018 08:38:47.8782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0097
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to flush tlb directly in the kvm_handle_hva_range()
when range flush is available.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 0ee310bad2c6..cadb6a0b5247 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1888,6 +1888,12 @@ static int kvm_handle_hva_range(struct kvm *kvm,
 						 &iterator)
 				ret |=3D handler(kvm, iterator.rmap, memslot,
 					       iterator.gfn, iterator.level, data);
+
+			if (ret && kvm_available_flush_tlb_with_range()) {
+				kvm_flush_remote_tlbs_with_address(kvm,
+						gfn_start, gfn_end - 1);
+				ret =3D 0;
+			}
 		}
 	}
=20
--=20
2.14.4

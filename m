Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7525AECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 180A72075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ogpnWFj+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 180A72075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbeGRGs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 02:48:28 -0400
Received: from mail-hk2apc01on0120.outbound.protection.outlook.com ([104.47.124.120]:23317
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726166AbeGRGs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 02:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWyfYiFrd888zoaschMOYz9JZMg8XxccHszPxIOOpUI=;
 b=ogpnWFj+m7mrjDKprZyLPmTzl0hW7/g7OYNyycXge2WtMo9/NWqIS7XYONItFAuJbnscNa4UJqryeW08r76dTHCw8AS9MvBCH2TiWpnyxODoIzrsD7nmDmc0KFN5l810frjncgXE8cG1O0cP0fsLrkwmblJ7Ja9UEVJzKr5jyG4=
Received: from KL1P15301MB0088.APCP153.PROD.OUTLOOK.COM (10.170.165.151) by
 KL1P15301MB0054.APCP153.PROD.OUTLOOK.COM (10.170.168.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.4; Wed, 18 Jul 2018 06:12:05 +0000
Received: from KL1P15301MB0088.APCP153.PROD.OUTLOOK.COM
 ([fe80::30fc:8c31:88c0:dfd2]) by KL1P15301MB0088.APCP153.PROD.OUTLOOK.COM
 ([fe80::30fc:8c31:88c0:dfd2%8]) with mapi id 15.20.0995.008; Wed, 18 Jul 2018
 06:12:04 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] KVM/MMU: Simplify __kvm_sync_page() function
Thread-Topic: [PATCH] KVM/MMU: Simplify __kvm_sync_page() function
Thread-Index: AQHUHl4/83JtVJ0m9ESSUd8qTNNokw==
Date:   Wed, 18 Jul 2018 06:12:04 +0000
Message-ID: <20180718061103.61920-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KL1P15301MB0054;6:o6c59ZZsYG34mKAtA2iPAd+vmxIwnHno1IJgGjZg6Sl2t83Ihe8AEXwBndjtN5Iv7Z5yRHmRisFcdnj7xU8qxElb/nMQTASYcQU8BpUUwETuhtQ3bKDrbqH7q4pIUIxYi3K3z2NFrB4YVMR/sdXQ7ZupV6IrxEIXnJzCwBXptgtEWJEj3EE6E28O22RPlbF7+WO2yp+dhQ40LjgYHHJ0iwwKs1kSFXLp4n+6/OUPgi2j/aw9bm4ypBFOpCSvwRCbAsYNWUj73j6vIIGWkReHP5s9BOihYvJ2alsiUjzg0E2kVJ+E4siBdNSMd+M6+YrGOTZ/lzWENWiyUD1Lxpo5b8QuZ7bvgYg1C8n3G0DlzSApPZmRbMWyO3wPK68jgIbH5YiKpMsYiaD9pfp0t7Jkc225PeUjBU1/zuqouVm77WTEKXLPsw3t1SRx560PppuyWS3SXX1faZLPcUH00yhEtQ==;5:WaeHzJKLLljmrdi6SAXJQssHHYBXDi4n1Q7DOYxA0dNkJRByUJhXQfzCufU1Tvth9n/ouhMTDfRtjsdJDd4zv0oc8Hjrq0efKKnk1we1MqnIMReG4fAh+jhwLerpoJnC241p1a7+G7qjzN4dBxINPUBmh0sDlhRcV+Xz7h/2cCc=;7:Jc+ATXHp2tDtu1ASrcOHWJOHmcgjIT73TCL26wjjwyPcsP6A9QFoHvyo7OHcxKICYlz5EzE7OEX3BTOkyaBJ+iXAPjAIUqD3QLpaw5bBJ/3lxelP4d13O9S3MG4Bzz904bBFeAm5oVjRSWUS6IcA4pmr5d5FjG3LsklxZ2kBvSYGNYce73px2eQA8CSa/19/29Ah/aU/NpppWIg0I7vrd9XV2HVFVKZ/TyPaNCCPtvb+eQCsIRa43c5KVeCcEfSA
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 87285f6f-1cdc-4854-3a1b-08d5ec756273
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7193020);SRVR:KL1P15301MB0054;
x-ms-traffictypediagnostic: KL1P15301MB0054:
x-microsoft-antispam-prvs: <KL1P15301MB0054996BE9AFF5F661A9A27F92530@KL1P15301MB0054.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:KL1P15301MB0054;BCL:0;PCL:0;RULEID:;SRVR:KL1P15301MB0054;
x-forefront-prvs: 0737B96801
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39860400002)(376002)(366004)(189003)(199004)(10090500001)(4326008)(54906003)(86612001)(59246006)(486006)(6116002)(86362001)(6486002)(1076002)(97736004)(6436002)(53936002)(2616005)(476003)(3846002)(5660300001)(22452003)(99286004)(316002)(2906002)(109986005)(25786009)(102836004)(10290500003)(6506007)(36756003)(66066001)(68736007)(1857600001)(72206003)(81156014)(1671002)(478600001)(8936002)(14454004)(7736002)(8676002)(305945005)(81166006)(5250100002)(105586002)(106356001)(256004)(2900100001)(6512007)(26005)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0054;H:KL1P15301MB0088.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9aga+7sLLUO6WAe/k3XdJpY2YIkmkjzbpNBbzWf6ktbl+egR3vtjKLhAU5AGvWSV8xfm3s3RIswECqQ2HBHFCBPuQmbLC846Mo1ufe29j5SVzdO6SCykkA87B4kVg9GxRWhUjZQ/G6K14iQ/RtCokT+F2PYkMqxM1lLAKkjR9zskwl4By/0bp82eo4sxucrdtsiitex5C1/5tALED1tB7+5AYbrLyrbp/VFZUw07tMfgNh6JZUMWZqu+BkwmS+yvvDxdcmiBtPCN4TeKA/f4wKcPNaLTGK75LGgNTCeX8b0Shth1Iqg6hmQIEtcOJlPaSnYtyqLyt2bVXgSay8JSL6ZOXh9GcZjqfSG1PBrqX7s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87285f6f-1cdc-4854-3a1b-08d5ec756273
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2018 06:12:04.4496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0054
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge check of "sp->role.cr4_pae !=3D !!is_pae(vcpu))" and "vcpu->
arch.mmu.sync_page(vcpu, sp) =3D=3D 0". kvm_mmu_prepare_zap_page()
is called under both these conditions.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index d594690d8b95..c2c1fd66fb36 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -2117,12 +2117,8 @@ static void kvm_mmu_commit_zap_page(struct kvm *kvm,
 static bool __kvm_sync_page(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp=
,
 			    struct list_head *invalid_list)
 {
-	if (sp->role.cr4_pae !=3D !!is_pae(vcpu)) {
-		kvm_mmu_prepare_zap_page(vcpu->kvm, sp, invalid_list);
-		return false;
-	}
-
-	if (vcpu->arch.mmu.sync_page(vcpu, sp) =3D=3D 0) {
+	if (sp->role.cr4_pae !=3D !!is_pae(vcpu)
+	    || vcpu->arch.mmu.sync_page(vcpu, sp) =3D=3D 0) {
 		kvm_mmu_prepare_zap_page(vcpu->kvm, sp, invalid_list);
 		return false;
 	}
--=20
2.14.3

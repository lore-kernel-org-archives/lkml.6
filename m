Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97A6ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 897852098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QiPevXG2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 897852098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730489AbeIXUuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:50:39 -0400
Received: from mail-eopbgr720121.outbound.protection.outlook.com ([40.107.72.121]:64608
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727497AbeIXUui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9Bo0EEsixI4iImCZcGWxVveulMWgHbCrlSZB7GkJ+Q=;
 b=QiPevXG246jeF0SzdorzBGfI59eKoU+86hFtYEA/a0iRr/t2c0JtJypuKuHhaXk222pPvqbWG4DchAkkmVLQi1Y/W2ybuTB6vBgrZnP8lRruvU8+J//7JMoGHEpHycjAfi+EOU0UPT744eYZk1ljfMk5DGZFyrE6c0dJ+0cR8kk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0134.namprd21.prod.outlook.com (10.173.189.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.9; Mon, 24 Sep 2018 14:48:02 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:02 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 04/76] KVM: PPC: Book3S HV: Don't truncate HPTE
 index in xlate function
Thread-Topic: [PATCH AUTOSEL 4.18 04/76] KVM: PPC: Book3S HV: Don't truncate
 HPTE index in xlate function
Thread-Index: AQHUVBWYhlEhMaw/UUmyvSCyEl0EHg==
Date:   Mon, 24 Sep 2018 14:48:02 +0000
Message-ID: <20180924144751.164410-4-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0134;6:NtGmOa9o1D1l1RQFMI8VFQIFB8/GgPxeQESfMiMqhddhGF852suO8oK4iRZFUA7v8Gn2gOVNLKuWmXUocyhN024Sj81rhJH+TXo6ccT3TROoXTcCy1//6slyFZo5g4aPGjR47DHjLK9OTDhWz/0SjZvSEMZWesY96tYGmjfvY34N+KdYSfR35pdOGY+8a3JEKR+bd2aTdt7MsPBGV6p54CN+ttieW8IRP+ye5i+qG6mqkIamwOqK3I+1aPLNw61V3W6rS+GdlivKCdCJJysx9NH09q1iYvcf80eISyCFMS/5P3p9QJ2xnTaJAziAWlpgIeB5fZZGAqWY6qwPwbwSoTGPVadBCJ9dtlKv1y9LIM4N30gr2Hh6MC2fUymC8508iGhg1THzAVYf1baQ1sGWIJxtafa15BF3mcfpLuDgf/4Uh7JqS/6HXR+65iIBMhNrJXt/UnWPwka/OHlL5ApCeA==;5:r90eeYU2lhCsdzd8M0JfNY7Xa8PA8E2GeJeMEEbw/U59bNPAIEyWXpNgXmwfxeCDCh88MXwX1EvHWVtoshU28VL3aZteepvDimZWL0AHiETr2ZFyO/gaSw7fbPcpvxUGyhNZfDN8dqAb5nix/+qvXPxQX8ZYU1cCKTkuD7XLoUM=;7:UfahC7uKKxGlUb2ClfkxhUemmSRToBo5YZUPpux/nFGWTUc/VKP3HF1tZRnr6EclkpQ2EnA87VTWc59CBKRcqTfsCe6jiXm4qKz9lSEQiES/nywonnlZvIE8FZlh7LH9XpDZJzXOTOZU2k1pVp/cfVPcsnds89BWYe3tucvOtiPO+aXYr6qjwvaGfcrnCwpinS+urUZ1qoEFOlONXxDEQAmRhQ9G5rAjlFn/4rY2dWu+dZ55W2BkfUo20qrmS5M7
x-ms-office365-filtering-correlation-id: d763da6d-0943-4565-82e4-08d6222cbaa4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0134;
x-ms-traffictypediagnostic: CY4PR21MB0134:
x-microsoft-antispam-prvs: <CY4PR21MB01344D4FCA55FB838630BABFFB170@CY4PR21MB0134.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149066)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0134;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0134;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39860400002)(366004)(396003)(199004)(189003)(2900100001)(86612001)(3846002)(106356001)(97736004)(105586002)(478600001)(10290500003)(36756003)(71200400001)(71190400001)(6116002)(8936002)(76176011)(186003)(5250100002)(217873002)(2501003)(8676002)(2616005)(102836004)(26005)(81166006)(81156014)(476003)(14444005)(11346002)(446003)(256004)(305945005)(54906003)(486006)(68736007)(86362001)(6486002)(5660300001)(99286004)(4326008)(2906002)(7736002)(110136005)(6346003)(6506007)(6512007)(53936002)(6436002)(25786009)(107886003)(1076002)(14454004)(10090500001)(316002)(72206003)(22452003)(66066001)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0134;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: lGV1OlpI6bjTMcP9L+zBKm+rhUnmAjN2OjLQP3BSxxZoII4+DPlXgvbek3KuwAnDbxQv5/ycXTq8xLhNrFNbwIgCwIKquNbL4FKdMVTIQ7BO1nWdDjODFwzZFqLzQ1IJDTq7Oi3qNZOD8PAN1Z+d2gzWBQ0fzB8H1WxcMeVsLSNMm02L3ljDhHLSUg95Ikswq5yc5KeomMFcMw2dBRU/hEI/NBLjbAeqieWJbXnW+dxHlTbBSzuzrDAyi8Okv7a34Unq0kqiLQGqZeMfCZrkVfs1U2/r+DEGIb1Tz6grEPDD54cAe7Ztxz9KKtbCnDtoBrzLi266Mgn+PFmb3fTUbMlhIh6VozFSQh9hvYasfMs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d763da6d-0943-4565-82e4-08d6222cbaa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:02.3231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Mackerras <paulus@ozlabs.org>

[ Upstream commit 46dec40fb741f00f1864580130779aeeaf24fb3d ]

This fixes a bug which causes guest virtual addresses to get translated
to guest real addresses incorrectly when the guest is using the HPT MMU
and has more than 256GB of RAM, or more specifically has a HPT larger
than 2GB.  This has showed up in testing as a failure of the host to
emulate doorbell instructions correctly on POWER9 for HPT guests with
more than 256GB of RAM.

The bug is that the HPTE index in kvmppc_mmu_book3s_64_hv_xlate()
is stored as an int, and in forming the HPTE address, the index gets
shifted left 4 bits as an int before being signed-extended to 64 bits.
The simple fix is to make the variable a long int, matching the
return type of kvmppc_hv_find_lock_hpte(), which is what calculates
the index.

Fixes: 697d3899dcb4 ("KVM: PPC: Implement MMIO emulation support for Book3S=
 HV guests")
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_=
64_mmu_hv.c
index 7f3a8cf5d66f..4c08f42f6406 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -359,7 +359,7 @@ static int kvmppc_mmu_book3s_64_hv_xlate(struct kvm_vcp=
u *vcpu, gva_t eaddr,
 	unsigned long pp, key;
 	unsigned long v, orig_v, gr;
 	__be64 *hptep;
-	int index;
+	long int index;
 	int virtmode =3D vcpu->arch.shregs.msr & (data ? MSR_DR : MSR_IR);
=20
 	if (kvm_is_radix(vcpu->kvm))
--=20
2.17.1

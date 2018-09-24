Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486B1ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE51320C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gDCZCrBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE51320C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389194AbeIXUyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:54:23 -0400
Received: from mail-eopbgr680134.outbound.protection.outlook.com ([40.107.68.134]:2178
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731884AbeIXUyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxkfIFAaCLKAUnSQFrla/o8zNljnWaZuSDNy6m4y4H8=;
 b=gDCZCrBAuWi1Q9eS3sfZj7Sdq7zp8DZbcGZ8t8XDIVZFWWyD2BxE1aev01BtYKaxWHVh75KjO25Nb59nxgW2q6Jp8U/tOxRBk1E+VObd3g0cPJZAyvwB0ThXulMzwSK1b7U6S3RSuqO0qQs4B+YQGVKuVLuYMki0JbwhnUjCJa0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0631.namprd21.prod.outlook.com (10.175.115.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.2; Mon, 24 Sep 2018 14:51:47 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:47 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 01/13] KVM: PPC: Book3S HV: Don't truncate HPTE
 index in xlate function
Thread-Topic: [PATCH AUTOSEL 3.18 01/13] KVM: PPC: Book3S HV: Don't truncate
 HPTE index in xlate function
Thread-Index: AQHUVBXjHorlgXk+40aHxySBpnmkyw==
Date:   Mon, 24 Sep 2018 14:50:08 +0000
Message-ID: <20180924144959.164754-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0631;6:Iz2FOEj5RVJZyP+9LsovBB8G5um+3f536sbJKm3r9m8hBS18UzJW3rlxggW/H+IfU6efjXzcBc/qO+nPupr49LMuq+6/c/Djbvg7yQ5SqSu1KFDPBSOXwjeQBDL5Ecsu/WUFJO/gFG7UMARU+gQifqLdBBsvT+lnbOshn2N7mUgeT7ZFTxA4/Z5I2mM0Vh2SCfeELr8iK7cqeci3Qp1P/ZNms13BNabfFWnHOqumneDkGj/EXv4GdQsnjOme9DS1ZqMWrocXAJanzUCRMEVFMLSvd4gip5Tad+VZ48096puGJXP/0VLx4VG2nQyLNVWDfVq1yF3y5Vk86AZyaLYjFcErVFN17qc1xslGi8BTo00/2R4hDripjbtejOcDQ7DDqyzrYQE5b6srBhGDH5KeGhlxyCiHk30gCWLvWTADy1XV0xQD8n5X8moG+Q0VnKlHvCHfoD7pvqPAgSGVvF8C9g==;5:gf0JfGacjgmktjYUezVp+w802iaB6tLok0M6ReQ6scjGCHE5fFJSyxGHLlSDSTCPU6DSbJFF4dsFju88LK1u/NcO076R9D229Zz3H280R5kWU7Wgc0ZMRUJNkDD87jlYE6OCtREsJpPa2lREovTtlsCKVCmWevo/l+sZuUMWqlc=;7:7amZJ6HCTf1qnJ7MohbdkmHhjZuz3mQxOi5U1GlcjwXSKX/n+yrQzd836mKZNiGRiJt+7OSU1wnGCRwtJr9fX+MseLYwtRSZCys7SLp6GO/raRGBdfh1e1nu7TW9X5CBgckAulcwbn04Tzu1/WFjai62I4cWJQYAUUz92c4be+b0QM+GnSfuV22ganE+AiDSLFyO4gfXcc4x/87l1Mj0me2dNpbfiGcEOh8pSTpQTui3mlhbeAehFeJzRfebshcg
x-ms-office365-filtering-correlation-id: 611f6c20-6a84-4d7d-1f3d-08d6222d40ba
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0631;
x-ms-traffictypediagnostic: CY4PR21MB0631:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB06310C7FFEE26C91F5993CF2FB170@CY4PR21MB0631.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0631;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0631;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(396003)(346002)(366004)(376002)(199004)(189003)(10290500003)(316002)(8936002)(66066001)(4326008)(107886003)(6666003)(22452003)(6512007)(25786009)(110136005)(54906003)(305945005)(68736007)(53936002)(7736002)(99286004)(5660300001)(2900100001)(6486002)(186003)(97736004)(26005)(6436002)(217873002)(71190400001)(10090500001)(1076002)(71200400001)(2616005)(476003)(5250100002)(3846002)(486006)(2501003)(14444005)(256004)(86612001)(105586002)(14454004)(86362001)(575784001)(81156014)(81166006)(106356001)(72206003)(2906002)(478600001)(36756003)(102836004)(8676002)(6506007)(6116002)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0631;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 12ITiA7jlIp3F96oRtSs8NmtrOxgHZZVA5x9M31dfWG3Lj/BEG2Lmg0MWl8xQ6Wd702pwC6qPDr4/Nr2iPfJLLOhavq96kZiZGN0z/jWX3sLFp8fsnMeB7X64qZwrjDLsaRy4JZoDvSMPgPwMmTcW8/NsZxJEQmrE7iqk8vHure7OrXdjeKtDFt31WnLGQqbvA8BFUbIRv7w2Fk3LUwDv1zMkHlln3UoeVSKFHcGRAcGmfq6tXLGBrXp10qzhr23hGweArv2IfmpcP5iiHNC9lZH0I4Y9MTPkd5ChKRnnSnxsbcqYJ+F0FRzNLVkGvCH1zh94l+kLiyA90DZx422YCZytc/f5IBzKkR5KDwGBPo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 611f6c20-6a84-4d7d-1f3d-08d6222d40ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:50:08.1007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0631
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
index d40770248b6a..191cc3eea0bf 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -449,7 +449,7 @@ static int kvmppc_mmu_book3s_64_hv_xlate(struct kvm_vcp=
u *vcpu, gva_t eaddr,
 	unsigned long pp, key;
 	unsigned long v, gr;
 	__be64 *hptep;
-	int index;
+	long int index;
 	int virtmode =3D vcpu->arch.shregs.msr & (data ? MSR_DR : MSR_IR);
=20
 	/* Get SLB entry */
--=20
2.17.1

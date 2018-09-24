Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049C0ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9488E2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="RrvP/Uac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9488E2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732250AbeIXU7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:59:41 -0400
Received: from mail-by2nam03on0111.outbound.protection.outlook.com ([104.47.42.111]:30644
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388517AbeIXUw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgMq0pzVERIMsJmQfHsb0dkerJSLMLJGXEu4f4Doy1k=;
 b=RrvP/UacpNBO7e8lArByiqeyPtBQXETVeSCgtLwC8Ayb+9i368NW6c/13ajW8H5mM33pS7/6AvgIfDquLJNwksnFhFTbEZ8a7IFw3snfXyuzC0h6PVfZyl2jGRGxDCBqXUFm3UrT2hVEMtmX8nQ3IDucncmkRO1mUd8AE9kSwno=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:50:24 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:50:24 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 02/23] KVM: PPC: Book3S HV: Don't truncate HPTE
 index in xlate function
Thread-Topic: [PATCH AUTOSEL 4.9 02/23] KVM: PPC: Book3S HV: Don't truncate
 HPTE index in xlate function
Thread-Index: AQHUVBXIjvcMFmHOtUK/zri8oVSQVA==
Date:   Mon, 24 Sep 2018 14:49:24 +0000
Message-ID: <20180924144919.164617-2-alexander.levin@microsoft.com>
References: <20180924144919.164617-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144919.164617-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:iNhAYeJdhIMEqe9GkdQEnEP+w6UlnmzlyIFvOEpIgGx4CcagDNq59EhNs3mYHXH84SsRqw5qzc5SZYDDuZaYcpN6ENih+GClYBQxiXp21SXFqt5MlQhnFSZ9VDVNyyD0PzS8grhhI+oAJ872DaSzxCWKh4C1Wa7OlY83bdWiwIq8/MfhCPK5rh6vLNTS+YjDx8sKzCcDjvUQCSsFh+R0fgv6F4YPRCDr/2u2r899EIK28qS6sngip0RZenrAPYm1vy63XP31fR99EcBwGl7WXAvG8I+QESdwpP4ZvkoQBVglW89rl8U5d8tm5X9atwOtnT5j4rn8Pt4idruCGiNdkN62wvnsUlv74HYm3PV60Ox5039PS6VgZ1yDY8dmgjIqtu2iMR2WYT42bgbSzPr2bYXZDVDUAR1RIhRArDofJ2y7mQGYSyUr5HjmbHnwJZNv/6Ca7CllEPL767OJUle9Dg==;5:QzWLW/pA9AmmxDLu3nVyaivDxZi3tAo/hbOYjWXQi+DOHVUuY/yHrviuAniAknD8pE8wOST4LvcSqW4XZn2FUCjaKif7CFWPrHWg6dHcHbeaiCEmyH0fjbrh7N/LBzSEZFVVRI5T6tUgittx8+VnPxvebKW/aI0EJ7MK8sAI9Fw=;7:VbIbLniEqgD7v9JtHjoP8+agpcgzkch9woZO+ZmEd/KPv4CBuI1shEIURHW6LNpZMuQf2vRJUjKVCC+08ZgSe9d281UNZR3irZ03MKOSWCxIkSctB573E1/BHJ1z3QcTzr2BtYQF7+T6sp4VqH8nonvzJettpcsZEz054yi+LrMstut9qToJIPzhDnW/s3wHTcZzSPqZbrT4/KEPqV+XlghdWrvhdbJ1t8EIjmng43W0Jgg1DlSdM/zQe+m5CiJa
x-ms-office365-filtering-correlation-id: 757b4f70-dbe5-4707-a37c-08d6222d0f2e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0181189A0124D0DF422BC89FFB170@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(10290500003)(6116002)(26005)(102836004)(3846002)(5660300001)(22452003)(110136005)(10090500001)(8676002)(1076002)(54906003)(105586002)(186003)(316002)(106356001)(2501003)(6436002)(97736004)(6486002)(107886003)(7736002)(36756003)(478600001)(72206003)(14454004)(71200400001)(71190400001)(305945005)(256004)(14444005)(5250100002)(217873002)(2616005)(68736007)(53936002)(81166006)(81156014)(2900100001)(476003)(86612001)(4326008)(8936002)(486006)(99286004)(6512007)(86362001)(2906002)(25786009)(66066001)(6506007)(11346002)(446003)(76176011)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6oV10wwPw10yL1X6QMtFPGoZzr0akopg1EeOuEI3EL72nx0do+OxFfAnpzxQk05mEs6tk1k8+79Asai4ncAZW0j4DE4fCKWd5IQkxm5nHv5NKhSlt/sY8WKR8j1c0FV8SWJR0GPyyc7xmWRXC5c1ZCIXEXs7aXrpUXF/EN18jgVrs6Tg5x77STHZaWlQGXMLl2q3JI52ZZZM2U4i8lIIRueDfZgU6WzumUWefYXoS5iZxU3AeTMVU1hzsIbavwIWV3Bjq5YBzsNdjcPy72Y+g26WsWJOCJcRQ1F5vX1m0QB4EdqM7HW8RWMrSn7K9YxLPSk8ZdWsZ3nN12Q9OezHNazDXDs9S7D7npgCAVvu6Uo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 757b4f70-dbe5-4707-a37c-08d6222d0f2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:24.2366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
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
index 05f09ae82587..915e89fcd946 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -314,7 +314,7 @@ static int kvmppc_mmu_book3s_64_hv_xlate(struct kvm_vcp=
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

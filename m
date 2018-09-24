Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E728ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9B72098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="efuX//pJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E9B72098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388257AbeIXUwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:52:37 -0400
Received: from mail-bl2nam02on0139.outbound.protection.outlook.com ([104.47.38.139]:31232
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387658AbeIXUwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8ls06rj1mc0sDDQ6HxAKog1NOVsAzHmSYc5NkIFkPs=;
 b=efuX//pJuMcA9j6PvTsf0RND9YzoAbt0B4boui7JlBxGolBvBAj0unNwYL1UWjrX0ev5Yio5hJERFThfle9Wtuz+aQw1YmY+5nyhiwZXF1T1jnYvb0K9XU6gwiGlJCtaCbq44536MdQeRmKByd052K5v+zlpzyzki1WxigF/nrA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:49:40 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:49:40 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 03/36] KVM: PPC: Book3S HV: Don't truncate HPTE
 index in xlate function
Thread-Topic: [PATCH AUTOSEL 4.14 03/36] KVM: PPC: Book3S HV: Don't truncate
 HPTE index in xlate function
Thread-Index: AQHUVBW3oEYhE7CYI0uN//sBVjP9Cg==
Date:   Mon, 24 Sep 2018 14:48:55 +0000
Message-ID: <20180924144851.164533-3-alexander.levin@microsoft.com>
References: <20180924144851.164533-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144851.164533-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:EhG4SuOn4+UQcHO1096yFYcWqZYWM1W5pJK+pcCtfsZKVocjrzWoiTdmJxcXx0arLuY8xeZXXPIGKD4umdaiNAchiqLyWIQeqvtA09oblQ37VYLKUksAtzvkZOCLPX2f5jfhqhyW4m5fgY4OirlmnO4dzJbFabOtlXjQI+2kniYG5zwNwtnK9TgIQCQJi/tR2EsPeOlq/+9J1/YgyOq7wCRCC7qzoaKU5Fb9ZShNfE77nwuUlP+diJad4VVCHtm4oLiee6PqXTaHeL22yfZrNnF8iH4Ah4oRuyHDqQJf9ydjbJxG9DQfmZ+RxGgvU1ep0UxyURU7/OuhHZmMOgq02Fd0IQ8vjks59bg+xQ2qPOVozzNzH4UyyrVx/KgMXt6Dy1W10Bibd4F8EHA/miWHgtP21P1/5oLShP8l1Bszo3cVwC0o4mZNzqP3TOwNvyk9gROZbkyiFLrlN/4otjzhLg==;5:tjTFMfO2X+N0yGWDZ9T08s1QNR0gRNF3V/xRNtkgYbyyq2E4UcKg5YMC+qWimjtqBM6vhCOZkdYjOiAHAchRbazkRc4x22nTcaoyxJf2K4+jV2uOvtWBjgcofPtUJ21oSwR9iSOn3wWF2ZOvpWg8NF6XRw1YNJgNE3OkkZKgwvk=;7:24HyCY54hXTIEF138MxtCXhMTe/wF+DlKbQNiSUn+S29LGtpVlTUWuzXn0XaNEFdVlxgFKZikfBLN8NAE+Szc7tfdtuHUITUyL87kURe94yslxP2Yp2C/YPegAhBkJMyq2xTtOxDtbr4bHCpph514eHlxLr9ECp5UDqJ2dv136bw9V9CKHdOfOH5/9YL/He581N6W9/n5lk4WNG84rdPNhTe/Gx7hvRFpJHLsz1MwbIx9vAcFLdkUBVG2vAhsArn
x-ms-office365-filtering-correlation-id: 1f24e405-9615-4f87-e787-08d6222cf4c8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0470A3851D341ECA7730CB5EFB170@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(136003)(189003)(199004)(26005)(97736004)(53936002)(14444005)(25786009)(1076002)(76176011)(99286004)(102836004)(186003)(6666003)(4326008)(3846002)(110136005)(107886003)(86362001)(5660300001)(6116002)(72206003)(54906003)(478600001)(8676002)(217873002)(86612001)(256004)(14454004)(10290500003)(316002)(6486002)(6436002)(106356001)(486006)(105586002)(446003)(6506007)(11346002)(476003)(10090500001)(2616005)(2501003)(5250100002)(71190400001)(68736007)(66066001)(81156014)(71200400001)(22452003)(7736002)(305945005)(2900100001)(8936002)(6512007)(81166006)(36756003)(2906002)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GNQbL/smXe2fuulVDrHCQ4bUWePFPWaF8i0AMlEPrfqWfCZIaiOlPw0DSCeTAW1jQds0sJDB9XctqFYHyWyiRSBuwt8j6ddU/tVj5ql2mfhZ/Vn6fN6g9smNfVGDCNz3itEANpNDz/ZmOr6wT2lHjTqaslYK7spYMMEjG/+tWQxd6vfOyFTmoKlyvj243GfQi2EGeRlSsM5MFd3V2iwOp8cc7F+fgt2tmwcMAfAFShJ7daklrYk2i8acVJXq6KUpuTtD8Lz8bGZ77HbLkrwhNkgX4NIvh2yLOm5ZYUO5LLVY/5v27X5TUpYZpVOR8aKNB3k6qahSrjtc/0O+sJWVbwS5xky94TGezTCQigaXH2Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f24e405-9615-4f87-e787-08d6222cf4c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:55.5159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
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
index df9b53f40b1e..7ac7e21b137e 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -355,7 +355,7 @@ static int kvmppc_mmu_book3s_64_hv_xlate(struct kvm_vcp=
u *vcpu, gva_t eaddr,
 	unsigned long pp, key;
 	unsigned long v, orig_v, gr;
 	__be64 *hptep;
-	int index;
+	long int index;
 	int virtmode =3D vcpu->arch.shregs.msr & (data ? MSR_DR : MSR_IR);
=20
 	/* Get SLB entry */
--=20
2.17.1

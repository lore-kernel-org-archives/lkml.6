Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1330C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70CFA2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bM9PwX/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70CFA2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389055AbeIXUx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:53:57 -0400
Received: from mail-eopbgr720135.outbound.protection.outlook.com ([40.107.72.135]:34196
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731712AbeIXUxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bf8hK+wmZVub4bayeVdP5F60We42JzwUkUFcKHj+JAo=;
 b=bM9PwX/ZvYvSl4No6ebgzz1KAqE/a6zspI0SAczW4vwRG+4EGaHEA4ueUQASaehN/nseeqvDVidOdY1HAH5LjZ7sy9d1lNT1N74TZ/oTa2C+STLuv2/uX/Pv0h97jZFfRdCa04N9o96o3d22YFH0akp10ehBomoaANaFBYabQfI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:51:04 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:04 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 01/18] KVM: PPC: Book3S HV: Don't truncate HPTE
 index in xlate function
Thread-Topic: [PATCH AUTOSEL 4.4 01/18] KVM: PPC: Book3S HV: Don't truncate
 HPTE index in xlate function
Thread-Index: AQHUVBXV38L3q+AYy0Wcd4oW81IwaQ==
Date:   Mon, 24 Sep 2018 14:49:45 +0000
Message-ID: <20180924144942.164688-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:21wxQYiDmAdwPjU3Ja7rdsOaGHdfxBfBqkCWKqiRUXwnBLSyqDVBMdvnrSPKnENA1G0tKSNbHuqYzQBZYBlsPESooQ6xMtMmElW+fyLKdLii6yTh95D3DMaPNEpacD2DHwnYsEDxsNgVNo4bNBpOOLy0tJzmwINTP9nfAwajuLfWkpCspyY3+7AOcygx9tIBUaTCGmq7Tx9ORePG2ZFN58RvX3WMkK0AFsNlIqr4o8jUWAlbtEAgtLmZ4Lq8m8dLyMEBY0wCm7dK0qAGMWUN8DSCa1gsGWn4wqykOF4DdRJDmFiux67jRDnzUytCva2XJLXSb8D4ximLPzoqHGQDes/SmangCJdtWXe36A4xlNSOWvzz92hUoHw2+TkMXKvtA/o6SNYL76UdTqYOsyYKCMIF6PET4c3cV1fwE/gOLNwdC2JnVGD5+vX0AU3aqCPLbNOLE/kPYdM8Zx640K/fEg==;5:tXQae/h3XdKUPkCYWCfU9z31qtLWMGOLvnAyLj6GnE1xTH9vAgT5eEb1X1LaECimnxCDIBhCaM+aTl1NAYehKJcPDdC9+zeZwf+PjolTxGquuWXEyHthG0Lhgu7X2nlcEgPWz11LMOfro9BBGLIhFSxyDvm5WkIkMhI1judjH2o=;7:Jv3Ne1n2yAEVmKDW0FcLWULxNAdR4WRfW/0w1zk77SDwc8B69fY6bin4tbOc32ittV1sMt6bW0pAqRL8K2mwGI5HFrnBzpGnPITV4Sqyo5dGqYtTER+kg0wFTMcwYMsiXd/4sixEyuWcUIAS7gUh1tSOUfC4ZfQYy/jJ5E3EiQpAhYPh4wNNapgkCyrvJuhXvyGJjlnZK/lupXs1LDoAr/bLdJ0mCj8Qztbtxgkmnys886Q6ClGQ5A4XNsL/IseE
x-ms-office365-filtering-correlation-id: dff3fd47-440b-4075-ebc9-08d6222d272e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB0821AD251B69094795BE4F30FB170@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(136003)(396003)(366004)(199004)(189003)(102836004)(5660300001)(53936002)(6512007)(6436002)(256004)(14444005)(217873002)(6666003)(6486002)(2501003)(10090500001)(2906002)(68736007)(5250100002)(97736004)(107886003)(66066001)(36756003)(4326008)(25786009)(1076002)(3846002)(6116002)(2900100001)(8936002)(81166006)(81156014)(8676002)(86612001)(86362001)(7736002)(305945005)(72206003)(186003)(26005)(10290500003)(6506007)(6346003)(478600001)(14454004)(110136005)(2616005)(476003)(486006)(54906003)(99286004)(105586002)(106356001)(71190400001)(71200400001)(22452003)(316002)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: e4cXhpHOAjn3CHPZ0XPb1MeuQrPcVH1PS3hbnBOo/vle1zinNswXDp4r5TpI48xIeDMsdTmQhBYtlWcM3szRZ/SD8qDg3ViFYm2JTdQvw1ZdyklvEZQ377aSyReNiXMlLW+5AtmTeF/eJ+1nmfReYVFJHMT0sSS0NC42wc/HCTr0VsXnSc1PSwVIXCPL3+fmbUXrQGymfaQtKrSO9UPnAwFqAcD9a/vh6761j35sNRNMXXml8dN4otCkwEOMmbrDJ4FEQFGs475mMnkwwjq73fRttv43jtGXJltblptK/LbSP/orfvuTZwRl+A6gkHl6w4fVrf7wwl61ZQwLeqsxtrlfNICqlvNquQL3TQcc8Bg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff3fd47-440b-4075-ebc9-08d6222d272e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:45.6933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
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
index fb37290a57b4..366965ae37bd 100644
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

Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E05C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A2E2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4Pj5niJA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbfAVKYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:24:22 -0500
Received: from mail-eopbgr750050.outbound.protection.outlook.com ([40.107.75.50]:5706
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726281AbfAVKYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:24:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGcchk9CinZ9Jo+Ul59JvESOZGt5fIadXCcXkqPdbXM=;
 b=4Pj5niJAnaBGvwgMyS5PZp+F1AVZKqEE7TMv1t7OEoWnWvbdwqz8+kOHB7fxA2jT4fKYvvK9TfHpNjwBFiziteuA6JzhqsRBHJPTzCgAQCQ9tlozneve/V6hENOTX8bsNXEI9og3/6u8lSCk7XhZ6H62haAUlSkOku6mPCfH1VE=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB3179.namprd12.prod.outlook.com (20.179.104.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Tue, 22 Jan 2019 10:24:19 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d%3]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 10:24:19 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH] svm: Add warning message for AVIC IPI invalid target
Thread-Topic: [PATCH] svm: Add warning message for AVIC IPI invalid target
Thread-Index: AQHUsjyio81xgzyc0EGuZO9Z8XPvxQ==
Date:   Tue, 22 Jan 2019 10:24:19 +0000
Message-ID: <20190122102356.125085-1-Suravee.Suthikulpanit@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [171.96.72.83]
x-clientproxiedby: SG2PR06CA0166.apcprd06.prod.outlook.com
 (2603:1096:1:1e::20) To DM6PR12MB2844.namprd12.prod.outlook.com
 (2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR12MB3179;20:oLilFseRtBK1DOB0KRfpwo/v5DU4KsBRVVEPyURrzM2o546fLUddlB0aL89MQAYzff0Pix2qjydDvWUDNaSwwBCZ196NlM3XAUyhj64YDgrcceTexBr7haS2tbU9uJGod6N/xfrFxaXSn9Dg9GyK5S4nJ4H1rkY/YPq66r+IzECjeaJtSkSekPqmw5dafdWKFO6DPNlU3YonxeEDWjPlRzdvEeAuX3T91eY+kbEY3OuNyvVVCiHr3osc99Spl4Kr
x-ms-office365-filtering-correlation-id: 07342437-31fc-4a8f-a54f-08d68053c459
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3179;
x-ms-traffictypediagnostic: DM6PR12MB3179:
x-microsoft-antispam-prvs: <DM6PR12MB317916807FAED8746D541AA4F3980@DM6PR12MB3179.namprd12.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(396003)(39860400002)(136003)(189003)(199004)(6506007)(386003)(102836004)(7736002)(2501003)(305945005)(52116002)(14454004)(6512007)(36756003)(7416002)(2906002)(478600001)(14444005)(256004)(53936002)(50226002)(105586002)(72206003)(217873002)(106356001)(8936002)(4744005)(1076003)(71190400001)(3846002)(6116002)(86362001)(71200400001)(2616005)(4326008)(2201001)(6486002)(476003)(186003)(66066001)(15650500001)(26005)(6436002)(316002)(68736007)(25786009)(97736004)(99286004)(486006)(54906003)(81166006)(81156014)(110136005)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3179;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: otkrsu5yQbTPn9U7hS9uRiMnKWdm9lEktyvPxpGA2/yYYIdrWdCyShsuaELCgPYthgT/UcWIW3LzwYtGSRSn5kOoWBbiMStHatGeStdmDpIBSp4EUX1IYTO2lpRP8DTo698VzICsA6S7BHj0yytM6yu/+KVege9MnByV/r9blYzo8HhBrUfwyoNnZIjF8g7QYNWBCjAwcHrqRD8TmpzcMOGuvkj/iP/E0UYDqNFrHvjNvOW4Fi0rWdOaM+YSxtaGkhbhBWBsc5i+2OHIByQ83sWHR28jXrl7YsMwCyH5aiTGZ/Ltzc/nB19iEF8jPFHB6SPtF981LZPAwGzJQ01AQ/jGB2Vnfs1dKCtYpadyzBoRhmA8iDYKi1wd4Ne/Spgr1V/YRYcCenXWqENGJvoWBwyJQj7RKS+mE2Wyo0hYK4M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07342437-31fc-4a8f-a54f-08d68053c459
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 10:24:15.0390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3179
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Print warning message when IPI target ID is invalid due to one of
the following reasons:
  * In logical mode: cluster > max_cluster (64)
  * In physical mode: target > max_physical (512)
  * Address is not present in the physical or logical ID tables

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/x86/kvm/svm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index a157ca5b6869..2aff835a65ed 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -4526,6 +4526,8 @@ static int avic_incomplete_ipi_interception(struct vc=
pu_svm *svm)
 		break;
 	}
 	case AVIC_IPI_FAILURE_INVALID_TARGET:
+		WARN_ONCE(1, "Invalid IPI target: index=3D%u, vcpu=3D%d, icr=3D%#0x:%#0x=
\n",
+			  index, svm->vcpu.vcpu_id, icrh, icrl);
 		break;
 	case AVIC_IPI_FAILURE_INVALID_BACKING_PAGE:
 		WARN_ONCE(1, "Invalid backing page\n");
--=20
2.17.1


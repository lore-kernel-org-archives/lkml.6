Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA708C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 20:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8637220864
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 20:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Zc3K+Ori"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8637220864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbeK2HR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 02:17:57 -0500
Received: from mail-eopbgr710048.outbound.protection.outlook.com ([40.107.71.48]:37222
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725994AbeK2HR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 02:17:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nByKivz8tvM1bZPOfcZHrPjQoO1hV9xgvkoClpODtBk=;
 b=Zc3K+Orii6OilMBmffqD+R3Y1FMANXeTyRa74pCMtVN+rDjWtZKSnFTGJVup5xZa9llQ0QjV4Wjc3lTc5mfxbCGe5q4o20BPS1DZX3XQZwQbeQClEpit1JDp+EAewd4X/TwuwFrwcptvJc4FiYjQdCsiOJOSAcSNm+F5dJXm99s=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1529.namprd12.prod.outlook.com (10.172.33.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Wed, 28 Nov 2018 20:15:02 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952%2]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 20:15:02 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "Moger, Babu" <Babu.Moger@amd.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/resctrl: fix the uninitialized variable warning
Thread-Topic: [PATCH] x86/resctrl: fix the uninitialized variable warning
Thread-Index: AQHUh1cLHrV+vYgAEUixrLdncIDn7Q==
Date:   Wed, 28 Nov 2018 20:15:02 +0000
Message-ID: <20181128201450.31820-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0601CA0016.namprd06.prod.outlook.com
 (2603:10b6:803:2f::26) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1529;20:epO/NiTz0vDsi9t18HXQPhv66xRSmK+iaMI5TP2J9Yy0bN9BuC1oLkNU76GcNLH37zA+TBOKt8QAdzQWsO35ReDRf+ACKWTzB/v18kv1v1+f9FF7WBq9ttINSwJkUxgGEKO3qq1o5mkuOe2FpTtbScmCFF+Q+gPFjIpLVIxgZyTrVKSiJL6T4S8BB5CkAByWI1RlkLi1sNasSFzorFWlFaE+JN2lFSuxDlzQPBUv3T+qqAAy3JsXVLKgx2qTbGZC
x-ms-office365-filtering-correlation-id: fd100894-a2b7-4828-6daf-08d6556e2db7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1529;
x-ms-traffictypediagnostic: DM5PR12MB1529:
x-microsoft-antispam-prvs: <DM5PR12MB1529D242CBCB1A799A696F5895D10@DM5PR12MB1529.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(3002001)(10201501046)(93006095)(93001095)(3231443)(999002)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1529;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1529;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(376002)(366004)(136003)(189003)(199004)(71190400001)(5660300001)(71200400001)(86362001)(6512007)(7736002)(2906002)(6116002)(3846002)(1076002)(6436002)(305945005)(6486002)(2501003)(110136005)(68736007)(54906003)(97736004)(36756003)(14444005)(256004)(8676002)(106356001)(66066001)(316002)(81156014)(4326008)(25786009)(72206003)(105586002)(8936002)(14454004)(478600001)(81166006)(486006)(476003)(2616005)(6506007)(386003)(52116002)(102836004)(53936002)(2201001)(99286004)(186003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1529;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: I3c7vbe0gK8u6Dt1xjLIR7R/JGudV+MCSX6GqLo15Hvl4dUYk2jELwfjPKs0rbKU+w5m5LXQRNIwvzBTYu3Mlz2dqFHVxG7pWFFvZq//384MSwpC+hYLJ/NTtzq3jy8EStj2Ih83c14X/gYq6lgkuhzzWoXOg6cJVE+VOkqtwA1CglQurMMNLu4KpTqTNRmGYxoHF6RrTCrDe9i+duxSJEHLb0iEvsWf1pNI0ztmXgjxNNBJlQ5R75i0NKz7pofmWYy0+NsieKlNK+HZ093gDZu/PM7dxVZgjvxXGjQfgvscYIzKfJVHIm5tnorvp+MvnGFqukG/j0IlXGpt/k+/dd5+RexpVBBUxARbBSLEqTA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd100894-a2b7-4828-6daf-08d6556e2db7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 20:15:02.4015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1529
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the compiler warning caused by a recent change.

Fixes: a36c5ff560fb ("x86/resctrl: Bring cbm_validate() into the resource s=
tructure")

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cp=
u/resctrl/ctrlmondata.c
index 03ee13235a45..2477cb196735 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -202,7 +202,7 @@ int parse_cbm(struct rdt_parse_data *data, struct rdt_r=
esource *r,
 	      struct rdt_domain *d)
 {
 	struct rdtgroup *rdtgrp =3D data->rdtgrp;
-	u32 cbm_val;
+	u32 cbm_val =3D 0;
=20
 	if (d->have_new_ctrl) {
 		rdt_last_cmd_printf("Duplicate domain %d\n", d->id);
--=20
2.17.1


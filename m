Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC42C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 20:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA728206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 20:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mBwYLseG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA728206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbeK2Hew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 02:34:52 -0500
Received: from mail-eopbgr730042.outbound.protection.outlook.com ([40.107.73.42]:57264
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725799AbeK2Hew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 02:34:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t33WyYLFWZWG0ShvljEW0K4f0ShCLKhUSXDhMrRpB4g=;
 b=mBwYLseGB7fXc3L9VaB5UimiTJHQqW+osRaLlkMYWmmIjlfOqmdbsE/ymgv7OwecPmsgbzQLmp+LwugB73ntUKvGaXjZDEA0JJAEgDx7fzpKgSFNgMsQgZ5OCGtEB/XiFVL+QoNAMEQaDzp2hRXm1WZJ95+PwRxdiN7/aswV23k=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1500.namprd12.prod.outlook.com (10.172.39.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Wed, 28 Nov 2018 20:31:57 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952%2]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 20:31:57 +0000
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
Subject: [PATCH v2] x86/resctrl: fix the uninitialized variable warning
Thread-Topic: [PATCH v2] x86/resctrl: fix the uninitialized variable warning
Thread-Index: AQHUh1lofSlJzle4uUK6QP9a/A5tRA==
Date:   Wed, 28 Nov 2018 20:31:56 +0000
Message-ID: <20181128203143.32007-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0030.namprd02.prod.outlook.com
 (2603:10b6:803:2e::16) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1500;20:GmkSM789iMDeoeHWd+VzVt0pPhzlPBJ3Mdb7VHUpp4mfpi0iQBDneeCz6Qe9tv6bQSAJ6hIV2wwB0Xi7BlIIuY136d+XLLi8zXxIrF+UkOP/PM3WlypS0zgHr+ChO2WduACPbORbcux2e/6ocbX3DdsRBzHmdkX+xFDiTaA+iIs0ngbyA3BahNb1zqe5eEkJ5/59ARB9vtWehekMRO+ul646pU3NoXlu8qI1Bcvz+48l6PrrM1ujC2ZfSg5+s9zG
x-ms-office365-filtering-correlation-id: ac376cfa-fa47-46a1-d7f6-08d655708a65
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1500;
x-ms-traffictypediagnostic: DM5PR12MB1500:
x-microsoft-antispam-prvs: <DM5PR12MB150027A209314D7B0FCC56BA95D10@DM5PR12MB1500.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(93006095)(93001095)(3002001)(3231443)(999002)(944501410)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1500;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1500;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(366004)(39860400002)(199004)(189003)(99286004)(71190400001)(71200400001)(6486002)(4326008)(36756003)(14454004)(52116002)(256004)(72206003)(110136005)(54906003)(14444005)(6116002)(3846002)(102836004)(105586002)(478600001)(6506007)(386003)(106356001)(6436002)(25786009)(26005)(1076002)(6512007)(186003)(2616005)(486006)(476003)(2906002)(5660300001)(68736007)(81156014)(66066001)(86362001)(81166006)(7736002)(305945005)(97736004)(8676002)(2501003)(53936002)(8936002)(2201001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1500;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DIClKG8kxJe5+uHeZe1c3T8Ec6+IosGKE2VR/fLX+OOJhBa84WuABasTkTUgjV2BCYkcWnA1WROHR2w7WEhkVB8V+04VJvCirAKV9Q8Ch3i3QOmeFKZTCrbabiihWcnn/aHYArUbs9H57y/NLuuqC8c49XIhgoDb0qDxrHg2+7Cf00IyUapLTgyV1tWT/2puhxkC6XStaQYW7DoZLKXfNrLvmW+L9y5CVF/BohjBhbHAVUax0HdD20VqRZgn5uVD3Gx5k6dnQxBgfRV76XdB23p6sIV4MpCNzokY0su25XhU0OhLnmi2tLvca5SJ2KI2jdu0+X8tMxA09A9dQvXPq3hDitnrCaldpXyOTAmCS9w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac376cfa-fa47-46a1-d7f6-08d655708a65
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 20:31:56.9824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1500
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following compiler warning caused by recent change.

arch/x86/kernel/cpu/resctrl/ctrlmondata.c:227 parse_cbm()
error: uninitialized symbol 'cbm_val'

Fixes: a36c5ff560fb ("x86/resctrl: Bring cbm_validate() into the resource s=
tructure")

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 v1->v2
 Added the actual warning.

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


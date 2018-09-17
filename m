Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831FEECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25CCA208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hVcqJQhL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25CCA208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbeIQIw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:52:28 -0400
Received: from mail-dm3nam03on0101.outbound.protection.outlook.com ([104.47.41.101]:50080
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729803AbeIQI2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAISTbhvsYKJqkEDupBCZV3PVE9ObqTF2FL7hOKgOIM=;
 b=hVcqJQhL/9XL+0PnT6GHHdDP+4Sr39q8pgFKGeW6qgZdH+RfW1HD6HG9+FqUq67a701G9nZrmIJNsG9WKOBFDWP1HWpEI5GLKA67O+HktVsvDqxQnv3mSlRwQm8mxgfNdha+RGJTdKmPGYPe5hsIEXReKjduvoJa5vzuMUtM3sg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:03:29 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:29 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wei Yang <richard.weiyang@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 05/87] x86/numa_emulation: Fix
 emulated-to-physical node mapping
Thread-Topic: [PATCH AUTOSEL 4.14 05/87] x86/numa_emulation: Fix
 emulated-to-physical node mapping
Thread-Index: AQHUTjLdfoG+lX/S40yOaVutEc5tdA==
Date:   Mon, 17 Sep 2018 03:02:27 +0000
Message-ID: <20180917030220.245686-5-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:OsDzVNgWHRaOeJ1JC+5k3qRR3jymxhj/D4mrrS21rev/dLsyf8gQ1A4sprBfllP+f+5sAIeFUD0axHdx0Q4KLevblCpXC1Gya/NGIiIpl1mQ/mrytx2r21KJ/nbPeZh1DNatnEj5UmHTozlfYp7SNJUJdHQR4l+bVX6YCofvG8PPjusLXLXXpkdu162t8WeciXAeEojgpgoopCMWN9m8kBLnK4/5KCCxiTjfFqady5VgCBy65qx8mkGmjXNx2VHKQNc4VKnivmUvmAJOPcLftqdEUWIfsin9/a7BZTIKmf0Rzsbpm1o/qoAuydm7DQ5+JNefWwOk5Cq1EAwJzH2tYcdTCLC+BEh38MjM5+7ucTakmmi0CHwy3cuGg1roGbqG1TG5LJaqVXU10I6mvemUL0/yKVTKC5NU7vUI4tbazWsJzNN1ec18fjMvCkCgdjgUcfVzKjTD2ok0MVmo9Y99yQ==;5:E7Xd4DKu/p118MTU9wqqpCsE1IiML+hCm9rafwH6U6SAzYZPyzkaDz1Gik8Hk8S7UKoqGu8XSrLYEsr5I3zy/II+2SmpESp1jP8ITcYM83aAbiEB2SNp9At0ANee/ghacC6z6a9eayZL/mNno5ds3zwFgwtR0B5Vh5vWRSeeZt4=;7:AJjywI73O7M/V6wxNOTVSHI1EIelATYCTD4QN6X1YEXe8K+9UabzvLDi+XYaLpmxZzuXfIA/cD/2FUo872Lfu+MJzmLi/sempjNwgsVxz1nv6eiW1ZejjwsxgkuuvfLMe9S8O806VVGnpa9j7VlckJJ+8mCxcj9S0RvjM0mPI1BHx1iU91CbM7XghUOTHAEfIujwO4YtPH5DpxmNVS8YIVOEs92iV0uZOUAgTXmFc8hj7nUZWb/kHMJOOWz/LCfB
x-ms-office365-filtering-correlation-id: 13472970-3c60-4857-c97c-08d61c4a2527
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB0855CCFBACC756959EF93E23FB1E0@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(228905959029699)(211936372134217)(153496737603132)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(6436002)(99286004)(7736002)(110136005)(54906003)(97736004)(5660300001)(7416002)(66066001)(446003)(72206003)(76176011)(86362001)(86612001)(81166006)(81156014)(2906002)(478600001)(305945005)(68736007)(105586002)(2616005)(106356001)(476003)(11346002)(22452003)(6486002)(10090500001)(10290500003)(8676002)(39060400002)(36756003)(6346003)(6116002)(6506007)(3846002)(102836004)(107886003)(6512007)(1076002)(25786009)(217873002)(4326008)(14454004)(26005)(256004)(14444005)(486006)(186003)(316002)(2900100001)(8936002)(53936002)(966005)(5250100002)(2501003)(6306002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: cghMX1LU0nBTyd1UfeSRe1ta+NQCw6EvZdnJ/P4FMhAQJnXBKf0qSD6Ir46TPUz+6h98R7L360zLCuCijgcX1vipYudwh8XtVsRNxtPuXKpDCz8gXvTwxaIYfc0ZwYjeP/x6eely5KRucTqZ7bZA49dUTa0JsKEC3/wco5+1aWPiB0tOjLjqA/bM2ZSb6RIBn/YXUFZrU3FmGg0nCGZFmNOwQsToABe2DDvUlpJhNRu67reWLSmZuW9mNxqKuAusyrOja5PbBWAV2glG8uthu9HdhCWbi5gEDcgUGDFQ7aMdDHJQdHaXpe1nD2t2QnTbL2LpUDFZE2Qxej2tdzjvLBBcDV5xW+tIaXej6iXgxHQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13472970-3c60-4857-c97c-08d61c4a2527
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:27.8533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

[ Upstream commit 3b6c62f363a19ce82bf378187ab97c9dc01e3927 ]

Without this change the distance table calculation for emulated nodes
may use the wrong numa node and report an incorrect distance.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/153089328103.27680.14778434392225818887.stgi=
t@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/mm/numa_emulation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/numa_emulation.c b/arch/x86/mm/numa_emulation.c
index 34a2a3bfde9c..22cbad56acab 100644
--- a/arch/x86/mm/numa_emulation.c
+++ b/arch/x86/mm/numa_emulation.c
@@ -61,7 +61,7 @@ static int __init emu_setup_memblk(struct numa_meminfo *e=
i,
 	eb->nid =3D nid;
=20
 	if (emu_nid_to_phys[nid] =3D=3D NUMA_NO_NODE)
-		emu_nid_to_phys[nid] =3D nid;
+		emu_nid_to_phys[nid] =3D pb->nid;
=20
 	pb->start +=3D size;
 	if (pb->start >=3D pb->end) {
--=20
2.17.1

Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB26CECE564
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6683214C3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WpffpDku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6683214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731721AbeIQIfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:35:36 -0400
Received: from mail-bl2nam02on0116.outbound.protection.outlook.com ([104.47.38.116]:52292
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731493AbeIQIdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6EFB+hxxf/uX9T9lsQKkr7PTWDd6uMzxiXGp3m/DjA=;
 b=WpffpDkudTuMfuU1BebmBGYO7DUMSs8K21x7/L06NV7v8o6GZNVJYDuJRZ2kVN6934oJvvKNHjsZ9qoIxYx6OrktXElLJLwpb1yCKIqFZwO+qQr0jOQVuVpR+RuAGQH/Pd1yL84IzToPj6ZJLG9THx5q6OnKx5jxnhS0OdQNtKw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:07:48 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:48 +0000
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
Subject: [PATCH AUTOSEL 3.18 03/29] x86/numa_emulation: Fix
 emulated-to-physical node mapping
Thread-Topic: [PATCH AUTOSEL 3.18 03/29] x86/numa_emulation: Fix
 emulated-to-physical node mapping
Thread-Index: AQHUTjNPJiTeV9qlk0mPyGKnH3V5wA==
Date:   Mon, 17 Sep 2018 03:05:38 +0000
Message-ID: <20180917030533.592-3-alexander.levin@microsoft.com>
References: <20180917030533.592-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030533.592-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:nkKSD56B+aFXyyoUtzyR8hqR9/KydZS5MSd/MkATdFJ1ZhFOH6YkDAV984zRcJtkys3+45OiJGUDzxX8dj7Nf67Fz9OV7E9dVWkaF0BZ/+gqqjqbkIeWcDNaCjp8qMeu247L4a+r6PbKsMTrPb3c0i4nSzA/iB5f55hXWyzqHw+Xw7m13HFgl451iLvrWCUUZcoICGnbnLdJYLj/SBi9QN8L+Zbm/GkySFQzG2iV6cFJqxvgU1jB8JN5KT7DnVocA+AcIe9IxigAv2bHvA1ExCZor2d9UUApwkfzEIYN7J3Dy5SfkJ4lGhJprcrW0FFwaXnNXEn9ermVGfUOvukOlpk27EjZ7UNSVgaH2pN6WRbAptaOVN0HDYY9p6f7+VRciVUGbgWpesd1LW06zygFe5vFSj3EnP4jQ3cTeAFywYISgCC0r+weRGOrgCfz6r8cdSHO2cYPigBnPu1N+E8f9Q==;5:YDm1mF0jMdaRloWRc42cp6kleX1TS0hDouBqlYpaWaIxth/XedKEM7NhpNUZD0qCpUDZyuvMhg8QmhJIBFVT6tbgJN29wfDQBinV8Va0VRS9ynjgk2t5OqhN91SnOMv/AngNH2cdqp9LTCQc3KroF1aOVHydjs68Pof7Z8fbOoU=;7:xyYzVzUqiU3HLRZZxQwVTqYzixLTsCSSG9qBl1QrmsABQ8dCYcRe9BFfqq5pPl2fV9T9FeJ1P7MoKBZjwCs0uM9duSeoWbvSjqy36sqjLA0okJlFpOWjAlsS2/KIedcbzk/Vl1YnTcGi62bI8R8dC8TuSu0Fai123F6YqSCnF3YBnzSb5ft0d3EPdLcbtSouHd++mvXwe/swOZl/J9FFaLzlhDPnroXzjBlUnjOk5f5HtQheJqTWQf8XSEzqtxs7
x-ms-office365-filtering-correlation-id: 8804d47e-ca79-4555-86bb-08d61c4abfa0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB083975E2F48640D79E40B5DEFB1E0@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(228905959029699)(211936372134217)(153496737603132)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(136003)(376002)(396003)(189003)(199004)(8936002)(6116002)(86612001)(3846002)(53936002)(81166006)(25786009)(217873002)(39060400002)(5660300001)(68736007)(5250100002)(6666003)(107886003)(256004)(14444005)(305945005)(7736002)(7416002)(2900100001)(1076002)(86362001)(2501003)(966005)(6506007)(4326008)(22452003)(10090500001)(6436002)(11346002)(446003)(76176011)(102836004)(6486002)(186003)(105586002)(6346003)(26005)(106356001)(54906003)(110136005)(6306002)(316002)(478600001)(6512007)(2616005)(476003)(486006)(10290500003)(2906002)(81156014)(36756003)(66066001)(72206003)(8676002)(97736004)(99286004)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: SaFd5wzJF5XkqXvXfl95zoCmLhDsVlU/pWnHC84yxGlWlCHazGBApdihu3yhW+f2gMW9MixI1Z+2n66IvxCYyq6zgMMANcdaYF0+KHZLGLnbdbXV0IwvBUyQ0CDNRjAdI+wvTYD1Mn8IHTTgRJXfE4xMF/Lt68NXzPIP/9qlyjD4NGoMXT5kVcLwvR2aP/7NsWH/DrKMmJqilCrkL2nfxamQiOA8aE0cL52/HXKWH3ZNmyPXk59Dj4f9UvC8UYXAOblfRu6SNpXaZtOYWKUIc7T9ZC837nHUwTvLSyp3gYkg+086PhRePPf0YysomKcxCFTrK8v67ZNVe3NrhvXQScxZpZFt56Wff3fukYUrpw8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8804d47e-ca79-4555-86bb-08d61c4abfa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:38.4828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
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
index a8f90ce3dedf..dc6d99017f3f 100644
--- a/arch/x86/mm/numa_emulation.c
+++ b/arch/x86/mm/numa_emulation.c
@@ -60,7 +60,7 @@ static int __init emu_setup_memblk(struct numa_meminfo *e=
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

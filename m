Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6493ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ABA3208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="or86A8RW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ABA3208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbeIQIbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:31:52 -0400
Received: from mail-eopbgr690135.outbound.protection.outlook.com ([40.107.69.135]:15223
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730990AbeIQIbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6EFB+hxxf/uX9T9lsQKkr7PTWDd6uMzxiXGp3m/DjA=;
 b=or86A8RW81/mNsfCOvEOhNYlYN0I7viKZLfY1pxjlOqz2KNNchvdNVQtVv32XKJ8v52CjpDCAPesZ6Q4rPwXMoTRfy+ZvDvFeM+gM8hXCz0DCe3OdHHfZBpVQI0xnr//EEzeYNJDscF64TsaM2A+nMYOYFt8LO6pEDzAEY/Deds=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0166.namprd21.prod.outlook.com (10.173.192.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:06:31 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:06:31 +0000
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
Subject: [PATCH AUTOSEL 4.4 04/43] x86/numa_emulation: Fix
 emulated-to-physical node mapping
Thread-Topic: [PATCH AUTOSEL 4.4 04/43] x86/numa_emulation: Fix
 emulated-to-physical node mapping
Thread-Index: AQHUTjMzmvi+6bOoZES8pF/9dsRxJA==
Date:   Mon, 17 Sep 2018 03:04:51 +0000
Message-ID: <20180917030445.484-4-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0166;6:o8sUujSDwLsm5l+LK2YOyDJyutULlWPs2GrfRyP/r22B1Aknw7eo3SdRbV4Zp4mwaR+KgF0x3DGFyW2pb+JqiSAzOS9YdpLNSAyO/xVv329K0o5iZWXOlXdG1e1dinS1JtgcTzd21eTP9duPnGA/VzNeI43+hjRtNzHe1itGHyXemLOnsBA/SYL7bsxm/ANeOpaBP23BY29R4CB1oRnQk1p7wfA50zyqe+td5NWlfcnfusi9woDQh0aQaDtzVBA8QN5/DyveFvl0chNkPKyOha6cq6KGI+H2v/7DltgZZ9MLisWPEjNsZOaNE2NSGOcShqt4HUlXNclaKZ3yUWy5R+2bxAYXvqpyc2fJoGlnuLPU/J5BQscAPy5IQ39TLQlUcQu7kDZYgEH2sw7NN0cDMweCuPyaIlg5CztraZhB6lcZe+xU6mPoBJzJ1TQ/imawYdzEfGadP+EvFQLcOdaYQA==;5:EuSWVlk5HShvJjLXKLJPDLJOqzhZpGxKEBp48FCVRJjzxhwPkWWR2dr0bCqMhWDzBZeIjBhJ0dFW1WLagMMdf3b3lAXEZd725sJwIeDEweLi+whqapQ6nwDElS+eXr3q1gQu4V047Aoh1Zsr2EXfxQlLnFdRfh6Y27NZw6P/qMc=;7:7Yld6cIThAt38hfOp1FJKQWFBzNcGjgLXTvLcGNeZ87iGNBcfBC9O0IWBxgzI+X82WcSGbX5nxvUlPdjL2U5/bL0RINKSSjR3DebocHDNBfy+usL6QVmor78VgJXwB/bPHyhB05swhazFbRWgEieLROlqsGd3NR0x6oi1VsqBJxuyEABTRt3Zd0G/CtyR+/ekwkRkH+4VCA3w60l4F0FMD8zT0oOBFQxUHTaxPSXZ4DR9jTmouy1Qmg4d7qnkC2D
x-ms-office365-filtering-correlation-id: d99dd4db-3ef1-4c65-cecc-08d61c4a9154
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0166;
x-ms-traffictypediagnostic: CY4PR21MB0166:
x-microsoft-antispam-prvs: <CY4PR21MB016611CA1D6DEA7420F2C02BFB1E0@CY4PR21MB0166.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(228905959029699)(211936372134217)(153496737603132)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0166;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0166;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(366004)(39860400002)(396003)(189003)(199004)(305945005)(256004)(14444005)(217873002)(486006)(186003)(966005)(86612001)(66066001)(7736002)(6486002)(102836004)(6512007)(2900100001)(25786009)(7416002)(14454004)(6666003)(2616005)(476003)(39060400002)(1076002)(97736004)(86362001)(6436002)(6306002)(5660300001)(6346003)(316002)(2501003)(6116002)(76176011)(6506007)(105586002)(8676002)(478600001)(3846002)(106356001)(53936002)(68736007)(72206003)(446003)(22452003)(5250100002)(81156014)(8936002)(36756003)(10090500001)(107886003)(4326008)(110136005)(11346002)(99286004)(81166006)(2906002)(26005)(54906003)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0166;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: UnNpUei59kXFDspIkl6QDs+AM6phQCGn1cZSgyyijQ6mXRWIlxTB7U+JfdQ0FXYH1Nd/7xqEPKIsYYJtOwgiRmy14T15ePamfSdKhKI9YNnEdsPh8i96mfgqldFtf6V0MM6XvUNQIybi2NyDhM6LLbPw9v9m+twquXFHC6l9H1TALC2cSP+l6f9O6CK/Y3B4W+xIrVmJhaKIn8g+4iKAAgW/m5EhM7WvwugecPXzReegil7nQ6aC3WEh3VluleVURojwvbgzi1Sfo9T3HFRD1j5RfrVr9zAbDra96VAHiylAuIwMPocyeVB2Yqu6e2rcupBlIbU0rm9yu9jYhk4xBj41qrn+rCY22XJpaoSIIvI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d99dd4db-3ef1-4c65-cecc-08d61c4a9154
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:51.3049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0166
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

Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757D4C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F4120837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="G+/EsOe0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F4120837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730247AbeIBRcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:32:19 -0400
Received: from mail-cys01nam02on0107.outbound.protection.outlook.com ([104.47.37.107]:15264
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730229AbeIBRcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6N9rj+kMjqmzOVs2X3XNMCgHmPM/XTS2ZhmHhZ82GVM=;
 b=G+/EsOe01fSWgUr80j5OBgvhIouOW+bpqvV913GimPTBZXffY9uZuArhSTQIOP8ffrDk34M1RhtERWUIzNsrGYHA+NfLiSU+pc9mfOzUn46M8fG6B4Td7aVWEfBJ7LYCG/u8GGiJfIkj3zjvA6iY7lhpjp/8PT5jMQreW5pwt9A=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:16:22 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:16:22 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 17/47] MIPS: Fix ISA virt/bus conversion for
 non-zero PHYS_OFFSET
Thread-Topic: [PATCH AUTOSEL 4.4 17/47] MIPS: Fix ISA virt/bus conversion for
 non-zero PHYS_OFFSET
Thread-Index: AQHUQr8VnraX3n/jLkWeLir0mvpWJw==
Date:   Sun, 2 Sep 2018 13:15:56 +0000
Message-ID: <20180902131533.184092-17-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:lycjZIW4QhXgja/3bQlZhgPLFMEown92q2HBT39l/cSoj5zXB6DGesrbihKiNkFz2a+UHW0HpOO+CVtFoXLZhyaEuMK78Q3q8ZD1t6qk9aUhk1tqGdVoFdxIBa29f1Rbg/nf1Umb4S8gjUc0W1KSdqqicyfp/m9J3m6/Eh/PgA1CXZJVuB+lT5U6koxdGVpg/9GSvMfCjGGntHVxapXSZqF0Cy2F93qd+TZT1pjwymYPuWNeUzVqrcma04aE7vZbmVszI5rEHq5zTpEcSYbO2WlUShZD7/o/ze9YBQGa3FzSiB7jUcWHLIegJUkh9kQeTfsSoeUwLFwe+s+hhtP1621uiE+BqCQAZcFfOO6Cwf9QJMrtFtDPj+akmTBfnefim59Ww6DYoICHzPET7jtzPfgoCOpZtqlxYPzG7znx99JoEvbl4p9GkD8tYCyb+0hEBfzy3/ywlu/PsskpSu/jzg==;5:AvGJcIsMAoMAuUQw5RUjOI8qOCyVHIltQNZYpOH6NgtTqNZRkeQz/thnfq6fqpPnUY0y/djyu1x2JsvR9uKPfyCoA6OHp0sAVgiayyx2sB98iIrJXfNP4LqMsas0iaOb7GOJcy2LoO/1JHB6kr3a1VLLox8DPSadU7Mbaeb7l3M=;7:mpMyU2MJGCr4KanfzvnYHfYwJvd+YAGnLc+FKFQlTwv0QbvNL2L9rqk/dOvP5RRgUzezdPjfaumvs3JVuqjTDEe02H1f0fQMbAfbqptEkoPvmSMNJCkFyWMpT1Q9+KEmxxPVhedaGdXkIVCn5sM44zE1+Jk2YqPsbBDKQIfyFtXGQjMZaK7TK4zNNeGZ+gTzwLfxaST7tGqQ7ozRBWxUj8qg8mDLq2LNXdomdVgP3mrK92JPXSa6SMVzd4GYAOm4
x-ms-office365-filtering-correlation-id: 2d90f6a5-15cf-4fd8-652e-08d610d64719
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB06297B005890855ABD771D15FB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(39860400002)(346002)(376002)(199004)(189003)(8676002)(478600001)(10090500001)(14454004)(966005)(10290500003)(72206003)(476003)(5660300001)(5250100002)(106356001)(110136005)(54906003)(316002)(105586002)(86612001)(102836004)(26005)(256004)(6506007)(2616005)(6116002)(217873002)(305945005)(446003)(1076002)(3846002)(2906002)(11346002)(97736004)(6346003)(81166006)(81156014)(7736002)(6436002)(66066001)(25786009)(86362001)(4326008)(186003)(53936002)(8936002)(6486002)(22452003)(6306002)(6512007)(99286004)(2501003)(36756003)(68736007)(6666003)(2900100001)(486006)(107886003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: aFdgVDbflpKj5aSzj9hbpYkiaGecESrM1N8mHC0aNj8Sqi6cI1z5Dvc55TuQvDg4LtcY8Chp60KI8vQqTpiqC/sufPu5+vaRBxYdrsXowY0HAZEMfHWm8vccQD3aa4SQ1FkPan4Bw5dzgWObYdmsp0Je3jeR4RhgICfJNSb1Wm9vVvODfAZoTGiwuucxpQs77L1C+yRxHeVfIXWZR40Xh3EYanMdMHMMa1eP4GNQeEmAz1JnTMC6mCoyWtcCyag8wo66/DpZ7gp+LQC5HeRXkR52Xn3uPorGwEA7M6UE8HJzpIg+n1az422OeMpzb0vuRpBgvQltAzE4KBiy6g5XjF2svWG95N73ckpAsAuBa6g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d90f6a5-15cf-4fd8-652e-08d610d64719
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:15:56.2963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Burton <paul.burton@mips.com>

[ Upstream commit 0494d7ffdcebc6935410ea0719b24ab626675351 ]

isa_virt_to_bus() & isa_bus_to_virt() claim to treat ISA bus addresses
as being identical to physical addresses, but they fail to do so in the
presence of a non-zero PHYS_OFFSET.

Correct this by having them use virt_to_phys() & phys_to_virt(), which
consolidates the calculations to one place & ensures that ISA bus
addresses do indeed match physical addresses.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/20047/
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/include/asm/io.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 75fa296836fc..ab1df19b0957 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -141,14 +141,14 @@ static inline void * phys_to_virt(unsigned long addre=
ss)
 /*
  * ISA I/O bus memory addresses are 1:1 with the physical address.
  */
-static inline unsigned long isa_virt_to_bus(volatile void * address)
+static inline unsigned long isa_virt_to_bus(volatile void *address)
 {
-	return (unsigned long)address - PAGE_OFFSET;
+	return virt_to_phys(address);
 }
=20
-static inline void * isa_bus_to_virt(unsigned long address)
+static inline void *isa_bus_to_virt(unsigned long address)
 {
-	return (void *)(address + PAGE_OFFSET);
+	return phys_to_virt(address);
 }
=20
 #define isa_page_to_bus page_to_phys
--=20
2.17.1

Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA725C64EB0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3BE22089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="C4fP1InE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3BE22089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbeJAHRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:17:09 -0400
Received: from mail-cys01nam02on0102.outbound.protection.outlook.com ([104.47.37.102]:43666
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730241AbeJAHRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbxIlWO8CIwg3yB/SymggHDz1FeLryiFvrt5aFRhpDQ=;
 b=C4fP1InEdPhUWl5/jHV6zrrBqvxEbEFMrbqeHIfN5dL5ZaEHJYZx0mzILyoE9JxnaBZPtJX6YMTYXxFKx2Yfdxn1Kv621CpZanyGguXAYQBWxloHdOLIkblE0ZuS9CH5+I9V+FA8dp+s3cYVgLAhirHhYdXiE5qGL42hCsQUes4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0791.namprd21.prod.outlook.com (10.175.121.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:41:48 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:41:48 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        Richard Kuo <rkuo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 07/13] arch/hexagon: fix kernel/dma.c build
 warning
Thread-Topic: [PATCH AUTOSEL 3.18 07/13] arch/hexagon: fix kernel/dma.c build
 warning
Thread-Index: AQHUWR+JLLuadHZqPUey3YhrhU8Q1w==
Date:   Mon, 1 Oct 2018 00:41:48 +0000
Message-ID: <20181001004139.147341-7-alexander.levin@microsoft.com>
References: <20181001004139.147341-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004139.147341-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0791;6:LFPfvaP43WDkCD0gMCRNqRoHhNowj03lkAJ3/ED5ZXeI6ZBQxsGwPpQyw8NQi2X/eZwStg0YftPdxW8b9sI/NuxF2JuJSY9Fc5JFg436EXkSVwgEYir/uVphHcCBLZzIxFFH6j3aofiT6BI0xCwakg1NVjhrw7HGjNgwFmpTTIzxrxe0nWIi9yr3pma5PiZkGoRQ/CDJSj+hKSSCb9CZuMC4Qmj6NvRw2Gdtzn6TPEls1ua210JzmeE/GUtnqCFLB1DQXk3tQxywDu+jr+WiTWxrN2dR1yB8Xr2VwnuMor0Re+pc3QlulXzg5mjsgkUNUG3pcIhRIIxjFRG8XDar6JW7myF9CkuDUpCi1Z99R/+BuDMypGgHT72nyJJ4OqP5AtEQN48G4Dp/VeUZN9Fc46xMxsjUkNShhqjNIMnhDgBLw7gIzp4eVyxF4lY6KPFDQD6Z423PyiXNO6nSvkwgMA==;5:BZzCRdegwQfq7TyEe8Iqwp3VJ9VBFErXIJWeuAX8Q3iGKF7BLsidtBQVxqNt3o1pvD9fiiCpkvTtP70y7Gmwe2/pCF8LRGAgxIizsX3HsE85CSvn1G7lNFYGV2JQbFU+zPrP/udccC6rEy+e8PLPRee/oN8OwxN8KQasAQPDT7I=;7:xsiXaO16Ga5ELkWAdVUf8i5q12ZH99hXAW1YBFXbzDO2IC+NZAqPIueBaMoYnxWZ+UpL1HtpwaTdCHKV/R/FBhvMFmhxLa20WWjRDQKoKnjaaEn4dvgS6UcOu23SAs4sSm/GUGr8/r0WasvR982FajntuIMebQEmgjvb+vqba/PtBHSLZueMVmjMGD/ynqp5wjjqqRit9gwyBrFVTOxzPS35jG6E0mzLjm7MhrFM9we8y4Iy+KXJibth1c+WrZ8B
x-ms-office365-filtering-correlation-id: 78a8f11f-6e27-4309-116a-08d62736abae
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0791;
x-ms-traffictypediagnostic: CY4PR21MB0791:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07918FD4174D1CEFF8412D29FBEF0@CY4PR21MB0791.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0791;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0791;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(366004)(376002)(39860400002)(189003)(199004)(72206003)(71190400001)(478600001)(316002)(110136005)(14454004)(2616005)(54906003)(105586002)(107886003)(106356001)(186003)(305945005)(26005)(34290500001)(71200400001)(22452003)(7736002)(256004)(14444005)(25786009)(10290500003)(99286004)(68736007)(53936002)(486006)(6512007)(446003)(66066001)(36756003)(6506007)(81166006)(81156014)(6486002)(5250100002)(575784001)(86362001)(2501003)(5660300001)(4326008)(11346002)(6116002)(476003)(3846002)(10090500001)(97736004)(1076002)(8676002)(8936002)(102836004)(217873002)(6436002)(76176011)(86612001)(2900100001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0791;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ec0DFYBWUL9n4N4RBMjL5UMS/+LX44etce76KVHBQz0aagcOZ5g7/gLQRFZD+/bxwSEmSISo8uZjkXhE/Mc18vrKvGtdzPAlfkhXvyafFg8vpKY3UMJCT2eulzF+Dhrjkov6qBepnafbacEgFi3vhD2WwMHrtt7nm9OxqKj+PZgHxWo2AJHyCixv53vt2OSOBdCmhZY6IUBYkdE54v0vM+aTKpYEDTvAu8hac+ZWYjP4qlN1BvrDH8Q9sUG8CNxbnBNo0JPQqbLmmSV14bMkjXh0kXTpwz9v3DJyQ5mzf10qLdNSsGr5ULx9duCA/Bmcrzmz0I1/MPr0QAkgnc3SrSQoj0egLi4Q4uNmjQF96uU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a8f11f-6e27-4309-116a-08d62736abae
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:41:48.0431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0791
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 200f351e27f014fcbf69b544b0b4b72aeaf45fd3 ]

Fix build warning in arch/hexagon/kernel/dma.c by casting a void *
to unsigned long to match the function parameter type.

../arch/hexagon/kernel/dma.c: In function 'arch_dma_alloc':
../arch/hexagon/kernel/dma.c:51:5: warning: passing argument 2 of 'gen_pool=
_add' makes integer from pointer without a cast [enabled by default]
../include/linux/genalloc.h:112:19: note: expected 'long unsigned int' but =
argument is of type 'void *'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Patch-mainline: linux-kernel @ 07/20/2018, 20:17
[rkuo@codeaurora.org: fixed architecture name]
Signed-off-by: Richard Kuo <rkuo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/hexagon/kernel/dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/kernel/dma.c b/arch/hexagon/kernel/dma.c
index b74f9bae31a3..5a821e1c4b9b 100644
--- a/arch/hexagon/kernel/dma.c
+++ b/arch/hexagon/kernel/dma.c
@@ -79,7 +79,7 @@ static void *hexagon_dma_alloc_coherent(struct device *de=
v, size_t size,
 			panic("Can't create %s() memory pool!", __func__);
 		else
 			gen_pool_add(coherent_pool,
-				pfn_to_virt(max_low_pfn),
+				(unsigned long)pfn_to_virt(max_low_pfn),
 				hexagon_coherent_pool_size, -1);
 	}
=20
--=20
2.17.1

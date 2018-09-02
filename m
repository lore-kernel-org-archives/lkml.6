Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA58C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E866A20841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ZlhkFvJM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E866A20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeIBRTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:19:47 -0400
Received: from mail-co1nam03on0117.outbound.protection.outlook.com ([104.47.40.117]:55552
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727356AbeIBRTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A48c4MgVhaploSiykmd24LxwXLZb7dwvbMYDkWSffYU=;
 b=ZlhkFvJMcU1VhG7U/i4O/m7w8pYTydcvRVzIVAcnW49WuRtsemwJF0fOsgxm2BylX89x/TnaYomluaHuF8gc590n1RqDzXhSkNh8N0vjMsumbDBmVAg6O7RWZKTTQ8nZ1doQqnKVgvZi+ZEJS8WAoIpG7YkILBNY6hX1UwTjRGA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0837.namprd21.prod.outlook.com (10.173.192.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.3; Sun, 2 Sep 2018 13:03:09 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:03:09 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Reza Arbab <arbab@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 010/131] powerpc/powernv: Fix concurrency issue
 with npu->mmio_atsd_usage
Thread-Topic: [PATCH AUTOSEL 4.18 010/131] powerpc/powernv: Fix concurrency
 issue with npu->mmio_atsd_usage
Thread-Index: AQHUQr1MkUJ2+aH7tESv+end9oe9XA==
Date:   Sun, 2 Sep 2018 13:03:09 +0000
Message-ID: <20180902064601.183036-10-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0837;6:A1D2+kxS/d57GYzMGxFYcOjwDnlJ3d7ph86MYqKvqDI1pR5D+8XCONSjj0e4rNlzM1IAw168u7+Jn5DWTJ8ZTiLWwRtsp3bXFT7+nzCmvUb0L79aP+VObCLw+LyvmSUBaFvflFW7gEQTrRnVAltwcxlG4/r/gPNfFMmq3qzpkSWWK0Wnf5dpk5ciT8swui8H1IHrcZgh+Ss3NJOJCnuwxAEhLFwiEo3XYNToZrQpn7s76h252goO1/XJo419ckD2nkVkX2m8DIOfm7MLwu6Jcpsx0rqM+fTgxnlLFBHi5hZnvRoug16XEXfN+FaCm9A7Ro3Bmudq7VYVdjcJHU0Rrlb9y2OIAfyq03lTCnRIXWR0sp1HMfdNbIsADU4Yx+l2LxXfVaUHWjqPQpJiPHSwuyY3gWUAjoGKS2grsg5HaUhbpaohUOzCUbIXpiK/QeVlhv2/AiSPwPvBXgdUizEaog==;5:QrJeiXIuj8IXvv9x0Sx7e037qCU7upOq8VSa7TLlwacOFeJKGY9QqT5Qquw4YjR5C699ZLGmdgdLwLFYw9WMGeLoWCe9Q3D58s7J7jGP+3rnXMHz2i+RFrWMDPT2aB1dHcjqbT4yQ0neH5mj4cRPyDeffjDkiDlLtfoXvUU9cW0=;7:Tzn6PPUg3PlWc+nVBOKY1i+vJIyc+ibXsoD2qzvQ60v5R/OLVUJD8+oi85uTBERd/3tUveOHYuHxLoliYMPfVLFu+tgnIX1TvY39b6J6bJiqMznaCCx5KkxkrnVIvyuFLjMNN5HfowZZhDmsBJ+wpTR1j95ICE278uLnAQJj9CCwZ6nhNgz0CRh8nmwMrnKfQAsgGz9wvQmqYn0svL8uBR0yJj0Nu5FmNz6b2CXzL56d+f7YGwJo5V7cS+Vn2Aur
x-ms-office365-filtering-correlation-id: 91ea1dd9-3a92-40ac-4a08-08d610d46edc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:CY4PR21MB0837;
x-ms-traffictypediagnostic: CY4PR21MB0837:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB083725629BA88CB69EA44C4CFB0D0@CY4PR21MB0837.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0837;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0837;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(136003)(366004)(346002)(189003)(199004)(6506007)(2616005)(25786009)(476003)(2900100001)(4326008)(6116002)(1076002)(3846002)(106356001)(305945005)(66066001)(7736002)(105586002)(10290500003)(2501003)(72206003)(478600001)(5250100002)(217873002)(11346002)(10090500001)(446003)(76176011)(6512007)(6486002)(256004)(53936002)(81156014)(14444005)(8676002)(81166006)(68736007)(14454004)(22452003)(8936002)(99286004)(316002)(102836004)(54906003)(110136005)(2906002)(107886003)(86612001)(5660300001)(186003)(486006)(36756003)(86362001)(97736004)(26005)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0837;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EK1BZcrcY9ACABE0AYwNvO/pWVqvddJaHYjcqDKAblV/pT0C2FpQtT0R1zpFYFKmCmEIdg5kMAOrOlBv924i7U/Ia5OPZOEVifMevlFEDWMsnPvZdXgh1Q/9pCTyvskgo7kpnhpzrWSpd7CfqKby12v631CUwO6ESdbuA8ZfetSCaEx0cwwXnzFkLWsm81l3BrYAPI/HhV9Wfr4as/ysZWvZ+piVIcmIHCsd7+46n53d7wzj//LnzugewKzaepPtq+oTrZ7WyGvIqBWTfhUJrdak6kAYKJasotVsuG88suZD1lPDsv8f7SdRupBFe++UzS5gSuZvlZY2WsNOkwsRh4dz1WNxs8ojg1ArcTzLQJ8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ea1dd9-3a92-40ac-4a08-08d610d46edc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:09.7214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0837
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Reza Arbab <arbab@linux.ibm.com>

[ Upstream commit 9eab9901b015f489199105c470de1ffc337cfabb ]

We've encountered a performance issue when multiple processors stress
{get,put}_mmio_atsd_reg(). These functions contend for
mmio_atsd_usage, an unsigned long used as a bitmask.

The accesses to mmio_atsd_usage are done using test_and_set_bit_lock()
and clear_bit_unlock(). As implemented, both of these will require
a (successful) stwcx to that same cache line.

What we end up with is thread A, attempting to unlock, being slowed by
other threads repeatedly attempting to lock. A's stwcx instructions
fail and retry because the memory reservation is lost every time a
different thread beats it to the punch.

There may be a long-term way to fix this at a larger scale, but for
now resolve the immediate problem by gating our call to
test_and_set_bit_lock() with one to test_bit(), which is obviously
implemented without using a store.

Fixes: 1ab66d1fbada ("powerpc/powernv: Introduce address translation servic=
es for Nvlink2")
Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
Acked-by: Alistair Popple <alistair@popple.id.au>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/platforms/powernv/npu-dma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platfo=
rms/powernv/npu-dma.c
index 8cdf91f5d3a4..c773465b2c95 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -437,8 +437,9 @@ static int get_mmio_atsd_reg(struct npu *npu)
 	int i;
=20
 	for (i =3D 0; i < npu->mmio_atsd_count; i++) {
-		if (!test_and_set_bit_lock(i, &npu->mmio_atsd_usage))
-			return i;
+		if (!test_bit(i, &npu->mmio_atsd_usage))
+			if (!test_and_set_bit_lock(i, &npu->mmio_atsd_usage))
+				return i;
 	}
=20
 	return -ENOSPC;
--=20
2.17.1

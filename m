Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82CAC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96CF720837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ndaEjiQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96CF720837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbeIBRma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:42:30 -0400
Received: from mail-eopbgr720121.outbound.protection.outlook.com ([40.107.72.121]:51200
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727355AbeIBRWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vaxeeilEoNsIwgURFufvJ6HcUoOA4TBI8fnh1sYJ1k=;
 b=ndaEjiQe8/5nL4W7Dra/iLjP6ZWc8yY5BwdZ1sEnGqHKw3qtAPLViThyevTpH7n5znT7ygMPZcFeZBTvlj/yjnNSp1fa4UDjmBVaBRdblD71KqfsqvpzuFqP5pV4FsxiTcwLb9FO9ywpLUgyzeDg/Y1qnKPSthkQ4yvmxJ7V8Kk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:06:22 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:06:22 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Reza Arbab <arbab@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 07/89] powerpc/powernv: Fix concurrency issue
 with npu->mmio_atsd_usage
Thread-Topic: [PATCH AUTOSEL 4.14 07/89] powerpc/powernv: Fix concurrency
 issue with npu->mmio_atsd_usage
Thread-Index: AQHUQr28m8ubqoptPkyUGf04ty5zxA==
Date:   Sun, 2 Sep 2018 13:06:17 +0000
Message-ID: <20180902064918.183387-7-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:TFSWfeTFp0YoZ9Tvtyd5ZZLUNfo2exS85jxAPqDmUk2VJEG2PHenInLB72rfgurRAfG3Ime7pUaQ2srdARgwJEvwOoCe/if5K2MK58v6Fa9EMl96dK6vX0GssM7RttfwlrzqcMpMRaxvdS51hGJkfuRyeZZWq198NSBSFzeXGi3H+0CSB7jjwv17XHmREE/UvsUYgLI5Ew+shXEwIGGzbFPDy6iynx1dUwG0qcPX5rSu9eMRClZ24ZC5eykVYS/cheaLMbqwETd4SnvoiZI+AiJcoHQyu9S5rj85XpPXaNsUtr8izoeKvxPfc3JjQI5P/H55KYCWWqUaCzVl8ypfdDndoIYBsza6al1JUDduF8l20ls0Bz88Kk03hk4QQzFR31/A4VCyX20rGEpuq/8Z8bXiTTGUfdc+pcJTX0tLpvaR9zZHi6n9hHjwtVhPvmtPsnTmW4gF4r/n8Iyr6N5iXA==;5:jiDwo9LJAfyZR7ux28WWZ0lABuLWAiJYE+r6Jp3uElAaXgfOcv+wuPiSifR3PNCKAPWWKYW7vmuqFV8R8QMLhiOhpMH22G6CYUhsSuq0OMtfv4Eoy7sZ+/rDIkiz+bAQw3h5c/ju7eIjVKInz1KWSNf124ZfpNvYSxs3MMksirk=;7:ZmDU3U4wifyGKh2ucRHUGXr9S9tGMDtw88W4DXf3ochkayxO0xPnMGFddeRb0695OnA+sqQ5gjYPXl3jrJbt9W3dCjV4fbmkdgcGVeCbR9kD4mWz3QqtMABcVXxXnaYPSWLTg30VkXuWjBS+1qBWzwEpj9xVbO0lujkiRBdNHFV4msX2bP9lAH6V4Ll9izoU1YqSv8aUvbgXO6VONMn362wEyIJZjUhsde2aUda52qN+CQeUGrZCfi6Vy+mQn8eJ
x-ms-office365-filtering-correlation-id: 6b309cff-2e2e-41df-c358-08d610d4e1be
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB08225001280A6C7400F04622FB0D0@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(366004)(39860400002)(189003)(199004)(256004)(14444005)(6512007)(486006)(86612001)(97736004)(68736007)(478600001)(446003)(11346002)(25786009)(8676002)(10090500001)(8936002)(2906002)(110136005)(86362001)(107886003)(4326008)(186003)(26005)(6346003)(76176011)(6486002)(53936002)(2616005)(476003)(72206003)(10290500003)(6506007)(81166006)(81156014)(66066001)(22452003)(99286004)(102836004)(5660300001)(217873002)(106356001)(2900100001)(1076002)(6666003)(7736002)(2501003)(14454004)(5250100002)(305945005)(3846002)(54906003)(36756003)(6436002)(105586002)(316002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ObgCtjKUMKP/c0XaN9D/bKRdBzq0s+de/6/hrZ5xeFFZdTKSc41TQ4wdt8yafMWaQ81GupV7Miy6/DFP31SMtgEHJ52tPPA4+xoFcyk3JINSBKtATMSXSFl6xOoiR5W/1vY6Y2s2w+dGrZeaJDmj6zaMYW8RnCXhTT2R3iaytiUrzQNHh64vcZ9NIr5uVWKASIwPcUp1zNAff2LqJ1rJa6iBduPxnNpRCdMItoguhL4QZUvzxcCacD5DPJ+XCBfhiZfO7TjYnli1MX4C9RyponDBKSlkyA6mhTrMsiilKXquPGwJMh38M63CcYFyjo3jCDmdeNdKNt9HkVfzFa+iz3UGGOodhWBCPLEWCzyUmlk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b309cff-2e2e-41df-c358-08d610d4e1be
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:17.3486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
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
index 63f007f2de7e..4b95bdde22aa 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -427,8 +427,9 @@ static int get_mmio_atsd_reg(struct npu *npu)
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

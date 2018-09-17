Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA994ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C497208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WG3Ku3gZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C497208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbeIQI3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:29:38 -0400
Received: from mail-eopbgr710093.outbound.protection.outlook.com ([40.107.71.93]:31768
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730193AbeIQI3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKHi7THa5t/fR1LyFkyUKlyxMlzn8QPx63tLMIbiptM=;
 b=WG3Ku3gZcAoOMs5R1gL1GJ9Ahcp9oIpIGbb7CF0bMfJhh33fRxEqYO0DdLf6LJNrxzmCmLv53p9Z1uaGdf/cAV7edfg13Gss7gkDFltXmL5h0x8laWPxLIGb1+ZRjD0baZ1gHnlVj7gA7ASdu4iNhpqTFjXzQM25WdAYzJEnz+4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Mon, 17 Sep 2018 03:04:15 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:15 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 41/87] powerpc/powernv/ioda2: Reduce upper limit
 for DMA window size
Thread-Topic: [PATCH AUTOSEL 4.14 41/87] powerpc/powernv/ioda2: Reduce upper
 limit for DMA window size
Thread-Index: AQHUTjLq3Ui3WShxXUint4xLHmJaPg==
Date:   Mon, 17 Sep 2018 03:02:49 +0000
Message-ID: <20180917030220.245686-41-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0776;6:ATHpNJ4dTmZwr+AgVOlcsDM1WcULU+yGaABe7RNz1fLchQ7nFxRJclnlcgVJ9r23gdzP6fJpmjWLrrs3cEiGWtTxd5loQMkyCZEjCnIETlYKAWaqTPIV3Z0/O/UXpZL67Pi+ZpcNY7MZKMrABqn5mFaFLuw5AFMaDOyEFyaa0ePptK0w/VvbURjD5hdLWDV4Sy6YI4uv8BXwPBMd4c9Z+R7vwE4LYkQLIa5H+eR9treaZcVt/uQAoSOvDUPh07h4TbPNqtQrBl/kpLt04VgFryGgqY9xePeZlU84APVjog/JTOdEaAeQrtXRbf8cz6+cb66nL2yZUZJNxhsDG05bYvC4kzUoF8JVc14QZ87YINe/f7oYdFvgw0zDirPjH3OrxFjm/wlBOMZhORaElL+IsJFv54O71MHwOW0N+ZBfOrJgmEtPh3Ssp4S41+yAT8j2/kPPwSVBpyXDKD8BAKlkdQ==;5:HVwEDHMdJI/U0VW/kBzM+WOZ4mR2bkQHsy6KcRAItciRxbrAIKFMGy3lQ/KhhPWayXb0BScmC38+A/Ot3eEs0Gj1hjgDDR1X0Mnryfak7e1OmjOxNT+OTPrwum6G4Oidj0Xw3dQUKiWSVu6Eou4uykXgp7UQwqs61Jj2xJUG8Jg=;7:iYqj/1KBoTOcFseoRsWzfEugLa2fUqoBWa+g3NTqwVdIdH8Lx+L6230lvEK65VQELsWVqGrHPaVlxw1Zgq/5ai8aofjjjoh0DXPC0ui5X64yKWxy3Kssl6sa64XcY6KQtDtbCw68dKNvZrGIaWoTtFAFB9DAelKjMjg2Rdi1wJeh7I3/iXI4O95++bm6cEcPSf4RxJWDmuYWQxRYJ1BMFbZfqT2nZQ/+cTvBZknthkVmOiGoqAK2j7xd91ef7eKa
x-ms-office365-filtering-correlation-id: b10ea2b0-2a7d-4547-d1c0-08d61c4a40a5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0776;
x-ms-traffictypediagnostic: CY4PR21MB0776:
x-microsoft-antispam-prvs: <CY4PR21MB077612B7184803754CABE5F6FB1E0@CY4PR21MB0776.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0776;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0776;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(346002)(376002)(396003)(199004)(189003)(5250100002)(53936002)(72206003)(14454004)(102836004)(478600001)(4326008)(6346003)(4477795004)(2501003)(25786009)(6666003)(10290500003)(110136005)(54906003)(6436002)(66066001)(8936002)(316002)(107886003)(76176011)(2906002)(217873002)(6116002)(3846002)(22452003)(14444005)(6506007)(486006)(5660300001)(7736002)(2616005)(11346002)(446003)(97736004)(476003)(6486002)(105586002)(81166006)(99286004)(186003)(81156014)(2900100001)(8676002)(86612001)(68736007)(86362001)(26005)(36756003)(305945005)(256004)(106356001)(6512007)(1076002)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0776;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ackrTd2XP7gPLQvT0WtQ3KDSp9e7LttvsUgduFPCLK1YLQ6g3gSTQtEUq+BlUhZUR4UCXViZkRA+igbJ05tEaZ/3OjpqOINc7ORXTuavX2pDWUKkxrlM3ugsmWWx9Byx323S8m5H7dPmaDH0QpDUnmr/BJan8nMaXdABtxrQZSDwDMLfMgO/11/BdcGiWjhBAPqh89WXWpAUN6Fg6Ytzt2fi8dsrQhwxbq70dUH3WCe3BF+Qmr4Icq0UkgZLCgq3Z4zHyYcU3M1mv4kMEFsZbFXOdkSF7nq5M1B2dvCo1dtIXNwiZbNB4tSgTNu2F2qvIbIEp74Chrl4G9y0sUKvUuAZdj6GjijQHSrVva1lVus=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10ea2b0-2a7d-4547-d1c0-08d61c4a40a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:49.6811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0776
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Kardashevskiy <aik@ozlabs.ru>

[ Upstream commit d3d4ffaae439981e1e441ebb125aa3588627c5d8 ]

We use PHB in mode1 which uses bit 59 to select a correct DMA window.
However there is mode2 which uses bits 59:55 and allows up to 32 DMA
windows per a PE.

Even though documentation does not clearly specify that, it seems that
the actual hardware does not support bits 59:55 even in mode1, in other
words we can create a window as big as 1<<58 but DMA simply won't work.

This reduces the upper limit from 59 to 55 bits to let the userspace know
about the hardware limits.

Fixes: 7aafac11e3 "powerpc/powernv/ioda2: Gracefully fail if too many TCE l=
evels requested"
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platf=
orms/powernv/pci-ioda.c
index e919696c7137..ddef22e00ddd 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2787,7 +2787,7 @@ static long pnv_pci_ioda2_table_alloc_pages(int nid, =
__u64 bus_offset,
 	level_shift =3D entries_shift + 3;
 	level_shift =3D max_t(unsigned, level_shift, PAGE_SHIFT);
=20
-	if ((level_shift - 3) * levels + page_shift >=3D 60)
+	if ((level_shift - 3) * levels + page_shift >=3D 55)
 		return -EINVAL;
=20
 	/* Allocate TCE table */
--=20
2.17.1

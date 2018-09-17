Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2129AECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6F52147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DGWriJaC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD6F52147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731637AbeIQIfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:35:10 -0400
Received: from mail-bl2nam02on0121.outbound.protection.outlook.com ([104.47.38.121]:19879
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730869AbeIQIdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5WZGmgQrQFTKHJpfXQ1zs2WVcsINvz/TEK/6edORG4=;
 b=DGWriJaCp2s7L1u9BLOd7e7oaC/usp+mx2fCgYxfFP2ogMTkalwR8+PWg42M92y2AWAURt4xE7gGkcLn1kHDmuL+e/SSdipmZnGEVucweZdGkeqHHU18Hm8GOZj2RJ14/Lp3P782BUeR/CuP/eUsBcn9a9T5JwWe7/FWf9J9sIg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:07:50 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:50 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Hari Bathini <hbathini@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 07/29] powerpc/kdump: Handle crashkernel memory
 reservation failure
Thread-Topic: [PATCH AUTOSEL 3.18 07/29] powerpc/kdump: Handle crashkernel
 memory reservation failure
Thread-Index: AQHUTjNQ0Zu385pad0O6+oIspRPRIw==
Date:   Mon, 17 Sep 2018 03:05:40 +0000
Message-ID: <20180917030533.592-7-alexander.levin@microsoft.com>
References: <20180917030533.592-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030533.592-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:P9tPI/TwCd5wi323M+qKOq7t+cS6+lw6AeQ+q90aT1PoA4kZR9d6wyR7GAO0POhP4BS+s8yi1XZ5efG57ujl4A+8NH0FAsHTurgfq4bLJBqstAbkrjbbxpGDdUuseY3z79bb3JZMPMg2cVxdZjzeja3fypete1pJEEOW3p/Nx4liJA+CNANBpnVnndIkooRQcVoyIgCpbPS0iqlt1V/3WRMfAQatHVwwzrT0H0wtRhBiUexuvAOjn917NMFswM9YvzBMdU+Y7KlZqfr0YE+e4mDEk0IeHtebRJTrLoRW4mRE2Bn85fJe0L2CAPGBmt/VkDXkdx+eLJwNdTibeAdLZ4aieRtvTTNMxwqZjyGl/rCpJUFd3qNKWvZMfmTpQ7tnE+ayr8eOf/m5eZtBWHnIAMu5EJR+N3Lt7s5XxRg+BB8TycvHiP06vUe7A8jadyIhGbh42LXzsLT1GFgAv+WBMA==;5:3u30+U0Vb09hTWouYVcitc+0DcwIfeV81UhWDiYbBp6DpPL69VDzbVzdm1vjvMiAnUsBU1yPl10JVJCZ4Mfsxuy7eMZy4Ic2BuzvCb0M5Ut1nwOoBGTU3swcIWl4EX4HnjahPdNV1HaNTBROWmnsYKn1OIdJ6CGGWogIvy+HUNE=;7:tl/t9ScclO8YA5SgockWytvFqLxJ8p+HG8sGXCTWhbevgaJb4QgaiukimobMUW7omEDRn3K1PfwiBAFsnSF+LFgmDbKQ8xEqcpgzkSKhI6Y8E2MYayE0a+GZd+XueYcjxljZd+earIUp3zvb6RJ1qbPiPT6Pv5j52eTXm06oXq/MRiMUtgotcMgm0h9Rc3XPx3ylwW/cEH++S0fP1ACNbF5uYZduTePqD4saf/dJH3LnC05G2jkcPSfqIbH36Xo6
x-ms-office365-filtering-correlation-id: c71f8515-4a4b-4ef4-dec8-08d61c4ac07b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB0839D3AC34F6FE3E380DF1D2FB1E0@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(104084551191319)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(136003)(376002)(396003)(189003)(199004)(8936002)(6116002)(86612001)(3846002)(575784001)(53936002)(81166006)(25786009)(217873002)(5660300001)(68736007)(5250100002)(6666003)(107886003)(256004)(14444005)(305945005)(7736002)(2900100001)(1076002)(86362001)(2501003)(6506007)(4326008)(22452003)(10090500001)(6436002)(11346002)(446003)(76176011)(102836004)(6486002)(186003)(105586002)(6346003)(26005)(106356001)(54906003)(110136005)(316002)(478600001)(6512007)(2616005)(476003)(486006)(10290500003)(2906002)(81156014)(36756003)(66066001)(72206003)(8676002)(97736004)(99286004)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: x0GjrUCnJnvA48111XTi5pSvfPG8JUg9vXvxwiHCZ4rdw986tKebx9fZFUvxfj5urpyeiylSWKAjMMi/hZkBzz+5KTXpiww5YIRYDB9kMroSV3P81xa2VdsNVNeFEnlxDblovSSQnr3125WFeg1pSV/blyDFVpsM+qLj0izI+xTK7tsk1C7FTcpr3Glc8V7ZQRwECC5QJm9pYFRUwoCowI9EiJWfdnGwXJ2VVezWojIygU2Pjm/6ok5zO70jWRydJF5GpCLjkU8mtzdvP5q19klKUjxQyQIiiEPPelkM9fTlY78QGcUcx1ZmKXfcrYKX2pqMTZsT4DTGM7x/8ngPAXFaCkvFSKoQ86U85okTa8Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c71f8515-4a4b-4ef4-dec8-08d61c4ac07b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:40.9359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hari Bathini <hbathini@linux.ibm.com>

[ Upstream commit 8950329c4a64c6d3ca0bc34711a1afbd9ce05657 ]

Memory reservation for crashkernel could fail if there are holes around
kdump kernel offset (128M). Fail gracefully in such cases and print an
error message.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
Tested-by: David Gibson <dgibson@redhat.com>
Reviewed-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/kernel/machine_kexec.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/mach=
ine_kexec.c
index 015ae55c1868..8dff2b371219 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -186,7 +186,12 @@ void __init reserve_crashkernel(void)
 			(unsigned long)(crashk_res.start >> 20),
 			(unsigned long)(memblock_phys_mem_size() >> 20));
=20
-	memblock_reserve(crashk_res.start, crash_size);
+	if (!memblock_is_region_memory(crashk_res.start, crash_size) ||
+	    memblock_reserve(crashk_res.start, crash_size)) {
+		pr_err("Failed to reserve memory for crashkernel!\n");
+		crashk_res.start =3D crashk_res.end =3D 0;
+		return;
+	}
 }
=20
 int overlaps_crashkernel(unsigned long start, unsigned long size)
--=20
2.17.1

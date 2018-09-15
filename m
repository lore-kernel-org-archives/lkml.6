Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784C5ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 245EC20866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SGCIdBnm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 245EC20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbeIOHAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:00:20 -0400
Received: from mail-co1nam03on0116.outbound.protection.outlook.com ([104.47.40.116]:27616
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729220AbeIOGtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSia2YCL83nX8s/lLbNeW521uNtQSEe1K46C5GYfCZ8=;
 b=SGCIdBnm7sQIrFW79QtaBD/nlKQ3pzIFU45/grTVXdDDSkL+NpTHjSNbkmfQrKz6Q+hpjnJkTftMT4Z82AdV/Ith39TKqorNGuWSsJBLwyBxSIfTkfrXSli8q5A97ScoD74hIn5ed7ooxndzU7+ednwpmR+0U8S5eHnzf2mUesU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:32:43 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:32:43 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Rick Farrington <ricardo.farrington@cavium.com>,
        Felix Manlunas <felix.manlunas@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 22/57] liquidio: fix hang when re-binding VF host
 drv after running DPDK VF driver
Thread-Topic: [PATCH AUTOSEL 4.14 22/57] liquidio: fix hang when re-binding VF
 host drv after running DPDK VF driver
Thread-Index: AQHUTJP/3FlGfIacwEWXORTClreWPA==
Date:   Sat, 15 Sep 2018 01:32:43 +0000
Message-ID: <20180915013223.179909-22-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:dSsoifHbINqVXDMKp5FZq4o/Ynm5xzv7YbSuUV84NKiIOudeTHwBTeRKdz7/RgEiGSX+nAb2r71NUApSDFqRW47og/GxGRIlHuZC3Nf871nuYj0HOip1H6AgNwmR9pK+APmWaGEVhsR9ZqhmUcD0UBiwhg6V/EFABpIXYJrF6QaS3Fm0QnGpoEZBVlaLSwJCb1REaMS32XZ8gzDoQjJhh6+hllJLp8a0zJjj7XfG6KPC5e39ekQDR/Ldt+FW+N9rUGDO1lDGNTU7qaZCIH+d92m2Um8uRCxAuCiE5XHmbmTYR3eHSDg/mK7qDpI/0oE91qzoPPLXJLgA+bUo/CM3nYyxR9/ivoMP8npUaXXq6trawx6NVkjYyBHGKdZ48VTTDqHFpwltUUiCPyGqXmIjMx8WXUWab+EnUqJna2+DU0ZJZ2QHKlT7lRUKUM1tOns/F/YBpcTbETv9uX8+qyFMiA==;5:KRyvVXNyYKCN/ptRhWfFDP0tBkRlxME8sNJ5MRtT+kYEDpQcZu2WywNtUiXJUjLUZl0o1BjYh/zAtRoizcjgFcaEMWMCggZmhCbeYjOpwtEEKrkQkwLX9s5rKgEWVkRmLashQIALgeeoF+eTFB14Eh4NWGk7BilK4rbzSWDj5pQ=;7:pOux/X7bXCcOtVvLEs2+Wi1geuA40JdPHHA4EK5Ao/iHaD2iiwik+8NirNrLYFtC0/449+WZ2hRAqon2DsgiiexHoUg+d6ZautWFyplq2r/dvQjlZXGLHF3MpDysguDqERiyZCq3l7CceKiIPiLRv3NSkX+ucI2KQOfTg+R6XgKFCi9SdyqhRCj2jDuMsjmM7aXB/tO0/ODQy6BVTwcBTQ7mp+EnX/ymV1ATOAlvw2SYHJmQacQLTnj+VUiVEupk
x-ms-office365-filtering-correlation-id: 8cf08359-91da-4156-1eb1-08d61aab2239
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08220C0DE7808A0287BE1958FB180@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(1076002)(72206003)(6506007)(102836004)(478600001)(8936002)(10290500003)(2906002)(81166006)(81156014)(5660300001)(22452003)(2900100001)(8676002)(110136005)(54906003)(107886003)(99286004)(25786009)(4326008)(316002)(10090500001)(97736004)(305945005)(7736002)(6116002)(3846002)(256004)(14444005)(66066001)(76176011)(217873002)(6436002)(14454004)(36756003)(476003)(86612001)(6512007)(26005)(5250100002)(53936002)(486006)(106356001)(11346002)(2616005)(6486002)(575784001)(86362001)(446003)(186003)(105586002)(2501003)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: P8GGXWT9IxIbyWcgVXTCSZKPAOWp0UPmQUDnPxCvQ8XXMXAu8l6FebQ+9NUHYJPeRo1GvqfVWmIky/BgF6JGcbzM0OPoGHVN4bj/b454c3+xovQvf4ismol5c0Xc6FsRABb7rJMmS547vTVDFx4blOC6PGBorls/+/wuw2ljiMm8vxGhuiFNo2W2EW6JykQ98d63TRhps/UdLT4L0+cgoFItS6ypzPQ7NtnEY9MFQAUyb23iaXWpcWKTDGUNI6VRgaYFwgQkZL6o2l2vn74CCYtwLqozB1z9VCty3my9VEm3rTXTrcdpmHIixblgtW4dMP2hXt64FSqP1wwzbWMlRqMC7fyB7b1ekoQ+LOSZtZY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf08359-91da-4156-1eb1-08d61aab2239
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:43.4464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rick Farrington <ricardo.farrington@cavium.com>

[ Upstream commit ac13d6d8eaded15c67265eafc32f439ea3a0ac4a ]

When configuring SLI_PKTn_OUTPUT_CONTROL, VF driver was assuming that IPTR
mode was disabled by reset, which was not true.  Since DPDK driver had
set IPTR mode previously, the VF driver (which uses buf-ptr-only mode) was
not properly handling DROQ packets (i.e. it saw zero-length packets).

This represented an invalid hardware configuration which the driver could
not handle.

Signed-off-by: Rick Farrington <ricardo.farrington@cavium.com>
Signed-off-by: Felix Manlunas <felix.manlunas@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c | 3 +++
 drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c b/driv=
ers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
index e8b290473ee2..2e089b5ff8f3 100644
--- a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
+++ b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
@@ -493,6 +493,9 @@ static void cn23xx_pf_setup_global_output_regs(struct o=
cteon_device *oct)
 	for (q_no =3D srn; q_no < ern; q_no++) {
 		reg_val =3D octeon_read_csr(oct, CN23XX_SLI_OQ_PKT_CONTROL(q_no));
=20
+		/* clear IPTR */
+		reg_val &=3D ~CN23XX_PKT_OUTPUT_CTL_IPTR;
+
 		/* set DPTR */
 		reg_val |=3D CN23XX_PKT_OUTPUT_CTL_DPTR;
=20
diff --git a/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c b/driv=
ers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c
index 9338a0008378..1f8b7f651254 100644
--- a/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c
+++ b/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c
@@ -165,6 +165,9 @@ static void cn23xx_vf_setup_global_output_regs(struct o=
cteon_device *oct)
 		reg_val =3D
 		    octeon_read_csr(oct, CN23XX_VF_SLI_OQ_PKT_CONTROL(q_no));
=20
+		/* clear IPTR */
+		reg_val &=3D ~CN23XX_PKT_OUTPUT_CTL_IPTR;
+
 		/* set DPTR */
 		reg_val |=3D CN23XX_PKT_OUTPUT_CTL_DPTR;
=20
--=20
2.17.1

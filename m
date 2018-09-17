Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D85ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60CE92147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="TwFH1D5T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60CE92147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731677AbeIQIeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:34:00 -0400
Received: from mail-bn3nam01on0135.outbound.protection.outlook.com ([104.47.33.135]:35136
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731095AbeIQIeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+m6XHIIihxGy8+1idJf95Knp1ntrt1a+z3e8ASbVb8=;
 b=TwFH1D5TezKJ9OsKAnIaeGTd8ct8sV16+IRB7I/HNaE5Oy6wT/FpGC9qsdZwYLZID1v8Zu3HdiyWuEvjArENutfdI0F+SHh2NF0mBOPHYx4IQmyvX0k2IpUvb7FUpf5CfzMjyg4amaYupXluAz4SEwppx3G2WiD0golIfku6xso=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.13; Mon, 17 Sep 2018 03:08:27 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:08:27 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 25/29] scsi: bnx2i: add error handling for
 ioremap_nocache
Thread-Topic: [PATCH AUTOSEL 3.18 25/29] scsi: bnx2i: add error handling for
 ioremap_nocache
Thread-Index: AQHUTjNYFsv/NVzn1EKHC2TRgCpgUA==
Date:   Mon, 17 Sep 2018 03:05:52 +0000
Message-ID: <20180917030533.592-25-alexander.levin@microsoft.com>
References: <20180917030533.592-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030533.592-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:UExYMCtOj03k3tbSX623N0X58doyd821Sl8lpeisKyP3UvvWbWb3eXwcLOVIC5VKRUjUwibAgUyJqpZt0m+7/032/4yFTs7cnHgVxHUCCVKeUfWezy4C2lTilN8JCfVGSn9t0VJ0RSkAkwtMMlOV56V6Y+OQdEroPbGqsXj58SVW/CKRiJMGBqVfJ8sYHjgyK9RzptM5yTJX5xkV3edqsdXFBqMllEGRSdrWWIuFUwfehy2jENxBwuIh9jeCHZ94ZEgLVdErmJ5jbNCQSVy8ljI1q1MZppO03yf221nVcukDxxUDI/ME+Y0z0Ml81GQd3NPcm+jTOlnhDXW+EIpStbLow3ZqOpX0QXLkZNFd3+B/fJlusduLNJP23XJZnADqUHJEhdrG2i5g43W9GMjyYcYdx1d6L607oIOtvms3oFpxAmBK3JaPIKhzDODyIZacinHg20lKUtnPy6+aAM+eFg==;5:/dMRvjnis4xGAGDCl3AGkwb9i1PFFCJJTy/7D5pVXZ+4yyIp+VzrbnNkb9yshyKA1lRqbtNxwTzSOVTRtP8rO04wbP1WB0kqi5cJo2YhC8BIDGO1n8QbAYrhGSXmxeS75YObjfvQY/09VBBywI30x/F6Sgd6PPSDv6uFJ40sj0Q=;7:k2CMszsCCb3G2VfZT8ZaZXggcGuRbSUp1M/uoQbw/CAqvlZSYgQApBYfw6rFTiwxlNVGAunjU0L6cOR8gcO3T3nx7mRMrLYjtvmURYFe67YmV2wuSf+qznF3nv54tcoNMRhw9dC0chkISmhs7nx2l4GsoTVfygkmddAnPOxhxWcgOQIzLIgNhK28es0wxQ11xh3SeZMzCiUY7Wh/Qo8WDcp7s2Np+YOy4NlXP7Brdw0EzFEHcJWVCbZhx42DuEdK
x-ms-office365-filtering-correlation-id: 31422c6f-78c1-4864-1f2f-08d61c4ad6d1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB082177E39F2B7AC0BE1A01B3FB1E0@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(396003)(376002)(136003)(366004)(189003)(199004)(5250100002)(53936002)(14454004)(10090500001)(6436002)(97736004)(68736007)(7736002)(8936002)(305945005)(105586002)(106356001)(36756003)(10290500003)(81166006)(81156014)(72206003)(6486002)(8676002)(99286004)(6512007)(478600001)(2501003)(2906002)(446003)(217873002)(256004)(2616005)(66066001)(6666003)(2900100001)(39060400002)(4326008)(107886003)(86612001)(5660300001)(3846002)(575784001)(86362001)(110136005)(54906003)(186003)(316002)(22452003)(102836004)(6506007)(25786009)(26005)(11346002)(476003)(76176011)(486006)(6116002)(6346003)(1076002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: /tJS6Ay26zD8BaZ0I3cxoCg0WJIebd/eF3HuzaHqyLvm3CGTtISwTlM80yaljYoDDibeWpER+yagImDz+QWA8Xn0vR5o5C490Wu6g+eRh2/0XeFmzqOzWI6AWoDApWdVCqGwKsTNOSyMTPlXDviP9ja829SI871yI0b5NYmH7fDTYuU5zbL4J4duvUfMefqwT0y6JjXDjGzvUm8e+LGFdKz/+QgYj4KyKrSDu0dYb2mD9lFpIzekIeEPUL31gop9g5yMG3vPL73vFPIUWwJXl5lganyFYbvYCJ4gXZJpP3aoeYOEA85C+si0ebtcBbC08OiAi0EQorxYLsnYzSW7g2vZloYuxXGzSR7PARLUAmQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31422c6f-78c1-4864-1f2f-08d61c4ad6d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:52.7795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhouyang Jia <jiazhouyang09@gmail.com>

[ Upstream commit aa154ea885eb0c2407457ce9c1538d78c95456fa ]

When ioremap_nocache fails, the lack of error-handling code may cause
unexpected results.

This patch adds error-handling code after calling ioremap_nocache.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Acked-by: Manish Rangankar <Manish.Rangankar@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/bnx2i/bnx2i_hwi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/bnx2i/bnx2i_hwi.c b/drivers/scsi/bnx2i/bnx2i_hwi.=
c
index fb072cc5e9fd..dada9ce4e702 100644
--- a/drivers/scsi/bnx2i/bnx2i_hwi.c
+++ b/drivers/scsi/bnx2i/bnx2i_hwi.c
@@ -2742,6 +2742,8 @@ int bnx2i_map_ep_dbell_regs(struct bnx2i_endpoint *ep=
)
 					      BNX2X_DOORBELL_PCI_BAR);
 		reg_off =3D (1 << BNX2X_DB_SHIFT) * (cid_num & 0x1FFFF);
 		ep->qp.ctx_base =3D ioremap_nocache(reg_base + reg_off, 4);
+		if (!ep->qp.ctx_base)
+			return -ENOMEM;
 		goto arm_cq;
 	}
=20
--=20
2.17.1

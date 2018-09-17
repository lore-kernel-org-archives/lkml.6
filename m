Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C076CECE564
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693F0214C3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EDlSGUsU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 693F0214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbeIQIdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:33:06 -0400
Received: from mail-bl2nam02on0121.outbound.protection.outlook.com ([104.47.38.121]:19879
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729071AbeIQIdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:33:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+m6XHIIihxGy8+1idJf95Knp1ntrt1a+z3e8ASbVb8=;
 b=EDlSGUsUG/hWmBze8NZ3lOtBb4AFM1bmzvhzY1SJaNtJm66f46UK29prmeTrbWkBJhATn0H1ojP367Gowv2/LgXHjRysOUuuuyzEWoQ3VUkJOoDljEc4L0zoQp1HnIQ1rzOx9+s+KTjaiUb22CMB+nw4g3dwCTc+2/W96wq8puE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:07:45 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:45 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 37/43] scsi: bnx2i: add error handling for
 ioremap_nocache
Thread-Topic: [PATCH AUTOSEL 4.4 37/43] scsi: bnx2i: add error handling for
 ioremap_nocache
Thread-Index: AQHUTjM/vot/ooPd/U29J0Bqmca/Qg==
Date:   Mon, 17 Sep 2018 03:05:12 +0000
Message-ID: <20180917030445.484-37-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:ACr9OD1ah9rPtxKx5A8/f64pC3v5G+2G4IURbtgg2iaZ8HalaqADf5gWeUzRK5Kb3jUVHVaLIo4VvgabOxcNSN3+YMShqlxd9ybM+mrx/iG5hiPl6OLxvUof/PpZCDpuf/I5EkTOMjRb+FOIHi3WavmdySJcpeXuXbDvfTvaf2p4W5FTpvElmjzMovlODiaRBdz5OKdKaGZw/ndGtDHaB+h1Lgpt+mcwOszXO5gt+oVdq9fSm+aIqc+wQglkZ1JvQJPTJKty3/+wjIsu8j2eNlDPXHg8I8s+LGNju7c4Ml5F8c0zfpkipzlj+rY65RNLJ8b5hKI9YCRKmgD+OqpQtqtVN1wRki1OSLfCt+m/Kt9zis59ekO/18qPodrUmqDmbrjCVhn3SgoBOReepiThP2/yiA+3zO/8UzjNK3vgvUGwLQjVesxIBlE6Rv3KmARsLqkagldWNuZJxmK5TOo7GQ==;5:kuDTPsDPiGF+4y8FTaqJ1DJLsp7273wGu46YD7WA7JjEZqNtdQVd6wOxemYHdjptqr5fdUoszH2L7ErHRABvNNm02EtUPVTGfHbZ9z3wiRT9mpRXlFEho0Y2PqcXhDgzFlUpUl1sDh84SwdBucjedqpb/zLvBSc7ELBpGKwaPJI=;7:k0VY/ElR0PI0lk1avCOuDIvwHxIMMNP48YUUZBuesB8n6xe1UJ13nhUgfLnNno4DX6q1T8WqeR4dJkXGgTIh9yjSqH3KQ1CqbW3j6cNFxQPM9WcZfaGhOJH+RNByInznaqUUa8bT4M/lu5AnPROvBuom3YeNg3RiGwqLxaiFFTvS1KPOzDQl9/YM36xQQn8DScsoTe/2lZGWV1JS7Jwkng2oYSUJQPOmf3kLLUECP2LgMDhffwU2lIZ8jYPexR+B
x-ms-office365-filtering-correlation-id: f96ca269-75f9-41be-b256-08d61c4abda4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB0839DCB3C86FE42BB3A36D08FB1E0@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(136003)(376002)(396003)(189003)(199004)(8936002)(6116002)(86612001)(3846002)(575784001)(53936002)(81166006)(25786009)(217873002)(39060400002)(5660300001)(68736007)(5250100002)(6666003)(107886003)(256004)(305945005)(7736002)(2900100001)(1076002)(86362001)(2501003)(6506007)(4326008)(22452003)(10090500001)(6436002)(11346002)(446003)(76176011)(102836004)(6486002)(186003)(105586002)(6346003)(26005)(106356001)(54906003)(110136005)(316002)(478600001)(6512007)(2616005)(476003)(486006)(10290500003)(2906002)(81156014)(36756003)(66066001)(72206003)(8676002)(97736004)(99286004)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 9ur8YhI2iuMggOiuarDmry8l4oHp85vXp/giIbzC/FpEhFQCGWp+Zpmvx4AOkEhcuy3nY6KczWZBJV7w+8uQcQVNXQvqt+WU3Ak/sy8AS1CseMN0/TYX1euGDcOPbsjeVTg2XkGsyV91nvJm7Qfu0ohUTKgd+Obb7X0ePsFu+f+/Ryf+sqCHD1MExLZp+nifxaFtbJGuPPC2bk8FLgxByBOQ3yRDlRvUyOOwUeYMPfblrhM0ansnno4yYsi+QJpzwZbvHvoyJo1ztSKFHh+fbi7VXCVDp7MWZMhQaYKq7zz2d6GEyxb3Abz4xXTQS665TcS6kR794DIpE6sseUYkGvrH948CeDi5LsMe/o3yl5o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f96ca269-75f9-41be-b256-08d61c4abda4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:12.2109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
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

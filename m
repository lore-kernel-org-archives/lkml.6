Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3DBECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8192147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="f8uOzx04"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D8192147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730498AbeIQIaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:30:24 -0400
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com ([104.47.38.103]:18657
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730424AbeIQIaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCZVr7bmdM17i6qTRMlt+NtrlF8V0TdcVBmvXfoYXvE=;
 b=f8uOzx044vdmgdU1IqwmZMdn7EsF1OI/f+eZDsMC0kfHQmAytG6KYeWiIWB4RiBRFqgqpHPxiUu2PNgWdAZM6xeRmFmvJdjMRvkiGRbGOOQfiqBfxm8PJ+YVWmSu7t4cBMNemVxvUuW4jeSq13b7zDqv10Gb4bhbiKFeuBJzwZE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0133.namprd21.prod.outlook.com (10.173.189.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:04:59 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:59 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 73/87] scsi: bnx2i: add error handling for
 ioremap_nocache
Thread-Topic: [PATCH AUTOSEL 4.14 73/87] scsi: bnx2i: add error handling for
 ioremap_nocache
Thread-Index: AQHUTjL3VSIZEDqoSkW6LUB8x8njJQ==
Date:   Mon, 17 Sep 2018 03:03:11 +0000
Message-ID: <20180917030220.245686-73-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0133;6:arCUmLlf35c1nVZQ73MJ2U1RJbAaZZInx4ngsrhfEUW0gu1W+WlsgZZlQiUvxhih7bXqezzBPQLnViXHP2uudDBQh1DZlg6/DHopqjKjhvIpgCkEcBdHrbyJVqWvVAOojyC3s3vwZT27UEfmEIi5Wv3sB6xfoxkAhGz0HC+kZuI5M49zEyQNPP4+aq8WW1/mLLB4h30nKsg5oNbgWZZUN5tfwqnEv6vQ8jAzOMFSThcToNlMRzzRI/ogEmU3I2NAKrktfgNJagttwBbsIMw6KCFUwIwZy9BZbwuPGR9iECQ/vCfXN1Q8ps3k5mqMRt5UzLWN7iUOpgiyjML/zm3/P00JqNbdi1bd6nuGha0thW1Ios4b7HgrrjwiudY1IMFcRSg+hYsDVYZCFuC8XEoVueNjfUUgshBZK+WQcBSJk7eoxU0fRmPQj26OnF2BzriUPsGtmB7zgJk8FZ0ISfM1mw==;5:R9lBRC5Ndxc9smMfD+ktbfeOQiPDtdOxbE6YmdTly8WVxIXGQnXdtF4Jai8cASq6zdJrVK4/Z8YE5EToEsqd6ezSgtDE7UMLZGsKssIQWz3mDiZLgcBP5jan85iyEp8vzIRDqMk1zBOyOI6OgNLgudii/U2qsGwU0LCIfvCSAkE=;7:o+WrY6OLoy6Lfi6+EjvlPmvAyOQ9gQ5n4ZjpSslo+X9Jjb3OmVcnMjkHhqkq2ACNxGGt5glLwwjWVTtm0SreZ6yUupzqn/yVnTc21FklJxV93N1sZaXX2SvKIuu7KqYlTW29m2XJ7bnPB58NuKOE/YumoyXeGGjyMIr23ssy4asoYLMRdrZNEFCI6GK7rEZtKWyBX0M1481G2FjRhKaDrmZB/VQkng4PKSkrZ0SvneoKkG441jR9rEU8zKaKtnKV
x-ms-office365-filtering-correlation-id: 6abfaf5b-6ac5-429f-2efd-08d61c4a5aca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0133;
x-ms-traffictypediagnostic: CY4PR21MB0133:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0133DC6FCC70EB364A6FB700FB1E0@CY4PR21MB0133.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0133;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0133;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39860400002)(376002)(346002)(189003)(199004)(102836004)(53936002)(8676002)(486006)(476003)(3846002)(6116002)(76176011)(10290500003)(97736004)(217873002)(256004)(5660300001)(107886003)(6506007)(478600001)(39060400002)(110136005)(2501003)(10090500001)(305945005)(7736002)(446003)(11346002)(36756003)(2906002)(1076002)(22452003)(5250100002)(2616005)(26005)(316002)(106356001)(25786009)(68736007)(86362001)(575784001)(14454004)(72206003)(105586002)(99286004)(6486002)(6436002)(6512007)(86612001)(6666003)(81166006)(81156014)(186003)(2900100001)(54906003)(8936002)(4326008)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0133;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5T6PMFZQ11aTAI490sMjpJtY/RpQaMLEHEMrq+fyX2di6wgW1Se2gTJVSu78uVmUM/QIqopxlr2FNaLKMInLndxbf5wYoA9cV4AvFCvBc3XhWQsYO9uzMVjc5IlGwlNmma6EDHD7QLFRlUhTkWkpL2V4+lxZEEKeUuhgqwfoxmHwLNEqfz5W6UeKRAA1Wyvw2LlgRJ+MxHGUe/xZWdI0pZdUsG0qQpCZmMbluXye6fAsQAAIWc+kn2Hrgd1hMVL5RNWN5Nxvi7o28gt6Qz5Cz9VHuJl9BNB1S70ezOIyppkCFfCsJvNwj5T3v7ro4Nnjm+jK9dulaD+FXDVQB9FUFGO/nPiiJgNV/GYRXEYy2qI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6abfaf5b-6ac5-429f-2efd-08d61c4a5aca
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:11.5403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0133
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
index 42921dbba927..4ca10501647b 100644
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

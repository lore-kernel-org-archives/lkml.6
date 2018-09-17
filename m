Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637B9ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12477214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YyeLd6GR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12477214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731058AbeIQIbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:31:55 -0400
Received: from mail-cys01nam02on0126.outbound.protection.outlook.com ([104.47.37.126]:15104
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731028AbeIQIby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCZVr7bmdM17i6qTRMlt+NtrlF8V0TdcVBmvXfoYXvE=;
 b=YyeLd6GRwH6JbU8iY0G9vbbNTHVt3eWrSQy98ADP2mDMzrE7lXOLWDMc6of+cY3RTqM/r9+zIZ8CvPunjWFTXmBY20h8wKS3ee9ewNHk5ajXYNim3YOyee76PFEEAmG/oWbUbu07nejhS/YX1ADrmlfAkeCRDpDhQdI76Z/Apa4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0742.namprd21.prod.outlook.com (10.173.189.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Mon, 17 Sep 2018 03:06:23 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:06:23 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 48/57] scsi: bnx2i: add error handling for
 ioremap_nocache
Thread-Topic: [PATCH AUTOSEL 4.9 48/57] scsi: bnx2i: add error handling for
 ioremap_nocache
Thread-Index: AQHUTjMcaG1kjdpd5k+suaVBfgPdMQ==
Date:   Mon, 17 Sep 2018 03:04:12 +0000
Message-ID: <20180917030340.378-48-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0742;6:PDm6aNr1PPLongdIf51M/tM0VJm8zfvyIhoSKN5Gyq2u/345rSTUp4u0OhRFHn5a9m3UB99wV5cR0VpV+gb3YB7SF//GHehsv4+mZdJ7IKWFDK5/eFPFaFg7utm01VQggsPDWxqSvWy9AtVYNrsIiL/FKSFAGRjIMQsCLNFt5J+bf6IxWVPoheVKE3Nw7lV6Eog+fcWwkyVbHBgVpoWnfAIIxbKbXwLaRXxCLHO7se8bMfr8ssQ2R3jtt+SKd/X8tyboKuyNvUDWB9JLPf1dSokCex8Sv7mdURfU0yHHpzkha291i4Ar9UWPK3Nnlwzq4sPpWKl0HslWDp6lKI8wwypaG2zMc016CY8L6ZFR/NIP3QF2dNJg0DaNIn2epRYF8SDk0Q/YfmTMx8dN5sZdQtzshLkQtqJjxw23C+89DPZoHSsy4Chkm+9jDTSp1sSnhrBoua8fBa7Y/trp814a7Q==;5:7CJAkMHXWeV0O11zJs3HF1XHmNNZS6zi8Wn3VdMjT5MeHXYhFp3IHgwy5OFZvVQUP2G8UMagSL8e5v51iwUUhmDdmkVJX4MELW2qaIKJN+Cnpv5Zb6gRIdkCGvNaaSkWzNEjVjR6sQAaC3m0p43OSDbiYL+hYXEjHqCj6lHT1Wk=;7:coM0ngyrkkRi6LKLjN/dn9nuV6hmGXaoYt7FIQNfCH7vEEmbxETBFfXoNjK0zAwpLY7KTWDNKwQUEcHOctRsRen2TQ5j4kAeVU1ycEcXyUfXYb4NcarElv/QHmhs9aThkd07nreyZmitQIb2GFS3YWK6kjWFdJAMgSkqfH3fpvZrC2HslCY6A25tTEHNq1hMEAKvaJZ2o/l6SryHMd1CAFDg7HbG1K41yc5J7G4U4wR8gnFrtFgNnzm6l8bGU1bE
x-ms-office365-filtering-correlation-id: 95749527-ba78-46d0-ca63-08d61c4a8cfd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0742;
x-ms-traffictypediagnostic: CY4PR21MB0742:
x-microsoft-antispam-prvs: <CY4PR21MB07429CE8BCFA59B7AA9FF8C0FB1E0@CY4PR21MB0742.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0742;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0742;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(366004)(396003)(376002)(199004)(189003)(6486002)(6436002)(6512007)(53936002)(4326008)(3846002)(39060400002)(217873002)(25786009)(2616005)(1076002)(6506007)(186003)(6346003)(11346002)(446003)(26005)(2900100001)(6116002)(486006)(102836004)(256004)(107886003)(476003)(86612001)(575784001)(86362001)(2501003)(14454004)(97736004)(66066001)(76176011)(6666003)(316002)(54906003)(110136005)(99286004)(68736007)(10090500001)(22452003)(81156014)(2906002)(36756003)(8676002)(8936002)(81166006)(7736002)(305945005)(105586002)(5660300001)(106356001)(10290500003)(478600001)(72206003)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0742;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: BqmUFL0M5nNKR7qBnnuADmOxtDZjbmKJp5k/k0snwTCqexGoylCdVSmYGPEDbQoft8tAkwYrBS+RsDfJPROt2A/f6ao5N0MtyROOy5Shpk3ynNXGSI0htw3n4O9pse7xTA2/Mh0VU+0FKlZUhKuJ0HmCBjoEZeA+b8RFIwdB7qgLnGEYfFdxUMqMd9TSceCo+8uI+PQ2VdjY5YYVbFHAWpqgTiu8UTNk0u1KNTJPORHy9cMkmetzsvN3EG/zQatapffY9D8eZz6VBqmnt2Q5iRoayMNN0XrkZTv6e5zWCH+PTT8yinBu7UtglAIHmB4NMDVhjsr/Et8eoL+/npZgBd5Dxdo5Tlif+JldWrJwHLU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95749527-ba78-46d0-ca63-08d61c4a8cfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:12.8052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0742
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

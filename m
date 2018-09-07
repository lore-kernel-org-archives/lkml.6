Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC02C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A1720844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="o7PxuOX7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A1720844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbeIGFdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:33:50 -0400
Received: from mail-bl2nam02on0092.outbound.protection.outlook.com ([104.47.38.92]:43727
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729543AbeIGFPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bq4S5A6zhZ7pXXXJMvAV7aZeAAs7BUfAVuMo3kxluIs=;
 b=o7PxuOX7FqHpz3m+7uXWWhFXKiY/fvbRp20OUi6M6rwXIoW2FcMdoNW19CtKm/uMbMqpVsiVdvqbKeynM3iGkg1Le4OUaUwTif/HQcXLbojVhFs5i3Kb6OizChFQZkLU7wap3sJKx/mhM5udoL+rc4SzKQ0k+t9EyRCkVjrrpPA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:36:56 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:56 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 52/88] nvmet: fix file discard return status
Thread-Topic: [PATCH AUTOSEL 4.18 52/88] nvmet: fix file discard return status
Thread-Index: AQHURkLSqV3wDXjapkypkC0KH7YaHg==
Date:   Fri, 7 Sep 2018 00:36:30 +0000
Message-ID: <20180907003547.57567-52-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:/AmJ7D3/KszV2Mh3VJpXwIrSgbQUPhbdVmn/dCOQH3euMeLG+7JMUJI96yV5Lo62fC2BeF80kCm7DlNMKuOTDFTPELrDpEe0e8Ee+fVGVTI0XsWBhpoWPuxcif2dXTNXBJzuMdlgiG95kusgP5h8Jag6oLM9+yP/wl33UozK4fuq4x1ssA6nMwFg4CZbnGixBgAZriIJA5QMcYvu7c+XJ4vxSSVG27smYQrnwIPhAsWqoedINZAyhf6FE0zYUmQyRqy778W6Unxg4cb9Wmkxi53Oo1QCubm6ELlYJHQNUsu143uv4bn+/MAhA9NQUz5JNJZVNsF/UK04WQYS8JRqyz5Z/gd4hrLaGg+UWJ+8wkxAx5YpVD/bCkeF/KxaAs5EG4Dh4dU/QtZadw5RU0WIbtzE2lHr1YXeXWUj9qgwV3n8LTwpUYSXpuIiRCAQMwqbkAiNTmOZhF3LJXtm4rRYfw==;5:N0+qncSdYMkjzBETFfVcg4+qaPExGlVJbN80neiaQoeULJOYbcqNMtdedn0lsNoxO/6WEjVxhnbGs9YtyKOplJllpLuTuOI35auma3Dot3uzB4UW3cq1+jQ/G9CqRC9toypWwTITuxTuAaGsM3J7rFMkIxjrFzE3P+w7oL6AAH4=;7:3gwpGFtjp9KPxRoXo1UcMHs5ZZXFiPJi7DDyqOEVdfqnFDJGJBGyXCTzQYMSyunaqe8WAFvDAeU7fAP0nppHzLk1uW4gH+EGTraxAq12bDc6sOwJC3nRf161jJuZL50STG+Mi1hMqqrKaOSmC9JEj/oKKLcTnePAvgvzgwv1/MVRZbFjqkKz1nrIQ98IMPdcbeS9Mp2hmpeJpIisvZk2ZWZexnngKxmL2H9Q5Fq389Iq7K/GBXeZmet0QU8Z+DMC
x-ms-office365-filtering-correlation-id: ada193e9-986c-4fda-da7c-08d6145a03af
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0773896185A522A886920771FB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(2616005)(476003)(4326008)(6666003)(11346002)(5250100002)(107886003)(2501003)(86612001)(97736004)(6512007)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(14454004)(1076002)(66066001)(26005)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IFuMCESz8dQIQxye+0xbLRctXYIFOEQUGyHmrgGOz5Kl1u4i9qFEv93NUz6mKKSMyw7GKDMVpsj8OvJphFAuv5oCVSJ2fUh/Y6k/IZpZdImMkdrCr/82uek8byn6Z7uWQTHWQmo4i8mkqmup4rWcG+Ti2/meCJ1wm+S8eFgcKEw03nZig5bdSibM4ejxHNFhVeeBG2eaC3HxGlPVV1mmQcrpKNIUWHutYLfQcAYJw1Y4L+jso7DTwuCfIqYj78clBTtfhrUPYZPLlPkEmpCmLF/Fo7pGPn/DY3FLH/9IB8Z1T5JZucVK9Fw/pYCvYXOg/2lu0fr8MVXedG8fKZkKag6GZrSgIvHQPbpyXaoJT2A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ada193e9-986c-4fda-da7c-08d6145a03af
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:30.6545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 1b72b71faccee986e2128a271125177dfe91f7b7 ]

If nvmet_copy_from_sgl failed, we falsly return successful
completion status.

Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/nvme/target/io-cmd-file.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd=
-file.c
index 8c42b3a8c420..64c7596a46a1 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -209,22 +209,24 @@ static void nvmet_file_execute_discard(struct nvmet_r=
eq *req)
 {
 	int mode =3D FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
 	struct nvme_dsm_range range;
-	loff_t offset;
-	loff_t len;
-	int i, ret;
+	loff_t offset, len;
+	u16 ret;
+	int i;
=20
 	for (i =3D 0; i <=3D le32_to_cpu(req->cmd->dsm.nr); i++) {
-		if (nvmet_copy_from_sgl(req, i * sizeof(range), &range,
-					sizeof(range)))
+		ret =3D nvmet_copy_from_sgl(req, i * sizeof(range), &range,
+					sizeof(range));
+		if (ret)
 			break;
 		offset =3D le64_to_cpu(range.slba) << req->ns->blksize_shift;
 		len =3D le32_to_cpu(range.nlb) << req->ns->blksize_shift;
-		ret =3D vfs_fallocate(req->ns->file, mode, offset, len);
-		if (ret)
+		if (vfs_fallocate(req->ns->file, mode, offset, len)) {
+			ret =3D NVME_SC_INTERNAL | NVME_SC_DNR;
 			break;
+		}
 	}
=20
-	nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL | NVME_SC_DNR : 0);
+	nvmet_req_complete(req, ret);
 }
=20
 static void nvmet_file_dsm_work(struct work_struct *w)
--=20
2.17.1

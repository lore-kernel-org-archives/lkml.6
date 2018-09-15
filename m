Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91885ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ABC620866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GpQkBnAI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ABC620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbeIOHDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:03:43 -0400
Received: from mail-eopbgr730136.outbound.protection.outlook.com ([40.107.73.136]:54496
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728861AbeIOGsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilC4aryC57WrTsKlTajactUJ+9UL5+VBBuKacNrA55Q=;
 b=GpQkBnAI3dZJQ8T7jx1x7SeiIX/2CdjLR2o0IdK0oUjJE01FkEb2gx0c+90VOyNx0R3Jtvkt1Dan/CE2dJ0M/peaUfzdrORNhEI35WO2EKDHGhs8NEu9Kg10Dmi0NGx6GcFxX9BTipYw7T5IF49ZFD0LVbzWMiF3UXzKFdkK8tk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:31:35 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:31:35 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 73/92] scsi: lpfc: Fix panic if driver unloaded
 when port is offline
Thread-Topic: [PATCH AUTOSEL 4.18 73/92] scsi: lpfc: Fix panic if driver
 unloaded when port is offline
Thread-Index: AQHUTJO2h2qDrYdr0UyK3RuQzvqo+g==
Date:   Sat, 15 Sep 2018 01:30:40 +0000
Message-ID: <20180915012944.179481-72-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:59KfqF7D/u7pbQfcOPciooTHKzJiliL/F0CSOEF43WehW7UNiMZMP90JuG6nM8Qk06nptf44MkQL0VDVyW9DyNgowfIs4jhTAyoKADdc9kyTQ8wy1cMR6T7CGsCXCOBCWHTN1u/MgkyUNESghNLZwls9z7+3uXEt8JygGAAJRXAvDZMTQWtLAe1ZFj1ttTF8qchQXig1Wiyan8X4UaGOyUOP78o/MAyL039kpII64CPrCmKeccBe205pqubhPg9CzByB5tmSAmi/qz6bErhdf/iTrtMTDqgX16sKvu3lyGatuPxz/IuI+L+XqfhmouU/uG+kfELIVseZaSSA1DaoSA0MwuW4OUVgtZeaR7RqidaSup8UuLf1upxh+1Iomg+SMncHiQexxZli+zvVBg+eQGLY0dJcQjmIDQPpfG86cfSK8HbMWYq+2z+CpWvKjG1z5OXFynN6tVG/WEvpwdYoKw==;5:T6JUEf7capXsvDHKsrXWfpfjVrScSBSMqfOnuy1b9RZpSGYzW4nSNRLaEZTosiCYxwHy5oa6uvY1UKzHHt3R3k8CbcrNJq5SkACx/xXqh33HR+oDDC6Zhyaq7SkVx3bA5J4BL8epMS3zD6Q3yfAfdFCzwXisiaQdGuKGqgEVjao=;7:Q4sn/Ka6bfLwrYZx4WA/Ozxz/1jHmKeYkEd1zv6NzHzmqqPZUzKg38PsojbBq+Nprt82OPHCQ9fLtXB85wZduVc84pNWy7PR3WaPXIdmFPTPPVC8ftN6OOXDtgLDClUpB8YoJ7LggSFPX0DUY5T/ZKLhgkBt5+Hp6iFpj/UrxV0WXmnEsj3MXyqtnhU1W82CioSEs+ouPg9ejg5bTx5UzUwdrn2CnVhGFOQA/tdZJAl6DdPZ7Tx/7M7Bbop/o1TX
x-ms-office365-filtering-correlation-id: fb140204-1736-4d95-46d8-08d61aaaf9b6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
x-microsoft-antispam-prvs: <CY4PR21MB0470381C4B8D2142BC6CD20EFB180@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(208715162771679)(28532068793085)(89211679590171)(85827821059158)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(14444005)(6506007)(2501003)(2906002)(6486002)(6436002)(5250100002)(99286004)(486006)(14454004)(81156014)(26005)(81166006)(8936002)(6346003)(102836004)(8676002)(186003)(2616005)(476003)(446003)(10290500003)(11346002)(97736004)(478600001)(72206003)(10090500001)(6666003)(105586002)(217873002)(36756003)(106356001)(22452003)(316002)(256004)(5660300001)(54906003)(110136005)(3846002)(6116002)(25786009)(66066001)(107886003)(4326008)(86362001)(2900100001)(39060400002)(68736007)(6512007)(53936002)(86612001)(76176011)(1076002)(305945005)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: jmdjhC1c96wurzbxkBXHlLA78Y8gRgqp7rb0OzbmOTqj7dMrObQ1KXv/oAOmitzOfoXJ4gfKWa/r4UZcL/4Jns2CuWe4Z9yCp4+ICuBLR3LuSWioyOXviWhdrW6PinIH2FwGSebTEYYlmzjecob80myMRENUjGzWYTypLq8U1aPKCxA7ZPVoW1KCk3QRP3eNak1jD+hD35jLm1+lslNdO5yg3kmdsyIPMcDcE412ex5EJa/zRs+hChBaJmhnP59CgSIljTDtR77VYQ14+8J3SvOLcLk0Jn0Jhv3CKJviMxsZEfZrVUQ2VRD/w8+4Ceid2pXLy/QXISYaoktHlm02OeZczATvlr6n//h6PYhpyZA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb140204-1736-4d95-46d8-08d61aaaf9b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:40.8542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit d580c6137476ab307a66e278cf7dbc666230f714 ]

System crashes when the lpfc module is unloaded after making the port
offline

The nvme queue pointers were freed during port offline, but were later
accessed in pci remove path.

Validate the pointers in pci remove path before accessing them.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/lpfc/lpfc_nvme.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index 76a5a99605aa..ada5a2aaee82 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -2970,7 +2970,7 @@ lpfc_nvme_wait_for_io_drain(struct lpfc_hba *phba)
 	struct lpfc_sli_ring  *pring;
 	u32 i, wait_cnt =3D 0;
=20
-	if (phba->sli_rev < LPFC_SLI_REV4)
+	if (phba->sli_rev < LPFC_SLI_REV4 || !phba->sli4_hba.nvme_wq)
 		return;
=20
 	/* Cycle through all NVME rings and make sure all outstanding
@@ -2979,6 +2979,9 @@ lpfc_nvme_wait_for_io_drain(struct lpfc_hba *phba)
 	for (i =3D 0; i < phba->cfg_nvme_io_channel; i++) {
 		pring =3D phba->sli4_hba.nvme_wq[i]->pring;
=20
+		if (!pring)
+			continue;
+
 		/* Retrieve everything on the txcmplq */
 		while (!list_empty(&pring->txcmplq)) {
 			msleep(LPFC_XRI_EXCH_BUSY_WAIT_T1);
--=20
2.17.1

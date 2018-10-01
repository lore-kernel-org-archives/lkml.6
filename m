Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC94C64EB0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFA42083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FlYtjRfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DFA42083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbeJAHYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:24:04 -0400
Received: from mail-by2nam03on0120.outbound.protection.outlook.com ([104.47.42.120]:46043
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726604AbeJAHOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/INsS4RAGOgH2prUhoDcsMS33Oa/6QbmKj0m5EIWywU=;
 b=FlYtjRfhvIUzhG+63m64agxS+XfwWYoyeNS0/ZoFdCx0tvgWo3h/KJXxItPT3S3beB56212aYQ7bDhcA+ng6aF2DgeFwyDe+ldklCvpyNVyLkruJVmPbl2tYCCqauj3TFAqh9QmNDV0DvqpSAv84fsj/7eT3FywfjBDZAhVkq7U=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0696.namprd21.prod.outlook.com (10.175.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.6; Mon, 1 Oct 2018 00:39:40 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:40 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nilesh Javali <nilesh.javali@cavium.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 07/37] scsi: qedi: Add the CRC size within iSCSI
 NVM image
Thread-Topic: [PATCH AUTOSEL 4.14 07/37] scsi: qedi: Add the CRC size within
 iSCSI NVM image
Thread-Index: AQHUWR8jg5giDxA1x0SMHxRMvsDwQw==
Date:   Mon, 1 Oct 2018 00:38:57 +0000
Message-ID: <20181001003850.147107-7-alexander.levin@microsoft.com>
References: <20181001003850.147107-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003850.147107-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0696;6:wmIC7uE1uvCwWxFke9HCBBpuYJqSXReKqz1G7vI4ERjMMMziYvTJz42kVhOCRGFH+vNKvA15vR4npkejssx2X2CsF0NVDl84fH7yPsrEG7SzEenIjpiWWCJ5paRwOmSEJRSzPRWxCxNuDkNgm2yBx/CHyCZ+iZ56e9JSdTjNe9dg7gEfx3KOueG6QCSjwKGhyt+wAl0sEuGh8NlkYAIPcwn9xG2j1ymm4NQ0f4oQC1bp1ze9a+/MihkDgZ5xOgeSky6pHMsuoCmTrJ2yzQjPVVmKfeuEQj0aIExDbhW6WEWsR2Ca4e6+6UFutuGXJWLobpEfjgUzuNkH+wrcDRqhmgw8cMwC4ABiehNUJsBvRfMVwMa5ftdZw19pOR8bXPhZCsVVMehw8TCN9ilwWEnH1mjh0FvCoCQrNqU2/vR9/L98MrDRjCyme2YH1Y/1zFYdX+FT6ScRFP12rXtFZoH+5g==;5:6EPBtan7cVblsqC4k3+WNzQniuG7JYVba0M3ZUZi7ci88bW1D6Xi+nSe4jrNuKTdRPK7iox8UiAY9AauxRNHmdplcdp4e0L6+xktA7HIn39KMdFo0whI7ovIVXIYrphzdODBThBRVwHYgZ7LuXQH6k0YN/6w66xqTCdU3XEwrfI=;7:0Y7opV0vBetN6vIkIMnD6um3l2XNCbqzA4Ww6/iYZEHhxTO5MZgBzYhbaTP5FgaS37AYLR9oStAySy278ZS/qJ9c+Pb6CoJ83eKd6HY+kHi/ri7tkeOXDc11SUEqC3vHhjZejYnyhrYmQNYdfitl33MgIm6p1Tt+IbtFHNitfr9acIu+d97TJCwnlVQ8nP7+GTlR8sbMD7OXKJzDJG54SFbSTDrTnyP24jKMa/IzMSZ5nZstsdTN2wpIH0LaV/uJ
x-ms-office365-filtering-correlation-id: 570830ae-5e7d-4cad-4a45-08d627365f6a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0696;
x-ms-traffictypediagnostic: CY4PR21MB0696:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0696591967D7A83B537E8A6FFBEF0@CY4PR21MB0696.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0696;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0696;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(396003)(346002)(136003)(366004)(189003)(199004)(3846002)(6116002)(5250100002)(71200400001)(97736004)(217873002)(71190400001)(1076002)(76176011)(6506007)(99286004)(11346002)(26005)(86362001)(36756003)(2501003)(446003)(2906002)(86612001)(102836004)(2616005)(476003)(14454004)(107886003)(10090500001)(14444005)(4326008)(34290500001)(316002)(486006)(22452003)(256004)(186003)(66066001)(53936002)(305945005)(25786009)(2900100001)(106356001)(6486002)(105586002)(7736002)(6512007)(81156014)(81166006)(6666003)(8936002)(8676002)(5660300001)(68736007)(54906003)(110136005)(6436002)(10290500003)(72206003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0696;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FAmIzSTCJDKRhZF54+V/gzmaH+EMGnqfIJ+KDlIr27ClN7Qqcy6CIZFcYxX6etwvNRRANqAiy+25o/rMiI3Px0Bqy5TobY21sNHSS8KBvftBZqh9edJdP2/EEGdz1faU9f1H01aq2/oog8c6Kj6+TF33STSYXHoJ131AnHokDZcIEqUZ7HoG3w+bHDl92aJKweOiHoVG0T7QaTVeAvY115cl5OEzS1yzcl3hxTf8dukO83VYRzayZyv0IAdgLxK08LxJR0Ab4tt9CpJjkQPO2kida2sOAHQIW4Kq00s86aRkEABeKuaiZcVoEmbnQh5G9yRX1aXzPPzhvgF3GrmNVSgupFgPYnEBYG2F3+iy6Ns=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 570830ae-5e7d-4cad-4a45-08d627365f6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:57.0414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0696
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nilesh Javali <nilesh.javali@cavium.com>

[ Upstream commit c77a2fa3ff8f73d1a485e67e6f81c64823739d59 ]

The QED driver commit, 1ac4329a1cff ("qed: Add configuration information
to register dump and debug data"), removes the CRC length validation
causing nvm_get_image failure while loading qedi driver:

[qed_mcp_get_nvm_image:2700(host_10-0)]Image [0] is too big - 00006008 byte=
s
where only 00006004 are available
[qedi_get_boot_info:2253]:10: Could not get NVM image. ret =3D -12

Hence add and adjust the CRC size to iSCSI NVM image to read boot info at
qedi load time.

Signed-off-by: Nilesh Javali <nilesh.javali@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/qedi/qedi.h      |  7 ++++++-
 drivers/scsi/qedi/qedi_main.c | 28 +++++++++++++++-------------
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/qedi/qedi.h b/drivers/scsi/qedi/qedi.h
index b8b22ce60ecc..95141066c3fa 100644
--- a/drivers/scsi/qedi/qedi.h
+++ b/drivers/scsi/qedi/qedi.h
@@ -77,6 +77,11 @@ enum qedi_nvm_tgts {
 	QEDI_NVM_TGT_SEC,
 };
=20
+struct qedi_nvm_iscsi_image {
+	struct nvm_iscsi_cfg iscsi_cfg;
+	u32 crc;
+};
+
 struct qedi_uio_ctrl {
 	/* meta data */
 	u32 uio_hsi_version;
@@ -294,7 +299,7 @@ struct qedi_ctx {
 	void *bdq_pbl_list;
 	dma_addr_t bdq_pbl_list_dma;
 	u8 bdq_pbl_list_num_entries;
-	struct nvm_iscsi_cfg *iscsi_cfg;
+	struct qedi_nvm_iscsi_image *iscsi_image;
 	dma_addr_t nvm_buf_dma;
 	void __iomem *bdq_primary_prod;
 	void __iomem *bdq_secondary_prod;
diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index e7daadc089fc..24b945b555ba 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -1147,23 +1147,26 @@ static int qedi_setup_int(struct qedi_ctx *qedi)
=20
 static void qedi_free_nvm_iscsi_cfg(struct qedi_ctx *qedi)
 {
-	if (qedi->iscsi_cfg)
+	if (qedi->iscsi_image)
 		dma_free_coherent(&qedi->pdev->dev,
-				  sizeof(struct nvm_iscsi_cfg),
-				  qedi->iscsi_cfg, qedi->nvm_buf_dma);
+				  sizeof(struct qedi_nvm_iscsi_image),
+				  qedi->iscsi_image, qedi->nvm_buf_dma);
 }
=20
 static int qedi_alloc_nvm_iscsi_cfg(struct qedi_ctx *qedi)
 {
-	qedi->iscsi_cfg =3D dma_zalloc_coherent(&qedi->pdev->dev,
-					     sizeof(struct nvm_iscsi_cfg),
-					     &qedi->nvm_buf_dma, GFP_KERNEL);
-	if (!qedi->iscsi_cfg) {
+	struct qedi_nvm_iscsi_image nvm_image;
+
+	qedi->iscsi_image =3D dma_zalloc_coherent(&qedi->pdev->dev,
+						sizeof(nvm_image),
+						&qedi->nvm_buf_dma,
+						GFP_KERNEL);
+	if (!qedi->iscsi_image) {
 		QEDI_ERR(&qedi->dbg_ctx, "Could not allocate NVM BUF.\n");
 		return -ENOMEM;
 	}
 	QEDI_INFO(&qedi->dbg_ctx, QEDI_LOG_INFO,
-		  "NVM BUF addr=3D0x%p dma=3D0x%llx.\n", qedi->iscsi_cfg,
+		  "NVM BUF addr=3D0x%p dma=3D0x%llx.\n", qedi->iscsi_image,
 		  qedi->nvm_buf_dma);
=20
 	return 0;
@@ -1716,7 +1719,7 @@ qedi_get_nvram_block(struct qedi_ctx *qedi)
 	struct nvm_iscsi_block *block;
=20
 	pf =3D qedi->dev_info.common.abs_pf_id;
-	block =3D &qedi->iscsi_cfg->block[0];
+	block =3D &qedi->iscsi_image->iscsi_cfg.block[0];
 	for (i =3D 0; i < NUM_OF_ISCSI_PF_SUPPORTED; i++, block++) {
 		flags =3D ((block->id) & NVM_ISCSI_CFG_BLK_CTRL_FLAG_MASK) >>
 			NVM_ISCSI_CFG_BLK_CTRL_FLAG_OFFSET;
@@ -2008,15 +2011,14 @@ static void qedi_boot_release(void *data)
 static int qedi_get_boot_info(struct qedi_ctx *qedi)
 {
 	int ret =3D 1;
-	u16 len;
-
-	len =3D sizeof(struct nvm_iscsi_cfg);
+	struct qedi_nvm_iscsi_image nvm_image;
=20
 	QEDI_INFO(&qedi->dbg_ctx, QEDI_LOG_INFO,
 		  "Get NVM iSCSI CFG image\n");
 	ret =3D qedi_ops->common->nvm_get_image(qedi->cdev,
 					      QED_NVM_IMAGE_ISCSI_CFG,
-					      (char *)qedi->iscsi_cfg, len);
+					      (char *)qedi->iscsi_image,
+					      sizeof(nvm_image));
 	if (ret)
 		QEDI_ERR(&qedi->dbg_ctx,
 			 "Could not get NVM image. ret =3D %d\n", ret);
--=20
2.17.1

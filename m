Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06272C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34D3208B3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="eyY2g3In"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34D3208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbeJAHNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:13:24 -0400
Received: from mail-eopbgr700117.outbound.protection.outlook.com ([40.107.70.117]:52496
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728617AbeJAHNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fek8gkwNg41XiNsBaoLDQF+0qglnaBkR4iyfcJEmr1A=;
 b=eyY2g3InZ6YOuNQKgCZQ+9BlMWy5peOHB3EtKWJ3K+vwis+BKdFSQExOE2VNwMQ8zZu1y9VJHD4rZMap9ccpLzuemb6hmSkrTwEBh6UbzUpfxBA/xlX2k+VVlz34PCkNSdmf1dfxSQseBss+FMfenIo73QohhoscQdC/75Lofog=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:38:08 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:08 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nilesh Javali <nilesh.javali@cavium.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 10/65] scsi: qedi: Add the CRC size within iSCSI
 NVM image
Thread-Topic: [PATCH AUTOSEL 4.18 10/65] scsi: qedi: Add the CRC size within
 iSCSI NVM image
Thread-Index: AQHUWR8Gak5WRCY1KUWMgPOVcT13mw==
Date:   Mon, 1 Oct 2018 00:38:08 +0000
Message-ID: <20181001003754.146961-10-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:AxrXoaCewWlh+ropY/ywBqKmPicy4tONm5x2QR0sOKaZOsx0uAmapwkw6V1QVgeUeAs8iJ3JdjbMvvtUQivHZ3gAHE8HaoIS+xxZniDJZ3XJWMPodHp7iOvzfAqmNJDZ5GTWHiynOzmtx75YDLKxmmIC00RFRGL147LnoCTFE7qzsR7o4zu4vSxGHFEXTLTQaNVOxj7nN1c72utmTDUElPRJ74Ck8dzjAaj0ROEhQbmnP+8iTk2MlgGcA0tqJGg/Od4S7fnxeuzwUK2q62DT+FwK42n0LfDnsQRiYa/XFFOT/nHeKSriVmeWh4etnWe+UPl/hjvut+NcxAqn+68c6pLuPKdGBqy3uFPLwm1N/CzNqWy5iCAGtxyz3/q79HHwfdP7d9aN8hTYoV0r8ZzOMZsC16SXQ017Cy2PvhIctG1+uOZy7uSt5c/cikdx6LewxFhGstO0ihPHAYx5qoy6MQ==;5:jIWqj//qnG3uaZxUzrMsD3HtoVBTLIq4P/QH/lyLFqF5Y0bopQNVZiHZtC+3dnol0bxg8KrcbJyA5CnmFkzfY4xLJiCS/hMS1nIyAurRqmzumn/G4kxmtEAYi33f9bfTrrwFThBLcGAW3B2zvZSoCrXPZdDDrhsDoHnrFUbB2i0=;7:PbnOlwbQl09YV2B0q9VTvuGFv1dvuZ993BOWAuFvgPcfu7/ASeLvY35bsZHoCQIn/EggQdJgBWxER8YRDzj5SHlYdMitvntZ+iw8q/KwYD9wOI4D+WOuoYNGCk+0+WroIZjFjLhNpfZnjpPoAvenhsaBg28DHFJoVrfS2sEwBCF+5tVIBqgZ4KleqBf2EEE19SZ5EZKvTTCjzGyR8FLakR6I2P9/L/8oqBDMN5zTcmx8d1l7kcLNTuLDPRQNWsuB
x-ms-office365-filtering-correlation-id: 8d9e8d2b-015b-4829-711f-08d6273628ec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0469D01ED7F28940C3BB0209FBEF0@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39860400002)(366004)(136003)(199004)(189003)(5250100002)(106356001)(81166006)(14454004)(10290500003)(316002)(54906003)(22452003)(110136005)(25786009)(305945005)(2501003)(217873002)(256004)(72206003)(68736007)(14444005)(478600001)(34290500001)(6506007)(2906002)(7736002)(86612001)(1076002)(86362001)(4326008)(99286004)(97736004)(3846002)(6116002)(76176011)(8936002)(81156014)(105586002)(8676002)(71200400001)(5660300001)(71190400001)(10090500001)(36756003)(6512007)(107886003)(2900100001)(102836004)(6486002)(6436002)(53936002)(11346002)(446003)(26005)(66066001)(2616005)(476003)(486006)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: z9Q4ymkKD4eIT3ynISXrZ3aJP8b6FGryee+Ht6eJb+DxH8+WDuHEAIV51Tbv7vZudyZg0bq03RaqBRqbEOc/+cGPFW4clMx9RqufpKudp2alWj+F1Gv09NzjA8mLdjSloV8zJA9GgTXVpivY9+ljWMGFimlxtQl6IajujJVI2b3gdLpMWEVEyKbapWOVY/hgXBXoEBDegAL3s7GXospZtFNqafbmqYmw5GRqJrwYlPCbwmUoZYVI9lu603BJYaheTuy92cD0zbNi/1vAsCd57kjN0ivalOf+rG28U5XiqLcWL5aw/wlju1TRbromdsN67b2wshcdcn4at4bmRNnfzIoS19yx0FCRoeheD+nOZ+k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d9e8d2b-015b-4829-711f-08d6273628ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:08.6934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
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
index fc3babc15fa3..a6f96b35e971 100644
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
index cff83b9457f7..3e18a68c2b03 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -1346,23 +1346,26 @@ static int qedi_setup_int(struct qedi_ctx *qedi)
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
@@ -1905,7 +1908,7 @@ qedi_get_nvram_block(struct qedi_ctx *qedi)
 	struct nvm_iscsi_block *block;
=20
 	pf =3D qedi->dev_info.common.abs_pf_id;
-	block =3D &qedi->iscsi_cfg->block[0];
+	block =3D &qedi->iscsi_image->iscsi_cfg.block[0];
 	for (i =3D 0; i < NUM_OF_ISCSI_PF_SUPPORTED; i++, block++) {
 		flags =3D ((block->id) & NVM_ISCSI_CFG_BLK_CTRL_FLAG_MASK) >>
 			NVM_ISCSI_CFG_BLK_CTRL_FLAG_OFFSET;
@@ -2194,15 +2197,14 @@ static void qedi_boot_release(void *data)
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

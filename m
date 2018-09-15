Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE25ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9A8208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="lQ1xzXMN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9A8208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbeIOGsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:48:50 -0400
Received: from mail-eopbgr720090.outbound.protection.outlook.com ([40.107.72.90]:59680
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728325AbeIOGss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBsfdmsKD1TXJVsfrLPwYt4mskohWYJG6/XhN+5qNm4=;
 b=lQ1xzXMNnzvOuJhl3MEO2ITu28NSIQyMEHO1bWR03I6sI9QpMIIBpi0ddm/RzmHCTlbB6C9PinGELIPM5bB6K41KvSziMUUNdBEzvkojv/0c+R11fQDWXUlqlt8rqsndUT3CKU5Z33BvkByQI/cjik3EI2OafK0a6vfBaMCX4ms=
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
Subject: [PATCH AUTOSEL 4.18 72/92] scsi: lpfc: Fix NVME Target crash in defer
 rcv logic
Thread-Topic: [PATCH AUTOSEL 4.18 72/92] scsi: lpfc: Fix NVME Target crash in
 defer rcv logic
Thread-Index: AQHUTJO2aIzChwerG0iolxgnFq7pYg==
Date:   Sat, 15 Sep 2018 01:30:40 +0000
Message-ID: <20180915012944.179481-71-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:B7o3gbLYTkDc2YEw2RxaypKorYWokDqNckLWFPFNBSnflRo61VwX/Stdgeb5plSmRWSSjlTkPoIg3QuO1M39kPqWIFI55OmkPi9blE5pZkm5B0BAMvCzWczTYNRWaXK+xm7dMGm1nnJG8QHc0gAMpi/iL8PG3jVd2u9bXm2K5PFFZl+P/4H2u59zr8yinQRc5fC9CyJ+aiRaeWaztEzGi9ELy59hw3aY7/YWFvji1tbznuKiQxz86/asW55uhZ6DsNM9jr+2DNw1nJo6f68Ffl8o8id8kFx1R1mW8TvieOQlQw0CA7mBiXBuFd8SD3i9qEPB/i6boG8ZgJEwdczmc13b0zbEJBhHSNySBaBV6kcojGnKxcyXE4VbfsDamR3b50zyIbQwO22Fu8gqVRoUkMCJFKL1SagHsgee248xvEPVEy7tpi5vYCw19NRmd+sKYgkirLpJhiOIkLb4svUy7A==;5:fKEC5gzAvZZZdiLBZZwjQWLNsCKT6GQQwKjCCH6B6nZFSKfWPLmVm7eY8QpiR7D8hq9sVW1yPqd48V/muVmaPxaPbk6LmUU6QSgoue+wJrA0VobBgjqAs3dWhZ5ULgXlTNA1d5oobC/NFRYCdfPh3JotPC8cRTZ2Wh2J1vPITgQ=;7:QuaL60YIVg2duQ2K0DZSn46s0Gt/E2RPyN2zBrOrexQhbWjLhDKXjLYV0aURHn/D4lIccTyLzm1Rhh/pC9t/ygkHZSXVEJ/ycojUjNNmntH1UjqhwKBg3+OzHM9hZ+hLNbWeYSNDowoVaoF6dqBaBRDq44XUzlQ5NkvkU4X6RJ6xelb3WKI6sA1HpxuVtSxHJYwknkPeWUeNAYHQPCbipipTCK+B0i+qayjZnntWNAhtugJhlRHJsGZKn5CQGVfZ
x-ms-office365-filtering-correlation-id: 2f27ea34-4b7b-4c6e-994d-08d61aaaf967
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
x-microsoft-antispam-prvs: <CY4PR21MB0470D7AF22EB16D79CEEA08FFB180@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(208715162771679)(28532068793085)(89211679590171)(85827821059158)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(14444005)(6506007)(2501003)(2906002)(6486002)(6436002)(5250100002)(99286004)(486006)(14454004)(81156014)(26005)(81166006)(8936002)(6346003)(102836004)(8676002)(186003)(2616005)(476003)(446003)(10290500003)(11346002)(97736004)(478600001)(72206003)(10090500001)(6666003)(105586002)(217873002)(36756003)(106356001)(22452003)(316002)(256004)(5660300001)(54906003)(110136005)(3846002)(6116002)(25786009)(66066001)(107886003)(4326008)(86362001)(2900100001)(39060400002)(68736007)(6512007)(53936002)(86612001)(76176011)(1076002)(305945005)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: WS87ocd/Gr3LBBJD/LdfqDBpcBYH61aMsAqjBlAZmG0Bto0BU7b7lVAD/VDSfQNSSJQWLfPKT5CREZB5MgZV1iPXsDIg1pD5S3s65h5O8FrdVdxWC+3MCBJkdPN43ffkCDsuvLmDgGYTJPxup/Oyj5OtUpJszPNdIEDDuWT3rh5BhpXJuvfzH7lLPYAp+w7yA91DeXhsYE+QW5QZ4ysxdQgBdIGZ2WFiyqNagLICbAFJTBgGrGS/Z1Y0RPo3ssnYxTLdw60paMZ6FW+aBVN033HBo8nJ/Rg30iPAn5Jei0+OB8cmSzh5ql6oum+vpi0pG38CazLLujK8gWe1wlfYwq5DlflFK41gQwaJmlXaZxk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f27ea34-4b7b-4c6e-994d-08d61aaaf967
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:40.2136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 6871e8144f935a1f08e7fc6269c894861ce494aa ]

Kernel occasionally crashed with the following
ops on NVME Target:
  BUG: unable to handle kernel NULL pointer dereference at 0000000000000058
  IP: [<ffffffffa042ee50>] lpfc_nvmet_defer_rcv+0x50/0x70 [lpfc]

Callback routine was called for deferred rcv when it should be treated as a
normal rcv.

Added code in callback routine to detect this condition and log a message,
then bail.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/lpfc/lpfc_nvmet.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.=
c
index 7271c9d885dd..5e5ec3363b44 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -402,6 +402,7 @@ lpfc_nvmet_ctxbuf_post(struct lpfc_hba *phba, struct lp=
fc_nvmet_ctxbuf *ctx_buf)
=20
 		/* Process FCP command */
 		if (rc =3D=3D 0) {
+			ctxp->rqb_buffer =3D NULL;
 			atomic_inc(&tgtp->rcv_fcp_cmd_out);
 			nvmebuf->hrq->rqbp->rqb_free_buffer(phba, nvmebuf);
 			return;
@@ -1116,8 +1117,17 @@ lpfc_nvmet_defer_rcv(struct nvmet_fc_target_port *tg=
tport,
 	lpfc_nvmeio_data(phba, "NVMET DEFERRCV: xri x%x sz %d CPU %02x\n",
 			 ctxp->oxid, ctxp->size, smp_processor_id());
=20
+	if (!nvmebuf) {
+		lpfc_printf_log(phba, KERN_INFO, LOG_NVME_IOERR,
+				"6425 Defer rcv: no buffer xri x%x: "
+				"flg %x ste %x\n",
+				ctxp->oxid, ctxp->flag, ctxp->state);
+		return;
+	}
+
 	tgtp =3D phba->targetport->private;
-	atomic_inc(&tgtp->rcv_fcp_cmd_defer);
+	if (tgtp)
+		atomic_inc(&tgtp->rcv_fcp_cmd_defer);
=20
 	/* Free the nvmebuf since a new buffer already replaced it */
 	nvmebuf->hrq->rqbp->rqb_free_buffer(phba, nvmebuf);
--=20
2.17.1

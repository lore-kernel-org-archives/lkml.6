Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131BAC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD59B21521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XoPh1apk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD59B21521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388245AbeITIaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:30:23 -0400
Received: from mail-bl2nam02on0106.outbound.protection.outlook.com ([104.47.38.106]:44649
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387611AbeITIaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzLWX96NFlruEA/xGoJh33YXIf+r6R8cGEQuadDJnH8=;
 b=XoPh1apknkNT5pLAEG5li/vvIopLDkLfL29wDs+uzAytgLmk/sEnZ8enMitdBTuYHt7+gc54ahWhKS2+1lNsgqY2ZE0SmtFoz/edgLfZGvssTo/OFVEix7cD7VHDndBjKH+Uw7P3uRXAzmqUEHQquCAD5wx1F9oy2wl79tHeuRI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0744.namprd21.prod.outlook.com (10.173.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:49:14 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:49:14 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Srikanth Jampala <Jampala.Srikanth@cavium.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 13/25] crypto: cavium/nitrox - fix for command
 corruption in queue full case with backlog submissions.
Thread-Topic: [PATCH AUTOSEL 4.14 13/25] crypto: cavium/nitrox - fix for
 command corruption in queue full case with backlog submissions.
Thread-Index: AQHUUIxmE6T8XR63qUmhKhxnFRKO9g==
Date:   Thu, 20 Sep 2018 02:48:24 +0000
Message-ID: <20180920024810.58594-13-alexander.levin@microsoft.com>
References: <20180920024810.58594-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024810.58594-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0744;6:mbmYiWsfVxlHyFFOys4ZTaz/MJd1ObHwJBxwEo5isSTDiapG3hI0KpvFb4vBBrVKFkrlZ0FUUjqruk3qoc/sevVBaKmXuLIUuWRPzEDf2rIbbkYwFXQyuQJat+MiZAlNKobbl2F+gwbTxo73FvjaetaRb5IIWDBZzgzMTAKidJ8OPwkP4jIhR3K4VcpAUPzT4Q3oi5PaJTc6Z7CSMd38JCVBynW1M+MWRbL+HAtvIS0Rad8VzP5Dwd/YULmMoYTK/HPizHDxkwNuvJhvdJTUBnKBSXQeM5nWYPzx/1RXfICmUvAubgm46XD8dwmueCgAtnAxW857tqYtNoZhxSvtpg9S/uuv8K+gREbge0joWoB/2GTqBLoIkUHx2kwJjyt5HrteqPC+S35w0CsIqjj+19lArC8i8oMwqBoI6qX+cMHVow6H4BukCjDtdb5LUb3gkH0xs9PJ3u60yl6nnIC8gQ==;5:juYDlJLX49ilTqFLOtF2mniOJ5QfJ5zBmE5HCr1qh+Fh+t9cv8FFK6Z12TEJZO2jJrXtqv9PhrPVeWyZk8CcW8ZpBzrK7iiWI3jpf+CKhZtYSxCzNvGotmubLoIj6dBUnSGhsLBQeRFIXfKIs17hOaGA1GAj/sw2NWCU52BjnBs=;7:fxO5xkeajVy6w8vhjHy7vqQSSJgRpSj4UVC7Zjd4k9SSYJ2daqWGs4f9Elbb6rvN49eMEV0mTM0deOk0yQmZnCIqRb0bLlr6ADecnFie5EhWOfEiQBxUKNvswhJ1TRwiRx6buczlZv554/aL0nEdGqv5NY7VFPaASNJ0n2Aed1wVaNTRWPfOvFGU5aWApSJmP8XyjZY6QBcCZEIcV5hMAyWuUS3d5vzTIKd5inmqbHlQ+XUVCgJGyLCtcX1XXOo1
x-ms-office365-filtering-correlation-id: 7cf4bf3a-c828-4408-bc3f-08d61ea3a698
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0744;
x-ms-traffictypediagnostic: CY4PR21MB0744:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0744B204D1A69664207DF6ACFB130@CY4PR21MB0744.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0744;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0744;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(8936002)(6436002)(10090500001)(110136005)(217873002)(54906003)(6512007)(53936002)(68736007)(5660300001)(14444005)(256004)(6666003)(71190400001)(6486002)(316002)(446003)(11346002)(105586002)(476003)(106356001)(478600001)(2616005)(2906002)(186003)(25786009)(10290500003)(486006)(71200400001)(72206003)(66066001)(4326008)(14454004)(22452003)(36756003)(102836004)(86612001)(97736004)(8676002)(305945005)(7736002)(1076002)(86362001)(575784001)(81156014)(26005)(76176011)(6506007)(5250100002)(107886003)(2900100001)(99286004)(3846002)(2501003)(81166006)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0744;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hPr6PUI+r0K8ZuJiai7G8iV15ajfahFf9C8vVZ+R1JuRgINQEICPvKnzBWjDryDT2it+c3V5V77DR39VM4lRWavUxlFr9FfYZqouugT5jXQXqWh8zQVffPX/Rtk97krSHPNL+V9s5Go/1RG+11BK92soJQp0kXVIx2irLoelhhMSj/nD2BK0GSs+AXQgNoutx3d6NIEA+fWqLOaZGvinCckIxjHKL1FHnrB5LMp5OVDcA++I3wYr58h0DYMu5o3csccNP5+0a1D6sT1Fv2Lv4YJUAx747KnN2kNrLl9rrn3bT05i8Y5SY88aB/8a1TOC2b5v8Gcb0b1sK0Z3WRgDA3adpNKg5ZfC/owENQih0/A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf4bf3a-c828-4408-bc3f-08d61ea3a698
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:24.1946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srikanth Jampala <Jampala.Srikanth@cavium.com>

[ Upstream commit 3d7c82060d1fe65bde4023aac41a0b1bd7718e07 ]

Earlier used to post the current command without checking queue full
     after backlog submissions. So, post the current command only after
     confirming the space in queue after backlog submissions.

     Maintain host write index instead of reading device registers
     to get the next free slot to post the command.

     Return -ENOSPC in queue full case.

Signed-off-by: Srikanth Jampala <Jampala.Srikanth@cavium.com>
Reviewed-by: Gadam Sreerama <sgadam@cavium.com>
Tested-by: Jha, Chandan <Chandan.Jha@cavium.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/crypto/cavium/nitrox/nitrox_dev.h    |  3 +-
 drivers/crypto/cavium/nitrox/nitrox_lib.c    |  1 +
 drivers/crypto/cavium/nitrox/nitrox_reqmgr.c | 57 +++++++++++---------
 3 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_dev.h b/drivers/crypto/cav=
ium/nitrox/nitrox_dev.h
index 9a476bb6d4c7..af596455b420 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_dev.h
+++ b/drivers/crypto/cavium/nitrox/nitrox_dev.h
@@ -35,6 +35,7 @@ struct nitrox_cmdq {
 	/* requests in backlog queues */
 	atomic_t backlog_count;
=20
+	int write_idx;
 	/* command size 32B/64B */
 	u8 instr_size;
 	u8 qno;
@@ -87,7 +88,7 @@ struct nitrox_bh {
 	struct bh_data *slc;
 };
=20
-/* NITROX-5 driver state */
+/* NITROX-V driver state */
 #define NITROX_UCODE_LOADED	0
 #define NITROX_READY		1
=20
diff --git a/drivers/crypto/cavium/nitrox/nitrox_lib.c b/drivers/crypto/cav=
ium/nitrox/nitrox_lib.c
index 4fdc921ba611..9906c0086647 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_lib.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_lib.c
@@ -36,6 +36,7 @@ static int cmdq_common_init(struct nitrox_cmdq *cmdq)
 	cmdq->head =3D PTR_ALIGN(cmdq->head_unaligned, PKT_IN_ALIGN);
 	cmdq->dma =3D PTR_ALIGN(cmdq->dma_unaligned, PKT_IN_ALIGN);
 	cmdq->qsize =3D (qsize + PKT_IN_ALIGN);
+	cmdq->write_idx =3D 0;
=20
 	spin_lock_init(&cmdq->response_lock);
 	spin_lock_init(&cmdq->cmdq_lock);
diff --git a/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c b/drivers/crypto/=
cavium/nitrox/nitrox_reqmgr.c
index 4addc238a6ef..4adf28176a4e 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c
@@ -43,6 +43,16 @@
  *   Invalid flag options in AES-CCM IV.
  */
=20
+static inline int incr_index(int index, int count, int max)
+{
+	if ((index + count) >=3D max)
+		index =3D index + count - max;
+	else
+		index +=3D count;
+
+	return index;
+}
+
 /**
  * dma_free_sglist - unmap and free the sg lists.
  * @ndev: N5 device
@@ -427,30 +437,29 @@ static void post_se_instr(struct nitrox_softreq *sr,
 			  struct nitrox_cmdq *cmdq)
 {
 	struct nitrox_device *ndev =3D sr->ndev;
-	union nps_pkt_in_instr_baoff_dbell pkt_in_baoff_dbell;
-	u64 offset;
+	int idx;
 	u8 *ent;
=20
 	spin_lock_bh(&cmdq->cmdq_lock);
=20
-	/* get the next write offset */
-	offset =3D NPS_PKT_IN_INSTR_BAOFF_DBELLX(cmdq->qno);
-	pkt_in_baoff_dbell.value =3D nitrox_read_csr(ndev, offset);
+	idx =3D cmdq->write_idx;
 	/* copy the instruction */
-	ent =3D cmdq->head + pkt_in_baoff_dbell.s.aoff;
+	ent =3D cmdq->head + (idx * cmdq->instr_size);
 	memcpy(ent, &sr->instr, cmdq->instr_size);
-	/* flush the command queue updates */
-	dma_wmb();
=20
-	sr->tstamp =3D jiffies;
 	atomic_set(&sr->status, REQ_POSTED);
 	response_list_add(sr, cmdq);
+	sr->tstamp =3D jiffies;
+	/* flush the command queue updates */
+	dma_wmb();
=20
 	/* Ring doorbell with count 1 */
 	writeq(1, cmdq->dbell_csr_addr);
 	/* orders the doorbell rings */
 	mmiowb();
=20
+	cmdq->write_idx =3D incr_index(idx, 1, ndev->qlen);
+
 	spin_unlock_bh(&cmdq->cmdq_lock);
 }
=20
@@ -460,6 +469,9 @@ static int post_backlog_cmds(struct nitrox_cmdq *cmdq)
 	struct nitrox_softreq *sr, *tmp;
 	int ret =3D 0;
=20
+	if (!atomic_read(&cmdq->backlog_count))
+		return 0;
+
 	spin_lock_bh(&cmdq->backlog_lock);
=20
 	list_for_each_entry_safe(sr, tmp, &cmdq->backlog_head, backlog) {
@@ -467,7 +479,7 @@ static int post_backlog_cmds(struct nitrox_cmdq *cmdq)
=20
 		/* submit until space available */
 		if (unlikely(cmdq_full(cmdq, ndev->qlen))) {
-			ret =3D -EBUSY;
+			ret =3D -ENOSPC;
 			break;
 		}
 		/* delete from backlog list */
@@ -492,23 +504,20 @@ static int nitrox_enqueue_request(struct nitrox_softr=
eq *sr)
 {
 	struct nitrox_cmdq *cmdq =3D sr->cmdq;
 	struct nitrox_device *ndev =3D sr->ndev;
-	int ret =3D -EBUSY;
+
+	/* try to post backlog requests */
+	post_backlog_cmds(cmdq);
=20
 	if (unlikely(cmdq_full(cmdq, ndev->qlen))) {
 		if (!(sr->flags & CRYPTO_TFM_REQ_MAY_BACKLOG))
-			return -EAGAIN;
-
+			return -ENOSPC;
+		/* add to backlog list */
 		backlog_list_add(sr, cmdq);
-	} else {
-		ret =3D post_backlog_cmds(cmdq);
-		if (ret) {
-			backlog_list_add(sr, cmdq);
-			return ret;
-		}
-		post_se_instr(sr, cmdq);
-		ret =3D -EINPROGRESS;
+		return -EBUSY;
 	}
-	return ret;
+	post_se_instr(sr, cmdq);
+
+	return -EINPROGRESS;
 }
=20
 /**
@@ -625,11 +634,9 @@ int nitrox_process_se_request(struct nitrox_device *nd=
ev,
 	 */
 	sr->instr.fdata[0] =3D *((u64 *)&req->gph);
 	sr->instr.fdata[1] =3D 0;
-	/* flush the soft_req changes before posting the cmd */
-	wmb();
=20
 	ret =3D nitrox_enqueue_request(sr);
-	if (ret =3D=3D -EAGAIN)
+	if (ret =3D=3D -ENOSPC)
 		goto send_fail;
=20
 	return ret;
--=20
2.17.1

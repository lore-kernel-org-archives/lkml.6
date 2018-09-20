Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26380ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 737CE21521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Y+ZeoT2J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 737CE21521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388429AbeITIgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:36:31 -0400
Received: from mail-dm3nam03on0093.outbound.protection.outlook.com ([104.47.41.93]:53376
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388036AbeITI3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QgzMGXrhyBOeu5auYmt9s1cSfiazT5zfMo9E2VMi5E=;
 b=Y+ZeoT2Jl7RWOVsopV8wzPcFtBLa0AqjQLZRHbeEHENEcLy/B+kCs7zEEyKpfMyMBPD4IZeLoy57nq9lVQ4SlQFUMp/fIKfMufb8t+O4mcRXYm7PMSY7gdNIAdsY5AynDaN2EZGqXzeFHbn/r7p3trSi8FsHy+wQ5CPcIcJOXe4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:48:25 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:48:25 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Srikanth Jampala <Jampala.Srikanth@cavium.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 42/56] crypto: cavium/nitrox - fix for command
 corruption in queue full case with backlog submissions.
Thread-Topic: [PATCH AUTOSEL 4.18 42/56] crypto: cavium/nitrox - fix for
 command corruption in queue full case with backlog submissions.
Thread-Index: AQHUUIxVFyGirfnOSkiVVHzGdczBQw==
Date:   Thu, 20 Sep 2018 02:47:56 +0000
Message-ID: <20180920024716.58490-42-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:Qww3S6tghgF2UKgXK4RYY/hjtKIAtdL5X6Q0bDVlghx2ES6NFYngOpex/RhxnXfN97a9Ql7goelDw1QSt6+QYKPoezXKb1jgHicuAHLii0nzsoEaHvVksc7UKXf9gQj/+VQ1cQIj9ClMc1arOtt/TFdJwFsMWE8xvsvzDxXxcjSaiRP/3ZgytvOtXUcd7j8J612oVBC4DoxzTWu/iwCpFLnvhLoK7UZOOf3x4h+yZnnSdxaLU9UHnCE1acMM4U3L0+naL9ZsIHvsweNYf5U8uWWItkuXdXxa67yX5CHrj2HtLiHDNzOnggFG1XcWYBrs3i41F3/zIiUBpQICqjxD+OxXPD1wTnnql+yQdnNGk9Luh9hyK2mcW/bU+R4vGJrUeqNNGd6CkgQoNUasCx/yt2BRmw0/BH4cIl0EHOgY4mLXBCx57f3LGV437ok7OqWMWrQA+OZJ5uNwULbnc8FjEw==;5:26Fx/nX/IyPMaKRiCIuIMCHyvqsuPxxMqh/ow95R+ENmwu6fwWpVoV8ZkCqgDbfbfLBvBb96wkcO4aTG5noqOSpgXSqYszW0c3UIoYrE7qCUfyJgqkA/n2eNuiVv6ufAJmf04whzcTWl+PgIIiM4A4yw+Soh+E6ch0aHrEkH7Kw=;7:Cz4WUxx1zEYosjXYKYAe99UiawgKwdcmINYQCiNCHzGAlZb33LanuHoa2zyPHqyk+1+vwNXOKPU2STYmSdd7CrJZmU3+WjidxZj90qiJvkYrgrgNEawAqPC6a6+ZuOySfzh8Es5KUavqDK1dOF0DkGkf7+gdNNCGSSLOneqmP9r8loqVq2XvnK3hHPUaADBnVKDfpAJpr8RYw0zLl03atDvAeo9Pnty8C4PmK99/ixxVmnJhLFojjuQzvIodjzYS
x-ms-office365-filtering-correlation-id: a2663842-2ee9-4d6c-0321-08d61ea38983
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-microsoft-antispam-prvs: <CY4PR21MB01659617712A71DDFA958EA2FB130@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(71190400001)(71200400001)(22452003)(53936002)(66066001)(6436002)(72206003)(97736004)(6512007)(478600001)(1076002)(36756003)(5250100002)(217873002)(10090500001)(6116002)(2501003)(14454004)(3846002)(106356001)(256004)(105586002)(2906002)(14444005)(99286004)(8676002)(81156014)(81166006)(86362001)(8936002)(316002)(2900100001)(5660300001)(76176011)(7736002)(305945005)(575784001)(446003)(11346002)(2616005)(486006)(86612001)(476003)(68736007)(102836004)(6506007)(107886003)(10290500003)(6486002)(6666003)(110136005)(54906003)(186003)(6346003)(25786009)(4326008)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: tJhjGJL3R8FyihoSbSoOni6UlFdGziII+8Y78x78PAoCcX7LPMK0IWklwYYcJcNwtZpa0kSVMROwTXhoaw9JLSfdW9XfZF6gDIcIdxrxBpR8cRMyYNd16/F3hHewCCR7XkSWeS9zCR8GtafY3TOvU3mS52MFaW4AaHGQCStVG5qSX5xszox0XQFEXqpVvSjD4LXwMBitAJHUves2b2yp0a3S1UbrgJo72tBSe0KUV5K9+bZ4o2C5bugMzFEBUPgj6K2Y6ZIMmBUDsZle2LZHF3taUHfVk0xCIX6x1jLnuY0q0nW5K6JsXQ8Mm6OgmGynByCX6AdY3LB/6nDUBiOsHlIryt3Mi/AFCgt6uBQQIB4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2663842-2ee9-4d6c-0321-08d61ea38983
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:56.4761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
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
index deaefd532aaa..4a362fc22f62 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c
@@ -42,6 +42,16 @@
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
@@ -426,30 +436,29 @@ static void post_se_instr(struct nitrox_softreq *sr,
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
@@ -459,6 +468,9 @@ static int post_backlog_cmds(struct nitrox_cmdq *cmdq)
 	struct nitrox_softreq *sr, *tmp;
 	int ret =3D 0;
=20
+	if (!atomic_read(&cmdq->backlog_count))
+		return 0;
+
 	spin_lock_bh(&cmdq->backlog_lock);
=20
 	list_for_each_entry_safe(sr, tmp, &cmdq->backlog_head, backlog) {
@@ -466,7 +478,7 @@ static int post_backlog_cmds(struct nitrox_cmdq *cmdq)
=20
 		/* submit until space available */
 		if (unlikely(cmdq_full(cmdq, ndev->qlen))) {
-			ret =3D -EBUSY;
+			ret =3D -ENOSPC;
 			break;
 		}
 		/* delete from backlog list */
@@ -491,23 +503,20 @@ static int nitrox_enqueue_request(struct nitrox_softr=
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
@@ -624,11 +633,9 @@ int nitrox_process_se_request(struct nitrox_device *nd=
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

Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BF8C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A54420666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CUi574fD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A54420666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbeJAHO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:14:57 -0400
Received: from mail-by2nam01on0116.outbound.protection.outlook.com ([104.47.34.116]:2013
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729525AbeJAHO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rox0gSB/rCXsrL5lZwpynvR7hD5T1hzY6892DXYF2HE=;
 b=CUi574fDsheupLa+yD0nW48BqJ2dkwd5PQ4YkwSZcY1mkwTDPCpqL7bW7m+F5KW4/piJ7GvezZoonScZd4+PuVG7IWvZ910DbjUoHQ+K048N8o9Tg/EA5nTLflT1Ra0HchBiWUEeUqw0vJIzDNBaoXxDbqA48s5br8qW7HA3E0U=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0854.namprd21.prod.outlook.com (10.173.192.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.4; Mon, 1 Oct 2018 00:39:43 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:43 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 16/37] nvmet-rdma: fix possible bogus dereference
 under heavy load
Thread-Topic: [PATCH AUTOSEL 4.14 16/37] nvmet-rdma: fix possible bogus
 dereference under heavy load
Thread-Index: AQHUWR8nZJd8ReK3bUOCntNpxjmX3w==
Date:   Mon, 1 Oct 2018 00:39:03 +0000
Message-ID: <20181001003850.147107-16-alexander.levin@microsoft.com>
References: <20181001003850.147107-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003850.147107-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0854;6:k5o0baQOchck+7MW7yiALm1ShfwQsgHrYRMUZamVhJcHaCdkk/N0diNgLJcX1AxyJzsrae8HQThDZqf3zKdtMc8Y+PQvorbZBJC7ZXROgPIXWfRw7StfZq+yO9aawJS2rCCucWHHr3sl8XOZu8DR83V8SRkruxGf1gC7em1AxeeO1PRb4rRrdi7Q1ojQix8FT0mVcCa2PieDPYt0ihnqMHhd57LtlI2Cie6kRhoQpAs3ZlO8YrdFIqgFTcuZnXW+5IuFTQt9t18sEzTLkQE7zrv2yh10FAxsf7EH5UqHVBH1mWUoAsY1ikIqJcYHs1jyVEB8DG9i6ybYfXc5mTMiFHF5rNYvLU/+UHPTKCLkGcZC5yTGR6677ca2FPPDXn0c3SiOWr/cP7wIDzemppyvFZBEiPMxBbHRxD2p3Ct5IXDMcLzpXyXrQO/Hn11iUTr0zdvVNe/1CyUrqtYoWFLCwg==;5:bsTu9elfhiWhmx1cwjGd4fSBYuiofF4jN1GFv/sAufSLm1ojEPwp0aU/HApsoO0esovJFL9MqrtwpXtRONY3Fwt2GFGUA+x1362ruJlksuJuib7dZ5gU4NfShQelq4B6MtJIVr69JoC7VOas6Lk8CDmt8K5VtlxphK+fdOyDY9A=;7:7wKADoFysiG0YUvUf3DzNm/f/4ZidLjeM/p6iYmexKMv1Qxs4neVK30K/bupURHpNovcGgv420KqF29k7eOvQTt+fkG/8eP3GLhfUnEjeyhMqWLJlUzTXeV81FTw20OCryRVgZ6ald24SZ0fr+g1WjFp2u/bvpGdgQGa041YfJjyyS0gUUolU3RU/RFbAKtkjxlyM/LAThl+KnbSCbQtWMp326nnxSQRkjXtpFiNnUOJGA7jOVfdgvtPTZJ7Ab3R
x-ms-office365-filtering-correlation-id: 2c7e5256-74bd-4ed4-2427-08d627366151
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0854;
x-ms-traffictypediagnostic: CY4PR21MB0854:
x-microsoft-antispam-prvs: <CY4PR21MB08540F06A4EDF44A4A1F2274FBEF0@CY4PR21MB0854.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0854;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0854;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(136003)(366004)(199004)(189003)(6116002)(3846002)(217873002)(5250100002)(1076002)(71200400001)(97736004)(71190400001)(76176011)(6506007)(99286004)(36756003)(6346003)(26005)(2906002)(575784001)(446003)(86362001)(11346002)(476003)(102836004)(2616005)(14454004)(2501003)(10090500001)(14444005)(107886003)(4326008)(22452003)(486006)(316002)(34290500001)(186003)(256004)(66066001)(86612001)(305945005)(25786009)(2900100001)(6486002)(106356001)(7736002)(6512007)(53936002)(81166006)(81156014)(6666003)(8936002)(8676002)(5660300001)(68736007)(54906003)(110136005)(10290500003)(6436002)(478600001)(72206003)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0854;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: KrzpCc2bxLb7khG0Xr2a8ju8DzGPZeL2NQOUWK+R1kgulACre8uvTUd/wKV3QOkpQSJUbp+UYuW8FQytI/mtC2JepGSarmSM+exIDIgyD2DiIGZ5jrMke+cETwf7T16N8JZPTuU0MdnZ2mi+M5EC6UdQCDjBGTWlFY/zzcgBe1h8/hrXtVB+btGc6oVAgmbWH6NgVmr+/rASNAa4xHax6Q+16nbo0BvFLWPyN5KzPdPYaSWGKz8Jpybx+3znVywqEYaUKn6nMNvoxHtr5sYeYmI+nkFNAmWh6cJ9PdM0NAgWGU4vt+tKdYPa/Olnqb643ywGxMHWSEjMFxuG0Z+uHTvi+3EFQrbE31orJbW+HOg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c7e5256-74bd-4ed4-2427-08d627366151
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:39:03.4658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0854
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 8407879c4e0d7731f6e7e905893cecf61a7762c7 ]

Currently we always repost the recv buffer before we send a response
capsule back to the host. Since ordering is not guaranteed for send
and recv completions, it is posible that we will receive a new request
from the host before we got a send completion for the response capsule.

Today, we pre-allocate 2x rsps the length of the queue, but in reality,
under heavy load there is nothing that is really preventing the gap to
expand until we exhaust all our rsps.

To fix this, if we don't have any pre-allocated rsps left, we dynamically
allocate a rsp and make sure to free it when we are done. If under memory
pressure we fail to allocate a rsp, we silently drop the command and
wait for the host to retry.

Reported-by: Steve Wise <swise@opengridcomputing.com>
Tested-by: Steve Wise <swise@opengridcomputing.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
[hch: dropped a superflous assignment]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/nvme/target/rdma.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 3333d417b248..a70b3d24936d 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -65,6 +65,7 @@ struct nvmet_rdma_rsp {
=20
 	struct nvmet_req	req;
=20
+	bool			allocated;
 	u8			n_rdma;
 	u32			flags;
 	u32			invalidate_rkey;
@@ -167,11 +168,19 @@ nvmet_rdma_get_rsp(struct nvmet_rdma_queue *queue)
 	unsigned long flags;
=20
 	spin_lock_irqsave(&queue->rsps_lock, flags);
-	rsp =3D list_first_entry(&queue->free_rsps,
+	rsp =3D list_first_entry_or_null(&queue->free_rsps,
 				struct nvmet_rdma_rsp, free_list);
-	list_del(&rsp->free_list);
+	if (likely(rsp))
+		list_del(&rsp->free_list);
 	spin_unlock_irqrestore(&queue->rsps_lock, flags);
=20
+	if (unlikely(!rsp)) {
+		rsp =3D kmalloc(sizeof(*rsp), GFP_KERNEL);
+		if (unlikely(!rsp))
+			return NULL;
+		rsp->allocated =3D true;
+	}
+
 	return rsp;
 }
=20
@@ -180,6 +189,11 @@ nvmet_rdma_put_rsp(struct nvmet_rdma_rsp *rsp)
 {
 	unsigned long flags;
=20
+	if (rsp->allocated) {
+		kfree(rsp);
+		return;
+	}
+
 	spin_lock_irqsave(&rsp->queue->rsps_lock, flags);
 	list_add_tail(&rsp->free_list, &rsp->queue->free_rsps);
 	spin_unlock_irqrestore(&rsp->queue->rsps_lock, flags);
@@ -756,6 +770,15 @@ static void nvmet_rdma_recv_done(struct ib_cq *cq, str=
uct ib_wc *wc)
=20
 	cmd->queue =3D queue;
 	rsp =3D nvmet_rdma_get_rsp(queue);
+	if (unlikely(!rsp)) {
+		/*
+		 * we get here only under memory pressure,
+		 * silently drop and have the host retry
+		 * as we can't even fail it.
+		 */
+		nvmet_rdma_post_recv(queue->dev, cmd);
+		return;
+	}
 	rsp->queue =3D queue;
 	rsp->cmd =3D cmd;
 	rsp->flags =3D 0;
--=20
2.17.1

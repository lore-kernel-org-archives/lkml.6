Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F76EC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3BB20840
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="oSdS8Z9J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A3BB20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbeJAHPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:15:51 -0400
Received: from mail-by2nam03on0114.outbound.protection.outlook.com ([104.47.42.114]:28569
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729042AbeJAHPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:15:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2qWa4b1h2GFjr2earEV+1ZvABcgThrqfOryHM5KWYo=;
 b=oSdS8Z9J07phudeO0xnYEA1AUfELvxTjy64AYYfFutk/FStnN/xSxkUT3itBhoB8e+muepWr1dIHwK55eXDSwsHa96/XnpPfLZdiufZtTYDRTPkehC1+1esY9tAHKFTNB1uYq2RV44nNbKcQXG1QruZ+kd9ubjmxk1xy0IvaJHg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:40:34 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:40:34 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 09/26] nvmet-rdma: fix possible bogus dereference
 under heavy load
Thread-Topic: [PATCH AUTOSEL 4.9 09/26] nvmet-rdma: fix possible bogus
 dereference under heavy load
Thread-Index: AQHUWR9dTIy/Q7QzV0O+rj9xEkb2ig==
Date:   Mon, 1 Oct 2018 00:40:34 +0000
Message-ID: <20181001004026.147201-9-alexander.levin@microsoft.com>
References: <20181001004026.147201-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004026.147201-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:og1qJbMFuvNxxCxY10gboT2XSkjNfmLEDwWtJ8ZKEgVaTtyEuKQk2aCOonzSGPQ+r4SOkLzGrdyEgNImaVMIneZAIh5+qKl/vOglbePdVAjeo7CQXyvUImgXPEK8DfnBxbN6qnpl3R0Ybdv+vh9HzdSU0/BxyCIAN9ktm+cAUky2z2WJWkndklZjWAqWdadDmVEQmRIw9pxejsfu+jDVy9ZBJ5OSSp6Eq4DaRYZ4YZOpf7YaLElnngqwnnxjF/a5hRv5aLsshuB9qtUvkRIakNBEnL+0WrikTg+l0ViQreawKJ3kSRXqKGG8qCWKGhSyzXlqzR6+7WPzGxOUFzhvEn4Dpios0dm+bbzBbzLQ8x3l4PfqPc4JFxqvzQZTSCMdIM991tNgPbhPJrtLnTZsU6kO/XKv38yyCo3Ni4CMSzYEMWvuW5PYaMJWKBDqGSMyWhkCKxtYxAfhq65hCZpKvA==;5:1sQpoxkxNN/mHvbl4brTRSuNb3oOguvEi3/hZVD9j94+w7pqcwmzdRNeqAsS2OQ39amGjPmGD8iBfJuSYtSrwrQex9saXVvH7aeselvmVpIMRmkAXWoZnj9EaQHd15ZCkV3sy92Ytu02yFMVfKtAISbHwRuctWbZStpMKdLkS8M=;7:kaB9o2wjWqsAX/fScvcJPLYnSBK5id2JjeplUJH/ETfBx68l+qzpycrEdB0Ebeo45yG4Aaqg4mJ4KunbxZE2URhpLBtfBz8BDZrYwETh/9NzFvEs7VdlOdNmq5suHo6iUp0bm0n6d3aHbF+ehz6Z73l0xVTokyEr+tC+oosxu1wmCSB/W9oR58RfKnuORBaOPLAjLKhV/WskQ+7wtARG6xGqZQMO5QZ47uUGVswA2j4O3lSz/wqf1BjD04AY366l
x-ms-office365-filtering-correlation-id: f29cd167-c232-44d4-b5b8-08d627367ff0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-microsoft-antispam-prvs: <CY4PR21MB01204D0C6C105FEFE95D1BF4FBEF0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(346002)(39860400002)(376002)(199004)(189003)(575784001)(86362001)(8936002)(6436002)(99286004)(6512007)(305945005)(76176011)(2616005)(68736007)(53936002)(34290500001)(186003)(10090500001)(105586002)(106356001)(86612001)(6486002)(81156014)(81166006)(8676002)(71200400001)(36756003)(54906003)(5250100002)(2501003)(26005)(110136005)(97736004)(6346003)(6116002)(3846002)(1076002)(5660300001)(102836004)(71190400001)(107886003)(2906002)(486006)(6506007)(2900100001)(4326008)(66066001)(446003)(11346002)(14454004)(7736002)(476003)(25786009)(14444005)(256004)(478600001)(72206003)(10290500003)(316002)(22452003)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Mg619DXnLM2MqLknbhXcGf5Zd9CxQSKCBXinQR4h1j9oPZWMQTgwtyiLdG5x28yN1LTqwnG6QkNVXDGYUkhMhc7ypz6RfMZQWWyiU93skDUiw8wXH2y2yR9HMV3kC9qRvqQAwyGwovY9Xqavin/3o7ust51cAVay9MFWhTM96VNGBJbTdn99/2GSoC9F3qlaGQa1eiq+52Vn4CGYAFkNadVqPmXjTnUEOIPYrFF2hlbLgHoQoZ1SCnDvIB/yLfiuwWwyyZavtxcrzfi1aLqRtcJP8y/+QVYEy1moH8enOew/lP870i3XITsCu/RXahv+8NY/o/Gh+vjBEpPS3VZKMARLiU0cnCuZggLNWNBFHpc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f29cd167-c232-44d4-b5b8-08d627367ff0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:40:34.6511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
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
index 53bd32550867..2dfd877974d7 100644
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
@@ -755,6 +769,15 @@ static void nvmet_rdma_recv_done(struct ib_cq *cq, str=
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

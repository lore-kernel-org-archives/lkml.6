Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35C1C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7E720666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="mCeHDPri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F7E720666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbeJAHNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:13:54 -0400
Received: from mail-dm3nam03on0101.outbound.protection.outlook.com ([104.47.41.101]:12851
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728670AbeJAHNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQuxpq9rZDJavEcPFivtKmZCDsWf2Ijq6pE/yvsH0SE=;
 b=mCeHDPriwPbGdPqcyAsvRTLliNopUUlj96DN+AE5Gi/tqs3xPBt8eD+mERsWvPOvZiyfF3a6+0EBhSb8YiTgiWS9M2VCd4B5sXpMvpnuQHb4D4g71eL7s6hPhFRROxymxRg8OF9MkgJXV75oEd+GzxCnKOz7s0kSvI4ufSsoKi8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0472.namprd21.prod.outlook.com (10.172.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:38:18 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:18 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 25/65] nvmet-rdma: fix possible bogus dereference
 under heavy load
Thread-Topic: [PATCH AUTOSEL 4.18 25/65] nvmet-rdma: fix possible bogus
 dereference under heavy load
Thread-Index: AQHUWR8M1YbDM/QOO0K5FnY7xLZ5OA==
Date:   Mon, 1 Oct 2018 00:38:18 +0000
Message-ID: <20181001003754.146961-25-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0472;6:KqgR6vnH1R/eUHMxreyXiOQ8dmPVfmUew3eP7LwQ76lE+hxS2tjRvbjV3vqAHJGq2jlLSd7I7P0qXZIbGjEcLTHe8WB30IREhc1ERDV4x2qRrevNMOGPJX6tG+RTbKvWpWj0xN5qAQ/AflGUrKm+x6J8Rq1Zx/7LDsgBFxcxPPBwh8H4blo2wyeP9ybNO6IQ90mZiukkudhPYBPwG7ZJMrftFyBgJ4vK2zXlP5hQoOBin4RgijPJwU6Dnvh6LPCWKoM9ANLnycf5WLQRCTHhXc1zyfvrDZdmiK5YEVbdrxuQ0mwNqW4oN/V4r5+SHxUreqt+Pyke1HeHALQy5SpzXZRsf50a+MZgJKO1wgrn304eaxUblN9o+cor4bzUJGVfPTvibT1FbfrFmbeDCwpZVNLlPBujejBpEtVWizgE58ixDm+KuP+c6kfExcnELz5gamO3qKcFWuppXO+SiImy2g==;5:PkubEoSm0i2puO72hkgJPM3u3rjFJIcI9dTvty8DXjQhTKwRPtFhk3zkehEokjoP6X7O+Ftq0B2GA//LRwzA5KapmtsbJaDWUe5fpk2dWswVMACcJfXcI0QqUlJ8dU/apup3SVSIEgGosMcp+9Z0kqOSVa7mBbCpdgVF6pIBaFk=;7:jiOq6+p8KH0ATGz9kNyCv7tGZ7oVPrNCYkDaXO1uGJ5YnuGN+QGEbZnH1kVIpbpyz7+/FC2sU0lu+GzGLHNwA8wcQfhwN81E2pbdrYfQDzbcCc2syaWAhRO80U1T8I4veYotDEM2HiwQ9pRhlvW1WXDpwGWg3oHj7zwb+AD+EMfY+dkM6nHxxONVhYL/eupd5Bsc8RPrA+jX971f0wme5aKsPemlR+4QIsxP4Vwx6qBTe1M/AySC6ZG/eVL+i2P7
x-ms-office365-filtering-correlation-id: 6e5c6a0f-dd91-4b60-e8db-08d627362eb7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0472;
x-ms-traffictypediagnostic: CY4PR21MB0472:
x-microsoft-antispam-prvs: <CY4PR21MB0472B7289FFFC831EA8A38F4FBEF0@CY4PR21MB0472.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0472;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0472;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(376002)(39860400002)(346002)(199004)(189003)(5660300001)(6486002)(8936002)(68736007)(486006)(6436002)(2616005)(6506007)(6346003)(8676002)(6512007)(81166006)(81156014)(5250100002)(6116002)(2906002)(3846002)(107886003)(2501003)(1076002)(22452003)(478600001)(102836004)(25786009)(4326008)(97736004)(10090500001)(11346002)(256004)(14444005)(106356001)(105586002)(99286004)(86362001)(575784001)(53936002)(316002)(71200400001)(71190400001)(305945005)(2900100001)(217873002)(7736002)(10290500003)(14454004)(34290500001)(446003)(66066001)(72206003)(110136005)(54906003)(186003)(86612001)(476003)(76176011)(26005)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0472;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: S1EPqOq5ZJkdQRPHQdY0/b0W9ZXiACOZbd23X5H3xpe0C9yPQ5h+yyRv61oZE8xypsnOdn/IolCor6AEVx0oeFeATCNFBRqcabDORtJtSPSykszkVm4j4I7l1g57l3L+GLVeoVDkPvp0h7RIUdZ3w3XJ8CGvCoErItiBmfus07nLF7jGSfFUotiVe9g8jv3daHncHShWe0n03ZwRAGnllrPe/ECNUnT53hArl56zipubJwm62KFa4WqBc+FfrZ063rlEcFX5CjkkWIrrcnsvW096cCnhmWq3k1I5a7iX+sq9gjJ3gBa7e905a0VHVI+xP5EPW9QiKoSJGJhUEu32wB7ASY4g76mxYwhxNMqXXBg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5c6a0f-dd91-4b60-e8db-08d627362eb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:18.3474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0472
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
index 52e0c5d579a7..1d909e5ba657 100644
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
@@ -166,11 +167,19 @@ nvmet_rdma_get_rsp(struct nvmet_rdma_queue *queue)
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
@@ -179,6 +188,11 @@ nvmet_rdma_put_rsp(struct nvmet_rdma_rsp *rsp)
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
@@ -702,6 +716,15 @@ static void nvmet_rdma_recv_done(struct ib_cq *cq, str=
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

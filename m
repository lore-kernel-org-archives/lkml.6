Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD24C31D63
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D2820880
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lfRNKBHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbfAUHQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:16:34 -0500
Received: from mail-eopbgr150057.outbound.protection.outlook.com ([40.107.15.57]:63424
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727566AbfAUHQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3SyASY1exvyKXQoXM/mj5u5kcX8oRhR0+16SyJ9MiM=;
 b=lfRNKBHj5/QEtAkiR+OodB/hNyuOU8YeOOvPf81bJzh4iZT1u0QpoO3NhhZj03HehZZM/33Di7MADUcAsS9gsDMGpWuh//RV1qb1DnZ1tiPd4dQFqkruHdE7ZAHZQZFdQR8x4d1CsLdP3Jp2sPjgkpdvJCl3VjNsy7pOCq70Dm4=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.148.143) by
 AM0PR04MB3970.eurprd04.prod.outlook.com (52.134.90.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.27; Mon, 21 Jan 2019 04:51:57 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::69ce:7da3:3bcf:d903]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::69ce:7da3:3bcf:d903%3]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 04:51:57 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: [RFC] virtio_ring: check dma_mem for xen_domain
Thread-Topic: [RFC] virtio_ring: check dma_mem for xen_domain
Thread-Index: AQHUsUUJrf+HCksNJUevQFBecw2Jmw==
Date:   Mon, 21 Jan 2019 04:51:57 +0000
Message-ID: <20190121050056.14325-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.14.1
x-clientproxiedby: HK0PR01CA0061.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::25) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:73::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB3970;6:5A3wuQr4F5QYQ0uU2hDLygCYBOuoSBD3QD7D8/CdPlmA0tWl1kvXREWVSP8FB+GDRcq++exTl5ruxr6IYz636d2vaWOVSahwfJASoS6W1ktQ9zA/ACQJaQ2Fh72iyFuGIi9denhl6BU6KYhC1742Q8GVxztWIQxE9SFSCztx2qBYSv/536Wbd1x7iYmjQK5ExyX7nftNpqPMvjYqOCp0RYQYsJtuTYxlMxQqMBPLMT+6MDm1ASYM241Kth9z6om8Vofa/1teJMuUtxWElxSY2YZAsuJ2QpIPLjDVMTsRu8hyIdBlCc9su0XgDLNIIqMM1XOTGPyeNk22qwlq3PPnqTsOyM0yUckj4+05ReyjT025Tw6fhwlwEjzK6U3TT3/yaq+fsIPVuuXKUALo/ZxxQsny3l3zSapp2uG29mkNUu6s95CtXxjxI9ye/tT1eaj4SFA90Uuc66bmDzIMxXtrtg==;5:aaz0KcC43PUptHjQlDnTNbljz/1tF7byUPZcxcxRKXAWSolAe9yM3cS9JObggFq252aqL25wmOuCucLLHHYlxZKqnH3qF/6t30bcVqFt9zhFNyHuiqhdrIjJ2L8s9WbeEDLRXNFf2VeJxx4nI/LntHI88HlXhk+BG54A9eJLOOguEYSlsC1KwE2ClWqznodHzZDD44Akt5gboWf/D9dRmA==;7:ZYVIMjSOPWhlhWjD82DbEugQ+7CmK0aTflsIFZyAxEHT2umGpO+aZ61qQ2QNp8svQXzNlfmN3Bjmzs5VwLgeBJO5pmDXTpBeaNl9WjaLBiJ7T65nBoGZpdTt7F8u3vs2UP3KTsmBjjgOrCADg4FUrw==
x-ms-office365-filtering-correlation-id: a00c003a-fe34-41f0-ac74-08d67f5c2be6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB3970;
x-ms-traffictypediagnostic: AM0PR04MB3970:
x-microsoft-antispam-prvs: <AM0PR04MB3970FC3D806742B6E66D0620889F0@AM0PR04MB3970.eurprd04.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(396003)(136003)(346002)(189003)(199004)(106356001)(53936002)(25786009)(6512007)(4326008)(478600001)(6486002)(105586002)(6436002)(14454004)(68736007)(36756003)(97736004)(66066001)(6506007)(86362001)(102836004)(44832011)(1076003)(3846002)(2616005)(476003)(486006)(7736002)(386003)(2201001)(186003)(6116002)(81166006)(316002)(305945005)(110136005)(8676002)(2906002)(99286004)(8936002)(50226002)(54906003)(81156014)(71200400001)(256004)(71190400001)(52116002)(14444005)(26005)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB3970;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uaEzstGIx2lTKhutq8bKhRX96GyprKFk0yjtME7pRujXXElqx5JiU9YM2VKap24t951xX8npZCI9o4ESLv/U0e9P7eW7VzgomAf9ruSnG1M+Q8yau7MH0t0XM2wFIv8jWapdwjatNOPlL3emNs6D8OxPOrxoHGATeLv/K7M7tP8WEqIqNxAmeejqgQTXsQ9tq0ZoKF3coc7UPvLBbnsZT+ubDbcEO0yuPwYQ2Isx2yNC4XBJ/tI5CcXP0vqVH9tF0LgYhnOuTkyI7jE1eNVaE+lDDm4jkvLqDqFnX8oGwHcCAgzSQo1WcBr2HGx9viplxW1mIXONAOokjvqneZzEcf45grHRwfQoKqVFMsqYd2M5SDomxaAeXYLj9EZ2bfC8bahdFwND2zhL/Y+uHIPHpuyOjVT0/sBqOJg5kQMZjhU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a00c003a-fe34-41f0-ac74-08d67f5c2be6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 04:51:54.0385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB3970
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

on i.MX8QM, M4_1 is communicating with DomU using rpmsg with a fixed
address as the dma mem buffer which is predefined.

Without this patch, the flow is:
vring_map_one_sg -> vring_use_dma_api
                 -> dma_map_page
		       -> __swiotlb_map_page
		                ->swiotlb_map_page
				->__dma_map_area(phys_to_virt(dma_to_phys(dev, dev_addr)), size, dir);
However we are using per device dma area for rpmsg, phys_to_virt
could not return a correct virtual address for virtual address in
vmalloc area. Then kernel panic.

With this patch, vring_use_dma_api will return false, and
vring_map_one_sg will return sg_phys(sg) which is the correct phys
address in the predefined memory region.
vring_map_one_sg -> vring_use_dma_api
                 -> sg_phys(sg)

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/virtio/virtio_ring.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index cd7e755484e3..8993d7cb3592 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -248,6 +248,8 @@ static inline bool virtqueue_use_indirect(struct virtqu=
eue *_vq,
=20
 static bool vring_use_dma_api(struct virtio_device *vdev)
 {
+	struct device *dma_dev =3D vdev->dev.parent;
+
 	if (!virtio_has_iommu_quirk(vdev))
 		return true;
=20
@@ -260,7 +262,7 @@ static bool vring_use_dma_api(struct virtio_device *vde=
v)
 	 * the DMA API if we're a Xen guest, which at least allows
 	 * all of the sensible Xen configurations to work correctly.
 	 */
-	if (xen_domain())
+	if (xen_domain() && !dma_dev->dma_mem)
 		return true;
=20
 	return false;
--=20
2.14.1


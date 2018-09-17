Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB36ECE565
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7042147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Ip9EL3Ew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7042147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730100AbeIQI3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:29:07 -0400
Received: from mail-eopbgr690092.outbound.protection.outlook.com ([40.107.69.92]:17633
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729959AbeIQI3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yl0zf9gcK5HsFEiWZI0LY8Pm2TF4YRDaulrtbQSvZ6g=;
 b=Ip9EL3Ew+9A8GdDhDdMsNV3o7EbenZrwafREG+d64O7lgghOpUz96PmNoFSGvaxAvibbVpQnE90yZmR7xfdPaqGWEOT7zBXJqcxtZ4Qb+KQFUMRHLF218gpku+Wc4JDuhBl2JK8ywCow5es6eQtaeZ463RHj+Vfj5PaVFl78TI0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:03:38 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:38 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Tarick Bedeir <tarick@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 25/87] IB/mlx4: Test port number before querying
 type.
Thread-Topic: [PATCH AUTOSEL 4.14 25/87] IB/mlx4: Test port number before
 querying type.
Thread-Index: AQHUTjLk/KjyFwATd0y0ETWrEsTNsQ==
Date:   Mon, 17 Sep 2018 03:02:39 +0000
Message-ID: <20180917030220.245686-25-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:rOwB+zRFsP/uLyCT2pW9DyqpQstpNU7dzSsDpT8fZF6R6fSuGB3KKndPBexhW9U0EvSgf4xK3ySe/Ct/MVjDBGqVOhXyvAPd0mBGeriWEZzMiJKvo5H41F7+oq6sU+zRzTsV3JiH/yNaqk/SqVMDM11CHfOskoftKOcgZyWcvgxNiCxJZ3NBNwYS3LE3doOvwYY5kOlSRegkKgzHUf+9UCEvJ12OPEfhaVtCAmkbJMMTilqUHpNDlIJw7no8Quz8mkufdon2jnmQrbp4Ji4yUxiicHduYPT04A8WjGJtDP4CKh2GxQEcg8tpQXvQmy5HFSdLcH0Iihpsd6ZXUrQhZFMQEMGggn+YCDwIrwpuyS9dU+hTMuqg6+CVSfeJ/H08o9vu3DQXXIbFCh+8PvJSYikNmcntiIsTijDEYg5IJL564MGFjCxOAFtR+I+qcx+SVSgNQfsz/snDnfxKCqdYdA==;5:GWFOskdimkezIZDF6aiwJhfVU9B+o7I7C1EOiiNitqpA+kottQpucvEh5FxUMFdWQeM5brrXDbRJ265MxHNVA8zCaRpzbBdrLABJpesGUEsePvE6GtLq3vJiqPdI7MH5zwC7XS8a7P6cb9Vz1ZXmClWIJEuxQKXkcBYdsHl8t7w=;7:fTnv8IyW1owrVUvsoX+AmjhJ8FHKU3B2gRYOnZ3j4j09gDjJxx/B/P7a2F0yW0EqT+NuiwNtBwYV8/9hxir6/PdLbfugK34RFZRsA/hvgPs8wkac4wK7Oo/UJDndnDTRy5Z8oAeMqk1AFJDaED41Uwc8QUgW1iDvxL4d+8LAUcDTqA1ygZjQ7h+Gp5BqIX1VIzGUS7Drum5o0vG58shZ6IR6GxyITkmaWWiU66B2beQMJW/6ot4n0VUe8wghdCuq
x-ms-office365-filtering-correlation-id: bebb6833-7e5b-4fb7-e5b7-08d61c4a2abb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
x-microsoft-antispam-prvs: <CY4PR21MB047022097E3C332CCDA88B38FB1E0@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211936372134217)(153496737603132)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(366004)(136003)(189003)(199004)(1076002)(25786009)(4326008)(107886003)(5660300001)(3846002)(6116002)(54906003)(110136005)(22452003)(316002)(86612001)(76176011)(53936002)(6512007)(68736007)(7736002)(305945005)(86362001)(2900100001)(256004)(66066001)(8936002)(11346002)(446003)(10290500003)(6486002)(14454004)(81156014)(486006)(6506007)(2501003)(99286004)(26005)(2906002)(10090500001)(478600001)(72206003)(105586002)(6436002)(102836004)(186003)(8676002)(2616005)(476003)(5250100002)(36756003)(81166006)(106356001)(6346003)(14444005)(97736004)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: dIBnxpFaOIAK0cgZrs72jcn1YcDmq7SAGzBQt9Nyism1oAYdLdht9zGek0HvfzVUH6sT9+37KfrPCm/dO8fsvn7sw5hv86ygeqJ9b25998wDTSSWY5Yx/mOfn99Q/wm4eFllUF5IL7SaJGTGIXZGiB2PxMLj22E4NIrz3sQIetDlZUR69+VJdQcrhrJ7Lm59uRsplB64mV+DgscLtwi4mt5h0yNs9/5ZP/8xgkVYOyo/UuP3dDCv9V3R5Ws/5+hKtV6f94ri5HG2VLatjTgw3vAGJDtXIPWHsZaAgobRFicP1mPDwdYDARob4fnReiJoDH90lUD8VT/cT8kZ07A9hvfijVDKIGIYud5LmNK6h9M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bebb6833-7e5b-4fb7-e5b7-08d61c4a2abb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:39.6813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tarick Bedeir <tarick@google.com>

[ Upstream commit f1228867adaf8890826f2b59e4caddb1c5cc2df7 ]

rdma_ah_find_type() can reach into ib_device->port_immutable with a
potentially out-of-bounds port number, so check that the port number is
valid first.

Fixes: 44c58487d51a ("IB/core: Define 'ib' and 'roce' rdma_ah_attr types")
Signed-off-by: Tarick Bedeir <tarick@google.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/mlx4/qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/q=
p.c
index 9354fec8efe7..e10c3d915e38 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -4014,9 +4014,9 @@ static void to_rdma_ah_attr(struct mlx4_ib_dev *ibdev=
,
 	u8 port_num =3D path->sched_queue & 0x40 ? 2 : 1;
=20
 	memset(ah_attr, 0, sizeof(*ah_attr));
-	ah_attr->type =3D rdma_ah_find_type(&ibdev->ib_dev, port_num);
 	if (port_num =3D=3D 0 || port_num > dev->caps.num_ports)
 		return;
+	ah_attr->type =3D rdma_ah_find_type(&ibdev->ib_dev, port_num);
=20
 	if (ah_attr->type =3D=3D RDMA_AH_ATTR_TYPE_ROCE)
 		rdma_ah_set_sl(ah_attr, ((path->sched_queue >> 3) & 0x7) |
--=20
2.17.1

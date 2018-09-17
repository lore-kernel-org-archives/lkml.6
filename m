Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E05AECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27212147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="kKxvx6Qe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F27212147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730860AbeIQIbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:31:21 -0400
Received: from mail-eopbgr690131.outbound.protection.outlook.com ([40.107.69.131]:27472
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730752AbeIQIbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYO0uxuz0C5AnQA22VkCB9fMjbcktAqfqQ1rvVjiXLI=;
 b=kKxvx6QeTic4FNGBJdKXTEjDhaXoz2HqasWk2SP2KjFMTZC9TGpu0a8XAjpuCNVvzpAmQq/wCk4igNIy526qEOhtAPX5LhBrjsKjsDQn7Cpx+PveRQq5AMQw84v6F3qm1yQMt43UTh7N2yZNLpoO86i4e01r/0TS0Q3XmgiAwPE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:05:41 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:41 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 16/57] IB/core: type promotion bug in
 rdma_rw_init_one_mr()
Thread-Topic: [PATCH AUTOSEL 4.9 16/57] IB/core: type promotion bug in
 rdma_rw_init_one_mr()
Thread-Index: AQHUTjMQer6+tLbCz0Ke4MX4kky+yA==
Date:   Mon, 17 Sep 2018 03:03:53 +0000
Message-ID: <20180917030340.378-16-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:XR9ZJD4dK7QzJbeRCLm1JprR/PFnTKuoMJ0WklKw+pDBDE7MLy19M6QrBaqz/8gjzGT3TOuqwyhYz9WdpOKKElJGXAavxthsLl/9NwULQulA57pPSW3fGRSenuLBfoWFbRwP289UaumIwNLh++ffLrO+UcAnYVtQsfEIh1m9+ziOWmsI2s5bS+IBL+dZD6L7TFSc2OTm8fNq2EhO0fIthBL3C9PFt7bIHOhzKd7d8kJXIyYFGllvFh87fgV5AA6c4hrlOVVaK019jfqk6Mg0vmnuW4M1CEcBruMBluVl6WyVM9YkZlC9tMbF/hvpaaItNY1E2dMRadbibw+QL1a0n5Wgp+sddrUZ+CURX9ViupsBYYaJcxhCuAfEZy0JyCmmGFx7mx8IlIajGp56OFLRcA4yU/EqYbKYrj8+H+4czFxs+OfWtu71LrPqAgUqNyaotsPGe3NBlKwnCqUhJFLuSA==;5:uu7zgl9ttWtK2DGTTK3AliT/0rS6SU7vpMkM6+ABWeqiu0egOTage4aL6hfRxwJO5dBj7tXK6u7c3vRTCgCviqOwreAQQ0a2qAlycdUb6K8OJvjiNl/1ebxMKFD39LyvhM9ahmcSYaRspN4qZ8O8v5O+1aRjJZvxhsGwHvEW5cE=;7:TBtqJn2zNUcw7gpW586o0/OS0QOvSNN1mTip8S3ogjDjbXlstInIUSkomyPjGazqC1HwEpMDZXSbeOED9oS8WLz5f4fOAx/rBe52Io68s+D+2hdTMc/4qlJwVgMWRguNoF5AfXLzl4oGIBqDA0Bnm2SLlmkxpkOOnV49o88yDQNpNCpgwGPZd1xQOYXP8ju1ADzuyxcDSyhARGxqVOtX4Nl9ox0ObVOxrafGCP5n90ZuxwPAylVECcturX6WeA2o
x-ms-office365-filtering-correlation-id: 0c92c2c2-dd1b-4f80-e380-08d61c4a7389
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-microsoft-antispam-prvs: <CY4PR21MB012036A197C4BB176CCAE1BEFB1E0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(54906003)(26005)(110136005)(446003)(2906002)(6346003)(99286004)(316002)(575784001)(86362001)(25786009)(102836004)(10090500001)(2616005)(2900100001)(76176011)(97736004)(36756003)(11346002)(72206003)(478600001)(10290500003)(3846002)(6116002)(1076002)(22452003)(107886003)(5250100002)(2501003)(86612001)(4326008)(217873002)(105586002)(106356001)(6486002)(14444005)(14454004)(256004)(6436002)(8676002)(305945005)(8936002)(6506007)(81156014)(81166006)(7736002)(476003)(486006)(68736007)(186003)(66066001)(6512007)(53936002)(5660300001)(6666003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: f7HZkoKlYq3lMRuqGHG8Jtenl/irRADwqXiiKZFsCnss97d6i+or+SzXFDM84/EH93j3xIyOv0e3NKbnnQP9MHbb5QuANHqmhkhzWeE4S87aHWDetVUcQPwxpq1+xHWpZACrMEDuqbqnzN47A6fiDuqXfugndv0KhlS1AKL+bCzwvmF4mEKeqUE7pMNBnntlu0WrkIsmPpHAKBeZNh5XHaztiOrK2ko700tMKLr5SCVUMPy/ebHaXBkoia8nhxsHmmau9z9JMtNBJALEq9D5rYeM9ygXYfoj7hh2nxjysUVP+9O2Lwz0HKVpXm724nVGFPhs40O1xGruyvT5lT9LI91g05lXhZHwhqt9GvvYriw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c92c2c2-dd1b-4f80-e380-08d61c4a7389
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:53.2429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit c2d7c8ff89b22ddefb1ac2986c0d48444a667689 ]

"nents" is an unsigned int, so if ib_map_mr_sg() returns a negative
error code then it's type promoted to a high unsigned int which is
treated as success.

Fixes: a060b5629ab0 ("IB/core: generic RDMA READ/WRITE API")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/core/rw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index dbfd854c32c9..1d90a122fe5e 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -87,7 +87,7 @@ static int rdma_rw_init_one_mr(struct ib_qp *qp, u8 port_=
num,
 	}
=20
 	ret =3D ib_map_mr_sg(reg->mr, sg, nents, &offset, PAGE_SIZE);
-	if (ret < nents) {
+	if (ret < 0 || ret < nents) {
 		ib_mr_pool_put(qp, &qp->rdma_mrs, reg->mr);
 		return -EINVAL;
 	}
--=20
2.17.1

Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04628C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24152075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VXWcZ+UZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24152075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbeIGFO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:14:27 -0400
Received: from mail-eopbgr710107.outbound.protection.outlook.com ([40.107.71.107]:21288
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725745AbeIGFO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuKUsHJdIaLlEYydc4rTM7frSD9X3HViMi4SU9y84lI=;
 b=VXWcZ+UZvWHKRXU8SoIsiPIwTW1//OzLOfeUCcFM/rxblyBpG2sh4UTnBcsX2zpC3FFmVm+9V6Z8+FlA7eGj9GZsnj/pb/5ANfhtLaScSC3d4OE+mOUizjLvi46lksGbR3arF7WB1thTjhkTC18fk3Kkc41+GcmjYgy6QLqprt8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0824.namprd21.prod.outlook.com (10.173.192.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:36:13 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:13 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 30/88] IB/ipoib: Fix error return code in
 ipoib_dev_init()
Thread-Topic: [PATCH AUTOSEL 4.18 30/88] IB/ipoib: Fix error return code in
 ipoib_dev_init()
Thread-Index: AQHURkLHJgmsfzSjd0upUrlaLQdGMw==
Date:   Fri, 7 Sep 2018 00:36:13 +0000
Message-ID: <20180907003547.57567-30-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0824;6:gC9yAuU+egGE3EnTY4uQAdTy4ZmWxLfUf/kz3h6mTw8OuI+PG1kxw83LsyvMlaEbw4P97+7BLgbioYItfi8l1pAHJnJLd8Drb2nfsLJwEvTmYnSkEFsWZ7QCw18UKkhi9XcD0cgZdN0hXMbUoM82EUxefccgTyLhrOH1qsBrFRJiTfZULZ/ZtPQyi9sXFbMWlJmQxprcx6bG+1hEG1Pz7loQCbJgKYfGxN+B0kiu6V7cWlo3pixJd8/LR5vCcmVT7rh10gc33pukbTgSqaITYfpiR/+Z6LEKHMcbpfQGqHFKpzTlUhUYTQJdSV9eV2XxT13l3CrZ0LNnxpkA6OcBoE3bMm7S2eBHwguUmJn9y6XZ5ysZWrSyJEYjm+zbiRvxE1AKrWEFL57kuonVShIyklsRb0np+tJM7TVY9TfBjkTLvAoNfIbfJAf+buanDknnlvYdcqFLancvtvYiUTUG4w==;5:9eFtnBYkeco5169pRazM+TwXPVYUaC+MWyDWjIwOX0rmCn4bXknrpHkIM5xBjpig9jsu/Ced/OuvTWzgWCa0IJSXzYFe4v+UrB5ZBBwCO+a/rhGB3p1ZKyvPxD/e1CGVHQwzQDeBxPVMK3yQ3h1v0FFxEVgAXmXCcRWrbTEcu7A=;7:KdkkEc9YV5rc2OMsDNceCXyegINHc8YZvZmyofVqaNfV0CklRwQvmsPBLZh463jMzppokJAbuTUuoQfA61LZj051/pNj5d9IGgMKccyofQwU7dOxMYJA/Kh+sv0jg/LKvb/EWC8mjC2gMluEPyeXEha74N6F+GcP9f6VCsXkypSHqmUFL4YHiZEkLwcU2BxFtdHLdXZxlDktfyXPFCPc2Q2/MELqtnfdrfWDndtLQjzE647B80to2RDP6IxeSth0
x-ms-office365-filtering-correlation-id: c87ffbaf-8cc3-43b5-4748-08d61459ea3b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0824;
x-ms-traffictypediagnostic: CY4PR21MB0824:
x-microsoft-antispam-prvs: <CY4PR21MB0824328843CEB3C1030E33EDFB000@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0824;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0824;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(376002)(346002)(136003)(199004)(189003)(22452003)(14444005)(256004)(102836004)(6506007)(217873002)(10290500003)(186003)(26005)(5660300001)(4326008)(6346003)(81156014)(81166006)(110136005)(54906003)(72206003)(316002)(575784001)(1076002)(6116002)(3846002)(8936002)(107886003)(14454004)(86612001)(2900100001)(105586002)(106356001)(5250100002)(86362001)(76176011)(2501003)(53936002)(10090500001)(68736007)(66066001)(36756003)(6436002)(99286004)(6512007)(486006)(25786009)(2906002)(6486002)(478600001)(7736002)(305945005)(2616005)(476003)(11346002)(97736004)(8676002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: i3WF0gy8ZccW8uEBy7lpEY0Fo6miMp2CL6Acw+iOGwqTPoBlo7d0mMI1+8GdRhN88BPWUdxowmg9mDGXuHZHpRPBt2oxr9daIbaWJWfP3moYqqaXJ/56jJYu9iwMYmPU1VFgxbqSLoQjCbUUxdNM5AdbXDQPFtKKxSEOGtwdd69bkWiHbAaku6c4coVWWc9REOmb6BgIQkEQpGu9R+oGIgjatcfp1t5Bwh2xjqIBIrQ+EElIZeeCcSZxF8ofPfppfy4baXB+Lb28I4gwFJssTfD3Md16yKVrLnP12ipXW3yg1XtxoQXcuFS3Mmcr/nMUJUB8Pq/ZRSzOC9IhGr5IrpOQdhsiIU9it1y+lLCxC4U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c87ffbaf-8cc3-43b5-4748-08d61459ea3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:13.2380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit 99a7e2bf704d64c966dfacede1ba2d9b47cb676e ]

Fix to return a negative error code from the ipoib_neigh_hash_init()
error handling case instead of 0, as done elsewhere in this function.

Fixes: 515ed4f3aab4 ("IB/IPoIB: Separate control and data related initializ=
ations")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband=
/ulp/ipoib/ipoib_main.c
index 26cde95bc0f3..7630d5ed2b41 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -1787,7 +1787,8 @@ int ipoib_dev_init(struct net_device *dev, struct ib_=
device *ca, int port)
 		goto out_free_pd;
 	}
=20
-	if (ipoib_neigh_hash_init(priv) < 0) {
+	ret =3D ipoib_neigh_hash_init(priv);
+	if (ret) {
 		pr_warn("%s failed to init neigh hash\n", dev->name);
 		goto out_dev_uninit;
 	}
--=20
2.17.1

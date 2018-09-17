Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A421BECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E51208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="llNfJ/Lb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E51208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbeIQI2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:28:54 -0400
Received: from mail-by2nam03on0130.outbound.protection.outlook.com ([104.47.42.130]:60384
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729820AbeIQI2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmxb2Kvuspo+88uKCu57S6v63gUG2PgZIUeT+J7uDtM=;
 b=llNfJ/LbndItuCbl5YEFMJEuTBGLMlDr2jFtbFFS537uU3Ad3Ow/ONaqXNNyQqLw9XtFviKcx3CQFcAeW3M26vQ/AVajoYRnlpiHCokXERq8ZDeTm4j3SKdgI680Jet1BaBBunXJMORKijVx5lfkafp9HwO8Bcb/2MlTpJcGnuE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:03:33 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:33 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 12/87] iommu/amd: make sure TLB to be flushed
 before IOVA freed
Thread-Topic: [PATCH AUTOSEL 4.14 12/87] iommu/amd: make sure TLB to be
 flushed before IOVA freed
Thread-Index: AQHUTjLg4fCFdIM2ZUGIUG3umeZNpQ==
Date:   Mon, 17 Sep 2018 03:02:32 +0000
Message-ID: <20180917030220.245686-12-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:aQZOOnGBI/EJS+hSyyW1dKgQqjpt8FbNPudK7/BPyGdCWCJOUROZdH7/qoQjn2qIOeoanLeCaVRRbs2vOyZ0fXnoh5rgwM9+RQ1DrLYo/9LMo+iZb4AP2ioZ/Bzs4RPljBGd7sLrLLpZeSWdctYdcNddo2WkXWk3Tnt9ilT5p73bxS0HS9uwJ1OzJsErlNPTHvNydhsOIIeDucnwSv/1BZk0PeMjSQ44sgIfYvMLlabO6WdYCG7/yc+UqM7kaAI54UQpsJwHcIDJbHAxWzU9cG8qpDybTuHBDxgphoV3UazgkRhq38MEIiIQ2mZJ+5a7efJASeRLP76M43rnX78yGi6wmzaU6+Xrwn0VjinH+E2X/fSz7J9XQWGcBXEej+aVOpV5FWYPCxNJAiNtp/bTVukzNw82knWo08NeZYwRMDJ4AhEzq9Qh0htqpO9+FSPbNndXH9TYlGC1motmv6b34A==;5:kKSoBWMhW++yJJ/19dHAF0Unj7jlrCF4itYRixPdG79K/8zsuSy2Y9d0QcJTvUXSXyQj3Snlvla3e6BoUgjVXs+uTT5h8UOdaePrw44S65HzNBYGVUzWBwIjG5Xz+QxHEZ3lzL3pHcdypqy1rZiAUCk6e95d7qSTeBM4YHLaSXA=;7:Ttew2WEXbunKHCSU9WGaeZ61WMZoztWotQ9dfkTyYOMChl1vZpbloPUzcNgKEXnR3LcYHdSu31KGVYtNTZrS2WRxjGkH5ZPBcmIHA1O2gukURTwWImDOdWP+W8jhjRMIV5dKuJS8WYDN8TZdSOQnbBpA6Gxf2PQYKq4ob7RcxdOSd7I+bR12GdS6xy4II+caAOgOLy0/BuTZc/gHplfQOvkEO5me4tFTSKIUbljq4DmOCSW9LK4St0qC0rlH52wn
x-ms-office365-filtering-correlation-id: aa9b6f83-2662-406f-5b67-08d61c4a27a4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB08556B574870B3FCBB13DDEBFB1E0@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(50582790962513)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(6436002)(99286004)(7736002)(110136005)(54906003)(97736004)(5660300001)(66066001)(446003)(72206003)(76176011)(86362001)(86612001)(81166006)(81156014)(2906002)(478600001)(305945005)(68736007)(105586002)(2616005)(106356001)(476003)(11346002)(22452003)(6486002)(10090500001)(10290500003)(8676002)(36756003)(6346003)(6116002)(6506007)(3846002)(102836004)(107886003)(6512007)(1076002)(25786009)(217873002)(4326008)(14454004)(26005)(256004)(14444005)(486006)(186003)(316002)(2900100001)(8936002)(53936002)(5250100002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: SJWJdzwxMm+K7+BleSYiIYvSmlzz4xtjK0984xuVX2yQsD+/ofBw/XWpwN5V6gfMyFi+Zd9KVUW80U4Kh/b/uJxBo2v7aNUha3qb7DJgZO/qUTrT85oRsXevbGJDtLGqUoAoY8Ua9/ouR/gOwFSZUCeQGbYkII5hX0Jpmaz6Y+ygXbZMF4yb0gkjWKBByhlE/TWn3J4uJM4CTjJ4kQo3/CXiNDGu9CroKCKIvPrywHFuLqgisV/4INcr8Xl65hU6BdNszCiFxKiFust9XDUJ9WW3o/230qsfKbQ5TZaSijlq3LfXbUN4Z4nKi7v5YVzn4SC/u4bSH9b+Dmn+oTJ+7AkW+KhkN/vKpGqtDGU9Zmk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9b6f83-2662-406f-5b67-08d61c4a27a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:32.3220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

[ Upstream commit 3c120143f584360a13614787e23ae2cdcb5e5ccd ]

Although the mapping has already been removed in the page table, it maybe
still exist in TLB. Suppose the freed IOVAs is reused by others before the
flush operation completed, the new user can not correctly access to its
meomory.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Fixes: b1516a14657a ('iommu/amd: Implement flush queue')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iommu/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 10190e361a13..01746e7b90de 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2400,9 +2400,9 @@ static void __unmap_single(struct dma_ops_domain *dma=
_dom,
 	}
=20
 	if (amd_iommu_unmap_flush) {
-		dma_ops_free_iova(dma_dom, dma_addr, pages);
 		domain_flush_tlb(&dma_dom->domain);
 		domain_flush_complete(&dma_dom->domain);
+		dma_ops_free_iova(dma_dom, dma_addr, pages);
 	} else {
 		pages =3D __roundup_pow_of_two(pages);
 		queue_iova(&dma_dom->iovad, dma_addr >> PAGE_SHIFT, pages, 0);
--=20
2.17.1

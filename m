Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B03ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A488D208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SPUCgAWG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A488D208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbeIQIa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:30:59 -0400
Received: from mail-eopbgr690131.outbound.protection.outlook.com ([40.107.69.131]:27472
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729897AbeIQIa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxDG7JAXHI9i8o5D9oN0TwheZoOcYiDUb64FcWLSoRE=;
 b=SPUCgAWG8989fYAR/6bx+ytI6HDu4kSRZuSKZIfCxNEewj3J0uK+o7FM+jsy4LTZ3JiNtmPi1WM1y+XbwmOShA/egSJbHfD8ruY8uaxWQtxLbySdWRaqkkGd7PwNYWIty2TJS/gXTVvz+HuJbLl2ZVNbgn70DKveGFY+7kACEL0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:05:37 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:37 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 08/57] iommu/amd: make sure TLB to be flushed
 before IOVA freed
Thread-Topic: [PATCH AUTOSEL 4.9 08/57] iommu/amd: make sure TLB to be flushed
 before IOVA freed
Thread-Index: AQHUTjMOhY6Oyxr/G0y11M2xb5/0Vg==
Date:   Mon, 17 Sep 2018 03:03:48 +0000
Message-ID: <20180917030340.378-8-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:d3sK4+0QRck9LMmL4ucLU0qfRsYPiszFiaTNkbsBrzlgkWYZmJ46Uatx9l90C2s/uVIiyvHnvWqqYLzq0TA7JeoDTmw3p8rGUMGPD4oyC88zViC+UUFuZy+loABHUQANnf51dbnCS5I/S1zEz8KKj9BrXUXkw6SoyYl7G4QgWYShvkfmHjBoLjkZKf1C2EO9gw+jQaH0h49xSiXJEqfgxDqc3yBaEATmZZjb1Sdu1c2I3I6f6+MEBqidDfO7xEv/phwCI+iw+ASWMVVNcotf/sMCT8aV7nTgWw6ZcHI11VCDdtYOObeYmOmhNMgFV/IgW8PiiUp2qX9jx1pjbP5yukCONn/4E19IDj3doLMnMAL0XAHpiYLVznzmx6kqfwLAmwE/FHCziyVEil096KEiEXTOsj4xY/bTyFS7V3xXyNR3kyFoQLuZtKRq3ga1wvo6KmJeGY9cxvlCOUKnS4jt3A==;5:7BPemNI6cxQkWi2a5TIRdBgBYh98TIZAVQOL02RNfpF9jPkQz8V9sb87LDjwhEb51TmgT+7lGEXREntnen9DeqKnD5JZ4mc+FihJj79gIqQXJqsbrMP1WnLpYw818fblfy+5KMqqeysIJU7AwM5uqUR5vFtkuKWP+5hcsxO9Y+Q=;7:5oUsZne5EFXF88A+ouX/IwD4RouUcOzdkUBcpHMjSocakfre0f9z7TjFHosiFHV+Quj005NPeIHoMS+gIE1njUU4xW6afxwBmrKfVITuye2H1bFpwDLFKuVgBtfwBDMcn8fTOl+PIBHhmpy3DdbDCSHm31QrUZVu8QR/XfYYxyhajrWknlADnbXBPpQUjAMlsuzLY8q4MZ41AfG/GQ34YcYzmgeQINVfPa515eXzKO1EUJWbSqpRuHh6mR0qX/i6
x-ms-office365-filtering-correlation-id: 56a2e0fb-9f93-42b7-49f1-08d61c4a71a8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-microsoft-antispam-prvs: <CY4PR21MB01202E3904BE2BA50B79DAC8FB1E0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(50582790962513)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(54906003)(26005)(110136005)(446003)(2906002)(6346003)(99286004)(316002)(86362001)(25786009)(102836004)(10090500001)(2616005)(2900100001)(76176011)(97736004)(36756003)(11346002)(72206003)(478600001)(10290500003)(3846002)(6116002)(1076002)(22452003)(107886003)(5250100002)(2501003)(86612001)(4326008)(217873002)(105586002)(106356001)(6486002)(14444005)(14454004)(256004)(6436002)(8676002)(305945005)(8936002)(6506007)(81156014)(81166006)(7736002)(476003)(486006)(68736007)(186003)(66066001)(6512007)(53936002)(5660300001)(6666003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: M9svcr6py6glWbEjcmnpbxACcF4nUYjmseKm4CvG2zvvpgI/GjwkLvPw6ECVjl/h7LPp3WRzUtQxpAlVwC2HxhKz3jFqE6ycyUiHuu6Ua/IPhlR5vyO+1hpLd460qoKdQGatAWUxywGYB000B3qAzcI2cUuwrjOWqqwZ/hwaow78y+OtfWTXJGuJDvcd8XwQxgIcMdMXkUZF4/sSKWMGyAIoMsQozdLpTt+97BPFVJaUAZhuN5ZlgX3bD3VxLJcvs+ShbjBPQ95cT054BG0H5XFQNlt0NxicwBYSLQo6mnjj3tsHkpy4ucftY7x8N8DT0DRXrLodWnmSE5WnFOAXM5I5mIXywCssdT1J631eAEw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a2e0fb-9f93-42b7-49f1-08d61c4a71a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:48.7898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
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
index 0c910a863581..16199b36a11e 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2452,9 +2452,9 @@ static void __unmap_single(struct dma_ops_domain *dma=
_dom,
 	}
=20
 	if (amd_iommu_unmap_flush) {
-		dma_ops_free_iova(dma_dom, dma_addr, pages);
 		domain_flush_tlb(&dma_dom->domain);
 		domain_flush_complete(&dma_dom->domain);
+		dma_ops_free_iova(dma_dom, dma_addr, pages);
 	} else {
 		queue_add(dma_dom, dma_addr, pages);
 	}
--=20
2.17.1

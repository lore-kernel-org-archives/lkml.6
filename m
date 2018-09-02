Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E58C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F9C204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="HAXrrf8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52F9C204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbeIBRXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:23:09 -0400
Received: from mail-sn1nam02on0115.outbound.protection.outlook.com ([104.47.36.115]:45032
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727723AbeIBRXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TYWnHFff13cry22N/YF76e/4CXky+ZM3RMMX0SpmYo=;
 b=HAXrrf8gXWckHnDLTq4UNFmTtCWo6srctKGFX7pvRzHOCpxKhtKub50uyugNYSnLQ/G16g9Z8YT6sP9XivOYvbuF1Je4o8J4y5/PVgci2UzAWGy7JcaInBSL4J/24KM5IyqLwZuLGYaseJDfiZs36dSB0xK09KW/o3NK0FUuO24=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0503.namprd21.prod.outlook.com (10.172.122.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:07:12 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:12 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Huaisheng Ye <yehs1@lenovo.com>, Dave Jiang <dave.jiang@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 44/89] tools/testing/nvdimm: kaddr and pfn can be
 NULL to ->direct_access()
Thread-Topic: [PATCH AUTOSEL 4.14 44/89] tools/testing/nvdimm: kaddr and pfn
 can be NULL to ->direct_access()
Thread-Index: AQHUQr3VCrXnTA713UOHlOfvuZQ2JQ==
Date:   Sun, 2 Sep 2018 13:07:00 +0000
Message-ID: <20180902064918.183387-44-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0503;6:4zXXiJxyndy1v7RH9sM1+K3bMLD0QogcBz0IqGuqEV43tSEKCF29fH1rs3UsRiXQ5/M+TYUsr5OzvZL9HaGq/wF5PrmQydQpX1v2wNhZ37OHAeRBUwvZykNtIkKLWfOiZ0pQl+uD0G0ydOr3TuQsc4WRDSEyJW1WD/XpVX2c5bABgLbczrIH5d+DGf6LuJZt9Yty4XE8ZQqGoWdqyAVk/7kIXStu3AwadBCNfqbgZEMd5BRuR1WkKgPnBJL+ySBeXiSy45FnPB1Up1asQHlV010LZQ6fQQUs+e6iLa4Q09xZDXa6+ZSOpfsoozO+yheTOBchhRi7U6FPQtIc4aHryoN7y1vzjlRBhXRswFGzOuF4uyfnn9xI2DrNuskViMx6XOAlTYTf4kSytp5GJgLjbN7tpB60FWuoZj1cZDQXQzY8E91eNEVs7snXUNzA9FDNYfGhjoj2RWRlHWDJc2tacg==;5:MGvicBADMmnSbg4VLaCJ8d65VGtA9nsMTTqOCKkydQw7gbziI2TC/7iJd+CZZRESDX/YLz6PZGMBaDqZpiiW5n15nEMRDVVfVmi8XGavCfuQQlAUWCJa3D6F4WBuMNdoqSmYFxmaqRlXahcwmRZ9KHYMEREVMzgw732g3IyUEgo=;7:QM5IxU0I1WpAK5E9RSPg++hrX3yXgcQI9nEJtblXQK8kRjQ5GpRue2k3kOo8le9fExrF3/2kC3TSwk0R7aNiBt6GNHWwR1FRXdJdZHv3BTiUtvCydB34K6d/qZZzjxJFF0I82Wh31/PcnKbVhD4bDRfz/XZLQ/fRm3MGAKhkQTojYAx0EobgLhwizvbj3V6HzWjAqzMuVajkCcVENwaad6gIRw991nYz2CZSoeprHziFyeNgerCUndx8OPtEmu4U
x-ms-office365-filtering-correlation-id: 18c32384-a4b3-43f8-9c60-08d610d4ff5a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0503;
x-ms-traffictypediagnostic: CY4PR21MB0503:
x-microsoft-antispam-prvs: <CY4PR21MB0503B46BB83FF15061DC91DDFB0D0@CY4PR21MB0503.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(3940261145250)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0503;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0503;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(376002)(346002)(366004)(189003)(199004)(105586002)(8936002)(102836004)(6346003)(68736007)(2900100001)(6116002)(217873002)(186003)(36756003)(81156014)(81166006)(1076002)(99286004)(26005)(5660300001)(66066001)(6666003)(8676002)(54906003)(256004)(316002)(305945005)(22452003)(3846002)(10090500001)(7736002)(110136005)(14444005)(106356001)(2906002)(6506007)(10290500003)(2501003)(478600001)(2616005)(72206003)(6512007)(53936002)(575784001)(86362001)(86612001)(107886003)(6436002)(14454004)(76176011)(486006)(25786009)(476003)(97736004)(446003)(11346002)(6486002)(4326008)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0503;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: EOZU4gWDayAv3UGfXiYKY6y57kIjH9F+08QVIMg5v3dbvH+NrZJHhhUMx36vkorU6EALkH4XJUwC/P5EdmkNnqhSPn8j2ht1s9MjCdHEMbuJ262weOLhn0Lq1AurT/HssynNElBbRySjfowPhxLOxEiWtFK0w9xpsBFKtlXj3mEasg7VUNgmsFSORxoN3Il1YLrYPgp6XYqNyxDpCTuxgQWEjWGGiMsX84xLPm4wcCneISvkI7DX8bFNSdBjsRVk6uxOEvNEMwhZVTazTRx6AzsPG7W8j4QKDTyWrnCCP0fwagOXbiWjDNQqPmax8DTjxIci9mqLK4EmcseIH4fi3VUIKdHgyFkIYNINFlX9ndE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c32384-a4b3-43f8-9c60-08d610d4ff5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:00.6616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0503
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

[ Upstream commit 45df5d3dc0c7289c1e67afe6d2ba806ad5174314 ]

The mock / test version of pmem_direct_access() needs to check the
validity of pointers kaddr and pfn for NULL assignment. If anyone
equals to NULL, it doesn't need to calculate the value.

If pointer equals to NULL, that is to say callers may have no need for
kaddr or pfn, so this patch is prepared for allowing them to pass in
NULL instead of having to pass in a local pointer or variable that
they then just throw away.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Reviewed-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/testing/nvdimm/pmem-dax.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/nvdimm/pmem-dax.c b/tools/testing/nvdimm/pmem-da=
x.c
index b53596ad601b..2e7fd8227969 100644
--- a/tools/testing/nvdimm/pmem-dax.c
+++ b/tools/testing/nvdimm/pmem-dax.c
@@ -31,17 +31,21 @@ long __pmem_direct_access(struct pmem_device *pmem, pgo=
ff_t pgoff,
 	if (get_nfit_res(pmem->phys_addr + offset)) {
 		struct page *page;
=20
-		*kaddr =3D pmem->virt_addr + offset;
+		if (kaddr)
+			*kaddr =3D pmem->virt_addr + offset;
 		page =3D vmalloc_to_page(pmem->virt_addr + offset);
-		*pfn =3D page_to_pfn_t(page);
+		if (pfn)
+			*pfn =3D page_to_pfn_t(page);
 		pr_debug_ratelimited("%s: pmem: %p pgoff: %#lx pfn: %#lx\n",
 				__func__, pmem, pgoff, page_to_pfn(page));
=20
 		return 1;
 	}
=20
-	*kaddr =3D pmem->virt_addr + offset;
-	*pfn =3D phys_to_pfn_t(pmem->phys_addr + offset, pmem->pfn_flags);
+	if (kaddr)
+		*kaddr =3D pmem->virt_addr + offset;
+	if (pfn)
+		*pfn =3D phys_to_pfn_t(pmem->phys_addr + offset, pmem->pfn_flags);
=20
 	/*
 	 * If badblocks are present, limit known good range to the
--=20
2.17.1

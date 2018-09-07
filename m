Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E726C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC5D20857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AqfLdduV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC5D20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbeIGFOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:14:16 -0400
Received: from mail-eopbgr690135.outbound.protection.outlook.com ([40.107.69.135]:4506
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727650AbeIGFOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6vOhPLqjQZXakXI0fZexhlzLC90QjCctp+3JvWxmq4=;
 b=AqfLdduVClzUjp3wl9aLVLi/sy6+fs6xfwwY88JU9fQE3wkxe9+gKDuttFsLzY1Lop/2nhhM/bP30H4XfqUQGTNj7ICNtrF7unEAnqjfWJrUU4SvFV9t1sBZFSCrqjsT6jMQ4hQtELzNzNOM5pAj8bJxHb9MjQalJMI2Yef1jj4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:35:57 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:35:57 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 06/88] iommu/io-pgtable-arm: Fix pgtable
 allocation in selftest
Thread-Topic: [PATCH AUTOSEL 4.18 06/88] iommu/io-pgtable-arm: Fix pgtable
 allocation in selftest
Thread-Index: AQHURkK+wia+TkXp5kmifMa/Px+Cpw==
Date:   Fri, 7 Sep 2018 00:35:57 +0000
Message-ID: <20180907003547.57567-6-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:xw7rYRJx+kqnhKYZIGdrSRrRbdVLblctL1zrITnmE8BB1gcQh8AwYqLdYPsNkTOlggxp/cI0EE3giz9F6EHuW31dCtT+yrEgvxPKXV2RMqq6Is4kG/TadihaBPNX8ghe6qck9bsCRqqkeeybT7gkpcnbyKxIPZZ2ELLqqKvWDrOIr0sqk328OpmHL9uCtTFvTu4XKlT5aJQ8IyX0yuFHHqptZhS78tNhGnUMRzbab4x1F6o/Q8/5FB/ci1UCZLB3g7GWnbMXFPYs+u3ANm5ajy6Z77dmX5hFFLliHuLdYn3lTL/R2QjTljiya9M+RNX7blw/i4DiJZZ5pSHkVYSQYvbxrIkrf9TErLeuDfoauGOpLuCqEsvPdpNxswP90K6UA5uUGFLo6LHN8LbZHFEWKaWdDi31dW/B99Pb8FW+lFVFYl9Zb+wY3U9R/JSLBZh4mFedELXC5n7FsZD0yht3eg==;5:UsvTkRnwvw0zcas3pJchlCkuBtGlTNxRRWfL5lE4L8B8er4v2jZQoERBSyYSBU3gvvvvJ8FbpYpl/Te8Fk37BgcmqlLXctAY8hB4EP8l5kC2dLooXYG4zgNqF6lCpZDmio8xa9yOSg8Fcr0vOiyGMyQWcmif/WHIJdGZbIrSWKw=;7:JxsqyH5GIph1aGIisaOzFrHUov0ESDU6Sbmk6rlWsLhazi8tsRzl0PWxhwaxxe5ChbDIEDmB8x8c1Au655A8GjG5kHK15fSimokCgMK4uV4/ZafNtv4wtaAp3wuXH/AbeBd62ptMnul4QCnlKHVE33G9pJuWyL49rgp/KKlG5AidT4XiWwF7VJz7wb/N/wi/eeVTlS1zMpTOtmaGgDOKwjVUUQcafGQemm8aF/3O8veh5YVxt5cH1+AeuCNxt8B0
x-ms-office365-filtering-correlation-id: 37f2a640-b23c-4db5-4c79-08d61459e0b0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07735B3441D0BC576B07481AFB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(2616005)(476003)(4326008)(11346002)(5250100002)(107886003)(2501003)(86612001)(97736004)(6512007)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(14454004)(1076002)(66066001)(26005)(575784001)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(14444005)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UIyYyCYVE5zLrGvJpJ9HhW9ojBgOtLoavD3nuKLFmVLANZgvVb6Er1f6uBbS+12UkX19MWfzLGTE8BUFHL/AcnkLN0x96vVvbzLdn35eeeZz+YVkuqDY1hehtlt3FdDxF2hMKI2Bgwu5MfBJ5Q1htYPLjQOi84LdBJBy/CwFAb9iwSutAXdQKy6EyBow6iTO0+gHTEPVmPT7aWvpe4go2ZT1n5PhQNO2/sxizyY71XQ57Pjz1/uPgrKqvGpIy2t2tTnogMHfDV7j5JNJTiAer/wU1CMWwlSmfvqsuP4B84+gTQdYHR2eNoSWcxcUgVxyYvWRR9LX+++f8cQsRQ3GsUrN32XhqVRnm9VxcTf6S7U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f2a640-b23c-4db5-4c79-08d61459e0b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:35:57.1627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

[ Upstream commit fac83d29d95471ad6a104f8c0d21669a3d59097b ]

Commit 4b123757eeaa ("iommu/io-pgtable-arm: Make allocations
NUMA-aware") added a NUMA hint to page table allocation, but the pgtable
selftest doesn't provide an SMMU device parameter. Since dev_to_node
doesn't accept a NULL argument, add a special case for selftest.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iommu/io-pgtable-arm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.=
c
index 010a254305dd..88641b4560bc 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -237,7 +237,8 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t =
gfp,
 	void *pages;
=20
 	VM_BUG_ON((gfp & __GFP_HIGHMEM));
-	p =3D alloc_pages_node(dev_to_node(dev), gfp | __GFP_ZERO, order);
+	p =3D alloc_pages_node(dev ? dev_to_node(dev) : NUMA_NO_NODE,
+			     gfp | __GFP_ZERO, order);
 	if (!p)
 		return NULL;
=20
--=20
2.17.1

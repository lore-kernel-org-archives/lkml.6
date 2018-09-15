Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46460ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5211208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Ctpfs9V9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5211208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbeIOGrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:47:05 -0400
Received: from mail-bn3nam01on0134.outbound.protection.outlook.com ([104.47.33.134]:14354
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728172AbeIOGrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPQAm1oj09a5WWH3QrvVyFyQBjm61Ky10Pr688Tq4g4=;
 b=Ctpfs9V9RYsC5y6OvISzz5VmIik2b9QZYKQWwCWGURcYaWZKrCoZEI0AZgt0x+ukjUT4cdqUO1O/bE23XqLEm0jnM4zn54JIr0SUYjL5nylrvgdNQjsP7pLbp2fVTi7olpJXshGheD0z/nR9oYofjJwEUbs8jQylc1kHas2VfYc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0840.namprd21.prod.outlook.com (10.173.192.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:29:59 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:29:59 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 16/92] KVM: PPC: Book3S: Fix matching of hardware
 and emulated TCE tables
Thread-Topic: [PATCH AUTOSEL 4.18 16/92] KVM: PPC: Book3S: Fix matching of
 hardware and emulated TCE tables
Thread-Index: AQHUTJOebyttoVZ53UiUL1zV2zciQA==
Date:   Sat, 15 Sep 2018 01:29:59 +0000
Message-ID: <20180915012944.179481-16-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0840;6:YVbsF7YgZ3pK2szyPd2pI2txypp+9QPl0OqfELI/GeKjFxX+c+hC/oO25/XunElOO1AH51S6WpKNMmrwTzT/2hDdhK6Cm4WwdRglIU86wFvsWi5xraKPOxJMowGhzPiYy3KFamWsi8O/C9qD2yHpLupk6dH+dRkkt3h6GO9dnEiRkyj9x/mpyxqvF/n5sJSJ2pBq67rbUHnNh16aMlxtNaS0UOoCyFnAVPJYb7ffibELKgz99H48wDlX/bQ76jqQSQv6X40L5cWDLi4f9zNzebbiubL/du48VvfxFQCmlI4ZCma0WBNHAeYHpbazTDfmiIGGuC+GV0traXIwiqhorzmZuHJpNm0H2vD/pwrQ60xbJmo8/VP27RT2gF6e5+z+bjyoFopehwU/IN8NGscBq0SXsrwvoxGhDTZLGNGLmnEjba7dzUYH7h8zO3AsvFQlWCh3gQHUZhBAtwS08TJqYg==;5:TJZLVDOzy2JA9azszttFZP8mZsNHiidDzeJv/El80GVLpBuc4MJZ/PCcpXDkn5XWIrQ2seIgjEjk6cMvVIubOqwIxlBAAQlOlzthTJFxy8Pe5j3lEMaI/UkHE56Dh4I5HbvVMC3TrmD/4Bk2S++aQzYJFQLgEb+yt/0Rr/SHwSM=;7:pjgYpt9TDoDtkIUnzOqv/CrhFzMBXDXeOOgCpL1GdzZTFHbn+ddXYIt4KOr8IcPqst64XYjPpmpLab+Nqu13J5tiWFzQEj9PbU+27Az1Q2kgR1E1/U9wm34/NWlXyTwD1+RbDqwxWc4iCvx5lOrOf3nGP99gG1TORBhn9XdksipWeC8uUNTGAwzmdIAwz4wHYNZvVCLFry1C6iiAcsvV5/Zy1aYcdQld1XTNi17rhynV0ryuQtEJOLKXD+0mBws4
x-ms-office365-filtering-correlation-id: 9ad1d77f-d005-4f51-5a1a-08d61aaac09a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0840;
x-ms-traffictypediagnostic: CY4PR21MB0840:
x-microsoft-antispam-prvs: <CY4PR21MB08406EFE93F210F0DE84D0D6FB180@CY4PR21MB0840.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0840;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0840;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(39860400002)(396003)(376002)(189003)(52314003)(199004)(14444005)(6116002)(81166006)(2906002)(446003)(478600001)(3846002)(8676002)(106356001)(105586002)(4477795004)(10090500001)(22452003)(8936002)(5024004)(486006)(2616005)(72206003)(36756003)(11346002)(81156014)(186003)(26005)(14454004)(6506007)(217873002)(4326008)(25786009)(256004)(107886003)(102836004)(6346003)(476003)(1076002)(10290500003)(575784001)(86362001)(66066001)(6436002)(6486002)(86612001)(53936002)(54906003)(2900100001)(97736004)(7736002)(6512007)(305945005)(76176011)(99286004)(2501003)(5660300001)(316002)(110136005)(5250100002)(68736007)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0840;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: h6pGE/WDPkLu85pdvyO2dKWYkUOc2ldtMcyeJD28KdNHJBw1eaaylnxXMMaAZk9o32Dsfuwm88gOh3325OWNiVd6r+5mIF1cTXGtSX4cQugepQc6YGEWKCB6DUblg645MvRvx+I8SgSxujSg3dKX1qiUBP/rxWa5zu/2HWdY3PhIQNvfVdSP4GGchXSyyFxH6LxQ7RbqPuMmr2gefkXnvqMW6jprkK4YwU4JOnKTvLSbJRQnozQlnaE61o85Cp5zlFoljbfR86WFWw+z12e7VhqI9te37ZRuKIMbgfQvZJUvpao1ZuXr01Rk63p3uxmG0mCR9pb0YzxgOfCHCNUyr2MD2kyOfcku0Q1xqOHVZos=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad1d77f-d005-4f51-5a1a-08d61aaac09a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:29:59.6669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0840
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Kardashevskiy <aik@ozlabs.ru>

[ Upstream commit 76346cd93a5eca33700f82685d56172dd65d4c0a ]

When attaching a hardware table to LIOBN in KVM, we match table parameters
such as page size, table offset and table size. However the tables are
created via very different paths - VFIO and KVM - and the VFIO path goes
through the platform code which has minimum TCE page size requirement
(which is 4K but since we allocate memory by pages and cannot avoid
alignment anyway, we align to 64k pages for powernv_defconfig).

So when we match the tables, one might be bigger that the other which
means the hardware table cannot get attached to LIOBN and DMA mapping
fails.

This removes the table size alignment from the guest visible table.
This does not affect the memory allocation which is still aligned -
kvmppc_tce_pages() takes care of this.

This relaxes the check we do when attaching tables to allow the hardware
table be bigger than the guest visible table.

Ideally we want the KVM table to cover the same space as the hardware
table does but since the hardware table may use multiple levels, and
all levels must use the same table size (IODA2 design), the area it can
actually cover might get very different from the window size which
the guest requested, even though the guest won't map it all.

Fixes: ca1fc489cf "KVM: PPC: Book3S: Allow backing bigger guest IOMMU pages=
 with smaller physical pages"
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/kvm/book3s_64_vio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_=
vio.c
index 8c456fa691a5..8167ce8e0cdd 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -180,7 +180,7 @@ extern long kvm_spapr_tce_attach_iommu_group(struct kvm=
 *kvm, int tablefd,
 		if ((tbltmp->it_page_shift <=3D stt->page_shift) &&
 				(tbltmp->it_offset << tbltmp->it_page_shift =3D=3D
 				 stt->offset << stt->page_shift) &&
-				(tbltmp->it_size << tbltmp->it_page_shift =3D=3D
+				(tbltmp->it_size << tbltmp->it_page_shift >=3D
 				 stt->size << stt->page_shift)) {
 			/*
 			 * Reference the table to avoid races with
@@ -296,7 +296,7 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 {
 	struct kvmppc_spapr_tce_table *stt =3D NULL;
 	struct kvmppc_spapr_tce_table *siter;
-	unsigned long npages, size;
+	unsigned long npages, size =3D args->size;
 	int ret =3D -ENOMEM;
 	int i;
=20
@@ -304,7 +304,6 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 		(args->offset + args->size > (ULLONG_MAX >> args->page_shift)))
 		return -EINVAL;
=20
-	size =3D _ALIGN_UP(args->size, PAGE_SIZE >> 3);
 	npages =3D kvmppc_tce_pages(size);
 	ret =3D kvmppc_account_memlimit(kvmppc_stt_pages(npages), true);
 	if (ret)
--=20
2.17.1

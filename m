Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA02AC64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656AB20666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dkEfIBtl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 656AB20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbeJAHOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:14:02 -0400
Received: from mail-by2nam01on0099.outbound.protection.outlook.com ([104.47.34.99]:20832
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726694AbeJAHOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Orgsm7+EoQxhllauXDvZ3VnvhljV2sf3l0mAyehGLF0=;
 b=dkEfIBtl6/aD3/2k94gmt9htquU3eTyr7Nq/e1pe+nh2O4jNDLJ5gEUIEgqfP2zmPDYwsj8gDhOklEZbkWlvm7hQRAYJ1UbUzfNIRVB+b01KdZQwqjGNrfzotPGHrbkRlpugiIlg9v3R4erS67wXmfdotYvCIRr8R9lq8eYubUg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.6; Mon, 1 Oct 2018 00:38:52 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:52 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 31/65] drm/nouveau/mmu: don't attempt to
 dereference vmm without valid instance pointer
Thread-Topic: [PATCH AUTOSEL 4.18 31/65] drm/nouveau/mmu: don't attempt to
 dereference vmm without valid instance pointer
Thread-Index: AQHUWR8OdXqAuG5GSUeCopOWk1pivw==
Date:   Mon, 1 Oct 2018 00:38:21 +0000
Message-ID: <20181001003754.146961-31-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:DWEvQ1sWwWWDuaQm3IX6w7B7sqtZpkSmfLy3yTy0GqsUvTrt8H4nxQnX8c8atDi0rSnAQGa2v7u6lAR2fLHB5P/05V3kzbEmq1EHNXh/JKNJmMDKh2uuTOHzlzrHkcLL5E5OHWMIpSMH4WcFtTx9+hGWhrd4+Tofjgn8vCMpvNYK2GIc9auZU9sTWcbqfE7uF/0ocDSXMo2Gyn0jKvYKRa5WJRcMKFB8C4rX1wXbDE+7egUiZR8m9NkGzbb3yAQc6sJhXzJARJRiwowwmmplgM3LUidtrkGvoSZ9JrY6E/VlC5ve1xF71DcxgYK9Lkc0ELbUGWuTz/4LFdRkm/wNPPVvw9oBWNhnKEhr+w6GraocXaRbsPPanctcSv/R6xbDIeYhVxhG4uUtNO/I9fibNf1SlBKo5k7TDwslcvOUFCorIbPkToxZEeXqWAwxhDZeb05k7zlUDF77LMdzhZSCAQ==;5:G4TC04f8gn8/imcTMXt6y3QTNXILhBzu0/0X21sG/V7cllj633PcZjDcfY7dPzsyVUHJTn64vRdVGQuuRaV73mIf6PKK2eT9qeZE5Y7PbL9WPFzC121xGIc/k+luUGIIxGrAjDbEdMQGrqWxi7wtGVKDbvxK+VTf0jix7awCt8k=;7:+EY3rPpR1W9N8Yc3cF3wL9uxVTrMm4xVrWr6uXgc4bqnHTS2DOTAAqi4AEMVAfjwbnLE1Qu4anUJOz25dQS64sf95YODqgSsBYJh9DBpOt1DbaRbkqweUjBElBWuJ0K4yCNIOQgs0DCr7g+QR3V0bAdHzBWDEbHQ9gK3JVtT2V1+RLYiaVUXDxR+TbIdYqPAodWQKoYGZ27qfj+TSXBaCMrE8wYBy5tpkUyD1oZ4sV8Bw7qZl6nBOrdY1hi+41Ik
x-ms-office365-filtering-correlation-id: 3386a1c6-5a5b-487b-d048-08d6273642f5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0181289A661F070F5985166EFBEF0@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(346002)(376002)(366004)(199004)(189003)(6512007)(71200400001)(71190400001)(6116002)(3846002)(2906002)(6436002)(1076002)(34290500001)(446003)(7736002)(478600001)(11346002)(53936002)(6486002)(66066001)(25786009)(2616005)(4326008)(476003)(81166006)(106356001)(72206003)(102836004)(86612001)(486006)(10290500003)(2900100001)(6506007)(76176011)(256004)(8676002)(217873002)(14444005)(97736004)(6666003)(107886003)(105586002)(81156014)(99286004)(54906003)(110136005)(5660300001)(2501003)(14454004)(5250100002)(22452003)(186003)(305945005)(26005)(68736007)(316002)(36756003)(8936002)(86362001)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FzCxaJZwZGIL2KcEeFKWobRe0Bf8QQm6mBaiUQNPQ9PQRoyNvwMnWgG1IN3Nr90Xg+iCL0TiUUQA8IXhQIzi3cmYzHyKTvszGk0xdV2a3yQ1ET6XFDcaGH7//9DmDzx+39vQrmph72VzBHy8y7z+L9Qv8mlPDcsOOBEuHZbORe0yFAS4NUx1DQNnkNYqJiafMBM3Le3j0CHtRx60dkteDGmIXY81Q3xG0ksVK5Izy9vylD3grD8YFTJceGMmnuB/bGQUXuD9Q6t6jkdzUg7W4ry2GxJu1vJMngm/g4crpDjQ8ki8PUYNofBm55vnOJmIM2++z00t2/fRNSCJX6jh3eDIR32KGTgP67fbI2qr14E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3386a1c6-5a5b-487b-d048-08d6273642f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:21.9854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Skeggs <bskeggs@redhat.com>

[ Upstream commit 51ed833c881b9d96557c773f6a37018d79e29a46 ]

Fixes oopses in certain failure paths.

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c b/drivers/gpu/dr=
m/nouveau/nvkm/subdev/mmu/vmm.c
index de269eb482dd..7459def78d50 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
@@ -1423,7 +1423,7 @@ nvkm_vmm_get(struct nvkm_vmm *vmm, u8 page, u64 size,=
 struct nvkm_vma **pvma)
 void
 nvkm_vmm_part(struct nvkm_vmm *vmm, struct nvkm_memory *inst)
 {
-	if (vmm->func->part && inst) {
+	if (inst && vmm->func->part) {
 		mutex_lock(&vmm->mutex);
 		vmm->func->part(vmm, inst);
 		mutex_unlock(&vmm->mutex);
--=20
2.17.1

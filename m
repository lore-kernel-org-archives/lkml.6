Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FB2ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB08214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="kcEDagMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB08214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbeIQIbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:31:51 -0400
Received: from mail-by2nam01on0133.outbound.protection.outlook.com ([104.47.34.133]:45216
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728659AbeIQIbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8aqqhK3Oj4/r4f/uVu4Udpl/T4Ng7H5uZU0YdLgu4As=;
 b=kcEDagMZhT9vEjr7BZr7LhY3koF/s++A5V/Zeq0+yA7TaUA28ooFOFp2gnuAq9H2+W89ZHRSpUtPfeOOTbL1ohmb3Gelh7Z7Iy5RXwTh9OYeGddy0HqiYKp1OMTXBX6S4Ymyr9pCJOzamwx4SmoI880FI9eaCaVmF7Wlb9JfM+M=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.6; Mon, 17 Sep 2018 03:06:19 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:06:19 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Alistair Strachan <astrachan@google.com>,
        Todd Kjos <tkjos@android.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-team@android.com" <kernel-team@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 35/57] staging: android: ashmem: Fix mmap size
 validation
Thread-Topic: [PATCH AUTOSEL 4.9 35/57] staging: android: ashmem: Fix mmap
 size validation
Thread-Index: AQHUTjMXIbV/+KwUSEinZ13zhg0SYQ==
Date:   Mon, 17 Sep 2018 03:04:04 +0000
Message-ID: <20180917030340.378-35-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:JMt8qGS4RMs9N6ja0Hmer0f/rf6vGyqOtnAyu8bEHGUDIRgKBHuAQq1EvZUlXg65CbPlTfoOg1j3SMVnWs2M7GWd+vg14P71/Tyn26pozz2qsgL13CtV9kMfxCaQzzLZVQCejtUecO2myyaR1PACxE4gXn7HDc0bLi6VKxoNBX4kRVm2hqv6r6iaJfO5gqNBBNayfPY2R3HNvics+IiG8JW1ZtDWN477aZ3D6VMYXWDw67TDDf3c076TsxNof5CbrT9jKDqbUtXU3XPOpLmHkOFjS8tUkfGZP2+zdSSQnzwcqvHiclGeN4fNxKhWAPwyt8WxP2YouP5K8P4hRq7T/3zlKGDI1EPoCsR4R65GB/FivIgwirpQwjL9+UKMn7yAMPky+d1sL4NK4DWaIvg50Bx/O/lss2EzwjBu5rqvWB+j7MmfylbU2LGxh6yw0vEzzqLSPNFATv2KK+lhXyIuUA==;5:grMR6ga4sIkwqbw1fNAgBkTO6L35rAwwPj4AzNZJyhg0PUhOJURvNV9n1CGWBc8gFEBR81x+KDKf1/LJxZnv1NGxV5TEaM9VcCUIBd4hrRjkOisZt87r7rb6MjuRPr8KhodBlPR/AuDudvc7S13pSvu3XbHzF+rGt4vjK0oTo9U=;7:xRg+DKGeQ42Ykt0DWVjatrpssTsi5F5KrukJOdsfawAk4GuxFkPW/m64+nA7nnb2/ZvdKyNnvgg8u4T6OWyz7Uv18pdmsfqCATutudV9p2Kcde14LIWmYgyprewhUF2Sq9C2/DcfEKBq8EgFSHLwvxkFIMQSldo5aWmpwofwuE+GvfEJOTTgU3Er2FmfMfIV2/f+NqiHG6f86MMlDp/ivCxh4vzuukUJc7De14+xt29vbZLeIEfhaXwDIPdVwzSq
x-ms-office365-filtering-correlation-id: 7c81fc22-72e6-4cb4-c667-08d61c4a8a2d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB0757A90DED84C6F93BA8C55BFB1E0@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(211936372134217)(153496737603132)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(346002)(376002)(396003)(189003)(199004)(8936002)(68736007)(476003)(575784001)(10290500003)(446003)(53936002)(11346002)(6512007)(486006)(86612001)(6436002)(1076002)(256004)(6486002)(2616005)(81156014)(81166006)(7736002)(8676002)(217873002)(478600001)(305945005)(3846002)(6116002)(86362001)(4326008)(106356001)(66066001)(186003)(36756003)(99286004)(76176011)(102836004)(107886003)(26005)(2906002)(5660300001)(110136005)(54906003)(10090500001)(22452003)(72206003)(2900100001)(316002)(14454004)(97736004)(105586002)(6506007)(25786009)(6346003)(6666003)(5250100002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 7nr7yu2ug2oIsaE9C+rupv+3UoicNhjjjG5FofdIVNZUOfZKs6ldjzcJmvmWKD4wlivQuRfKZb2u+ob58/oHImGWJd4wBSuTwENMAwPo0m6cW6dQnDgyDwIWjOgwt7LUyT3pYaSqG0E1pa9Iq2XKIapFLCdzmQQIJ1Labk2698GEaP1hJw8GJK6lQsCPE6VE9CnerzyYIwW0dUC0lFECfOSqEwVgKyLkJaI51bx1jWdRNR/8jWbuWinNckuZR+hIeibSN2n9kSXDXK2Bz7nSPpBFaowNVBzUpUpANKOs5+thcgIzQIVTO6njrjwUGcgc1x2mSXd3J14zF9zoOxKFuj4SUMFyDmjHjOKNWgVK8TQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c81fc22-72e6-4cb4-c667-08d61c4a8a2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:04.9615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alistair Strachan <astrachan@google.com>

[ Upstream commit 8632c614565d0c5fdde527889601c018e97b6384 ]

The ashmem driver did not check that the size/offset of the vma passed
to its .mmap() function was not larger than the ashmem object being
mapped. This could cause mmap() to succeed, even though accessing parts
of the mapping would later fail with a segmentation fault.

Ensure an error is returned by the ashmem_mmap() function if the vma
size is larger than the ashmem object size. This enables safer handling
of the problem in userspace.

Cc: Todd Kjos <tkjos@android.com>
Cc: devel@driverdev.osuosl.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com
Cc: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Alistair Strachan <astrachan@google.com>
Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Martijn Coenen <maco@android.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/staging/android/ashmem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ash=
mem.c
index 6d690e5fa9bb..c6314d1552ea 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -383,6 +383,12 @@ static int ashmem_mmap(struct file *file, struct vm_ar=
ea_struct *vma)
 		goto out;
 	}
=20
+	/* requested mapping size larger than object size */
+	if (vma->vm_end - vma->vm_start > PAGE_ALIGN(asma->size)) {
+		ret =3D -EINVAL;
+		goto out;
+	}
+
 	/* requested protection bits must match our allowed protection mask */
 	if (unlikely((vma->vm_flags & ~calc_vm_prot_bits(asma->prot_mask, 0)) &
 		     calc_vm_prot_bits(PROT_MASK, 0))) {
--=20
2.17.1

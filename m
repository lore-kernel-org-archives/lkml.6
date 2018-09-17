Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C2CECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9146F2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fqY15Pxj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9146F2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbeIQIcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:32:36 -0400
Received: from mail-by2nam01on0104.outbound.protection.outlook.com ([104.47.34.104]:36220
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730359AbeIQIce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:32:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DW2CVHY9HsSBUTcsmz0qzQA4viIZKXrsrnnA6XPAIhs=;
 b=fqY15PxjJeffUq3T0zxEh740aLzUwH7Zh9emxZ9ufwCx3cN6L3Z120pLPB1KsiTM8nbvOc33dGr0qtBjnTXHnGO4KTVkHjT8aPCaL4zcOw3PR7lro2Bz2D/R4Qi1cQSPLpm/lalSeG5Q3s5Z6dLewpXQI3skzJEIQZfcj3pSMW8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0759.namprd21.prod.outlook.com (10.173.192.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.5; Mon, 17 Sep 2018 03:07:12 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:12 +0000
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
Subject: [PATCH AUTOSEL 4.4 28/43] staging: android: ashmem: Fix mmap size
 validation
Thread-Topic: [PATCH AUTOSEL 4.4 28/43] staging: android: ashmem: Fix mmap
 size validation
Thread-Index: AQHUTjM8ZFgq838WGUqvVZCEaCcORw==
Date:   Mon, 17 Sep 2018 03:05:06 +0000
Message-ID: <20180917030445.484-28-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0759;6:C8KU7ZK7OK1FXEIu1uq7ZrZhO2n5VyYcBOroyOKxF4OuqW+47reml1blT4eZu/x7wFym9fSFQP8EMWqL1jg1pFRM5uDXJSIQvQsIFoBpMysFAJ9tlcDhjbZUCnykZ+Xgm8qTfLwja4oeERc8bm3wNF2U8y7Ag4CJ78z8orunr0EIJ0OsyRigkmHqegPiJeHqycud+JyEVnj39qhyVMw221fadVJVvPox4MsXh7CUL333QCnLB0d69KlkM8z3yezXv+hahZCWmHJFg/ZQVY4YyckexRqL8qymLC4Jy3QgKS2OtAwaKXAhr1AOk1uk5Tolqkxo4hFJ7NY5exjAB/hm3LNBKYVUklvdYC9SLJoSR9NwH7hv3BId3XuMw2aWIpL1l43qCWBzXDgjdusbxuWTKBJJ4GxwTnIQp3YcCVb5+oC9gfkiZXI2lwHcww8lFUkldm1s7mWCZVIgQTYOHlxPGw==;5:B1OsVh0G1s3Ci6VTVzeO5HdBjqiWJ3WHEM14oqvhjIzO+l3s5mZUg9Xyp4frjrLuPCGQ52s1kV3ANYFU6Z5MxTmLB4990X+Si+nqNU0h5UQ3IYlJoAQhCaNDGbww4Bm9Ors0UdTKJLxNZlqUcn8Mv4pb2Dxk9f1HyIff96w1KU4=;7:/2IHCihwQtCV7K6qr8txSG11bWBEf2jzJ7HUeMknQPIyIsG3UMYBlvmJS9tglN2xV5pHCy8I1vFAyEHPyNFQfIPhtSJu5+XUlatZWIKZlLlEDjO1JQBpBItXzUu7+e14V2qAdWOfw6aAzS+tApSZasi1KExuE2PgRowKLVxAKAJaJGfzzGsqYArjvngUYpEwCrVWBxSx8nRXvYajUdcyC08KDw37WV5DxGhQdlaCfEp1LD4H4vxzV0lOYQBTNI8c
x-ms-office365-filtering-correlation-id: 6522a9e5-d288-44c9-7a43-08d61c4aa9e1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0759;
x-ms-traffictypediagnostic: CY4PR21MB0759:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0759F6DC49827E48794D4850FB1E0@CY4PR21MB0759.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(211936372134217)(153496737603132)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0759;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0759;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39860400002)(366004)(189003)(199004)(2501003)(2900100001)(305945005)(7736002)(5250100002)(6436002)(5660300001)(53936002)(1076002)(86612001)(6512007)(2906002)(6116002)(3846002)(6666003)(6486002)(86362001)(575784001)(97736004)(10090500001)(26005)(54906003)(256004)(106356001)(102836004)(25786009)(99286004)(105586002)(6506007)(446003)(478600001)(10290500003)(72206003)(11346002)(217873002)(66066001)(68736007)(107886003)(4326008)(76176011)(36756003)(486006)(2616005)(476003)(316002)(14454004)(186003)(110136005)(22452003)(8936002)(8676002)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0759;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3ss5zmrsqClUmJhWTYnW9QxFk93XkhO0ut9bYpxGQNlCL5spNu/Hel8hQKgaGSsImMMQT9HDC2u+Dndw4Ds5Sc8BNNq2jRpd/BN732vdpMWvDoNc7blOcI12TfN5wys11vhugWUhzPCJz4e4JtNAApxCh4p0PZ+tAjzWG/L5ou8W7Mzo0CjGraAiwXoJ4lhWOeOghHeVzKjC/d5lsOrXXt/8led+3ezOwtBfAHwEONw9hcY1Mi5vzfSixO0bLXvEePDo1JKmy9SQRsS8KC2nDPEjoYphxoHy/ntLSEw3PPop2skamJ5sgobjFLhYva3hG5JxWZrDaoMg85IWq4f3q4MwQ5/LDoyIsiMpmCZq2KI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6522a9e5-d288-44c9-7a43-08d61c4aa9e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:06.9610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0759
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
index 013b33760639..e9c74c41aece 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -370,6 +370,12 @@ static int ashmem_mmap(struct file *file, struct vm_ar=
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
 	if (unlikely((vma->vm_flags & ~calc_vm_prot_bits(asma->prot_mask)) &
 		     calc_vm_prot_bits(PROT_MASK))) {
--=20
2.17.1

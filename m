Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78010ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37732147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OT/8QM6d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37732147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbeIQI3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:29:46 -0400
Received: from mail-dm3nam03on0110.outbound.protection.outlook.com ([104.47.41.110]:11424
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730225AbeIQI3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90wcYhjrNt6jpNp0Aj12Eilk7fB602C57NNCGGOGbxY=;
 b=OT/8QM6dc6kal5qjE3NSrU92z1aTq0PvAQ0rnaNb/BsD1OOEXiciRM0TUR8kyfNx/DWsPri7UxGo3247IWZDxvhWd7cR5mQ4NDm8gNNwZ3opfiFHJSTzAZTgHP3R68MtIWbw1T+5f6rlvACnfM/kguPF4WqX+WvxFgpCvtfLlrI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0774.namprd21.prod.outlook.com (10.173.192.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Mon, 17 Sep 2018 03:04:22 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:22 +0000
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
Subject: [PATCH AUTOSEL 4.14 56/87] staging: android: ashmem: Fix mmap size
 validation
Thread-Topic: [PATCH AUTOSEL 4.14 56/87] staging: android: ashmem: Fix mmap
 size validation
Thread-Index: AQHUTjLwcVDwcijDBEuLOipbP/BNOQ==
Date:   Mon, 17 Sep 2018 03:02:59 +0000
Message-ID: <20180917030220.245686-56-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0774;6:VmMuyPcKhMs05SkoSb4TfbKk1JtOAmv8sN87dUrfVCCz8Patq00r4F4SzUaEfJ8iomR/x236MpDH0iRYQOUhNTiD/cr/elkTH4JpgisxIeKaBgk+Qy5xAVo1onM2rZGSrjTleWSyiKyE3Hq7GVk5nGvO7YNxz1mgDmn5FfuW7tSUmgWXXh6MO8RLvt9ZZY9ZIw/CJQ6n9wEVbFvNCx57rnj1HBEVg9K09u1SPgg4jBVY3jYQwWELD2BCPidQn4xkn2jIayaE1L4yzlQ1JwbkhUlwbRHFAbC9v2y138E17EQSUCmmarhAMU8Nm/q/UpqBC5FBSo0wFZ359KRw49S04ds7ISpTrYn6q/nle0RgtO+9lbXmBlxhulgiXNHPEuhvcflrubRYuVkcSQcIVaHPzATnp8VaP2WePXRI5Sx+uhMO4uPPff4UXHBFh/scOiC7pjibCxaJ+jEvt/9gQ/MUZw==;5:5jnmqGxWpkbtinftjdJun/d9uqum3czKB5UZ5afxKupFgCeCvH2OO4VfH30ZsDMGyAulPpYbS1WCVY5sJ4MJF69BfSMVt+b/pXvWVURAMFDbEwQFIjIglNFG4w9BdPtmtTdg/DK51F+Pn7V53vKoGZ7B1BK8hKNpeiDpKFIvbNk=;7:yQ3A6VpxCR1dMKFtz2Kvww51nkgHXghNxUVeUZ5g6nr7gIkSu1T46kzia7l/rPdyPldKJIRmo7ocFXoanwFmHwhZH2GOXlIuqhAK+C2tOJEqKGfyVj5UKGzB222/uYB9qGL8zAoO2s3c+ey7Y9AnPiOK/Po4DaPlulnXlEvvSe7hY0zdl7Z7hR9G45qSB3jxjSaXtNx1hKetCLzJMcXejAlogY56kFQz7la0O3qq8RIxsjpUmR9YibrOMSJ06L2q
x-ms-office365-filtering-correlation-id: ab1ae942-4ff9-46a6-814c-08d61c4a449d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0774;
x-ms-traffictypediagnostic: CY4PR21MB0774:
x-microsoft-antispam-prvs: <CY4PR21MB07749DBA0623238FA7C3F22DFB1E0@CY4PR21MB0774.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(211936372134217)(153496737603132)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0774;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0774;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(396003)(39860400002)(346002)(199004)(189003)(54906003)(105586002)(316002)(4326008)(6116002)(1076002)(14454004)(305945005)(7736002)(22452003)(81156014)(66066001)(81166006)(99286004)(8936002)(8676002)(3846002)(478600001)(72206003)(53936002)(10290500003)(68736007)(106356001)(6512007)(25786009)(76176011)(110136005)(11346002)(476003)(2616005)(446003)(6436002)(486006)(6506007)(86612001)(10090500001)(102836004)(575784001)(86362001)(6346003)(186003)(26005)(36756003)(97736004)(2906002)(256004)(2900100001)(6486002)(217873002)(107886003)(2501003)(6666003)(5250100002)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0774;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 8Apo7Oe+W7KxAehprZvAByRn0ku7dcYYr+N40GSyUyCKXUAd6u8hKZ5fq4addYne1BMTnwBspDAOEFi0/Cbo54oL7Z2uIAy1i2VQrWHdIZNCf8cVJUTZVnwUzW7L2H3id+KsKAG8kNMBuj2Jrkd5Rb/BtU0L2lDoYc+OfCXhZ5vXeS/kJmEMSKyo9JB07IT/Mt9S6Yer89jP4965bI9I6Pw5RseCPvgJXf0tLx4u5phK3tyzu2KVTzTT23yDWfRwOu3p1d1BR9eUC4+4/yxMfjVakdB2BciKj2XNZv01qXqrhZcYoyfX29Ca+89sVz32vVvf7E3NAWE39etIDVxfgBzIP4EtS8eojnl/dCOz1e8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1ae942-4ff9-46a6-814c-08d61c4a449d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:59.8842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0774
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
index 893b2836089c..4151bb44a410 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -374,6 +374,12 @@ static int ashmem_mmap(struct file *file, struct vm_ar=
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

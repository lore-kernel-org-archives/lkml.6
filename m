Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF66ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A7E3208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="eDGxlDcu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7E3208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbeIQI5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:57:07 -0400
Received: from mail-by2nam03on0112.outbound.protection.outlook.com ([104.47.42.112]:14944
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729298AbeIQI1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JU0UpCCgY1AguYOihkkoIWUFnem0z/qhM1jCwA47fw=;
 b=eDGxlDcu1saqzhe7HVD0TRPd/j+KgbCMoyrr55AvmskZJKZquz02A4gNi7OOChYDueHi3FBsAwYzrjTB07NBWXRg2wKYp9jL3CGj6i9xI3GWHa/PDJAU3tHdXq4bgZ4ih/k3zEKmAL2jVVGdxZ4NP9xoCRPlBXstPFdCzUAKOoo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0502.namprd21.prod.outlook.com (10.172.122.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.7; Mon, 17 Sep 2018 03:01:58 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:58 +0000
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
Subject: [PATCH AUTOSEL 4.18 075/136] staging: android: ashmem: Fix mmap size
 validation
Thread-Topic: [PATCH AUTOSEL 4.18 075/136] staging: android: ashmem: Fix mmap
 size validation
Thread-Index: AQHUTjKokRbmOUkyxE24ti0atlB+aA==
Date:   Mon, 17 Sep 2018 03:00:59 +0000
Message-ID: <20180917030006.245495-75-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0502;6:U9iPFKDtm6+/mHA817jrj38pOzeNP8v9zHXYIXUlBlWRn/Z3S321UGfySF9b0edmEemR7Ni5H9fJViE4BGmQ33v762yTw6sJz1AXPpgEETZByV7Vc9jqMcIo/nRXioRngNPfFueLRjsBD16pk5liYBGbAGzCeY4llH8wRC8ORMVCV30xLqofi1rcZvutS74itLeQmrJNPAhNoOPg1g4DWOdWxHL/gSSeehcI7QLKZJ7AU3d1CxXiHGVzx94KBgI0Q3Z7thfP7VuDouWTLg58uWmkkpGSRubtvQydHTFa/201dO/OWqskC6aFZWuaKjAa8zBHHBQD1k+UupAbRAHfaF8WE+9fXM6l+pnTXkhpPVC6VhJrVWqYbcfpL3ll88L002ftzUn5MK0J5pkgNUzEX6hnke0SbP8mf4cshQlbPs2ynQxz+egVYsLzeMQZAc1WJuRHfADzUbGU0H+d1T5eSg==;5:zKTPuL3n5EssGRALsCSLvC9oCGH2IXJuJGjZsFbyU9uea0nsog3pxxIw7pmE4sELN7cIeowLdhOme0749vhJZo8OU4H7sdU5Fw+dnCkdcC+tYrJxvzkKE01LfTPWurBW75lt44XKeKlG/RCir1tccQJ5rcjQWKwvN2lvJvLMs7o=;7:V+vlxe7D9eO+jGfFXvjE552Qmkx7KDc3M+FmrvLaeHv0Nkx+Y0CkT7npjnEuSOX29Q54EkUBWNPxyNsqAhHpaLiMccRZ67w97XHL1zVuF3R1v01UO7Xl6pQAkD0NlwCMzNh+iCox9Ljm+v0FSw2SbOWaBDqFZpX9p9Je09pBJNAI+Bmw+CnDoktMZXdQxReldY5ClCaR/5z/wdTNeLVcRfeuuiTtv/DSgVBIY6PMLNBzRcGkv1+sm73OVibVaFfz
x-ms-office365-filtering-correlation-id: ba277d22-2883-4194-d856-08d61c49eecd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0502;
x-ms-traffictypediagnostic: CY4PR21MB0502:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0502088D28E0D4485BCE530FFB1E0@CY4PR21MB0502.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(211936372134217)(153496737603132)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0502;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0502;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(136003)(366004)(376002)(189003)(199004)(86362001)(2616005)(99286004)(5660300001)(575784001)(1076002)(6116002)(3846002)(10290500003)(2900100001)(72206003)(68736007)(8676002)(22452003)(26005)(217873002)(86612001)(486006)(76176011)(66066001)(102836004)(2906002)(476003)(186003)(256004)(6506007)(446003)(11346002)(36756003)(316002)(5250100002)(6512007)(97736004)(2501003)(107886003)(110136005)(54906003)(6486002)(8936002)(53936002)(81156014)(81166006)(10090500001)(25786009)(305945005)(7736002)(105586002)(106356001)(478600001)(4326008)(14454004)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0502;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kWgVidkiNrjIpZoFU4Iq+2IdO88iXwiFxmv5QGEPr/VpXNF1IRYlvlc8Ctkbia36eMCnrlVIMrJx4gRJibPW3MZmU38qCK0SnUryuDL3XIsEJ83G9to0kgQ8jzdpPDjXI4fGv1sNQgdUSk8EovAl1ZCtqLBFMKMp1qgrSkzE64xPI7W0jCLzWf5L9dfOy4QFZl3mf/ojnOamEdZRdOFbj3Hwv8U6/uZZAA6HjixP0k8J/q/P7bUQLUjcAaJCBdmQW7WdPICUULOw3EiNfVbEHR7fmk7HhoEbH47t9ZNILPqXbl7nqvhRamPkaeUk+umJeWovcguLiVdM3lp8ZkBW0VzvIAigkKvNxHpIib9y91E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba277d22-2883-4194-d856-08d61c49eecd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:59.1043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0502
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
index d5d33e12e952..716573c21579 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -366,6 +366,12 @@ static int ashmem_mmap(struct file *file, struct vm_ar=
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

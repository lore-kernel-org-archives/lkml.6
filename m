Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF70FC282D9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B5D2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cj1L9a3a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733239AbfA3Ssx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:48:53 -0500
Received: from mail-eopbgr1300098.outbound.protection.outlook.com ([40.107.130.98]:3904
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733116AbfA3Ssx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:48:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajHjdCLEV7SsuyYmnz6WLsFk2+AvBvyJ+8GtBnC+kyk=;
 b=cj1L9a3aChiiiWXzIQCC2s2sM5RrvZE56/dNzC4GVuorsZjLtUXxI6so8U5HKZ3umRVXz3D/Mf3jad7s6gx5zHeVSXWwW+JE88L3N3ccfpPMY8p0bZ3EPZDszr6WYGPJ2fhc+voH+d2rz5WUAZhU2MgWDFsa/frAQ8k1chcvu6w=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0171.APCP153.PROD.OUTLOOK.COM (10.170.189.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.4; Wed, 30 Jan 2019 18:48:40 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f%9]) with mapi id 15.20.1601.008; Wed, 30 Jan 2019
 18:48:40 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
CC:     Josh Poulson <jopoulso@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: [PATCH] nfit: Collect shutdown status for NVDIMM_FAMILY_HYPERV
Thread-Topic: [PATCH] nfit: Collect shutdown status for NVDIMM_FAMILY_HYPERV
Thread-Index: AdS4zD5pzoRrhLrvR3mTKoQx0ZwP5A==
Date:   Wed, 30 Jan 2019 18:48:40 +0000
Message-ID: <PU1P153MB01691690696D8F83FC1872C7BF900@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-01-30T18:48:38.1866517Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=af1da13b-d9bf-4b58-bb62-3363cbf73c82;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [2001:4898:80e8:9:e07a:40bd:14fc:76ab]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0171;6:A2nGMF8LXHbrmKWDRt+ewyC0r8ExQe3PecR11NamwxxL0JPKkAgQ1rSujFCRY7fq/HNqHobYN5DH4V9hZIZXXEl5EFBncTkGNheV83RhfjnPl9KCSJNHHuw13lzgPNnswjEfnrX05MR8OXGizG7F7HZkeN5qelGaE1IvgN09QUx5n5+LFK0NAhpBp4PUHKM0Fhu5rzPj9L+fH3MFi4q2eM9JCnjgSbCgVNRTOovTFc4RXr2tTg24fjsAZ7bFnfkk1E+GK/Hp3OtrFQGuv0ZnzchmTlCXU/jXvCx+hQqaiI65ZtlsV4b55aF3/3rc/J1tWwOMVZm4gS8kbcvb0oqZbOTJv31WZuipBoBzEuKKkKdwJ+yMtrBq9zk7A9frY7/nakuhCfLZkOBoMCeCAFoeD2Bzru8DWhdcS2y55tlY/Zn6Xp59TTK3Gy+xOGG8uzgAsRhsl5DqKsaPG5xnsUBd+Q==;5:OQ2G9Fe6luGxY6MveGEHZOZfar1k2g+m0JjdJ6PmhETcKXi/2LPD/yGo9y2H50tR4BKEHeewuLJbEt/0MVmF8FP/gMkBXZmPfUGGdALoqEGzJXPA2ReaxLAXpcG943a1ajc62OaZyQJBAqxL4EzpUe4fvrndgyyD1ESsDvf7i0UxeTQRrFrc+UPmnTBexXB0NI69nkYSspQESuU6FMhaiA==;7:PQnwa9uiwEztWttaM0VdUkroqiHNx090dE3lGKG/fetxuVIBUXgqwzYia7Mkc0eX8AJHVayNBid4VvLPpvNMN23jGNnUOEsMWOXaVHyK6G/DnOzqVGjYjuq8jHpqO9HwX4/gXjySaHtjqFeNEK8phw==
x-ms-office365-filtering-correlation-id: 2182b31c-7253-4d6a-b2d0-08d686e38d66
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:PU1P153MB0171;
x-ms-traffictypediagnostic: PU1P153MB0171:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <PU1P153MB017132C781E8DB807478CBE9BF900@PU1P153MB0171.APCP153.PROD.OUTLOOK.COM>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(136003)(376002)(39860400002)(189003)(199004)(99286004)(9686003)(46003)(86362001)(2201001)(7696005)(476003)(8990500004)(55016002)(105586002)(71200400001)(71190400001)(6306002)(86612001)(102836004)(2906002)(106356001)(256004)(8936002)(81156014)(81166006)(8676002)(6346003)(186003)(110136005)(6506007)(7736002)(54906003)(6436002)(53936002)(2501003)(10090500001)(97736004)(6116002)(966005)(305945005)(107886003)(22452003)(486006)(316002)(4326008)(25786009)(10290500003)(74316002)(33656002)(478600001)(7416002)(68736007)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0171;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WGB8I2UxhnfdJHtO1XwvRagN1kVZ/4N/nKZA6dYW7Z1GUJkACeplV3S7u5YJWnlnyKBZgEPqAmE6xcATzPZZoH0f8Mvd2lARwYqJDZ1LDxfAPprxKYjqGZOnCcD0yy2Nvk3M4p1kJNfmhpf+FuTkCVagfhYZcmUMVz6DmNUQArem5bM37M7ZFL3M2+66VUpqAcCNZN2nx/U9KCY6Rqq4w+LqUlfGA73YlPv0krkplRZfNaN6qgJAjvizDRxMYEPKuOEP1EDCrw4RvZtVnclc+rMdPwGkfPiPm+XIse9wjv6ZbLfKjj5xNpe//SOkD17WWSdYzuDKkpNNJKUTVsg4SopQlcEjKr2ljXFsA8G0ncaYNpz5+ZotiveeC4JhWhaolxwGHjiqxRByhkjClVXXaGdnz7sdSXycO7nnVn6UWno=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2182b31c-7253-4d6a-b2d0-08d686e38d66
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 18:48:40.2852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


See http://www.uefi.org/RFIC_LIST ("Virtual NVDIMM 0x1901"):
"Get Unsafe Shutdown Count (Function Index 2)".

Let's expose the info to the userspace (e.g. ntctl) via sysfs.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/acpi/nfit/core.c   | 51 ++++++++++++++++++++++++++++++++++++++
 drivers/acpi/nfit/hyperv.h | 26 +++++++++++++++++++
 2 files changed, 77 insertions(+)
 create mode 100644 drivers/acpi/nfit/hyperv.h

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index d5a164b6833a..d504da34ce34 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -25,6 +25,7 @@
 #include <asm/cacheflush.h>
 #include <acpi/nfit.h>
 #include "intel.h"
+#include "hyperv.h"
 #include "nfit.h"
=20
 /*
@@ -1802,6 +1803,54 @@ __weak void nfit_intel_shutdown_status(struct nfit_m=
em *nfit_mem)
 	}
 }
=20
+__weak void nfit_hyperv_shutdown_status(struct nfit_mem *nfit_mem)
+{
+	struct device *dev =3D &nfit_mem->adev->dev;
+	struct nd_hyperv_shutdown_status status;
+	union acpi_object in_buf =3D {
+		.buffer.type =3D ACPI_TYPE_BUFFER,
+		.buffer.length =3D 0,
+	};
+	union acpi_object in_obj =3D {
+		.package.type =3D ACPI_TYPE_PACKAGE,
+		.package.count =3D 1,
+		.package.elements =3D &in_buf,
+	};
+	const u8 func =3D ND_HYPERV_GET_UNSAFE_SHUTDOWN_COUNT;
+	const guid_t *guid =3D to_nfit_uuid(nfit_mem->family);
+	u8 revid =3D nfit_dsm_revid(nfit_mem->family, func);
+	struct acpi_device *adev =3D nfit_mem->adev;
+	acpi_handle handle =3D adev->handle;
+	union acpi_object *out_obj;
+
+	if ((nfit_mem->dsm_mask & BIT(func)) =3D=3D 0)
+		return;
+
+	out_obj =3D acpi_evaluate_dsm(handle, guid, revid, func, &in_obj);
+	if (!out_obj || out_obj->type !=3D ACPI_TYPE_BUFFER
+		     || out_obj->buffer.length < sizeof(status)) {
+		dev_dbg(dev->parent,
+			"%s: failed to get Unsafe Shutdown Count\n",
+			dev_name(dev));
+		ACPI_FREE(out_obj);
+		return;
+	}
+
+	memcpy(&status, out_obj->buffer.pointer, sizeof(status));
+	ACPI_FREE(out_obj);
+
+	if (status.general_err !=3D 0) {
+		dev_dbg(dev->parent,
+			"%s: failed to get Unsafe Shutdown Count: err=3D0x%x\n",
+			dev_name(dev), status.status);
+		return;
+	}
+
+	set_bit(NFIT_MEM_DIRTY_COUNT, &nfit_mem->flags);
+	nfit_mem->dirty_shutdown =3D status.shutdown_count;
+}
+
+
 static void populate_shutdown_status(struct nfit_mem *nfit_mem)
 {
 	/*
@@ -1811,6 +1860,8 @@ static void populate_shutdown_status(struct nfit_mem =
*nfit_mem)
 	 */
 	if (nfit_mem->family =3D=3D NVDIMM_FAMILY_INTEL)
 		nfit_intel_shutdown_status(nfit_mem);
+	else if (nfit_mem->family =3D=3D NVDIMM_FAMILY_HYPERV)
+		nfit_hyperv_shutdown_status(nfit_mem);
 }
=20
 static int acpi_nfit_add_dimm(struct acpi_nfit_desc *acpi_desc,
diff --git a/drivers/acpi/nfit/hyperv.h b/drivers/acpi/nfit/hyperv.h
new file mode 100644
index 000000000000..c4a25b8624cc
--- /dev/null
+++ b/drivers/acpi/nfit/hyperv.h
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright(c) 2019 Microsoft Corporation. All rights reserved.
+ * Hyper-V specific definitions for _DSM of Hyper-V Virtual NVDIMM
+ *
+ * See http://www.uefi.org/RFIC_LIST (Virtual NVDIMM 0x1901)
+ */
+#ifndef _NFIT_HYPERV_H_
+#define _NFIT_HYPERV_H_
+
+#define ND_HYPERV_GET_UNSAFE_SHUTDOWN_COUNT 2
+
+struct nd_hyperv_shutdown_status {
+	union {
+		u32 status;
+		struct {
+			u16 general_err;
+			u8  func_err;
+			u8  vendor_err;
+		};
+	};
+	u32 shutdown_count;
+} __packed;
+
+
+#endif
--=20
2.19.1


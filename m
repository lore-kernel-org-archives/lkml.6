Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA07ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87EC62147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="C4ATYQam"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87EC62147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730826AbeIQIbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:31:13 -0400
Received: from mail-eopbgr690134.outbound.protection.outlook.com ([40.107.69.134]:52946
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730797AbeIQIbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZegg5eOZYPQnG2E7tXZn1/acMpwoAankmZeQUBbRDw=;
 b=C4ATYQamX2aX4UEpdudbHvOJtgIzqZuLH4g1KjqVlv4uUfwwOk6u0wbmy4VFI6KCnB4x2nmASOKeTYSMXcdyvMwn/otbZMMhgdBeakA7QtmJ7gqqPpD2tA5jmP/FMxiplOovhTYKfABs4F+cWgwHFIZgVeKz0GfP222pbiY17v4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:05:41 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:41 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Hari Bathini <hbathini@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 18/57] powerpc/kdump: Handle crashkernel memory
 reservation failure
Thread-Topic: [PATCH AUTOSEL 4.9 18/57] powerpc/kdump: Handle crashkernel
 memory reservation failure
Thread-Index: AQHUTjMReh00V4aS+kCePImpY9p6bw==
Date:   Mon, 17 Sep 2018 03:03:54 +0000
Message-ID: <20180917030340.378-18-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:URET+jTmOPqF8c+1+HS9mdc9y35CiE1LgHr6iMNj6TdNpj3Nk5VKyu0tevQJASWkSW6DrjG/6mCBiecjKhY6oQ07q2mgWixxppZNamtqFkwqkyV7DJn/XVZEVnSvKkx1SMRaNDqwDAwpy7RwD5gZEw+l7jhGHBQV6lKh9cbEbZ9O9LU2eX22vEaTdYAfTDokC9xRFgbi6C9z9Yzp/gP1GEyaimKZnOgAZFa1WFWcL3HO7ARJ2ROB21D/1Gpxm8KZHjc3zNnIRozgRAH17BgiuWGPrUVsqXjjhJILWq8e3bqEgA/p/jpFOWcgDTCSRCFpC5NFbAtQdZWSMhycP+BR3c5jm6+QvXN7uWp4W0RNUSzh/5dPpRijvwFI3ABePH7G0yIOq51CQgCoPX+I3Vwqord8VpBSm/KRNOnGTkRaTeA3sZIT7kHqu5bVQUMXGOrjLXHNLmmpdP5mjhV9M09xgA==;5:cGnFnBWo+guRMF+e+uJ/aSjAPdzwFfA7ZsgHyJsCxTKCnqEY+IzbB3i+V0j9Du3Y5leVaAEVUg3Lj+7WczUPJvmsZ98mM8Bllf3IUkFIQnAPkeSOKUtDWAYeWViOPSKp8Hk4VJ/PYAaQRzf6iWcGkNuseAcH+fFKHJok8Pxi1ow=;7:qX+c+TKn1WlIxgrC6ADNnmA5yJQGRg8FcJWjyz7dVepHA4uUKchM2679l+819nAXtrDnRmQ96zVH88x4B7ISTJT1hGRxdpXRFEdJ3Y3bRxCFJGnNFhfJu6h6f5f1/1UdipUS0i8LiaBFGRJIqt98iwUTTxT+OMw0uPQaf4SudRDX0QcsRv0Rpw/BtK/8RNQQFLlIbq1l77cPISUV9ZhNMAsSEJ12vjq4rCYcqc50CgB5HyxkQ47NnXzN9Oe0hxLZ
x-ms-office365-filtering-correlation-id: 8f77c07b-f45b-4e18-5588-08d61c4a73dd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-microsoft-antispam-prvs: <CY4PR21MB012006CD3E996584CFCF6A4DFB1E0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(104084551191319)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(54906003)(26005)(110136005)(446003)(2906002)(6346003)(99286004)(316002)(575784001)(86362001)(25786009)(102836004)(10090500001)(2616005)(2900100001)(76176011)(97736004)(36756003)(11346002)(72206003)(478600001)(10290500003)(3846002)(6116002)(1076002)(22452003)(107886003)(5250100002)(2501003)(86612001)(4326008)(217873002)(105586002)(106356001)(6486002)(14444005)(14454004)(256004)(6436002)(8676002)(305945005)(8936002)(6506007)(81156014)(81166006)(7736002)(476003)(486006)(68736007)(186003)(66066001)(6512007)(53936002)(5660300001)(6666003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: iXpkY2cGjz/bKKSMUxf/7eA1bb03Aj5N3q3ws5dNB+VXjltddMc1ggECFe84Riicf75jp+3jWn6VNEamEByopcdOfMcRhgWu3Kg17V2gYkuBtgYt2QfhfJGj4dDAJjTlUrk8yDHKbZALPBZrcfdCV3iuX8kxNxzXB6zPauK0ODH+YAXC3gJaV6p+Uf2wNav79Ixv9w7WzjJ9vlM4A8hIlO6hbDmVraAN9P+Kc6ANZdf2f+i8vII+A+xUpdw6/9bF6FzGsC/TQ5gNl6vjX/QH8cuHc/8Hyi3Mskl8RX5EkLU6Ur0mHJ+ftftNz2AZjkWW/QC/5N3bliUH2qsgg4wbgk6L3hlALm92FYXcqnXe6BQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f77c07b-f45b-4e18-5588-08d61c4a73dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:54.4773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hari Bathini <hbathini@linux.ibm.com>

[ Upstream commit 8950329c4a64c6d3ca0bc34711a1afbd9ce05657 ]

Memory reservation for crashkernel could fail if there are holes around
kdump kernel offset (128M). Fail gracefully in such cases and print an
error message.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
Tested-by: David Gibson <dgibson@redhat.com>
Reviewed-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/kernel/machine_kexec.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/mach=
ine_kexec.c
index 2694d078741d..9dafd7af39b8 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -186,7 +186,12 @@ void __init reserve_crashkernel(void)
 			(unsigned long)(crashk_res.start >> 20),
 			(unsigned long)(memblock_phys_mem_size() >> 20));
=20
-	memblock_reserve(crashk_res.start, crash_size);
+	if (!memblock_is_region_memory(crashk_res.start, crash_size) ||
+	    memblock_reserve(crashk_res.start, crash_size)) {
+		pr_err("Failed to reserve memory for crashkernel!\n");
+		crashk_res.start =3D crashk_res.end =3D 0;
+		return;
+	}
 }
=20
 int overlaps_crashkernel(unsigned long start, unsigned long size)
--=20
2.17.1

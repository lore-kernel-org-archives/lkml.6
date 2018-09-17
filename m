Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D52ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334B020693
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="k7801UUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 334B020693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731363AbeIQIcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:32:43 -0400
Received: from mail-eopbgr690120.outbound.protection.outlook.com ([40.107.69.120]:6882
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731341AbeIQIcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:32:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5WZGmgQrQFTKHJpfXQ1zs2WVcsINvz/TEK/6edORG4=;
 b=k7801UUdi39yD2v6waPdumNMTBTF9ChGw7VqUAktcIJgR5tVuOSJVlrxBpAYZUoeQu2CGF8eAW4E4x6IPEU90986vH6kY7LxhPEFuWroQUHdJUQSzbuxv50pz9tU9JXm54vd4OAV9EP6C9wZXoEwvFdoqpHa34+2qSY+C1It4VE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0166.namprd21.prod.outlook.com (10.173.192.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:07:05 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:05 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Hari Bathini <hbathini@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 13/43] powerpc/kdump: Handle crashkernel memory
 reservation failure
Thread-Topic: [PATCH AUTOSEL 4.4 13/43] powerpc/kdump: Handle crashkernel
 memory reservation failure
Thread-Index: AQHUTjM2/trUwrfa70Cxz7FoeaBrgQ==
Date:   Mon, 17 Sep 2018 03:04:56 +0000
Message-ID: <20180917030445.484-13-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0166;6:/VAdMocyhCclUbixHrQTuizb7RAusFZz8uE1IgC/0KNhW5o58AUAOzkX3bL/kNO/OMHgtySCQBSNxu8OV0MFhqu5mmLluTQP58SD36iqnJXvx1NK2Yn1isWKli2Va9lPmjOk4fpZjeJKEtEtBL/IL48FY0xk+Yp17WSCyQGHu/Ep8yr5s8qneZRrgBzcaMNsUVsknN3sFgSQhWtLaoHKrN1gkEVD7ZlbzR3rq2qcZ0GwqVTXcRPqQCF3AK84j8xDWD8XO+i6dkfSNPinN60rYxyHgPLrSOmf9vb7HuhVAjR2qh+q10qzq038oF69XI3Ozq1R9dt7TSGxfHdJzCdtvNg6Bsrd7H2Ywsc/IPFXtSsxXYGqOMrhU3PPGeW/yVa7IRzfMTTvQI3thV7P0ULUaFvUzUQHOAoI0XKa6rsaxPVVAsd48Ft5ukNovOSRYObUUegpGBtgcMt7SXkLnVuE6A==;5:BIV+nlED5tz++lLE4ZV6NF+G8Dq2frlr/Z5t45ZxaDOEIfjQUkUkBCcbxWfAD1/19GFmUTO90f/NAB6HWCgC2OuVI9uRLxq5GuPqGL+3zE2CBFbyHe8+GXUVmZ91Ucp2vtPRASmkqeEN00Wo+kiHkRx7xH/FgCGZ3wukSJ6Vf2o=;7:PufcZnMx+fGKdkOKmOv5UBcs60mAVeFlZKQpilzm5+czJ7XP6sABAmCe05TBMozcp8roFMfIzSMxfkQ7g5ZEDi2ENgbJnmBLs4G5hsyJHnc538kj3sTxIdsPPsupknSiHEF3iIP76Ivi6d/kt+ag0uLuOEt+GRxm/6lDBqA/z/693sZTQ6BoZDeYMg2T+IA6o02VE5sJPwxqhqAE+4Svk2AoPHpEaKJ+JNFv5S87yMa2Vc84DMVwCoHRn6Aypqjv
x-ms-office365-filtering-correlation-id: 183fd6ed-5c4a-444a-80a7-08d61c4aa619
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0166;
x-ms-traffictypediagnostic: CY4PR21MB0166:
x-microsoft-antispam-prvs: <CY4PR21MB016610E30EE4CF46325E2C3AFB1E0@CY4PR21MB0166.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(104084551191319)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0166;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0166;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(366004)(39860400002)(396003)(189003)(199004)(305945005)(256004)(14444005)(217873002)(486006)(186003)(86612001)(66066001)(7736002)(6486002)(102836004)(6512007)(2900100001)(25786009)(14454004)(6666003)(2616005)(476003)(1076002)(575784001)(97736004)(86362001)(6436002)(5660300001)(6346003)(316002)(2501003)(6116002)(76176011)(6506007)(105586002)(8676002)(478600001)(3846002)(106356001)(53936002)(68736007)(72206003)(446003)(22452003)(5250100002)(81156014)(8936002)(36756003)(10090500001)(107886003)(4326008)(110136005)(11346002)(99286004)(81166006)(2906002)(26005)(54906003)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0166;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: AukeUb4HBzqX5nDfY32PFkT2UROQq2hdo0d12XMkJwvgoZ0HT9QvoYHtDfbBTpxVL15npA9dlV0oDU6spJ3ZcL9hgRAwSni7uK4bCHRy4t8Xwjk3swuYcCtt+cBNfukqzOT6Spda1G9sHQoz34vhoa+JwDbYAZE/Rr4GFh+7QKQ9ZhOu/zMpecQyO6VtFttshiNB6wexTLNxRySaLZF5P0u2785wqLy2vTQEwbO4P/N45WK4TBylE7JzHTUCYieooPJD/B9c4geobfUCsrzHScaySYDNVB3E+kwquCHRmNjyRCWocJx3qUA8HETrBPbpjzbdmELzyGCY9LBfsLYg4jCKASzRfIX3IgV/IBizNYg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 183fd6ed-5c4a-444a-80a7-08d61c4aa619
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:56.3674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0166
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
index 015ae55c1868..8dff2b371219 100644
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

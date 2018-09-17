Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2345ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F31214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SKLekAuY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F31214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbeIQI0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:26:23 -0400
Received: from mail-bl2nam02on0125.outbound.protection.outlook.com ([104.47.38.125]:3776
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727242AbeIQI0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BoCTxMsGpBA1imUCPObqJ624oskYS+mwWgK5vh7k1NA=;
 b=SKLekAuYxZhd/5N2RUg530f//QfASUHje/WmLRuM8J+b6kGUTr2EXEzUXbWbQitYWdUJp84jYRipJz899TMxjlq+Y/IReDrZw1aYnVTKBIG8g8LvAQ2Cqa6La3LP7ODKXZNbtzI8dlhJJ4iZlsfUFEu3WJf5awaTSOWm0eeFxtc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.13; Mon, 17 Sep 2018 03:01:03 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:03 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Hari Bathini <hbathini@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 036/136] powerpc/kdump: Handle crashkernel memory
 reservation failure
Thread-Topic: [PATCH AUTOSEL 4.18 036/136] powerpc/kdump: Handle crashkernel
 memory reservation failure
Thread-Index: AQHUTjKalJCICtjDwkWzYHDSrhZIKQ==
Date:   Mon, 17 Sep 2018 03:00:34 +0000
Message-ID: <20180917030006.245495-36-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:1Zyu6tpTnXb6ygwb1cSDUh5x4QSfmPK2fhHatqoyqRmf1T5hvYIfkKw+eGPj0il/prag/vtV8sKnhPmOnzwG4R6aw8mBy84lyMd4Dd8SnHbTX+jNE8JuMRyCXzKiH5E2a0R+IeK+wWZFY4Ac9nq9f9WBV5fnO9jwkLlSmIxkrbX0EOCPew8WlR34iIu8xBdvP/YrqVGV3Yo1C7VNkJ7hPtn9GUvHRi7Iv+5umpV8wLIfDdr8qkxjX9SMwwn7YNm9ps6/CozqfaSYYasUYW+XxlPAHABrMjIqCv+jMUG0B4Ue/e+1oKSRVhtD5W0CcY4iXkESTVXPnrAiaj4/PbIfgAwRfFg23Rl41CVeiDyj8+jM9qDRnXdegrMy+icHDJGjU5gjkQzDO8hqZdldnPYu2s2eTGpYc+mPGmFfl7WaRzU/epVNwaqWc4FpSSjSez9v+dMU1HoBmvqFW8ue+cU9wA==;5:93eJfub0gCXnji5H3hMMSyZLsS+1LGWGCt46YoH79z4orQKts602CYW7SQtP6r2Hw5TkQyE6Vqy443MSw5RtxNoto3nG3/ovEWcGyYtePpi6QWkFrtoHdh7Od7qkK1gAdAchRmq/t6VoF7HUCuoGXcgKJqvQ7J+EouGxMsdHtv4=;7:N11qgMaHHBV1dTT+9K+hoXoYlz2FhRvHL9rWgKr3o6vHuwfja6sId6HX1+aJ0nM9Y0q6RIz2vKIj6GiNBBfZRMuDUjzc015wJkTQaCOrcmKF49eSdJdMhx/idJvLoNs/idMmVa1QbyfnFtrVSdQe5HoD5pf+qSfiSsDia/YeHLvIhdihZMAuukOcQDXdn/sOe+wtABNi82FiFu32EZz1Yy4WEGNQbCT/nTnxhLP7E0TM6JQw/UtPf3SJ7hYu7R7v
x-ms-office365-filtering-correlation-id: d06c9907-a1a3-457e-e917-08d61c49ce32
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0629F3E98F26A61785959424FB1E0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(104084551191319)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(376002)(396003)(136003)(189003)(199004)(76176011)(1076002)(86612001)(105586002)(22452003)(5250100002)(6666003)(7736002)(68736007)(4326008)(86362001)(575784001)(2501003)(99286004)(6116002)(3846002)(36756003)(107886003)(72206003)(25786009)(106356001)(14454004)(6436002)(5660300001)(10290500003)(486006)(2616005)(446003)(6506007)(11346002)(97736004)(256004)(476003)(478600001)(305945005)(14444005)(217873002)(81166006)(102836004)(6512007)(8676002)(6486002)(2906002)(66066001)(2900100001)(186003)(26005)(54906003)(316002)(53936002)(8936002)(10090500001)(81156014)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RsJRFLs65lwmw14pn2meSx6On58tNRqfG3jj5AEC+sUJZEi+0a2BRZ7mis63nrigeXEecFjXrMcYXxE1b+Zzm9hqhV8y/VWbeA7Ok4e3t2MzE2xaq0Gc/+ouqfJL6WCxt9663q8cT78ELi5W+RFhCWbmQdJ8s8fPeX3A8s1DUPn3EYdhPMuGLU23RwNR3oo9oSTfMYBnjkE9gziq0MZU3KOSB81hungtxXIjkszV2JZPDJCpngnHziNYAS97cL0+IYA60rSdwBA2XJBlgRBvFx5QYS5EKMJVDG8N0bN7LoBUEp/31sQw4cbOO6VOGFEkm5QpQWkV2RoXJwVukseByw3PmmKSM40p5qToOTogUe8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d06c9907-a1a3-457e-e917-08d61c49ce32
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:34.8390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
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
index 936c7e2d421e..b53401334e81 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -188,7 +188,12 @@ void __init reserve_crashkernel(void)
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

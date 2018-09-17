Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2292BECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBDB4208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FH4Cppqe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBDB4208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbeIQIrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:47:45 -0400
Received: from mail-eopbgr710114.outbound.protection.outlook.com ([40.107.71.114]:1680
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730227AbeIQI3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KogNFhzNLCxJUmVuoSZxInjXoqehF6Tg/mr1Aa1PUQc=;
 b=FH4Cppqe7tvMxa4YaQO47di+reEBhU14uDhkyS38cxToiu/3cKVcwKU4FnDUSY8wA1XO1LlDBcsFdS+ewcR9BYwlJ/DIJnVCDfZooGPrhsZnkNMg5uDIWxlmU1kF/xZ7rc3atrBLd37pkECtfqqUAKnQxlmk3ly4XRBFVXB8ggQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Mon, 17 Sep 2018 03:04:17 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:17 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Vasily Gorbik <gor@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 46/87] s390/extmem: fix gcc 8 stringop-overflow
 warning
Thread-Topic: [PATCH AUTOSEL 4.14 46/87] s390/extmem: fix gcc 8
 stringop-overflow warning
Thread-Index: AQHUTjLsg6aiAVP3Wky28Ihd8Rvthg==
Date:   Mon, 17 Sep 2018 03:02:52 +0000
Message-ID: <20180917030220.245686-46-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0776;6:1N5XEHh9tL3V7FWz22DhcBKZ7Ul8oACu7HGr1CFjyWbt+qK+m+7QxgE6RD0rhEntOJwl1b2sTrGQIqD/TlIcGvLMaf5Y/dh7tQRWFaJtqCYKGsiE2v6Z5a97ex7BlPtjgOgeOioWWcCQ9vwSCr4AjpiNyYoNMpD5rcch6whsywMoGiU9sgZwS+VCiqHhJXleYYO2eo1qOd6wgpHHwBqWCx7aP9qC5kmvC0sE30Y+T00JLE7UODIvevu/za8PHAh0Hnx7myRitHEeio5vfH023aitCgyzmxYn4CKnJy+OfKP0YaCSBKS41yVrcVFW5uHtrwZZYFuZlcPMnEzFxxAdMNUK8C4e+w14cL1kfx7hDVtcaAC5j3pUK9GYYPYG3VhnXD3VFmArmgvIyiOsPIkkesT8APJ/5KgwcRTyo61sDxnqkg0Opc7IGXz8T+i8H2ZUoJ5OMcZQfvPmW5ijHAHWEg==;5:zC2wY8wMTCZsppNB6OVAgnrCUHZ2fr6EDTgXCx1hiMRoz9OUuZP8W1h1rYHVkW6ajFHkVG6Kqp0DiGcrSlkb40wVx7fpt11RG4Iq3vIwDvZPq+KmipXAPRwvX0GR1SmB8lhzMzAFrkoB/Q0Iq7syrg168wu1IFs/n9/NNdsC4Qg=;7:3mR5NmGaiNqiZyC5EdKEQGIgnph9uHpRATFpcV/kdCJNsRkZ2Tj2PuoRYCqaWRw2b1WzDBNonoN5ah0N+5gp6EIwt4qvJfgdirJIzgNRG+Ve4bsmfdbFk3TLFQG3tjzr9THJt8OvPppb4Jpq1l5ONgiicQSrugmsqNVDlyxGxzQlZ+LMKCjjCLJyGdZc6bP/ZH7uEINgsOtzoTAeDrCeS/YurE5OlPIS1nca39Uuxf7GcwyC9ARGU46kXQ5LN74j
x-ms-office365-filtering-correlation-id: e0b05f77-2e08-472d-d542-08d61c4a41ee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0776;
x-ms-traffictypediagnostic: CY4PR21MB0776:
x-microsoft-antispam-prvs: <CY4PR21MB0776E6EADD4043E42800B264FB1E0@CY4PR21MB0776.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(104084551191319)(190383065149520)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0776;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0776;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(346002)(376002)(396003)(199004)(189003)(5250100002)(53936002)(72206003)(14454004)(102836004)(478600001)(4326008)(6346003)(2501003)(25786009)(6666003)(10290500003)(110136005)(54906003)(6436002)(66066001)(8936002)(316002)(107886003)(76176011)(2906002)(217873002)(6116002)(3846002)(22452003)(14444005)(6506007)(486006)(5660300001)(7736002)(2616005)(11346002)(446003)(97736004)(476003)(6486002)(105586002)(81166006)(99286004)(186003)(81156014)(2900100001)(8676002)(86612001)(68736007)(86362001)(26005)(36756003)(305945005)(256004)(106356001)(6512007)(1076002)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0776;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Fwd4K6t3V5lOUogoB387VS6jOzx+yrjZ3M/y/zhst570V+mg3wZ8QQ0y/FdNVA17+wu3ixLWIzJKWdAiC+0WM+XuEv2mU/HpMn56YrJjWkKfKG1UK6We6Lq1N6r/IjlYZ27NjHnjiRrgjgEAjiuRMCw5m3p7is3qPK/dzvFn+sGDZx2xshJ8kBWo0ye0aJ79CHWStMNVbM483OsHV9uk3pDuUPp0EbHmR+GiEdUj+qC18LV7oeCOGa1LCRqVyldia9UlGcbVaBb9DTXw+KGJLRB2L4hQ+m73D8nH62rXd9v+Ulkj0ulUL3lcRC5RyYH88kzI5CLsW26Msn2ixUKNGQbEcPHsi14A656gKD13iCE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b05f77-2e08-472d-d542-08d61c4a41ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:52.4155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0776
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit 6b2ddf33baec23dace85bd647e3fc4ac070963e8 ]

arch/s390/mm/extmem.c: In function '__segment_load':
arch/s390/mm/extmem.c:436:2: warning: 'strncat' specified bound 7 equals
source length [-Wstringop-overflow=3D]
  strncat(seg->res_name, " (DCSS)", 7);

What gcc complains about here is the misuse of strncat function, which
in this case does not limit a number of bytes taken from "src", so it is
in the end the same as strcat(seg->res_name, " (DCSS)");

Keeping in mind that a res_name is 15 bytes, strncat in this case
would overflow the buffer and write 0 into alignment byte between the
fields in the struct. To avoid that increasing res_name size to 16,
and reusing strlcat.

Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/s390/mm/extmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/mm/extmem.c b/arch/s390/mm/extmem.c
index 920d40894535..290e71e57541 100644
--- a/arch/s390/mm/extmem.c
+++ b/arch/s390/mm/extmem.c
@@ -80,7 +80,7 @@ struct qin64 {
 struct dcss_segment {
 	struct list_head list;
 	char dcss_name[8];
-	char res_name[15];
+	char res_name[16];
 	unsigned long start_addr;
 	unsigned long end;
 	atomic_t ref_count;
@@ -433,7 +433,7 @@ __segment_load (char *name, int do_nonshared, unsigned =
long *addr, unsigned long
 	memcpy(&seg->res_name, seg->dcss_name, 8);
 	EBCASC(seg->res_name, 8);
 	seg->res_name[8] =3D '\0';
-	strncat(seg->res_name, " (DCSS)", 7);
+	strlcat(seg->res_name, " (DCSS)", sizeof(seg->res_name));
 	seg->res->name =3D seg->res_name;
 	rc =3D seg->vm_segtype;
 	if (rc =3D=3D SEG_TYPE_SC ||
--=20
2.17.1

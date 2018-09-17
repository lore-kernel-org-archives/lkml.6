Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB73ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5F1208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="itVNrYLs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD5F1208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731028AbeIQImG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:42:06 -0400
Received: from mail-eopbgr710091.outbound.protection.outlook.com ([40.107.71.91]:43296
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729427AbeIQIbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcaj9NUgHNWwNt6S3PeukzjKfBodQAUcubEvB6psUcg=;
 b=itVNrYLsTtlW68lr+aoa+JovhSPXMtDm6zU6QXS+n5t//rGTzNO/lehmXmcmZsj+23x59ufNjhiU+W2Bpt9RGRQHXmA5ORKnVOz5YyWO2zVLiciLV15P40punkJDuh/rVncpuUUpEH328yI0xrQiMFyCJ3lEFmYsaqV9ptKGdYo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.6; Mon, 17 Sep 2018 03:05:47 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:46 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Vasily Gorbik <gor@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 30/57] s390/extmem: fix gcc 8 stringop-overflow
 warning
Thread-Topic: [PATCH AUTOSEL 4.9 30/57] s390/extmem: fix gcc 8
 stringop-overflow warning
Thread-Index: AQHUTjMVV+vrt854zk6acx/VtDf9ag==
Date:   Mon, 17 Sep 2018 03:04:01 +0000
Message-ID: <20180917030340.378-30-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:cYBxzSwcrlADQGpxKDjFME+XdWBjo6mSOCXS+PfoX5BII5CB8od8OBk4PxZPgERK8NDcdFU248+muWnRny0jxR93WOwEXerWVCjgbd5tmMY60vvWyYk4Vcj0uU2mluX9nOXPDtZt7ElWnjjPllJscQaTyyuZi6cb5d4rduwvBMF2EcFl6lx35Lueq8ghFX+OIvwdV6/TtVj31bRSEid/mfvVeSF/YBka80kmHAkkXJ30xFxGkFejXYRoMuLgFpZQSz6i8oIpnYomJF4Px6a2nbwAU4C200UrIhuGfOZBqDJCa0pkMPeDvYTKx4zRBTPGlBPk5u6P9PLggopjwdkagta1w+a0Hx10lqs8vZg7jw5qP6cJvZQJ+zCf9BErP8L7SDk4K6yB4xpkG3pP2G1ecztjH2+8fqiGNoYBeHByAtho0GmYNiGczkFNdO/W0nkUuyudS9XM6OTKidog0/7HyQ==;5:i3ccTwhCvgIfogfUFs6KsEq0K2P2+KcYSYY5R3/NlB+hJOrX7qF+4/iGxI9u0ryhz7JjhMbTQmqOhJFMVPWhrywYsJB2Ag/rETtw6NahG1cvQwqcN2A0ebNa9Y5vMWZwEy71Hrcqp725HjQ/WVt8gV/ugv9dIgP6yybnod5/m+Q=;7:OwrqRyATQWhGPcukx4ejt12IRJ9OXlBrj8u3rwy43BFKIMacSkSWU99E7HbAqoj21Fnty1MpJmIBCl3QofVVpK7bU2F0EMhY4LwD9uZzY1F1tRRJ9eyPcbwu1ZzMrsXupF7lM006vsV+JDvPua51gF7ukHMOu1JUA/8IzfSdlS93zJm+k2R3KhzNtYV3kNXVnqJ6Wis0atbooStTuSdBGuNEppndzIpuWdUiD4EMdXQGhNFILJHYj6tK9Jq4fIPd
x-ms-office365-filtering-correlation-id: 479672a3-4efe-4b01-b752-08d61c4a770c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB0757B94C417496FA39ADC27EFB1E0@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(104084551191319)(190383065149520)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39860400002)(136003)(366004)(346002)(376002)(396003)(189003)(199004)(8936002)(68736007)(476003)(10290500003)(446003)(53936002)(11346002)(6512007)(486006)(86612001)(6436002)(1076002)(256004)(6486002)(2616005)(14444005)(81156014)(81166006)(7736002)(8676002)(217873002)(478600001)(305945005)(3846002)(6116002)(86362001)(4326008)(106356001)(66066001)(186003)(36756003)(99286004)(76176011)(102836004)(107886003)(26005)(2906002)(5660300001)(110136005)(54906003)(10090500001)(22452003)(72206003)(2900100001)(316002)(14454004)(97736004)(105586002)(6506007)(25786009)(6346003)(6666003)(5250100002)(2501003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 5tHvrLPDJFAIrPQGFB3m6ctdurd4P2XVvjq1bVPqEW8nKo99efEWMP1j/aZ5AxLh3uCY+WKNI7gFPcDzP7YXHmkiqutNLXkmlyQdXOL6CHcPp+kKTeLp4d3z5e+dsJDvW/1lfQozw0zMRnE4wFeql25CHUKZIJLe9mGXoopD0t3Oznvim37hXQF+TllVnFrarYxu8lXQAhbkddqEkch8qRhlAKh/wJnPehVUwkG3TpmFaviY5/kOaJHS3BN+bwYnTZoIb20pciwCpjw6IfKI5X9un2/E8O8/yhzNGTA8vTpjGxK85SLwINZCz+Yq3vXqhw9ERsfHXwo1aH6zOCFVNXMA7LnVGMy+xFO3TFIWYEA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 479672a3-4efe-4b01-b752-08d61c4a770c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:01.7740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
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
index 02042b6b66bf..e6665a6e105e 100644
--- a/arch/s390/mm/extmem.c
+++ b/arch/s390/mm/extmem.c
@@ -79,7 +79,7 @@ struct qin64 {
 struct dcss_segment {
 	struct list_head list;
 	char dcss_name[8];
-	char res_name[15];
+	char res_name[16];
 	unsigned long start_addr;
 	unsigned long end;
 	atomic_t ref_count;
@@ -432,7 +432,7 @@ __segment_load (char *name, int do_nonshared, unsigned =
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

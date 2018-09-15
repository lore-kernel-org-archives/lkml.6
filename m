Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69723ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D5A208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Z5/ZTacX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D5A208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbeIOGsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:48:40 -0400
Received: from mail-eopbgr720090.outbound.protection.outlook.com ([40.107.72.90]:59680
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728779AbeIOGsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdJBUnTb2P3zen/XkuR6+oF17g6m9tgk8xXDJA2Twns=;
 b=Z5/ZTacXzkLKjM/V6jognc9gOJPZe3G0cEu6R0GIakA4x1NzOXLwGs/1xtXI3trS7g24WeUvaGFmxst7RLmbUFuYeKBMe5i3scVFAzvRkicvigrGfLCScEehVX/17I+GCceCYPMlcZQ2AKNk7sK/KEAMyWVN93eBTuAiyN6nv3k=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:31:33 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:31:33 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Shuah Khan (Samsung OSG)" <shuah@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 68/92] selftests: vDSO - fix to return KSFT_SKIP
 when test couldn't be run
Thread-Topic: [PATCH AUTOSEL 4.18 68/92] selftests: vDSO - fix to return
 KSFT_SKIP when test couldn't be run
Thread-Index: AQHUTJO0KOQmr+u1pEqeaaMnxR+VKQ==
Date:   Sat, 15 Sep 2018 01:30:37 +0000
Message-ID: <20180915012944.179481-67-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:8CHd4IPlEb7vV3LlsYKyEQjU52OLoWJ4dRN/lAmvBEeAu3PgKz3Rs1p3UMKSHXD+xjxg/Gt9MROrtmo3N2huxC+J5JP8KNGgGZHmsE3okcJ/z1+6EAyGPNTw4Eob74dvu6d4ZZSdXG5xNB8/N7kjFCt0rGMa5tN/DJIii5KHCfjTPRe5CGXJK+CETswZ9VOmm8urAl3tk4prRVO2nlzUIfVD9o4aKVLfGV78qqMTdl6tliA3Iva2HzoA1S70OWFUI9WN3XAtobUMSg2EDd4y7aXY/BzEfAnrKSU+pgdjfIibx4EicJ3afsampbUQcdFFVbF5pa81EzgWZ70oX6ATZ7Jp+O/fzhkyyn0M53EkHmAM8cjCnFWuS90CN/BiOOEpODftkaGGmynBsI2S+YdoQ7NmMT85HQqzgwH2rcAgNXdhEQbYAHauu8fVMRPRlMjW/ytB5qIGGMiXrYANY7v1uQ==;5:vfiJ6iRPi9iC+JASDT1/bBcuAh2LfBVOSJ60SkKxs75sW5G3SVkPYhYi5GBJYTHbIwOhVpFW59mQ1/MX3d1ZHh5mudF5jf/MYgT8LXdfZ45KSvg1O+tBvVwN+Hr26xgA6INspJDRf9LU1QuG/62U9P1rZQfjMAZKIlOXwAPu9dA=;7:xjuJ2wt5zCcOv/GjPTR2YaQV3g8jfHW79JYiP3u21IkcY6A5mi+doQ8qt/W3oKcOsVu4ZM3Zjt/kBbbgbmhGp8mw/kTtZB9eVucqwQOwwZBZ/J7ueCyLjURxuuCZYU/JzeP9tNPRVNh+V1a0WE9pV2Qx8nm87xqvIE7fEyLLm41Pet3vtQoGNWGyArPxO/NtP46zl85FnbC7R/tRQ9MoFx2J56aN+Aqo56yJDFdUf9aI5GQKSXw93OFEcNv7Y1JV
x-ms-office365-filtering-correlation-id: 8ed9fb92-dbd0-4283-f4be-08d61aaaf85e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
x-microsoft-antispam-prvs: <CY4PR21MB04703802F96472C6C19B9B20FB180@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(6506007)(2501003)(2906002)(6486002)(6436002)(5250100002)(99286004)(486006)(14454004)(81156014)(26005)(81166006)(8936002)(6346003)(102836004)(8676002)(186003)(2616005)(476003)(446003)(10290500003)(11346002)(97736004)(478600001)(72206003)(10090500001)(105586002)(217873002)(36756003)(106356001)(22452003)(316002)(256004)(5660300001)(54906003)(110136005)(3846002)(6116002)(25786009)(66066001)(107886003)(4326008)(86362001)(575784001)(2900100001)(68736007)(6512007)(53936002)(86612001)(76176011)(1076002)(305945005)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 0QhCq4rdqtz4tx4gmislIQ/AuJJtEWd+3BIUsk/kg53Xj5nFLLnEVtLLE0rqVIkEj5EYSsJn73mLkmhcPJBT/VMTrxbz11yQEtsW9sGb4HbSqIxXssfn87OPxCGR9+d8BGvEMhjdZZpbc3Zj1BT3Ff7vKw0xPKIRjB1Pb3S4QsTT5hSA8VFgwupRK9QIIWrp8JHUo43SHNpbjlNMphwQgDmZYD++5ZWdbUyHwoogHfzBbyDLr3Pe/ZiSByjAZUgTHdnvbzesnNnl3afPCk1OC9NE00ed4Qm6Q1cOqxGerwzWNB9XW5tyGlYP0cb6/s6Bv415+2VGjgX3JLIhExl+dvPLGZ7XuvvnicfJqfuhObs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed9fb92-dbd0-4283-f4be-08d61aaaf85e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:37.5261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>

[ Upstream commit d2d49495b5c0dffee5c4da5ea12ac0da6679bd08 ]

Fix to return KSFT_SKIP when test couldn't be run because AT_SYSINFO_EHDR
isn't found and gettimeofday isn't defined.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/testing/selftests/vDSO/vdso_test.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test.c b/tools/testing/selft=
ests/vDSO/vdso_test.c
index 2df26bd0099c..eda53f833d8e 100644
--- a/tools/testing/selftests/vDSO/vdso_test.c
+++ b/tools/testing/selftests/vDSO/vdso_test.c
@@ -15,6 +15,8 @@
 #include <sys/auxv.h>
 #include <sys/time.h>
=20
+#include "../kselftest.h"
+
 extern void *vdso_sym(const char *version, const char *name);
 extern void vdso_init_from_sysinfo_ehdr(uintptr_t base);
 extern void vdso_init_from_auxv(void *auxv);
@@ -37,7 +39,7 @@ int main(int argc, char **argv)
 	unsigned long sysinfo_ehdr =3D getauxval(AT_SYSINFO_EHDR);
 	if (!sysinfo_ehdr) {
 		printf("AT_SYSINFO_EHDR is not present!\n");
-		return 0;
+		return KSFT_SKIP;
 	}
=20
 	vdso_init_from_sysinfo_ehdr(getauxval(AT_SYSINFO_EHDR));
@@ -48,7 +50,7 @@ int main(int argc, char **argv)
=20
 	if (!gtod) {
 		printf("Could not find %s\n", name);
-		return 1;
+		return KSFT_SKIP;
 	}
=20
 	struct timeval tv;
@@ -59,6 +61,7 @@ int main(int argc, char **argv)
 		       (long long)tv.tv_sec, (long long)tv.tv_usec);
 	} else {
 		printf("%s failed\n", name);
+		return KSFT_FAIL;
 	}
=20
 	return 0;
--=20
2.17.1

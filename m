Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98CDECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5710E208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XXH2lLZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5710E208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbeIOGro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:47:44 -0400
Received: from mail-by2nam01on0094.outbound.protection.outlook.com ([104.47.34.94]:11650
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728297AbeIOGrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4vC5/pTSEEJm/dHn+sIOfMu10/pnO3PLab+1BsY1V0=;
 b=XXH2lLZKiJKmb0Fepgm1DFJaRSlmY9uP+rR8gyoxsIJiMD5Z/rKOi8VFoEfO8nU00LT14o1kLnXtYI+Wx5VZS/ALynIOiyCGwIu4RD3Um60mCNkFDC+xGZCXkyIxMezUJtL1CVIPqUUrSiHU/k1kGpv4UzxeByejNLLtM0EwVII=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:30:10 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:10 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 28/92] ARM: hisi: fix error handling and missing
 of_node_put
Thread-Topic: [PATCH AUTOSEL 4.18 28/92] ARM: hisi: fix error handling and
 missing of_node_put
Thread-Index: AQHUTJOklofrsNbjFkycP+o3fQ3vXw==
Date:   Sat, 15 Sep 2018 01:30:09 +0000
Message-ID: <20180915012944.179481-28-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:E8+JQEKWoFDuNGSJa8d0uW6+vAL+pWB+LTgNOkybBZ8kBxYWem1CE95eg7dBhAYzGdrdFZTULeYAXvDgFpIOf2ebpKLiIcKQFJppXRoPi5tHUoKzDTWrFbCjZodpRRBLbRT65nGVZiEOqYwmCgybWCpcMY1JZtyAjcSVkhSt+oDWUrXBlD/75krZZEcHgrd6BpQZpoFNvl2raxBjOEpA6KKtoi+OoTUhbVdI7F+uNB3JaLdqySV3Lckl/SYG3PSYefZeMUD3rDMSLpuhklTlx780ea8T4mqNRb8D/zaL500SV5bTdAGg+04w3Kaz0mlwMAJcyfP/nMBn+/mE1ytSFoj91qvGO/tEztyD6WtdRJqjaxJkLMkvjeHdyJ8jhblbVRnhnfajLwkgmZj7soovmKDcv8j6pLf4sf4S/a7PYtcKCmLXNoCJIktn+zZhJQZynmuw8yUZ3Rv9OCo4SHSUpw==;5:xusEpEhhzLSraRVLl2979B4MacMLUKFcKP7I9a1QQiY4BoJqJP9QtqwvnEvywGHq1pvdK4/ZAFcz61rVewYRlIRuUV+Gwt6lH5ytmBh1M6gFKNQ6f2nalP79zzqSJeK5mNNybS8hCm+kXN7sgjOIdU8I027RUoO1MniQgSO4bJg=;7:zUj3YIyj455s8Yx9UsAuNwAg/zFA2to9zvDH+mCYgxngi25kprHF9ssh4Jy7uPNiWVSX36xN8UyOPzn8rEbbwB8lPnkXOd0dxiNhGtnOatbWe1ifu2ppGzE/BIijfrLSqwDkfEo/FvqFUt4JA6avPOsaVoewrQQoAIbzBaFPEHsn74In12Iir4k5a2WRhHx9swj7jB1FO90awAC9k1xwNkrnoF7TrJEGo1CJHP5r3D/uRmwGn8sCcXDlYU3c6HVn
x-ms-office365-filtering-correlation-id: f1f57dd8-58a3-44d1-4a3e-08d61aaac6c2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
x-microsoft-antispam-prvs: <CY4PR21MB074110F8510AD829BC453B28FB180@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(376002)(396003)(346002)(189003)(199004)(186003)(106356001)(25786009)(6346003)(6486002)(6436002)(476003)(102836004)(11346002)(5660300001)(2616005)(26005)(217873002)(105586002)(486006)(446003)(4326008)(53936002)(5250100002)(14454004)(10090500001)(2900100001)(256004)(2501003)(10290500003)(6512007)(22452003)(72206003)(8676002)(478600001)(110136005)(97736004)(68736007)(66066001)(81156014)(81166006)(2906002)(99286004)(86362001)(86612001)(6506007)(76176011)(8936002)(6116002)(3846002)(1076002)(54906003)(305945005)(36756003)(7736002)(316002)(107886003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: f17mlfteugquqPj3O614/UHkaop0eMZKYoW+/BbntQsxQV7cx90/J1OjHvKgGwmI44OY2eozQKTEKDRkgZtLM5QxPP5VhDi/jgB9JMJ5lh2EyZpkclQiD0Q2KV5Nj0kYCRuj6BXbwwUpJm4Og4aD3gB28O84NN81w7Apqu7GecN/NpAVaj3rdkhMeWk4TVFJJq+R3eIqpGPPAawXMO3gPKZob9kM911TSlGHDj1LwNGsVKQ67dcucWSlhq/7+FD5+VUIJeqPh4LpiusOSUVz+05/2mVB597zKfnYwQpxNyfhWz3Sx1UPCL7MsARV4JgZjZffTk1cUD/XXDlTIE0mzqomGUFcI7dZKclbpmYpU+A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f57dd8-58a3-44d1-4a3e-08d61aaac6c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:09.9950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit 9f30b5ae0585ca5234fe979294b8f897299dec99 ]

of_iomap() can return NULL which seems critical here and thus should be
explicitly flagged so that the cause of system halting can be understood.
As of_find_compatible_node() is returning a device node with refcount
incremented it must be explicitly decremented here.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit 7fda91e73155 ("ARM: hisi: enable smp for HiP01")
Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/mach-hisi/hotplug.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-hisi/hotplug.c b/arch/arm/mach-hisi/hotplug.c
index 3f28c9141b48..32870560b280 100644
--- a/arch/arm/mach-hisi/hotplug.c
+++ b/arch/arm/mach-hisi/hotplug.c
@@ -226,10 +226,10 @@ void hip01_set_cpu(int cpu, bool enable)
=20
 	if (!ctrl_base) {
 		np =3D of_find_compatible_node(NULL, NULL, "hisilicon,hip01-sysctrl");
-		if (np)
-			ctrl_base =3D of_iomap(np, 0);
-		else
-			BUG();
+		BUG_ON(!np);
+		ctrl_base =3D of_iomap(np, 0);
+		of_node_put(np);
+		BUG_ON(!ctrl_base);
 	}
=20
 	if (enable) {
--=20
2.17.1

Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C78ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6DC2214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PlUGsZN0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6DC2214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbeIQI3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:29:07 -0400
Received: from mail-eopbgr680131.outbound.protection.outlook.com ([40.107.68.131]:11025
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730044AbeIQI3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZegg5eOZYPQnG2E7tXZn1/acMpwoAankmZeQUBbRDw=;
 b=PlUGsZN0JKw238ORb4kb9Q17+yn3R+JhqzqKtGQ1ZyOaC6NccGPHO8MJaPkt887DR18KLDXZAFYGOKwwvGL6Gri/RedhNgaIxI9ni5u2OHEn2vtkWYShljMcZ2vvvcxRqLBPDZ29FQXWa+MUOZwpWEmcVsm4c4gq5yvEXqZDszw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:03:39 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:39 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Hari Bathini <hbathini@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 26/87] powerpc/kdump: Handle crashkernel memory
 reservation failure
Thread-Topic: [PATCH AUTOSEL 4.14 26/87] powerpc/kdump: Handle crashkernel
 memory reservation failure
Thread-Index: AQHUTjLl0Yjr/pigcUOvokD8BYYs9A==
Date:   Mon, 17 Sep 2018 03:02:40 +0000
Message-ID: <20180917030220.245686-26-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:f678u92TRedDaExChy7h3Rj2pof/fSS+OViStxI6UM68F7526LMMpYwpiYXiNNjqNDsyxeJt73+TvmTSpbAajUHmHoaf0V/gu4gRDqwj+jyCSHx+oL/IEaD3/aaqhKXN1bQEzQCNz07Q+ilsFfEmhC3GTU05itzFCf6FhayjguZwD7RVjADtZHd6DMNEbl9fAopBcCYGGoG8GeHE1VnJAvs0n8BiI72U9T++nFrFdc+qirOp+1DxH+7Jq4BKwkeiYjfnmY61DhcW6fPaH0fBHLXoC4KmkFtc6iLQNjY1EnuRwFbsTzqRfxLKZNbn0nS4yayERzhB5c8zWPDuaO91mHDIU04ku0yLrtRg6xSD7G77ZgTHZahjlfEZbU2tUWpU6t/5A7ZFhhuKVADbe2lMBtXgs2cUsqdiZ0d23jo5VbpP2Pk+xJj9Atou1dDOLO9IfhgnvMVkthlzdDVXmw4sYQ==;5:vjcayrQMrzuOp7nqsM9YjvJrPy+Y47gZF9X5DoYJqdeFIRS7vdDSxbIaODKrVGkk/KtS4POoM7lyfIXGtjqIN6OHHlq+2kC5PiPxqbiuiPaq2AUUscM/RJqtBMTVWoS3vmEaXvZeELubsFb7bXlPXoNtFLBYPbtXig6kF1JT8xU=;7:eEsNGyfSEUZTPoL9/WscT+aPSo8rZFk/7mV2F6qAEP4sNeEqCLk1qlZhrHFd7XK/lE+KeNmXmKL+NXQkpAWxX7mRsz4naophWMNKJNb4TkGVxY8ju6mf82gDTRdJrjI5NizS+t7NyxhR0/P1//R9SGqRYg4iLKTPD8lP+DkO8Uha7YrMiQjlNizRqedL47Kln/qE70eYaM/XEUZ+genrnEIXRbPtiAzorr9Unro+v9R8s5veJOMwpK9APaUI1qxF
x-ms-office365-filtering-correlation-id: ed2cd4d2-ca16-4b12-3242-08d61c4a2ae9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
x-microsoft-antispam-prvs: <CY4PR21MB04704838B7819D0D865DACC6FB1E0@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(104084551191319)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(366004)(136003)(189003)(199004)(1076002)(25786009)(4326008)(107886003)(5660300001)(3846002)(6116002)(54906003)(110136005)(22452003)(316002)(86612001)(76176011)(53936002)(6512007)(68736007)(7736002)(305945005)(86362001)(575784001)(2900100001)(256004)(66066001)(8936002)(11346002)(446003)(10290500003)(6486002)(14454004)(81156014)(486006)(6506007)(2501003)(99286004)(26005)(2906002)(10090500001)(6666003)(478600001)(72206003)(105586002)(6436002)(102836004)(186003)(8676002)(2616005)(476003)(5250100002)(36756003)(81166006)(106356001)(6346003)(14444005)(97736004)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: mOpL66ku8Ky7BWWThX/TUOPzL+R50GNkp8iOokI8vQyzLsp8RTlny0OQxLkBmAjSfL2lWSGIjR7EbB8IinVAWgjrrS+r7swbTFYNN54acTPY3drLe8NH5TwyPW5kFQEUnuta1zhI7GhmwKlw7G7vOUDpOgzv3QDXcsgx80/A+OO0Aab/gLSjm4VY5LZgzcM9xCYgmr8hDEt+kFtZsrJtFrYpgoAmkuiIeNN8Z7WOsmcGtCu16W7Rs5e+XxNXr6BfON63phBDh6tDms2JDxOS/Ofx1ywZwmVYxr9movPr9/PliKV0wRo0wnK8JGJwmI/jQuxB1HII61jJ+xuIrAJGtdBGrpyBu9cvV9phEvVf+f8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2cd4d2-ca16-4b12-3242-08d61c4a2ae9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:40.2750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
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

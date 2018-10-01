Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6093EC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 169E62083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hUWHHxGA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 169E62083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbeJAHXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:23:52 -0400
Received: from mail-by2nam03on0120.outbound.protection.outlook.com ([104.47.42.120]:46043
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729510AbeJAHOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWTEQarl0lS422jQ4b2kzw68i3vC7P2bhWcz1bMUDDU=;
 b=hUWHHxGAhIkeenEmukvpPSvbOu863xUg5zLpgsQVD4l+9vpOT5yzZTcd6PoNhawi6DceoYOR0moNLBd5z51YgAPjIQZIgSwRJwLhR8yo1xPBuK+zTXObQf/FHQpu5cxX2Qf+D0IeR+uIQkmwQFygkEXriSYQqnC0p8QphiG3YKI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0696.namprd21.prod.outlook.com (10.175.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.6; Mon, 1 Oct 2018 00:39:41 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:41 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sandipan Das <sandipan@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 10/37] perf probe powerpc: Ignore SyS symbols
 irrespective of endianness
Thread-Topic: [PATCH AUTOSEL 4.14 10/37] perf probe powerpc: Ignore SyS
 symbols irrespective of endianness
Thread-Index: AQHUWR8ksxfJkmCubk6iGFT02rcYZA==
Date:   Mon, 1 Oct 2018 00:38:59 +0000
Message-ID: <20181001003850.147107-10-alexander.levin@microsoft.com>
References: <20181001003850.147107-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003850.147107-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0696;6:RemUd+swrXHoAL9Q4N8/h8zHFwX3LwTqGAXAArVEKkhHOYUNRJtBz8mpjWDxB2ZmndT+k6r82kulJDfuh+FNCgjK9jmGkKnBvJthUE6nFOw+yc5g6qcSUfCF4lUgYCda/5t5agyKJT0Ho10A9GgxthUbzzyCfCFiUj8iegCkZ6U3MqEZpjJJcc4vXWtHNbMBWKl9z4KwTtbJLAOxZ3FEMIUh/51rGgcZMmMUAotw0yAg35HKS8MrNcmk/W8UtD5y9bA2fM11cpBB7j/g7tqqXzWLKFAgJydNVWo+kydVqIZVkTxyWNik1o9qcWU4TQYHTxKCJcuCiJPbazTDrIbsm3oHwrJldXIvXFnuo3IEcpUa8hzF0THuCs/8VtLy8uQUtExhc76G8Q2XrQESf9D/kxDzpNJ+RMTONX+CYTm+ZzrNjtwcmDvOSDJWyW4d8pHfEyGo0nhfN5V8rcaiPFmruw==;5:O/IhncT+idOitP4YAfXysWJ/Oe9fHzhpLrjVE/BD8N2FKBqbc1Moqx/B+O1T/uXxPl4p1AWGIx+b1GpisA1ZYhqYbWJ9LDQ5C5qpeNvwCKeIKLxUxCffP7qfAXWTGa6nw44J/GzxMFLw0UwUTj39/SMclTXoEPp3/9xe3y7/xOQ=;7:CClNdvmy6Up+sun85m3E4OerCsJsa9qj15VLrMraRH00Fh0MCrIiqfQhaq0by3EOj/JqAjo/Q8zuE9NWgnJbGgcrvNsti36PHQ/uA8kuRXk1PJdSv6Lgurt8uaXXmOdzl4M5A8pAq49YqZ4AjIF5C6emVF6TQ6TnmojCmH7pghkeHsJmhDlWxpI44zNsx3rQzNDUlf0Xj19zeAVN/g5P7kQ0iaR8Cx9q++5ENeYaELDl9r6ndSgyL6LN9jVzsRTq
x-ms-office365-filtering-correlation-id: 3cc9dd58-d81c-44bf-5943-08d627366008
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0696;
x-ms-traffictypediagnostic: CY4PR21MB0696:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0696ECC37DA5639B9033E0F5FBEF0@CY4PR21MB0696.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(104084551191319)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(4982022)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0696;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0696;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(396003)(346002)(136003)(366004)(189003)(199004)(3846002)(6116002)(5250100002)(71200400001)(97736004)(217873002)(71190400001)(1076002)(76176011)(6506007)(966005)(99286004)(11346002)(26005)(86362001)(36756003)(2501003)(446003)(2906002)(86612001)(102836004)(2616005)(476003)(14454004)(107886003)(10090500001)(14444005)(4326008)(34290500001)(316002)(486006)(22452003)(256004)(186003)(66066001)(53936002)(305945005)(25786009)(2900100001)(106356001)(6486002)(105586002)(7736002)(6512007)(6306002)(81156014)(81166006)(6666003)(8936002)(8676002)(5660300001)(68736007)(54906003)(110136005)(6436002)(10290500003)(72206003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0696;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: iztWEHFwZpUXOagRPpJILe3MgYvvWiU3z7X0Zn+naNSJHR1MC4JLnsTaStolMCk2AuwvMlWasOwEW/8oo/4JLqhyVbqVLDZlCA5qbIuDTpY7q+wm2tHikOgbWRLpTeiidxG6rMdbmjjr2agnb2Zb02i0sNi+O+MkfH51B05xsV0Bt6GSWZM28F796kxBfMCJ8pkB1611Ooeq8LxXG8Tothvi0gCN9wWR9Os2Uzmx1RuHemcV0nQFPjlXNPDhYcE4uUpHRPUPvfla/usHjsasDpV+iDS6KfiCfiiq1VdL3AiE9FQo0QixKKE4JkPzvUs0cUOW5fXn+esD89pnMR4yWa6z5Sb6YVF3A4J14rKaVr4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc9dd58-d81c-44bf-5943-08d627366008
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:59.7637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0696
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandipan Das <sandipan@linux.ibm.com>

[ Upstream commit fa694160cca6dbba17c57dc7efec5f93feaf8795 ]

This makes sure that the SyS symbols are ignored for any powerpc system,
not just the big endian ones.

Reported-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Fixes: fb6d59423115 ("perf probe ppc: Use the right prefix when ignoring Sy=
S symbols on ppc")
Link: http://lkml.kernel.org/r/20180828090848.1914-1-sandipan@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/arch/powerpc/util/sym-handling.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/=
powerpc/util/sym-handling.c
index 20e7d74d86cd..10a44e946f77 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -22,15 +22,16 @@ bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
=20
 #endif
=20
-#if !defined(_CALL_ELF) || _CALL_ELF !=3D 2
 int arch__choose_best_symbol(struct symbol *syma,
 			     struct symbol *symb __maybe_unused)
 {
 	char *sym =3D syma->name;
=20
+#if !defined(_CALL_ELF) || _CALL_ELF !=3D 2
 	/* Skip over any initial dot */
 	if (*sym =3D=3D '.')
 		sym++;
+#endif
=20
 	/* Avoid "SyS" kernel syscall aliases */
 	if (strlen(sym) >=3D 3 && !strncmp(sym, "SyS", 3))
@@ -41,6 +42,7 @@ int arch__choose_best_symbol(struct symbol *syma,
 	return SYMBOL_A;
 }
=20
+#if !defined(_CALL_ELF) || _CALL_ELF !=3D 2
 /* Allow matching against dot variants */
 int arch__compare_symbol_names(const char *namea, const char *nameb)
 {
--=20
2.17.1

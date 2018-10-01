Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5784DC64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0892083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ZaXB0lT1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E0892083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbeJAHQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:16:51 -0400
Received: from mail-by2nam03on0131.outbound.protection.outlook.com ([104.47.42.131]:55885
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729343AbeJAHQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlA7eFHsYOdCYzE5J3nsWap6qFRNFmzhAo6VvPC3LPk=;
 b=ZaXB0lT11qhByoogI+JGus+8/j8Ph/8lCdo2tdQP9PpRQWA6ZfoZ1e0KJGnBP040GFfHYYm8ngIAeomNwQnedH6n0Y+tAaex7J7GSLJ0q+ty8rYr/xP6gnV90eOV3D72fEqWIWK0Y2RmXU6cFuehVsg2M1+j4fSGM7hYwapRpwY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.5; Mon, 1 Oct 2018 00:41:26 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:41:26 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sandipan Das <sandipan@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 03/17] perf probe powerpc: Ignore SyS symbols
 irrespective of endianness
Thread-Topic: [PATCH AUTOSEL 4.4 03/17] perf probe powerpc: Ignore SyS symbols
 irrespective of endianness
Thread-Index: AQHUWR98DDrGbV/ViUq8ZcxNpCghdQ==
Date:   Mon, 1 Oct 2018 00:41:26 +0000
Message-ID: <20181001004122.147276-3-alexander.levin@microsoft.com>
References: <20181001004122.147276-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004122.147276-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:H2Yu8RZO181qGqB/xCVJIfSuUjNC2avvTZW/A4Y+Z/UkQnE22Sfn1gMMFIPEyzWsagixu3fUyC66rW7O1YbSVFpROA7LqPQjx4JzuyNTlvw70TsZxrjHjX6wm9NTpCCvOBzl8U5fZzbU7x45B7gAEG568mqHkbNoLEsFtpP1X07xc3iKT1httxyKkLPdLISiEVeRwABhF4RbysTFhjqWRt+rpYOFHzFclxDRWI23hyllzDcPoS1wsM1yztp+6+GL9JQVwwCIVLtCyNEu4Y9FsRYQcKfK2gFnv+bKk5N2vHYNw3Po4AzOoN0xtTb2mZyAm3gD5t3gMJIBvkrPyiT2uzNxJgzm221AY86jEYhhbjrxIPZpEU4d3II6QKuXSzYwtBKSvwFOEz9UwIH215N9I0xFzeUPTV1ov4cbSFNXCLDhwdr2hwh29KiTprj9jNQBGBoVH1dPHD1B0ZhXxtj3FQ==;5:sA14KCh3AoKdqEhP9VCo+ZXFlnIupM6MuT6/ugTl8N3FvgCrB0OBi9H49ea9W8Y/XXVLSGvRAO5GZf8I4+G71h5A5uiUvlfn6OoZDQ3oHezq0VOx5a0DcdJnB7yo29qGNTWrvgAu+gp5Y3K0AIx/2hJOMaht2p+Ue4bOhn8ksDQ=;7:3qKLalRNiO6A7z46B5vNH5tRC7uh3SHb2AT58z/5Tt+8q3ln3O9Y+++woXUN5rjMXsk+qqs+mZ0xq2xjegzkl+TPM62QaH5qBflSyPN/ZC2SO9vUHbuvJOaHLLv2ji1nJPlcdtK2nC+q7Dn5mEDnKQdgNHBXHXQzBkWGU0v7oArJ8JQi4mUFvqIw4pDY2fu3rnm89snfZRd52RTyad1fApdt4+ypX+PXXF+OS3f18MfWTvXJlY5H0tmGjUbgEALj
x-ms-office365-filtering-correlation-id: 7893706e-4217-4066-fdac-08d627369f0b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-microsoft-antispam-prvs: <CY4PR21MB0165FBF5F7CD8CF88D97CF97FBEF0@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(104084551191319)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(4982022)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(366004)(39860400002)(199004)(189003)(476003)(2616005)(256004)(217873002)(486006)(6486002)(1076002)(11346002)(446003)(86362001)(97736004)(2900100001)(3846002)(6116002)(2501003)(110136005)(478600001)(54906003)(2906002)(5250100002)(6436002)(8936002)(316002)(53936002)(14444005)(81166006)(81156014)(68736007)(5660300001)(99286004)(8676002)(10290500003)(26005)(6306002)(6346003)(4326008)(966005)(86612001)(6506007)(305945005)(106356001)(7736002)(76176011)(6512007)(72206003)(102836004)(25786009)(105586002)(107886003)(186003)(14454004)(71200400001)(34290500001)(71190400001)(22452003)(36756003)(66066001)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: EH05gaqCw49qN3dV7bwPPLphBC1bCtazkUGflmbhmbwOP7PlL1bfsQ9CS1zxPZ9i3CavGK8mSyJEjOjU4S461rJDwtwU33iWiHgXzsASWHLrHGz19W9uKd/ccuHt6S2SGgtNU801TGqZWoSMgkFHP62+PU4bk2WUPnzsoMYKTXFWccKnjSlfSHgol7YTjKTS/0Ja1IVku7JQQ+IRNTaTVoRCcvW1ZGF7WxatoaqYHSlJzhaHlYgO1tCDsuzpRuoBBaeXUu2+7xQDt6wpqP6sWyi5wxpAvIzjvPukZQO3JtC5KTu5AS/tIeiUUPMNd7Nogix5Z5B/7qLXtnpdog82K6yzoGqJKicqKkIN7I+aR/c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7893706e-4217-4066-fdac-08d627369f0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:41:26.8343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
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
index bbc1a50768dd..873f19f1a771 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -27,15 +27,16 @@ void arch__elf_sym_adjust(GElf_Sym *sym)
 #endif
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
@@ -46,6 +47,7 @@ int arch__choose_best_symbol(struct symbol *syma,
 	return SYMBOL_A;
 }
=20
+#if !defined(_CALL_ELF) || _CALL_ELF !=3D 2
 /* Allow matching against dot variants */
 int arch__compare_symbol_names(const char *namea, const char *nameb)
 {
--=20
2.17.1

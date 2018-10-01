Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4815EC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01181208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WUmsXtj7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01181208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbeJAHVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:21:20 -0400
Received: from mail-by2nam03on0104.outbound.protection.outlook.com ([104.47.42.104]:65184
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729832AbeJAHPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4v6POGrY3fh0P49bcRSV1BHShuk6fB6gRlAzYOX6Gw=;
 b=WUmsXtj7HDz+cJoq8rPFNgnaDuHd7CcBBbsibL9HuHYSozQyy0W/Y8/UjevUhvyzrcXuoE0T/PSQyCx1Tys0JFWy34z6prhaoo7PknHeeUpvxD9bK76iv7OhawE5NcUl39s03P8ucp4Qgd42Dl+S790/rhUI9sgBLGyav0ik0K4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:40:33 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:40:33 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sandipan Das <sandipan@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 06/26] perf probe powerpc: Ignore SyS symbols
 irrespective of endianness
Thread-Topic: [PATCH AUTOSEL 4.9 06/26] perf probe powerpc: Ignore SyS symbols
 irrespective of endianness
Thread-Index: AQHUWR9ca3Zt0+ZICkShXfpRvkT/ag==
Date:   Mon, 1 Oct 2018 00:40:32 +0000
Message-ID: <20181001004026.147201-6-alexander.levin@microsoft.com>
References: <20181001004026.147201-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004026.147201-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:6F0Rx0KD/gX258ffrpnluVEh8oTvslm24kadROSp1O/qmnmYNRf/IblgffwaZ5pvEtPksd8DrpCcOI/l0+ERQwk0DgWeXZOwu9TGNE5y4gK67BofDldt8ex81XZZ9GCwcR9dKt9tT6U90zS90q11XSqLXjAjfmRbETdAHsf97uYVYDw2IKYzGrhDo0pPc0TKiNez57t2aWF87ir1qicL2tjXHv/rs+cXRsJ1sxS95ImXhSC03LodKa14MrpaaKboTCiZnIzqdc4njv1h+J6AtLlyim3a+4JL2Vd3f48fFrY7yD9MimQPesazo1Tv7FPhCqUuDcaMK3KblzyC9NXqU4l94McajBNXycOnjqr5QPb9MvMAqOIT8byQp6LSxU7NCjpIhYbrovWpi3/Ug8nKEKhtYL56X5ktcp9ptQEMs5xFnDaiYJJre9AXhFiOM2sMXUPNd5Jh55yKWonllfcUUA==;5:Gn6CjYKzjlX9Z2zawKuTUY0tHYKVq1qNG8b81+APYrT/IuzkffjYO+yvkIFP1CGsP+rA8GbJcqDzoboVJEgXbQt7jXM1+8BxtqhvmpEUgSWb1sIHd3GNSu07TIT8ld1IDd3G59aPpZYhLFVf0Pk1SwNrkrmRMRBr2THxK87igBk=;7:i1IGVZt1ZOLW9RYoJtKdSlRfQbLxwLA5z/+URWy/EEm3jEMXqUfQM9kugXh+XYCN7rNbWVQG3fHzkNQ9qBGKhXNdd/x3m5XOuUqMpZmyMlcoMZl7aov+TJmx8CBZfuolZsFECJyLZpwkM68fIXpdvWWQFEH6+AJyHfwVNMF/rc2R+biXR4Mlo6tXaWXftbpUdH07fT4HTZG0TpmrRlbfY+I9HJ5eQg4GtsZ1u95pCs+B+W6fXjVy5qmOFws3Peks
x-ms-office365-filtering-correlation-id: aec6404f-ae9e-4dad-d062-08d627367ee8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-microsoft-antispam-prvs: <CY4PR21MB012074570A416B227F6C6D42FBEF0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(104084551191319)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(4982022)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(346002)(39860400002)(376002)(199004)(189003)(86362001)(8936002)(6436002)(99286004)(6512007)(305945005)(76176011)(2616005)(68736007)(53936002)(6306002)(34290500001)(186003)(10090500001)(105586002)(106356001)(86612001)(6486002)(81156014)(81166006)(8676002)(71200400001)(36756003)(54906003)(5250100002)(2501003)(26005)(110136005)(97736004)(6346003)(6116002)(3846002)(1076002)(5660300001)(102836004)(71190400001)(107886003)(2906002)(486006)(6506007)(2900100001)(4326008)(66066001)(446003)(11346002)(14454004)(7736002)(476003)(25786009)(14444005)(256004)(966005)(478600001)(72206003)(10290500003)(316002)(22452003)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: jNbOyB4oafFUrnNdVMjVCTD5cAAonW5h4Wxd4DXde7wfC99PjYrrfIVPnKAPx5WL8EBvozI+ldhKBLj0hY3d9Ke5mAFImX9LuKV33aF9vE8HhhjkjrEjew7hFrPcGlskPqRi1D5ebBM891IXK1/EYYxabw67bVKqZ7jDhjEy5JTcDUXcfgd1afvfUjdqzvz+JwcQb0M6eUiuqjFM3OsCLOX0j8VPVdqEl22m6ObfEcdAB/4aIrwADp05vx/g/g2QD72ulNw+xmCzWcykiYNWJac53BQmrHKNwJqjM7xsK8EMdErD+EwpfZZUAAsrU7ZyzCt4jsEp6wsaCD7tsaFUzk58+r6dp3mZBWXX2ej8+E0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aec6404f-ae9e-4dad-d062-08d627367ee8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:40:32.8976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
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
index de477a3dc968..01a288c79dc5 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -21,15 +21,16 @@ bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
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
@@ -40,6 +41,7 @@ int arch__choose_best_symbol(struct symbol *syma,
 	return SYMBOL_A;
 }
=20
+#if !defined(_CALL_ELF) || _CALL_ELF !=3D 2
 /* Allow matching against dot variants */
 int arch__compare_symbol_names(const char *namea, const char *nameb)
 {
--=20
2.17.1

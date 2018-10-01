Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3226CC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8C12083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Hp7equvw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD8C12083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbeJAHNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:13:24 -0400
Received: from mail-dm3nam03on0101.outbound.protection.outlook.com ([104.47.41.101]:12851
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728618AbeJAHNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWTEQarl0lS422jQ4b2kzw68i3vC7P2bhWcz1bMUDDU=;
 b=Hp7equvwJrVLj2vEmNUU5Se61egGZ5sF+hfJ1XvZOsN0kfG7+ZEAREGgDM2kFZbVkmR4cPOqXLJj5yQ8u6NjRztzP1rE8D6RDOm5YjedU7jyQZDbNWSXFyU2HZT+NSvoknfeRElrygljCa/7LUKOr3v8eqzjDcq7JuJQNw/G0+k=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0472.namprd21.prod.outlook.com (10.172.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:38:11 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:11 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sandipan Das <sandipan@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 14/65] perf probe powerpc: Ignore SyS symbols
 irrespective of endianness
Thread-Topic: [PATCH AUTOSEL 4.18 14/65] perf probe powerpc: Ignore SyS
 symbols irrespective of endianness
Thread-Index: AQHUWR8IhAMLfIfDoECZ2+ROfZ9DIg==
Date:   Mon, 1 Oct 2018 00:38:11 +0000
Message-ID: <20181001003754.146961-14-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0472;6:TUm2yvJVG8VoKJICeHnRFeodjjNkIlcmi8JxLlEhiQsp7XN5ByJyt/itt/6a1nOAXXwoZrWE9pijJj7z9GSOmGXPm1/nHp+COFbRAYcLr8wKB6q0N7xkqPNqXg5kuN18vJAedGknaPW3Wqw8HQ6tpbylARdWKQkDDZTW2l/YVQjzPyjpBmF4T5LLALmvhvvTN7UkzLRAi7lpqmDzaId3jQepcr0WiPLf9/9V3fbO6VUq/Lt/Ph8/QF+osydfgnLeRCFUNKgPjUimeUIjhTIc4QZzdfR1ZZs3dybDyZEthbVpw7DgPGnvmQAqMkAZpvoPdS9JW2mODts3bUpEYh2r7GBBD6U7VI/azL2SC9OLZ/UVEtUTLwdhDNAWp1fXeeXbULju7Uzbk27cHU4bKBbEY1fXyOTWJ5SE1DA2+4GOJVT+d4FF1m2wd1ajF4LxAjTtUZHOIYtO4Zq6L3tRnjIygg==;5:1PA5rX8qoKJ4W6QKLshTQjvW+ynHP5mIhhpNIW5A8PJZ7976QonUUuQ+5vKgIYO/XMnNEySTY1eP3Zi0reOYV5OlqmX/ltoHpHHd9pwm+fTBhIZQvLbbcC1sMQ3MWEWUqMwqiOp/ohlx3kVGQ4dHxtMp0tmLiUfbmnSek5PIhc8=;7:3JdSB98cxgETnVhLUCdb/jXy5FYZrBgIu2vfqgGmIzrPalSjXwzV4DAo7TYaHXCpUd6bOWGfo3ezj7yHaULulwawy/eGtj14Er0uqxqmCqMYuuOLW9znjo1jdtHboeH/kAqvfZisJh2xGfN/mi5czQVrGXf6jLZ9fo3FONQtb4NxG2qBV/Qq3XPPmXs3NNnK5oJK6kjoc5GVpLmMBdNqtlwGdN2HpJDNBreOdR3UHJg+VkqR3xEkUFwDeKP9iK2o
x-ms-office365-filtering-correlation-id: b403f35e-6cff-4afc-189c-08d627362a9b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0472;
x-ms-traffictypediagnostic: CY4PR21MB0472:
x-microsoft-antispam-prvs: <CY4PR21MB0472484A5E4E953DC7D11592FBEF0@CY4PR21MB0472.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(104084551191319)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(4982022)(52105095)(2018427008)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0472;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0472;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(376002)(39860400002)(346002)(199004)(189003)(5660300001)(966005)(6486002)(6306002)(8936002)(68736007)(486006)(6436002)(2616005)(6506007)(6346003)(8676002)(6512007)(81166006)(81156014)(5250100002)(6116002)(2906002)(3846002)(107886003)(2501003)(1076002)(22452003)(478600001)(102836004)(25786009)(4326008)(97736004)(10090500001)(11346002)(256004)(14444005)(106356001)(105586002)(99286004)(86362001)(53936002)(316002)(71200400001)(71190400001)(305945005)(2900100001)(217873002)(7736002)(10290500003)(14454004)(34290500001)(446003)(66066001)(72206003)(110136005)(54906003)(186003)(86612001)(476003)(76176011)(26005)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0472;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Itdf45WC8XxW8gY09xwU66XikeYTyKI2cO4joFmraxwONs4nwLG7S4yY7F8slDWezU6V3y8uEyg6OPj3F6rkRELOgGdEvnZQsZoo/hRPiU0qL/u9RM/YjTkMMCnNorYWuyIu5m4ikaeFbKCjpcoJtQeiL8WtB6m0mQEb8cEhCHO425JQ9xDaelltc0pJH1CCCcOyAfn4JOLmUczE6mj88JCJc3oGSbhjr54+Ygm2NbzU4igMkQ7jhcUddqXuzui2fK6jNGVwTAPiyLuqcRooWTXAAaEv2vX+ApXTfrKfTnTbak47ooHs+ONOmWoRcYNf2fiAREfMxL1Oq7HkM50DDLMqd2/GMAAyk2bG8qjSYAU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b403f35e-6cff-4afc-189c-08d627362a9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:11.4527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0472
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

Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FD2C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877B1205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IC11cpoY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877B1205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbeIBR3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:29:02 -0400
Received: from mail-sn1nam02on0115.outbound.protection.outlook.com ([104.47.36.115]:45032
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729234AbeIBRXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niPsq3BFlAydwYiM1h2XV2tCmJjccVlqwahi8ADwvyg=;
 b=IC11cpoYxBz/B9vpZEtPF0RPrUs/wwIKgZOiHF98ntnllVvGp+6rvlZXMjIFwBZhSRtm4rdkn5gFnEW+Ctw0gjhwH3Mz7IYWmbwY2EbPT1keVQC1pWEaAWlmZu1aOW4T5mSLqUo+sYq4iLiAkxDdKr7WmB2FN7bstd+jfyjszF8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0503.namprd21.prod.outlook.com (10.172.122.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:07:14 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:14 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "aliguori@amazon.com" <aliguori@amazon.com>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        "hughd@google.com" <hughd@google.com>,
        "keescook@google.com" <keescook@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 48/89] x86/kexec: Allocate 8k PGDs for PTI
Thread-Topic: [PATCH AUTOSEL 4.14 48/89] x86/kexec: Allocate 8k PGDs for PTI
Thread-Index: AQHUQr3b5qaqnfY0ck+Kjj6okvOk8g==
Date:   Sun, 2 Sep 2018 13:07:10 +0000
Message-ID: <20180902064918.183387-48-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0503;6:4NaEa6BgwEVX8hdwaqqUk9oT4dowU2mtZJYCW8+7Sj2yERs+ItEiMkYXWhumwbcsXe0qnxC0uZLrfP+CQZpPXxU4UrFlcZgUeNuUxX+I1kRHHwThPBwdvlOKND94Az13qd2DClFMaszM3tgmTN427lAmQTxpdUMiTlXqasp/+dIMvP9oYsiVDmzOKtHlvbBAqu52IcQ8RbjXk1v8MJAtYqUzsyz6sULn+kYSoQ0RDGIcWoesqz4yjgf3Ha+JuIvPjnl+HK5VaMdTAWLE+RJRUZh3qepz2iKEgCjXf5xK2YfGGTDjN4PEwtBoZTCyS+BekCWZjfGtJaEzvAREgsCYMV2fIyCdst+F9lX8L2xi+VEgfuXhmIqtiEU9t5oMNHqE5WmmN2J0hLFtyCv/+I5mJ6kZX+tg+kOIRobUQKdkarmcqE0ZJCivgjHEYJMpELDSEmKo8Odc58rNT0f1sRl0+g==;5:+duwnctfLoLeIw4XT8eSPcjIKrE1K/BMFX+9uaNc9rVYZLOBE7uG85DU+ggqwJcteMKaGiSaKX8XPxUDRstWw0QSJKjNFQ6jmImpvFX7qTsFxiWUnyTI5E7iCtDGkpOo1J3mIaZsR02AykTIIxSS/JY79b4sLk3B4OTxdGXTokk=;7:+bUdTTyjFog65zdx7BQjDnPONCdCBwZHfbftxR8xrXG3AlLIctRsbcWnReqE4n0UGmbIM8M6VI5f7lzP6FWUXupufPeIsV5S2NIZFNXDEp0Sf75/g/uu5MbFekLUXfnVlwYA7I6jhJc6CBGHTNe74dA74NbLRPmLB5GLHrXAwZ/DfwXRQTU9Qpf11qB2zeZgjqRi6B21faCoezjfJp3SLaZW983Htj//CLzT6P2cdGJmLBfpF+jnn9J7J9ku0IGu
x-ms-office365-filtering-correlation-id: 2fa89296-8bd4-4337-cd84-08d610d5006d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0503;
x-ms-traffictypediagnostic: CY4PR21MB0503:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB050333EBA83744E2D2FDF95FFB0D0@CY4PR21MB0503.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20283166320243)(28532068793085)(180628864354917)(89211679590171)(33061846794335)(85827821059158)(211936372134217)(42068640409301)(146099531331640)(47284530071512);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0503;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0503;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(376002)(346002)(366004)(189003)(199004)(105586002)(8936002)(102836004)(6346003)(68736007)(2900100001)(6116002)(217873002)(186003)(36756003)(81156014)(81166006)(1076002)(99286004)(26005)(7406005)(5660300001)(7416002)(66066001)(6666003)(8676002)(54906003)(256004)(316002)(305945005)(22452003)(3846002)(10090500001)(7736002)(110136005)(14444005)(106356001)(2906002)(6506007)(10290500003)(2501003)(966005)(478600001)(2616005)(72206003)(6512007)(53936002)(86362001)(39060400002)(86612001)(107886003)(6436002)(14454004)(76176011)(486006)(25786009)(476003)(97736004)(446003)(11346002)(6486002)(4326008)(6306002)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0503;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: JWErkMTo1u9SUMsL0pSgErPu9MY1ZlNWabeP3WcKrg7d7UK2XXR4oBnkBEiUkmaCt5wIookhxP8VS/7mGU1kPpnNXhwA83THiocUdyv61m6TEnMdQlmUNkXhXTYEhCwm8FEKxAY5ziiPviBoNu1tGEkl1sPkHbBzrEK5KZB5SzBrs11j3WpL5YZHUWCg145V75uiqEzX/Pf9qRgVjjdN0y9NhuwN2oWk3OJys7GYESMsl85MCAICdtt72yNQ4SXINhUpBe0hVEc4NuQwbCn7v+bXVXo7RPdpqlzciDUmd8c7OraqpWYRqpJ1o/0oCbJIpC7CPkdxhbovt7RwCUvTj2Miymc7cviO+XODQ4DyZTI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa89296-8bd4-4337-cd84-08d610d5006d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:10.1375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0503
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

[ Upstream commit ca38dc8f2724d101038b1205122c93a1c7f38f11 ]

Fuzzing the PTI-x86-32 code with trinity showed unhandled
kernel paging request oops-messages that looked a lot like
silent data corruption.

Lot's of debugging and testing lead to the kexec-32bit code,
which is still allocating 4k PGDs when PTI is enabled. But
since it uses native_set_pud() to build the page-table, it
will unevitably call into __pti_set_user_pgtbl(), which
writes beyond the allocated 4k page.

Use PGD_ALLOCATION_ORDER to allocate PGDs in the kexec code
to fix the issue.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: David H. Gutteridge <dhgutteridge@sympatico.ca>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: linux-mm@kvack.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David Laight <David.Laight@aculab.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Eduardo Valentin <eduval@amazon.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: aliguori@amazon.com
Cc: daniel.gruss@iaik.tugraz.at
Cc: hughd@google.com
Cc: keescook@google.com
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Waiman Long <llong@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: joro@8bytes.org
Link: https://lkml.kernel.org/r/1532533683-5988-4-git-send-email-joro@8byte=
s.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/kernel/machine_kexec_32.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_k=
exec_32.c
index 5167f3f74136..83cb5f3c72e5 100644
--- a/arch/x86/kernel/machine_kexec_32.c
+++ b/arch/x86/kernel/machine_kexec_32.c
@@ -56,7 +56,7 @@ static void load_segments(void)
=20
 static void machine_kexec_free_page_tables(struct kimage *image)
 {
-	free_page((unsigned long)image->arch.pgd);
+	free_pages((unsigned long)image->arch.pgd, PGD_ALLOCATION_ORDER);
 	image->arch.pgd =3D NULL;
 #ifdef CONFIG_X86_PAE
 	free_page((unsigned long)image->arch.pmd0);
@@ -72,7 +72,8 @@ static void machine_kexec_free_page_tables(struct kimage =
*image)
=20
 static int machine_kexec_alloc_page_tables(struct kimage *image)
 {
-	image->arch.pgd =3D (pgd_t *)get_zeroed_page(GFP_KERNEL);
+	image->arch.pgd =3D (pgd_t *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
+						    PGD_ALLOCATION_ORDER);
 #ifdef CONFIG_X86_PAE
 	image->arch.pmd0 =3D (pmd_t *)get_zeroed_page(GFP_KERNEL);
 	image->arch.pmd1 =3D (pmd_t *)get_zeroed_page(GFP_KERNEL);
--=20
2.17.1

Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D502AC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D15820652
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GIZ8oEfK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D15820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbeIBRd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:33:56 -0400
Received: from mail-cys01nam02on0107.outbound.protection.outlook.com ([104.47.37.107]:15264
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730263AbeIBRc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5zfbb2/wNo2xPTtgYa9lD3IJrnve2w/0AcqYcsK+6Y=;
 b=GIZ8oEfKw/v92+2ls6coCzcs56LT4Fu60ICtXSakvUSirDOc0OveMAZZZ1FF+FiCGE8yhogFYXDNksWsFab464O23eO+8dSNDbZzHAkaCk0sevLP6SK1Bgh09J4cVa0KXT67z8Ue9En99+h9/U1TEnc0BOkIKqfx23J0jhBWFU4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:16:24 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:16:24 +0000
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
Subject: [PATCH AUTOSEL 4.4 23/47] x86/kexec: Allocate 8k PGDs for PTI
Thread-Topic: [PATCH AUTOSEL 4.4 23/47] x86/kexec: Allocate 8k PGDs for PTI
Thread-Index: AQHUQr8cQlafy3ciR0q/ULSflFCkLA==
Date:   Sun, 2 Sep 2018 13:16:08 +0000
Message-ID: <20180902131533.184092-23-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:n+lRPJ0T4F3wGXbMIvq8HwGgMFehaf/GI8FXV92tS+eOP7mUHipaLq3XUuiSoJgmLjgo7kkxHzGRkUQd89Y3vIn6bfAG3aJWNLUZ/0D6NWT0CICbv1OcqzHFvisnsAYxaILhCDjDCCGMd4hnyYa1WMm9crwZZckzJC5zzhB9TXb351S0Qkqcmtcyo/O2RcGwGuNVNM+fokP5w2pnTrt1afrdJBf/YiyiyCyB5FUkdFUAq4RKyYPZLcELI/5vqt7kEBCGWhcpg7qIg5/bTyNxAbDysfyKiiWDXgf30qhk2ogomRRvzu5nRkNGZoVM5mAfcFS4cbvZrHnSiBp8uaqCUys328JwK097L90Z/+yLZkn3h6sYzp6n8SWTuEf7bGRMQVtY7s4RF9XduBGwN0xSP0fjV5d/8PSpa29yL3izbKZqtNIkOjHSVezJNEFuUf9IKM7HkCnNYCgKACHB7wHiaQ==;5:qsR6fth6eLvLf5FvvBNXhmvEngXc48fwYEol5RgEAiLXmceQWXhqLblxNxBQn3DV2RmOkGc/cM7QXfAMxbTKRsfY/ezG1x/72mAtDQpALEpfxfy4wLjPU+4Qu2ak4hkxbUXKyu3VD4APb1D+spIjhaCI9X3BaZo/kLn2teqfYLw=;7:BGn1SMAA3LT3lRylG+fEfLihrK4j5IOlDMu4T72UDZt1Dz9jlranqfc52gblXVZur982fm89hC4+cdc8j8Fr9bfcWSsA/QlK+5/rLlojvjIZOb2eQGwY+bpgecoRu4RaQzykv8ARVajB5klCN37WJf7kiEr+Uvpjhbqo9h+vcV3XwekfdFmpcFMPcES2H6qC2JHQ5zMXN6wmBXdOnxQ42X8RFOq/xSOJoRqn3uVzsRUG2iyIGGJddhOXJYn7UV3W
x-ms-office365-filtering-correlation-id: dbae3e62-4741-441b-1674-08d610d6488f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB0629A5DDEEC04B124823AF0FFB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20283166320243)(28532068793085)(180628864354917)(89211679590171)(33061846794335)(85827821059158)(211936372134217)(42068640409301)(146099531331640)(47284530071512);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(39860400002)(346002)(376002)(199004)(189003)(8676002)(478600001)(10090500001)(14454004)(966005)(10290500003)(72206003)(476003)(5660300001)(5250100002)(106356001)(110136005)(54906003)(316002)(105586002)(86612001)(102836004)(14444005)(26005)(256004)(6506007)(2616005)(6116002)(217873002)(305945005)(446003)(1076002)(3846002)(2906002)(11346002)(97736004)(6346003)(81166006)(81156014)(7736002)(6436002)(66066001)(25786009)(86362001)(4326008)(39060400002)(186003)(53936002)(8936002)(7416002)(7406005)(6486002)(22452003)(6306002)(6512007)(99286004)(2501003)(36756003)(68736007)(6666003)(2900100001)(486006)(107886003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 0Q/9ZjT6c6xKUxgKOBCNoVQuH9S3paoT1EczMPEkNFe4bHY9FzaToLvbvUUPbiL4jtk84xea2Pj+h/n//oFHQYkkney4OJ9GV9tg4CWLEqBDsOqAu0rIeDZ/EPP7b+10NrBuCOG1uhbFaG+OwMnBQLgL+7IC31anPO5eoGPXf+u7RmeiyHbl7hSj+m4FlpHHsIiFWP83Pbx1tjn30Gvu9AsC3ilke8Xy09sL4NYXkY8OxrTNuBFdxT/EIheUtBbYQMfckROfccaElwOwzfq95/GKyKqDc7NzE2Ob8BKA1d2c7+ORDKoeu/0KHV1EbdiXwSA799gd2F2zczuvZmGssgzUVi8axRPL/dplhUTuXq8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbae3e62-4741-441b-1674-08d610d6488f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:16:08.0310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
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
index fd7e9937ddd6..e9359272c5cb 100644
--- a/arch/x86/kernel/machine_kexec_32.c
+++ b/arch/x86/kernel/machine_kexec_32.c
@@ -70,7 +70,7 @@ static void load_segments(void)
=20
 static void machine_kexec_free_page_tables(struct kimage *image)
 {
-	free_page((unsigned long)image->arch.pgd);
+	free_pages((unsigned long)image->arch.pgd, PGD_ALLOCATION_ORDER);
 	image->arch.pgd =3D NULL;
 #ifdef CONFIG_X86_PAE
 	free_page((unsigned long)image->arch.pmd0);
@@ -86,7 +86,8 @@ static void machine_kexec_free_page_tables(struct kimage =
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

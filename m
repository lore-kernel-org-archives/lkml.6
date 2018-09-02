Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C1BC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E59220835
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XtiaIFfM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E59220835
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbeIBRUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:20:52 -0400
Received: from mail-eopbgr680117.outbound.protection.outlook.com ([40.107.68.117]:50363
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728321AbeIBRUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/HFXmI7ykAxsLqcir6BctWe4FkeGzrGBMjcZ7LLqmg=;
 b=XtiaIFfMgO/SpDqYiN7tR0dhQXAngaEniP7PkFLu6RdOnBVZNOsTdvYVBHBzW+DsWt0MzKxw5bMQ+7YvEYZupxYTmedoRdr+cxR5/KIiOkhMLes0hk3ByNBqc0tN4FmSI7lw38BSKirnvCN2iRZiZRGkAwsR8H2mfIfjwAXPoSg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:53 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:53 +0000
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
Subject: [PATCH AUTOSEL 4.18 073/131] x86/kexec: Allocate 8k PGDs for PTI
Thread-Topic: [PATCH AUTOSEL 4.18 073/131] x86/kexec: Allocate 8k PGDs for PTI
Thread-Index: AQHUQr2AgA4Nl75l9UGONf6ZpoMAwQ==
Date:   Sun, 2 Sep 2018 13:04:37 +0000
Message-ID: <20180902064601.183036-73-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:auUwmAR9cL6XLJxSn85mWJBJjEXl8VQpbY6vYPMZtiJ62FA1ECuuPWGbabApLL9jbgud4W0A83FgUsZvlU4Ovxt9r15Ixml2KvRoy6PNElWJNpqlM/xc6cegf8JVKUJQBCfK74s7InfwTjlmYNKwSjvbg/xeNMhY6/GIoW+B8IGtUibxOqUq59+bkHrLGhnWGyLrfCkSuTT9IgNAKhnU88xAkMDbQ41QpjSwaJW2yJTtNGaG4+5ybPkcv7hR16yx//S+SDjwB8P+oEjPAAnSXINlmWdddzO8CGkeckNoFOXt1Xa+1hsz4B0i9GWBqI6x0yblEvpN72F00PCPq35wm7QMM7gTDMGuY5pdYNQy2FFfzSJx5fT7BrSq5QNipTeSzJiksG2jiUjjBBqJz/OLK8AdH7CJdzqFJZoVn00rNAyS/d6x1d0Lx7v/pnj/NWiOFXYUmhQCRmVw6sA6bPabrQ==;5:5Ex8XZ5VGljh3anht2weCZaJb1xWgMOwOw9oGgaVWHms6oANJsIHTQz+O+scfau+nuqDuioM7/Ib+AOUq5CPDb3mcjMOgX8ItUYcP8cEiYvTQ3hpORXxggG0aFRZBBznFF1UHd3ECo3RVQi0YO1uI0BCv0690kwbU8kc40BYYBE=;7:gNuQ94mPPoIRxI1+HnMtVj59/p4C92ZSRCcC36/h9EHR/HNNLc8SHqEyTrORBvFDZcMI8sYEHj+Wr++eXqiyJuOhqDy7+TCwRyzrZ2/ODvQx5bkOiHv8RzvSj+kCmxAguTQcPFcGiEjHs43olxAkQQPSKPeRWz2gsYu0wU2hsMjChuOcYswPvQoD20JfMzcxEMs19fiPQCZBoByCDFVsCBTReDJgeKWM8MY2py5wC0c0tvh++0e8BqZ6HPYBHN3G
x-ms-office365-filtering-correlation-id: 25319e02-bf52-4389-d387-08d610d4ace6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB0741C906510D6AE428FE69F4FB0D0@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20283166320243)(28532068793085)(180628864354917)(89211679590171)(33061846794335)(85827821059158)(211936372134217)(42068640409301)(146099531331640)(47284530071512);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(97736004)(2906002)(186003)(26005)(256004)(14444005)(102836004)(11346002)(25786009)(476003)(486006)(2616005)(446003)(305945005)(66066001)(5250100002)(2501003)(7736002)(6506007)(8676002)(68736007)(76176011)(6666003)(99286004)(6486002)(39060400002)(105586002)(81156014)(81166006)(53936002)(7416002)(5660300001)(22452003)(478600001)(6436002)(86362001)(14454004)(54906003)(36756003)(106356001)(110136005)(6512007)(4326008)(6306002)(107886003)(217873002)(3846002)(2900100001)(7406005)(316002)(8936002)(1076002)(10090500001)(6116002)(72206003)(86612001)(966005)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rYpgndPV7GglSLsxVffv48xIvWah6Hns85QnUq+6ipip+416S1xRcglL1HXvKJMa2zKypAKtlWELrsEm4ALs2MFunUgzXRgyt64b/AM0jMD+4quOPRWrqyB/MwC2PVM6nU6cIxhR61CA77BR3hE9VBM5iRfjQg0gl7IdLmTnYPo6Ez29QCFJuYepdix7dvZv3FFcAnLjKuXpPAxWAGiEaYstSpeFTgUH+bLBzL7jZXPGN55vzXJ7ul9pjN9MauPJqj6hDPzr51gLVztZriwJM5vIfNyiCWydYdBI5GJlgYh5eBufK/sfvhQn3C1XWZPEglY5EBqoiob9y+I0c3KudwsCVg3DrB8tDBXTp1nJRW4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25319e02-bf52-4389-d387-08d610d4ace6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:37.3056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
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
index d1ab07ec8c9a..5409c2800ab5 100644
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

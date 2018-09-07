Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7DEC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092532083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MAoUPeXh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 092532083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbeIGFSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:18:50 -0400
Received: from mail-bn3nam01on0093.outbound.protection.outlook.com ([104.47.33.93]:60384
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729296AbeIGFSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hu63KFvTbz8FrX0AfqqJmcmfoc/fUItVNMJse89Lbog=;
 b=MAoUPeXhhLirG23A+EMoQrJ+opbuViEmCIgM3bFyZ5uuOHNjxcGdCE0DHM3mLFCKlreW9EartEykseZQU74f5oVyWZyQv184D9/nLNU2cNnOEPabiNRJ7qa5bdfER99mmrCgp6xPMc1puvkBL0hUXrvEqnt6G+DkQSGpmVQDnfk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:40:00 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:40:00 +0000
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
        Waiman Long <llong@redhat.com>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        "joro@8bytes.org" <joro@8bytes.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 67/67] x86/mm/pti: Add an overflow check to
 pti_clone_pmds()
Thread-Topic: [PATCH AUTOSEL 4.14 67/67] x86/mm/pti: Add an overflow check to
 pti_clone_pmds()
Thread-Index: AQHURkMNr95K6teAAEuHaXPPdMkYqQ==
Date:   Fri, 7 Sep 2018 00:38:10 +0000
Message-ID: <20180907003716.57737-67-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:ozd7wRviIT3JW9iZijaNsaKX71jR5myxR2h0lolar9jMvZhyA/yGI+DbsBu6LzBc0SZvwELwb5HIXjn7x5RBKe7xpQAc1xF8H9yrHgQJDQVTm26zMbTtG1LwGjo2a7Ylcrj5nbdCFhVu1wZdA4rMiZj3ysmcmAs//T56tWToi++yB23mm8XkTlxJMXrh/W8MASQL9YvdLiBdh+SWuqBuEAelIMTfv4ZXDdB9/a+39C9rVJFqqjzTIm7imSKWtD634zQej1hd8/RiPCv2PgOb3zGtx8a7GRFXAsxELPxbPI5YaSgCos+1+yw7/hKVYH2Tg+gZZGv+2iFdVuuo9qtBu7OOsU53e+8SnNAH247lL/4n6ee1boacbDWUWm0mNA+fj4fQQ7tLKgezWFNWFnPTTBSs6PY1IGy9cGLq2eyJnmiabU2V3jwYlCOAmdC3MCCUNLFLhBSAjLWOLciAcwGWWw==;5:hCLNR4t5Fk24PSxLd/gGmN07h9/9X5RSxVWr4+cxr0jKQK0Hhy+3FU4Idin8uJgFx2S3UnVp6h/611I2RoLplAVo0AUkk1o3JM64jQDAjcuSXpdU4eY5PZl4lopBLRYFRuH2XAh7uxSJt679OOf5fJYzSQBqKW1VqmgvSrc3M6Q=;7:NOS9M+SbudBlrYhnouENDQJKc5dVMf2WX8ev/1F4ydLWq3Dn1RVyhLsBD74Z39w5bX4im+g3Cveb+l4RHljmeeIsBoF+ADN2GXs5kdXYgpeiXZO5fUc3fg4XSSuMzE6zJN5xYdb/iIlwe9GgvqjXHvhc8j55lXeO8VDgXYzsGE9jcBBWFLC2svdgZUGfDhRu8rRWICLKsQ8UMrvyU5O9WgqL3StNUmgmkWhtre31ExQd9/cKuHgBxGfmlhPx1N83
x-ms-office365-filtering-correlation-id: 3e4e3081-db58-48c9-8546-08d6145a7195
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB08553D6F6A004AFDDB1A4490FB000@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20283166320243)(28532068793085)(180628864354917)(89211679590171)(33061846794335)(85827821059158)(211936372134217)(42068640409301)(146099531331640)(47284530071512);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(366004)(376002)(39860400002)(189003)(199004)(53936002)(316002)(97736004)(2900100001)(86612001)(25786009)(86362001)(2906002)(6306002)(6512007)(54906003)(39060400002)(107886003)(68736007)(110136005)(4326008)(81156014)(10290500003)(14454004)(8936002)(66066001)(81166006)(8676002)(3846002)(966005)(6116002)(478600001)(72206003)(7736002)(305945005)(1076002)(7416002)(106356001)(105586002)(6506007)(76176011)(10090500001)(6486002)(99286004)(256004)(36756003)(2501003)(26005)(186003)(6666003)(5250100002)(6436002)(5660300001)(102836004)(217873002)(476003)(2616005)(486006)(22452003)(11346002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BU6m1QXa0Vh6EI/0EjloCyLAGk8uU64+n8qmM6+7Mjk01kW12jDHsVxVtiWuCoUoR3nQl9RzSwaDPQiAJ6lbHfe62SOF3WVQE3U0d7ozSNvMcWemJl/XXo/e3QebXhbmHT+terjgxA/riZD0sF0sl4ixV0KOsMN5/mt120thwRkF6ZiMexWPf6Bv/NBXLCh0f/NRmdrPm3vceTg9rDaHpIlPiVSxKGD5othms4wDPpeBtk6gGFhM/d89HZyKIjIf+HJlwCli97jcHaDEsDqgnTQcAKHrroSif/hdpmlmQZ7ljKdvc/OuGehY1rmLLAnNsxN32eYd+/YHJN5PKId+NZsUoV71nhPR4kUSN7fTNDM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4e3081-db58-48c9-8546-08d6145a7195
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:10.0701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

[ Upstream commit 935232ce28dfabff1171e5a7113b2d865fa9ee63 ]

The addr counter will overflow if the last PMD of the address space is
cloned, resulting in an endless loop.

Check for that and bail out of the loop when it happens.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Pavel Machek <pavel@ucw.cz>
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
Cc: "David H . Gutteridge" <dhgutteridge@sympatico.ca>
Cc: joro@8bytes.org
Link: https://lkml.kernel.org/r/1531906876-13451-25-git-send-email-joro@8by=
tes.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/mm/pti.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 7786ab306225..b07e3ffc5ac5 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -291,6 +291,10 @@ pti_clone_pmds(unsigned long start, unsigned long end,=
 pmdval_t clear)
 		p4d_t *p4d;
 		pud_t *pud;
=20
+		/* Overflow check */
+		if (addr < start)
+			break;
+
 		pgd =3D pgd_offset_k(addr);
 		if (WARN_ON(pgd_none(*pgd)))
 			return;
--=20
2.17.1

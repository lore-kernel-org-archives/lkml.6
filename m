Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD96C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAEDD2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="e1JfM6Si"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAEDD2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbeIGFPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:15:53 -0400
Received: from mail-sn1nam02on0118.outbound.protection.outlook.com ([104.47.36.118]:6328
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729522AbeIGFPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MHaB83DkVxmPbe2gikclHNslR1QrnWGTsU/73wAv7E=;
 b=e1JfM6SiUebFfigV0o2fqJmfSG+Al7OLQTi+NNteJeTgj/B87HdSETDksagx47f6BMJu2Yl1Oj8ouU8qj3MSd4uBgcDi+RC60Ik/cq6OmclUdEbsGJEvzLAAjG5cHzB5nUfal3KiSaE64DGdhoc6r3ixA+MPfUEnqVg5BjBPCaw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:37:40 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:37:40 +0000
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
Subject: [PATCH AUTOSEL 4.18 87/88] x86/mm/pti: Add an overflow check to
 pti_clone_pmds()
Thread-Topic: [PATCH AUTOSEL 4.18 87/88] x86/mm/pti: Add an overflow check to
 pti_clone_pmds()
Thread-Index: AQHURkLfBdAoKRBJBE+KJ3vVDo65pA==
Date:   Fri, 7 Sep 2018 00:36:53 +0000
Message-ID: <20180907003547.57567-87-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:9Y4KDxRKkl+8OYwvpgmX6iBuEcieApMKYv5fZrBeMExK3e2ZPX4DscrZHijvuJApRmvVRRkFLdxeWPia2rvqGPlgzpK3lmUQOZfcl1mhKl0GmXNSdPKDFs7RR1v5kq234keff8uAMLGQ93Lx2cvstyjzqIZmq5ZldYEsq4V1O7th72+qHqkoT0831AR0u9XPszvsj34ZuxyJyu3LH+GADiD6whWgAIoiOgJgDVCbVS0Kn8M6UpmI+syKgunypcUz0Zje5B86JeR3bCtChciwNgmNdwJ8R+kp8ZbUjJbz9SEfmW10ZVqeiGfxGPp1xF7bY7ObaqZKkXAoJCM7WCvNBDpFU31I6z9X3bOKZA9gXHpvnvzLUU4/GDdhjGPX471weiEhpzxrDsyo+ouqCKe4LbfpfVu945kJRuzqnA24axV6pfJHvddw2Khy2d0R+lS76UEZ9IKmq6Uyf0PnOMKOOQ==;5:dOvqL8uopa9Px3hZloRiulbN7uCE9olpjQ6RQ8V25oob14VaUna5VieWQ52hV9cD9YJhVkVDzeQCLvA7RW3wmXdVmw/BAfe4VA5FBY7jeIWNvBcK+lNVHUJY/kJFYLzVYMX6mMom4JrVWUmP6B6ZFl2DDXzunY2PSFcRCJij0Nc=;7:rjer4zvvHGE7wxg1TZtUcp3yp8sxpScmBOjSc0qGIZMrO3reUQd2Xto1uYa2vP6CqWxWjjNgJoRU1zlqYQK/9SVQXiyrVJB6AytvnZipap3PI91YM9f1q3h7UgbQa1vSkP6DBRdhxjIkqoi8k5wAW+gb37nQES1+Lwk6lHF4wRg/+UE9rwDJ+Bd5N9jNGzHGnRzzjx8PtWZed2+gEIIyK4tRmIGLF+zbDl6acmKMWyJREWjnJt8k8yVZ6zhsP9vn
x-ms-office365-filtering-correlation-id: d9dffca8-b137-431d-cfbb-08d6145a1e71
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB01811026C4B1CC82C90CF5E9FB000@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20283166320243)(28532068793085)(180628864354917)(89211679590171)(33061846794335)(85827821059158)(211936372134217)(42068640409301)(146099531331640)(47284530071512);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(136003)(376002)(346002)(189003)(199004)(217873002)(72206003)(22452003)(966005)(2900100001)(8676002)(10290500003)(2501003)(478600001)(68736007)(305945005)(76176011)(81156014)(105586002)(81166006)(7416002)(256004)(10090500001)(8936002)(14454004)(2906002)(5660300001)(110136005)(54906003)(316002)(106356001)(6346003)(6436002)(26005)(25786009)(1076002)(99286004)(6116002)(6512007)(39060400002)(3846002)(7736002)(186003)(4326008)(6666003)(107886003)(6306002)(476003)(66066001)(97736004)(86612001)(2616005)(6486002)(446003)(53936002)(575784001)(86362001)(11346002)(102836004)(486006)(36756003)(6506007)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: dvRseBMDdOoqoEcjTQohqjPLC83sl078TawctBQ6AC/wVS2WvKxgszV7TqQScu9+Sc4tPVapYwOIm2Kuylzwsyhi7jdgOO8hWrRtchFi4QdzQT8PdOSZumzidhrmmLn3y3PQ6naJhzsxxm1uBazTGlzGFryu5V1SCAQWQ069B5ET1gR/EkTjtkB5XOAIO/+sU/+ixKRpxx+haG/uMc7nroYvkJwYA7IIy9GLdSSkgO7DIASmF4XXish5+xZS3z8cfSGhiFxQYZ5FPuE6DoIYplwQtlokngdslFCBDSxEJrzyhT5PIpgRO+VqAm3mqkMMoMwis2Ele8O4mGFCEdoOvGRZ33nwwQ1Hz8/IPmeRMKk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9dffca8-b137-431d-cfbb-08d6145a1e71
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:53.6975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
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
index ffa2f0f67904..1d2106d83b4e 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -306,6 +306,10 @@ pti_clone_pmds(unsigned long start, unsigned long end,=
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

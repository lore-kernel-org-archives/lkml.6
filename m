Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A82C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F115204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GBh1We7n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F115204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbeIBRVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:21:05 -0400
Received: from mail-sn1nam02on0106.outbound.protection.outlook.com ([104.47.36.106]:31968
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727453AbeIBRVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6BZE0sTCpnYVRM+vCGyXKK/zr/w465Ktw7fOH45lcc=;
 b=GBh1We7nYqfMLQe0f9HlDHu/GgOEWOVbuIATTiyTuUptemZY31PIlmCzIpWpgJMTob1PuBY4NTDX4aZI5OtoWy5hGeoCza+mZQyOdXgpI1JrqJdr6N8EkZwZsmtawlDIO51a1XnsitRk3w5fy8EeP44eoqay1xxE6TMwvru16b4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
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
Subject: [PATCH AUTOSEL 4.18 072/131] x86/mm: Remove in_nmi() warning from
 vmalloc_fault()
Thread-Topic: [PATCH AUTOSEL 4.18 072/131] x86/mm: Remove in_nmi() warning
 from vmalloc_fault()
Thread-Index: AQHUQr1+cYypuF6UO0qmfPDsanQTqw==
Date:   Sun, 2 Sep 2018 13:04:33 +0000
Message-ID: <20180902064601.183036-72-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:eQOhVbAxZMRaySANj9ewzcnPwncL4l0o50zg1Blz96fZB9o8DMTkKp/J8+/7wT/qlq+vGUaoiYhFbQUSQmHMyWg+hy3XjXyuC/Pnv0lzA56sGwECZnLVSjXGqiZR+W94Qr3Kc+q4OGyH0EcnZBPqtYXqWPiBy9bmvfwDuIV14E7EPhZYO3wYCj2n4GOBl/NgLc2YA19r3f5ES03EFD4SsgJisS3Xr9aYEvm4I6vSRLV9ETF806koIXd8+CDrvt/M7qKikwt6vR00Mf5cMMSOZlw39Eo3OPWlgxwyQmBCDBCdGSYBAodHEZsGrqAEzX0xzKYqRQbTpVYdtijzK8uvpSuS5QnKXTOQLP8q2ui2j+5LQQEDzCG17MttJTugwpraeAFRu3YlbkCeQI8DuiMAhGbd+NLRslSqfgfT6HtOgvNbMb6xP9vk0gEad3Vq7TO+iOnQkbtqOe0gQwU9RaPvoA==;5:s39ZpkZlLgmpumSwEMSyBjyuqJx0jdGq6tcupYjwAf3JR9+Mhm8zmWSXALHHJljpJ4Mto77FwMW2UPSt6x+YYwbyiGy2b3h7v/XUC5Axo0gTFaL8ktFyX4fvusIxMzev+wNWl8I6zcIjJVOJpw1kdbL5hLseqJzgcFjNDD1WNW4=;7:XhFpwc4zrIJRcrlX94kwfYcjvD5iAOK9gzTEfZP3gl7fN6BftU6czpdkuZOZV+hZmPxK4CjyP+1Si6PqtQBQPZiR2upQp8pl4Wc26zfyMwOHwqAAlUrzdBbpJgp4z3eW0eUe+UvdzDIomiOemFOM2EVtu2x3q7oaJzRs6vKLzgHNbsiFMXt+FkHJsajigXuN7d04/jKZgE/JPkVXxiR34z4O0Vw5+/cNHIzDLf5DytEzPa2BbKDSkKGxkeCNdIMM
x-ms-office365-filtering-correlation-id: 433639fe-f2f6-49ee-ff04-08d610d4ac9b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB0120AED1502A09D83C7022BFFB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20283166320243)(28532068793085)(180628864354917)(89211679590171)(33061846794335)(85827821059158)(211936372134217)(42068640409301)(146099531331640)(47284530071512);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(366004)(346002)(39860400002)(199004)(189003)(7416002)(110136005)(5660300001)(7406005)(107886003)(26005)(6506007)(6666003)(2900100001)(8936002)(68736007)(66066001)(99286004)(76176011)(39060400002)(217873002)(2906002)(1076002)(316002)(3846002)(6116002)(86612001)(14444005)(54906003)(6436002)(305945005)(7736002)(256004)(575784001)(86362001)(6486002)(25786009)(10290500003)(478600001)(14454004)(476003)(22452003)(5250100002)(97736004)(106356001)(72206003)(966005)(53936002)(2501003)(2616005)(446003)(11346002)(6306002)(6512007)(10090500001)(4326008)(36756003)(105586002)(102836004)(8676002)(81156014)(81166006)(186003)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 261+kN92I2nWRlu3WoweZvnYOSFqO/JkzdAileRsw0c8fc+BFtzxU9yJd38KNMGcseAC3ZybUc/cTUcGf27r/oY14ts/LteMUR9n0vEuhQjWVWSJvlyKfze5W++XytlFDMQJ0AKkDGn2Fq1WJQwrBC72JWOrJSvIZL0bWvU6PzxTYm5Eo7am1A0ZXJRS+cSEUJHfg6GevTjQD3bPy0TYiNg7kqJ5bdBJUpBKfeGjJ5M2Jx5C/fhFOJDSgB9v8jYXeOw10K6EcuPAK2bDCTb42T21kN6qyobnpSNhCvjFKL8WFCv7t8w2qyIyTr+89LGrhsUEb+/ABMMYd14n9YO64LiwjEr/hE9Cw9HF/ebBVt0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 433639fe-f2f6-49ee-ff04-08d610d4ac9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:33.8087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

[ Upstream commit 6863ea0cda8725072522cd78bda332d9a0b73150 ]

It is perfectly okay to take page-faults, especially on the
vmalloc area while executing an NMI handler. Remove the
warning.

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
Link: https://lkml.kernel.org/r/1532533683-5988-2-git-send-email-joro@8byte=
s.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/mm/fault.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 2aafa6ab6103..db1c042e9853 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -317,8 +317,6 @@ static noinline int vmalloc_fault(unsigned long address=
)
 	if (!(address >=3D VMALLOC_START && address < VMALLOC_END))
 		return -1;
=20
-	WARN_ON_ONCE(in_nmi());
-
 	/*
 	 * Synchronize this task's top level page-table
 	 * with the 'reference' page table.
--=20
2.17.1

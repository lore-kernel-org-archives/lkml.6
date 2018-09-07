Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E034C43143
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C51B820857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="blh4R3FU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C51B820857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731379AbeIGFU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:20:56 -0400
Received: from mail-bl2nam02on0097.outbound.protection.outlook.com ([104.47.38.97]:7296
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730477AbeIGFUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qK104y4Fy48+hwjk2kixi6W/SbWNqOODMyDDfs0XhWc=;
 b=blh4R3FUVsV5paVqdxHJE9C/T1BKz/deDNKb3O5KgyGRFF4x6rh0QrGT16EqDLpTF4zACl5clyi3IqeZNaoiSXftHRSTjgzSHXWmeqoIu4fgeAY32z0pvCDALiZfFQmLykTBZKgXuoAsBi9+/XvkQyIMQhNiKh2EZnDytEJNHAo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0631.namprd21.prod.outlook.com (10.175.115.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:42:45 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:42:45 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sandipan Das <sandipan@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Maynard Johnson <maynard@us.ibm.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 14/19] perf powerpc: Fix callchain ip filtering
Thread-Topic: [PATCH AUTOSEL 3.18 14/19] perf powerpc: Fix callchain ip
 filtering
Thread-Index: AQHURkNAREQnmUU8kkW5WKCvX2+Ulg==
Date:   Fri, 7 Sep 2018 00:39:35 +0000
Message-ID: <20180907003923.58019-14-alexander.levin@microsoft.com>
References: <20180907003923.58019-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003923.58019-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0631;6:CUrWRjFLClv0vRQ9McnDyah8kRHO0H6tDbzJO0MYlMZy+KcGdVeaUdv16HTzL7l2DAVhbGiEPMxCrjl3bu88WU0vOeiQDoZ20PaG9l2qVwLSjaa0fFZC3U9nneK8lpT7SdL8l1WZmTRlKNjDpo1UzGcPNO3kmev/mwBNZehbFkqNLgvNZD4zSNC3bpHmxAhSSe8NmYrEgoix23OCK6HKPkt37x9NoKFxdLpegpXA34YfaarqHnEPuBXBgvXVrdEp4KHSZa7UJflkb1hMHsypZfv0Y5G016XVMnDupqa0r4gVl948mbrWAGX9/RNnaagp7Z7NBK6JHYo6BidE0IvW5nMttHoh6WTxzTg5iFN3MPIURd/tKnjiCFqNJ/n4htPbwXXIwrl75bAwRroqrhfy841BaoXdIRiw1sQFpiyBs5q0qtQzcZFKPDoE2E7QPfy/Y7PzEnQVmEECDg0aVBKv2g==;5:+Vz+EZ2vjMuQbD251L/NivOvx22bQNI/FgOoOvzTVf7NKv6JUedYmrs2JNKHEWwMrYrCtF8SDiRiKVzXkSU8dOVy8/V3unJtqhbEccenT/QX+FVss/K6qMDGWiln92OSVZEQsn/BRBNsPN/Xe438VayxiOGqgJE3H/CbSsNqkaY=;7:8UMtv0EphGkByjKjBsNks7P2hbTkFE/Q+O0xIAN3eOeGkPww3MkVQkstF5MrgUDN1EU287PiptCB1zTkg5zfsmUoBmwGsF43VZ8e6J2fV/gx/k0pBJ6EsS8aHO4+fFX8xlIiW5nAWmpWVBKRtRDwbvuw/OduJOPgc9sZ3Bd7V7KoIHlSHNfLNkDukRWCF7kDebepNO2/irqqRr7T+2Zf6aR7XIInZ2ES+2BuM4shSR34eC+S0iOjaYq1fqie2Q3w
x-ms-office365-filtering-correlation-id: 8432957f-c9cb-4e41-ef3d-08d6145ad3ac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0631;
x-ms-traffictypediagnostic: CY4PR21MB0631:
x-microsoft-antispam-prvs: <CY4PR21MB0631DEF260AB9B47CD74896DFB000@CY4PR21MB0631.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(274839183919467)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0631;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0631;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(346002)(376002)(396003)(189003)(199004)(8676002)(72206003)(5660300001)(26005)(66066001)(966005)(6486002)(2501003)(14454004)(8936002)(6506007)(81166006)(36756003)(97736004)(10290500003)(81156014)(478600001)(22452003)(6346003)(4326008)(217873002)(10090500001)(102836004)(1076002)(107886003)(6436002)(256004)(68736007)(106356001)(5024004)(14444005)(110136005)(486006)(11346002)(6666003)(186003)(6512007)(99286004)(2900100001)(105586002)(7736002)(305945005)(6116002)(2616005)(3846002)(316002)(5250100002)(54906003)(2906002)(86612001)(25786009)(476003)(6306002)(76176011)(446003)(53936002)(86362001)(575784001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0631;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: zM0akIOhEIWnuVoXIRpG6gcgdQwEtEkELdIj3if7UJab0jfB4MdqC1FUKhN1Mpg2HtHKGw3NtXtq0zSgGPe+awzsqssHhkhueRGlffvclbEhtbh9rjB9IWNj5NLihpZytlUvheR2OdMCLVqJe9sWmtFdwQ900u26j3gHTqvmD7Efz/84/7iAs2UAhh5n1t1bcWCqz3Shxm54NaOAQPaJ7U8OhG3TTKwNxow56kDc1C132RFjYDCNoLptgtBV4/JMdpU8wpARpXvzic7jN+V9C2usC3JMn+g2JPr18gfa0HSmV/igwgvgSIJedg2iJy09mtbKQwnDLOymqGWdpKaqt2OaRyAHjiwqxL3G20a50oA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8432957f-c9cb-4e41-ef3d-08d6145ad3ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:35.8263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0631
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandipan Das <sandipan@linux.ibm.com>

[ Upstream commit c715fcfda5a08edabaa15508742be926b7ee51db ]

For powerpc64, redundant entries in the callchain are filtered out by
determining the state of the return address and the stack frame using
DWARF debug information.

For making these filtering decisions we must analyze the debug
information for the location corresponding to the program counter value,
i.e. the first entry in the callchain, and not the LR value; otherwise,
perf may filter out either the second or the third entry in the
callchain incorrectly.

This can be observed on a powerpc64le system running Fedora 27 as shown
below.

Case 1 - Attaching a probe at inet_pton+0x8 (binary offset 0x15af28).
         Return address is still in LR and a new stack frame is not yet
         allocated. The LR value, i.e. the second entry, should not be
	 filtered out.

  # objdump -d /usr/lib64/libc-2.26.so | less
  ...
  000000000010eb10 <gaih_inet.constprop.7>:
  ...
    10fa48:       78 bb e4 7e     mr      r4,r23
    10fa4c:       0a 00 60 38     li      r3,10
    10fa50:       d9 b4 04 48     bl      15af28 <inet_pton+0x8>
    10fa54:       00 00 00 60     nop
    10fa58:       ac f4 ff 4b     b       10ef04 <gaih_inet.constprop.7+0x3=
f4>
  ...
  0000000000110450 <getaddrinfo>:
  ...
    1105a8:       54 00 ff 38     addi    r7,r31,84
    1105ac:       58 00 df 38     addi    r6,r31,88
    1105b0:       69 e5 ff 4b     bl      10eb18 <gaih_inet.constprop.7+0x8=
>
    1105b4:       78 1b 71 7c     mr      r17,r3
    1105b8:       50 01 7f e8     ld      r3,336(r31)
  ...
  000000000015af20 <inet_pton>:
    15af20:       0b 00 4c 3c     addis   r2,r12,11
    15af24:       e0 c1 42 38     addi    r2,r2,-15904
    15af28:       a6 02 08 7c     mflr    r0
    15af2c:       f0 ff c1 fb     std     r30,-16(r1)
    15af30:       f8 ff e1 fb     std     r31,-8(r1)
  ...

  # perf probe -x /usr/lib64/libc-2.26.so -a inet_pton+0x8
  # perf record -e probe_libc:inet_pton -g ping -6 -c 1 ::1
  # perf script

Before:

  ping  4507 [002] 514985.546540: probe_libc:inet_pton: (7fffa7dbaf28)
              7fffa7dbaf28 __GI___inet_pton+0x8 (/usr/lib64/libc-2.26.so)
              7fffa7d705b4 getaddrinfo+0x164 (/usr/lib64/libc-2.26.so)
                 13fb52d70 _init+0xbfc (/usr/bin/ping)
              7fffa7c836a0 generic_start_main.isra.0+0x140 (/usr/lib64/libc=
-2.26.so)
              7fffa7c83898 __libc_start_main+0xb8 (/usr/lib64/libc-2.26.so)
                         0 [unknown] ([unknown])

After:

  ping  4507 [002] 514985.546540: probe_libc:inet_pton: (7fffa7dbaf28)
              7fffa7dbaf28 __GI___inet_pton+0x8 (/usr/lib64/libc-2.26.so)
              7fffa7d6fa54 gaih_inet.constprop.7+0xf44 (/usr/lib64/libc-2.2=
6.so)
              7fffa7d705b4 getaddrinfo+0x164 (/usr/lib64/libc-2.26.so)
                 13fb52d70 _init+0xbfc (/usr/bin/ping)
              7fffa7c836a0 generic_start_main.isra.0+0x140 (/usr/lib64/libc=
-2.26.so)
              7fffa7c83898 __libc_start_main+0xb8 (/usr/lib64/libc-2.26.so)
                         0 [unknown] ([unknown])

Case 2 - Attaching a probe at _int_malloc+0x180 (binary offset 0x9cf10).
         Return address in still in LR and a new stack frame has already
         been allocated but not used. The caller's caller, i.e. the third
	 entry, is invalid and should be filtered out and not the second
	 one.

  # objdump -d /usr/lib64/libc-2.26.so | less
  ...
  000000000009cd90 <_int_malloc>:
     9cd90:       17 00 4c 3c     addis   r2,r12,23
     9cd94:       70 a3 42 38     addi    r2,r2,-23696
     9cd98:       26 00 80 7d     mfcr    r12
     9cd9c:       f8 ff e1 fb     std     r31,-8(r1)
     9cda0:       17 00 e4 3b     addi    r31,r4,23
     9cda4:       d8 ff 61 fb     std     r27,-40(r1)
     9cda8:       78 23 9b 7c     mr      r27,r4
     9cdac:       1f 00 bf 2b     cmpldi  cr7,r31,31
     9cdb0:       f0 ff c1 fb     std     r30,-16(r1)
     9cdb4:       b0 ff c1 fa     std     r22,-80(r1)
     9cdb8:       78 1b 7e 7c     mr      r30,r3
     9cdbc:       08 00 81 91     stw     r12,8(r1)
     9cdc0:       11 ff 21 f8     stdu    r1,-240(r1)
     9cdc4:       4c 01 9d 41     bgt     cr7,9cf10 <_int_malloc+0x180>
     9cdc8:       20 00 a4 2b     cmpldi  cr7,r4,32
  ...
     9cf08:       00 00 00 60     nop
     9cf0c:       00 00 42 60     ori     r2,r2,0
     9cf10:       e4 06 ff 7b     rldicr  r31,r31,0,59
     9cf14:       40 f8 a4 7f     cmpld   cr7,r4,r31
     9cf18:       68 05 9d 41     bgt     cr7,9d480 <_int_malloc+0x6f0>
  ...
  000000000009e3c0 <tcache_init.part.4>:
  ...
     9e420:       40 02 80 38     li      r4,576
     9e424:       78 fb e3 7f     mr      r3,r31
     9e428:       71 e9 ff 4b     bl      9cd98 <_int_malloc+0x8>
     9e42c:       00 00 a3 2f     cmpdi   cr7,r3,0
     9e430:       78 1b 7e 7c     mr      r30,r3
  ...
  000000000009f7a0 <__libc_malloc>:
  ...
     9f8f8:       00 00 89 2f     cmpwi   cr7,r9,0
     9f8fc:       1c ff 9e 40     bne     cr7,9f818 <__libc_malloc+0x78>
     9f900:       c9 ea ff 4b     bl      9e3c8 <tcache_init.part.4+0x8>
     9f904:       00 00 00 60     nop
     9f908:       e8 90 22 e9     ld      r9,-28440(r2)
  ...

  # perf probe -x /usr/lib64/libc-2.26.so -a _int_malloc+0x180
  # perf record -e probe_libc:_int_malloc -g ./test-malloc
  # perf script

Before:

  test-malloc  6554 [009] 515975.797403: probe_libc:_int_malloc: (7fffa6e6c=
f10)
              7fffa6e6cf10 _int_malloc+0x180 (/usr/lib64/libc-2.26.so)
              7fffa6dd0000 [unknown] (/usr/lib64/libc-2.26.so)
              7fffa6e6f904 malloc+0x164 (/usr/lib64/libc-2.26.so)
              7fffa6e6f9fc malloc+0x25c (/usr/lib64/libc-2.26.so)
                  100006b4 main+0x38 (/home/testuser/test-malloc)
              7fffa6df36a0 generic_start_main.isra.0+0x140 (/usr/lib64/libc=
-2.26.so)
              7fffa6df3898 __libc_start_main+0xb8 (/usr/lib64/libc-2.26.so)
                         0 [unknown] ([unknown])

After:

  test-malloc  6554 [009] 515975.797403: probe_libc:_int_malloc: (7fffa6e6c=
f10)
              7fffa6e6cf10 _int_malloc+0x180 (/usr/lib64/libc-2.26.so)
              7fffa6e6e42c tcache_init.part.4+0x6c (/usr/lib64/libc-2.26.so=
)
              7fffa6e6f904 malloc+0x164 (/usr/lib64/libc-2.26.so)
              7fffa6e6f9fc malloc+0x25c (/usr/lib64/libc-2.26.so)
                  100006b4 main+0x38 (/home/sandipan/test-malloc)
              7fffa6df36a0 generic_start_main.isra.0+0x140 (/usr/lib64/libc=
-2.26.so)
              7fffa6df3898 __libc_start_main+0xb8 (/usr/lib64/libc-2.26.so)
                         0 [unknown] ([unknown])

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Maynard Johnson <maynard@us.ibm.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Fixes: a60335ba3298 ("perf tools powerpc: Adjust callchain based on DWARF d=
ebug info")
Link: http://lkml.kernel.org/r/24bb726d91ed173aebc972ec3f41a2ef2249434e.153=
0724939.git.sandipan@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/arch/powerpc/util/skip-callchain-idx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/perf=
/arch/powerpc/util/skip-callchain-idx.c
index b070893bfcfe..d03992ee217d 100644
--- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
+++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
@@ -237,7 +237,7 @@ int arch_skip_callchain_idx(struct machine *machine, st=
ruct thread *thread,
 	if (!chain || chain->nr < 3)
 		return skip_slot;
=20
-	ip =3D chain->ips[2];
+	ip =3D chain->ips[1];
=20
 	thread__find_addr_location(thread, machine, PERF_RECORD_MISC_USER,
 			MAP__FUNCTION, ip, &al);
--=20
2.17.1

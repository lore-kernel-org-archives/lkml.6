Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF82C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 810F52083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XkSWpdDH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 810F52083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbeIGFPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:15:54 -0400
Received: from mail-bl2nam02on0092.outbound.protection.outlook.com ([104.47.38.92]:43727
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729606AbeIGFPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAS9dBViobeQnwU/4gckDxM1nU1cZ2wKvFUOHVWY1So=;
 b=XkSWpdDHIaH/gK6xmrvEgTiK2uvpM8H/etxoVx1QmeNSynDC063MOpmbTQ+/K5oFkp8X6LeijXWTKSiK3jmt/Z6MCCF9mUMns2XLKSQmsPmPO7uDiIVV+4A7AwH7a3/nOsLpgsloCs5Rm+P+HeNYiNWA2tcpV/QgPA1l4Q69ySc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:36:55 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:55 +0000
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
Subject: [PATCH AUTOSEL 4.18 51/88] perf powerpc: Fix callchain ip filtering
Thread-Topic: [PATCH AUTOSEL 4.18 51/88] perf powerpc: Fix callchain ip
 filtering
Thread-Index: AQHURkLR3GGJ7ADA1kmI2hm14NfESw==
Date:   Fri, 7 Sep 2018 00:36:29 +0000
Message-ID: <20180907003547.57567-51-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:LOB1wPwCqujp9dWHp5ecSqYUYNLLAzmSxnCs9LlL/9igleCdjb4aa5G22tkJ2hI6CnKuz8WVjJD3g3WW1fCvJJysygTn53N+UoQiFgVB1qlPafhHgRbwK94MsyFBl/PEAvyHVlNmmWrdeQvduwwCMoCRFucYqyS9e1AWldMd0ueCHOxPNkjWhX7dfyqTysohdVmn4ogcCRWZp3VFe7mFRaeMbaBi5NeZzjtXWsSSqb4036bP34poMBTdu0lKny8iPrC9hZsaFk7oYHjl7WxKTUKsegLdP6njV879+FzPABujyCN17JDRgeKx01yELccqUR++KEtpS+zl1SnLn33AbWDTQXKeYX4bfTYC01U47O/uuetwsTFtwue64841ALy5EloFd4xOtsa44T/tRVAfm3fejbQC9wtDyDSlfc2t06ZdIXZjpvdgCabbFXJ8GnnxeJSImEncXoFfjt1Am4FXwg==;5:ezh0c6JQFMGZ4TUXvj5ydjvzRndHWFLwpIBL2LIO/owtp5Pa/Fldzo3mpIkYvh/XCb3RB5PjhWlY3sXfPpcziTkoeFNJY2Yfx1K1eyJrjlvCAisHCUzsm1vOm83Udgg2ASM+OxaknixG6xpd5dsctZySdy5ek/BiOhDS4RP3bV4=;7:6C80S7Q1uEgEXEslcK5ZzDsLXZblFpO9mMC5Mz2KVPjw4/L/aJ74UHZicuvS+oKyPDx9V0TocAO9ZyXYuUG3q6vROz6SuVFh+zAMnqMkpDK4smzvooBHDHh5ZiOFHQ7149cmoebfc7MWw5bEhr73w4RtgpuPhmeop81IpyWxdpKpnIJnnNexS83OC9sV75OWJ8cbZQsAgQqUznmfBxC87cFOMfguDX39wobKTKE4gl7c/YmDWc2SQUETnbroQc7T
x-ms-office365-filtering-correlation-id: 761fefe5-b998-46c0-bead-08d6145a0376
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0773726814418BEE66CAF344FB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(274839183919467)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(6306002)(2616005)(476003)(4326008)(6666003)(11346002)(5250100002)(107886003)(2501003)(86612001)(97736004)(6512007)(966005)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(14454004)(1076002)(66066001)(26005)(575784001)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(14444005)(5024004)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PAuZR23L67byfaRF6ssMAesfTc5h/b2T94OrcWOQAAuh+y9VGarNcMXPvfwQd1BSJt6wRB0j+WlpqLqFCtG9taQlufxG/pxWzb8V4DfPO0znb/dptykdOve3TA+0Ip1IiZfPDYTHFCn/wgC1SuMioxyu16AWq8jOMXjMiG+wcbRvagYo/0SqamtJwIiH5VX8ipsJW/0uhX+T13vFmENXOo6k7H0urTeZ/ysR4ZFfTw+R6E5dCLz3KtKnW9Hrch0IixgBV3W3FfPnFNyRX/Qnin49gXXtNSenCHO6kQ2GdYfK1klWAIkRjJcfYtRnq6TSIQ6zL79QIyJjlWOa15s49hulvuivipWIkBfNUGxelmE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 761fefe5-b998-46c0-bead-08d6145a0376
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:30.0230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
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
index 699b73be7d91..7c6eeb4633fe 100644
--- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
+++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
@@ -250,7 +250,7 @@ int arch_skip_callchain_idx(struct thread *thread, stru=
ct ip_callchain *chain)
 	if (!chain || chain->nr < 3)
 		return skip_slot;
=20
-	ip =3D chain->ips[2];
+	ip =3D chain->ips[1];
=20
 	thread__find_symbol(thread, PERF_RECORD_MISC_USER, ip, &al);
=20
--=20
2.17.1

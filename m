Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E67C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5473720869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QQEFT1Hu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5473720869
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbeIGFhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:37:23 -0400
Received: from mail-sn1nam01on0109.outbound.protection.outlook.com ([104.47.32.109]:39556
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726681AbeIGFPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8bsTR7va80dD59bR4IqXSijGFfubsK2TEgl8L9Fmeo=;
 b=QQEFT1HugO79ouIAkLV4aF7434F0WvqXOb8ht1W7r0v+7ifckkoFPrwGKruzcesIOP89QA8NQT7ZjrjzI8Km6+VwhizMSjdGoVo9Mjmp479IxcnLW3iOAhfM3Eh2EF3pu8piaU1ubWSdO2eu6QZp6rLwPb6H1iOr86lb++OxV9Y=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:36:57 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:57 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sandipan Das <sandipan@linux.ibm.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 56/88] perf script: Show correct offsets for
 DWARF-based unwinding
Thread-Topic: [PATCH AUTOSEL 4.18 56/88] perf script: Show correct offsets for
 DWARF-based unwinding
Thread-Index: AQHURkLTaVcugtoSdk2XR8nFpiSK0w==
Date:   Fri, 7 Sep 2018 00:36:33 +0000
Message-ID: <20180907003547.57567-56-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:vF3FeZmbDwy22z3IuTAzPbHXQZv76PuF5g39s/iHkOLprQgQ0IU975OT/nKN924x3+aLR4OGfVep7KBqeS90pUlS8rFNkO1I7fIUTBh0boqM7Gh6cVY5GXAcAuCzD8zRDRRmK2GzNxaHHfm4Q9O191LRsLGWkRq6lK9PVFGKwSdAuTtKOWy1+YXvUis8t8JtTXqlerS3z1AVjQM2XUlZywDmNVXqVcQIgUStlbXZvhybdpGqw6kC/SClSX7Py6PdOXAd+0FP+69/9I0MMj1+ibGESDKp0m6T76w2DaCHlmEU7xGTNJ3NkrR3ycP3Ol1FdEZl5mNs6a1wfkv2fC9BidHPHu6MeosLZCKD+95qRFADgcK3b06M5Aarp+/6PRwkH6EYQQrLcAVAe2l8BdM8AmHN4iDB4uXDJ3KI2YsZKyV4iCwLJ686scEr1t4W7cTU5CcrjZafQxY7qmIPLh02qw==;5:QIl/jCczQGkKwe/ExEFw5wrAjsN+WQ4ovTP2kLumvTX8t/T65IhcZcH2XXCY/u0vOZgEjVAcDmeizfmhRtNNiqgFWgSZW8xkmfoyf5cykg1LYdzeXkIP/tFzqtXZIZ2kmSEzv/i4GtN0CjV1FOKY7VdJ26EymN7DRuYnpub+Oks=;7:fR5z/Q5ggiCkHmHQSrKtPr9E34yzlVua4W/rpWItirlbbeR0w3JxJCWiHuniyqzJTIDOe+f1tf6WCNnRMPo7bSE7bMZemy+ulniqx6nXIL8kFHlF+itHiqjqdPgV311SjAmsNmopUuM/I0K9ksnUxHjyFE+hRQQAv/0cnv6iaMJikJoHQQKzDj/bGiV9f2u880sA2f1S7HDJbz1HavFfagLfMN6BRIE750AB96rYH6Idr/SYFX5Skk6Ey3NrbUge
x-ms-office365-filtering-correlation-id: 9e98bc8f-8316-45c2-587b-08d6145a04ab
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB046943C840BF92D96166AC81FB000@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(25786009)(446003)(316002)(86612001)(54906003)(76176011)(86362001)(110136005)(256004)(6486002)(10090500001)(14444005)(26005)(2900100001)(476003)(2616005)(6306002)(102836004)(5250100002)(22452003)(186003)(6506007)(11346002)(53936002)(217873002)(66066001)(4326008)(575784001)(486006)(6512007)(107886003)(2906002)(8676002)(105586002)(72206003)(99286004)(966005)(1076002)(6666003)(68736007)(2501003)(7736002)(10290500003)(106356001)(305945005)(14454004)(6116002)(3846002)(5660300001)(36756003)(478600001)(81166006)(6436002)(97736004)(81156014)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vFocxqlZcZ8YbZ1QZ6ErbMP/QrLppjhsnxjseTaR5k5KT3sTyktckxXM4emWxlzP7owlLitsolIoOg6YmDdOTOKSrCZnmNQvSM+sxJdFJ2OOE+BGiD9XVx6nU64ZreylbBvbpZjAOMQiAvYGPSxc4egyCCwF74jsQgX6wQ5fRKyk5K3j7XA0gR+o7JI4qfzcSc4kynavS/H3JjyBBqRNu0KV8ssBy0ide2EWRpI9cEskGbfPMRQtbzvumKxEsLlI5jw7Un157amKfb18i4yzTyiLg4n0heaj2nBjd4zE5IrNZIZZLmeWFOF2yJIMmUbqEgpXiEKcqr8tmnrKCA4Pj4z5gdroHmAW+dlYG2jSu4U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e98bc8f-8316-45c2-587b-08d6145a04ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:33.1946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandipan Das <sandipan@linux.ibm.com>

[ Upstream commit 2a9d5050dc84fa2060f08a52f632976923e0fa7e ]

When perf/data is recorded with the dwarf call-graph option, the
callchain shown by 'perf script' still shows the binary offsets of the
userspace symbols instead of their virtual addresses. Since the symbol
offset calculation is based on using virtual address as the ip, we see
incorrect offsets as well.

The use of virtual addresses affects the ability to find out the
line number in the corresponding source file to which an address
maps to as described in commit 67540759151a ("perf unwind: Use
addr_location::addr instead of ip for entries").

This has also been addressed by temporarily converting the virtual
address to the correponding binary offset so that it can be mapped
to the source line number correctly.

This is a follow-up for commit 19610184693c ("perf script: Show
virtual addresses instead of offsets").

This can be verified on a powerpc64le system running Fedora 27 as
shown below:

  # perf probe -x /usr/lib64/libc-2.26.so -a inet_pton
  # perf record -e probe_libc:inet_pton --call-graph=3Ddwarf ping -6 -c 1 :=
:1

Before:

  # perf report --stdio --no-children -s sym,srcline -g address

  # Samples: 1  of event 'probe_libc:inet_pton'
  # Event count (approx.): 1
  #
  # Overhead  Symbol                Source:Line
  # ........  ....................  ...........
  #
     100.00%  [.] __GI___inet_pton  inet_pton.c
              |
              ---gaih_inet getaddrinfo.c:537 (inlined)
                 __GI_getaddrinfo getaddrinfo.c:2304 (inlined)
                 main ping.c:519
                 generic_start_main libc-start.c:308 (inlined)
                 __libc_start_main libc-start.c:102
  ...

  # perf script -F comm,ip,sym,symoff,srcline,dso

  ping
                    15af28 __GI___inet_pton+0xffff000099160008 (/usr/lib64/=
libc-2.26.so)
    libc-2.26.so[ffff80004ca0af28]
                    10fa53 gaih_inet+0xffff000099160f43
    libc-2.26.so[ffff80004c9bfa53] (inlined)
                    1105b3 __GI_getaddrinfo+0xffff000099160163
    libc-2.26.so[ffff80004c9c05b3] (inlined)
                      2d6f main+0xfffffffd9f1003df (/usr/bin/ping)
    ping[fffffffecf882d6f]
                     2369f generic_start_main+0xffff00009916013f
    libc-2.26.so[ffff80004c8d369f] (inlined)
                     23897 __libc_start_main+0xffff0000991600b7 (/usr/lib64=
/libc-2.26.so)
    libc-2.26.so[ffff80004c8d3897]

After:

  # perf report --stdio --no-children -s sym,srcline -g address

  # Samples: 1  of event 'probe_libc:inet_pton'
  # Event count (approx.): 1
  #
  # Overhead  Symbol                Source:Line
  # ........  ....................  ...........
  #
     100.00%  [.] __GI___inet_pton  inet_pton.c
              |
              ---gaih_inet.constprop.7 getaddrinfo.c:537
                 getaddrinfo getaddrinfo.c:2304
                 main ping.c:519
                 generic_start_main.isra.0 libc-start.c:308
                 __libc_start_main libc-start.c:102
  ...

  # perf script -F comm,ip,sym,symoff,srcline,dso

  ping
              7fffb38aaf28 __GI___inet_pton+0x8 (/usr/lib64/libc-2.26.so)
    inet_pton.c:68
              7fffb385fa53 gaih_inet.constprop.7+0xf43 (/usr/lib64/libc-2.2=
6.so)
    getaddrinfo.c:537
              7fffb38605b3 getaddrinfo+0x163 (/usr/lib64/libc-2.26.so)
    getaddrinfo.c:2304
                 130782d6f main+0x3df (/usr/bin/ping)
    ping.c:519
              7fffb377369f generic_start_main.isra.0+0x13f (/usr/lib64/libc=
-2.26.so)
    libc-start.c:308
              7fffb3773897 __libc_start_main+0xb7 (/usr/lib64/libc-2.26.so)
    libc-start.c:102

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Fixes: 67540759151a ("perf unwind: Use addr_location::addr instead of ip fo=
r entries")
Link: http://lkml.kernel.org/r/20180703120555.32971-1-sandipan@linux.ibm.co=
m
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/util/machine.c                | 9 ++++++++-
 tools/perf/util/unwind-libdw.c           | 2 +-
 tools/perf/util/unwind-libunwind-local.c | 2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index e7b4a8b513f2..22dbb6612b41 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2272,6 +2272,7 @@ static int unwind_entry(struct unwind_entry *entry, v=
oid *arg)
 {
 	struct callchain_cursor *cursor =3D arg;
 	const char *srcline =3D NULL;
+	u64 addr;
=20
 	if (symbol_conf.hide_unresolved && entry->sym =3D=3D NULL)
 		return 0;
@@ -2279,7 +2280,13 @@ static int unwind_entry(struct unwind_entry *entry, =
void *arg)
 	if (append_inlines(cursor, entry->map, entry->sym, entry->ip) =3D=3D 0)
 		return 0;
=20
-	srcline =3D callchain_srcline(entry->map, entry->sym, entry->ip);
+	/*
+	 * Convert entry->ip from a virtual address to an offset in
+	 * its corresponding binary.
+	 */
+	addr =3D map__map_ip(entry->map, entry->ip);
+
+	srcline =3D callchain_srcline(entry->map, entry->sym, addr);
 	return callchain_cursor_append(cursor, entry->ip,
 				       entry->map, entry->sym,
 				       false, NULL, 0, 0, 0, srcline);
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.=
c
index 538db4e5d1e6..6f318b15950e 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -77,7 +77,7 @@ static int entry(u64 ip, struct unwind_info *ui)
 	if (__report_module(&al, ip, ui))
 		return -1;
=20
-	e->ip  =3D al.addr;
+	e->ip  =3D ip;
 	e->map =3D al.map;
 	e->sym =3D al.sym;
=20
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unw=
ind-libunwind-local.c
index 6a11bc7e6b27..79f521a552cf 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -575,7 +575,7 @@ static int entry(u64 ip, struct thread *thread,
 	struct addr_location al;
=20
 	e.sym =3D thread__find_symbol(thread, PERF_RECORD_MISC_USER, ip, &al);
-	e.ip =3D al.addr;
+	e.ip  =3D ip;
 	e.map =3D al.map;
=20
 	pr_debug("unwind: %s:ip =3D 0x%" PRIx64 " (0x%" PRIx64 ")\n",
--=20
2.17.1

Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF186C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757582083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iGIHAHT1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 757582083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbeIGFPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:15:12 -0400
Received: from mail-eopbgr690126.outbound.protection.outlook.com ([40.107.69.126]:51988
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729190AbeIGFPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oATNAD5vLy9Nvoq//2WkfS8Kz0xutPMbCQdFjYkpMN0=;
 b=iGIHAHT1kh5vz42RMQ7X3jFNMGBLi9UXmvyIEMIS1kpPchm/yBEPKHacu1Q/eKOGoMesZ4j+ecvjcmndeN1R1jv/CKT39sETLcK+b1sSjqVbmip3oF7a0qijAcszhJQ2Iv7q99zufWVULcUrDZ8b1Avh26ZF3dHnwFZEO2Sgins=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:36:50 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:51 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Lukasz Odzioba <lukasz.odzioba@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wang Nan <wangnan0@huawei.com>,
        "kernel-team@lge.com" <kernel-team@lge.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 43/88] perf tools: Fix struct comm_str removal
 crash
Thread-Topic: [PATCH AUTOSEL 4.18 43/88] perf tools: Fix struct comm_str
 removal crash
Thread-Index: AQHURkLOytTaOnpK7EeyzocQp2d4RQ==
Date:   Fri, 7 Sep 2018 00:36:24 +0000
Message-ID: <20180907003547.57567-43-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:kO1zm7CJrM2Uzd2YDCORyyDHPuW11DsUmCs+STl+tfSCU2ziYt7f6Kc3qxsWwOV1ulenhfUHFlJhCEjk95xd2D8Ap6i1Ir6mCX9lhK9tXkgdbhpjprC1QLGezkuJSXrb7jXL57sTD3Zk9ukaM7gIykRWCDlGAW/aGD88miuBLGvhShaJNkZfIIr4PaXa+0ywCieSG7jzxbXnf/peaLkzpCk73mS1apkxLc5CFaxop/HHPGTHhNyHmCbTwsDRy60LmcegqxVofpA9wwAnu1dWYkW5jmqLtA1FZm6KiM+qcR3RJq1XDdoOOneURNRGrJ9niQI95s9AxcJzpMZRQCuBkHJvmka46WHKC6q2SxvAmd0AqBraMs7gI72GPAK60U6jOj/37dGkkswuWdx8vU4qx+0kz5Nuq9eTS8xDQ54n4LPnj8Gt4qURVjeWrFx0WbNPeIT81XtemkK0nJ6ee7kJNA==;5:mEAY24FJket/OdlgQfS7Q8UxhLQQsSZk+xXEjjAFv0lpzfEQzAmdBuM+b0GAzvFwvm7+YUg3EeV7/EaR2bI06Llyao/QKmmZ/yDnhMXwkp7lOfVHCpjOZisHpU0KCRo3NYesWV51z8BSMSCXeOc6kdsY3cNXKSvmlKXf0S+ZnHc=;7:049bOufmxM4Gzn++ApmRPFL84RKvwpAeteSfCBARl0dLdwXEMk5Qb5gENQBAcW+Mfch5qT62x/7nNZVy/7cmMggglgXpnULJR3lk/2FtMcgta0pzjw5LYv9qqYtdDUomps+jt/XcZIkPd+9osYGvpgHwK2jprO8i5Ket+wO5dw4KAgz6+3gWsRVwoaRuDOo7tvzc9BiOqmTU/kY8GMPsG0VNIN/NVBZRh40F6Nh+26juUimcN8I/P1SMSlXa5TTx
x-ms-office365-filtering-correlation-id: c9b5076e-d786-4934-363d-08d6145a00a7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07730C5B2AB2DD7E3E512D47FB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(85827821059158)(42068640409301)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(6306002)(2616005)(476003)(4326008)(6666003)(11346002)(5250100002)(107886003)(2501003)(39060400002)(86612001)(97736004)(6512007)(966005)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(7416002)(14454004)(1076002)(66066001)(26005)(575784001)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(14444005)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: g/AehL4tiwuXjPbdLAmyz2DVbNQ/GFi++jWFeEsiFqlA3u/VC3PbWnVvwOSsP0hAqLPcrnaxjaEtqg4BlzdBEufR6VHKIYscBoEB/NQl2zjiOErIBz60MMNrda8EEsHf68gTq3FLRHsZjYYnfOYmiW4MgOHgIV2jOh0Ox/vz2KTuq6MoLT/YaopWGAf7XWpMlw2B+sKqZxXAvvXBX21kV5bkzsTF515ICJhmpuavaE8b3Btf1x+xzuG9V2pc7CKQMoj7ySOwdr8TU/GtOk8lEZ2yjCGUgjeOe1+68EEfeS0GbBigPB4RP8/35gGogiA/ZDTo7hpWmhdL4aq63JsTn4arG45L9SAhsHFRqq7O2Fo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b5076e-d786-4934-363d-08d6145a00a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:24.7246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

[ Upstream commit 46b3722cc7765582354488da633aafffcb138458 ]

We occasionaly hit following assert failure in 'perf top', when processing =
the
/proc info in multiple threads.

  perf: ...include/linux/refcount.h:109: refcount_inc:
        Assertion `!(!refcount_inc_not_zero(r))' failed.

The gdb backtrace looks like this:

  [Switching to Thread 0x7ffff11ba700 (LWP 13749)]
  0x00007ffff50839fb in raise () from /lib64/libc.so.6
  (gdb)
  #0  0x00007ffff50839fb in raise () from /lib64/libc.so.6
  #1  0x00007ffff5085800 in abort () from /lib64/libc.so.6
  #2  0x00007ffff507c0da in __assert_fail_base () from /lib64/libc.so.6
  #3  0x00007ffff507c152 in __assert_fail () from /lib64/libc.so.6
  #4  0x0000000000535373 in refcount_inc (r=3D0x7fffdc009be0)
      at ...include/linux/refcount.h:109
  #5  0x00000000005354f1 in comm_str__get (cs=3D0x7fffdc009bc0)
      at util/comm.c:24
  #6  0x00000000005356bd in __comm_str__findnew (str=3D0x7fffd000b260 ":2",
      root=3D0xbed5c0 <comm_str_root>) at util/comm.c:72
  #7  0x000000000053579e in comm_str__findnew (str=3D0x7fffd000b260 ":2",
      root=3D0xbed5c0 <comm_str_root>) at util/comm.c:95
  #8  0x000000000053582e in comm__new (str=3D0x7fffd000b260 ":2",
      timestamp=3D0, exec=3Dfalse) at util/comm.c:111
  #9  0x00000000005363bc in thread__new (pid=3D2, tid=3D2) at util/thread.c=
:57
  #10 0x0000000000523da0 in ____machine__findnew_thread (machine=3D0xbfde38=
,
      threads=3D0xbfdf28, pid=3D2, tid=3D2, create=3Dtrue) at util/machine.=
c:457
  #11 0x0000000000523eb4 in __machine__findnew_thread (machine=3D0xbfde38,
  ...

The failing assertion is this one:

  REFCOUNT_WARN(!refcount_inc_not_zero(r), ...

The problem is that we keep global comm_str_root list, which
is accessed by multiple threads during the 'perf top' startup
and following 2 paths can race:

  thread 1:
    ...
    thread__new
      comm__new
        comm_str__findnew
          down_write(&comm_str_lock);
          __comm_str__findnew
            comm_str__get

  thread 2:
    ...
    comm__override or comm__free
      comm_str__put
        refcount_dec_and_test
          down_write(&comm_str_lock);
          rb_erase(&cs->rb_node, &comm_str_root);

Because thread 2 first decrements the refcnt and only after then it removes=
 the
struct comm_str from the list, the thread 1 can find this object on the lis=
t
with refcnt equls to 0 and hit the assert.

This patch fixes the thread 1 __comm_str__findnew path, by ignoring objects
that already dropped the refcnt to 0. For the rest of the objects we take t=
he
refcnt before comparing its name and release it afterwards with comm_str__p=
ut,
which can also release the object completely.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Lukasz Odzioba <lukasz.odzioba@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: kernel-team@lge.com
Link: http://lkml.kernel.org/r/20180720101740.GA27176@krava
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/util/comm.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
index 7798a2cc8a86..31279a7bd919 100644
--- a/tools/perf/util/comm.c
+++ b/tools/perf/util/comm.c
@@ -20,9 +20,10 @@ static struct rw_semaphore comm_str_lock =3D {.lock =3D =
PTHREAD_RWLOCK_INITIALIZER,}
=20
 static struct comm_str *comm_str__get(struct comm_str *cs)
 {
-	if (cs)
-		refcount_inc(&cs->refcnt);
-	return cs;
+	if (cs && refcount_inc_not_zero(&cs->refcnt))
+		return cs;
+
+	return NULL;
 }
=20
 static void comm_str__put(struct comm_str *cs)
@@ -67,9 +68,14 @@ struct comm_str *__comm_str__findnew(const char *str, st=
ruct rb_root *root)
 		parent =3D *p;
 		iter =3D rb_entry(parent, struct comm_str, rb_node);
=20
+		/*
+		 * If we race with comm_str__put, iter->refcnt is 0
+		 * and it will be removed within comm_str__put call
+		 * shortly, ignore it in this search.
+		 */
 		cmp =3D strcmp(str, iter->str);
-		if (!cmp)
-			return comm_str__get(iter);
+		if (!cmp && comm_str__get(iter))
+			return iter;
=20
 		if (cmp < 0)
 			p =3D &(*p)->rb_left;
--=20
2.17.1

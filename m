Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E49C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9701620857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LyzlAX83"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9701620857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbeIGFRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:17:07 -0400
Received: from mail-sn1nam02on0101.outbound.protection.outlook.com ([104.47.36.101]:49984
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728117AbeIGFRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=733VpI2F/aE8GyWEYdlEDabdEG9QlA0eMF+vr3qwOHc=;
 b=LyzlAX83HwNJWP6SBHdwUeG937GIIfdFdkz7aOigPlUcw/YS+skgiH3rxNxqFzs1sUa5a2ipzbYXTsTbx6BWK3KdQc3aVSJBT5ZQr6RRn21Bw2RHPbgkEP8JTiM+6QGn7Rrlv+TU0uy+kAhcWVUAv180zjRJmo54D9oRasig0hc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0840.namprd21.prod.outlook.com (10.173.192.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:38:25 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:25 +0000
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
Subject: [PATCH AUTOSEL 4.14 32/67] perf tools: Fix struct comm_str removal
 crash
Thread-Topic: [PATCH AUTOSEL 4.14 32/67] perf tools: Fix struct comm_str
 removal crash
Thread-Index: AQHURkL9J5YK56pR30S5qjr9mDdtsQ==
Date:   Fri, 7 Sep 2018 00:37:44 +0000
Message-ID: <20180907003716.57737-32-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0840;6:gQCnfJQOdzImhpdFlKjMfBzkA2NaTze7mYi5PVxrxR1yKuG6hEV2PfjpqG/fsInAq8AQMyH5ibNx3wwkmaXNzcGUSTGK50b5epjSvmNIWsANJrFZyjh9ziP6htGRlHQT8wQfTp6syeIUnplCAYmZFe+MTt1MfXzgtS1saN3r1qAbdDB0uGTTSRed1NBIV7dD988S9tehDqDQiEY0ddQljcXZZjPAD9mIexY7RhLoitEgOFyLUVnxya6fMfWDd2Sa/hNM0pt543ldU7EItE7t42RTGqMc2JyOO9xUbUJCckzj0edzcasnvciQRGoyZF2S3lQE4MvMN7tKOXFAoQAOs2bSUDrfXfWm0OYawfMQ+Fx4UHj5AfguQ1ikz9C9/GaKebKy1qTEAd7o4nv8mMgvPdkx4mSywQEruVmM0QXTJINT+SFkgQOZmaaY7fZDE6OG2Y9q+bfRb6NkEXB4k+VcpA==;5:EwONj7hSepI+sav1UTHcLtnGTphMQCsOA/llvnoHOZ8O3ZeMjVw11MSauI0amt4T4SCurayc+e5Ah1xQWaGv2edXJsEvxk56JvSvJ3nNTbW7+kbPbAEd9EDMLOxJHBR3yBJwL6pnvMqmJIY1D/sD68oy3BsemLsNU8vGvPMw/lg=;7:4/LoPf+9OteTUHZV9wyhe4RVKI68cqUwuebXj/2miz4epvM/tZjXfXRZsMRzhXLDykSFmgYH+jv4TJk1ZEUIPAmKOmPHMBX5KEGz17r1KfG746vYXTeTNMLGfkOH9NvTMkijdZBgpUbtTBIe9nvsV4PnoXerDqxni0OaEf5RmCpjKcCmu40TKN/oJFGfgwLK3CeEouC3VWnEiu8WUC8Gn3/p2ptQBp9HVfbxIyj5Do3dEDXNCWF8n73z3P96Eeuw
x-ms-office365-filtering-correlation-id: 70eddebe-205b-426f-7e50-08d6145a3902
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0840;
x-ms-traffictypediagnostic: CY4PR21MB0840:
x-microsoft-antispam-prvs: <CY4PR21MB0840C3BD306B9FA08E98470BFB000@CY4PR21MB0840.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(85827821059158)(42068640409301)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0840;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0840;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(39860400002)(396003)(136003)(189003)(199004)(66066001)(186003)(99286004)(26005)(8936002)(76176011)(102836004)(81166006)(81156014)(5250100002)(54906003)(6506007)(110136005)(11346002)(446003)(316002)(476003)(2616005)(106356001)(6486002)(86362001)(575784001)(6436002)(105586002)(86612001)(97736004)(486006)(6346003)(53936002)(6512007)(6306002)(68736007)(10090500001)(2501003)(1076002)(22452003)(6116002)(3846002)(36756003)(4326008)(8676002)(10290500003)(2900100001)(25786009)(39060400002)(256004)(14444005)(305945005)(7416002)(72206003)(7736002)(478600001)(14454004)(217873002)(6666003)(5660300001)(966005)(107886003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0840;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Rt4vuPZwLUu0oSlTlC4DJ9B4l6h6uuaXHx3Z/ZvyHMx7TolwcykoyctcfqieTM20crFhWU3G3RpLhmtilccnS+45bMUrBARwsxgihsmdOLX7wOgKC/nvsU2tSUDjrFVVDjruBjffiQnOR7VNSjgeWW+BkggWdGJ0kNZ4RNpkT7ASY0J+dojbicA/oEOQz3cpUL3kgM2ms1ySpG2WUhO8qBOfkex6TDmYIsKCSXPHE2N8GQ1H9ALoki+iHpye3WfUlmCo+TSwSeVlMbwccmjey3Z+D653Gf4kLF4HPlBGnHSC7t+uaczGnsTeGhLjcmwLBrPIpYB19sFUZPf7BpQ7yNqrmFjAU00Lrhl8RWr/AOo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70eddebe-205b-426f-7e50-08d6145a3902
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:44.2245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0840
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
index 8808570f8e9c..327e01cb1aa2 100644
--- a/tools/perf/util/comm.c
+++ b/tools/perf/util/comm.c
@@ -18,9 +18,10 @@ static struct rb_root comm_str_root;
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
@@ -62,9 +63,14 @@ static struct comm_str *comm_str__findnew(const char *st=
r, struct rb_root *root)
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

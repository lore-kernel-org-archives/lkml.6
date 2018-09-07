Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D99C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709F72083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="W/oiRtn+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709F72083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbeIGFgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:36:22 -0400
Received: from mail-eopbgr690126.outbound.protection.outlook.com ([40.107.69.126]:51988
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726695AbeIGFPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fc5lYW519/9VCzEPyteoNxpHnnsCAG1TaQCXiSpuKY0=;
 b=W/oiRtn+TjsRndBa7s8i6p5k7fCnfm+j3iRm8bvAC2LWlpTnC4rnAPHoAFIhrLe2OFOP4/067j3lOvOOTpbNTk1NPfDvbeYqLQ3Q+b8TzwPRpYoLL2Z1MP5Pq+c5RSKlSDwsdQH2djmPCsCEv+WYthFcb9Bc0VxQhlfuW/xq+JM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:36:52 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:52 +0000
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
Subject: [PATCH AUTOSEL 4.18 46/88] perf powerpc: Fix callchain ip filtering
 when return address is in a register
Thread-Topic: [PATCH AUTOSEL 4.18 46/88] perf powerpc: Fix callchain ip
 filtering when return address is in a register
Thread-Index: AQHURkLPrFKVsFVXZkmIh9rRJlIqIw==
Date:   Fri, 7 Sep 2018 00:36:26 +0000
Message-ID: <20180907003547.57567-46-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:gpQ0nWZofEkxQw+0MRQtCZwUfoCWq6TZ6EwpdLOfgZD512farMqX+w6MMGW4EmZtxUu51dscihdxbPP+tm+ef2IijUJn8/GsOA2sWHh/NeQ+4v7aoBTG/Fsc4EpHeiLypaTmE49LOgAQZBCUDoMhPya+lCzc/AeALAexqftrqKlol500PkHsmHVFxWzzvSrgIm0MWJeCjRdsrK9Jf3nfwe1Oz2TMLi/bafK8ehA4mFJMQ6YKlaxu79Ze89qm5zvBvHI7sGuKHujo5qvyScGN2/A1FEXQJXCz3wjC8eXECV1l24OuDKWEo/33Ai4n8RjlAASfKDDZELj8dPmaYRONJYj8+L2vsIOjSmBWI5N55S5HFFggMwWaAcewd5Bjf6rA/fdYx/4s5V1jvovFllPHB7P3/C9EUg39w6o+l9x8tV0MCqQB3APZN+aSr9ejpCpwnPmAC+DJSZxWZqLq5OxsmA==;5:4FMykImjif7QZtYnINRxA5fwxE0cRpTxkf6xIjdC2zGzZTon5cH3qXTzgkVJdlch8MXOv2Qg8n7zieS/Y1ExGpGeuWqqkfAkZNmJTJncRb+N+108brKdIiMEP3M1SNrsGdJums3jdukX64VAncPVFR3gwGqnxTTA7HPe4SQnGtc=;7:CuYao1/Ak1zLCY7eTHwLeMT9evROAB8B0QYqPHEJjbua6hJQoehRnWEb5O3QjriWx5IfUbZJmO2waqTC27aGxECuFmwGVZn7Z5jcPKXQR++Uq9WXsE+xiEyv1LwWMYJWhu7e95O8MKo7qNYDtT9gbiaX9044VrKmtniysj+5FX+hLhjr244tbtrpNbtHXvre3ulj2f6aGu9a0OUDkPzDzfSiSPvD2AzMlb21hDnVE1qjFevje6EdOP57dst6UISn
x-ms-office365-filtering-correlation-id: 242fc111-ecfd-48ec-23e7-08d6145a0176
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB077307547BB90CEBF65D643DFB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(274839183919467)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(6306002)(2616005)(476003)(4326008)(6666003)(11346002)(5250100002)(107886003)(2501003)(86612001)(97736004)(6512007)(966005)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(14454004)(1076002)(66066001)(26005)(575784001)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mn3ks8I4Z4Wdi8XM3NiNYDocwlM/ikW9GfBAY482t9GFC2U/JxeSlncFhUi24SmLddLe//7U+F8TpgJGZxf179bLFIugKJchbv9VZ1KK4P9sKad+eSbOd6N5zRP67S97HAw1WG+i3qoHdMZQ5J7tQ8SvhN3GVK8h8l6Z1s4PwepGX4r8h+QvHm9/O1vtYWyrnGMPXdYlEUCNgCJx5NLRyU82LkeLKfD1OePmtmFfjDWvMJNgc+0hNT5NnC9tU2RL2xPfCYUrm5z8vox8+Qat/WXCWidoBbkv+++G7jpfZsirRZp1Y3Q/WZbB19p7Bww441KQXBWnz+5s2DDDfyzbHTzSv56KhUI8nVPxMwFbsfU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 242fc111-ecfd-48ec-23e7-08d6145a0176
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:26.7132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandipan Das <sandipan@linux.ibm.com>

[ Upstream commit 9068533e4f470daf2b0f29c71d865990acd8826e ]

For powerpc64, perf will filter out the second entry in the callchain,
i.e. the LR value, if the return address of the function corresponding
to the probed location has already been saved on its caller's stack.

The state of the return address is determined using debug information.
At any point within a function, if the return address is already saved
somewhere, a DWARF expression can tell us about its location. If the
return address in still in LR only, no DWARF expression would exist.

Typically, the instructions in a function's prologue first copy the LR
value to R0 and then pushes R0 on to the stack. If LR has already been
copied to R0 but R0 is yet to be pushed to the stack, we can still get a
DWARF expression that says that the return address is in R0. This is
indicating that getting a DWARF expression for the return address does
not guarantee the fact that it has already been saved on the stack.

This can be observed on a powerpc64le system running Fedora 27 as shown
below.

  # objdump -d /usr/lib64/libc-2.26.so | less
  ...
  000000000015af20 <inet_pton>:
    15af20:       0b 00 4c 3c     addis   r2,r12,11
    15af24:       e0 c1 42 38     addi    r2,r2,-15904
    15af28:       a6 02 08 7c     mflr    r0
    15af2c:       f0 ff c1 fb     std     r30,-16(r1)
    15af30:       f8 ff e1 fb     std     r31,-8(r1)
    15af34:       78 1b 7f 7c     mr      r31,r3
    15af38:       78 23 83 7c     mr      r3,r4
    15af3c:       78 2b be 7c     mr      r30,r5
    15af40:       10 00 01 f8     std     r0,16(r1)
    15af44:       c1 ff 21 f8     stdu    r1,-64(r1)
    15af48:       28 00 81 f8     std     r4,40(r1)
  ...

  # readelf --debug-dump=3Dframes-interp /usr/lib64/libc-2.26.so | less
  ...
  00027024 0000000000000024 00027028 FDE cie=3D00000000 pc=3D000000000015af=
20..000000000015af88
     LOC           CFA      r30   r31   ra
  000000000015af20 r1+0     u     u     u
  000000000015af34 r1+0     c-16  c-8   r0
  000000000015af48 r1+64    c-16  c-8   c+16
  000000000015af5c r1+0     c-16  c-8   c+16
  000000000015af78 r1+0     u     u
  ...

  # perf probe -x /usr/lib64/libc-2.26.so -a inet_pton+0x18
  # perf record -e probe_libc:inet_pton -g ping -6 -c 1 ::1
  # perf script

Before:

  ping  2829 [005] 512917.460174: probe_libc:inet_pton: (7fff7e2baf38)
              7fff7e2baf38 __GI___inet_pton+0x18 (/usr/lib64/libc-2.26.so)
              7fff7e2705b4 getaddrinfo+0x164 (/usr/lib64/libc-2.26.so)
                 12f152d70 _init+0xbfc (/usr/bin/ping)
              7fff7e1836a0 generic_start_main.isra.0+0x140 (/usr/lib64/libc=
-2.26.so)
              7fff7e183898 __libc_start_main+0xb8 (/usr/lib64/libc-2.26.so)
                         0 [unknown] ([unknown])

After:

  ping  2829 [005] 512917.460174: probe_libc:inet_pton: (7fff7e2baf38)
              7fff7e2baf38 __GI___inet_pton+0x18 (/usr/lib64/libc-2.26.so)
              7fff7e26fa54 gaih_inet.constprop.7+0xf44 (/usr/lib64/libc-2.2=
6.so)
              7fff7e2705b4 getaddrinfo+0x164 (/usr/lib64/libc-2.26.so)
                 12f152d70 _init+0xbfc (/usr/bin/ping)
              7fff7e1836a0 generic_start_main.isra.0+0x140 (/usr/lib64/libc=
-2.26.so)
              7fff7e183898 __libc_start_main+0xb8 (/usr/lib64/libc-2.26.so)
                         0 [unknown] ([unknown])

Reported-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Maynard Johnson <maynard@us.ibm.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/66e848a7bdf2d43b39210a705ff6d828a0865661.153=
0724939.git.sandipan@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/arch/powerpc/util/skip-callchain-idx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/perf=
/arch/powerpc/util/skip-callchain-idx.c
index ef5d59a5742e..699b73be7d91 100644
--- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
+++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
@@ -58,9 +58,13 @@ static int check_return_reg(int ra_regno, Dwarf_Frame *f=
rame)
 	}
=20
 	/*
-	 * Check if return address is on the stack.
+	 * Check if return address is on the stack. If return address
+	 * is in a register (typically R0), it is yet to be saved on
+	 * the stack.
 	 */
-	if (nops !=3D 0 || ops !=3D NULL)
+	if ((nops !=3D 0 || ops !=3D NULL) &&
+		!(nops =3D=3D 1 && ops[0].atom =3D=3D DW_OP_regx &&
+			ops[0].number2 =3D=3D 0 && ops[0].offset =3D=3D 0))
 		return 0;
=20
 	/*
--=20
2.17.1

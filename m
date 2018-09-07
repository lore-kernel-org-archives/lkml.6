Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B38C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A822086C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="m8UFinEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A822086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbeIGFRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:17:12 -0400
Received: from mail-bn3nam01on0105.outbound.protection.outlook.com ([104.47.33.105]:63798
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728945AbeIGFRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O38crd5w19SOR7QIkujoGUMyyl0g9KsjeShqQHLaV6M=;
 b=m8UFinEcgKB8H+cxWao767aP6gOQ+l4uRjmONZGxunYfEfu7gJK5Hy3+RL0F7iamPHLeoeOEZDEiMucDyOVJL1gfL+DS4Pq8/46O57glH+inwtE4jHJtgKzWxO7dE1PqGDIb/IUmiAa9uDD/qfIPan6DyQmXfG8hr3kolFzrEts=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0696.namprd21.prod.outlook.com (10.175.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:38:56 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:56 +0000
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
Subject: [PATCH AUTOSEL 4.14 35/67] perf powerpc: Fix callchain ip filtering
 when return address is in a register
Thread-Topic: [PATCH AUTOSEL 4.14 35/67] perf powerpc: Fix callchain ip
 filtering when return address is in a register
Thread-Index: AQHURkL/76OTF4PzlEu40wt/ICspGw==
Date:   Fri, 7 Sep 2018 00:37:47 +0000
Message-ID: <20180907003716.57737-35-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0696;6:MExAdsm2cxjF5qbyrSMe2VSJ3Nw8aUw7KpTi/R0dyWitZJ/TgrzNghvED3p6/umXYMrzs2tK2WGpuvJKXRzNw3NNnlO+r02Crk54qzAXRrpU70/qjXLX9gfaq9yY++d6/Qow6pa5SZNOZF4hhhIRNpjV6JwiexNByFm6WsBBdbhi8tZO1j7SsLENoIfm+O7quS4Vt0Ja/LFyc7P/lovWFr7WrMhzLbm+a796W2hP2rk/oiCVZ+ZWPWJ3Qo6LpQ1ov4M/633GkLbJhFMyKBVN3R2T9+B/LGY1HzL5WMk1x8Q+GjPQYg+vwNmDu6Zu7nfF5ZfEpAMKcJoGY035r21h1mK2M9RLikX8BzcjT1BNt1jatZir9hAaaWqt6eo4auAzfDw7zBF4SRFSjx2vSelMWcXFxvsm05quM58PgY9xCOFQiabx/PRqM7jLrXmHr96vgSKrSWvTvPUWbIZiSDbCoA==;5:sBSWYdHBDqF3iEJz4GZ8auUoK0diD7do9sq/bIb0P73D1OisRuCf6tx8UR7OKLzkbAu7uNZN5+44mOBQ1E4lpdpQx2qRGsy5YdXf0k4/aF9EA4N6sMzPoWzsdEepYA2sOcKHryAAMRgkO1oVhezeJLQiSmjo+1rhFMzcyp4Tbj4=;7:JzaZ+tO9BOxnF/qo5qngb7zCd23/ieJrGAJUim5bIFgzfCtMMZ159l2P4a/RzWoApz/kEhNcXCuaHxEz8enA9ix9/lnooEtSVLEneFtwOYAkjJN+sORYJFzTj4GSTLLzOOOITzvRymp4/LUAM3Ae4qp0cNDUmeGGZuK+kQo3dVUjBGfWZrJarnoszb6Q5oF2MWgvU8xvKsGYt+RvcdAk8Vqk5vHZycLhlirflBVH0kfhjpQyIzKdh9kRFsU3BaQx
x-ms-office365-filtering-correlation-id: df6c26a0-d0dd-4d1d-1531-08d6145a4bac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0696;
x-ms-traffictypediagnostic: CY4PR21MB0696:
x-microsoft-antispam-prvs: <CY4PR21MB069681AACDFE7EF2C9843984FB000@CY4PR21MB0696.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(274839183919467)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0696;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0696;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(366004)(376002)(396003)(189003)(199004)(966005)(107886003)(36756003)(99286004)(97736004)(14454004)(105586002)(256004)(106356001)(10090500001)(2900100001)(575784001)(4326008)(86362001)(72206003)(25786009)(2501003)(5250100002)(6346003)(54906003)(22452003)(26005)(186003)(110136005)(316002)(446003)(2616005)(476003)(76176011)(11346002)(66066001)(8936002)(68736007)(6506007)(102836004)(86612001)(2906002)(6486002)(486006)(53936002)(478600001)(10290500003)(305945005)(6666003)(1076002)(7736002)(5660300001)(6306002)(6116002)(8676002)(217873002)(3846002)(6512007)(6436002)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0696;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 9H8/ogrPM4ysEdEQT7X27SUC2YUZuZt4csG7ynjIx8knHRRPDAHjwQ07Bfnz7e69eR2NkgJZF9BFNl2yrdtlg1fm6MxWbMfLnTAFVdAM34kc7M2rz7h20DP6iuI8krNDrHE/eDH4nam1WHsGaa/RtXaFyHeR6CgDkR13uTt1PNODsG+IQ0tW9+v5hZYOD6EqJ+PsrQPwpzzGOeetM6MDpy2mKhEpZM4zqHFTKJtBQX+wqNZFmnHrOiGjCEPEUfn/UPLvpy4L1VFYFX0/VfwAM6k49HVsTHEIUSFp04xglLrJNV7T+aQippfmfZ9Ah9I11zTA4QJ/KyIDMAbWw+yUWmrd8cRywaLJw+C1rk/JXu8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df6c26a0-d0dd-4d1d-1531-08d6145a4bac
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:47.4850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0696
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
index bd630c222e65..9d1f6e976a5a 100644
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

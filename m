Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315CFC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C860E20857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YHk9CD1X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C860E20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbeIGFUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:20:31 -0400
Received: from mail-sn1nam01on0127.outbound.protection.outlook.com ([104.47.32.127]:28480
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727282AbeIGFUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFgqQOuoVFlxhc84u+0t898kmCixvMN2yN5AMfw+90Y=;
 b=YHk9CD1XezFJ8qEwT19L6wSuplIS8pz3tZCBGdQxw31rB4QEZcN8TsugnbZrwFExpn3W7qYSZQr9x/hOfl2fSCVgjNXnRh8FvOm9O/2JrG+lpNdo40OjmwQPUHzi8FZJxjB5/FQhUu2reyHwPfN21wz+dApjKhJO4cR+HdBw4f8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:42:14 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:42:14 +0000
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
Subject: [PATCH AUTOSEL 3.18 12/19] perf powerpc: Fix callchain ip filtering
 when return address is in a register
Thread-Topic: [PATCH AUTOSEL 3.18 12/19] perf powerpc: Fix callchain ip
 filtering when return address is in a register
Thread-Index: AQHURkM/94eEIL1HgUi41L5aqoriBQ==
Date:   Fri, 7 Sep 2018 00:39:34 +0000
Message-ID: <20180907003923.58019-12-alexander.levin@microsoft.com>
References: <20180907003923.58019-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003923.58019-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:k8y4QmAj6yRk2u8EZ50B/K8wbE8/ytYcNqhjMhnea+kwZNVWyPl5Cptjf/Ahjj/q/GNTNSSX2wLKlPdIFXHrucVMx5jn06xm/IFwIeuXGcr/0Z9HgOGHUOLAKvFxOtnRjG4PMMZb8iiebje/qCpfoV1rETmUmLSV2kTPrjXlPHFmVdOyq4+pf96t5vxNQLCAV7ZeQDcNBatt3+l6FpmcF+mtfV2nuiOEB8Pdj+NbWhItpmwVk4XoRCLoaKwIOddmbjkEM2mmLVneY1eiRNpEmWsU1zEii9MbLukYkS1hzLKF6zI03s/HqmSiglAhn8hanuhyNue9yKeYVQEX32beGP5RwVeRzDUzUk/jSDD1P08WCsUpWv/vYMC36uJMo7LlE5aeB+aFygvDrp6btzgaoHrbOD0qpdvdCIcSqDAXJ8yGYAyxB+5MAi2HNHxnIf0ZCXLRSFfePU9xPeDPM1EA2Q==;5:jC8qCIfVfZ9F6jsZQQGWbjA0qWCzdj+6BQpEr33sR39Wo9gkFPWr30HY4udvwjErs2HzlixQ2JBHEIQAsY9IaSDhES4UiKPIayXXIl7eifB+2LFoD1Msqkmxq2bViPIhLZeO7Hn38KlO9xaDnF22r/A4qesSPxoLVXCN21ZQqqk=;7:HUlOcsgOVX3zTdKgMaTEbPYJXo0G0dR5ELXACD9eINf5OTJ/5527MduaXoqvmgwrC5/1x6LyBCY//rnbbDA69WoM2YIC4BmqRmCHxRtqe1stOg7lDFdq8nMGiLTK3BvDju/jnfE2KZCqNxnFxAL921EiIcJ1wYJ8NnoAQnNbglbzyscSmxQy7B9GIYim3QTvIbVvwDFGLXVjdoe4fGXPtHeHDgW44rgaMTTpjxz5WpOzjDd9VjYW/k3ESJBzBmTf
x-ms-office365-filtering-correlation-id: 75007fd7-ec29-4d13-5408-08d6145ac146
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB046917584DB497C106226880FB000@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(274839183919467)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(25786009)(446003)(316002)(86612001)(54906003)(76176011)(86362001)(110136005)(256004)(6486002)(10090500001)(26005)(2900100001)(476003)(2616005)(6306002)(102836004)(5250100002)(22452003)(186003)(6506007)(11346002)(53936002)(217873002)(66066001)(4326008)(575784001)(486006)(6512007)(107886003)(2906002)(8676002)(105586002)(72206003)(99286004)(966005)(1076002)(6666003)(68736007)(2501003)(7736002)(10290500003)(106356001)(305945005)(14454004)(6116002)(3846002)(5660300001)(36756003)(478600001)(81166006)(6436002)(97736004)(81156014)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SW7W/0TnARC1tROJEUKDWNb8i7FKSNlAFv9y45DSZgcWJgP6FCcX7mPevpE1sBESpLdgZnX7+RdabupSdH0Tjns8olYTaSnCONrRWq+DpS11GKPeKQdJHl1DX5Ar1eAdF9Ajf2aKQ50RbmY+AyrOVsd2B2jgPRTuxneDamfcCD1x+lCswMv0bQf33yMMv+KgnNApnJitTh8+e4LtnPkITT+zolpGjPmPu04s5QrcC+iObuSpeVJtVaURBhYa4C9MMl6FxjFGpoh0a9l8oTTCgX2qS+5z2HmsAOh9mSBUuRO1sLccNuO/xaFEFLg0wwPXh1f8ahx2snb+62KqWsyN147Ke2BfsfH0fQ1V2oEx4wU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75007fd7-ec29-4d13-5408-08d6145ac146
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:34.4452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
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
index 8e24f39f9158..b070893bfcfe 100644
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

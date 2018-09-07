Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1AAC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748582083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FjTlxAWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 748582083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbeIGFWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:22:00 -0400
Received: from mail-by2nam01on0103.outbound.protection.outlook.com ([104.47.34.103]:49312
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728110AbeIGFU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O38crd5w19SOR7QIkujoGUMyyl0g9KsjeShqQHLaV6M=;
 b=FjTlxAWwAJ4FKLkwgFKGDDgrEIBF9MFGch0Ztuki/mVTEZarok9rGp4+0ajAEw2hcQ5m1kOL6MC5bQNt4YsgMRCNKwcsOvYJRknwLx/0rmtXmgltKBfSwsCkPLb85ts7kkcilRyz3/lx71g15kww/k9RhTbS46Y9saVBkprT/sk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:42:02 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:42:02 +0000
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
Subject: [PATCH AUTOSEL 4.4 18/30] perf powerpc: Fix callchain ip filtering
 when return address is in a register
Thread-Topic: [PATCH AUTOSEL 4.4 18/30] perf powerpc: Fix callchain ip
 filtering when return address is in a register
Thread-Index: AQHURkMxMXsIpUJ3QEix+TYMJ5pP0Q==
Date:   Fri, 7 Sep 2018 00:39:10 +0000
Message-ID: <20180907003853.57942-18-alexander.levin@microsoft.com>
References: <20180907003853.57942-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003853.57942-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:dCxtFBtBmEjTStQGYYYnf/THGiTNHzuujXBmnpxYPv/xJACyyplFMyLAMugnZ2EZc3iFctsekms73CZ457NADl8MiAux6gFFHjYNisQRp9rJnk+KPt4+TgtIbpdeySvk4Q8RNpXYWOy0klaAAbZBf/rZpFqZSt9+Eh8ZTdWZlW4BByXfbW88FYq8H+XzpsZKWF6gjnPvXBhSewTrcIbNPWPA8ygdGKM/i/rkh4NRKzEqnAFrrFaxq0pYmcSS5YPzcAIQlBvrY6uuk1nHKn7ZFmnNpeu+E6TczHUEApFs83pI2lmYQ+Tg9W1/f8Mf4V9EF/RqosgSX3zI0C9TWQC4Z7T27LJHE8Id+Z7TgDU0UVVOB3vuPAYAQM8BiOaVbIbG1OE8xkxN0B82SMVCSmxDMUYnaE8lNg9JkapxyNc05jlOghu+LVgHZ7b6JknlI+0L/tqOsNRXJzb5iXfjsuNfFg==;5:3ALXuyvvNf9CU2POm/BuxFRNw+oPNzzTeZBdpeAD2sjcde8zFp9TR/3p1Bv4IaGpZcrmeOh4ubqCkLt3NMJh1aaHajsOx5gsbNKy/MngDMQIAKUjVJFaS4hTszvcL8vOhDbJoqmT71DbmcpLo1vME1LCM8J8cho5c15UKzUJL4k=;7:pfYYeCy5y8bkVlbekshvRTRFm0tKlcOwbTsRVqKJnNL/YU7gOPK++FCSCeO3saqIKNrf0YUwcCOMVEuwNTTmo+DhSpcFcd1OF26vO1yJw8jiA4BSV8dvO3SoBsQnMNskV96cx7H6SJtvkeEmuM/3uyfLiD7IAA8MixaztoX+pkUpbh8ic9SIETRIDwVIGlU93oK3y+h6xclo+6TzUPYgsgBSsLwTGdS1W2mbrL3zDVDUzMNYOw4Qdljj1yP5gZLn
x-ms-office365-filtering-correlation-id: f17c725b-86b7-4069-9e72-08d6145aba5b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0822FFCB398D3C7C2EA13F41FB000@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(274839183919467)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(6506007)(10290500003)(478600001)(102836004)(81166006)(14454004)(22452003)(6486002)(26005)(53936002)(966005)(186003)(6436002)(72206003)(2501003)(5250100002)(110136005)(6666003)(54906003)(3846002)(316002)(6512007)(36756003)(1076002)(97736004)(6306002)(8676002)(81156014)(6116002)(5660300001)(10090500001)(76176011)(2906002)(256004)(8936002)(2900100001)(99286004)(66066001)(305945005)(7736002)(486006)(217873002)(68736007)(4326008)(25786009)(476003)(106356001)(11346002)(107886003)(575784001)(446003)(105586002)(86362001)(86612001)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: AG83XyH+WAAMhfc29ztPqZVUkhw3VTidmpJ3ecv/6QYPuKAVS0iFGuk/QiaZgf3Uss77m+mIVi1rfbT0m23Fhar/FpKk1zbYoADT/VNSGwILN7M2mBete0MpEFyT/ZpfiFMHkyN8Xw0ttcRqn/MzcyPBwsOPQfkkczgEVE04wR9zxQD6PcKK87ZRrJpXJW2Rx87KmV2OPi03USrRTnUvim69YIrAt9EnHBKp2wVXOTwG7MxYtbHyeIqAmtFl9jgyKn2efnJEAL6dp1R5+g2SG1Dnbka40v/uD4rzh4G7BA7PWH18CgRVgDOPdMgMPyKIAwVsUX7bEkyVQRjSyVfS511V17ZkvydUcpV617L9rjI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f17c725b-86b7-4069-9e72-08d6145aba5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:10.5702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
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

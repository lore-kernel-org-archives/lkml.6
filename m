Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807F9C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A58820841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="RMzZIAC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A58820841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbeIBRUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:20:21 -0400
Received: from mail-dm3nam03on0090.outbound.protection.outlook.com ([104.47.41.90]:39552
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727487AbeIBRUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmCW0yLL31abB8buUZt9UqeIYuR9zVRGcBT1JxlaHXQ=;
 b=RMzZIAC+Edg4zkeAKsZ8Es7UA+p/wI3ycOGbbPO8o8FamyBdfGtIdi1L386LkpMLLDUyUM83gr/7/wAqVb30+TYG6Ryc+KUlRFWaxdi65dFhxf7JR6h5SwsSA/A0WX/0yqWVoFocaz6xMAlmr98EfBBTiMwPC4aWJCVOPGlX/Lo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0135.namprd21.prod.outlook.com (10.173.189.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:15 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:15 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Richter <tmricht@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 052/131] perf build: Fix installation directory
 for eBPF
Thread-Topic: [PATCH AUTOSEL 4.18 052/131] perf build: Fix installation
 directory for eBPF
Thread-Index: AQHUQr1uzKo1cRGYJ0+NxzFPrh0iqQ==
Date:   Sun, 2 Sep 2018 13:04:07 +0000
Message-ID: <20180902064601.183036-52-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0135;6:nTJjdzLbFTvvQAYiLJ4nbJ2WUs3VFdrokKGA54faZgsXBkSsG9uY4U8vDAk2m7nppZ9Q9tRVJtbriKLwtOCHurGN4vwLQpftdRjb5aeah15CYTfwOKUZWNezQdJkM1Wnu8IpKtlRt9mSFXPTfwZEBxvJ26FUI5zsDyIcWBTLLm9SzgNrlzJYz+CcKKqY9MH1D1vm5uenLDmh+zixdK0EA8Bwcl3lSNvlqRY8YlwRmGU6C0LoRRMnBvZv6YAfdtAnuFKaxMQd0EI+QZMav7hqyXeG3lh0v8gyDu1en1FE8pKRN5ZPh+u2lZNi4O7d3JN5G9h9T2L8GAXfD66wjeQ+t8FVM+K8iSO8lYkUKk6/dBV1Vt/nhaX3+ywMs0zT8DCRiR5FqhqVZe5ha6xQN3c43Sml69BBMmiLRqDU1BdMCFHzbv5Y/0ntGnQ4UyXYOEFgdcCOcfOvyIOMdprPVqJGew==;5:J6edDLxuMAM70YydT9hUelxEXy4WpVENgTDDZeo4q7hcbpFIu1hZr5mi+bUEBCYmgYEg8N8y51xoZUEVf1vWqz4GLcTlXXaM6K3aBIr8xh1X/bkHE02VIjTaCcjUxbuhCcdUWCv//UFmc+Twxyqx9PYPy37A72sUzDUw4bfNnDE=;7:v7Xj0F0WxY23p8C8HMy4+uD5iU10z+nao69vYB5vbDHMBGs3IWCs2RRvRd+NWfkuymQtcjPSfBp8XHQhXIK1UMEOixAgS35KM9djuLzmGc/OAdkN2jvjNx5aTiOPkQlM2K3INmpKLUAZ9UMZKx0dL3lpUdYQQdboW1ql3YOYLJH6I5e6vJgPmSE3PDSEXYZq2LUv04HTGb9zFc34KOx9JyVoMYCINXOaVVJk4regxPYWDMgppCxibtmg6QXtjfdP
x-ms-office365-filtering-correlation-id: fbcc1871-fcfa-4d69-a7da-08d610d495d9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0135;
x-ms-traffictypediagnostic: CY4PR21MB0135:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0135A9F26B86DAED66470E12FB0D0@CY4PR21MB0135.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(190383065149520)(42068640409301)(176510541525296)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0135;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0135;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(376002)(346002)(189003)(199004)(478600001)(76176011)(53936002)(6306002)(2616005)(6512007)(966005)(476003)(446003)(11346002)(36756003)(486006)(106356001)(305945005)(6486002)(6436002)(97736004)(102836004)(6506007)(5250100002)(2906002)(14444005)(256004)(72206003)(2501003)(10290500003)(14454004)(86612001)(186003)(26005)(217873002)(99286004)(86362001)(2900100001)(22452003)(81156014)(81166006)(10090500001)(316002)(107886003)(8676002)(105586002)(6116002)(8936002)(25786009)(4326008)(7736002)(5660300001)(6666003)(110136005)(54906003)(1076002)(68736007)(66066001)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0135;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SYOf7KL6nYKmYMujsmZR5CH77JXRFvJ7FIusbv7SA1G0/a/C12rcD8Yo8b01kQjzRrcSkOvZcBFNG94rPD9Oqm0/w+ymiR/TbkGz7RiGEiHBnPffAsahdQSgmSoD9HuBQg3WoAy1CYunOZTZCxkC+gl9aoHzez/I7UHS3U+D+qBbR1DVlKMS5wGdWKVeVjl97inYK/0mJP8HSj/owKanaba29WPHKPKlcmv1HCLiLHV36OQyaBWYkTo4ABAeyxdoinLiHyIo17S7jqI/96xRamPJfFDfPTtDFm+XH02xe51TAltD8neCoI/jNKuBEhMJnx8v3Sfyz7P1kkdnzxuXYS5WF5MAR7rnW5phNWm39V0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbcc1871-fcfa-4d69-a7da-08d610d495d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:07.4550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit 83868bf71d2eb7700b37f1ea188007f0125e4ee4 ]

The perf tool build and install is controlled via a Makefile. The
'install' rule creates directories and copies files. Among them are
header files installed in /usr/lib/include/perf/bpf/.

However all listed examples are installing its header files in

  /usr/lib/<tool-name>/...[/include]/header.h

and not in

  /usr/lib/include/<tool-name>/.../header.h.

Background information:

Building the Fedora 28 glibc RPM on s390x and s390 fails on s390 (gcc
-m31) as gcc is not able to find header-files like stdbool.h.

In the glibc.spec file, you can see that glibc is configured with
"--with-headers". In this case, first -nostdinc is added to the CFLAGS
and then further include paths are added via -isystem.  One of those
paths should contain header files like stdbool.h.

In order to get this path, gcc is invoked with:

- on Fedora 28 (with 4.18 kernel):

  $ gcc -print-file-name=3Dinclude
  /usr/lib/gcc/s390x-redhat-linux/8/include
  $ gcc -m31 -print-file-name=3Dinclude
  /usr/lib/gcc/s390x-redhat-linux/8/../../../../lib/include
  =3D> If perf is installed, this is: /usr/lib/include
  On my machine this directory is only containing the directory "perf".
  If perf is not installed gcc returns: /usr/lib/gcc/s390x-redhat-linux/8/i=
nclude

- on Ubuntu 18.04 (with 4.15 kernel):

  $ gcc  -print-file-name=3Dinclude
  /usr/lib/gcc/s390x-linux-gnu/7/include
  $ gcc -m31 -print-file-name=3Dinclude
  /usr/lib/gcc/s390x-linux-gnu/7/include
  =3D> gcc returns the correct path even if perf is installed.

In each case, the introduction of the subdirectory /usr/lib/include
leads to the regression that one can not build the glibc RPM for s390
anymore as gcc can not find headers like stdbool.h.

To remedy this install bpf.h to /usr/lib/perf/include/bpf/bpf.h

Output before using the command 'perf test -Fv 40':

  echo '...[bpf-program-source]...' | /usr/bin/clang ... \
		   -I/root/lib/include/perf/bpf ...
                               ^^^^^^^^^^^^
...
  [root@p23lp27 perf]# perf test -F 40
  40: BPF filter                                            :
  40.1: Basic BPF filtering                                 : Ok
  40.2: BPF pinning                                         : Ok
  40.3: BPF prologue generation                             : Ok
  40.4: BPF relocation checker                              : Ok
  [root@p23lp27 perf]#

Output after using command 'perf test -Fv 40':

  echo '...[bpf-program-source]...' | /usr/bin/clang ... \
		 -I/root/lib/perf/include/bpf ...
                             ^^^^^^^^^^^^
...
  [root@p23lp27 perf]# perf test -F 40
  40: BPF filter                                            :
  40.1: Basic BPF filtering                                 : Ok
  40.2: BPF pinning                                         : Ok
  40.3: BPF prologue generation                             : Ok
  40.4: BPF relocation checker                              : Ok
  [root@p23lp27 perf]#

Committer testing:

While the above 'perf test -F 40' (or 'perf test bpf') will allow us
to see that the correct path is now added via -I, to actually test this
we better try to use a bpf script that includes files in the changed
directory.

We have the files that now reside in /root/lib/perf/examples/bpf/ to do
just that:

  # tail -8 /root/lib/perf/examples/bpf/5sec.c
  #include <bpf.h>

  int probe(hrtimer_nanosleep, rqtp->tv_sec)(void *ctx, int err, long sec)
  {
	  return sec =3D=3D 5;
  }

  license(GPL);
  # perf trace -e *sleep -e /root/lib/perf/examples/bpf/5sec.c sleep 4
       0.333 (4000.086 ms): sleep/9248 nanosleep(rqtp: 0x7ffc155f3300) =3D =
0
  # perf trace -e *sleep -e /root/lib/perf/examples/bpf/5sec.c sleep 5
       0.287 (         ): sleep/9659 nanosleep(rqtp: 0x7ffeafe38200) ...
       0.290 (         ): perf_bpf_probe:hrtimer_nanosleep:(ffffffff9911efe=
0) tv_sec=3D5
       0.287 (5000.059 ms): sleep/9659  ... [continued]: nanosleep()) =3D 0
  # perf trace -e *sleep -e /root/lib/perf/examples/bpf/5sec.c sleep 6
       0.247 (5999.951 ms): sleep/10068 nanosleep(rqtp: 0x7fff2086d900) =3D=
 0
  # perf trace -e *sleep -e /root/lib/perf/examples/bpf/5sec.c sleep 5.987
       0.293 (         ): sleep/10489 nanosleep(rqtp: 0x7ffdd4fc10e0) ...
       0.296 (         ): perf_bpf_probe:hrtimer_nanosleep:(ffffffff9911efe=
0) tv_sec=3D5
       0.293 (5986.912 ms): sleep/10489  ... [continued]: nanosleep()) =3D =
0
  #

Suggested-by: Stefan Liebler <stli@linux.ibm.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Fixes: 1b16fffa389d ("perf llvm-utils: Add bpf include path to clang comman=
d line")
Link: http://lkml.kernel.org/r/20180731073254.91090-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/Makefile.config | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index f5a3b402589e..67b042738ed7 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -905,8 +905,8 @@ bindir =3D $(abspath $(prefix)/$(bindir_relative))
 mandir =3D share/man
 infodir =3D share/info
 perfexecdir =3D libexec/perf-core
-perf_include_dir =3D lib/include/perf
-perf_examples_dir =3D lib/examples/perf
+perf_include_dir =3D lib/perf/include
+perf_examples_dir =3D lib/perf/examples
 sharedir =3D $(prefix)/share
 template_dir =3D share/perf-core/templates
 STRACE_GROUPS_DIR =3D share/perf-core/strace/groups
--=20
2.17.1

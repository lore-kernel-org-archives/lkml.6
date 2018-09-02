Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CDCC4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45132054F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KUa1r7A6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45132054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbeIBRgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:36:02 -0400
Received: from mail-dm3nam03on0125.outbound.protection.outlook.com ([104.47.41.125]:63162
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729166AbeIBRcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1yoRaDnq6dbigTolB0vaGOtQudaUemlwVsckCC/NeM=;
 b=KUa1r7A6E3s1XMn7ppMZyVZtF2IHAKE0GhJiSGpuoBCT23wh+kBuPqsehrx7Tlo303S/8Vlaxw2aETuDOzONRK6LPVGnMrKNcSruQfhx2beJjuDxmQULiMAS9pkVE4ELFOgG3Zmf3LVCrFAcvr4ncz2DY5qRPC3R/yBP87XjRmA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:16:20 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:16:20 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 12/47] perf tools: Allow overriding MAX_NR_CPUS at
 compile time
Thread-Topic: [PATCH AUTOSEL 4.4 12/47] perf tools: Allow overriding
 MAX_NR_CPUS at compile time
Thread-Index: AQHUQr8RTrRuLpz4Ukqy6wyU/bCxoQ==
Date:   Sun, 2 Sep 2018 13:15:50 +0000
Message-ID: <20180902131533.184092-12-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:14Mag++7fil3nEBK8qq/vpVJKpQ8sl+oBl8/+dkaQVUBF073iQOfy3eb0M3L5n/fHBPcclYfCfIjU00IkSdBRoSNy2II0fSJISkzVsfj0Y2OLInU5yXz/mJlfY7vXil+JpRAEea0H4dkISu/EvfF/d6XVEUf1izehy10OpLp0qCgiRfznWbD98Sc5z5ZV4oZ6mUzg7sa6ApIRalrWwKG8bfh1FAQgcXNYZYhxWVvlhvyseZAVkMlOfzDKlN879ySdED7gT5TYw2Razd5eph01LTa/ukS0EzxKbBxtHZtiy4L6QHmjfux4DQaDKCVAK3B1cdheLnB+r9AiRYxsoY6Y7MLtmd8kUlzZkvEi10AmONM/hWZlA6zHr4wWJnX76KntHFFRksGMj4VzUskTf3kKzo0srgx7CKnv068NtuAIb/M2ClIkgHdwJopyqoV/eRbBBRCR6g8ks4W0ckpgqrwig==;5:BJ/qfcO3zZoZ1symnod7AzYLxk1ZwZmwVUQgQZUrWXn8aECdNevE1S+nuxInxMj90zeaVVaEzeh/paODOiqa7GB0H7a7kFDUGRmFtItUqrTg+CuZ4Oz9Td62bcqMip9vj7n2aoUgGp3ETrkLk53+Z8h186eVmoT+httyc8sPRgk=;7:6k001M6YutA3IiiZG4sWWZiX3IqkyQk6+/5v92in3u8/l3zogqYyJy0TRFPgFOG2SQdO1Xa9CpPFEuLm1EXDt+h3975z4oKsh100/mDogx/5kI2hJNdzgOIRRWlFeszlAquSU4oGlFydfcAdcpm2LO1KuEF/5DGu5d8MFBUKrQdAoZl+kQg1WLvTKGOxGqAvsw+u4bVR5SAIdkX/5uerd8fxMdyaC85OPNlGXyxXzGdlF2533uXO22ik1lpCmX2s
x-ms-office365-filtering-correlation-id: 97c6c000-07a3-4860-6e77-08d610d645fc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB0629C8A3F19B006E2180910FFB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(65623756079841)(42068640409301)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(39860400002)(346002)(376002)(199004)(189003)(8676002)(478600001)(10090500001)(14454004)(966005)(10290500003)(72206003)(476003)(5660300001)(5250100002)(106356001)(110136005)(54906003)(316002)(105586002)(86612001)(102836004)(14444005)(26005)(256004)(6506007)(2616005)(6116002)(217873002)(305945005)(446003)(1076002)(3846002)(2906002)(551934003)(11346002)(97736004)(6346003)(81166006)(81156014)(7736002)(6436002)(66066001)(25786009)(86362001)(575784001)(4326008)(186003)(53936002)(8936002)(6486002)(22452003)(6306002)(6512007)(99286004)(2501003)(36756003)(68736007)(6666003)(2900100001)(486006)(107886003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: rRom2fCzioq633kab+ac7ANPBunVFYyJQV4UtNjimsFlORluYaReGd9f5sOJXjChdQZft8lmBEud8omyYRb4vvXt073yqkhZipJV8HLS1XG5jw9pSkEAAHJZ09ltOKaTlfsI2RxH9RA9iHGnZNg0GN6ETwvJwZT8p3RpT+MHOI1AfuXjDc5pI7b8EZpkIIRARCQcFiu4uJx/+Bia9iCK67JPQOyS7XUKJwVLer4uB0tnCL47JVI03B1NxQX4Tul77DC5bRM4jiwMWNnwVNCitKJAIIPaQqG1BbVJV12rEM9FOgOTmLc1xO2vR7Enw25721HNgVqqE0k9t1ZyfG0rnowtQhm1T1RccuDecJ+qiWs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c6c000-07a3-4860-6e77-08d610d645fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:15:50.8948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

[ Upstream commit 21b8732eb4479b579bda9ee38e62b2c312c2a0e5 ]

After update of kernel, the perf tool doesn't run anymore on my 32MB RAM
powerpc board, but still runs on a 128MB RAM board:

  ~# strace perf
  execve("/usr/sbin/perf", ["perf"], [/* 12 vars */]) =3D -1 ENOMEM (Cannot=
 allocate memory)
  --- SIGSEGV {si_signo=3DSIGSEGV, si_code=3DSI_KERNEL, si_addr=3D0} ---
  +++ killed by SIGSEGV +++
  Segmentation fault

objdump -x shows that .bss section has a huge size of 24Mbytes:

 27 .bss          016baca8  101cebb8  101cebb8  001cd988  2**3

With especially the following objects having quite big size:

  10205f80 l     O .bss	00140000     runtime_cycles_stats
  10345f80 l     O .bss	00140000     runtime_stalled_cycles_front_stats
  10485f80 l     O .bss	00140000     runtime_stalled_cycles_back_stats
  105c5f80 l     O .bss	00140000     runtime_branches_stats
  10705f80 l     O .bss	00140000     runtime_cacherefs_stats
  10845f80 l     O .bss	00140000     runtime_l1_dcache_stats
  10985f80 l     O .bss	00140000     runtime_l1_icache_stats
  10ac5f80 l     O .bss	00140000     runtime_ll_cache_stats
  10c05f80 l     O .bss	00140000     runtime_itlb_cache_stats
  10d45f80 l     O .bss	00140000     runtime_dtlb_cache_stats
  10e85f80 l     O .bss	00140000     runtime_cycles_in_tx_stats
  10fc5f80 l     O .bss	00140000     runtime_transaction_stats
  11105f80 l     O .bss	00140000     runtime_elision_stats
  11245f80 l     O .bss	00140000     runtime_topdown_total_slots
  11385f80 l     O .bss	00140000     runtime_topdown_slots_retired
  114c5f80 l     O .bss	00140000     runtime_topdown_slots_issued
  11605f80 l     O .bss	00140000     runtime_topdown_fetch_bubbles
  11745f80 l     O .bss	00140000     runtime_topdown_recovery_bubbles

This is due to commit 4d255766d28b1 ("perf: Bump max number of cpus
to 1024"), because many tables are sized with MAX_NR_CPUS

This patch gives the opportunity to redefine MAX_NR_CPUS via

  $ make EXTRA_CFLAGS=3D-DMAX_NR_CPUS=3D1

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/20170922112043.8349468C57@po15668-vm-win7.id=
si0.si.c-s.fr
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/perf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 90129accffbe..4341ed267d4e 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -29,7 +29,9 @@ static inline unsigned long long rdclock(void)
 	return ts.tv_sec * 1000000000ULL + ts.tv_nsec;
 }
=20
+#ifndef MAX_NR_CPUS
 #define MAX_NR_CPUS			1024
+#endif
=20
 extern const char *input_name;
 extern bool perf_host, perf_guest;
--=20
2.17.1

Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0541DC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9761820837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="l8PZbfNG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9761820837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbeIBRXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:23:03 -0400
Received: from mail-by2nam03on0090.outbound.protection.outlook.com ([104.47.42.90]:31424
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729107AbeIBRXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vftKhVJ08xqJNPdMn8rB9aNJkqrxhYXbdAe0/4/ih7M=;
 b=l8PZbfNGu09AfGUCKzkjY4bPne3BW6F60TidIqi2P6V8l0CaABH+0l0cTY/z7Do6t14sIiFY1ETWBNSr6hL2bSVXDB/lTA21ZB+sVAM85bPelVTwQEhwNYZstsIKRPYV0TD87ceBHoJoD2nQ4zlwzZ3OFShzzsK3ekQjDBt3SYU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Sun, 2 Sep 2018 13:07:06 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:06 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 29/89] perf tools: Allow overriding MAX_NR_CPUS
 at compile time
Thread-Topic: [PATCH AUTOSEL 4.14 29/89] perf tools: Allow overriding
 MAX_NR_CPUS at compile time
Thread-Index: AQHUQr3LqsvtbZ82UEGkb339Fdym9g==
Date:   Sun, 2 Sep 2018 13:06:43 +0000
Message-ID: <20180902064918.183387-29-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:fZFdJgbh2DXFzXZwf7nCFNdNtS+0fcLzFHd5GSHvUMf4H1oMkzXwi8ashx13qb380jCarYbfClqm5fFgYIDKNHjwKkQ8+5FsIlcCukuyb2o6l6En9yp8QzEcQ7dorsmnV0hG2VkZ/ZBDXWxef0Eh72Mwc4BU2kSEnd9ZPojdyQMRg1PKXoDh/K4lUNIJgoCcklw9uMmJeOwgm9de0lQTHRM06hqIGOiSbbshj75fFELGuvOfjkGtlYzIjsrPaELBnzeQaXB7RJ93m0untPdyk16pYxQAfHGpE2yfve4cwK6VPjr2ucJ83AejyQJdCZ1U2/wkvS9+VTTcPKh7ASy7kcK/jwDERYav5m4VfPRucundnLL4tlKTGbS0lU6o2WeFOeVuzRWWiWnH0+avDzWfzSptf+uZdV2weRQLxhzO8jZ4CRYNwej7NjqVW3KFXLAQdeLYnfGqIoOrFejf7S/7Jw==;5:6vA1AbOWXza3RHFJoyMr+/NK+hsvvkYe+eD6RnWX5hD2vNZHrJJxNWyFKbs1EmUeZPS/DGIZgklLZcQhpgv6SBgxE3XNRnVIyzMXMUW1hBljwqNwkwv/6+wxNEHoyOtI2umRsrSC5sNog4x9DuGSyOhI1f0c7p1qXrGgCTEzk2Y=;7:q9eE0oL6uCJXL172ItVUt2DnkgNzYk43aNNBZZFvghyRK8zXId+ruH3LKXBGJnVCipsTEXwQOAkYxMG69ka/xbCt239JpYR7N46V2rj2CFLZiCLYCU0cT0mnelferjJWJncsgtrGhSTtRbQoTS+3lK1l68JoMCeQpgyK2w3sXaKmJwZ/R87zbqKbAfeJqby3DxxcCZwVylD2fCJx/c+VcAF9Eivka5vXYdo413OUVn8YajnGex9TnwAEQaLbUZf3
x-ms-office365-filtering-correlation-id: 6212bab0-5452-4da4-dee6-08d610d4fbf8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB085651B1F455120C4F930E4DFB0D0@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(65623756079841)(42068640409301)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(39860400002)(366004)(189003)(199004)(53936002)(81166006)(11346002)(81156014)(575784001)(446003)(476003)(4326008)(5660300001)(25786009)(86612001)(8936002)(26005)(6506007)(6486002)(102836004)(2616005)(86362001)(6306002)(8676002)(6512007)(14444005)(6436002)(107886003)(66066001)(256004)(10090500001)(217873002)(14454004)(3846002)(478600001)(1076002)(72206003)(6116002)(99286004)(305945005)(7736002)(22452003)(551934003)(36756003)(76176011)(105586002)(486006)(106356001)(2900100001)(186003)(97736004)(68736007)(6666003)(316002)(966005)(10290500003)(2501003)(110136005)(54906003)(2906002)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3kTGBhUX5ain25mVcRySmlee0dfgibU1aUbdei64DNP7CB21knf47QaOsAycJLQTqgsyE/LGXdrBS7nWafs8Hr8czu2fCYwf9yHCzpRSt4IMH1K8fdolQEX37Cuj50aMm2x8uDT/KQG6cB6+PvRNHRdnBHd+l7fjakfHOL05S52HGk6rSq820NBSjq+994vfGYb8pvoBOCTUCuTJD0HRl15zdOqGY/KCh6g4ZraAusve/TA66aL0VTksTeX/gDwots5Ex4C/P6e7LMaNb7s8yFQGsUU7JvF1cFHUPUajibVAkYqtzoIp4YEvb9gcQzAuYeoRRH5aGmP+0kpzBbOV57yIDrurXs0IpBInmJc6UjQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6212bab0-5452-4da4-dee6-08d610d4fbf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:43.1771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
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
index 55086389fc06..96f62dd7e3ed 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -24,7 +24,9 @@ static inline unsigned long long rdclock(void)
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

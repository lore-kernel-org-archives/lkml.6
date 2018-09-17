Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D3BECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A336214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="i9aYw/5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A336214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730485AbeIQIaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:30:24 -0400
Received: from mail-eopbgr690116.outbound.protection.outlook.com ([40.107.69.116]:54124
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730392AbeIQIaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXrKdNUhD7f/yLaoW6FEglSpY37UFg6LXrUy0CICE2w=;
 b=i9aYw/5Bc2coMxHB2tGYZXOSzhyPRHismpn7tmkBf0lRlGIy4nGprq6TQujrj1CqLkiZJjG6b0abQq4fKPO3PjcDvW6fBn+3esbHXFMCjl9ZZcwsVp1lhQQrNz2wkEJd6bSEaVaR9NeMjaWMKgPjEpASd7Q0ybAvcK/1TD6uJI8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0133.namprd21.prod.outlook.com (10.173.189.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:04:58 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:58 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Kan Liang <kan.liang@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "acme@kernel.org" <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 72/87] perf/x86/intel/lbr: Fix incomplete LBR
 call stack
Thread-Topic: [PATCH AUTOSEL 4.14 72/87] perf/x86/intel/lbr: Fix incomplete
 LBR call stack
Thread-Index: AQHUTjL3Y+utbGXtLUeMgWjo+4Y0Uw==
Date:   Mon, 17 Sep 2018 03:03:10 +0000
Message-ID: <20180917030220.245686-72-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0133;6:eqPppBN0GGyQVuWuDG2i7GxPWRMyEteXYQs/dr+KFqOcrw4nYR+pjUvr9BIJrJNTk/HZ8Nx2LlsFIDqkQaTrBFF3b9E1m8O9v2nndoEXFHeDvfDY3j4f1mx7pBC0OvkJUvaImItRQWaEBp1Jh4Iuk44Sl/tJK3RkUN11HYHaiGfO+ZKNGvhvP7RuNy6H/d1j7IfBhDB4bleTmgjWDKZY4c7VKBxw5rmaTawTSiU8k5KJkomK0gqEMyXf3wcY2DGr96iq49aiZdvG31+GASx4zVm9U7D5r95jBRp3UhnRhrUOectu+ecOpD+aIhOjgpmArQ96O6UNbhazY0xtzSGj/YAJd45xmEOYq8uy2aUG1VaUVTk6kGlQHuKXQoO4X/aE89r6T5PJzYobp8odt7z6czhQhBhyMERZ/oTP3YAVGLRnXkt07M2BSx95f7EIigcBMXB3g70EEiaOJj/Vi/JCEg==;5:AEJ6KNBTiFHTaZb+2T5zrqrdbS2+27rEdXCDDUcMZP5FoJGUIoKlcfs1qL1e3lRJKbGP32vKCeT1XWgxm0xtncP2Qmx2vcipR3tgdI923JCdq8Y2Xb4rMMg840i1jSdgXdTabb4JrRSti6G2VZZBp1vW/Zs8JuLJcUnJuXWielc=;7:BGNc/RhwLXvd/VAMXqw1FsOAAUUxXjCVfy7Q3A/zDFCvvtRdNXk7TpwGwEqqyPfSKgNgt4yoNTjKPkgiafksC5Y9z8P3p+Btc4ueEsPm9yQ1hGJv/Rfos4c9G1Sp7HSp2d8fo+IeS5qzd9//kPD+Qhi0RgMBWe/tSIxTIjfml8Hb/b4Gj5NAJfKo+eQ0ObpOaMEZnXlKCd6De9R6y2NzOliJeQT876+/zYAXKrllKgggMsEHbjk+oOPyLgz2gvSv
x-ms-office365-filtering-correlation-id: ca03552b-26e0-4cf5-84b5-08d61c4a5a3d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0133;
x-ms-traffictypediagnostic: CY4PR21MB0133:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01337A8096C6B6569F0DE75CFB1E0@CY4PR21MB0133.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211936372134217)(228905959029699)(153496737603132)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0133;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0133;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39860400002)(376002)(346002)(189003)(199004)(102836004)(53936002)(8676002)(486006)(476003)(3846002)(6116002)(76176011)(10290500003)(97736004)(217873002)(256004)(5660300001)(107886003)(6506007)(478600001)(110136005)(2501003)(10090500001)(7416002)(14444005)(305945005)(7736002)(446003)(11346002)(36756003)(2906002)(1076002)(22452003)(5250100002)(2616005)(26005)(316002)(106356001)(25786009)(68736007)(86362001)(14454004)(966005)(72206003)(105586002)(99286004)(6486002)(6306002)(6436002)(6512007)(86612001)(6666003)(81166006)(81156014)(186003)(2900100001)(54906003)(8936002)(4326008)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0133;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NrnHdK+O3SvVHn3/m9sT8TZmQ+14SLiG5Z+V4GA4aj+UpBS+5/OQlseyMjbfPFBKrjjOstNO7JfhL4d1U8AO99TUeyOpxbzOIyQ2WvjLMXbywIgh+fEiizUXxZDUnm4BhuamrXCxVtzJHEe3E4HnSHUgs6coXtMycTNQHCO4sqfH9n75Po97bmSAgDuFW+Xeq3ar9b0W0P17G944TDzN1Qlrn562SQcJQDEa+FsDgJ+9Ja0INlkKjHt2glhUHe3t4MpMvkDPy303zfOhEMpv5zi/6umye1NwvItV7sN0M9WCsQVEo7tc65MSBNXTG0fXW4G5v7/ZRXQOZonzaYhdnGRcdgiVrp4Qfje6LwMqmxo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca03552b-26e0-4cf5-84b5-08d61c4a5a3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:10.9465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

[ Upstream commit 0592e57b24e7e05ec1f4c50b9666c013abff7017 ]

LBR has a limited stack size. If a task has a deeper call stack than
LBR's stack size, only the overflowed part is reported. A complete call
stack may not be reconstructed by perf tool.

Current code doesn't access all LBR registers. It only read the ones
below the TOS. The LBR registers above the TOS will be discarded
unconditionally.

When a CALL is captured, the TOS is incremented by 1 , modulo max LBR
stack size. The LBR HW only records the call stack information to the
register which the TOS points to. It will not touch other LBR
registers. So the registers above the TOS probably still store the valid
call stack information for an overflowed call stack, which need to be
reported.

To retrieve complete call stack information, we need to start from TOS,
read all LBR registers until an invalid entry is detected.
0s can be used to detect the invalid entry, because:

 - When a RET is captured, the HW zeros the LBR register which TOS points
   to, then decreases the TOS.
 - The LBR registers are reset to 0 when adding a new LBR event or
   scheduling an existing LBR event.
 - A taken branch at IP 0 is not expected

The context switch code is also modified to save/restore all valid LBR
registers. Furthermore, the LBR registers, which don't have valid call
stack information, need to be reset in restore, because they may be
polluted while swapped out.

Here is a small test program, tchain_deep.
Its call stack is deeper than 32.

 noinline void f33(void)
 {
        int i;

        for (i =3D 0; i < 10000000;) {
                if (i%2)
                        i++;
                else
                        i++;
        }
 }

 noinline void f32(void)
 {
        f33();
 }

 noinline void f31(void)
 {
        f32();
 }

 ... ...

 noinline void f1(void)
 {
        f2();
 }

 int main()
 {
        f1();
 }

Here is the test result on SKX. The max stack size of SKX is 32.

Without the patch:

 $ perf record -e cycles --call-graph lbr -- ./tchain_deep
 $ perf report --stdio
 #
 # Children      Self  Command      Shared Object     Symbol
 # ........  ........  ...........  ................  .................
 #
   100.00%    99.99%  tchain_deep    tchain_deep       [.] f33
            |
             --99.99%--f30
                       f31
                       f32
                       f33

With the patch:

 $ perf record -e cycles --call-graph lbr -- ./tchain_deep
 $ perf report --stdio
 # Children      Self  Command      Shared Object     Symbol
 # ........  ........  ...........  ................  ..................
 #
    99.99%     0.00%  tchain_deep    tchain_deep       [.] f1
            |
            ---f1
               f2
               f3
               f4
               f5
               f6
               f7
               f8
               f9
               f10
               f11
               f12
               f13
               f14
               f15
               f16
               f17
               f18
               f19
               f20
               f21
               f22
               f23
               f24
               f25
               f26
               f27
               f28
               f29
               f30
               f31
               f32
               f33

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: acme@kernel.org
Cc: eranian@google.com
Link: https://lore.kernel.org/lkml/1528213126-4312-1-git-send-email-kan.lia=
ng@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/events/intel/lbr.c  | 32 ++++++++++++++++++++++++++------
 arch/x86/events/perf_event.h |  1 +
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index cf372b90557e..a4170048a30b 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -346,7 +346,7 @@ static void __intel_pmu_lbr_restore(struct x86_perf_tas=
k_context *task_ctx)
=20
 	mask =3D x86_pmu.lbr_nr - 1;
 	tos =3D task_ctx->tos;
-	for (i =3D 0; i < tos; i++) {
+	for (i =3D 0; i < task_ctx->valid_lbrs; i++) {
 		lbr_idx =3D (tos - i) & mask;
 		wrlbr_from(lbr_idx, task_ctx->lbr_from[i]);
 		wrlbr_to  (lbr_idx, task_ctx->lbr_to[i]);
@@ -354,6 +354,15 @@ static void __intel_pmu_lbr_restore(struct x86_perf_ta=
sk_context *task_ctx)
 		if (x86_pmu.intel_cap.lbr_format =3D=3D LBR_FORMAT_INFO)
 			wrmsrl(MSR_LBR_INFO_0 + lbr_idx, task_ctx->lbr_info[i]);
 	}
+
+	for (; i < x86_pmu.lbr_nr; i++) {
+		lbr_idx =3D (tos - i) & mask;
+		wrlbr_from(lbr_idx, 0);
+		wrlbr_to(lbr_idx, 0);
+		if (x86_pmu.intel_cap.lbr_format =3D=3D LBR_FORMAT_INFO)
+			wrmsrl(MSR_LBR_INFO_0 + lbr_idx, 0);
+	}
+
 	wrmsrl(x86_pmu.lbr_tos, tos);
 	task_ctx->lbr_stack_state =3D LBR_NONE;
 }
@@ -361,7 +370,7 @@ static void __intel_pmu_lbr_restore(struct x86_perf_tas=
k_context *task_ctx)
 static void __intel_pmu_lbr_save(struct x86_perf_task_context *task_ctx)
 {
 	unsigned lbr_idx, mask;
-	u64 tos;
+	u64 tos, from;
 	int i;
=20
 	if (task_ctx->lbr_callstack_users =3D=3D 0) {
@@ -371,13 +380,17 @@ static void __intel_pmu_lbr_save(struct x86_perf_task=
_context *task_ctx)
=20
 	mask =3D x86_pmu.lbr_nr - 1;
 	tos =3D intel_pmu_lbr_tos();
-	for (i =3D 0; i < tos; i++) {
+	for (i =3D 0; i < x86_pmu.lbr_nr; i++) {
 		lbr_idx =3D (tos - i) & mask;
-		task_ctx->lbr_from[i] =3D rdlbr_from(lbr_idx);
+		from =3D rdlbr_from(lbr_idx);
+		if (!from)
+			break;
+		task_ctx->lbr_from[i] =3D from;
 		task_ctx->lbr_to[i]   =3D rdlbr_to(lbr_idx);
 		if (x86_pmu.intel_cap.lbr_format =3D=3D LBR_FORMAT_INFO)
 			rdmsrl(MSR_LBR_INFO_0 + lbr_idx, task_ctx->lbr_info[i]);
 	}
+	task_ctx->valid_lbrs =3D i;
 	task_ctx->tos =3D tos;
 	task_ctx->lbr_stack_state =3D LBR_VALID;
 }
@@ -531,7 +544,7 @@ static void intel_pmu_lbr_read_32(struct cpu_hw_events =
*cpuc)
  */
 static void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 {
-	bool need_info =3D false;
+	bool need_info =3D false, call_stack =3D false;
 	unsigned long mask =3D x86_pmu.lbr_nr - 1;
 	int lbr_format =3D x86_pmu.intel_cap.lbr_format;
 	u64 tos =3D intel_pmu_lbr_tos();
@@ -542,7 +555,7 @@ static void intel_pmu_lbr_read_64(struct cpu_hw_events =
*cpuc)
 	if (cpuc->lbr_sel) {
 		need_info =3D !(cpuc->lbr_sel->config & LBR_NO_INFO);
 		if (cpuc->lbr_sel->config & LBR_CALL_STACK)
-			num =3D tos;
+			call_stack =3D true;
 	}
=20
 	for (i =3D 0; i < num; i++) {
@@ -555,6 +568,13 @@ static void intel_pmu_lbr_read_64(struct cpu_hw_events=
 *cpuc)
 		from =3D rdlbr_from(lbr_idx);
 		to   =3D rdlbr_to(lbr_idx);
=20
+		/*
+		 * Read LBR call stack entries
+		 * until invalid entry (0s) is detected.
+		 */
+		if (call_stack && !from)
+			break;
+
 		if (lbr_format =3D=3D LBR_FORMAT_INFO && need_info) {
 			u64 info;
=20
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index dc4728eccfd8..c6698c63c047 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -646,6 +646,7 @@ struct x86_perf_task_context {
 	u64 lbr_to[MAX_LBR_ENTRIES];
 	u64 lbr_info[MAX_LBR_ENTRIES];
 	int tos;
+	int valid_lbrs;
 	int lbr_callstack_users;
 	int lbr_stack_state;
 };
--=20
2.17.1

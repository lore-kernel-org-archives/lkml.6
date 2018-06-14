Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AA5CAC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D7A208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="bern9Wfa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55D7A208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=concurrent-rt.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755252AbeFNTgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 15:36:11 -0400
Received: from mail-eopbgr700119.outbound.protection.outlook.com ([40.107.70.119]:45329
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754691AbeFNTgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 15:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector1-concurrentrt-com02e;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXeeUFIhkXBdsrwgk1MKhtUaakMAGEdPiDttBN5LTW8=;
 b=bern9WfalTRVjxwx3bCmVEeTDP6wfDfAD98d5Nonv10TvTuzdcFwiYxC/nIos2Spkc44RmlIe5l772Glq27cAwqIFFpkO/ind8f1AWMuSUUXx9tJ/8lyycJPoLl9nhx/FnZwkCKPkQQj1X5FSMtIapJQ3NwwMmPI4PpZi+lChRI=
Received: from DM5PR11MB2011.namprd11.prod.outlook.com (10.168.105.151) by
 DM5PR11MB1756.namprd11.prod.outlook.com (10.175.91.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.17; Thu, 14 Jun 2018 19:36:07 +0000
Received: from DM5PR11MB2011.namprd11.prod.outlook.com
 ([fe80::d9fc:b142:3a66:2c34]) by DM5PR11MB2011.namprd11.prod.outlook.com
 ([fe80::d9fc:b142:3a66:2c34%7]) with mapi id 15.20.0863.016; Thu, 14 Jun 2018
 19:36:07 +0000
From:   Siarhei Liakh <Siarhei.Liakh@concurrent-rt.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Borislav Petkov" <bpetkov@suse.de>
Subject: [PATCH] x86: Call fixup_exception() before notify_die() in
 math_error()
Thread-Topic: [PATCH] x86: Call fixup_exception() before notify_die() in
 math_error()
Thread-Index: AQHUBBaUW86w1+9ez0usdUxJuRkw3w==
Date:   Thu, 14 Jun 2018 19:36:07 +0000
Message-ID: <DM5PR11MB201156F1CAB2592B07C79A03B17D0@DM5PR11MB2011.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Siarhei.Liakh@concurrent-rt.com; 
x-originating-ip: [65.190.80.89]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR11MB1756;7:+AAZ4cCTE/Pb9P4gq2Xee9gSNTaM80cAN1SHT3e/zJivrWRwd2y/F86BjGz4/inVjaRWG/BbkiacbSjXmbiERxSKvxnfA6K7rKbMpnLWMIw7mXC6LAlyAHMu2QQbgLBwRHzgQyEHrcavKThHHq/zekV5bcQd5hKajqqaKsYvt+qioXTLRYszrvPWPfbdN2M0J+k16JPfWEHMI27poqV/16WJKijvvJXmYkdcAPlB+2BQspdcn5bOUOv/SIC6FCFB
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 39e6f40c-13e6-4ffe-ef43-08d5d22e1309
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR11MB1756;
x-ms-traffictypediagnostic: DM5PR11MB1756:
x-microsoft-antispam-prvs: <DM5PR11MB17569062BF1237650F6381DAB17D0@DM5PR11MB1756.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM5PR11MB1756;BCL:0;PCL:0;RULEID:;SRVR:DM5PR11MB1756;
x-forefront-prvs: 0703B549E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39840400004)(346002)(39380400002)(366004)(396003)(199004)(189003)(7736002)(74316002)(86362001)(2906002)(110136005)(5250100002)(305945005)(3280700002)(68736007)(478600001)(14454004)(72206003)(102836004)(26005)(54906003)(476003)(6436002)(9686003)(3660700001)(2501003)(7696005)(55016002)(99286004)(81156014)(8676002)(81166006)(8936002)(97736004)(1857600001)(186003)(6506007)(2900100001)(5660300001)(6116002)(3846002)(4326008)(33656002)(53936002)(105586002)(486006)(106356001)(316002)(66066001)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR11MB1756;H:DM5PR11MB2011.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: concurrent-rt.com does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: 21jCbM4l8x92dZtQPGl7LHLFrQrwolUh4uGDjXu7meHVVlhAiIbelRZ+JrDM7zGl8l3kt1lizT/YU6GCIbONjPXxyb4tbEJXHYqpsHulceEhAw7cXTNuK/TlHopTWR9JNJ3PBccldS+pmrjXseZoAMIqIEEdU8JCK4ZbWQ1zhVZHhRe3xJCj99opXUXjlLbx
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e6f40c-13e6-4ffe-ef43-08d5d22e1309
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2018 19:36:07.0798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1756
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fpu__drop() has an explicit fwait which under some conditions can trigger
a fixable FPU exception while in kernel. Thus, we should attempt to fixup
the exception first, and only call notify_die() if the fixup failed just
like in do_general_protection(). The original call sequence incorrectly
triggers KDB entry on debug kernels under particular FPU-intensive
workloads. This issue had been privately observed, fixed, and tested=20
on 4.9.98, while this patch brings the fix to the upstream.

Signed-off-by: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
---

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index a535dd6..68d77a3 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -835,16 +835,18 @@ static void math_error(struct pt_regs *regs, int erro=
r_code, int trapnr)
 	char *str =3D (trapnr =3D=3D X86_TRAP_MF) ? "fpu exception" :
 						"simd exception";
=20
-	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, SIGFPE) =3D=3D NO=
TIFY_STOP)
-		return;
 	cond_local_irq_enable(regs);
=20
 	if (!user_mode(regs)) {
-		if (!fixup_exception(regs, trapnr)) {
-			task->thread.error_code =3D error_code;
-			task->thread.trap_nr =3D trapnr;
+		if (fixup_exception(regs, trapnr))
+			return;
+
+		task->thread.error_code =3D error_code;
+		task->thread.trap_nr =3D trapnr;
+
+		if (notify_die(DIE_TRAP, str, regs, error_code,
+					trapnr, SIGFPE) !=3D NOTIFY_STOP)
 			die(str, regs, error_code);
-		}
 		return;
 	}
 =
